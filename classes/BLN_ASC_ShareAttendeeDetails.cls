/***********************************************************************************************
*   Controller Name : BLN_ASC_ShareAttendeeDetails
*   Date            : 18/11/2015(DD/MM/YY)
*   Author          : Deepthi Kollu
*   Purpose         : This is sharing Attendee Details
**************************************************************************************************/
@RestResource(urlMapping='/BLN_ASC_ShareAttendeeDetails')
global class BLN_ASC_ShareAttendeeDetails{
   Static BLN_Ls_Addlead.leadDetails ldetails = new BLN_Ls_Addlead.leadDetails();
   static BLN_ResponseMsg respMsg=new BLN_ResponseMsg();
   @HttpPost  
    global static BLN_ResponseMsg doPost(){
    
        BLN_Ticket_DAO ticketDao = new BLN_Ticket_DAO(); 
        BLN_Badge_DAO badgeDao = new BLN_Badge_DAO(); 
        RestRequest req = RestContext.request;  
        
        String EventID=req.params.get('Event_Id');
        String TicketID=req.params.get('Ticket_Id');
        String UserID=req.params.get('User_Id');
        String ScanTime=req.params.get('Scan_Time');
        String Status=req.params.get('Status');
        String CompId=req.params.get('Company_Id');
        //String Android_AppName=req.params.get('Android_AppName');
        //String iPhone_AppName=req.params.get('iPhone_AppName');
        String environmentName=req.params.get('environmentName');
        
        String Android_AppName='';
        String iPhone_AppName='';
        
        /*if(environmentName == 'PRO'){
            Android_AppName='EventdexAndroidPush';
            iPhone_AppName='Eventdex';
        }else IF(environmentName == 'QA'){
            Android_AppName='EventdexAndroid';
            iPhone_AppName='Eventdexnew';
        }else if(environmentName == 'DEV'){
            Android_AppName='EventdexAndroidPush';
            iPhone_AppName='Eventdex';
        }else{
            Android_AppName='EventdexAndroidPush';
            iPhone_AppName='Eventdex';
        }*/
        
        BLN_AppMenuItem_DAO ConnectedAppsDAO = new BLN_AppMenuItem_DAO();
        LIST<AppMenuItem> connectedApps=new LIST<AppMenuItem>();
        ConnectedApps = ConnectedAppsDAO.getConnectedAppDetails();
        
        for(AppMenuItem conApp:ConnectedApps){
            if(conApp.MobilePlatform == 'android'){
                Android_AppName =conApp.Label;
            }else if(conApp.MobilePlatform == 'ios'){ 
                iPhone_AppName =conApp.Label;
            }
        }
        
        
        ticket__c ticketcheck = ticketDao.checkTicketEventMapping(EventID,TicketID);
       GN_User__c GNUser = [Select First_Name__c,Last_Name__c,User__c from GN_User__c where id = :UserID];
       if(Status == 'Accept'){
           
           if(null != ticketcheck){
               string badgeId = badgeDao.getBadgeForTicket(TicketID);
               if(badgeId != '' && badgeId != null){
                    BLN_Ls_Addlead AddLead = new BLN_Ls_Addlead();
                    req.params.put('barcodeid',badgeId);
                    req.params.put('loginUserId',UserID);
                    req.params.put('eventId',EventID);
                    req.params.put('luCompId',CompId);
                    req.params.put('sTime',ScanTime); 
                    ldetails =  BLN_Ls_Addlead.doPost();
               }else{
                   BLN_Quick_Registration_BAL quickbal=new BLN_Quick_Registration_BAL();
                   string badgeIDnew=quickbal.generateBadge(ticketcheck.Badge_Label__c,TicketID,''); 
                   if(badgeIDnew != '' && badgeIDnew != null){
                       BLN_Ls_Addlead AddLead = new BLN_Ls_Addlead();
                        req.params.put('barcodeid',badgeIDnew);
                        req.params.put('loginUserId',UserID);
                        req.params.put('eventId',EventID);
                        req.params.put('luCompId',CompId);
                        req.params.put('sTime',ScanTime); 
                        ldetails =  BLN_Ls_Addlead.doPost();
                   }
               }
                
                Messaging.PushNotification msg =new Messaging.PushNotification();
                Map<String, Object> androidPayload = new Map<String, Object>();
                androidPayload.put('message','Hello! '+ GNUser.First_Name__c+' '+GNUser.Last_Name__c+'\n'+ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' accepted you as  a Lead.');
                if(null != ldetails){
                   String lead_deatils = JSON.serialize(ldetails);
                   androidPayload.put('lead_deatils',lead_deatils );
                }
                androidPayload.put('content-available', 1);
                androidPayload.put('Key', 'Attendee_Response');
                androidPayload.put('Status', Status);
                msg.setPayload(androidPayload);
                
                Set<String> users = new Set<String>();
                users.add(GNUser.User__c);
                msg.send(Android_AppName, users);
                
                
                String lead_deatils ='';
                 if(null != ldetails){
                 if(ldetails.msg.validbadge== true){
                     lead_deatils =ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' accepted you as a Lead.';
                 }else{
                     lead_deatils =ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' '+ldetails.msg.message;
                 }
                }
                
                Messaging.PushNotification iphoneMsg =new Messaging.PushNotification();
        
                Map<String, Object> iphonePayload = new Map<String, Object>();
                iphonePayload = BLN_ASC_SendNotification.iphoneGlobalPayloadMethod('Hello! '+ GNUser.First_Name__c+' '+GNUser.Last_Name__c+'\n'+ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' accepted you as  a Lead.','','',string.valueOf(ticketcheck.Id),'','','Attendee_Response',lead_deatils,Status);

                iphoneMsg.setPayload(iphonePayload);
                iphoneMsg.send(iPhone_AppName, users);
                
                 
        
           }else{
               ldetails.msg.ldvalueAssign('Error','Ticket does not belong to this event!',false);
           }
           
           
       }else if(Status == 'Reject'){
           Messaging.PushNotification msg =new Messaging.PushNotification();
           Map<String, Object> androidPayload = new Map<String, Object>();
           androidPayload.put('message','Hello! '+ GNUser.First_Name__c+' '+GNUser.Last_Name__c+'\n'+ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' rejected you as  a Lead.');
           androidPayload.put('content-available', 1);
           androidPayload.put('Key', 'Attendee_Response');
           androidPayload.put('Status', Status);
           msg.setPayload(androidPayload);
           
           Set<String> users = new Set<String>();
           users.add(GNUser.User__c);
           msg.send(Android_AppName, users);

           
           
           Messaging.PushNotification iphoneMsg =new Messaging.PushNotification();

            Map<String, Object> iphonePayload = new Map<String, Object>();
            iphonePayload = BLN_ASC_SendNotification.iphoneGlobalPayloadMethod('Hello! '+ GNUser.First_Name__c+' '+GNUser.Last_Name__c+'\n'+ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' rejected you as  a Lead.','','',string.valueOf(ticketcheck.Id),'','','Attendee_Response',ticketcheck.tkt_profile__r.First_Name__c+' '+ticketcheck.tkt_Profile__r.Last_Name__c+' rejected your lead request',Status);
           
            iphoneMsg.setPayload(iphonePayload);
            iphoneMsg.send(iPhone_AppName, users);
           
           
           
       }
       
        respMsg.ldvalueAssign('Success','Notification Sent!',true);
        return respMsg;
      // return ldetails;  
        
    }

    
}
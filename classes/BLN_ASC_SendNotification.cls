/***********************************************************************************************
*   Controller Name : BLN_ASC_SendNotification
*   Date            : 18/11/2015(DD/MM/YY)
*   Author          : Deepthi Kollu
*   Purpose         : This is for sending notification in Attendee sharing
**************************************************************************************************/
@RestResource(urlMapping='/BLN_ASC_SendNotification')
global class BLN_ASC_SendNotification{
    static BLN_ResponseMsg respMsg=new BLN_ResponseMsg();
   @HttpPost  
    global static BLN_ResponseMsg doPost(){
        BLN_Ticket_DAO ticketDao = new BLN_Ticket_DAO(); 
        RestRequest req = RestContext.request;  
        
        String SenderUserID=req.params.get('User_Id');
        String EventID=req.params.get('Event_Id');
        String TicketID=req.params.get('Ticket_Id');
        String ScanTime=req.params.get('Scan_Time');
        String CompId=req.params.get('Company_Id');
        //String Android_AppName=req.params.get('Android_AppName');
        //String iPhone_AppName=req.params.get('iPhone_AppName');

        String environmentName=req.params.get('environmentName');
        
        String Android_AppName='';
        String iPhone_AppName='';
        
      /*  if(environmentName == 'PRO'){
            Android_AppName='EventdexAndroidPush';
            iPhone_AppName='Eventdex';
        }else if(environmentName == 'QA'){
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
        System.debug('Request ===' + req);
        
        System.debug('Android_AppName ===' + Android_AppName);
        System.debug('iPhone_AppName ====' + iPhone_AppName);
        
        GN_User__c SenderUser = [Select First_Name__c,Last_Name__c,User__c from GN_User__c where id = :SenderUserID];
        Ticket__c ReceiverTic = ticketDao.tcWithTktPid(TicketID);

        
        Messaging.PushNotification msg =new Messaging.PushNotification();
        Map<String, Object> androidPayload = new Map<String, Object>();
        
        androidPayload.put('message','Hello! '+ReceiverTic.tkt_profile__r.First_Name__c+' '+ReceiverTic.tkt_Profile__r.Last_Name__c+'\n'+ SenderUser.First_Name__c+' '+SenderUser.Last_Name__c+' wants to add you as  a Lead.');
        androidPayload.put('SenderUserID', SenderUserID);
        androidPayload.put('EventID', EventID);
        androidPayload.put('TicketID', TicketID);
        androidPayload.put('ScanTime', ScanTime);
        androidPayload.put('CompId', CompId);
        androidPayload.put('content-available', 1);
        androidPayload.put('Key', 'Attendee_Request');
        
        msg.setPayload(androidPayload);
   
        Set<String> users = new Set<String>();
        users.add(ReceiverTic.tkt_profile__r.BLN_GN_User__r.User__c);
        
        msg.send(Android_AppName, users);
        
        
        Messaging.PushNotification iphoneMsg =new Messaging.PushNotification();
        
        Map<String, Object> iphonePayload = new Map<String, Object>();
        iphonePayload = iphoneGlobalPayloadMethod('Hello! '+ReceiverTic.tkt_profile__r.First_Name__c+' '+ReceiverTic.tkt_Profile__r.Last_Name__c+'\n'+ SenderUser.First_Name__c+' '+SenderUser.Last_Name__c+' wants to add you as  a Lead.',SenderUserID,EventID,TicketID,ScanTime,CompId,'Attendee_Request','','');
        
        iphoneMsg.setPayload(iphonePayload);
        iphoneMsg.send(iPhone_AppName, users);
        
        
        respMsg.ldvalueAssign('Success','Notification Sent!',true);
        return respMsg;
        
    }
    
    global static Map<String, Object> iphoneGlobalPayloadMethod(string msg,string senderId,string eveId,string ticId,string stime,string compId,string key,string leaddetail,string status){
        Map<String, Object> androidPayload1 = new Map<String, Object>();
        androidPayload1.put('alert',msg);
        androidPayload1.put('sound','calling.mp3');
        androidPayload1.put('content-available',1);
        androidPayload1.put('badge',1);
        
        Map<String, Object> androidPayload2 = new Map<String, Object>();
        androidPayload2.put('aps',androidPayload1);
        
        if(msg != '' && msg!= null)
        androidPayload2.put('message',msg);
        
        if(senderId != '' && senderId!= null)
        androidPayload2.put('SenderUserID', senderId);
        
        if(eveId != '' && eveId!= null)
        androidPayload2.put('EventID', eveId);
        
        if(ticId != '' && ticId!= null)
        androidPayload2.put('TicketID', ticId);
        
        if(stime != '' && stime!= null)
        androidPayload2.put('ScanTime', stime);
        
        if(compid != '' && compid!= null)
        androidPayload2.put('CompId', compid);
        
        if(key != '' && key!= null)
        androidPayload2.put('Key', key);

        if(leaddetail != '' && leaddetail!= null)
        androidPayload2.put('lead_deatils',leaddetail);
        
        if(status != '' && status!= null)
        androidPayload2.put('Status', status);
        
        return androidPayload2;
    }
}
global class BLN_PushNotificationSc implements Schedulable{
   global string message{get;set;}
   global set<string> users{get;set;}
   global id campId{get;set;}
   global string ecName{get;set;}
    global BLN_PushNotificationSc(set<string> users1,string message1,id campId1,string ecName1){
        message=message1;
        users=users1;
        campId=campId1;
        ecName=ecName1;
    }
 
    global void execute(SchedulableContext SC) {
         BLN_AppMenuItem_DAO ConnectedAppsDAO = new BLN_AppMenuItem_DAO();
            LIST<AppMenuItem> connectedApps=new LIST<AppMenuItem>();
            ConnectedApps = ConnectedAppsDAO.getConnectedAppDetails();
            
            for(AppMenuItem conApp:ConnectedApps){
                if(conApp.MobilePlatform == 'android'){
                    Messaging.PushNotification msg =new Messaging.PushNotification();
                    Map<String, Object> androidPayload = new Map<String, Object>();
                    androidPayload.put('message',message);
                    androidPayload.put('content-available', 1);
                    androidPayload.put('Key', 'Attendee_Request');
                    msg.setPayload(androidPayload);
                    msg.send(conApp.Label, users);
                }else if(conApp.MobilePlatform == 'ios'){    
                    Messaging.PushNotification iphoneMsg =new Messaging.PushNotification();
                    Map<String, Object> iphonePayload = new Map<String, Object>();
                                
                    iphonePayload.put('alert',message);
                    iphonePayload.put('sound','calling.mp3');
                    iphonePayload.put('content-available',1);
                    iphonePayload.put('badge',1);
                    
                    Map<String, Object> iphonePayload2 = new Map<String, Object>();
                    iphonePayload2.put('aps',iphonePayload);

                    iphonePayload2.put('message',message);
                    
                    iphonePayload2.put('Key', 'FROM PORTAL');
                    
                    iphonePayload2.put('NotificationId',campId);
                    iphonePayload2.put('TicketID',campId);
                    iphonePayload2.put('title',ecName);
                    //Messaging.PushNotificationPayload.apple(pnMsg,'calling.mp3', null, null);
                    iphoneMsg.setPayload(iphonePayload2);
                    iphoneMsg.send(conApp.Label, users);
                }
            }
        
        EmailCampaign__c ec=new EmailCampaign__c();
        ec=[SELECT Email_Status__c from EmailCampaign__c where id =:campId];
        ec.Email_Status__c = 'Sent';
        update ec;
    } 
}
global class batchEmailsSending implements Database.Batchable<sObject> {
  
   global string SelectEvent {get;set;}
   global string url{get;set;}
   global string sessionId {get;set;}
   
   
   global List<User_Profile_Event__c> start(Database.BatchableContext BC){
       
       return [SELECT (select id from EventSchedule__r),EV_id__r.EV_HostingZipcode__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HistingAddr1__c,EV_id__r.EV_Title__c ,EV_id__r.EV_StartDate__c,id,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_Email__c FROM User_Profile_Event__c where EV_id__c =:SelectEvent AND MAtchMakingProfile__c ='Corporate'];
    }
  
    global void execute(Database.BatchableContext BC, List<User_Profile_Event__c> scope){
       List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
       
         for(User_Profile_Event__c up : scope){  
             System.debug('BBBBBBBBBBBatch    '+up);
             System.debug('CCCCCCCCCCCCCC  '+up.EventSchedule__r); 
             if(up.EventSchedule__r.size()>0){
                // Getting attachments  
                PageReference pdfPage = new PageReference(url+'/MatchMaking/mm_eventadmin_printscheduleMass');
                 System.debug('UUUUUUUUUUUUUuu '+url+'/mm_eventadmin_printscheduleMass');
                pdfPage.getParameters().put('id',up.id);
                
                Blob pdf;
                try{
               pdf = pdfPage.getContentAsPdf(); //!Test.isRunningTest() ? pdfPage.getContentAsPdf() : Blob.ValueOf('dummy text');
               }catch(exception e){
               pdf =blob.valueof('123');}
                 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                  LIST<String> toAddresses = new LIST<String>();  
                   toAddresses.add(up.Attendee_Summary__r.AS_Email__c);
                   email.setSubject('Your Schedules for Registered Event!');
                   email.setToAddresses(toAddresses);
                   //Attachments  start 
                     Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                     efa.setContentType('application/pdf');
                     efa.setFileName('Schedule.pdf');
                     efa.setBody(pdf);
                     email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                   //Attachments  End
                   
                   Event__c eventtimedetails= new Event__c();
                   
                   String hostLocation;
            String hostadd1;
            String hostCity;
            String hostState;
            String hostZipCode;
            String commaSymb;

            hostLocation=(up.EV_id__r.EV_HostingLocation__c!=Null) ? up.EV_id__r.EV_HostingLocation__c : '';
            hostadd1=(up.EV_id__r.EV_HistingAddr1__c!=Null) ? up.EV_id__r.EV_HistingAddr1__c : '';
            hostCity=(up.EV_id__r.AS_HostingCity__c!=Null) ? up.EV_id__r.AS_HostingCity__c : '';
            hostState=(up.EV_id__r.EV_HostingState__c!=Null) ? up.EV_id__r.EV_HostingState__c : '';
            hostZipCode=(up.EV_id__r.EV_HostingZipcode__c!=Null) ? up.EV_id__r.EV_HostingZipcode__c : '';
            commaSymb=(up.EV_id__r.AS_HostingCity__c!=Null) ? ',' : '';
                   
                   
                   email.setHTMLBody( 'Hello ' + ' ' + up.Attendee_Summary__r.AS_FirstName__c +',' + '<br/>' + '' + '<br/>' +
                 'Thank you for participating in the matchmaking.' + '<br/>' +'' + '<br/>' + '<br/>' +
                 'Attached is your one on one matchmaking schedule for the following event:' + '<br/>' +'<br/>' +
                 +'<b>'+ up.EV_id__r.EV_StartDate__c.format() +'<br/>'+  up.EV_id__r.EV_Title__c  +'</b>'+ '<br/>' +
                 hostLocation + '<br/>' +
                  hostadd1+ '<br/>' +
                  hostCity+commaSymb+hostState+' '+hostZipCode+ '<br/>' +'<br/>'+
                 'Please come on time and be prepared with either a capability statement or a brochure to let'+ '<br/>' +
                 'your potential customers know about your products, and services.'+ '<br/>'+ '<br/>'+
                 'If you have any further questions, please contact your event administrator.'+ '<br/>'+'<br/>'+'<br/>'+
                 'Best Wishes!'+'<br/>'+
                 'Booth Leads customer support'+'<br/>'+
                 +'<a>'+'support@boothleads.com.'+'</a>'+'<br/>'+
                 'Phone: 1-(800)-492-1289.');
                   email.setFileAttachments(new Messaging.EmailFileAttachment[] { efa });
                   System.debug('PPPPPPPPPPPPP '+up.Attendee_Summary__r.AS_FirstName__c);
                   Emailslist.add(email); 
         }  else{
         
                 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                  LIST<String> toAddresses = new LIST<String>();  
                   toAddresses.add(up.Attendee_Summary__r.AS_Email__c);
                   string sub = 'Your schedule for the event:'+' '+up.EV_id__r.EV_Title__c;
                   email.setSubject(sub);
                   email.setToAddresses(toAddresses);
                   email.setHTMLBody('Dear'+' '+ up.Attendee_Summary__r.AS_FirstName__c+','+'<br/>'+'<br/>'+
                  +'Thank you for your registering to participate in the'+' '+
                   
                    up.EV_id__r.EV_Title__c+'.' +' '+'Unfortunately, your company was not selected for a 1:1'+ '<br/>'+ 'MatchMaker Meeting; however, we hope you will take advantage of the many other networking opportunities taking place during the event.');
                   Emailslist.add(email); 
         
         }
            
      } 
      if(EmailsList.size()>0){   
          List<Messaging.SendEmailResult> results = Messaging.sendEmail(EmailsList); 
       }
    }
    
     global void finish(Database.BatchableContext BC){     
            
    }   

}
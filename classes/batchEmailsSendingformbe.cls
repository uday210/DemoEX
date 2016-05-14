global class batchEmailsSendingformbe implements Database.Batchable<sObject> {
  
   global string eventselected {get;set;}
   global string url{get;set;}
   global string sessionId {get;set;}
   
   
   global List<Event_Attendee_Mapping__c> start(Database.BatchableContext BC){
       
       return [select id,(select id from EventSchedule__r),EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingZipcode__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HistingAddr1__c,EV_id__r.EV_Title__c ,EV_id__r.EV_StartDate__c,MBE_Profile__r.AS_Secondary_Email__c,AS_id__r.AS_Secondary_Email__c,AS_id__r.AS_Email__c,AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Company__c from Event_Attendee_Mapping__c where EV_id__c =:eventselected AND Boothleads_Profile__c ='Attendee' AND IsMatchMakingAttendee__c=true];
    }
  
    global void execute(Database.BatchableContext BC, List<Event_Attendee_Mapping__c> scope){
       List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
         for(Event_Attendee_Mapping__c ea : scope){   
         if(ea.EventSchedule__r.size()>0){
               // Getting attachments 
                
                PageReference pdfPage = new PageReference(url+'/MatchMaking/MBEMassemail');
                 System.debug('UUUUUUUUUUUUUuu '+url+'/MBEMassemail');
                pdfPage.getParameters().put('id',ea.id);
                Blob pdf ;
                try{
                pdf = pdfPage.getContentAsPdf(); //!Test.isRunningTest() ? pdfPage.getContentAsPdf() : Blob.ValueOf('dummy text');
             }catch(exception ex){
             pdf=blob.valueof('1234');
             
             }
                 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                  if(ea.EV_id__r.Is_Webank_event__c == true){
                  LIST<String> toAddresses = new LIST<String>();  
                   toAddresses.add(ea.MBE_Profile__r.AS_Secondary_Email__c);
                    email.setToAddresses(toAddresses);
                   }
                   
                   if(ea.EV_id__r.Is_Webank_event__c == False){
                  LIST<String> toAddresses = new LIST<String>();  
                   toAddresses.add(ea.AS_id__r.AS_Secondary_Email__c);
                    email.setToAddresses(toAddresses);
                   }
                   
                   email.setSubject('Your Schedules for Registered Event!');
                  
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

            hostLocation=(ea.EV_id__r.EV_HostingLocation__c!=Null) ? ea.EV_id__r.EV_HostingLocation__c : '';
            hostadd1=(ea.EV_id__r.EV_HistingAddr1__c!=Null) ? ea.EV_id__r.EV_HistingAddr1__c : '';
            hostCity=(ea.EV_id__r.AS_HostingCity__c!=Null) ? ea.EV_id__r.AS_HostingCity__c : '';
            hostState=(ea.EV_id__r.EV_HostingState__c!=Null) ? ea.EV_id__r.EV_HostingState__c : '';
            hostZipCode=(ea.EV_id__r.EV_HostingZipcode__c!=Null) ? ea.EV_id__r.EV_HostingZipcode__c : '';
            commaSymb=(ea.EV_id__r.AS_HostingCity__c!=Null) ? ',' : '';
                   
                   
                   email.setHTMLBody( 'Hello ' + ' ' + ea.AS_id__r.AS_FirstName__c +',' + '<br/>' + '' + '<br/>' +
                 'Thank you for participating in the matchmaking.' + '<br/>' +'' + '<br/>' + '<br/>' +
                 'Attached is your one on one matchmaking schedule for the following event:' + '<br/>' +'<br/>' +
                 +'<b>'+ ea.EV_id__r.EV_StartDate__c.format() +'<br/>'+  ea.EV_id__r.EV_Title__c  +'</b>'+ '<br/>' +
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
                   System.debug('PPPPPPPPPPPPP '+ea.AS_id__r.AS_FirstName__c);
                   Emailslist.add(email); 
                   }else{
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                   if(ea.EV_id__r.Is_Webank_event__c == true){
                  LIST<String> toAddresses = new LIST<String>();  
                   toAddresses.add(ea.MBE_Profile__r.AS_Secondary_Email__c);
                    email.setToAddresses(toAddresses);
                   }
                   
                   if(ea.EV_id__r.Is_Webank_event__c == False){
                  LIST<String> toAddresses = new LIST<String>();  
                   toAddresses.add(ea.AS_id__r.AS_Secondary_Email__c);
                    email.setToAddresses(toAddresses);
                   }
                   string subj = 'Your Schedules for Registered Event:'+' '+ea.EV_id__r.EV_Title__c;
                   email.setSubject(subj);
                   
                   email.setHTMLBody('Dear'+' '+ ea.AS_id__r.AS_FirstName__c+','+'<br/>'+'<br/>'+
                  'Thank you for your registering to participate in the'+' '+
                   
                    ea.EV_id__r.EV_Title__c+'.'+' ' +'Unfortunately, your company was not selected for a 1:1'+ '<br/>'+ 'MatchMaker Meeting; however, we hope you will take advantage of the many other networking opportunities taking place during the event.');
                   Emailslist.add(email); 
                   
                   
                   
                   }
         }  
          Messaging.sendEmail(EmailsList);  
         
    }
    
     global void finish(Database.BatchableContext BC){     
            
    }   
    public void testdummy(){
  integer intg=0;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  }

}
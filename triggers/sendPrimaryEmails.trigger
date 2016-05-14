trigger sendPrimaryEmails on Constomer__c (after update) {

 SET<id> ids = new SET<id>();
 for(Constomer__c con:trigger.old){
   system.debug('HHHHHHHHHHHHHHHHHHHHHHHH '+con.id);
   ids.add(con.id);
 }
 
     Commanforstates  con = new Commanforstates ();
     List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
     
       List<Dummay__c> dums = new List<Dummay__c>([SELECT Event__r.EV_EventLogo__c,Company__c,DiscountValue__c,Promocode__c,Ticket_Amount__c,Event__r.EV_HostingOrgName__c,customer_key__r.Name,ID, Event__r.owner.Email,Event__r.owner.Name,Event__r.owner.userName,NAME, Last_Name__c, First_Name__c,Email__c,TicketAmount__c,  Event__r.AS_HostingAddr2__c, Event__r.EV_HistingAddr1__c,Event__r.EV_HostingZipcode__c,Event__r.EV_HostingStateNew__c,Event__r.AS_HostingCity__c,Event__r.EV_HostingLocation__c,Event__c,Event__r.EV_Title__c,Event__r.EV_StartDate__c,
           Event__r.StartTime__c,Event__r.EV_EndDate__c,Event__r.EV_EndTime__c,CreatedDate, TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c,TicketTypes__r.Type__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c ,Event__r.TwitterId__c,Event__r.FacebookId__c,Event__r.OrganizerId__c FROM Dummay__c WHERE customer_key__c in :ids and Event__r.id='a00F000000EXmXc']);
       
       system.debug('222222222222222 '+dums.size());
       
        
        for(Dummay__c d:dums ){
        system.debug('333333333333333333333 '+d);
          if(d.Event__r.id=='a00F000000EXmXc' ){
             
              string questionpeople;
              string partiattendPeople;
           
              OrgWideEmailAddress Org = new OrgWideEmailAddress();
        
             try{
             
                if(d.Event__r.OrganizerId__c!=null){
                   Org = [select id from OrgWideEmailAddress WHERE address=:d.Event__r.OrganizerId__c];
                     system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'+Org );
                 }else{
                    
                    Org = [select id from OrgWideEmailAddress WHERE address='support@boothleads.com'];
                    system.debug('EEEEEEEEEEEEEEE '+Org );
                   }
             
               }catch(Exception e){}
               
              
               d.Event__r.EV_HostingStateNew__c=  con.mapstate(d.Event__r.EV_HostingStateNew__c);
              system.debug('ttttttttttttttttttttttt' );
             
               Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
               //email.setSubject('Schedule Your Prime Contractor Appointments');
               if( Org != null){  
               email.setOrgWideEmailAddressId(Org.id);
               
              }
             
               LIST<String> ccAddresses = new LIST<String>();  
              // ccAddresses.add(d.Event__r.OrganizerId__c);
             // ccAddresses.add('phani@globalnest.com');
                ccAddresses.add(d.Email__c);
              system.debug('444444444444444444444444 '+ccAddresses);
              email.setToAddresses(ccAddresses);
              
               EmailTemplate E = new EmailTemplate();
              
                try{
                 if(d.TicketTypes__r.Type__c == 'Match Leads Buyer'){
                   E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = :'Primecontractors template'];
                   }else if(d.TicketTypes__r.Type__c == 'Match Leads Seller'){
                   E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = :'small business Template'];
                   }else{
                    E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Email to user After Registration'];
                   }  
                   }catch(exception fr){   
                    
                 }
              email.setSubject(E.Subject);
              String ReplaceContactName = E.HtmlValue;
              String replacedname;
              
              
              try{
              replacedname = ReplaceContactName.Replace('{!userName}',d.First_Name__c +' '+d.Last_Name__c);
              replacedname = replacedname.Replace('{!userEmail}',d.Email__c);
              }catch(exception ed){
                  replacedname = ReplaceContactName.Replace('{!userName}','' +' '+'');
              }
              
             system.debug('555555555555555555555555555555 '+replacedname );
             email.setHtmlBody(replacedname);            
              EmailsList.add(email); 
             system.debug('666666666666666666 '+EmailsList.size());
           
              
          
         }  
     
     }
  Messaging.sendEmail(EmailsList);

}
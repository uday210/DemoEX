public without sharing class testEmailSendingCon {

    
    public pageReference PDF{get;set;}
    public Constomer__c custmer{get; set;}
    public LIST<Dummay__c> dummyTypes{get; set;}
    public LIST<Dummay__c> dummyTypesLIST{get; set;}
    
    public TicketTypes__c tt{get; set;} 
    
    public PageReference sendEmail(){ 
        sendEmail('a0TZ00000013w2IMAQ');
    return  null; }
    
    public void  sendEmail(ID custmerId) {
    
    
    custmer = new Constomer__c();
    dummyTypes = new LIST<Dummay__c>();
    dummyTypesLIST =  new LIST<Dummay__c>();
    boolean sendemailbool=True;  
         
       //  ID custmerId = apexpages.currentpage().getparameters().get('id');
         
         custmer = [SELECT ID,  NAME,Email__c,Uniq_Number__c, Isinserted__c,Total_Amount__c, Is_Invoice_mail_Send__c FROM Constomer__c WHERE ID =:custmerId ];
       
         dummyTypes = [SELECT ID, NAME, Last_Name__c, First_Name__c,Event__c, TicketTypes__r.TT_Name__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c FROM Dummay__c WHERE customer_key__c =: custmerId AND Email__c =: custmer.Email__c  LIMIT 1 ];
        
        dummyTypesLIST =[SELECT ID, NAME, Last_Name__c, First_Name__c,  Event__c, TicketTypes__r.TT_Name__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c FROM Dummay__c WHERE customer_key__c =: custmerId ];
        
        OrgWideEmailAddress Org;
        
     try{
        Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Jerilynn Clarke'];
       
       }catch(Exception e){}
       
       
       Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         email.setSubject('Order confirmation for 2013 GNEMSDC Business Opportunity Conference & Expo');
     
     if( Org != null)  
         email.setOrgWideEmailAddressId(Org.id);
     
     // String[]  toAddresses = new String[]; 
        LIST<String> toAddresses = new LIST<String>();
       if( custmer.Email__c != null){
            toAddresses.add(custmer.Email__c);
        }
        String FirstName;
        String LsatName;
        string eventId;
        String paymentMode='';
        if(!dummyTypes.isEmpty()){
            FirstName = dummyTypes[0].First_Name__c;
            LsatName = dummyTypes[0].Last_Name__c; 
            eventId =dummyTypes[0].Event__c;
            paymentMode =  dummyTypes[0].Payment_Type__c; 
        }
     email.setToAddresses(toAddresses);
     
     
     system.debug(' ------ **************** ------'+email);
     
     
     
    String emailBody='<tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; padding-left:35px;"> <ul style="list-style:disc;">';
   
    boolean isBoothatExpo=false;
    
     for(Dummay__c d : dummyTypesLIST ){
         
          if(d.TicketTypes__r.Section_Name__c =='SPONSORSHIP PACKAGES' || d.TicketTypes__r.Section_Name__c =='ANNUAl SPONSORSHIP PACKAGES' || d.TicketTypes__r.Section_Name__c =='ACTIVITY SPONSORSHIP PACKAGES' ){
           
         sendemailbool =false;
         }
         
         emailBody += '<li>'+  d.First_Name__c +' '+d.Last_Name__c + '</li>' ;
         
         if(d.TicketTypes__r.TT_Name__c =='Booth at Expo'){
         isBoothatExpo =true;
         }
         
     }
       string attachmentMAtter='';
  
     if(isBoothatExpo){
      List<Attachment> a = new List<Attachment>();
       a =[select id,body from attachment where parentId=:eventId ];
       system.debug('44444444444444444444 '+a);
       
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
  //  attach.setContentType('application/pdf');
     attach.setFileName('advance shipping GREATER NEW ENGLAND.pdf');
     attach.Body = a[0].body;
     email.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
     attachmentMAtter='<b>Please review the attachment for shipment instructions, furnishings and services for your booth.<b>';
   }
     
     
      emailBody += '</ul></td> </tr>';
     
     String no1 = '<body> <table width="98%" border="0" cellspacing="0" cellpadding="0" style="text-align:left; line-height:25px;"> <tr> <td width="74%" style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"> Dear '+ '&nbsp;';
     String no2 = Firstname +'&nbsp;'+  LsatName;
     String no3 = ', </td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Your order for <font style="color:#006ea1">2013 GNEMSDC Business Opportunity Conference &amp; Expo</font> is complete.</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;"></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;font-weight:bold;">Registered Names:</td> </tr>' ; 
     String no4 =  emailBody;
     String no5 =  '<tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"> <b> Amount Paid:</b> $ ' + custmer.Total_Amount__c ;
     String no6 =  '</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"><b>Payment Method:</b> '+ paymentMode  ;
     String no7 =  '</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;"></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; font-weight:bold;">Event Details:</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Tuesday, Sept 24, 2013 at 7:30 AM</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">to <span data-term="goog_1547834660" tabindex="0">Wednesday Sept 25, 6:00 PM (EDT)</span></td> </tr><tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;">&nbsp;</td> </tr> <tr> <td style=" height:10px;"></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">2013 GNEMSDC Business Opportunity</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Conference &amp; Expo  Tickets </td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; font-weight:bold;">Connecticut Convention Center</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">100 Columbus Blvd</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Hartford, CT 06103<br/></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;">&nbsp;</td> </tr><tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Please visit <a href="http://www.boothleads.com/" target="_blank">http://www.boothleads.com</a> to download the mobile app for scanning leads at the event.</td> </tr> <tr><td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"><br />'+attachmentMAtter+'</td></tr><tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"><br/>If you have any questions, please contact the Event Administrator: <a href="mailto:jclarke@gnemsdc.org" target="_blank">jclarke@gnemsdc.org</a></td> </tr> <tr> <td style="height:10px;">&nbsp;</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Thank  you,<br /> Jerilynn Clarke<br />  Greater New England MSDC<br /> Phone: <a href="tel:203-288-9744" value="+912032889744" target="_blank">203-288-9744</a><br /> Email: <a href="mailto:jclarke@gnemsdc.org" target="_blank">jclarke@gnemsdc.org</a></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;"></td> </tr>  </table> </body>';
      
     String finalEmailBody =no1 + no2 + no3 +no4 +no5 +no6 + no7;
     
     email.setHTMLBody( finalEmailBody );
      
    system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEmail Template'+finalEmailBody  );
                                                                                               
     
    if(sendemailbool ){
     Messaging.SendEmailResult[]  r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
  }
  
 }
    
   
    //----------------------------------------------------------------------------------------------------
    public Messaging.SingleEmailMessage EventTypeTickets(String body, String toMailId,Dummay__c dd) {
    
    system.debug('222222222 '+toMailId);
       system.debug('222222222 333333333 '+dd);
    custmer = new Constomer__c();
      dummyTypesLIST =  new LIST<Dummay__c>();
      dummyTypesLIST.add(dd);
         
         
        OrgWideEmailAddress Org;
        
     try{
        Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Jerilynn Clarke'];
       
       }catch(Exception e){}
       
       
       Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         email.setSubject('Order confirmation for 2013 GNEMSDC Business Opportunity Conference & Expo');
     
     if( Org != null)  
         email.setOrgWideEmailAddressId(Org.id);
     
     // String[]  toAddresses = new String[]; 
        LIST<String> toAddresses = new LIST<String>();
       if( toMailId != null){
            toAddresses.add(toMailId);
        }
        String FirstName;
        String LsatName;
        
      
            FirstName = dd.First_Name__c;
            LsatName = dd.Last_Name__c; 
            
      
     email.setToAddresses(toAddresses);
     
     
     
    String emailBody='<tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; padding-left:35px;"> <ul style="list-style:disc;">';
    
    
     for(Dummay__c d : dummyTypesLIST ){
         
         emailBody += '<li>'+  d.First_Name__c +' '+d.Last_Name__c + '</li>' ;
     }
     
      emailBody += '</ul></td> </tr>';
     
     String no1 = '<body> <table width="98%" border="0" cellspacing="0" cellpadding="0" style="text-align:left; line-height:25px;"> <tr> <td width="74%" style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"> Dear '+ '&nbsp;';
     String no2 = Firstname +'&nbsp;'+  LsatName;
     String no3 = ', </td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Your order for <font style="color:#006ea1">2013 GNEMSDC Business Opportunity Conference &amp; Expo</font> is complete.</td> </tr> ' ; 
     String no4 =  body;
    // String no5 =  '<tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"> <b> Amount Paid:</b> $ ' + custmer.Total_Amount__c ;
    // String no6 =  '</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"><b>Payment Method:</b> '+ paymentMode  ;
     String no5 =  '</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;"></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; font-weight:bold;">Event Details:</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Tuesday, Sept 24, 2013 at 7:30 AM</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">to <span data-term="goog_1547834660" tabindex="0">Wednesday Sept 25, 6:00 PM (EDT)</span></td> </tr><tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;">&nbsp;</td> </tr> <tr> <td style=" height:10px;"></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">2013 GNEMSDC Business Opportunity</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Conference &amp; Expo  Tickets </td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; font-weight:bold;">Connecticut Convention Center</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">100 Columbus Blvd</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Hartford, CT 06103<br/></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;">&nbsp;</td> </tr><tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Please visit <a href="http://www.boothleads.com/" target="_blank">http://www.boothleads.com</a> to download the mobile app for scanning leads at the event.</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;"><br/>If you have any questions, please contact the Event Administrator: <a href="mailto:jclarke@gnemsdc.org" target="_blank">jclarke@gnemsdc.org</a></td> </tr> <tr> <td style="height:10px;">&nbsp;</td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left;">Thank  you,<br /> Jerilynn Clarke<br />  Greater New England MSDC<br /> Phone: <a href="tel:203-288-9744" value="+912032889744" target="_blank">203-288-9744</a><br /> Email: <a href="mailto:jclarke@gnemsdc.org" target="_blank">jclarke@gnemsdc.org</a></td> </tr> <tr> <td style="font-family:Verdana, Geneva, sans-serif; font-size:13px; text-align:left; height:10px;"></td> </tr>  </table> </body>';
      
     String finalEmailBody =no1 + no2 + no3 +no4 + no5;
     
     email.setHTMLBody( finalEmailBody );
      
    system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEmail 2222222222222222222222222'+finalEmailBody  );
                                                                                               
      
       
       
       return email;
        
    
         
    }
    
    public void sendEmail(MAP<string,id> link){
    
    MAP<string,id> linkvalues = new MAP<string,id>();
    linkvalues =link;
      LIST<String> toAddresses = new LIST<String>();
      
      MAP<ID, Dummay__c> dummyValues= new MAP<ID, dummay__c>([SELECT ID, TicketTypes__r.Section_Name__c ,NAME,Email__c,TicketTypes__r.TT_Name__c, Attendees_Available__c,Booth_admins_available__c,First_Name__c,Last_Name__c FROM Dummay__c WHERE ID IN: link.Values() ]);
      
      
      
        LIST<Messaging.SingleEmailMessage> eventTypeTicketsLIST = new LIST<Messaging.SingleEmailMessage>();
        
      
      
       for(Dummay__c f: dummyValues.Values()){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // if(dummyValues.get(f.Id) != null){
             if(f.Email__c != null){
             system.debug('uuuuuuuuuuuu '+f.id);
             String EmailBody='';
                // String EmailBody = 'As a '+ f.TicketTypes__r.TT_Name__c +' '+f.TicketTypes__r.Section_Name__c +' member, You can now add '+ f.Attendees_Available__c +' more attendees for free by clicking on the below link <br/>';
                //EmailBody += '<a href="https://boothleads.secure.force.com/BL_addattendees?id='+f.id+'"> click Here </a>';
      
                  email = EventTypeTickets(emailBody,  f.Email__c, f);
              }
       //  } 
       
           eventTypeTicketsLIST.add(email);
       
      }
      
       //    Messaging.SendEmailResult[]  r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {eventTypeTickets});
           Messaging.SendEmailResult[]  r = Messaging.sendEmail(eventTypeTicketsLIST, FALSE);
           
           
           system.debug('FFFFFFFFFFFFFFFFFFFFFFinal      '+ r);
           
           
           
      
    }
     
    
    }
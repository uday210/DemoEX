global without sharing class ReadAndPopulateDataBatchSC implements Database.batchable<String>, Database.Stateful
{
  LIST<String> parsedCSV;
   string SelectedEventId;
   LIST<SA_ImportAttendeesController.innclas> inn;
   MAP<String,String> DBField;
   
   private static final Integer SCOPE_SIZE = 100;
    public ReadAndPopulateDataBatchSC (LIST<String> parsedCSV,string SelectedEventId,LIST<SA_ImportAttendeesController.innclas> inn,MAP<String,String> DBField){
    this.parsedCSV=parsedCSV;
    this.SelectedEventId=SelectedEventId;
    this.inn=inn;
    this.DBField=DBField;
    
    }
   global Iterable<String> start(Database.batchableContext batchableContext)
   { 
       return new ListIterator(parsedCSV);
   }
   global void execute(Database.BatchableContext batchableContext, List<String> scope)  
   {
       
       importAttendeeValues(scope);
   }
   global void finish(Database.BatchableContext batchableContext){}
   
    MAP<Id, Decimal> TicketIdsListMAP;
   global void importAttendeeValues(LIST<String> scope)
   {
      MAP<Id, Integer> UpdateTickets= new MAP<Id, Integer>();
        LIST<AttendeeSummary__c> UploadedAttendeeWithAllFields = new LIST<AttendeeSummary__c>();
        MAP<String, AttendeeSummary__c> UploadedAttendeeWithAllFieldsMAP= new MAP<String, AttendeeSummary__c>();
        LIST<AttendeeSummary__c> FailedRecordsuploaded = new LIST<AttendeeSummary__c>();
        LIST<Dummay__c> UploadedRegistrationInfoList = new LIST<Dummay__c>();
        LIST<Dummay__c> FailedRegistrationInfoList = new LIST<Dummay__c>();
        LIST<Constomer__c> UploadedTransactionInfoList = new LIST<Constomer__c>();
        LIST<Constomer__c> FailedTransactionInfoList = new LIST<Constomer__c>();
        SET<Id>  insertedRecordIds = new SET<Id>(); 
        SET<Id>  insertedPaymentIds = new SET<Id>(); 
        SET<String> AllfailedRecords = new  SET<String>(); 
        List<TicketTypes__c> TicketNamesList = new LIST<TicketTypes__c>();
        MAP<String, TicketTypes__c> TicketNamesListMAP = new MAP<String, TicketTypes__c>();
        MAP<String, String> AttendeeCategoryMAP= new MAP<String, String>(); 
        MAP<String, String> custombarcodeMAP= new MAP<String, String>();         
        TicketIdsListMAP= new MAP<Id, Decimal>();
        TicketNamesList=[SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Available__c, TT_TicketType__c, Available__c, TT_Sold__c FROM TicketTypes__c WHERE EV_id__c =: selectedEventId AND Available__c > 0];
        for(TicketTypes__c tic: TicketNamesList){        
            TicketNamesListMAP.put(tic.TT_Name__c.toLowercase(), tic); 
        }
        system.debug(TicketNamesListMAP.size()+'  INITIAL LIST '+TicketNamesListMAP);
        LIST<TicketTypes__c> Tickets = new LIST<TicketTypes__c>();
        MAP<String, TicketTypes__c> InsertTickets= new MAP<String, TicketTypes__c>();
        MAP<String, Decimal> toIncreaseTicketQuantity= new MAP<String, Decimal>();
        
        for(Integer i=1;i<scope.size();i++){                        
            String[] inputvalues = new String[]{};
            User U = new User();
            u.TwitterId__c = String.valueOf(i);
            inputvalues = scope[i].split(';;;:::');
            system.debug(inputvalues.size()+'   INPUT VALUES '+inputvalues );
            TicketTypes__c insertTicket= new TicketTypes__c();
            String SelectedTicketName;            
            Decimal SoldTicketQuantity;

            if(inputvalues.size() >11){
                for(SA_ImportAttendeesController.innclas innIterator:inn){
    
                    system.debug(innIterator.dbFieldvalue+'  FOR TICKET NAME '+innIterator.selectedValue);
                    
                    if(DBField.get(innIterator.dbFieldvalue)=='TT_Name__c'){
                    try{
                        SelectedTicketName= inputvalues[integer.valueOf(innIterator.selectedValue)];
                        system.debug('  SELECTED TICKET NAME '+SelectedTicketName);
                        if(TicketNamesListMAP.get(SelectedTicketName.toLowercase()) == NULL){  
                            system.debug('Ticket Looping'+SelectedTicketName);
                            insertTicket.TT_Name__c = SelectedTicketName;
                            insertTicket.EV_id__c = selectedEventId;
                            insertTicket.TT_Sold__c =0;                        
                        } 
                        }catch(Exception e){}                   
                    }
                    
                    if(DBField.get(innIterator.dbFieldvalue)=='TT_Amount__c'){
                    try{
                        system.debug('  TICKET AMOUNT  '+inputvalues[integer.valueOf(innIterator.selectedValue)]);
                        if(TicketNamesListMAP.get(SelectedTicketName.toLowercase()) == NULL){  
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] !=''){
                                insertTicket.TT_Amount__c= Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                                if(insertTicket.TT_Amount__c == 0){
                                    insertTicket.TT_TicketType__c= 'Free';
                                }else{
                                    insertTicket.TT_TicketType__c= 'Paid';
                                }
                            }else{
                                insertTicket.TT_Amount__c=0;
                            }
                        }
                        else{
                            if(TicketNamesListMAP.get(SelectedTicketName.toLowercase()).TT_TicketType__c == 'Donation'){
                                if(inputvalues[integer.valueOf(innIterator.selectedValue)] == NULL){
                                    TicketIdsListMAP.put(TicketNamesListMAP.get(SelectedTicketName.toLowercase()).Id, TicketNamesListMAP.get(SelectedTicketName.toLowercase()).TT_Amount__c);
                                }else{
                                    TicketIdsListMAP.put(TicketNamesListMAP.get(SelectedTicketName.toLowercase()).Id, Decimal.valueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));                       
                                }
                            }
                        }
                        }catch(Exception e){}
                    }
                   
                   if(DBField.get(innIterator.dbFieldvalue)=='TT_Available__c'){
                   try{
                       if(TicketNamesListMAP.get(SelectedTicketName.toLowercase()) == NULL){  
                           if(inputvalues[integer.valueOf(innIterator.selectedValue)] != ''){
                               insertTicket.TT_Available__c= Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                           }else{
                               insertTicket.TT_Available__c=0;
                           }
                       }
                       }catch(Exception e){}
                   }
                   
                   if(DBField.get(innIterator.dbFieldvalue)=='Tickets_Quantty__c'){
                   try{
                       SoldTicketQuantity= Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                       if(toIncreaseTicketQuantity.containsKey(SelectedTicketName.toLowercase())){
                           Decimal soldQuantity= toIncreaseTicketQuantity.get(SelectedTicketName.toLowercase());
                           soldQuantity= soldQuantity+SoldTicketQuantity;
                           toIncreaseTicketQuantity.put(SelectedTicketName.toLowercase(), soldQuantity);                            
                       }else{
                           toIncreaseTicketQuantity.put(SelectedTicketName.toLowercase(), SoldTicketQuantity); 
                       }
                       }catch(Exception e){}
                   }
                   system.debug(toIncreaseTicketQuantity.size()+'   TO INCREASE TICKET QUANTITY1111111111111   '+toIncreaseTicketQuantity);
                   
                }
                if(insertTicket.TT_Name__c != NULL){
                    InsertTickets.put(insertTicket.TT_Name__c, insertTicket);
                    system.debug('Ticket to be inserted: '+insertTicket);
                } 

                
                //Tickets.add(insertTicket); 
                }   
         } 
         system.debug(InsertTickets+'   TO INCREASE TICKET QUANTITY2222222222222  '+toIncreaseTicketQuantity);
         if(InsertTickets.size() >0){
             LIST<TicketTypes__c> InsertingCheckedTickets= new LIST<TicketTypes__c>();
             for(TicketTypes__c ticket: InsertTickets.values()){
                 if(toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase()) != NULL){ 
                     if(ticket.TT_Available__c < toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase())){
                         ticket.TT_Available__c=  toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase());
                     }
                     system.debug(ticket.TT_Sold__c+' CHECK TO CREATE  '+toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase()));
                     ticket.TT_Sold__c += toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase());
                     system.debug(' TICKET TO CREATE  '+ticket);
                     InsertingCheckedTickets.add(ticket);                 
                 }
             }
             Database.SaveResult[] InsertedTicketResult= Database.Insert(InsertingCheckedTickets, FALSE);                       
         }
         LIST<TicketTypes__c> updatingCheckedTickets= new LIST<TicketTypes__c>();
         for(TicketTypes__c ticket: TicketNamesListMAP.values()){
             if(toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase()) != NULL){ 
                 if(ticket.Available__c < toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase())){
                     ticket.TT_Available__c= ticket.TT_Sold__c+ toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase());
                 }
                 ticket.TT_Sold__c += toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase());
                 system.debug(ticket.TT_Sold__c+' TICKET TO UPDATE  '+ticket);
                 updatingCheckedTickets.add(ticket);
             }
             
               
         }         
         Database.SaveResult[] UpdatedTicketResult= Database.Update(updatingCheckedTickets, FALSE);                       
         system.debug(' TICKET TO UPDATE  RESULT  '+UpdatedTicketResult);
         TicketNamesList = new LIST<TicketTypes__c>();                    
         TicketNamesListMAP = new MAP<String, TicketTypes__c >();
         
         TicketNamesList=[SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Available__c, TT_TicketType__c FROM TicketTypes__c WHERE EV_id__c =: selectedEventId AND Available__c > 0];
         for(TicketTypes__c tic: TicketNamesList)
         {
             system.debug(' AFTER  TICKET NAME '+tic.TT_Name__c);        
             TicketNamesListMAP.put(tic.TT_Name__c.toLowerCase(), tic);
             TicketIdsListMAP.put(tic.Id, tic.TT_Amount__c);
         }
        system.debug(TicketNamesListMAP.size()+'  TICKETS MAP '+TicketNamesListMAP);       
        system.debug(scope.size()+'Size of parsed CSV '+scope);

        for(Integer i=1;i<scope.size();i++){
            String[] inputvalues = new String[]{};
            User U = new User();
            u.TwitterId__c = String.valueOf(i);
            inputvalues = scope[i].split(';;;:::');
            AttendeeSummary__c Attendee = new AttendeeSummary__c();
            Ticket_Eam__c TicketEvent = new Ticket_Eam__c();

            Dummay__c RegistrationInfo = new Dummay__c();
            Constomer__c TransactionInfo = new Constomer__c();

            for(SA_ImportAttendeesController.innclas innIterator:inn){
                string SelectedTicketName ;
                if(innIterator.selectedValue!='NONE'){
                    system.debug('DBField Values are '+ DBField.get(innIterator.dbFieldvalue));
                    if(DBField.get(innIterator.dbFieldvalue)=='AS_FirstName__c'){
                        try{
                            Attendee.AS_FirstName__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            RegistrationInfo.First_Name__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}   
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_LastName__c'){
                        try{
                            Attendee.AS_LastName__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            RegistrationInfo.Last_Name__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}  
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_Email__c'){
                        try{
                            Attendee.AS_Email__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            system.debug('  EMAIL ID IS '+Attendee.AS_Email__c);
                            RegistrationInfo.Email__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}  
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_Company__c'){
                        try{
                            Attendee.AS_Company__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            RegistrationInfo.Company__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_Title__c'){
                        try{
                            Attendee.AS_Title__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='GuestType__c'){
                        try{
                            system.debug('  EMAIL ID IS2222222222 '+Attendee.AS_Email__c);
                            AttendeeCategoryMAP.put(Attendee.AS_Email__c.toLowerCase(), inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            system.debug(AttendeeCategoryMAP+'  EMAIL ID IS3333333333 '+Attendee.AS_Email__c);
                        }catch(exception e){}
                    }
                     else if(DBField.get(innIterator.dbFieldvalue)=='Custom_Barcode__c'){
                        try{
                            system.debug('  EMAIL ID IS2222222222 '+Attendee.AS_Email__c);
                            custombarcodeMAP.put(Attendee.AS_Email__c.toLowerCase(), inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            system.debug(custombarcodeMAP+'  EMAIL ID IS4444444 '+Attendee.AS_Email__c);
                        }catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_Name__c'){
                        try{
                            system.debug(innIterator+' SELECTED VALUE ');
                            if(inputvalues.size() >11){
                            SelectedTicketName = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            system.debug(SelectedTicketName +' SELECTED TICKET NAME '+SelectedTicketName.toLowerCase());
                            if(TicketNamesListMAP.get(SelectedTicketName.toLowerCase()) != NULL){
                                RegistrationInfo.TicketTypes__c = TicketNamesListMAP.get(SelectedTicketName.toLowerCase()).Id;
                            } 
                            }else{
                                RegistrationInfo.TicketTypes__c = TicketNamesListMAP.get('guest').Id;
                            }
                        }catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Payment_Status__c'){
                        try{
                            if(inputvalues.size() >11){
                                RegistrationInfo.Payment_Status__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            }else{
                                RegistrationInfo.Payment_Status__c ='Guest';
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Payment_Type__c'){
                        try{
                        system.debug('  PAYMENT TYPE  '+inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            if(inputvalues.size() >11){
                                RegistrationInfo.Payment_Type__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            }else{
                                RegistrationInfo.Payment_Type__c= 'Paid';
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Tickets_Quantty__c'){
                        try{
                            if(inputvalues.size() >11){
                                RegistrationInfo.Tickets_Quantty__c = Decimal.valueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            }else{
                                RegistrationInfo.Tickets_Quantty__c= 1;                            
                            }

                          
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Seat_Number__c'){
                        try{
                            RegistrationInfo.Seat_Number__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_WorkPhone__c'){
                        try{
                            Attendee.AS_WorkPhone__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            RegistrationInfo.Phone__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_WorkAddress1__c'){
                        try{
                            Attendee.AS_WorkAddress1__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_WorkCity__c'){
                        try{
                            Attendee.AS_WorkCity__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_Work_States__c'){
                        try{
                            Attendee.AS_Work_States__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='AS_WorkZip__c'){
                        try{
                            Attendee.AS_WorkZip__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                }
            }
            system.debug(RegistrationInfo.Payment_Type__c+'  REGINFO PAYMENT TYPE '+RegistrationInfo);
            if((Attendee.AS_FirstName__c!=null && Attendee.AS_LastName__c!=null && Attendee.AS_Email__c!=null) && (Attendee.AS_FirstName__c!='' && Attendee.AS_LastName__c!='' && Attendee.AS_Email__c!='')){                 
                UploadedAttendeeWithAllFields.add(Attendee);
                UploadedAttendeeWithAllFieldsMAP.put(Attendee.AS_Email__c, Attendee);
                UploadedRegistrationInfoList.add(RegistrationInfo);
            }
            else{
                AllfailedRecords.add(u.Twitterid__c);  
                FailedRecordsuploaded.add(Attendee);
                FailedRegistrationInfoList.add(RegistrationInfo);
            } 
        }
        System.debug('Uploaded Attendees ' + UploadedAttendeeWithAllFields);
        System.debug('Failed Attendees ' + FailedRecordsuploaded);
        
        Database.UpsertResult[] MySaveResultItems =dataBase.upsert(UploadedAttendeeWithAllFieldsMAP.values(), AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false); 
        System.debug('result: ' + MySaveResultItems);
        for(Database.UpsertResult SaveRes:MySaveResultItems){
            if(SaveRes.issuccess()){
                insertedRecordIds.add(SaveRes.getId());
            }
        }
        //Database.Update(updateTicketsMAP.values());
        
        for(AttendeeSummary__c attendee: UploadedAttendeeWithAllFields){
            Constomer__c TransactionInfo= new Constomer__c();
                                    
            TransactionInfo.Email__c= attendee.AS_Email__c;
            TransactionInfo.Customer_Name__c= attendee.AS_FirstName__c+' '+attendee.AS_LastName__c;
            TransactionInfo.Isinserted__c = TRUE;
            
            UploadedTransactionInfoList.add(TransactionInfo);
        }
        
        MAP<String, Constomer__c> EmailCustomerKey= new MAP<String, Constomer__c>();
        Database.Insert(UploadedTransactionInfoList,False);
        for(Constomer__c trans: UploadedTransactionInfoList){
            EmailCustomerKey.put(trans.Email__c, trans);
        }
        try{
        for(Dummay__c regInfo: UploadedRegistrationInfoList){
            regInfo.customer_key__c= EmailCustomerKey.get(regInfo.Email__c).Id;
            regInfo.TicketAmount__c= regInfo.Tickets_Quantty__c*TicketIdsListMAP.get(regInfo.TicketTypes__c);
            system.debug('  FOR PAYMENT TYPE  '+regInfo.Payment_Type__c);
        }
        }catch(Exception e){}
        Database.SaveResult[] RegistrationSaveResultItems =dataBase.insert(UploadedRegistrationInfoList,false); 
        System.debug('result: ' + RegistrationSaveResultItems);
        System.debug('  PAYMENT STATUS FOR RG INFO  ' + UploadedRegistrationInfoList);        
        for(Database.SaveResult RegSaveRes:RegistrationSaveResultItems ){
            if(RegSaveRes.issuccess()){
                insertedPaymentIds.add(RegSaveRes.getId());
            }
        }

        system.debug(' $$$$$ '+selectedEventId+' %%%%% '+insertedRecordIds);
        
        
        // --------------------------------------- Sending Failure Records Email Start ----------------------------------------------
       
        String failedList ;
        
        String defaultval =scope[0];
        defaultval =defaultval.replaceAll(';;;:::',',');
        defaultval =defaultval +'\r';
        failedList =defaultval;     
        for(string us:AllFailedRecords){
            string  s =scope[integer.valueOf(us)];
            failedList+=s+'\r';
        }
    
        integer csvSize = scope.size();
         
        integer  successedRecords =(csvSize-1) - AllFailedRecords.size();     
        
        Messaging.singleEmailMessage  Mail = new Messaging.singleEmailMessage();
                
        mail.setHTMLBody('Hello ' + ' ,' + + '<br/>' + '' + '<br/>' +
                     'Scan Attendee App has just completed your attendee import process!' + '<br/>' +'<br/>' +
                     'Number of records imported: '+(csvSize-1)+'<br/>'+
                     'Number of records inserted: '+successedRecords +'<br/>'+
                     'Number of records failed: '+AllFailedRecords.size()+'<br/>'+'<br/>'+
                     'Please check the attached file for the failed records.'+'<br/>'+
                     'We strongly recommend that you check a few of your imported records to verify that your information was imported as expected.'+'<br/>'+'<br/>'+
                     'If you have any further questions, please contact Scan Attendee.'+'<br/>'+'<br/>'+
                     'Best Wishes!'+'<br/>'+
                     'Scan Attendee Customer support'+'<br/>'+
                     +'<a>'+'support@boothleads.com.'+'</a>'+'<br/>'+
                     'Phone: 1-(800)-492-1289.');
        
        failedList=failedList.replaceAll(';;;:::',',');
        blob b1=blob.valueOf(failedList);
        
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        if(AllFailedRecords.size()!=0){
         if(failedList!=null&&failedList!=''&&failedList!='null'){
        attach.setFileName('Failed Attendees Records.csv');
        attach.setInline(false);
        attach.Body = b1;}}
        string vgf= userInfo.getUserName();

        mail.setToAddresses(new String[] {vgf});
        mail.setSubject('Import Attendees Summary');
        if(AllFailedRecords.size()!=0){
        if(failedList!=null&&failedList!=''&&failedList!='null')
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });}
        Messaging.SendEmailResult[] msResult= Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
 
        // ------------------------------------------------ Send Failure Records Email End ------------------------------------------------
        system.debug('  ATTENDEE CATEGORY '+AttendeeCategoryMAP);
        insertAllObjects(selectedEventId,insertedRecordIds,insertedPaymentIds, AttendeeCategoryMAP,custombarcodeMAP);
   }
   
   global void insertAllObjects(String EventId,SET<Id> AttendeeIds,SET<Id> PaymentIds, MAP<String, String> AttCatMAP,MAP<String, String> custombarcodeMAP){
     
        LIST<Event_Attendee_Mapping__c> Event_AttendeeList = new LIST<Event_Attendee_Mapping__c>();
        SET<Id>  insertedEAMIds = new SET<Id>(); 
        LIST<AttendeeSummary__c> AttendeeList = [SELECT Id, AS_Email__c FROM AttendeeSummary__c WHERE Id IN:AttendeeIds];
        LIST<Dummay__c> RegInfoList = [SELECT Id,TicketTypes__c, Tickets_Quantty__c, Email__c,Event__c,Event_Attendee_Mapping__c,AttendeeSummary__c, Payment_Type__c, TicketAmount__c FROM Dummay__c WHERE Id IN:PaymentIds];
        system.debug('Attendee Size: '+ AttendeeList.size() + ' Reg Info Size: '+RegInfoList.size()+'     '+RegInfoList );
        
        for(AttendeeSummary__c att:AttendeeList){
  
            Event_Attendee_Mapping__c Event_Attendee = new Event_Attendee_Mapping__c();
            Event_Attendee.AS_id__c = att.Id;
            Event_Attendee.EV_id__c = EventId;
            Event_Attendee.Attendee_Event_IDs__c = att.Id+'-'+EventId;
            if(AttCatMAP.get(att.AS_Email__c) != NULL){
                Event_Attendee.GuestType__c= AttCatMAP.get(att.AS_Email__c);
            }else{
                Event_Attendee.GuestType__c= 'Attendee';
            }
            if(custombarcodeMAP.get(att.AS_Email__c) != NULL){
                Event_Attendee.Custom_Barcode__c= custombarcodeMAP.get(att.AS_Email__c);
            }
            Event_AttendeeList.add(Event_Attendee);  
        }
         
        system.debug('&&&& '+Event_AttendeeList);
        Database.UpsertResult[] MySaveResultItems = database.upsert(Event_AttendeeList, Event_Attendee_Mapping__c.Attendee_Event_IDs__c.getDescribe().getSObjectField(), FALSE); 
        System.debug('result: ' + MySaveResultItems);
        
        for(Database.UpsertResult SaveRes:MySaveResultItems){
            if(SaveRes.issuccess()){
                insertedEAMIds.add(SaveRes.getId());
            }
        } 
        
        MAP<String, Event_Attendee_Mapping__c> EAMListMAP= new MAP<String, Event_Attendee_Mapping__c>();
        LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
        
        EAMList=[ SELECT ID, AS_Id__c, AS_Id__r.AS_Email__c, EV_id__c FROM Event_Attendee_Mapping__c WHERE ID IN :insertedEAMIds];
        for(Event_Attendee_Mapping__c EAM: EAMList){
            EAMListMAP.put(EAM.AS_Id__r.AS_Email__c, EAM);
        }
        system.debug(EAMListMAP.size()+'  EAM LIST FOR MAP  '+EAMListMAP);
        system.debug(RegInfoList.size()+'  REG INFO LIST TO INSERT '+RegInfoList);
        
        SET<Id> TicketIds= new SET<Id>();
        for(Dummay__c RegInfo: RegInfoList){
            system.debug(RegInfo.Email__c+' REGINFO DS '+eventid);
            TicketIds.add(RegInfo.TicketTypes__c);
            try{
                RegInfo.Event_Attendee_Mapping__c = EAMListMAP.get(RegInfo.Email__c).Id;
                RegInfo.Event__c = EAMListMAP.get(RegInfo.Email__c).EV_id__c;
                RegInfo.AttendeeSummary__c = EAMListMAP.get(RegInfo.Email__c).AS_id__c; 
                system.debug('  PAYMENT TYPE FOR REG INFO '+RegInfo.Payment_Type__c);
                if(RegInfo.Payment_Type__c == NULL){
                    if(RegInfo.TicketAmount__c == 0){
                        RegInfo.Payment_Type__c= 'Free';
                    }else{
                        RegInfo.Payment_Type__c= 'Cash';                    
                    }

                }
            }
            catch(Exception e){}
        }
        update RegInfoList; 
 
    }
  
   
   }
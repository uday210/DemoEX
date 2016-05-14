public with sharing class SA_ImportTicketsController {
    
    // Import Variables
    public String SelectedEventId{get;set;}
    public Event__c SelectedEvent{get;set;}
    public Blob importedFile{ get; set; }
    public String fileName{ get; set; }
    public LIST<selectOption> CSVHeaders{get;set;}
    public MAP<string,string> DBField{get;set;}
    public string nameFile{get;set;}
    public LIST<String> allFields{get;set;} 
    public MAP<String, String> CSVHeaderMapping{get; set;}
    public LIST<String> CSVHeaderToStore{get; set;}
    public LIST<String> parsedCSV{get;set;}
    public LIST<string> dbvalue{get;set;}
    public Boolean showselectCSV{get;set;}
    public Boolean Successbool{get;set;}
    public String dataFromJavaScript{get;set;}
    public LIST<innclas> inn{get;set;}
    
    public SA_ImportTicketsController(){
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            SelectedEventId  = counter.getValue();
            SelectedEvent =[SELECT Id,Ev_Title__c FROM Event__c Where Id=:SelectedEventId];
        }
        system.debug('EVENT ID '+SelectedEventId);  
        Successbool = FALSE;
        showselectCSV = FALSE;
        
        DBField = new MAP<String, String>();
        dbvalue =new LIST<string>{'Ticket Name','Ticket Price','Quantity','Ticket Type(Paid;Free;Donation)'};   
        DBField.put('none','NONE');
        DBField.put('Ticket Name','TT_Name__c');
        DBField.put('Ticket Price','TT_Amount__c');
        DBField.put('Quantity','TT_Available__c');
        DBField.put('Ticket Type(Paid;Free;Donation)','TT_TicketType__c');
    }
    
    public PageReference closeTicket(){
        showselectCSV = false;
        PageReference pageRef= new PageReference('/apex/SA_Tickets');
        return pageRef;
    }
    
    public PageReference exportTicketToCSV(){
        PageReference pageRef= new PageReference('/apex/ScanAttendee_Ticket_Template');
        return pageRef;
    }

    public PageReference close(){
        PageReference pageRef= new PageReference('/apex/SA_Tickets');
        pageRef.setRedirect(false);
        return pageRef;
    }
        
    public PageReference showTicketMapping(){
        showselectCSV = true;
        parsedCSV = new LIST<String>();
        dataFromJavaScript =ApexPages.currentPage().getparameters().get('one');
        system.debug('dataFromJavaScript::::::::dataFromJavaScript' + dataFromJavaScript);
        try{
            dataFromJavaScript = dataFromJavaScript.replaceAll('&amp;', '&');
        }
        catch(Exception e){
        }
        
        if(dataFromJavaScript !=''){
            nameFile =dataFromJavaScript;
          system.debug('nameFile:nameFile' + nameFile);
  
            parsedCSV = parseCSV(nameFile);
            system.debug('parsedCSV::::::parsedCSV' + parsedCSV);  

            CSVHeaders = new LIST<SelectOption>();
            CSVHeaderMapping = new MAP<String, String>();
            CSVHeaderToStore = new LIST<String>();
            integer columncount = 0;
            CSVHeaders.add(new SelectOption('NONE','NONE'));
            
            for(String ss: parsedCSV[0].split(';;;:::')){
                CSVHeaders.add(new SelectOption(String.valueOf(columncount),ss));
                CSVHeaderMapping.put(ss.toLowerCase(), String.valueOf(columncount));
                CSVHeaderToStore.add(ss);
                columncount ++;
            }
        }

        passValuesToInner();
        return null;
    }
    
    public LIST<String> parseCSV(String contents){
    system.debug('contents:::::::::contents'+contents);
        LIST<String> allFields = new LIST<String>();
        LIST<String> lines = new LIST<String>();
        
        string nameFile1 = contents.subString(contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
         system.debug('nameFile1:::::::::nameFile1'+nameFile1);
        nameFile1 = nameFile1.replace('????:::::******&&&&&&%%%%;;;;','');
            system.debug('nameFile1::2244355:::::::nameFile1'+nameFile1);

        contents = contents.subString(0,contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
                    system.debug('contents::2244355:::::::contents'+contents);

        try{
            lines = contents.split('aazz11ttt222ggg'); 
        }
        catch (System.LISTException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        Integer num = 0;
                    system.debug('lines::lines:::::::lines'+lines);

        for(String line: lines){
            system.debug('lines::lines:34345345::::::lines'+line);

            if(line.replaceAll(',','').trim().length() == 0) break;
            
            LIST<String> fields = line.split(','); 
            
            String cleanFields='';
            String compositeField;
            Boolean makeCompositeField = false;
            
            for(String field: fields){
                field = field.trim();
              system.debug('field::::::field' + field);  
                if(field == '"'){ 
                    compositeField += ',' + field;
                    cleanFields+=(compositeField.replaceAll('DBLQT','"')+';;;:::');
                    makeCompositeField = FALSE;
                }
                else if(field.startsWith('"') && field.endsWith('"')){
                    cleanFields+=(field.replaceAll('DBLQT','"')+';;;:::' );
                } 
                else if(field.startsWith('"')){
                    makeCompositeField = true;
                    compositeField = field;
                }
                else if(field.endsWith('"')){
                    compositeField += ',' + field;
                    cleanFields+=(compositeField.replaceAll('DBLQT','"')+';;;:::');
                    makeCompositeField = false;
                }
                else if(makeCompositeField){
                    compositeField +=  ',' + field;
                }
                else{
                    cleanFields+=(field.replaceAll('DBLQT','"')+';;;:::');
                }
            }  
            allFields.add(cleanFields);
                        system.debug('allFields::allFields:34345345::::::allFields'+allFields);

        }     
        return allFields;      
    }
    
    public void passValuesToInner(){
        inn = new LIST<innclas>();

        for(string dd:dbvalue){
            inn.add(new innclas(dd,CSVHeaderMapping.get(dd.toLowerCase())));
        }
    }

    public class innclas{
        public string selectedValue{get;set;}
        public string dbFieldvalue{get;set;}
        public LIST<selectOption> options {get;set;}
        
        public innclas(string sd,string opt){
            dbFieldvalue =sd;
            selectedValue=opt;
        }
    }
    
    public PageReference importTicketValues(){   
        
        LIST<TicketTypes__c> UploadedTicketWithAllFields= new LIST<TicketTypes__c>();
        LIST<TicketTypes__c> FailedRecordsuploaded= new LIST<TicketTypes__c>();
        SET<id>  insertedRecordIds = new SET<id>(); 
        SET<string> AllfailedRecords = new  SET<string>(); 
        SET<string> ticketTypesMAP=new Set<String>();        
        
       Schema.DescribeFieldResult TicketField= TicketTypes__c.TT_TicketType__c.getDescribe();
       List<Schema.PicklistEntry> TicketTypeValues= TicketField.getPicklistValues();
       for (Schema.PicklistEntry type: TicketTypeValues){ 
           ticketTypesMAP.add(type.getValue().toLowerCase()); 
       }   
       system.debug(ticketTypesMAP.size()+'   TICKET TYPES MAP  '+ticketTypesMAP);            
        system.debug('Size of parsed CSV '+parsedCSV.size());
        for(Integer i=1;i<parsedCSV.size();i++){
            TicketTypes__c ticket = new TicketTypes__c();
            User U = new User();
            u.TwitterId__c = String.valueOf(i);
            String[] inputvalues = new String[]{};
            inputvalues = parsedCSV[i].split(';;;:::');
            system.debug('  TICKET EVENT ID '+ticket.EV_id__c);
            ticket.EV_id__c = SelectedEventId;
            system.debug('!!!!! '+inn);
            for(innclas innIterator:inn){
                system.debug('##### '+innIterator.selectedValue);
                if(innIterator.selectedValue!='NONE'){
                    system.debug('DBField Values are '+ DBField.get(innIterator.dbFieldvalue));
                    if(DBField.get(innIterator.dbFieldvalue)=='TT_Name__c'){        
                        try{
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] != NULL || inputvalues[integer.valueOf(innIterator.selectedValue)]!=''){
                                system.debug('^^^^Name '+inputvalues[integer.valueOf(innIterator.selectedValue)]);
                                ticket.TT_Name__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_Amount__c'){
                        try{
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] != NULL || inputvalues[integer.valueOf(innIterator.selectedValue)]!=''){
                                system.debug('^^^^Price '+Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));
                                ticket.TT_Amount__c = Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_Available__c'){
                        try{
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] != NULL || inputvalues[integer.valueOf(innIterator.selectedValue)]!=''){
                                system.debug('^^^^Quantity '+Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));
                                ticket.TT_Available__c = Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_TicketType__c'){
                        try{
                            system.debug('^^^^tickettype '+inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            ticket.TT_TicketType__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            String LowerCaseTicketType= 'Free';
                            if(ticket.TT_TicketType__c.toLowerCase() == LowerCaseTicketType.toLowerCase()){
                                ticket.TT_Amount__c = 0.00;
                            }
                        }
                        catch(exception e){}
                    }
                }
                system.debug('  TICKET DETAILS11111111 '+ticket);
            }
            system.debug('  TICKET DETAILS2222222 '+ticket);
            if((ticket.TT_Name__c!=null && ticket.TT_Amount__c != null && ticket.TT_Available__c!=null && ticket.TT_TicketType__c!=NULL) && (ticket.TT_Name__c!=''&& ticket.TT_Amount__c!=null && ticket.TT_Available__c!=null && ticket.TT_TicketType__c!='')){                 
                String LowerCaseTicketType= ticket.TT_TicketType__c.toLowerCase();
                if(ticketTypesMAP.Contains(LowerCaseTicketType)){
                    UploadedTicketWithAllFields.add(ticket);
                }else{
                    FailedRecordsuploaded.add(ticket);
                }
            }
            else{
                AllfailedRecords.add(u.Twitterid__c);  
                FailedRecordsuploaded.add(ticket);
            }   
        }
        System.debug(' Uploaded Tickets ' + UploadedTicketWithAllFields);
        System.debug(' Failed Tickets ' + FailedRecordsuploaded);
        Database.SaveResult[] MySaveResultTickets =dataBase.insert(UploadedTicketWithAllFields,false); 
        System.debug(' SAVED result: ' + MySaveResultTickets);
        for(Database.saveResult SaveRes:MySaveResultTickets){
            if(SaveRes.issuccess()){
                insertedRecordIds.add(SaveRes.getId());
            }
        } 
        
        // --------------------------------------- Sending Failure Records Email Start ----------------------------------------------
       
        String failedList ;
        String defaultval =parsedCSV[0];
        defaultval =defaultval.replaceAll(';;;:::',',');
        defaultval =defaultval +'\r';
        failedList =defaultval;     
        for(string us:AllFailedRecords){
            string  s =parsedCSV[integer.valueOf(us)];
            failedList+=s+'\r';
        }
         
        integer csvSize = parsedCSV.size();
         
        integer  successedRecords =(csvSize-1) - AllFailedRecords.size();     
        
        Messaging.singleEmailMessage  Mail = new Messaging.singleEmailMessage();
                
        mail.setHTMLBody('Hello ' + ' ,' + + '<br/>' + '' + '<br/>' +
                     'Scan Attendee App has just completed your ticket import process!' + '<br/>' +'<br/>' +
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
        attach.setFileName('Failed Tickets Records.csv');
        attach.setInline(false);
        attach.Body = b1;
        string vgf= userInfo.getUserName();
        //userInfo.getUserName();

        mail.setToAddresses(new String[] {vgf});
        mail.setSubject('Import Tickets Summary');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        Messaging.SendEmailResult[] msResult= Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
 
        // ------------------------------------------------ Send Failure Records Email End ------------------------------------------------
        
        
        showselectCSV = false;
        Successbool =true; 
        return null;
    }

}
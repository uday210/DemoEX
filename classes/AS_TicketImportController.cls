public with sharing class AS_TicketImportController{

    // Import Variables
    public Blob importedFile{ get; set; }
    public String fileName { get; set; }
    public LIST<selectOption> CSVHeaders {get;set;}
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
    public List<User_Profile_Event__c> ListOfEvents{get;set;}
    public string SelectedEventId{get;set;}
        
    public AS_TicketImportController(){
        Successbool = FALSE;
        showselectCSV = FALSE;
        
        DBField = new MAP<String, String>();
        dbvalue =new LIST<string>{'Ticket Name','Ticket Price','Quantity','Ticket Type','Ticket Category','Ticket Description'};   
        DBField.put('none','NONE');
        DBField.put('Ticket Name','TT_Name__c');
        DBField.put('Ticket Price','TT_Amount__c');
        DBField.put('Quantity','TT_Available__c');
        DBField.put('Ticket Type','TT_TicketType__c');
        DBField.put('Ticket Category','Ticket_Category__c');
        DBField.put('Ticket Description','Ticket_Description__c');
        
        ListOfEvents = new List<User_Profile_Event__c>();
        ListOfEvents =[SELECT u.EV_id__r.Status__c,u.EV_id__r.StartTime__c, u.EV_id__r.SecondaryCategory__c,
                                u.EV_id__r.Primary__c, u.EV_id__r.Name, u.EV_id__r.Id, u.EV_id__r.EV_Title__c, u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_HostingZipcode__c, 
                                u.EV_id__r.EV_HostingTimeZone__c, u.EV_id__r.EV_HostingState__c,u.EV_id__r.EV_HostingPostalCode__c,
                                u.EV_id__r.EV_HostingPhone__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HostingCountry__c,EV_id__r.TwitterId__c,EV_id__r.FacebookId__c,EV_id__r.OrganizerId__c,
                                u.EV_id__r.EV_HostedByEventBrite__c, u.EV_id__r.EV_HistingAddr1__c, u.EV_id__r.EV_EventLogo__c,u.EV_id__r.CCRDetails_Required__c, 
                                u.EV_id__r.EV_EndTime__c,u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_Description__c, u.Profile_id__r.PR_Name__c,
                                u.EV_id__r.CreatedDate, u.EV_id__r.Attendee_Tags__c,u.EV_id__r.EV_HostingOrgName__c, u.EV_id__r.AS_HostingCity__c,u.EV_id__r.AS_HostingAddr2__c,u.EV_id__r.Is_MatchMaking_Event__c 
                       FROM User_Profile_Event__c u 
                       WHERE u.EventAdmin_Id__c =: UserInfo.getUserId() ORDER BY CREATEDDATE Asc];
       for(User_Profile_Event__c Ev : ListOfEvents ){
           SelectedEventId  = ListOfEvents[0].EV_id__r.Id;
       }
    }
    
    public void closeticket(){
        showselectCSV = false;
    }
    
    public PageReference exportTicketToCSV(){
        PageReference pageRef= new PageReference('/apex/ScanAttendee_Ticket_Template');
        return pageRef;
    }

    public PageReference close() {
        PageReference pageRef= new PageReference('/apex/AS_Events?id='+SelectedEventId);
        pageRef.setredirect(false);
        return pageRef;
    }
        
    public PageReference showTicketMapping(){
        showselectCSV = true;
        parsedCSV = new LIST<String>();
        dataFromJavaScript =ApexPages.currentPage().getparameters().get('one');
        try{
            dataFromJavaScript = dataFromJavaScript.replaceAll('&amp;', '&');
        }
        catch(Exception e){
        }
        
        if(dataFromJavaScript !=''){
            nameFile =dataFromJavaScript;
            
            parsedCSV = parseCSV(nameFile);

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
    
        LIST<String> allFields = new LIST<String>();
        LIST<String> lines = new LIST<String>();
        
        string nameFile1 = contents.subString(contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
        nameFile1 = nameFile1.replace('????:::::******&&&&&&%%%%;;;;','');
        
        contents = contents.subString(0,contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
        try{
            lines = contents.split('aazz11ttt222ggg'); //correction: this only accomodates windows files
        }
        catch (System.LISTException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        Integer num = 0;

        for(String line: lines){
            if(line.replaceAll(',','').trim().length() == 0) break;
            
            LIST<String> fields = line.split(','); 
            
            String cleanFields='';
            String compositeField;
            Boolean makeCompositeField = false;
            
            for(String field: fields){
                field = field.trim();
                
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
        string eventId=ApexPages.currentpage().getParameters().get('Id');
        string eventName;
        LIST<event__c> forEventName =[SELECT Id,EV_Title__c FROM Event__c WHERE Id=:eventId];
        if(forEventName.size()>0){
            eventName=forEventName[0].EV_Title__c;
        }     
        
        LIST<TicketTypes__c> UploadedTicketWithAllFields= new LIST<TicketTypes__c>();
        LIST<TicketTypes__c> FailesRecordsuploaded= new LIST<TicketTypes__c>();
        SET<id>  insertedRecordIds = new SET<id>(); 
        SET<string> AllfailedRecords = new  SET<string>(); 
        
        system.debug('Size of parsed CSV '+parsedCSV.size());
        for(Integer i=1;i<parsedCSV.size();i++){
            TicketTypes__c ticket = new TicketTypes__c();
            String[] inputvalues = new String[]{};
            inputvalues = parsedCSV[i].split(';;;:::');
            ticket.EV_id__c = eventId;
            system.debug('!!!!! '+inn);
            for(innclas innIterator:inn){
                system.debug('##### '+innIterator.selectedValue);
                if(innIterator.selectedValue!='NONE'){
                    system.debug('DBField Values are '+ DBField.get(innIterator.dbFieldvalue));
                    if(DBField.get(innIterator.dbFieldvalue)=='TT_Name__c'){
                        system.debug('^^^^Name '+inputvalues[integer.valueOf(innIterator.selectedValue)]);
                        try{
                            ticket.TT_Name__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_Amount__c'){
                        system.debug('^^^^Price '+Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));
                        try{
                            ticket.TT_Amount__c = Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_Available__c'){
                        system.debug('^^^^Quantity '+Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));
                        try{
                            ticket.TT_Available__c = Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='TT_TicketType__c'){
                        try{
                            ticket.TT_TicketType__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Ticket_Category__c'){
                        try{
                            ticket.Ticket_Category__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Ticket_Description__c'){
                        try{
                            ticket.Ticket_Description__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                        }
                        catch(exception e){}
                    }
                }
            }
            if((ticket.TT_Name__c!=null && ticket.TT_Amount__c!=null && ticket.TT_Available__c!=null) && (ticket.TT_Name__c!=''&& ticket.TT_Amount__c!=null && ticket.TT_Available__c!=null)){                 
              UploadedTicketWithAllFields.add(ticket);
            }
            else{
              FailesRecordsuploaded.add(ticket);
            }   
        }
        System.debug('Uploaded Tickets ' + UploadedTicketWithAllFields);
        System.debug('Failed Tickets ' + FailesRecordsuploaded);
        Database.SaveResult[] MySaveResultTickets =dataBase.insert(UploadedTicketWithAllFields,false); 
        System.debug('result: ' + MySaveResultTickets);
        for(Database.saveResult SaveRes:MySaveResultTickets){
            if(SaveRes.issuccess()){
                insertedRecordIds.add(SaveRes.getId());
            }
        } 
        showselectCSV = false;
        Successbool =true; 
        return null;
    }
    
    public Pagereference CheckUserId(){
        if(userInfo.getUserType()=='guest'){
            Pagereference pg = new pagereference('/apex/AS_Login');
            pg.setredirect(true);
            return pg;
        }
        else{
            return null;
        }
    }
}
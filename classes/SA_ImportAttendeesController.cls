public with sharing class SA_ImportAttendeesController{

    // Import Variables
    public Blob importedFile{get;set;}
    public String fileName{get;set;}
    public LIST<selectOption> CSVHeaders{get;set;}
    public MAP<String,String> DBField{get;set;}
    public String nameFile{get;set;}
    public LIST<String> allFields{get;set;} 
    public MAP<String, String> CSVHeaderMapping{get; set;}
    public LIST<String> CSVHeaderToStore{get; set;}
    public LIST<String> parsedCSV{get;set;}
    public LIST<String> dbvalue{get;set;}
    public Boolean showselectCSV{get;set;}
    public Boolean Successbool{get;set;}
    
    public String dataFromJavaScript{get;set;}
    public LIST<innclas> inn{get;set;}
    public string SelectedEventId{get;set;}
    public Event__c SelectedEvent{get; set;}
    
    public SA_ImportAttendeesController(){
        showselectCSV = FALSE;
        Successbool = FALSE;
        DBField = new MAP<String,String>();   // ,'Ticket Type'
        dbvalue = new LIST<String>{'First Name','Last Name','Email Id','Phone','Company','Job Title','Attendee Category','Address','City','State','Zip Code','Ticket Name','Ticket Price','Ticket Quantity','Payment Status','Sold Quantity','Payment Type','Seat Numbers','Custom Barcode'};
        DBField.put('none','NONE');
        DBField.put('First Name','AS_FirstName__c');
        DBField.put('Last Name','AS_LastName__c');
        DBField.put('Email Id','AS_Email__c');
        DBField.put('Phone','AS_WorkPhone__c');
        DBField.put('Company','AS_Company__c');
        DBField.put('Address','AS_WorkAddress1__c');
        DBField.put('City','AS_WorkCity__c');
        DBField.put('State','AS_Work_States__c');
        DBField.put('Zip Code','AS_WorkZip__c');  
        DBField.put('Job Title','AS_Title__c');  
        DBField.put('Attendee Category','GuestType__c');  
        DBField.put('Ticket Name','TT_Name__c');
        //DBField.put('Ticket Type','TT_TicketType__c');        
        DBField.put('Ticket Price','TT_Amount__c');
        DBField.put('Ticket Quantity','TT_Available__c');
        DBField.put('Payment Status','Payment_Status__c');
        DBField.put('Sold Quantity','Tickets_Quantty__c');
        DBField.put('Payment Type','Payment_Type__c');
        DBField.put('Seat Numbers','Seat_Number__c');
        DBField.put('Custom Barcode','Custom_Barcode__c');
        

        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            selectedEventId= counter.getValue();
            SelectedEvent= new Event__c();
            SelectedEvent= [SELECT Id,Ev_Title__c FROM Event__c Where Id=:SelectedEventId];
        }
    }

    public MAP<Id, Decimal> TicketIdsListMAP{get; set;}
    
    public PageReference importAttendeeValues(){
        Id batchInstanceId = Database.executeBatch(new ReadAndPopulateDataBatchSC(parsedCSV,SelectedEventId,inn,DBField), 100); 
        showselectCSV = false;
        Successbool =true; 
        return null;
    }
    
    
   
       
    public PageReference showAttendeeMapping(){
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
            try{
            
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
            catch (Exception e) {}
        }
        
        
        passValuesToInner();
        
        return null;
    }
    
    public LIST<String> parseCSV(String contents){
        system.debug('contents:::::::::contents'+contents);

        LIST<String> allFields = new LIST<String>();
        LIST<String> lines = new LIST<String>();
        
        string nameFile1 = contents.subString(contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
        nameFile1 = nameFile1.replace('????:::::******&&&&&&%%%%;;;;','');
                 system.debug('nameFile1:::::::::nameFile1'+nameFile1);

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
        try{
        inn = new LIST<innclas>();

        for(string dd:dbvalue){
            inn.add(new innclas(dd,CSVHeaderMapping.get(dd.toLowerCase())));
        }
    }catch(Exception e){}
    }

    public class innclas{
        public string selectedValue{get;set;}
        public string dbFieldvalue{get;set;}
        public LIST<selectOption> options{get;set;}
        
        public innclas(string sd,string opt){
            dbFieldvalue =sd;
            selectedValue=opt;
        }
    }
    
     public PageReference exportAttendeeToCSV(){
         PageReference pg;
         pg = page.ScanAttendee_Attendee_Template;
         return pg;
    }
    
    public void closeAttendee(){
        showselectCSV = false;
    }
      
    public PageReference close(){
        PageReference pageRef= new PageReference('/apex/SA_Attendees');
        pageRef.setredirect(false);
        return pageRef;
    }
    
    
    public PageReference checkUserId() {
        if (userInfo.getUserType() == 'guest') {
            Pagereference pg = new pagereference('/SA_Signup');
            pg.setredirect(true);
            return pg;
        }else {
            return null;
        }
    }

}
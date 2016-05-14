public with sharing class SA_ImportItemsController{

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
    public String selectedEventId{get; set;}     
    public Event__c SelectedEvent{get; set;}
        
    public SA_ImportItemsController(){
        Successbool = FALSE;
        showselectCSV = FALSE;
        
        DBField = new MAP<String, String>();
       // dbvalue =new LIST<string>{'Item Name','Item Price','Item Quantity','isTaxable(True;False)','Sales Tax'}; 
        dbvalue =new LIST<string>{'Item Name','Item Price','Item Quantity','isTaxable(True;False)'};   
        DBField.put('none','NONE');
        DBField.put('Item Name','Item_name__c');
        DBField.put('Item Price','Cost__c');
        DBField.put('Item Quantity','Item_Quantity__c');
        DBField.put('isTaxable(True;False)','isTaxable__c');
        //DBField.put('Sales Tax','Sales_Tax__c');
        
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            selectedEventId= counter.getValue();
            SelectedEvent= new Event__c();
            SelectedEvent= [SELECT Id,Ev_Title__c, Sales_Tax__c FROM Event__c Where Id=:SelectedEventId];
        }
    }
    
    public PageReference closeItem(){
        showselectCSV = false;
        PageReference pageRef= new PageReference('/apex/SA_Items');
        return pageRef;
    }
    
    public PageReference exportItemToCSV(){
        PageReference pageRef= new PageReference('/apex/ScanAttendee_Item_Template');
        return pageRef;
    }

    public PageReference close() {
        PageReference pageRef= new PageReference('/apex/SA_Items');
        pageRef.setredirect(false);
        return pageRef;
    }
        
    public PageReference showItemMapping(){
        showselectCSV = true;
        parsedCSV = new LIST<String>();
        dataFromJavaScript =ApexPages.currentPage().getparameters().get('one');
        system.debug('dataFromJavaScript:::::::' +dataFromJavaScript);
        try{
            dataFromJavaScript = dataFromJavaScript.replaceAll('&amp;', '&');
        }
        catch(Exception e){
        }
        
        if(dataFromJavaScript !=''){
            nameFile =dataFromJavaScript;
   system.debug('nameFile:::::::' +nameFile);            
            parsedCSV = parseCSV(nameFile);
   system.debug('parsedCSV:::::::' +parsedCSV);            

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
        system.debug('contentscontents:::::' + contents);
        string nameFile1 = contents.subString(contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
                system.debug('nameFile1nameFile1:::::' + nameFile1);

        nameFile1 = nameFile1.replace('????:::::******&&&&&&%%%%;;;;','');
                    system.debug('nameFile1::2244355:::::::nameFile1'+nameFile1);

        contents = contents.subString(0,contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
                            system.debug('contents::2244355:::::::contents'+contents);

        try{
            lines = contents.split('aazz11ttt222ggg'); //correction: this only accomodates windows files
        }
        catch (System.LISTException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        Integer num = 0;
System.debug('line line:::line?' + lines);
        for(String line: lines){
            System.debug('line line:::11111111111111111111111' + line);

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
    
    public PageReference importItemValues(){
        
        LIST<Item__c> UploadedItemWithAllFields= new LIST<Item__c>();
        LIST<Item__c> FailedRecordsuploaded= new LIST<Item__c>();
        SET<id>  insertedRecordIds = new SET<id>(); 
        SET<string> AllfailedRecords = new  SET<string>(); 
        
        system.debug('Size of parsed CSV '+parsedCSV.size());
        for(Integer i=1;i<parsedCSV.size();i++){
            Item__c Item = new Item__c();
            User U = new User();
            String[] inputvalues = new String[]{};
            inputvalues = parsedCSV[i].split(';;;:::');
            Item.Event__c = SelectedEventId;
            u.TwitterId__c = String.valueOf(i);
            system.debug('!!!!! '+inn);
            for(innclas innIterator:inn){
                system.debug('##### '+innIterator.selectedValue);
                if(innIterator.selectedValue!='NONE'){
                    system.debug('DBField Values are '+ DBField.get(innIterator.dbFieldvalue));
                    if(DBField.get(innIterator.dbFieldvalue)=='Item_name__c'){      
                        try{
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] != NULL || inputvalues[integer.valueOf(innIterator.selectedValue)]!=''){
                                system.debug('^^^^Name '+inputvalues[integer.valueOf(innIterator.selectedValue)]);
                                Item.Item_name__c = inputvalues[integer.valueOf(innIterator.selectedValue)];
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Cost__c'){
                        try{
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] != NULL || inputvalues[integer.valueOf(innIterator.selectedValue)]!=''){
                                system.debug('^^^^Price '+Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));
                                Item.Cost__c = Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='Item_Quantity__c'){
                        try{
                            if(inputvalues[integer.valueOf(innIterator.selectedValue)] != NULL || inputvalues[integer.valueOf(innIterator.selectedValue)]!=''){
                                system.debug('^^^^Quantity '+Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]));
                                Item.Item_Quantity__c = Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            }
                        }
                        catch(exception e){}
                    }
                    else if(DBField.get(innIterator.dbFieldvalue)=='isTaxable__c'){
                        try{
                            Item.isTaxable__c = Boolean.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            if(Item.isTaxable__c == TRUE){
                                Item.Sales_Tax__c= SelectedEvent.Sales_Tax__c;
                            }else{
                                Item.Sales_Tax__c= 0;
                            }
                        }
                        catch(exception e){}
                    }
                    /*
                    else if(DBField.get(innIterator.dbFieldvalue)=='Sales_Tax__c'){
                        try{
                            Item.Sales_Tax__c =Decimal.ValueOf(inputvalues[integer.valueOf(innIterator.selectedValue)]);
                            if(Item.Sales_Tax__c != NULL){
                                Item.Cost__c = Item.Cost__c+ ((Item.Sales_Tax__c*Item.Cost__c)/100);
                            } 
                        }
                        catch(exception e){}
                    }
                    */
                }
            }
            if((Item.Item_name__c!=null && Item.Cost__c!=null && Item.Item_Quantity__c!=null) && (Item.Item_name__c!=''&& Item.Cost__c!=null && Item.Item_Quantity__c!=null)){                 
              UploadedItemWithAllFields.add(Item);
            }
            else{
              AllfailedRecords.add(u.Twitterid__c);  
              FailedRecordsuploaded.add(Item);
            }   
        }
        System.debug('Uploaded Items ' + UploadedItemWithAllFields);
        System.debug('Failed Items ' + FailedRecordsuploaded);
        Database.SaveResult[] MySaveResultItems =dataBase.insert(UploadedItemWithAllFields,false); 
        System.debug('result: ' + MySaveResultItems);
        for(Database.saveResult SaveRes:MySaveResultItems){
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
                     'Scan Attendee App has just completed your import items process!' + '<br/>' +'<br/>' +
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
        attach.setFileName('Failed Items Records.csv');
        attach.setInline(false);
        attach.Body = b1;
        string vgf= userInfo.getUserName();

        mail.setToAddresses(new String[] {vgf});
        mail.setSubject('Import Items Summary');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        Messaging.SendEmailResult[] msResult= Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
 
        // ------------------------------------------------ Send Failure Records Email End ------------------------------------------------
        
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
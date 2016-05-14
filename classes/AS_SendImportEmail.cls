@RestResource(urlMapping='/AS_SendImportEmail/*')
  
global with sharing class AS_SendImportEmail{

    @HttpPost
    global static Container doPost(){
        RestRequest req = RestContext.request;
        String Recipients_EmailID = req.params.get('Recipients_EmailID');
        String TotalRecords = req.params.get('TotalRecords');
        String TotalFailedRecords = req.params.get('TotalFailedRecords');
        String TotalSuccessRecords = req.params.get('TotalSuccessRecords');
        String CSVName = req.params.get('CSVName');
        system.debug(Recipients_EmailID+'   **** '+CSVName );
        Blob jSONRequestBody=req.requestBody; 
        system.debug('$$$$$ '+jSONRequestBody);
        
        LIST<String> AdditionalEmailIds;
        Container ct=new Container();
        try{ 
            String finalstr = String.valueOf(jSONRequestBody);    
            system.debug('***** '+finalstr);
            String strUrlUTF8 = jSONRequestBody.toString();
            System.debug('String strUrlUTF8: [' + strUrlUTF8 + ']');

            String strOriginal = EncodingUtil.urlDecode(strUrlUTF8, 'UTF-8');
          
            // String strOriginal = 'First Name,Last Name,Email Id,Phone,Company,Address,City,State,Zip Code,Ticket Name,Ticket Price,Ticket Quantity,Payment Status,Sold Quantity,Payment Type,Seat Numbers\n"Yakaira","","yinoa@rmtechn3456ologies.com","","","","","","","gold pass","120","20","Paid","3","cash","qw"\n"","Hall","ahall@h2hassoc345iates.com","","","161 Worcester road","Framingham","Massachusetts","1234","admin pass","111","1","paid","1","cash",""\n"Andrew","Sogolow","","1234512345","tcs","88 Howard St","New London","Connecticut","123123","","","","","","",""\n"     ","","","","","","","","","","","","","","",""\n';
            system.debug('&&&& '+strOriginal);
            String stru = String.valueOf(strOriginal);
            //String stru ='First Name,Last Name,Email Id,Phone,Company,Address,City,State,Zip Code,Ticket Name,Ticket Price,Ticket Quantity,Payment Status,Sold Quantity,Payment Type,Seat Numbers\n"Yakaira","","yinoa@rmtechn3456ologies.com","","","","","","","gold pass","120","20","Paid","3","cash","qw"\n"","Hall","ahall@h2hassoc345iates.com","","","161 Worcester road","Framingham","Massachusetts","1234","admin pass","111","1","paid","1","cash",""\n"Andrew","Sogolow","","1234512345","tcs","88 Howard St","New London","Connecticut","123123","","","","","","",""\n"     ","","","","","","","","","","","","","","",""\n';
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(strOriginal);
            
            string csvname1= CSVName;
            csvAttc.setFileName(csvname1);
            csvAttc.setBody(csvBlob);
            // csvAttc.setBody(jSONRequestBody);
            
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();

            OrgWideEmailAddress[] owea = [SELECT Id FROM OrgWideEmailAddress WHERE Address=: 'support@boothleads.com' LIMIT 1];
            if(owea.size() > 0){
                email.setOrgWideEmailAddressId(owea.get(0).Id);
            } 
            
            String[] toAddresses = new String[]{};
            AdditionalEmailIds = new LIST<String>();
            AdditionalEmailIds = Recipients_EmailID.split(',',0);
            system.debug(AdditionalEmailIds.size()+'  EMAIL IDS '+AdditionalEmailIds);
            LIST<User> LastNamesList= new LIST<User>();
            LastNamesList= [SELECT ID, LastName FROM USER WHERE UserName IN :AdditionalEmailIds];
            String UserLastName;
            system.debug(LastNamesList.size()+'  LAST NAMES '+LastNamesList);            
            if(LastNamesList.size() >0){
                UserLastName= LastNamesList[0].LastName;
            }
            system.debug(UserLastName+'  LAST NAME FROM QUERY '+LastNamesList);            
            toAddresses.addAll(AdditionalEmailIds);
            email.setReplyTo('support@boothleads.com');
            email.setSubject('Import Attendees Summary');
            email.setToAddresses(toAddresses);
            email.setHTMLBody('Hello ' + UserLastName+' ,' + + '<br/>' + '' + '<br/>' +
                 'Scan Attendee App has just completed your import process!' + '<br/>' +'<br/>' +
                 'Number of records imported: '+TotalRecords+'<br/>'+
                 'Number of records inserted: '+TotalSuccessRecords+'<br/>'+
                 'Number of records failed: '+TotalFailedRecords+'<br/>'+'<br/>'+
                 'Please check the attached file for the failed records.'+'<br/>'+
                 'We strongly recommend that you check a few of your imported records to verify that your information was imported as expected.'+'<br/>'+'<br/>'+
                 'If you have any further questions, please contact Scan Attendee.'+'<br/>'+'<br/>'+
                 'Best Wishes!'+'<br/>'+
                 'Scan Attendee Customer support'+'<br/>'+
                 +'<a>'+'support@boothleads.com.'+'</a>'+'<br/>'+
                 'Phone: 1-(800)-492-1289.');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            system.debug('***** '+r);
            ct.Message='Success';
        }
        catch(Exception e){
            ct.Error=e.getMessage();
        }
        return ct; 
    }
    
    global class Container{
        public String Message{get;set;}
        public String Error{get;set;}
        public Container(){ 
        }
    }
}
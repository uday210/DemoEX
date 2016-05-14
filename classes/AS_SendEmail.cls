@RestResource(urlMapping='/AS_SendEmail/*')
  
global with sharing class AS_SendEmail{

    @HttpGet
    global static Container doGet(){
        RestRequest req = RestContext.request;
        String Sender_EmailID = req.params.get('Sender_EmailID');
        String Recipients_EmailID = req.params.get('Recipients_EmailID');
        LIST<String> AdditionalEmailIds;
        Container ct=new Container();
        try{ 
            string header = 'First Name,Last Name,Email Id,Phone,Company, Job Title, Attendee Category, Address,City,State,Zip Code \n';
            string recordString = '"John","Smith","johnsmith@gmail.com","8978456789","Acme Corp","Business Manager","Attendee","105 Vanderbilt Ave.","Central Islip","NY","11722"';
            //,"Full Conference","100","250","Paid","2","Credit Card","A1,B1"\n"Mark","Waugh","markwaugh@gmail.com","8897845698","Globalnest","127 West 135 Street","New York","NY","10030","VIP Pass","2500","500","Paid","3","Check","B2,C3"';
            string finalstr = header+recordString;


         //   finalstr = finalstr +recordString;

            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            string csvname= 'AttendeesSample.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            
            OrgWideEmailAddress[] owea = [SELECT Id FROM OrgWideEmailAddress WHERE Address=: Sender_EmailID];
            OrgWideEmailAddress[] owe = [SELECT Id FROM OrgWideEmailAddress WHERE Address=: 'support@boothleads.com' LIMIT 1];
            if(owea.size() > 0){
                email.setOrgWideEmailAddressId(owea.get(0).Id);
            } 
            else{
                email.setOrgWideEmailAddressId(owe.get(0).Id);
            }
            
            String[] toAddresses = new String[]{};
            AdditionalEmailIds = new LIST<String>();
            AdditionalEmailIds = Recipients_EmailID.split(',',0);
            toAddresses.addAll(AdditionalEmailIds);
            String subject ='Scan Attendee: Sample CSV';
            email.setSubject(subject);
            email.setToAddresses(toAddresses);
            email.setHTMLBody('Hello ' + ' ,' + + '<br/>' + '' + '<br/>' +
                 'Thank you for using the Scan Attendee app from Boothleads.' + '<br/>' +'<br/>' +
                 'Attached is a sample CSV to import Attendees for the Scan Attendee application.' + '<br/>' +
                 'Fields from 4 to 11 are optional.'+ '<br/>'+'<br/>'+
                 '1. First Name (required)'+'<br/>'+
                 '2. Last Name (required)'+'<br/>'+
                 '3. Email Id (required)'+'<br/>'+
                 '4. Phone (optional)'+'<br/>'+
                 '5. Company (optional)'+'<br/>'+
                 '6. Job Title (optional)'+'<br/>'+
                 '7. Attendee Category(optional) (example: Attendee, exhibitor, Sponsor etc. to show on the badge)'+'<br/>'+                 
                 '8. Address(optional)'+'<br/>'+
                 '9. City (optional)'+'<br/>'+                 
                 '10. State (optional)'+'<br/>'+
                 '11. Zip Code (optional)'+'<br/>'+'<br/>'+
                 '<b>' +'Note :'+'<br/>'+'<br/>'+
                 '1. File needs to be in the CSV format. Please add the data and save the file in Dropbox to import into the Scan Attendee app.'+'<br/>'+'<br/>'+
                 '2. The order of the columns is not important, but column names are important.'+'<br/>'+'<br/>'+
                 '3. Columns names is not case sensitive.'+'<br/>'+'<br/>'+
                 '4. The CSV file will be processed from Top to Bottom.'+'<br/>'+'<br/>'+                 
                 '5. If two records have the same email ids, then the two records will be grouped in to one record with 2 attendees and data will be updated with the last record.'+'<br/>'+ '<br/>'+                
                 +'</b>'+'<br/>'+'<br/>'+
                 'If you have any further questions, please contact Scan Attendee.'+'<br/>'+'<br/>'+
                 'Best Wishes!'+'<br/>'+
                 'Scan Attendee Customer support'+'<br/>'+
                 +'<a>'+'support@boothleads.com.'+'</a>'+'<br/>'+
                 'Phone: 1-(800)-492-1289.');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
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
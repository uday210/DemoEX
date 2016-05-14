/**
* @author :Sai Kumar.D
* @date : April 15, 2016
* @ This class is used to send emails either from Salesforce or Post Mark App
*/ 

global without sharing class Bln_SendEmailPost{

public  Bln_SendEmailPost(){ 
}

// This Method is used to Send email from Non batch class via PostMarkApp
@Future(callout = true)
Public static void Emailfromsupport(string Fromemail,list<string> Toemail,string emailsubject,string template,String Attachment,String Contentbody,String ContentType){
string token = 'e37f03f2-57ef-41e9-9501-a9cb5ac699cc';

string commaSepratedtolist = '';

for(String strc : Toemail)
{
 commaSepratedtolist += strc + ',' ;
}

system.debug('commaSepratedtolist ===================================='+commaSepratedtolist);
system.debug('Fromemail===='+Fromemail+'Toemail==='+Toemail+'emailsubject====='+emailsubject+'template===='+template);

        JSONGenerator gn = JSON.createGenerator(true);  
        gn.writeStartObject();               
        gn.writeStringField('From',Fromemail);   
        gn.writeStringField('To',commaSepratedtolist); 
        gn.writeStringField('Subject',emailsubject); 
        gn.writeStringField('HtmlBody',template);
        if(Attachment != ''){
        gn.writeFieldName('Attachments'); 
        gn.writeStartArray();
        gn.writeStartObject();
        gn.writeStringField('Name',Attachment); 
        gn.writeStringField('Content',Contentbody); 
        gn.writeStringField('ContentType',ContentType); 
        gn.writeEndObject();
        gn.writeEndArray();
        }
        gn.writeEndObject();   

        String Emailstring= gn.getAsString();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://api.postmarkapp.com/email');
        req.setMethod('POST');
        req.setHeader('Accept','application/json');
        req.setHeader('Content-Type','application/json');
        req.setHeader('X-Postmark-Server-Token',token);
        req.setBody(Emailstring);
        
        res = http1.send(req);
        string str = res.getbody();
        system.debug('str=============================='+str);

   }

// This Method is used to Send email from batch class via PostMarkApp   
Public static void Emailfrombacthclass(string Fromemail,list<string> Toemail,string emailsubject,string template,String Attachment,String Contentbody,String ContentType){
string token = 'e37f03f2-57ef-41e9-9501-a9cb5ac699cc';

string commaSepratedtolist = '';

for(String strc : Toemail)
{
 commaSepratedtolist += strc + ',' ;
}

system.debug('commaSepratedtolist ===================================='+commaSepratedtolist);
system.debug('Fromemail===='+Fromemail+'Toemail==='+Toemail+'emailsubject====='+emailsubject+'template===='+template);

        JSONGenerator gn = JSON.createGenerator(true);  
        gn.writeStartObject();               
        gn.writeStringField('From',Fromemail);   
        gn.writeStringField('To',commaSepratedtolist); 
        gn.writeStringField('Subject',emailsubject); 
        gn.writeStringField('HtmlBody',template); 
        if(Contentbody !=''){
        gn.writeFieldName('Attachments'); 
        gn.writeStartArray();
        gn.writeStartObject();
        gn.writeStringField('Name',Attachment); 
        gn.writeStringField('Content',Contentbody); 
        gn.writeStringField('ContentType',ContentType); 
        gn.writeEndObject();   
        gn.writeEndArray();
        }
        gn.writeEndObject();   

        String Emailstring= gn.getAsString();
        system.debug('%%%%Emailstring'+Emailstring);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://api.postmarkapp.com/email');
        req.setMethod('POST');
        req.setHeader('Accept','application/json');
        req.setHeader('Content-Type','application/json');
        req.setHeader('X-Postmark-Server-Token',token);
        req.setBody(Emailstring);
        
        res = http1.send(req);
        string str = res.getbody();
        system.debug('str=============================='+str);

   }
   
// This Method is used to Send email from Non batch class via Salesforce   
   @Future(callout = true)
Public static void Emailfromsalesforce(String Fromemail,list<string> Toemail,string emailsubject,string template,String Attachment,String Contentbody,String ContentType){
string token = 'e37f03f2-57ef-41e9-9501-a9cb5ac699cc';

string commaSepratedtolist = '';

for(String strc : Toemail)
{
 commaSepratedtolist += strc + ',' ;
}
 try{
 
      List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();

      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      
 if(Attachment != ''){
               Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
                  
                blob csvBlob = Blob.valueOf(Contentbody);          
                csvAttc.setFileName(Attachment);
                csvAttc.setBody(csvBlob);
                mail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
             }    
                                             
                 mail.setOrgWideEmailAddressId(Fromemail);
                            
                 mail.setToAddresses(Toemail);
                
                // mail.setReplyTo(Fromemail);
    
                 mail.setSubject(emailsubject);

                 mail.setHtmlBody(template);
                 
                EmailsList.add(mail); 
                if(EmailsList.size()>0){
                
                    Messaging.sendEmail(EmailsList);
                }
                                                           
                 }catch(Exception e){}
   

   }
 
// This Method is used to Send email from batch class via Salesforce  
   Public static void EmailfromsalesforceBatch(string Fromemail,list<string> Toemail,string emailsubject,string template,String Attachment,String Contentbody,String ContentType){
string token = 'e37f03f2-57ef-41e9-9501-a9cb5ac699cc';

string commaSepratedtolist = '';

for(String strc : Toemail)
{
 commaSepratedtolist += strc + ',' ;
}

 try{
      Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
      if(Contentbody !=''){            
                blob csvBlob = Blob.valueOf(Contentbody);          
                csvAttc.setFileName(Attachment);
                csvAttc.setBody(csvBlob);
      }                                       
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                 mail.setOrgWideEmailAddressId(Fromemail);
                            
                 mail.setToAddresses(Toemail);
               
                // mail.setReplyTo(Fromemail);
                mail.setReplyTo('support@eventdex.com');
    
                 mail.setSubject(emailsubject);

                 mail.setHtmlBody(template);
              if(Contentbody !=''){                 
                 mail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
              }   
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 
                 }catch(Exception e){}
   

   }
   
}
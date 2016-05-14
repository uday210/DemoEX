trigger SignUpEmail on User (after Insert,after update) {

EmailTemplate Email_Template= new EmailTemplate();
Email_Template= [SELECT Name, Body,Subject,HtmlValue,Markup from EmailTemplate Where Name =: 'Welcome Template'];
OrgWideEmailAddress Org = [select id from OrgWideEmailAddress Limit 1];
boolean isoldValuefalse =true;
SET<id> userids = new Set<id>();
system.debug('****************88'+Trigger.old);
try{
for(User U :Trigger.old){
system.debug('****************22'+U);
if(U.isSignup__c != null){
system.debug('****************21111111112'+U);
 isoldValuefalse = U.isSignup__c;
 }
 system.debug('****************20000000'+isoldValuefalse );
}
}
Catch(exception e){
}

if(isoldValuefalse==false){
if(trigger.isInsert){
for(User U:Trigger.New){
system.debug('    SELECTED TEMPLATE IN INSERT '+Email_Template);
if(U.isSignup__c == True){

String EmailTem = Email_Template.HtmlValue;
String EmailTem1= EmailTem .Replace('{!Name}',U.FirstName+' '+U.LastName);

system.debug('6666 666666 666666'+U.UserName);

Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();

string [] toAddresses = new string[]
                 {
                     U.UserName
                 };
singleEmail.setHtmlBody(EmailTem1);
singleEmail.setToAddresses(toAddresses);
singleEmail.setSubject(Email_Template .Subject);
singleEmail.setOrgWideEmailAddressId(Org.id);
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { singleEmail }); 
}

}
}
if(trigger.isUpdate){
for(User U:Trigger.New){

system.debug('    SELECTED TEMPLATE IN UPDATE  '+Email_Template);
User  OldUser  = Trigger.oldMap.get(U.Id);
system.debug('************************************'+OldUser.isSignup__c+'###############'+  U.isSignup__c  );
    if (OldUser.isSignup__c == False && U.isSignup__c == True) {
      String EmailTem = Email_Template.HtmlValue.Replace('{!Name}',U.FirstName+' '+U.LastName);

system.debug('6666 666666 666666'+U.UserName);

Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();

string [] toAddresses = new string[]
                 {
                     U.UserName
                 };
singleEmail.setHtmlBody(EmailTem);
singleEmail.setToAddresses(toAddresses);
singleEmail .setSubject(Email_Template.Subject);
singleEmail.setOrgWideEmailAddressId(Org.id);
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { singleEmail }); 
}

  }
    }
   } 
}
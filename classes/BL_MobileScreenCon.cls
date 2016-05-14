public with sharing class BL_MobileScreenCon {

public string boothId{get;set;}
public string boothEId {get;set;}
public Booth__c bg{get;set;}

Public Pagereference login1(){ 
 boothId =ApexPages.currentPage().getParameters().get('Id');
 boothEId =ApexPages.currentPage().getParameters().get('EId');
 system.debug('************************'+boothEId );
  bg =[select BT_Name__c from Booth__c where id=:boothId]; 
  QueryContactInformation();
  return null;    
}

public List<Booth_Qrcode__c> totalRecords{get;set;}
public List<Booth_Qrcode__c> forUrlType{get;set;}
public List<string> forContactType{get;set;}
public List<Booth_Qrcode__c> forPdfType{get;set;}



public pageReference QueryContactInformation(){
 String userAgent = ApexPages.currentPage().getHeaders().get('User-Agent');
 
 
system.debug('22222222222222222 '+boothEId);
system.debug('444444444444444 '+boothId);

totalRecords = new List<Booth_Qrcode__c>();
forUrlType= new List<Booth_Qrcode__c>();
forPdfType= new List<Booth_Qrcode__c>();
 inn = new List<innercls>();

//Booth_Qrcode__c testmallik = [SELECT ID, NAME FROM Booth_Qrcode__c WHERE  ]

totalRecords = [select id,Address__c,Address_2__c,Booth__c,City__c,Company__c,Country__c,Email_Address__c,
                Data_Types__c,Link_LabelName__c,Name__c,Phone_number__c,Pin_code__c,POBox__c,Registration_Link__c,
                State__c,Title__c,Website_URL__c, (select id,name from Booth_Qrcode__c.attachments) 
                from Booth_Qrcode__c where Booth__c=:boothId   and Event__c=:boothEId];
string iphone;
string android;
for(Booth_Qrcode__c b:totalRecords ){

if(b.Data_Types__c=='Contact Information'){
 for(attachment d:b.attachments){
    if(d.name=='iphonecontact.ics'){
      iphone =string.valueOf(d.id);
      system.debug('999999999999999999999999  '+iphone);
    }else if(d.name=='Android.vcf'){
     android =string.valueOf(d.id);
      system.debug('8888888888888888888 '+android );
    }
  }

 if(userAgent.contains('iPhone')){
 system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii '+iphone);
  inn.add(new innercls(iphone,b));
 }else{
  system.debug('555555555555555555555555 '+android);
 inn.add(new innercls(android,b));
 }

}
if(b.Data_Types__c=='Registration Link'){
forUrlType.add(b);
}
if(b.Data_Types__c=='Company Broacher'){
forPdfType.add(b);
}
}
return null;
}

public List<innercls> inn{get;set;}
public class innercls{
public string str{get;set;}
public Booth_Qrcode__c strobj{get;set;}
public innercls(string s,Booth_Qrcode__c v){
this.str=s;
this.strobj=v;
}

}


Public String Name{get;set;} 
Public String EmailAddress{get;set;} 
Public String Phonenumber{get;set;}
public boolean intren{get;set;}
public list<string> email{get;set;}
public list<User_Profile_Event__c> upeve{get;set;}

public void interested()
 {
 intren=true;
 }


public void send()
{
 upeve = new list<User_Profile_Event__c>();
 system.debug(' **************'+Name+'!!!!!!!!!'+EmailAddress+'$$$$$$$$'+Phonenumber+'$$$$ $$$$$$$$$$$ $$$$$$$$$$$$'+BoothId+'%%%%%%%%%%%%%%%'+boothEId );
 upeve=[select User_id__r.Username,User_id__r.Name from User_Profile_Event__c where BT_id__c=:boothId   and EV_id__c=:boothEId ]; 
 system.debug(' **************'+upeve);
  
  for(User_Profile_Event__c i:upeve)
  {  
  Messaging.singleEmailMessage Mail = new Messaging.singleEmailMessage();   
     String Information = 'Hello' +  '&nbsp;&nbsp;' + i.User_id__r.Name + '<br/>'+ 'Please find the details of attendee who is interested' + '<br/><br/>'+'Name:' + Name+ '<br/>'+'Email:' + EmailAddress +'<br/>'+'Phone:' + Phonenumber;
     String Body = 'Who are Interested?';
  // email.add(i.User_id__r.Username);
   String[] toAddress = new  String[]{i.User_id__r.UserName};  
   Mail.setHtmlBody(Information);   
   Mail.setToAddresses(toAddress);
   Mail.setPlainTextBody(Body );
   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+Mail);
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
  }
  
  intren=false;
 
  
  
}

public void cancel()
{
intren=false;
}





}
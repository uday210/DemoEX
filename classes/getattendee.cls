@RestResource(urlMapping='/getattendeeforRegistration/*')

 global without sharing class getattendee{
 
  
  
  @HttpGet
  global static List<innercls> doGet(){
  
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  
  string userName= req.params.get('UserName');
  string eventId =req.params.get('EventId');
  List<innercls> allinnsers = new List<innercls>();
  
  
  List<Event_Attendee_Mapping__c> EAm = new List<Event_Attendee_Mapping__c>();
  EAm =[select  EA_AttendeeBarcode__c,AS_id__c, AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Company__c,AS_id__r.AS_Title__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:UserName and EV_id__c=:EventId limit 1];
  if(EAm.size() <=0){
   innercls inn = new innercls('NO Records Found');
   allinnsers.add(inn);
  }
  
  
  for(Event_Attendee_Mapping__c AttaSummary:EAm){
    innercls inn = new innercls(AttaSummary.AS_id__r.AS_FirstName__c,AttaSummary.AS_id__r.AS_LastName__c,AttaSummary.AS_id__r.AS_Email__c,AttaSummary.AS_id__r.AS_Company__c,AttaSummary.AS_id__r.AS_WorkPhone__c,AttaSummary.AS_id__r.AS_Title__c,AttaSummary.EA_AttendeeBarcode__c);
    system.debug('2222222222222222 '+AttaSummary.AS_id__r.AS_Title__c);
     allinnsers.add(inn);
  }  
  
  return allinnsers;
 }
 
 
 global class innercls{
 
 string FirstName;
 string LastName;
 string Email;
 string Company;
 string Phone;
 string Title;
 string Error;
 string BadgeBarcode;     
 
public innercls(string fn,string ln,string em,string com,string ph,string title,string barcode){
  this.FirstName=fn;
  this.LastName=ln;
  this.Email=em;
  this.Company=com;
  this.Phone=ph;
 this.Title=title;
 system.debug('33333333333333 '+ this.title);
  this.BadgeBarcode=barcode;
 } 
 public innercls(string str){
 Error =str;
 }
 
 }
  


}
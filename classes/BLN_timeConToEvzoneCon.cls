public with sharing class BLN_timeConToEvzoneCon {
 public DateTime dateTimeValue{get;set;}
 public string tZone{get;set;}
 public String format{get;set;}
 //Converting to Event time zone
 public string getTimeZoneValue(){
     if(format!=null && format!=''){ 
         return dateTimeValue.format(format, tZone);
     }else if(tZone!=null && tZone!='' && null!=dateTimeValue){
         system.debug('Time Zone Values '+tZone +'PPPPP '+dateTimeValue);
         return dateTimeValue.format('MMMM d,  yyyy h:mm a', tZone); 
     }else{
         return null;
     }
 }
  public DateTime getDateBasedOnEventTimeZone(String customerDateStringparam, String EventId) {
 //Get the date whta user enter as datetime.parse always parse with local usertimezone
  system.debug('customerDateTimeString=========='+customerDateStringparam);
 DateTime dt = DateTime.parse(customerDateStringparam);
         User u=[select id,name,TimeZoneSidKey,LocaleSidKey,email from User where id=:UserInfo.getUserId()];
  String customerDateTimeString = dt.format('yyyy-MM-dd HH:mm:ss',u.TimeZoneSidKey);
  
  //Set the timzezone of the date based on Event Timezone instead of user
  DateTime customerDateTime = DateTime.valueofGmt(customerDateTimeString);
  //Get Event TimeZone
  string customerTimeZoneSidId;
  try{
 BLN_Event__c eve=[select id,name,Time_Zone__c  from BLN_Event__c where id=:EventId];
customerTimeZoneSidId = eve.Time_Zone__c ;
    } catch (Exception e) {
 customerTimeZoneSidId = EventId; 
}
TimeZone customerTimeZone = TimeZone.getTimeZone(customerTimeZoneSidId);
integer offsetToCustomersTimeZone = customerTimeZone.getOffset(customerDateTime);
System.debug('offsetToCustomersTimeZone '+offsetToCustomersTimeZone );

string customerTimeZoneSidId1 = 'GMT';
TimeZone tz= TimeZone.getTimeZone(customerTimeZoneSidId1);
integer offsetToUserTimeZone = tz.getOffset(customerDateTime);
System.debug('offsetToUserTimeZone '+offsetToUserTimeZone );
integer correction = offsetToUserTimeZone - offsetToCustomersTimeZone;
DateTime correctedDateTime = customerDateTime.addMinutes(correction / (1000 * 60));
return correctedDateTime ;
  
  
}
  public DateTime getDateBasedOnEventTimeZone(String customerDateStringparam, String usertimezone, String eventtimezone) {
 //Get the date whta user enter as datetime.parse always parse with local usertimezone
  system.debug('customerDateTimeString=========='+customerDateStringparam);
 DateTime dt = DateTime.parse(customerDateStringparam);
         //User u=[select id,name,TimeZoneSidKey,LocaleSidKey,email from User where id=:UserInfo.getUserId()];
  String customerDateTimeString = dt.format('yyyy-MM-dd HH:mm:ss',usertimezone);
  
  //Set the timzezone of the date based on Event Timezone instead of user
  DateTime customerDateTime = DateTime.valueofGmt(customerDateTimeString);
  //Get Event TimeZone
  string customerTimeZoneSidId=eventtimezone;
 
TimeZone customerTimeZone = TimeZone.getTimeZone(customerTimeZoneSidId);
integer offsetToCustomersTimeZone = customerTimeZone.getOffset(customerDateTime);
System.debug('offsetToCustomersTimeZone '+offsetToCustomersTimeZone );

string customerTimeZoneSidId1 = 'GMT';
TimeZone tz= TimeZone.getTimeZone(customerTimeZoneSidId1);
integer offsetToUserTimeZone = tz.getOffset(customerDateTime);
System.debug('offsetToUserTimeZone '+offsetToUserTimeZone );
integer correction = offsetToUserTimeZone - offsetToCustomersTimeZone;
DateTime correctedDateTime = customerDateTime.addMinutes(correction / (1000 * 60));
return correctedDateTime ;
  }
// By Phani 
public  DateTime getEventTimeZone(String customerDateStringparam,String etimezone,String userTimezone){
  //Get the date whta user enter as datetime.parse always parse with local usertimezone
  system.debug('customerDateTimeString=========='+customerDateStringparam);
  DateTime dt = DateTime.parse(customerDateStringparam);
  String customerDateTimeString = dt.format('yyyy-MM-dd HH:mm:ss',userTimezone);
  
   //Set the timzezone of the date based on Event Timezone instead of user
    DateTime customerDateTime = DateTime.valueofGmt(customerDateTimeString);
    //Get Event TimeZone
    string customerTimeZoneSidId =etimezone ;
   TimeZone customerTimeZone = TimeZone.getTimeZone(customerTimeZoneSidId);
  integer offsetToCustomersTimeZone = customerTimeZone.getOffset(customerDateTime);
  System.debug('offsetToCustomersTimeZone '+offsetToCustomersTimeZone );
  
  string customerTimeZoneSidId1 = 'GMT';
  TimeZone tz= TimeZone.getTimeZone(customerTimeZoneSidId1);
  integer offsetToUserTimeZone = tz.getOffset(customerDateTime);
  System.debug('offsetToUserTimeZone '+offsetToUserTimeZone );
  integer correction = offsetToUserTimeZone - offsetToCustomersTimeZone;
  DateTime correctedDateTime = customerDateTime.addMinutes(correction / (1000 * 60));
  return correctedDateTime ;
}

}
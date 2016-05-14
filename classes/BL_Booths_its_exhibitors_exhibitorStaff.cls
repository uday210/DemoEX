public without sharing class BL_Booths_its_exhibitors_exhibitorStaff {
 public string EventId{get;set;}
 public List<inncls> inn{get;set;}
 
 
 public BL_Booths_its_exhibitors_exhibitorStaff(){
 inn = new List<inncls>();
   EventId =Apexpages.currentpage().getParameters().get('Event');

   List<User_Profile_Event__c> boothsIds= new List<User_Profile_Event__c>();

   boothsIds = [SELECT id,BT_id__r.id,BT_id__r.BT_Name__c,BT_id__c,Profile_id__c,Profile_id__r.PR_Name__c,User_id__c, User_id__r.userName,User_id__r.Name,Attendee_Summary__r.AS_Company__C from User_Profile_Event__c where EV_id__c=:EventId and (Profile_id__r.PR_Name__c='BoothAdmin' Or Profile_id__r.PR_Name__c='BoothPersonnel') ]; 
  SET<id> boothIds = new SET<id>();
  
  
  for(User_Profile_Event__c upe:boothsIds){
    boothIds.add(upe.BT_id__c);
  }
  
  integer j=1;
    for(Booth__c booth :[SELECT id,BT_Name__c from Booth__c where id IN :boothIds order by BT_Name__c]){
     List<User_Profile_Event__c> users= new List<User_Profile_Event__c>();
      
      for(User_Profile_Event__c upes:boothsIds){
        if(upes.BT_id__r.id==booth.id ){
        users.add(upes);
       }
      }
      inn.add(new Inncls(booth,users,j));
      j++;
    }
 }

public class inncls{
public Booth__c booths{get;set;}
public List<User_Profile_Event__c> upeInns{get;set;}
public integer i{get;set;}
public inncls(Booth__c bo,List<User_Profile_Event__c> up,integer g){
this.i=g;
this.booths =bo;
this.upeInns =up;
}


}




}
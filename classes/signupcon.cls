public without sharing class signupcon {

public List<inncls> upelist{get;set;}
public Event__c event {get;set;}
public string selectedEvent {get;set;}




public signupcon()
{
    selectedEvent =Apexpages.currentPage().getparameters().get('id');
    
    system.debug(' GGGGGG GGGGGGGGGGGGGG GGGGGGGGGGG'+selectedEvent );
    
    upelist =new List<inncls >();
    integer g =1;
    for(User_Profile_Event__c uy: [Select User_id__r.Password__c,id,User_id__r.Name,User_id__r.Email, User_id__r.isSignup__c,Attendee_Summary__r.AS_Company__c,User_id__r.Companyphone__c ,LastmodifiedDate,Profile_id__r.PR_Name__c
               from User_Profile_Event__c   
               where EV_id__r.id =:selectedEvent 
               ORDER BY User_id__r.isSignup__c DESC , LastmodifiedDate  ]){
               upelist.add(new inncls (g,uy));
               g++;
              }
               
}

public class inncls {
 public User_Profile_Event__c up{get;set;}
 public integer i{get;set;}
 public inncls(integer f,User_Profile_Event__c hg){
 this.i=f;
 this.up=hg;
 }
}




}
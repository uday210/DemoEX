public with sharing class waitList {

    public list<User_Profile_Event__c> listofstaff {get;set;}
    public string SelectEvent {get; set;}
    public Event__c attach{get;set;}

    public waitList(){
     try{
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
          
            SelectEvent = k.getValue();
    listofstaff = new list<User_Profile_Event__c> ();
    
    listofstaff = [select Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_WorkPhone__c from User_Profile_Event__c
                             where EV_id__r.id =: SelectEvent AND
                             IsMatchMakingUser__c =: true AND 
                             Profile_id__r.PR_Name__c ='WaitingList'];
     
      attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c from Event__c where id = : SelectEvent ];
       }catch(Exception e){}
    }


}
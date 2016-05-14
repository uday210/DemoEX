public with sharing class corporatestaff {
    
    public list<User_Profile_Event__c> listofstaff {get;set;}
    public string SelectEvent {get; set;}
    public Event__c attach{get;set;}
public string exhibitoralias {get ; set ;}
public string attendeealias {get ; set ;}
 public list<Tags__c> tagslist {get; set ;}
    public corporatestaff(){
     exhibitoralias ='';
     attendeealias ='';
     try{
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
          
            SelectEvent = k.getValue();
    listofstaff = new list<User_Profile_Event__c> ();
    
    listofstaff = [select Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_WorkPhone__c from User_Profile_Event__c
                             where EV_id__r.id =: SelectEvent AND
                             IsMatchMakingUser__c =: true AND 
                             Profile_id__r.PR_Name__c ='CorporateStaff'];
     
      attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c from Event__c where id = : SelectEvent ];
       }catch(Exception e){}
       
       tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : SelectEvent];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
    }



}
}
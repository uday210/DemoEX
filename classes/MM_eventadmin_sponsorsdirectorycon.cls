public with sharing class MM_eventadmin_sponsorsdirectorycon {
    public list < Event_Attendee_Mapping__c > eventlist {get;set;}
    public string eventselected {get;set;}
    public Event__c attach{get;set;}
    public string exhibitoralias {get ; set ;}
public string attendeealias {get ; set ;}
 public list<Tags__c> tagslist {get; set ;}
     public String sortField {
    get  { if (sortField == null) {sortField = 'AS_id__r.AS_LastName__c'; } return sortField;  }
    set;
    }
    public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
    }
    public string selectedapp {get;set;}
    public list<selectoption> apps {get;set;}
    
    public MM_eventadmin_sponsorsdirectorycon() {
    
    eventSelected ='';
     exhibitoralias ='';
     attendeealias ='';
    apps = new list<selectoption> ();
    apps.add(new selectoption('Match Leads','Match Leads'));
    apps.add(new selectoption('Booth Leads','Booth Leads'));
    selectedapp = 'Match Leads';
   try{
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
    eventSelected = k.getValue();
    eventlist = new list < Event_Attendee_Mapping__c > ();
    string eventQuery ='select id,CreatedDate,Attendee_Types__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =  true  AND Boothleads_Profile__c =\''+'Sponsor'+'\' AND EV_id__r.id = \''+eventSelected +'\'  ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
    eventlist = dataBase.Query(eventQuery );
    
    system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeee'+eventlist );
    
    attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c from Event__c where id = : eventSelected];
    }catch (exception e) {}
    
    tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventSelected];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
    }
    }
    public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
 
  }
}
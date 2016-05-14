public with sharing class emailbadges {
public string x{get;set;}
public boolean logo{get;set;}
public attachment attach{get;set;}
public Event_Attendee_Mapping__c details{get;set;}

public emailbadges()
{
x =ApexPages.currentPage().getParameters().get('id');
system.debug('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'+x);
details=[select AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,
               AS_id__r.AS_Company__c,EV_id__c,  EA_AttendeeBarcode__c,Ev_Id__r.id,
               Ev_Id__r.Ev_title__c,Ev_Id__r.EV_StartDate__c,Ev_Id__r.StartTime__c,
               Ev_Id__r.EV_EndDate__c,Ev_Id__r.EV_EndTime__c,Ev_Id__r.EV_HostingLocation__c
               from Event_Attendee_Mapping__c where EA_AttendeeBarcode__c =: x ];
system.debug('dddddddddddddddddddddddddddddddddddddddddddd'+details);
   try{
          attach=[select parentid,name from attachment where parentid =:details.Ev_Id__r.id];
          logo=true;
          }
          catch(exception e){
          logo=false;
          }
}
static testMethod void testrest(){
PageReference pageRef = Page.Qrcode_EmailBadgeToAttendees;
    Test.setCurrentPage(pageRef);
    
        
  
     Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;
      AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
  Event_Attendee_Mapping__c eam =new Event_Attendee_Mapping__c(AS_id__c=attSummary.Id,Ev_Id__c=eve.id);
  insert eam;
  

eam.EA_AttendeeBarcode__c=eam.id+'-'+eve.id;

update eam;
ApexPages.currentPage().getParameters().put('id', eam.id+'-'+eve.id);
   emailbadges ebadge=new emailbadges();


} 



}
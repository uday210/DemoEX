@istest

public class Test_BL_ChengeBadgeTypeCon
{
  static testmethod void Testm()
  {
    Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2020'),
                             EV_StartDate__c = Date.Parse('01/18/2020'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM',
                             EV_Publish__c=TRUE,
                             Attendee_Types__c ='Exhibitor' );
    insert eve;
 AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='test',AS_LastName__c='boothadmin',AS_Email__c='123booth@noemail.com');
 insert attSummary;
  
   Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
   eam.AS_id__c =attSummary.id; 
   eam.EV_id__c  = eve.id;   
  dataBase.insert(eam,false);    
      
    PageReference pageRef = Page.BL_ChengeBadgeType;
    Test.setCurrentPage(pageRef);
    ApexPages.currentPage().getParameters().put('id', eve.Id);
    
    BL_ChengeBadgeTypeCon BLAtt = new BL_ChengeBadgeTypeCon();
    BLAtt.insertValues();
  
  }
}
@isTest

public class Test_AllEventsCon{ 
  
  static testMethod void Test_AllEventsCon() {
  
  Profile w = [select id from profile where name='Standard User'];
  
  User u = new User(alias = 'st1020', email='tesnt1213fl@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='tesnt1213fl@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;
  
  Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.valueOf('2016-06-01'),
                             EV_StartDate__c = Date.valueOf('2016-06-01'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM',
                             Is_MatchMaking_Event__c=true,
                              is_Live_Event__c = true
                             );
      insert eve;
      Id EventId=eve.Id;
      
      AllEventsCon Allec= new AllEventsCon();
      BL_EventsList_DAO BLDAO = new BL_EventsList_DAO();
      Allec.AllEvents();
      BLDAO.GetAllEvents();
  
  }
  
  }
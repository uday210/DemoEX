@istest
private class Test_AS_EventInfo{

    static testMethod void testAS_EventInfo() {
    
        account a=new account(name='govtnm3');
        insert a;
        
        contact c=new contact(lastname='n',accountid = a.id);
        insert c;
        
        Profile p = [select Id,Name FROM profile where name='Event Admin'];
        Profile__c profilecus = new Profile__c(PR_Name__c ='EventAdmin');
        insert profilecus;
    
        User u = new User(alias = 'test123', email = 'event@gmail.com',emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US',localesidkey = 'en_US', country = 'United States',timezonesidkey = 'America/Los_Angeles', username = 'event@gmail.com',Password__c='1',isactive=true,ContactID = c.id);
        insert u;

        Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',ownerid=u.id,isActive__c=true);
        insert event;
        
        //Adding Item
        Item__c itm=new Item__c();
        itm.Event__c=Event.ID ;
        itm.Item_name__c='Test Item';
        itm.Cost__c=50;
        itm.Item_Quantity__c=2;
        itm.isTaxable__c=true;
        itm.Sales_Tax__c=2.0;
        itm.Sold_Quantity__c=1;
        insert itm;
        
        AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'manu', AS_LastName__c = 'gandham',
        AS_Email__c = 'event@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_ImageUrl__c='testurl');
        insert attendee;

        //calling AS_EventInfo Service
        System.RestContext.request = new RestRequest();
        
        RestContext.request.addParameter('Event_Name', 'Test Event');
        RestContext.request.addParameter('Start_Date', '2014-02-20');
        RestContext.request.addParameter('End_Date', '2014-02-20');
        RestContext.request.addParameter('STime', '10:00 AM');
        RestContext.request.addParameter('ETime', '02:00 PM');
        RestContext.request.addParameter('City', 'Hyd');
        RestContext.request.addParameter('State', 'Ap');
        RestContext.request.addParameter('Address1', 'Hitech');
        RestContext.request.addParameter('Address2', 'City');
        RestContext.request.addParameter('Location', 'Madhapur');
        RestContext.request.addParameter('MobileEvent_Id', '124');
        RestContext.request.addParameter('OwnerEmailID', 'event@gmail.com');
        RestContext.request.addParameter('SalesTax', '05.00'); 
        RestContext.request.addParameter('FeeApplicable', 'TRUE');         
        RestContext.request.addParameter('Event_Id', event.id);
        RestContext.request.addParameter('Status', 'CREATE');
        AS_EventInfo.doGet();
        RestContext.request.addParameter('Status', 'EDIT');
        AS_EventInfo.doGet();
        RestContext.request.addParameter('Status', 'DELETE');
        AS_EventInfo.doGet();
    }
}
@isTest(seeAllData = True)
public class Test_BLN_ASC_Edexinfo {

    static testmethod void testmethod_BLN_ASC_Edexinfo() {
        globalForTestClass globalTest = new globalForTestClass();
        account a = new account(name = 'govtnm3');
        insert a;

        contact c = new contact(lastname = 'n', accountid = a.id);
        insert c;

        Profile p = [select Id, Name FROM profile where name = 'Event Admin'];
        Profile__c profilecus = new Profile__c(PR_Name__c = 'EventAdmin');
        insert profilecus;

        User u = new User(alias = 'test123', email = 'event@gmail.com', emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US', localesidkey = 'en_US', country = 'United States', timezonesidkey = 'America/Los_Angeles', username = 'event@gmail.com', Password__c = '1', isactive = true, ContactID = c.id);
        insert u;

        Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass', ownerid = u.id, isActive__c = true);
        insert event;

        //Adding Item
        Item__c itm = new Item__c();
        itm.Event__c = Event.ID;
        itm.Item_name__c = 'Test Item';
        itm.Cost__c = 50;
        itm.Item_Quantity__c = 2;
        itm.isTaxable__c = true;
        itm.Sales_Tax__c = 2.0;
        itm.Sold_Quantity__c = 1;
        insert itm;

        AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'manu', AS_LastName__c = 'gandham',
            AS_Email__c = 'event@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765', AS_ImageUrl__c = 'testurl');
        insert attendee;

        Company__c companyInfo = new Company__c();
        companyInfo = globalTest.createCompany(u.Companyname);
        Currency__c currenyInfo = new Currency__c();
        currenyInfo = globalTest.createCurrency();

        Country__c countryInfo = new Country__c();
        countryInfo = globalTest.createCountry(currenyInfo.Id);

        State__c stateInfo = new State__c();
        stateInfo = globalTest.createState(countryInfo.Id);
        BLN_Event__c eventInfo = new BLN_Event__c();
        eventInfo = globalTest.createEvent(countryInfo.Id, Stateinfo.Id, CompanyInfo.id);
        eventInfo.scan_attendee_limit__c= 10;
        update eventInfo;

        Reg_Setting__c rsett1 = new Reg_Setting__c();
        rsett1.Column_Name__c = Null;
        rsett1.Defaullt_Label__c = 'Sponsors';
        rsett1.Event__c = eventInfo.id;
        rsett1.Label_Name__c = 'Sponsors';
        rsett1.Included__c = true;
        rsett1.Setting_Type__c = 'Eventdexapp';
        rsett1.Order__c = 1;
        insert rsett1;

        Reg_Setting__c rsett2 = new Reg_Setting__c();
        rsett2.Column_Name__c = Null;
        rsett2.Defaullt_Label__c = 'Speakers';
        rsett2.Event__c = eventInfo.id;
        rsett2.Label_Name__c = 'Speakers';
        rsett2.Included__c = true;
        rsett2.Setting_Type__c = 'Eventdexapp';
        rsett2.Order__c = 2;
        insert rsett2;

        Reg_Setting__c rsett3 = new Reg_Setting__c();
        rsett3.Column_Name__c = Null;
        rsett3.Defaullt_Label__c = 'Attendees';
        rsett3.Event__c = eventInfo.id;
        rsett3.Label_Name__c = 'Attendees';
        rsett3.Included__c = true;
        rsett3.Setting_Type__c = 'Eventdexapp';
        rsett3.Order__c = 3;
        insert rsett3;

        //calling ASC_Edexinfo Service
        System.RestContext.request = new RestRequest(); 
        RestContext.request.addParameter('Event_id', eventInfo.id);
        RestContext.request.addParameter('User_id', u.id);
        
        string year = '2009';
        string month = '3';
        string day = '5';
        string hour = '5';
        string minute = '2';
        string second = '2';
        string stringDate = year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;

        RestContext.request.addParameter('LastModifiedDate', stringDate);
        RestContext.request.addParameter('lastattid', attendee.id);

        BLN_ASC_Edexinfo.doPost();



    }

}
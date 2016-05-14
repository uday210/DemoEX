@isTest(SeeAllData=true)
public class Test_BLN_ReUse_EventsEditConPayment{
    public static testmethod void Testmethod_BLN_ReUse_EventsEditConPayment(){
    Account acc= new Account(Name='Globalnest');
         insert acc;
    
        contact con = new contact(firstname='gn',lastname='user',AccountId=acc.id);
        insert con;
        Profile p = [select id from profile where name='Event Admin1'];
        //userRole r=[SELECT ID FROM userRole WHERE name =: 'Custom Role'];   userRoleId= r.id,
        User U= new User(alias = 'gn', email='manasatest@gmail.com', firstname= 'fngn', Phone= '9878654345',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnuser', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest',
                                  timezonesidkey='America/Los_Angeles', username='manasatest@gmail.com', Title= 'SFDC Developer');
        database.insert(U,false);
     
     globalForTestClass globalTest= new globalForTestClass();
     
     test.starttest();
       System.runas(u){
        
   Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
    Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
    Company__c companyInfo= new Company__c();
    Item_Type__c itemType1= new Item_Type__c();
            itemType1= globalTest.createItemType();
            companyInfo= globalTest.createCompany('GlobalNest');
   
    BLN_Event__c eventInfo= new  BLN_Event__c();
    eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);
    GN_User__c  gnUserInfo= new GN_User__c();
   gnUserInfo= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);
        BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
         
             Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType1.Id, NULL, trackInfo.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool2.Id, itemType1.Id, eventInfo.id);
            Currency__c currencyInfo= new Currency__c();
            
            currencyInfo= globalTest.createCurrency();
                 
       
           
    BLN_ReUse_EventsEditCon.new_savesPaymentGateways( '{"pgopt":"PayPal","firstparam":"lisatillman2020@gmail.com","thirdparam":"Adaptive"}',eventInfo.id , 'keyname1','',null);
            BLN_ReUse_EventsEditCon.new_savesPaymentGateways( '{"pgopt":"PayPal","firstparam":"evendextest-facilitator_api1.gmail.com","secondparam":"KSDCKDDVCKMHPZR8","fourthparam":"AlWyKFhzRCLrsjZ9AqNlmIhDGZoiA051tz5Pll73ltw2RzLCgTV6S9uk","thirdparam":"Direct"}',eventInfo.id , 'keyname1','',null);
            BLN_ReUse_EventsEditCon.new_savesPaymentGateways( '{"pgopt":"Stripe","firstparam":"rt_6eenOnyUX2AJu9FHOSo2lnnAodNp2DF8gxctrvYc25JhDxHS","secondparam":"sk_test_bEmelgLJ0pUN8Nx9uq1Fv5xj","fourthparam":"","thirdparam":"Adaptive"}',eventInfo.id , 'keyname2','',null);
            BLN_ReUse_EventsEditCon.new_savesPaymentGateways( '{"pgopt":"Stripe","firstparam":"sk_test_cT9zTRnILXKy40xIkWb4tr2I","secondparam":"pk_test_lagbIPq5ejE7cWgCPmM41XCU","fourthparam":"","thirdparam":"Direct"}',eventInfo.id , 'keyname3','',null);
             BLN_ReUse_EventsEditCon.new_savesPaymentGateways( '{"pgopt":"Authorize.Net","firstparam":"2hc378RM2","secondparam":"6uqM6qb3F3cS32GH","fourthparam":"","thirdparam":"Direct"}',eventInfo.id , 'keyname4','',null);
             BLN_ReUse_EventsEditCon.new_savesPaymentGateways( '{"pgopt":"TrustCommerce","firstparam":"1114000","secondparam":"vivJand9","fourthparam":"","thirdparam":"Direct"}',eventInfo.id , 'keyname5','',null);
        try{ 
            BLN_ReUse_EventsEditCon.savesEventInfo('{"EventName":"Traditional Day Celebrations","EventSDate":"11/19/2014 7:00 AM","EventEDate":"11/26/2014 4:00 PM","EventLocation":"Hyderabad","EventOrgEmail":"phani.chimata@gmail.com","CurrencySetting":"a11c0000007oSK1AAM","LanguageSetting":"en_US","HostingTimeZone":"America/New_York","EventCategory":"Appearance or Signing","OrgName":"","EventStatus":"Draft","WebUrl":"www.boothleads.com","AttendeeReg":"By Global Nest","PhoneNo":"8756432123","EventDesc":"For conducting cultural activities","HostingAddress1":"Madhapur","HostingAddress2":"Hitech City","EventCity":"Hyderabad","EventState":"a1Oc00000026YQQEA2","EventCountry":"a10c0000004TO6IAAW","ZipCode":"45676","EventHashTag":"","TwitterUrl":"","FacebookUrl":""}', 'thirupathi','globalnest',companyInfo.id,'jhon','smith',gnUserInfo.id,U.id,countryInfo.Id);
            }catch(Exception eee){}
          BLN_ReUse_EventsEditCon.savesTicketInfo('[{"poolid":"","tname":"First","tpaytype":"Paid","tqty":1,"tprice":100,"tvisib":"Public","tdesc":"","tbdglabel":"Attendee","tbadgable":"B - Badge","trowid":1,"grouptickets":[{"itemid":"","tname":"First","sdate":"11/05/2015 05:39 AM","edate":"11/07/2015 06:00 PM","qty":1,"minqty":0,"maxqty":10,"tprice":100,"availabletickets":1}],"ticketcount":1,"tags":[{"tagname":"sponsor"}],"subpackagegroup":[],"ispackage":"false","itemtype":"","taxrateflag":false,"tebudprcflag":true},{"poolid":"","tname":"AP","tpaytype":"Paid","tqty":1,"tprice":1,"tvisib":"Public","tdesc":"","tbdglabel":"","tbadgable":"N - No Badge","trowid":2,"grouptickets":[{"itemid":"","tname":"AP","sdate":"11/06/2015 05:31 PM","edate":"11/07/2015 06:00 PM","qty":1,"minqty":0,"maxqty":1,"tprice":1,"availabletickets":1}],"ticketcount":1,"tags":[{"tagname":"sponsor"}],"subpackagegroup":[{"addonid":"","pkgitemname":"adm","pkgitemqty":1,"ttype":"'+itemType1.id+'","badgelabel":"Attendee","badgable":"B - Badge","tags":[{"tagname":"sponsor"}]}],"ispackage":"true","itemtype":"'+itemType1.id+'","taxrateflag":false,"tebudprcflag":true}]',eventInfo.Id,'01/29/2015 9:00 AM','01/30/2015 6:00 PM','30');
     BLN_ReUse_EventsEditCon.savesTicketInfo('[{"poolid":"","tname":"First","tpaytype":"Paid","tqty":1,"tprice":100,"tvisib":"Public","tdesc":"","tbdglabel":"Attendee","tbadgable":"B - Badge","trowid":1,"grouptickets":[{"itemid":"","tname":"First","sdate":"11/05/2015 05:39 AM","edate":"11/07/2015 06:00 PM","qty":1,"minqty":0,"maxqty":10,"tprice":100,"availabletickets":1}],"ticketcount":1,"tags":[{"tagname":"sponsor"}],"subpackagegroup":[],"ispackage":"false","itemtype":"","taxrateflag":false,"tebudprcflag":true},{"poolid":"","tname":"AP","tpaytype":"Paid","tqty":1,"tprice":1,"tvisib":"Public","tdesc":"","tbdglabel":"","tbadgable":"N - No Badge","trowid":2,"grouptickets":[{"itemid":"","tname":"AP","sdate":"11/06/2015 05:31 PM","edate":"11/07/2015 06:00 PM","qty":1,"minqty":0,"maxqty":1,"tprice":1,"availabletickets":1}],"ticketcount":1,"tags":[{"tagname":"sponsor"}],"subpackagegroup":[{"addonid":"","pkgitemname":"adm","pkgitemqty":1,"ttype":"'+itemType1.id+'","badgelabel":"Attendee","badgable":"B - Badge","tags":[{"tagname":"sponsor"}]}],"ispackage":"true","itemtype":"'+itemType1.id+'","taxrateflag":false,"tebudprcflag":true}]',eventInfo.Id,'01/29/2015 9:00 AM','01/30/2015 6:00 PM','4000');
         
            }       
    test.stoptest();
    
    }
    
    
    
    }
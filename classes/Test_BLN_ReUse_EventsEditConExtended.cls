@isTest(SeeAllData=true)
public class Test_BLN_ReUse_EventsEditConExtended{
    public static testmethod void Testmethod_BLN_ReUse_EventsEditConExtended(){
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
            PGateway_Type__c pt=[select id,name from PGateway_Type__c limit 1];
            Pay_Gateway__c p1=new Pay_Gateway__c(Company__c=CompanyInfo.id,PGateway_Type__c=pt.id);
            
     BLN_ReUse_EventsEditCon.savesFinalEvent('Live',string.valueof(eventInfo.id),'2.00','4111111111111111','09','2017','123', '[{"ticketName":"ABC","ticketPrice":"2","ticketQty":"1","ticketId":"'+itemType1.id+'","itemId":"'+item.id+'"}]',string.valueof(currencyInfo.Id),'Pay Using Existing Credit Card','Credit Card','visa');
     BLN_ReUse_EventsEditCon.savesFinalEvent('Live',string.valueof(eventInfo.id),'2.00','4111111111111111','09','2017','123', '[{"ticketName":"ABC","ticketPrice":"2","ticketQty":"1","ticketId":"'+itemType1.id+'","itemId":"'+item.id+'"}]',string.valueof(currencyInfo.Id),'Pay Using New Credit Card','Credit Card','visa');
     BLN_ReUse_EventsEditCon.savesFinalEvent('Live',string.valueof(eventInfo.id),'2.00','4111111111111111','09','2017','123', '[{"ticketName":"ABC","ticketPrice":"2","ticketQty":"1","ticketId":"'+itemType1.id+'","itemId":"'+item.id+'"}]',string.valueof(currencyInfo.Id),'Check ','Check','visa');
     try{
      BLN_ReUse_EventsEditCon.new_savesPaymentOption('{"pgopt":"PayPal","firstparam":"'+p1.id+'","secondparam":"Check","thirdparam":"Direct","fourthparam":"test4p"}',eventInfo.id,'true','cash','external','cashcheckexternalcardcustomerid', 'cashcheckexternalcarddetails','tckopt','feeopt', '','F','acceptrangeforgt','mingt','check','micheck');
       }catch(Exception e){}      
        
         
            }       
    test.stoptest();
    
    }
    
    
    
    }
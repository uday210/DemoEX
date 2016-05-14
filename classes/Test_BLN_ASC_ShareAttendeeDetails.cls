@isTest(SeeAllData=true)
public class Test_BLN_ASC_ShareAttendeeDetails{
static testmethod void Testmethod_BLN_ASC_ShareAttendeeDetails(){

 globalForTestClass globalTest= new globalForTestClass();
      
      
     Account acc1= new Account(Name='Globalnest1');
         insert acc1;
    
        contact con1 = new contact(firstname='gn1',lastname='user1',AccountId=acc1.id);
        insert con1;
        
      Profile p = [select id from profile where name='Event Admin1'];
    
      User U= new User(alias = 'gnalias', email='attdetails@noemail.com', firstname= 'fngnchek', Phone= '9878754345',Contactid=con1.id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnuconser', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest com',
                                  timezonesidkey='America/Los_Angeles', username='attdetails@noemail.com', Title= 'SFDC Developer');
        insert U;
         system.runas(u){
        User userForGN= new User();
            userForGN= globalTest.createUser();              
            
         
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
          
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
            
        GN_User__c  gnUserInfo= new GN_User__c();
        gnUserInfo= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);          
        
       Company__c companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(u.Companyname);
        
        BLN_Event__c eventInfo= new  BLN_Event__c();
        eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);     
      
       BLN_Track__c trackInfo= new BLN_Track__c();
        trackInfo= globalTest.createTrack(eventInfo.id);
        
         Item_Type__c itemType1= new Item_Type__c();
         itemType1= globalTest.createItemType();
         
         Item_Pool__c  ItemPool2= new Item_Pool__c();
         ItemPool2= globalTest.createItemPool(eventInfo.id, itemType1.Id, NULL, trackInfo.id);
            
      BLN_Item__c  item= new BLN_Item__c();
        item= globalTest.createItem(ItemPool2.Id, itemType1.Id, eventInfo.id);
        
       
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);

            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
        
         //Order__c insertOrder1=new Order__c (Currency_Code__c = currenyInfo.id, Events__c = eventInfo.Id ,order_type__c = 'EVENT PRODUCER');
            //insert insertOrder1;
         
          Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
        Order_Item__c  orderiteminfo =new Order_Item__c ();
            orderiteminfo = globalTest.createOrderItem(item.id, insertOrder1.id, promotion1.id, currenyInfo.id);
        
        
        Ticket__c ticketinfo = new Ticket__c();
        ticketinfo = globalTest.createTicket(eventInfo.id, item.Id, itemPool2.Id, itemType1.Id, insertOrder1.Id,tktprof.id);
        
        
        System.RestContext.request = new RestRequest();
            RestContext.request.requestURI ='/BLN_ASC_AttendeeDetails';
            RestContext.request.addParameter('Event_Id',eventInfo.id);
            RestContext.request.addParameter('Ticket_Id',ticketinfo.id);
            RestContext.request.addParameter('User_Id',gnUserInfo.id);
            RestContext.request.addParameter('Scan_Time',system.now().format('MM/dd/yyyy hh:mm a','America/New_York'));
            RestContext.request.addParameter('Status','Accept');
            RestContext.request.addParameter('Company_Id',CompanyInfo.id);
            RestContext.request.addParameter('environmentName','PRO');
            
            
            
       Blob jsonbody = blob.valueOf('{"fn":"Manasa","ln":"B","email":"manasa1@gmail.com","comp":"Global","compid":"'+CompanyInfo.id+'","phone":"(986) 623-6514","tid":"'+ticketinfo.id+'","title":"Android","badgelabel":"Attendee"}');
    
        RestContext.request.requestBody  = jsonbody ;
        
          BLN_ASC_ShareAttendeeDetails.doPost();

        RestContext.request.addParameter('Status','Reject');
        BLN_ASC_ShareAttendeeDetails.doPost();
}

}
}
@isTest(SeeAllData=true)
public class Test_BLN_ASC_AttendeeDetails{
static testmethod void Testmethod_BLN_ASC_AttendeeDetails(){
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
            RestContext.request.addParameter('eventId',eventInfo.id);
            
       Blob jsonbody = blob.valueOf('{"fn":"Manasa","ln":"B","email":"manasa1@gmail.com","comp":"Global","compid":"'+CompanyInfo.id+'","phone":"(986) 623-6514","tid":"'+ticketinfo.id+'","title":"Android","badgelabel":"Attendee"}');
    
        RestContext.request.requestBody  = jsonbody ;
     
      BLN_ASC_AttendeeDetails allatte = new BLN_ASC_AttendeeDetails();
      
      BLN_ASC_AttendeeDetails.innforParser setde= new BLN_ASC_AttendeeDetails.innforParser(); 
            
            BLN_ASC_AttendeeDetails.innforParser attinnforparser = new BLN_ASC_AttendeeDetails.innforParser();
            attinnforparser.add1 = 'add12';
            attinnforparser.add2 = 'add34';
            attinnforparser.badgelabel = 'ATTENDEE';
            attinnforparser.city = 'Morganville';
            attinnforparser.comp = 'GNC';
            attinnforparser.compid = 'GNC0054';
            attinnforparser.country = 'United States of America';
            attinnforparser.email = 'dev@test.com';
            attinnforparser.fn = 'Dev';
            attinnforparser.ln = 'test';
            attinnforparser.note = 'An ultimate Events portal';
            attinnforparser.phone = '(732) 333 4808';
            attinnforparser.seatno = 'Seat 10';
            attinnforparser.state = 'New Jersey';
            attinnforparser.tag = 'Booths';
            attinnforparser.tid = 'Booth1010';
            attinnforparser.title ='Senior Arch';
            //attinnforparser.workphone ='(732) 333 1901';
            attinnforparser.zipcode = '00751';
            
            BLN_ASC_AttendeeDetails.maincontainer attmaincon = new BLN_ASC_AttendeeDetails.maincontainer();
            attmaincon.orderInn = new order__c();
            attmaincon.dt = System.today();
            attmaincon.ticketsInn=new List<Ticket__c>();
            attmaincon.cancelledTickets = new List<Ticket__c>();
            attmaincon.paymentInn = new payment__c();
            attmaincon.orderItemInn = new List<order_Item__c>();
            attmaincon.compListInner = new List<company__c>();
            attmaincon.orderPrice = 0.123;
            attmaincon.ticketTags = new List<Hash_Tag__c>();
            
      BLN_ASC_AttendeeDetails.TotalList tlst =new BLN_ASC_AttendeeDetails.TotalList ();
            tlst.isorder=true;
            
            try{
                BLN_ASC_AttendeeDetails.doPost();
            }catch(Exception e){}      
     
      }
      
      
}
}
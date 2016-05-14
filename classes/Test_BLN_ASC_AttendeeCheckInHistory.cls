@isTest(SeeAllData=true)
public class Test_BLN_ASC_AttendeeCheckInHistory{
    static testmethod void Testmethod_BLN_ASC_AttendeeCheckInHistory(){
      globalForTestClass globalTest= new globalForTestClass();
    
      Account acc= new Account(Name='Globalnestacc');
         insert acc;
    
      contact con = new contact(firstname='gaccn',lastname='usercon',AccountId=acc.id);
        insert con;
        
      Profile p = [select id from profile where name='Event Admin1'];
    
      User U= new User(alias = 'gnalias', email='testgcheck@noemail.com', firstname= 'fngnchek', Phone= '9878754345',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnuconser', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest com',
                                  timezonesidkey='America/Los_Angeles', username='testgcheck@noemail.com', Title= 'SFDC Developer');
        database.insert(U,false);
         system.runas(u){

         
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
           tktprof=globalTest.createTktprofile(u);
        
        
         //Order__c insertOrder1=new Order__c (Currency_Code__c = currenyInfo.id, Events__c = eventInfo.Id ,order_type__c = 'EVENT PRODUCER');
           // insert insertOrder1;
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, u.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
        
        
        //Ticket__c ticketinfo = new Ticket__c();
        //ticketinfo = globalTest.createTicket(eventInfo.id, item.Id, itemPool2.Id, itemType1.Id, insertOrder1.Id,gnUserInfo.id);
        
        Ticket__c ticket= new Ticket__c();
        ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool2.Id, itemType1.Id, insertOrder1.Id, tktprof.Id);
      
        Tstatus__c tstatus =new     Tstatus__c(Device_Name__c ='iphone',Ticket__c = ticket.id ,Tstatus_name__c = true );      
          insert tstatus ;
      
         /*****************************************/
         
            System.RestContext.request = new RestRequest();
            RestContext.request.requestURI ='/BLN_ASC_AttendeeCheckInHistory';
            RestContext.request.addParameter('Ticket_Id',ticket.id);
            
            BLN_ASC_AttendeeCheckInHistory  bln_attendeecheckinh = new BLN_ASC_AttendeeCheckInHistory();
            
            BLN_ASC_AttendeeCheckInHistory.dopost();       
            
         }   
            
          
                
    }
    
 }
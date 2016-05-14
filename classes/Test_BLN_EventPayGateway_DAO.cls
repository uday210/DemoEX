@isTest(seeAllData=True)
public class Test_BLN_EventPayGateway_DAO{

static testmethod void Test_BLN_EventPayGateway_DAO(){

   User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id,Registration_Type__c='Onsite',BLN_Pay_Gateway__c = paygateway.id);
            insert payobj;
            
            BLN_EventPayGateway_DAO EVpayGateway = new BLN_EventPayGateway_DAO();
            EVpayGateway.getEventPayGateWays(eventInfo.id);
            EVpayGateway.getEventPayGateWaysbasedonmodule(eventInfo.id,'Onsite');
           try{
            BLN_EventPayGateway_DAO.getEventPayGateWay(eventInfo.id,'Check','Onsite');
            }Catch(Exception e){}
            }
            }
            }
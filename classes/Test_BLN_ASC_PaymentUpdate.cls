@isTest(seeAllData=True)
public class Test_BLN_ASC_PaymentUpdate{

static testmethod void Test_BLN_ASC_PaymentUpdate(){

   User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
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
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
             tktprof.bln_gn_user__c=gnUser.id;
        update tktprof;
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id);
            insert payobj;
            string bodys='{"transactionId": "123456","Payment_Mode":"Free","orderId": "'+insertOrder1.id+'","isTransactionSuccess": null,"errorMessage": null,"cardType": "Master","cardLastDigits":"7866","PaymentType":"","RegType":"Online","eventId":"'+eventInfo.id+'","paygatewayid":"'+paygateway.id+'"}';
    blob b = blob.valueOf(bodys);
    system.debug('@@@@@@@@@@'+bodys);
    System.RestContext.request = new RestRequest();
     RestContext.request.requestBody  = b;
     RestContext.request.requestURI ='/BLN_ASC_PaymentUpdate';
      
         String Module='ScanAttendee';
        BLN_ASC_PaymentUpdate pay =new BLN_ASC_PaymentUpdate();
        try{
        BLN_ASC_PaymentUpdate.doPost();
        }catch(exception e){}
        BLN_ASC_PaymentUpdate.paykeys pkeys = new BLN_ASC_PaymentUpdate.paykeys();
        pkeys.transactionId = 'tst1';
        pkeys.orderId = 'tst2';
        pkeys.isTransactionSuccess = 'tst3';
        pkeys.errorMessage = 'tst5';   
        pkeys.cardType = 'tst6'; 
        pkeys.cardLastDigits = 'tst7'; 
        pkeys.Payment_Mode = 'tst8'; 
        pkeys.RegType = 'tst9'; 
        pkeys.eventId = 'tst10'; 
        pkeys.paygatewayid = 'tst11';          
        pkeys.PaymentType = 'tst12'; 
        
           
            }

   
 

}



}
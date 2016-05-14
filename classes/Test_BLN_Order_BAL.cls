@istest(seealldata = true)
public class Test_BLN_Order_BAL{
 static testmethod void Test_BLN_Order_BAL(){
 //try{
 
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
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);  
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
             BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
                        
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
                
            /*GN_user__c gnUser  = new GN_user__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);*/
            GN_User__c gnUser= new GN_User__c();
        
        //User insertUser= new User();
        //insertUser= createUserForGNUser();
        
        gnUser.User__c= u.Id;
       //insertGNUser.Company_Name__c= userInfo.CompanyName;
        gnUser.Email__c= u.email;
        gnUser.First_Name__c= u.firstname;
        gnUser.Last_Name__c= u.lastname;
        gnUser.Home_Phone__c= u.Phone;
       
        //insertGNUser.Country__c= countryInfo.id;
        //insertGNUser.State__c= stateInfo.id;
        
        insert gnUser;
            
            system.debug('------gnUser Id---- '+gnUser.id);
            system.debug('------gnUser---- '+gnUser);
            
           /* Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            tktprof.bln_company__c = companyInfo.id;
            update tktprof;*/
         Tkt_profile__c insertTktprofile= new Tkt_profile__c();
        
       
        insertTktprofile.First_Name__c= 'testfname';
        insertTktprofile.Last_Name__c= 'testlname';
        insertTktprofile.Email__c= u.email;
        insertTktprofile.TKT_Job_Title__c= u.Title;
        insertTktprofile.BLN_GN_User__c = gnUser.Id;
        insert insertTktprofile;
           
            Order__c insertOrder1= new Order__c();
            
            insertOrder1.bln_tkt_profile__c=insertTktprofile.id;
            insertOrder1.Events__c= eventInfo.id;
            insertOrder1.Order_Total__c= 2;
            insertOrder1.Order_Status__c= 'Fully Paid';
            insertOrder1.Amount_Paid__c= 25.12;
            insertOrder1.Fee_Amount__c= 23.29;
            insertOrder1.Currency_Code__c= currenyInfo.id;
            
            
            insert insertOrder1;  
            
           Ticket__c ticket= new Ticket__c();
           ticket= globalTest.createTicket(insertTktprofile.BLN_GN_User__r.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, insertTktprofile.Id);
            
            
            
            BLN_Order_BAL ordbal = new BLN_Order_BAL();
            BLN_Order_DAO insertOrder = new BLN_Order_DAO();
            BLN_StatusMessage OrderMsg = new BLN_StatusMessage();
            
            system.debug('gnuser id : '+gnUser.id);
            system.debug('eventInfo id : '+eventInfo.id);
            system.debug('companyInfo id : '+companyInfo.id);
            system.debug('currenyInfo id : '+currenyInfo.id);
            
            
try{
            
            OrderMsg = ordbal.ProcessOrder(insertOrder1.BLN_TKT_profile__r.BLN_GN_User__r.id, eventInfo.id,companyInfo.id,'Check', '12352', '15', '12', '3', '0.75', '1', '13.75', 'Check Not Received',currenyInfo.Id );
             
     }catch(Exception e){}        
 
 }
 
  
 }



}
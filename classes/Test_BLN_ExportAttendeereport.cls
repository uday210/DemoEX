@isTest
public class Test_BLN_ExportAttendeereport{

    static testmethod void Testmethod_BLN_ExportAttendeereport(){
        
            // User U= new User();
            globalForTestClass globalTest= new globalForTestClass();
            // U= globalTest.createUser();
            
            Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
            
            User u = new User(alias = 'Test', email='testcodec123d@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
            localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
            timezonesidkey='America/Los_Angeles', username='testcodec123d@noemail.com');
            Database.insert(u);
            
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
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Order__c insertOrder1= new Order__c();
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof =globalTest.createTktprofile(userForGN);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.name = 'Admissions';
            update itemType;
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            Ticket__c ticket2= new Ticket__c();
            ticket2= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket2.Parent_ID__c = ticket.id;
            update ticket2;
            
            test.starttest();
            Database.BatchableContext BC;
            Database.QueryLocator QL;
            string query = 'SELECT ID,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,(SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,            tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,            tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,            tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c FROM Ticket__c' ;            
            BLN_ExportAttendeereport beo = new BLN_ExportAttendeereport(query,'America/New_York',eventInfo.id,system.today(),system.today()+1);            
            beo.start(BC);            
            Database.executeBatch(beo);
            test.stoptest();
          
        }  
  
   }
  
}
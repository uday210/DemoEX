@isTest
public class Test_BLN_ExportLeadsBatch{
    static testmethod void Testmethod_BLN_ExportLeadsBatch(){
        
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
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            GN_User__c  gnUser1= new GN_User__c();
            gnUser1= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            list<BLN_Item__c>  itemli = new list<BLN_Item__c>();   
            itemli.add(item);
            
            Lead_Scan__c ls=new Lead_Scan__c();
            ls.First_Name__c='testa';
            ls.Last_Name__c='testb';
            ls.Event__c=eventInfo.id;
            ls.Scanner_Company__c=companyInfo.id;
            ls.Scanner_User__c=gnUser1.id;
            ls.BLN_TKT_profile__c = tktprof.Id;
            ls.Lead_Email__c = tktprof.email__c;
            ls.Title__c ='assa';
            ls.Cell_Phone__c = '1234567890';
            ls.Company__c = 'dsdsf';
            ls.Lead_Status__c = 'Active';
            ls.Scan_Time__c = system.now();
            insert ls;
                
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
            
            Promotion__c promotion4= new Promotion__c();
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
           BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
            
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
             Payment__c pay=new Payment__c();
             pay.Payment_Amount__c=10;
             pay.Order__c=insertOrder1.id;
             pay.Currency_Code__c=currenyInfo.id;
             pay.Payment_Mode__c='Check';
             insert pay;
           
            string querystring ='SELECT Event__r.Time_Zone__c,BLN_TKT_profile__r.Email__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Name,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + eventInfo.id+ '\' AND Scanner_User__r.User__c=\'' + UserInfo.getUserId() + '\'' + ' order by scan_time__c Desc';

             BLN_ExportLeadsBatch bec = new  BLN_ExportLeadsBatch(querystring,eventInfo.id);
             Database.QueryLocator QL;
             Database.BatchableContext BC;
             Database.executebatch(bec,90);
           
        } 
    }
}
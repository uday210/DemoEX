@istest
public class Test_BLN_ASC_UpdateProfile {
 public static BLN_Event__c eventInfo{get;set;}
 public static BLN_Profile_BAL procon {get ; set ;}
 
 
 
 
 
public static testmethod void Test_BLN_ASC_UpdateProfile (){

    //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
       // U= globalTest.createUser();
        
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User u = new User(alias = 'Test', email='testcode123xc@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode123xc@noemail.com');
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
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
             Role__c insertRole= new Role__c();
        insertRole.name= 'Company Admin';
        insertRole.Role_ShortName__c= 'CA';
        insert insertRole;
             
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
              tktprof=globalTest.createTktprofile(userForGN);

            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
             UC_Role__c insertUCRole= new UC_Role__c();
             insertUCRole.Company__c= companyInfo.Id;
        insertUCRole.Event__c= eventInfo.id;
       // insertUCRole.Role__c= 'Company Admin';
        insertUCRole.RoleId__c= insertRole.id;
        insertUCRole.GN_User__c= gnUser.id;
        //insertUCRole.User__c= userId;
            
        insert insertUCRole;
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
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
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
           BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
            
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'thirumala', 'globalnest');
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id,tktprof.Id);
             RestRequest req = new RestRequest(); 
            string fname = 'mythily';
            string Lname = 'Yenki';
            string comp = 'Globalnest';
            string emil = 'globalnest@globalnest.com';
            string mb = '999999';
            string city = 'New York';
            string state = 'NY';
            string coun = 'United States Of America';
            procon = new BLN_Profile_BAL();
            req.addParameter('Firstname',fname );
            req.addParameter('Lastname',Lname );
            req.addParameter('Companyname',comp );
            req.addParameter('Email',emil );
            req.addParameter('Mobile',mb);
            req.addParameter('City',city );
            req.addParameter('State',stateInfo.id);
            req.addParameter('Country',countryInfo.id);
            req.addParameter('DefaultcompanyId',companyInfo.id);
            req.addParameter('Userid',userForGN.id);
           
            req.httpMethod = 'POST';
            
             string bodys = '{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
            blob b = blob.valueOf(bodys);
            string bodd = EncodingUtil.base64encode(b);
            blob b1 = blob.valueOf(bodd);
            req.requestBody= b1;
            
            RestContext.request = req;
            BLN_ASC_UpdateProfile.maincontainer wrap = new BLN_ASC_UpdateProfile.maincontainer();
            wrap.Profile = gnUser;
            wrap.profileimage = 'wrap4';
            wrap.profilestate = 'wrap1';
            wrap.profilestate = 'wrap2';
            wrap.profilecountry = 'wrap3';
            
            //BLN_ASC_UpdateProfile.procon p = new BLN_ASC_UpdateProfile.procon();
              //try{
                 BLN_ASC_UpdateProfile.dopost();    
           // }catch(Exception Ex){ }  
                
              
           
            
    }
    





}




}
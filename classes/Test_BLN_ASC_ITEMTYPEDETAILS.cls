@isTest(seeAllData=True)

public class Test_BLN_ASC_ITEMTYPEDETAILS {
    
    static testMethod void testmethod_Test_BLN_ASC_ITEMTYPEDETAILS(){
        
        //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
        Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User U = new User(alias = 'Test1', email='testcode12333@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting1', Firstname='codeTesting1', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode12333@noemail.com');
        
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

            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType15();
            
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
            
            //Ticket__c ticket= new Ticket__c();
            //ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            booth_map__c bmap=new booth_map__c();
            bmap = globalTest.createBoothmap(ticket.id);
            
            System.RestContext.request = new RestRequest();
            
            //RestRequest req = new RestRequest(); 
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestContext.request.addParameter('ItemType_Name','Exhibitors');
            RestContext.request.addParameter('Event_Id',eventInfo.id);
            RestContext.request.requestURI =  sfbaseURL+'/services/apexrest/BLN_ASC_ITEMTYPEDETAILS';  
            RestContext.request.httpMethod = 'POST';
            
            BLN_ASC_ITEMTYPEDETAILS blnascitem = new BLN_ASC_ITEMTYPEDETAILS();
            
            
            BLN_ASC_ITEMTYPEDETAILS.boothContainer itemboothcon = new BLN_ASC_ITEMTYPEDETAILS.boothContainer();
            itemboothcon.BoothArea = 'testt1';
            itemboothcon.BoothName = 'testt2';
            itemboothcon.BoothNumber = '1234';
            itemboothcon.Room = 'room1';
            
            BLN_ASC_ITEMTYPEDETAILS.Container blnasccont = new BLN_ASC_ITEMTYPEDETAILS.Container();
            //BLN_ASC_ITEMTYPEDETAILS.Container blnasccont = new BLN_ASC_ITEMTYPEDETAILS.Container('test1','test2','test3','test4','test5','test6','test7','test8','test9','test10','test11','test12','test13','test14','test15','test16','test17','test18','test19','test20','test21');
            blnasccont.TicketId = 'test22';
            blnasccont.FirstName = 'test1';
            blnasccont.LastName = 'test2';
            blnasccont.Email = 'test3';
            blnasccont.CompanyName = 'test4';
            blnasccont.UserWebSite = 'test5';
            blnasccont.UserPhoto = 'test6';
            blnasccont.tktprofileid = 'test7';
            blnasccont.SfuserID = 'test8';
            blnasccont.CompanyID = 'test9';
            blnasccont.City = 'test10';
            blnasccont.State = 'test11';
            blnasccont.Country = 'test12';
            blnasccont.Facebook = 'test13';
            blnasccont.linkedin = 'test14';
            blnasccont.Twitter = 'test15';
            blnasccont.SpeakerBlog = 'test16';
            blnasccont.Biography = 'test17';
            blnasccont.Youtube = 'test18';
            blnasccont.CompanyWebSite = 'test19';
            blnasccont.CompanyLogo = 'test20';
            blnasccont.Phone = 'test21';
            
			
            BLN_ASC_ITEMTYPEDETAILS.MainContainer itemmaincon = new BLN_ASC_ITEMTYPEDETAILS.MainContainer();
            itemmaincon.ImagePath = 'Testt4';
            itemmaincon.ItemTypeName = 'Testt5';
            
            
            //try{
            BLN_ASC_ITEMTYPEDETAILS.doPost();
            //}catch(Exception e) {} 
    }

}
    
}
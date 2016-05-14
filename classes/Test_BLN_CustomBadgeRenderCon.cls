@isTest(seeAllData=true)
public class Test_BLN_CustomBadgeRenderCon{
  static testmethod void Test_BLN_CustomBadgeRenderCon(){
  
  
    globalForTestClass globalTest= new globalForTestClass();
            
        
        
         Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         // ------------------ Eventadmin Insert ---------------------

         User u = new User(alias = 'Test', email='testcode1234@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1234@noemail.com');
         database.insert(u,false);
         
         
         
         
         
         system.runas(U){  
   
     NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
   
      BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            
            BLN_BadgeTemplate_Styles__c badTStyleInfo=new BLN_BadgeTemplate_Styles__c();
            badTStyleInfo=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            Reg_Setting__c regSettingsInfo4= new Reg_Setting__c();
            regSettingsInfo4= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            list<Reg_Setting__c> regsettinginfo3 = new list<Reg_Setting__c>();
            regsettinginfo3.add(regSettingsInfo1);
            
            
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
           // Order__c insertOrder1= new Order__c();
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
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);



Ticket__c ticket= new Ticket__c();
                
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            Ticket__c insertTicket  = [select id,Name,Badge_Label__c,Tag_No__c,tkt_profile__r.BLN_GN_User__c,Item__c,Event__c
                                       from Ticket__c where id =:ticket.id];
                                       
           Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);                              


BLN_CustomBadgeRenderCon bn = new BLN_CustomBadgeRenderCon(); 

 BLN_CustomBadgeRenderCon.getLayoutDataForSize(4,3,'8.5\" x 11\"');
              BLN_CustomBadgeRenderCon.getLayoutDataForSize(8.5,11,'8.5\" x 11\"');
               BLN_CustomBadgeRenderCon.getLayoutDataForSize(3.4,2.3,'8.5\" x 11\"');
               BLN_CustomBadgeRenderCon.getLayoutDataForSize(3.9,2.4,'8.5\" x 11\"');
               BLN_CustomBadgeRenderCon.getLayoutDataForSize(3.5,2.25,'8.5\" x 11\"');
               BLN_CustomBadgeRenderCon.getLayoutDataForSize(3.4,2.1,'8.5\" x 11\"');
               BLN_CustomBadgeRenderCon.getLayoutDataForSize(1.1,2.1,'8.5\" x 11\"');
               
               List<String> lststng = new List<String>();
                lststng.add(ticket.id);
                lststng.add(ticket1.id);
              
              
               BLN_CustomBadgeRenderCon.genpdf(eventInfo.id,lststng,'true');
               BLN_CustomBadgeRenderCon.genpdf(eventInfo.id,lststng,'false');
               
               BLN_CustomBadgeRenderCon.openPDF('test');
               
               
               BLN_Badge_Layer__c bbc = new BLN_Badge_Layer__c();
       bbc.BLN_Badge_Style_ID__c = '999';
       bbc.Data__c = '{"id":-1,"type":"Image layer","content":"Hello World123123","directive":"layer-image","width":0.3,"height":0.15,"x":0.04923599320882852,"y":0.050933786078098474,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":0,"elem":null,"scope":null,"image":"/Eventdex/resource/1446315046000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}';
       insert bbc;
       
       list<BLN_Badge_Layer__c> lis = new list<BLN_Badge_Layer__c>();
       lis.add(bbc);
            
    BLN_Badge_Style__c bb = new BLN_Badge_Style__c();
    bb.Description__c = 'test';
    insert bb;
      // BLN_CustomBagdeConNew bcn = new BLN_CustomBagdeConNew();
     
       
     
   //   BLN_CustomBagdeConNew.saveStyle('999','ddddddd', 'cffff', lis,eventInfo.id, 'test', 'test' );
               
   //            BLN_CustomBadgeRenderCon.getRenderData(eventInfo.id,'999',ticket.id,'true');
     //          BLN_CustomBadgeRenderCon.getRenderData(eventInfo.id,bb.Name,ticket.id,'false');
               
                
              
             
                
               List<String> lststng1 = new List<String>();
               lststng1.add('test');
               lststng1.add('test1');
               lststng1.add('test2');
              BLN_CustomBadgeRenderCon.getAttendeeData('test',lststng1,'true');             
              

               BLN_CustomBadgeRenderCon.RenderData blnattndrend = new   BLN_CustomBadgeRenderCon.RenderData('test',BLN_CustomBadgeRenderCon.getLayoutDataForSize(3.5,2.25,'8.5\" x 11\"'),null); 
                 


}
  
  }}
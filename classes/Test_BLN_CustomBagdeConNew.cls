@istest(seeAlldata=true)
public class Test_BLN_CustomBagdeConNew{
    static testmethod void Testmethod_BLN_BLN_CustomBagdeConNew(){
    
    
    //User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    //U= globalTest.createUser();
    
    Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];
        // ------------------ Eventadmin Insert ---------------------
        
        User u = new User(alias = 'bussatet', email='bussastest@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='newclass', Firstname='myclasstest', languagelocalekey='en_US',
        localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
        timezonesidkey='America/Los_Angeles', username='bussastest@noemail.com');
       database.insert(u);

    
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
            
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);             
            
             BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);        
            
            list<BLN_Event__c> sce = new list<BLN_Event__c>();
            sce.add(eventInfo);
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);          
       
                       
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
          
          
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userForGN);

            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id,insertOrder1.Id,tktprof.id);
            
            Hash_Tag__c HTag = new Hash_Tag__c ();
            HTag = globalTest.createHashTag(eventInfo.id);
            
            BLN_Badge_Layer__c bbc = new BLN_Badge_Layer__c();
       bbc.BLN_Badge_Style_ID__c = '9999';
       bbc.Data__c = '{"id":-1,"type":"Image layer","content":"Hello World123123","directive":"layer-image","width":0.3,"height":0.15,"x":0.04923599320882852,"y":0.050933786078098474,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":0,"elem":null,"scope":null,"image":"/Eventdex/resource/1446315046000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}';
       insert bbc;
       
       list<BLN_Badge_Layer__c> lis = new list<BLN_Badge_Layer__c>();
       lis.add(bbc);
       
        BLN_Badge_Style__c bstyle= new BLN_Badge_Style__c();
        bstyle.Description__c = 'testbadge';
        bstyle.Event__c =     eventInfo.id;
    
    insert bstyle;
    BLN_Badge_Style__c bstyle1 = [select name from BLN_Badge_Style__c where Description__c ='testbadge'];
    System.debug('estclass '+bstyle1);
      // BLN_CustomBagdeConNew bcn = new BLN_CustomBagdeConNew();
     
       BLN_CustomBagdeConNew.getStyles(eventInfo.id);
       BLN_CustomBagdeConNew.getAllStyles(eventInfo.id);
         
       
     
      BLN_CustomBagdeConNew.saveStyle('999','ddddddd', 'cffff', lis,eventInfo.id, 'test', 'test' );
      
      BLN_Badge_Style__c bs = [select id from BLN_Badge_Style__c where Description__c='ddddddd'];
      BLN_CustomBagdeConNew.saveStyle('999','ddddddd', 'cffff', lis,eventInfo.id, 'test', 'test' );
   //  BLN_CustomBagdeConNew.getStyle(bstyle1.Name);
    //  BLN_CustomBagdeConNew.deleteStyle(bstyle.Id);
     //    
   BLN_CustomBagdeConNew.renameStyle(bstyle1.Name,'new ');
    //    BLN_CustomBagdeConNew.deleteStyle(insertBadge.id);
      BLN_CustomBagdeConNew.uploadImage('data:image/png;base64,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', 'vhguj');
        
    }
    
   } 
     
   }
/*
Author : Anil kumar
Date   : 12/10/2015
*/


@isTest(seeAllData=True)
public class Test_BLN_attendee_settingsNewCon{

static testmethod void Test_BLN_attendee_settingsNewCon(){

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
            
              Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
             cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_attendee_settingsNewCon attsettings =new BLN_attendee_settingsNewCon();
            
            attsettings.selectedGroups = 'testName1';
            string RegisNo = 'testName1';
            Boolean IsSelectd = true;
            List<Reg_Setting__c> LstReg = new List<Reg_Setting__c>();
            for(Integer i=0;i<20;i++)
            { 
            Reg_Setting__c registr = new Reg_Setting__c(Label_Name__c = 'testName'+i,Required__c=true,Update_Access__c=false,Column_Name__c='test Column Name'+i); 
            LstReg.add(registr); 
            }
            insert LstReg; 
            
            List<BLN_attendee_settingsNewCon.innHeaderWithSettList> Templs = new List<BLN_attendee_settingsNewCon.innHeaderWithSettList>();
            Templs.add(new BLN_attendee_settingsNewCon.innHeaderWithSettList(RegisNo,LstReg,IsSelectd));
            attsettings.innSetList = Templs;
            attsettings.defSettings = Templs;
            ApexPages.currentPage().getParameters().put('pmValue',string.valueof(item.id));
            attsettings.selectedInfoType='Collect info from Buyers only';
            attsettings.setApplyItems =item.id+',';
           attsettings.fetchSettings();
           attsettings.cancelAct();
           
           Account[] accts = new List<Account>{
           new Account(Name='Account1'),
           new Account()};

            Database.SaveResult[] srList = Database.insert(accts, false);

           attsettings.resultOfrecs(srList);
           try{
           attsettings.Save();
           }catch(Exception e){}
           try{
           attsettings.savedefAction();
           }catch(Exception e){} 
          // attsettings.resultOfrecs();
           
            }
            }
            }
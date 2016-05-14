/**
 Author : By Phani 
 Purpose : Test class for registration page
 Date : 28/01/2015 
 */
 
@isTest
private class Test_BLN_Registrationnew {

    static testMethod void myUnitTest() {
        //Test_BLN_ReUse_EventsEditCon tcon = new Test_BLN_ReUse_EventsEditCon();
        //Test_BLN_ReUse_EventsEditCon.Testmethod_BLN_ReUse_EventsEditCon();
        system.debug('AAAAAAAAAAAAAAAAAAAAa '+Test_BLN_ReUse_EventsEditCon.eventid);
        //string eventid =  Test_BLN_ReUse_EventsEditCon.eventid;
        globalForTestClass globalTest= new globalForTestClass();
        User u= new User();
        u= globalTest.createUserForGNUser();
        
        Company__c companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(u.Companyname);
        
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
        
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
        
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
        
        GN_User__c  gnUser= new GN_User__c();
        gnUser= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);
        
        BLN_Event__c eventInfo= new  BLN_Event__c();
        eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
           
        NAICS_Code__c naicsCodeInfo1 = new NAICS_Code__c();
        naicsCodeInfo1 =globalTest.createNaicsCode();
        
        
        NAICS_Code__c naicsCodeInfo2 = new NAICS_Code__c();
        naicsCodeInfo2 =globalTest.createNaicsCode();


        
        
        Company_Ext__c companyExtInfo = new Company_Ext__c();
        companyExtInfo = globalTest.createCompanyExt(CompanyInfo.id,naicsCodeInfo1.Id,naicsCodeInfo2.Id,countryInfo.Id,Stateinfo.Id);

        
        // Inserting item type with admission
        Item_Type__c insertItemType= new Item_Type__c();
        insertItemType.Name= 'Admissions';
        insertItemType.Badge_Label__c= 'BadgeLabel';
        insertItemType.Order__c=1;
        insertItemType.Add_On__c= False;
        insertItemType.Unlimited__c=false;
        insertItemType.Badgable__c = 'B - Badge';
        
        insert insertItemType;
        
        // inserting pool for admission ticket 
        Item_Pool__c insertItemPool= new Item_Pool__c();
        insertItemPool.Event__c= eventinfo.Id;
        insertItemPool.Item_Pool_Name__c= 'Admission';
        insertItemPool.item_type__c= insertItemType.id;
        insertItemPool.Item_Count__c= 12;
       // insertItemPool.Addon_Parent__c= insertItemType.id;
        insertItemPool.Addon_Count__c= 0;
        insertItemPool.Ticket_Settings__c   = 'Collect info from Buyers only';
        insert insertItemPool;
        
       // Inserting item
        BLN_Item__c insertItem= new BLN_Item__c();
        insertItem.item_name__c= 'Admission';
        insertItem.Item_Pool__c= insertItemPool.id;
        insertItem.item_type__c= insertItemType.id;
        insertItem.Visibility__c  ='public';
        insertItem.Event__c= eventinfo.Id;
        insertItem.price__c= 22.50;
        insertItem.Payment__c= 'Paid';
        insertItem.item_count__c= 12;
        insertItem.Taxable__c = false;
        insertItem.sale_start__c=System.today()-1;
        insertItem.sale_end__c=System.today()+2;
        insertItem.Ticket_Settings__c   = 'Collect info from Buyers only';
        insert insertItem;
        
       // insert promotion
        Promotion__c pro = new Promotion__c();
        pro.Promo_Code__c = 'Basic';
        pro.Promotion_Type__c = 'Basic Promo codes';
        pro.Condition_Type__c ='Quantity Threshold';
        pro.Discount_Type__c ='Percent';
        pro.Discount_Value__c =0.0;
        pro.Eff_TimeStamp__c = system.today();
        pro.Event__c = eventinfo.Id;
        pro.Exp_TimeStamp__c =system.today()+1;
        pro.I_Max_Count__c =12;
        pro.Status__c ='active';
        pro.T_Max_Count__c  =12;
        pro.T_Used_Count__c =0;
        pro.Type__c = 'Promo code';
        insert pro;
        
         PGateway_Type__c ptype = new PGateway_Type__c();
        ptype.Online_Flag__c = true;
        ptype.Onsite_Flag__c =true;
        ptype.Name = 'Cash';
        insert ptype;
        
        Pay_Gateway__c paygatecom = new Pay_Gateway__c();
        paygatecom.Company__c = CompanyInfo.id;
        paygatecom.PGateway_Type__c = ptype.id;
        insert paygatecom;
        
        Event_Pay_Gateway__c epay = new Event_Pay_Gateway__c();
        epay.Events__c = eventinfo.Id;
        epay.Pay_Gateway__c = paygatecom.id;
        epay.Registration_Type__c = 'Online';
        epay.Accept_Min_Max_Range__c = true;
        epay.Min_amount_to_accept__c = 100;
        insert epay;
        
        
        
       // insert item promocode
       Item_Promotion__c itp = new Item_Promotion__c();
       itp.Buy_Item__c = insertItem.id;
       itp.Item_Discount_Type__c = 'Percent';
       itp.Item_Discount_Value__c = 50;
       itp.Promotion__c = pro.id;
       insert itp;  
         
         Tkt_profile__c  tktprof = new Tkt_profile__c();
          tktprof=globalTest.createTktprofile(u);

         
        Order__c insertOrder1= new Order__c();
        insertOrder1= globalTest.createOrder(tktprof.Id, u.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
        
        Order_Item__c insertOrderItem = new Order_Item__c();        
        insertOrderItem =globalTest.createOrderItem(insertItem.id,insertOrder1.id,pro.id,currenyInfo.id);
        
        
        
        ticket__c ticket=new ticket__c();
        ticket=globalTest.createTicket(eventinfo.Id,insertitem.Id, insertItemPool.Id, insertItemType.Id,insertOrder1.Id, tktprof.id);
        
        Question__c que = new Question__c();
        que=globalTest.createQuestion(eventInfo.id);
        
        Item_Question__c itemQue = new Item_Question__c();
        itemQue =globalTest.createItemQuestion(eventInfo.id,insertItem.Id,que.Id);
         
       BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
                 
        User_Answer__c  usrAns = new User_Answer__c();
        usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
         
        pageReference pageRef = page.BLN_Registration_onlytickets;
        Test.setCurrentPage(pageRef);
        
        cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter});  
        
        ApexPages.currentPage().getParameters().put('id',eventinfo.id);
       
            BLN_RegistrationnewCon regcon = new BLN_RegistrationnewCon();
            regcon.promocode = 'Basic';
            regcon.registrationTemplate = new Registration_Template__c();
            //regcon.PayAddress = new Pay_Address__c();
            //regcon.testName = 'testStr';
           // regcon.Result = 'testStr';
            //regcon.PayAddress = new Pay_Address__c(); 
            //regcon.OrderFirstname = 'testStr';
            //regcon.OrderLastname = 'testStr';
           // regcon.OrderEmail = 'testStr';
            regcon.PaymentAddress1 = 'testStr';
            regcon.showtickettab = true;
            regcon.DisplaySettings = new LIST<Reg_Setting__c>();
            regcon.PackageInfo = 'TestString';
            regcon.selectedState  = 'TestString';
            regcon.states = new LIST<State__c>();
            regcon.naics1  = 'TestString';
            regcon.naics2= 'TestString';
            regcon.ShowPaymentError = true;
            regcon.PaymentErrorString = 'TestString';
            regcon.StripeSecret = 'TestString';
            regcon.StripeRefreshToken = 'TestString';
            regcon.ANLoginId = 'TestString';
            regcon.ApiUserName = 'TestString';
            regcon.Apipassword = 'TestString';
            regcon.Apisignature = 'TestString';
            regcon.ApiapplicationId = 'TestString';
            regcon.Apiipaddress = 'TestString';
            regcon.paypalUrl = 'TestString';
            regcon.ActionType = 'TestString';
            regcon.PaymentType = 'TestString';
            regcon.FeesPayer = 'TestString';
            regcon.PayeeEmail = 'TestString';
            regcon.FundingTypeEcheck = true;
            regcon.FundingTypeBalance = true;
            regcon.FundingTypeCreditCard = true;
            regcon.IsDisplay = true;
            regcon.APICredentialObjName = 'TestString';
            
            regcon.SuccessMessage = 'TestString';
            regcon.CommonParametersObjName = 'TestString';
            regcon.SenderEmail = 'TestString'; 
            regcon.EventType = 'TestString';
            regcon.displayButton = true;
            regcon.istestmethod = true;
            
            regcon.Mainmessage = 'TestString';
            regcon.CommnetsByEventadmin = 'TestString';
            
           // regcon.GNUserforbuyerfirstName = 'TestString';
           // regcon.GNUserforbuyerlastName = 'TestString';
           // regcon.GNUserforbuyeremail = 'TestString'; 
            
            regcon.gnbuyercomp = 'TestString';
            regcon.errorvalidateion = 'TestString';
            
            
            regcon.applyPromocodenew();
            regcon.isOrderCreated = true;
            try{
            	regcon.orderNow();
            }catch(exception e){}
        regcon.itpoolid=insertItemPool.id;
        regcon.itlabel = 'All';
        regcon.itoldqnty ='0';  
        regcon.applyPromocode();
        
            //regcon.RegItemList[0].TabLabel  ='All';
            LIST<Selectoption> itemWiseOptions = new LIST<Selectoption>();
            itemWiseOptions.add(new Selectoption('0','0'));
            BLN_RegistrationnewCon.ItemInnerClass itemincls=new BLN_RegistrationnewCon.ItemInnerClass(insertItem, itemWiseOptions, '10',.75,'test Package');
            //itemincls= regcon.ItemInnerClass(insertItem, itemWiseOptions, 10,.75,'test Package');
            LIST<BLN_Registrationnewcon.ItemInnerClass> iteminclsLst = new LIST<BLN_Registrationnewcon.ItemInnerClass>(); 
            iteminclsLst.add(itemincls);
            
            LIST<BLN_Answer__c> lstans = new LIST<BLN_Answer__c>();
            lstans.add(ans);
            
            LIST<SelectOption> lstselect = new LIST<SelectOption>();
            lstselect.add(null);
        
            BLN_RegistrationnewCon.UserAnswerInnerClass regtickinn = new BLN_RegistrationnewCon.UserAnswerInnerClass(que,lstans, lstselect, false, itemQue);
            List<String> stngarry = new List<String>{'abcd','bbbcd'};
            regtickinn.setSelectedAnswerCheck(stngarry);            
            
            regcon.validatePayment();
            regcon.orderId=insertOrder1.Id;
            Try { 
                regcon.callingPaymentMethod();
            } catch(exception ee) {}
        try {
            BLN_RegistrationnewCon.login('vineel.ragula@globalnest.com','Cameron');
        } catch (Exception ess){}    
            //regcon.logout();
            regcon.fetchNAICSCodes();
           // regcon.countryStates();
          //  regcon.statesBasedOnCountry();
            
        
            //regcon.RegItemInnerClass('testlabel',2,iteminclsLst);
            
            
        
        //regcon.completeRegistration();
            regcon.cpmdetails();
            // try{}catch(exception eeee){}
            BLN_RegistrationnewCon.getCompanies('regcon1','regcon2');
            regcon.checkCompany('regcon3');
            regcon.checkPersonalAccount('regcon4');
            LIST<id> tid=new LIST<id>();
            tid.add(ticket.id);
           // Bln_Scheduler_ticketStatus scCls =new Bln_Scheduler_ticketStatus(2,tid);
            //MyTestcode
            LIST<BLN_RegistrationnewCon.ItemInnerClass>   itmInnList = new LIST<BLN_RegistrationnewCon.ItemInnerClass>();    
             
            BLN_RegistrationnewCon.RegItemInnerClass regItemInner = new BLN_RegistrationnewCon.RegItemInnerClass('NewLabel',2.0,itmInnList);
            
            
           
            
            regcon.PaymentCall();
            //regcon.setCookieValues();
           try {
            BLN_RegistrationnewCon.getCompaniesext('globalnest'); } catch (Exception e) {}
            BLN_RegistrationnewCon.getCompanieswithid('globalnest','global');
            regcon.callingPaymentMethod();
            try{
            regcon.logout();
            } catch(exception e){}
            regcon.fetchSettings();
            regcon.cpmdetails();
            
             BLN_RegistrationnewCon.TicketInnerClass regItemInr1 = new BLN_RegistrationnewCon.TicketInnerClass();
           Ticket__c sampTkt = new Ticket__c();
            GN_User__c userGn = new GN_User__c();
            BLN_Item__c Itm = new BLN_Item__c();
            MAP<Id,LIST<Reg_Setting__c>> regMap = new MAP<Id,LIST<Reg_Setting__c>>();
            MAP<Id,LIST<Item_Question__c>> itemLstMap = new MAP<Id,LIST<Item_Question__c>>();          
            List<List<NAICS_Code__c>>  nAICSCodeList2 = new List<List<NAICS_Code__c>>();
            List<Diversity__c> divrs = new List<Diversity__c>();
           SET<id> polids = new SET<id>();
            polids.add(insertItemPool.Id) ;        
            BLN_RegistrationnewCon.TicketInnerClass regItemInr2 = new BLN_RegistrationnewCon.TicketInnerClass(sampTkt, 8,10,Itm,regMap,itemLstMap,companyExtInfo.id,true,nAICSCodeList2 ,divrs,polids);
            
         
            
            
            
    }
}
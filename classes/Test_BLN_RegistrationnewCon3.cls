@isTest(seeAllData=true)
public class Test_BLN_RegistrationnewCon3{
string fullUrl =  Site.getBaseUrl();
static testmethod void Testmethod_BLN_RegistrationnewCon3(){
  globalForTestClass globalTest= new globalForTestClass();
   Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

            User u = new User(alias = 'TestAb', email='manasatest@gmail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcodehh5689@noemail.com');
            Database.insert(u);
        
        
        
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
            
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
           
            PageReference pgRef = Page.BLN_Registration_Eventdex;
            Test.setCurrentPage(pgRef);
            
             
            Reg_Setting__c regSettingsInfo4= new Reg_Setting__c();
            regSettingsInfo4= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            list<Reg_Setting__c> regsettinginfo3 = new list<Reg_Setting__c>();
            regsettinginfo3.add(regSettingsInfo1);
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUserupd= [select id,Email__c from GN_User__c where id=:gnUser.id];
            gnUserupd.Email__c = 'manasatest@gmail.com';
            update gnUserupd;
            
           Tkt_profile__c  tktprof = new Tkt_profile__c();
           tktprof=globalTest.createTktprofile(userForGN);
           Tkt_profile__c  tktprofupd = new Tkt_profile__c();
           tktprofupd.Last_Name__c ='test';
           tktprofupd.id=tktprof.id;
           tktprofupd.TKT_Company__c='company';
           tktprofupd.Work_Phone__c = '123456';
           update tktprofupd;
             
           apexpages.currentpage().getparameters().put('id' , eventInfo.id);
           cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            
              
                Order__c insertOrder= new Order__c();
              
                    insertOrder.bln_tkt_profile__c=tktprof.id;
                    insertOrder.Events__c= eventInfo.Id;
                    insertOrder.Order_Total__c= 2;
                    insertOrder.Order_Status__c= 'Fully Paid';
                    insertOrder.Amount_Paid__c= 25.12;
                    insertOrder.Fee_Amount__c= 23.29;
                    insertOrder.Currency_Code__c= currenyInfo.Id;
                insert insertOrder ;
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
            Promotion__c Promotion= new Promotion__c();        
            Promotion =   globalTest.createPromotion(eventInfo.id,'testpormo', 'Basic Promo codes', 'Percent');
               Order_Item__c inOrderItem= new Order_Item__c();
              inOrderItem = globalTest.createOrderItem(item.id,insertOrder.id, Promotion.id, currenyInfo.Id);
              BLN_Reg_Main_Template__c tmpl=new BLN_Reg_Main_Template__c(BLN_Events__c=eventInfo.id,Data__c='<div class="row eventdexclass"></div>',structure_type__c='Registration Page',InUse__c=true,Theme_Name__c='Eventdex_Template_11'); 
              insert tmpl;
              Registration_Template__c rgtmpl = new Registration_Template__c(BLN_Events__c=eventInfo.id,Status__c='Active',Styles__c='#container{border:0px #ccc solid;background-color:#95f6ea;',Theme_Name__c='Aqua',Template_Image_URL__c='http://0158A0000008zWs');
              insert rgtmpl ;
              
               Reg_Setting__c RegSettings= new Reg_Setting__c();
               
                RegSettings.Event__c= eventInfo.id;
                RegSettings.Setting_Type__c= 'Registration Tab';
                RegSettings.Group_Name__c= 'Basic Information'; 
                RegSettings.Item__c= item.id;
                RegSettings.Item_Pool__c= ItemPool.id;
                RegSettings.Organizer__c= companyInfo.id;
                RegSettings.Included__c = true;
                RegSettings.Table_Name__c ='test';
                
                insert RegSettings;
              PGateway_Type__c pgway=new PGateway_Type__c(Name = 'Check',Onsite_Flag__c=true);
              insert pgway;
              Pay_Gateway__c pg=new Pay_Gateway__c(Company__c=companyInfo.id,PGateway_Type__c=pgway.id); 
              insert pg;
              Event_Pay_Gateway__c evpay=new Event_Pay_Gateway__c(Events__c=eventInfo.id,Pay_Gateway__c=pg.id,Registration_Type__c='Online');
              insert evpay;
              BLN_Template__c btempl=new BLN_Template__c(BLN_Reg_Main_Template__c=tmpl.id,BLN_Events__c=eventInfo.id,Template_Name__c='Eventdex_Template_11');
              insert btempl;
              BLN_Track__c BTRACK=NEW BLN_Track__c(Event__c=eventInfo.id,Name='TRACK1');
              insert BTRACK;
              Agenda__c agenda = new Agenda__c(Event__c=eventInfo.id,BLN_Ticket__c=ItemPool.id,Name='SEM1',Visibility__c='Public',BLN_Track__c=BTRACK.ID);
              insert agenda ;
              Currency__c cur=new Currency__c(Currency_Name__c='US Dollar',Name='USD',Currency_Symbol__c='INR');
              insert cur;
              Country__c scou=new Country__c(Currency__c=cur.id,Long_Name__c='United States Of America',Short_Name__c='US');
              insert scou;
              State__c state=new State__c(Long_Name__c='New Jersey',Short_Name__c='NJ',Country__c=scou.id);
              insert state;
              Company_Ext__c comext=new Company_Ext__c(Company__c=companyInfo.id,Blog_URL__c='http://1');
              insert comext;
              Role__c role=new Role__c(NAME='Company Admin');
              insert role;
              UC_Role__c ucr=new UC_Role__c(Company__c=companyInfo.id,Event__c=eventInfo.id,RoleId__c=role.id,GN_User__c=gnUser.id,User_Type__c='Personal');
              insert ucr;
              BLN_Address__c address=new BLN_Address__c(Address1__c='flat no 206',State__c=state.id,City__c='hyd',Country__c=scou.id);
              insert address;
            /*****************Calling class1****************************************/
              BLN_RegistrationnewCon3 regCls1 = new BLN_RegistrationnewCon3();
              
              regCls1.go();
              
            /***********************Calling class2******************************************/
              apexpages.currentpage().getparameters().put('Tab' , RegSettings.id);
                BLN_RegistrationnewCon3 regCls2 = new BLN_RegistrationnewCon3();
              
                regCls2.go();
                regCls2.AddedWidgets();
                regCls2.agendalist();
                BLN_RegistrationnewCon3.contactOrganiser('test@gmail.com','tstfirst','tstlast','tstem@gmail.com','good');
                regCls2.getSponsorList();
                regCls2.getSpeakerList();
                
               
            /******************************************************************************/
              BLN_RegistrationnewCon3  br2 = new  BLN_RegistrationnewCon3();
     
                    br2.SelectedPaymentGateway='Cash';
                   // br2.onloadmethod(eventInfo.id);
                    br2.countryStates();
                    br2.statesBasedOnCountry();
                    br2.fetchNAICSCodes();
                    br2.applyPromocode();    
                    br2.applyPromocodenew();
                   // br2.orderNow();
                    br2.callingPaymentMethod();
                    br2.PaymentCall();
                   // br2.validatePayment();
                    br2.cpmdetails();
                   // br2.logout();
            
            
            
            /******************************************************************************/
                test.starttest();
                  try{
                    BLN_RegistrationnewCon3.getsecondpagehtml(eventInfo.id,'Eventdex_Template_11');
                    }catch(Exception e){}
                     try{
                    BLN_RegistrationnewCon3.getIndividualwidgets(eventInfo.id,tmpl.id);
                     }catch(Exception e){}
               
                apexpages.currentpage().getparameters().put('buyerinform' , 'test');
                apexpages.currentpage().getparameters().put('attendeeinform' , 'test');
                try{
                   br2.getController();
                   }catch(Exception e){}
                    try{
                   br2.Complete_Registration();
                    }catch(Exception e){}
                    
               BLN_RegistrationnewCon3.getSecondaryBusinessCategory();
               BLN_RegistrationnewCon3.getPrimaryBusinessCategory();
               BLN_RegistrationnewCon3.getSuffixes();
               BLN_RegistrationnewCon3.getPrefixes();
               try{
               BLN_RegistrationnewCon3.statesBasedOnCountry(string.valueof(scou.id));
               }catch(Exception e){}
               BLN_RegistrationnewCon3.getCompanieswithid(string.valueof(companyInfo.id),'ss');
               BLN_RegistrationnewCon3.getCompaniesext(string.valueof(companyInfo.id));
               br2.checkPersonalAccount('hegotthelogic@gfcforce.com');
               br2.checkCompany(string.valueof(companyInfo.id));
               BLN_RegistrationnewCon3.getCompanies(string.valueof(companyInfo.id),'hegotthelogic@gfcforce.com');
               try{
               br2.fetchSettings();
               }catch(Exception e){}
                
                try{
                BLN_RegistrationnewCon3.login('testcodehh5689@noemail.com','global');
                }catch(Exception e){}
                try{
                br2.logout();
                }catch(Exception e){}
                br2.buyerTicketInn.tktProfileObject=tktprof ;
                br2.completeRegistration();
                br2.orderId=insertOrder.id;
                br2.setCookieValues();
                map<id,integer> itq=new map<id,integer>();
                itq.put(item.id,1);
                map<id,BLN_Item__c> itall=new map<id,BLN_Item__c>();
                itall.put(item.id,item);
                br2.mapItemobjWithQua = itall;
                br2.mapItemWithQuan=itq;
                 br2.calculateFee(itq);
                 br2.buyerTicketInn.workAddress=address;
                 br2.PaymentCall();
                 //br2.itemWiseCount.add(new SelectOption('1', '1'));
                 br2.ItemList.add(new BLN_RegistrationnewCon3.ItemInnerClass(item,null,'1',1.0,'package'));
                 try{
                 br2.orderNow();
                 }catch(Exception e){}
                 
                 BLN_RegistrationnewCon3.TicketInnerClass ticinn=new BLN_RegistrationnewCon3.TicketInnerClass();
                 ticinn.OrderNo=1;
                 ticinn.Ticket=null;
                 ticinn.customBarcode=null;
                 ticinn.Tag=null;
                 ticinn.selectedQuantity=null;
                 ticinn.BLNItem=null;
                 ticinn.RegSettingMap=null;
                 ticinn.QuestionMap=null;
                 ticinn.selectedCompnay=null;
                 ticinn.surveys=null;
                 ticinn.selectedNaicsCodes=null;
                 ticinn.selecteddivers=null;
                 ticinn.selectedCommodities=null;
                 ticinn.SpeakerPic1=null;
                 ticinn.SpeakerImageName1=null;
                 ticinn.CompanyPic1=null;
                 ticinn.CompanyImageName1=null;
                 ticinn.myfile1=null;
                 ticinn.myfilename1=null;
                 
                br2.PaymentGateways.add(new SelectOption('Credit Card', 'Credit Card'));
                br2.Password = '123';
                br2.PaymentAddress1 ='hyd';
                br2.selectedState = 'USA';
                br2.states =null;
                br2.RegistrationLinks =null;
                br2.QuestionsMap=null;
                br2.mapQueIdQithQue=null;
                br2.UserEventAnswer=null;
                br2.naics1=null;
                br2.naics2=null;
                br2.CreditCardNumber=null;
                br2.SelectedMonth=null;
                br2.CheckNumber=null;
                br2.CVVNumber=null;
                br2.ShowPaymentError=null;
                br2.PaymentErrorString=null;
                br2.StripeSecret=null;
                br2.StripeRefreshToken=null;
                br2.ANLoginId=null;
                br2.ANTransactionKey=null;
                br2.ApiUserName=null;
                br2.Apipassword=null;
                br2.Apisignature=null;
                br2.ApiapplicationId=null;
                br2.Apiipaddress=null;
                br2.paypalUrl=null;
                br2.ActionType=null;
                br2.PaymentType=null;
                br2.FeesPayer=null;
                br2.PayeeEmail=null;
                br2.BoothLeadsEmail=null;
                br2.FundingTypeEcheck=null;
                br2.FundingTypeBalance=null;
                br2.FundingTypeCreditCard=null;
                br2.IsDisplay=null;
                br2.APICredentialObjName=null;
                br2.PayResponse=null;
                br2.RespEnvp=null;
                br2.SuccessMessage=null;
                br2.CommonParametersObjName=null;
                br2.SenderEmail=null;
                br2.EventType=null;
                br2.displayButton=null;
                br2.Mainmessage=null;
                br2.CommnetsByEventadmin=null;
                br2.gnbuyercomp=null;
                br2.errorvalidateion=null;
                br2.ee=null;
                br2.widgets=null;
                br2.templatescript=null;
                br2.onlinepayment=null;
                br2.settingsForbuyer=null;
                br2.css=null;
                br2.bt=null;
                 br2.att=null;
                  br2.tickettemplatemap=null;
                  br2.fieldmap=null;
                  br2.itemfieldmap=null;
                  br2.tktcopyoptions=null;
                  br2.buyerfieldmapstring=null;
                  br2.eventidAfterEncoding=null;
                  br2.buyerTitle=null;
                  br2.EnablePoller=null;
                  try{
                 BLN_RegistrationnewCon3.UserAnswerInnerClass userans=new BLN_RegistrationnewCon3.UserAnswerInnerClass(null,null,null,null,null);
                 userans.Question=null;
                 userans.ItemAnswer=null;
                 userans.Answers=null;
                 userans.isRequired=null;
                 userans.SelectedAnswer=null;
                 userans.itq=null;
                   }catch(Exception e){}
                   BLN_RegistrationnewCon3.RegItemInnerClass regitemss=new BLN_RegistrationnewCon3.RegItemInnerClass(null,null,null);
                   try{
               BLN_RegistrationnewCon3.TicketInnerClass  stqereg=new BLN_RegistrationnewCon3.TicketInnerClass(null,null,null,null,null,null,null,null,null,null,null);
               }catch(Exception e){}
                test.stoptest();
           /*******************************************************************************/     
            }

}
}
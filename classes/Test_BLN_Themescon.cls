@isTest(SeeAllData=true)
public class Test_BLN_Themescon{
    static testmethod void Testmethod_BLN_Themescon(){
        
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
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);
            eventInfo.Organizer_Email__c = 'hegotthelogic@gfcforce.com';
            update eventInfo;
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            
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
               
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            
             Payment__c pay=new Payment__c();
             pay.Payment_Amount__c=10;
             pay.Order__c=insertOrder1.id;
             pay.Currency_Code__c=currenyInfo.id;
             pay.Payment_Mode__c='Check';
             insert pay;
             
             Registration_Template__c rtc=new Registration_Template__c(name='mytemplate',Template_Image_URL__c='https://upload.wikimedia.org/wikipedia/commons/3/33/Vanamo_Logo.png');
                insert rtc;
            
             cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
             ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            
             BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO();
             GNDAO.existingGnuser('hegotthelogic@gfcforce.com');
             BLN_Themescon themescon = new BLN_Themescon();
             
             themescon.csssave();
             BLN_Themescon.getThemes('theme1',eventInfo.id);
             BLN_Themescon.savesRegTempl(rtc.id,eventInfo.id);
             BLN_Themescon.getThemewithid(rtc.id);
             BLN_Themescon.updatetheme('tname','tcss',rtc.id);
             BLN_Themescon.updatethemename('tname',rtc.id);
             BLN_Themescon.deleteindividualtheam(rtc.id,eventInfo.id);
             BLN_Themescon.duplicatetheme('tname','tcss',rtc.id,eventInfo.id);
             BLN_Themescon.alltemplatenames(eventInfo.id);
             BLN_Themescon.allstandardthemes();
             BLN_Themescon.getAllThemes(eventInfo.id);
             BLN_Themescon.subwrapper subwrap = new BLN_Themescon.subwrapper(rtc,eventInfo.id);
             

           
            
        } 
    }
}
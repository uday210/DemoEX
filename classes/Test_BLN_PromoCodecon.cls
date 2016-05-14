@isTest
public class Test_BLN_PromoCodecon{
    static testmethod void Testmethod_BLN_PromoCodecon(){
    
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
                   
        Order_Item__c orderItem= new Order_Item__c();
        orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            
           Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c insertPromotion= new Promotion__c();
             insertPromotion.Name= 'promotion';
        insertPromotion.Promo_Code__c= 'mult-0001';
        insertPromotion.Event__c= eventInfo.id;
        insertPromotion.Eff_TimeStamp__c= system.today();
        insertPromotion.Exp_TimeStamp__c= system.today()+2;
        insertPromotion.Discount_Value__c = 8;
        insertPromotion.Discount_Type__c= 'Percent';
        insertPromotion.Promotion_Type__c= 'Basic Promo codes';
        insertPromotion.Status__c= 'Active and Enable for online registrations';
        insertPromotion.Type__c= 'Promo code';
        
        insert insertPromotion;
            
         Promotion__c insertPromotion1= new Promotion__c();
             insertPromotion1.Name= 'promotion';
        insertPromotion1.Promo_Code__c= 'mult-00012';
        insertPromotion1.Event__c= eventInfo.id;
        insertPromotion1.Eff_TimeStamp__c= system.today();
        insertPromotion1.Exp_TimeStamp__c= system.today()+2;
        insertPromotion1.Discount_Value__c = 8;
        insertPromotion1.Discount_Type__c= 'Percent';
        insertPromotion1.Promotion_Type__c= 'Multi-Items Discount';
        insertPromotion1.Status__c= 'Active and Enable for online registrations';
        insertPromotion1.Type__c= 'Promo code';
            
        insert insertPromotion1; 
            
            
            
            
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});            
            
            BLN_PromoCodecon promoCodeConTest=new BLN_PromoCodecon();
            
            ApexPages.CurrentPage().getParameters().put('chkArray',item.Id);     
            
            promoCodeConTest.displayPermissions();
            promoCodeConTest.gettypeoptions();
            promoCodeConTest.getstatusoptions();
            promoCodeConTest.promotionslist();
            promoCodeConTest.discountmenu();
         //promoCodeConTest.createbasicpromobool=true;
             promoCodeConTest.createbasicpromotion();
            
                promoCodeConTest.createpromotion();
                promoCodeConTest.createorderpromotion();
                promoCodeConTest.createbuyxgetypromotion();
                promoCodeConTest.additems();
                promoCodeConTest.addgetitems();
                promoCodeConTest.Addrangemethod();
                promoCodeConTest.deleteitempromoline();
                promoCodeConTest.deletefreeitempromoline();
                promoCodeConTest.deletespendmoreline();
                promoCodeConTest.cancelmethod();
                promoCodeConTest.savepromotion();
                promoCodeConTest.saveorderpromotion();
                promoCodeConTest.savebuyxgetxpromotion();
                promoCodeConTest.itempromotionslist.add(new item_Promotion__c(Promotion__c=promotion1.Id,Buy_Item__c=item.Id,Buy_Item_Quantity__c =2, Item_Discount_Value__c=2,Free_Item_Quantity__c =1,Item_Discount_Type__c='Parcent',Free_Item__c=item.id));
            //promoCodeConTest.itempromotionslist.add(new item_Promotion__c(Promotion__c=promotionslist[0].Id,Buy_Item__c=item.Id,Buy_Item_Quantity__c =2, Item_Discount_Value__c=2,Free_Item_Quantity__c =1,Item_Discount_Type__c='Parcent',Free_Item__c=item.id));

               Apexpages.Currentpage().getparameters().put('promoid',promotion1.Promo_Code__c);
                promoCodeConTest.editpromo();
                
                Apexpages.Currentpage().getparameters().put('promoid',promotion1.Promo_Code__c);
            promoCodeConTest.editpromo();
            
            Apexpages.Currentpage().getparameters().put('promoid',promotion1.Promo_Code__c );
            Apexpages.Currentpage().getparameters().put('promousedcount',string.valueOf(1));
            promoCodeConTest.DeletePromotion();
              BLN_PromoCodecon promoCodeConTest1=new BLN_PromoCodecon();
            promoCodeConTest1.additems();
            promoCodeConTest1.addgetitems();
            promoCodeConTest1.editpromobool=true;
            promoCodeConTest1.cancelmethod();
                        promoCodeConTest1.promotionslist.add(new Promotion__c(Promotion_Type__c = 'Basic Promo codes', Name ='Basic Promo Codes Test', Promo_Code__c ='JKH6576GF', Eff_TimeStamp__c =System.today(), Exp_TimeStamp__c=System.today()+4, Condition_Min_No__c=20, Discount_Type__c='Percent'));
     promoCodeConTest1.itempromotionslist.add(new item_Promotion__c(Buy_Item_Quantity__c =2, Item_Discount_Value__c=2));                              
            //promoCodeConTest1.itempromotionslist.add(new item_Promotion__c(Promotion__c=promotionslist[0].Id,Buy_Item__c=item.Id,Buy_Item_Quantity__c =2, Item_Discount_Value__c=2,Free_Item_Quantity__c =1,Item_Discount_Type__c='Parcent',Free_Item__c=item.id));
          promoCodeConTest1.promotionslist.add(new Promotion__c(Promotion_Type__c = 'Buy Something Get Something', Name ='Buy Something Get Something Test', Promo_Code__c ='JKH6576GF', Eff_TimeStamp__c =System.today(), Exp_TimeStamp__c=System.today()+4, Condition_Min_No__c=20, Discount_Type__c='Percent'));            
            promoCodeConTest1.itempromotionslist.add(new item_Promotion__c(Buy_Item_Quantity__c =2, Item_Discount_Value__c=2,Free_Item_Quantity__c =1));
            promoCodeConTest1.editpromobool=true;
            promoCodeConTest1.savebuyxgetxpromotion();
            
            Apexpages.Currentpage().getparameters().put('promo',promotion1.id );
             //promoCodeConTest1.editpromobool=false;
            
            //promoCodeConTest1.promotionslist.add(new Promotion__c(Promotion_Type__c = 'Basic Promo codes', Name ='Basic Promo Codes Test', Promo_Code__c ='JKH6576GF', Eff_TimeStamp__c =System.today(), Exp_TimeStamp__c=System.today()+4, Condition_Min_No__c=20, Discount_Type__c='Percent'));            
            //promoCodeConTest1.itempromotionslist.add(new item_Promotion__c(Buy_Item_Quantity__c =2, Item_Discount_Value__c=2));
            //promoCodeConTest1.savepromotion();
            
  

               Apexpages.Currentpage().getparameters().put('promoid',promotion1.Promo_Code__c);
            promoCodeConTest1.saveorderpromotion();
            promoCodeConTest1.refereshpage();
            BLN_PromoCodecon.getvalidationmethod(item.id,1000,4.5,'Amount');
            BLN_PromoCodecon promoCodeConTest2=new BLN_PromoCodecon();
          
              promoCodeConTest2.savepromotion();  
               
try{
               //Apexpages.Currentpage().getparameters().put('promoid',insertPromotion.Promo_Code__c);
                promoCodeConTest2.editpromo();
                }
                catch(exception e){}  
                promoCodeConTest2.createbasicpromobool=true;
                promoCodeConTest2.getitems();

                 promoCodeConTest2.selectedeventid= null;
                 promoCodeConTest2.getitems();
                 
                  BLN_PromoCodecon promoCodeConTest3=new BLN_PromoCodecon();
                  promoCodeConTest3.createbasicpromobool=false;
                promoCodeConTest3.getitems();
                
                //promoCodeConTest3.failuremessageset=null;
                 promoCodeConTest3.savepromotion();
                 try{
                    promoCodeConTest3.promotionslist.add(new Promotion__c(Promotion_Type__c = 'Multi-Items Discount', Name ='Buy Something Get Something Test', Promo_Code__c ='JKH6576GF', Eff_TimeStamp__c =System.today(), Exp_TimeStamp__c=System.today()+4, Condition_Min_No__c=20, Discount_Type__c='Percent'));  
                   Apexpages.Currentpage().getparameters().put('promotionslist[0].Promotion_Type__c',promotion2.Promo_Code__c);
                        promoCodeConTest3.editpromo();
                        }
                        catch(Exception e){}
                         BLN_PromoCodecon.getvalidationmethod(item.id,1000,400.5,'Amount');
           
                        
        } 
    }
}
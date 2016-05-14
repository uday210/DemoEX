global without sharing class  BLN_PromoCodecon{

    public String edtimezon { get; set; }

    public String stdatetimezon { get; set; }

   
     /***********************************************************************************************
    *   Controller Name         : BLN_PromoCodecon
    *   Date                    : 02/06/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for Add/Edit/Delete/view Promotions.
    **************************************************************************************************/
  
//--------------------Variables Declaration------------------------------------------------
  
    public BLN_UtillDisplayLinks promo { get; set; }
    Public LIST<Promotion__c> promotionslist{get;set;}
    Public Promotion__c promorecord{get;set;}
    Public LIST<Promotion__c> totpromotionslist{get;set;}
    Public MAP<Id,Promotion__c> promotionMAP{get;set;}
    Public MAP<String,List<Promotion__c>> promotioncodeMAP{get;set;}
    Public MAP<Decimal,Promotion__c> promotionslistMAP{get;set;}
    Public List<Item_Promotion__c> itempromotionslist{get;set;}
    Public List<Item_Promotion__c> freeitempromotionslist {get;set;}
    Public Item_Promotion__c iprecord{get;set;}
    Public MAP<Decimal,Item_Promotion__c> itmpromolineitemMAP{get;set;}
    Public MAP<Decimal,Item_Promotion__c> freeitmpromolineitemMAP{get;set;}
    Public MAP<Id,Item_Promotion__c> ItempromotionDupMAP{get;set;}
    Public MAP<Id,Item_Promotion__c> freeItempromotionDupMAP{get;set;}
    Public MAP<Id,BLN_Item__c> ItemMAP{get;set;}
    Public BLN_Event__c eventslist {get;set;}
    public List<SelectOption> itemnames{get; set;} 
    public List<SelectOption> discounttypes{get; set;} 
    public LIST<Selectoption> promotypeoptions{get; set;} 
    public LIST<Selectoption> promostatusoptions{get; set;}  
    public LIST<String> promostatus{get; set;}  
    Public Integer promousedcount {get; set;} 
    Public String promoid {get; set;} 
    Public Boolean menubool{get;set;} 
    Public Boolean createpromotionbool{get;set;} 
    Public Boolean createbasicpromobool {get;set;} 
    Public Boolean createitembool{get;set;} 
    Public Boolean createorderbool{get;set;}
    Public Boolean displaypromotionbool{get;set;}
    Public Boolean errormessagebool {get;set;}
    Public Boolean createbuygetbool {get;set;}
    Public Boolean editpromobool{get;set;} 
    Public Set<string> failuremessageset{get;set;} 
    Public string selectedeventid{get;set;}
    Public Decimal Uniqueno{get;set;}
    Public Decimal itemUniqueno{get;set;}
    Public String CheckTicketsforedit{get;set;}
    Public DateTime eventenddate{get;set;}
    Public string stringset{get;set;}
    Public string DupPromocodecheck{get;set;}
    Public DateTime TodaysDate{get;set;}
     public date dt{get;set;}
     public date edte{get;set;}
//-------------------------------------CONSTRUCTOR-----------------------------------------     
    
    public BLN_PromoCodecon(){
        promotionslist = new LIST<Promotion__c>();
     totpromotionslist= new LIST<Promotion__c>();
     promorecord = new Promotion__c();
     itempromotionslist = new LIST<Item_Promotion__c>();
     freeitempromotionslist = new LIST<Item_Promotion__c>();
     iprecord = new Item_Promotion__c();     
     itmpromolineitemMAP = new MAP<Decimal,Item_Promotion__c> ();
     freeitmpromolineitemMAP = new MAP<Decimal,Item_Promotion__c> ();
     freeItempromotionDupMAP =  new  MAP<Id,Item_Promotion__c>();
     promotionMAP= new MAP<Id,Promotion__c> ();
     promotionslistMAP = new MAP<Decimal,Promotion__c> ();
     promotioncodeMAP = new MAP<String,LIST<Promotion__c>>();
     itemnames = new List<SelectOption>();
     discounttypes = new List<SelectOption>();
     promostatusoptions= new List<SelectOption>();
     promotypeoptions = new List<SelectOption>();
     promostatus = new LIST<String>();
     failuremessageset = new Set<String>();
     ItemMAP = new MAP<Id,BLN_Item__c> ();
     eventslist  = new BLN_Event__c ();
     
          menubool = FALSE;
         createpromotionbool= FALSE;
         errormessagebool = FALSE;
         createitembool= FALSE;
         createorderbool= FALSE;
         createbuygetbool = FALSE;
         displaypromotionbool = TRUE;
         createbasicpromobool = FALSE;
         editpromobool   = FALSE;
      
     
   Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){
     selectedeventid = k.getValue();
     }
   
     system.Debug('EventId:' + selectedeventid );
      //selectedeventid= 'a0sc0000001oHlU';
     Date dToday = System.Today();
     TodaysDate  = Datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
     promousedcount= 0;
     promoid = '';
     DupPromocodecheck= '';
     Uniqueno = 0;
     itemUniqueno = 0;
     try{
     eventslist  = geteventdetails();
     if(eventslist.End_Date__c!= null){
        eventenddate = Datetime.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
        edte = Date.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
     }
     else{
         eventenddate = null;
     }
     }catch(exception e){}
     
      try{
      getpromotionslist();
      getitems();
      }catch(exception e){}
      
      //selectedeventid='a0sc0000003OJVk';
         dt=system.Today();     
    }
    
    
   public void displayPermissions(){
try{
     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
      BLN_Event__c  eventslist = new BLN_Event__c  ();
      try{
        eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }catch(exception e){}

         promo = new BLN_UtillDisplayLinks();
         promo.ispromocodesPage='active';
         promo.isTicketsPageExpand='expand';
         promo.tablabel='Promo Codes';
         try{
         promo.eventName = eventslist.Name;
         }catch(exception e){}
         promo.EventId= selectedeventid;
         promo.userPermissions(userInfo.getUserId(),selectedeventid);
         }catch(exception ex){}
    }

     // This Method is to retrieve promotion types options for the selected Event.
    
    Public List<SelectOption> gettypeoptions(){
        promotypeoptions = new List<SelectOption>();
        for(Schema.PicklistEntry pic: Promotion__c.Type__c.getDescribe().getPicklistValues()){
          
                if(pic.isDefaultValue()){
                        promorecord.Type__c = pic.getValue();
                 }
                promotypeoptions.add(new Selectoption(pic.getValue(), pic.getLabel()));       
        }
          return promotypeoptions;
   }
    
    // This Method is to retrieve promotion Status options for the selected Event.
     
    Public List<Selectoption> getstatusoptions(){
    
    
    
     promostatusoptions = new List<SelectOption>();
    for(Schema.PicklistEntry pic: Promotion__c.Status__c.getDescribe().getPicklistValues()){
          
                if(pic.isDefaultValue()){
                        promorecord.Status__c = pic.getValue();
                 }
                promostatusoptions.add(new Selectoption(pic.getValue(), pic.getLabel()));       
        }
          return promostatusoptions;
   }
     
     // This method is to retieve all the promotions for the selected event.
   
    
     Public void promotionslist(){
          getpromotionslist();
     }
    
    

    Public void getpromotionslist(){

         menubool = FALSE;
         createpromotionbool= FALSE;
         errormessagebool = FALSE;
         createitembool= FALSE;
         createorderbool= FALSE;
         createbuygetbool = FALSE;
         displaypromotionbool = TRUE;
         createbasicpromobool = FALSE;
         editpromobool   = FALSE;
        try{
        BLN_PromoCode_BAL blnpromotionsbal = New BLN_PromoCode_BAL();
        totpromotionslist= blnpromotionsbal.promotionslist(selectedeventid);
        }catch(Exception e){}
        System.debug('========promotionlist  ===============' + totpromotionslist.SIZE());
        stringset = '';  
         promotioncodeMAP= new MAP<string,LIST<Promotion__c>> ();
         promotionMAP= new MAP<Id,Promotion__c> ();
         if(totpromotionslist.SIZE()>0){
         
             for(Promotion__c p : totpromotionslist){
                  string code = p.Promo_Code__c;
                  promotionMAP.Put(p.Id,p);
                    
                    if(promotioncodeMAP.ContainsKey(code)){
              
                      LIST<Promotion__c> listnew = new LIST<Promotion__c>();
                      listnew = promotioncodeMAP.get(code);
                      promotioncodeMAP.remove(code);
                       listnew.add(p);
                      promotioncodeMAP.Put(p.Promo_Code__c,listnew);
                    }
                   else{
               
                      LIST<Promotion__c> listnew1 = new LIST<Promotion__c>();
                      listnew1.add(p);
                      promotioncodeMAP.Put(p.Promo_Code__c,listnew1);
                  }
              
              stringset += p.Promo_Code__c + '!@#$%';
           }
        
          System.Debug('===============promotioncodeMAPSize =====================' +promotioncodeMAP.size());  
            
            
                if(promotioncodeMAP.SIZE()>0){ 
                    totpromotionslist= new List<Promotion__c>();
                    for(List<Promotion__c> lp : promotioncodeMAP.values()){
                          totpromotionslist.add(lp[0]);  
                    } 
                }
       }
   
       system.debug('menuboolerr======'+menubool);
   
   }
   
    
    
    
    
    
    
    
// ----------------------------This Method displays different types of discounts user can build.--------------------------
    
    Public Void discountmenu(){
    
     menubool = TRUE;
     createpromotionbool= FALSE;
     createbasicpromobool = FALSE;
     errormessagebool = FALSE;
     createitembool= FALSE;
     createorderbool= FALSE;
     createbuygetbool = FALSE;
     displaypromotionbool = FALSE;
     editpromobool   = FALSE;
     
    }
    
// ----------------------------This method is To retrieve all the items for the selected event.--------------------------
    public List<BLN_Item__c> Itemslist;
    
    Public void getitems(){
         
         BLN_PromoCode_BAL blnItembal = New BLN_PromoCode_BAL();
         Itemslist = new List<BLN_Item__c>();
         Itemslist= blnItembal.itemslist(selectedeventid);
         
         itemnames  = new List<SelectOption>();
         ItemMAP = new MAP<Id,BLN_Item__c> ();
         
       if(Itemslist.size()>0){  
         
         
         if(createbasicpromobool == TRUE){
           itemnames.add(new SelectOption('a089000000Mg123456','Select All' ));  
           ItemMAP.PUT('a089000000Mg123456', new BLN_Item__c());

         }
         else{
          itemnames.add(new SelectOption('a089000000Mg123456','--None--' ));
          ItemMAP.PUT('a089000000Mg123456', new BLN_Item__c());
         }
         
           /* String itemcurrencycode = Itemslist[0].Currency_Code__c;
            
           
            BLN_PromoCode_BAL blncurrencybal = New BLN_PromoCode_BAL();
            Currency__c currencydetails = new Currency__c();
            currencydetails = blncurrencybal.getcurrencydetails(itemcurrencycode);*/
           
            for(BLN_Item__c items : Itemslist){
                if(items.item_name__c != null && items.Payment__c!='Free' && items.Payment__c!='Donation'){
                itemnames.add(new SelectOption(items.id,items.item_name__c ));
                ItemMAP.PUT(items.id, items );
                
                }
            } 
            
         discounttypes = new List<SelectOption>();
         discounttypes.add(new SelectOption('Percent','%' ));
        // discounttypes.add(new SelectOption('Amount',currencydetails.Currency_Symbol__c));
        discounttypes.add(new SelectOption('Amount','$' ));
      
         SYSTEM.DEBUG('=================ITEMMAP=====' + ItemMAP);
       }
       
       // If no Item Exists For the event----------------------------------------------------
       else{
               
         
         if(createbasicpromobool == TRUE){
           itemnames.add(new SelectOption('a089000000Mg123456','SELECT ALL' ));  
           ItemMAP.PUT('a089000000Mg123456', new BLN_Item__c());

         }
         else{
          itemnames.add(new SelectOption('a089000000Mg123456','--None--' ));
          ItemMAP.PUT('a089000000Mg123456', new BLN_Item__c());
         }
       
         discounttypes = new List<SelectOption>();
         discounttypes.add(new SelectOption('Percent','%' ));
         discounttypes.add(new SelectOption('Amount','$'));
       }
         
    }
      
  // -------------------------- This method is to Retrieve Event Details.--------------------------
      
           Public BLN_Event__c geteventdetails(){
         BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
         RETURN eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }
// -------------------------- This method is to Create Basic Promotion.-------------------------- 
 public string hosttzonecurrtime{get;set;}
 public string hosttzoneendtime{get;set;}
   Public void createbasicpromotion(){
    getpromotionslist();
    
     menubool = TRUE;
     createpromotionbool= FALSE;
     errormessagebool = FALSE;
     createbasicpromobool =TRUE;
     createitembool= FALSE;
     createorderbool= FALSE;
     createbuygetbool = FALSE;
     displaypromotionbool = FALSE;
     editpromobool   = FALSE;
      
      getitems();    
      DupPromocodecheck= '';  
      try{
      eventslist = geteventdetails();
      }catch(exception e){}
      promotionslist = NEW LIST<Promotion__c>();
      promorecord = NEW Promotion__c();
      
      promorecord.Event__c = selectedeventid;      
      promorecord.Condition_Type__c = 'Quantity Threshold';
      promorecord.Condition_Level__c = 'Item Level';
      promorecord.Promotion_Type__c = 'Basic Promo codes';


      Date dToday = System.Today();
      BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=eventslist.time_zone__c;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=System.now();
    hosttzonecurrtime=tz.getTimeZoneValue();
    
    tz.dateTimeValue=eventslist.End_Date__c;
    hosttzoneendtime=tz.getTimeZoneValue();
    
      //promorecord.Eff_TimeStamp__c = Datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
      if(eventslist.End_Date__c!= null){
      //promorecord.Exp_TimeStamp__c = Datetime.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
      }
      gettypeoptions();
      getstatusoptions();
      promotionslist.add(promorecord );
      
          itempromotionslist = new LIST<Item_Promotion__c>();
          iprecord = new Item_Promotion__c();
          iprecord.Buy_Item_Quantity__c = 1;
          
          itempromotionslist.add(iprecord);
          
          CheckTicketsforedit = '!@#$%^&';
       
    }
    
// -------------------------- This method is to Create Multi-item Promotion.--------------------------
    
    Public void createpromotion(){
     getpromotionslist();
     
              menubool = TRUE;
              errormessagebool = FALSE;
              createpromotionbool=TRUE;
              createitembool= TRUE;
              createorderbool= FALSE;
              createbuygetbool = FALSE;
              displaypromotionbool = FALSE;
              createbasicpromobool =FALSE;
              editpromobool   = FALSE;
    
    
      String  del = apexpages.currentpage().getparameters().get('guestindex');
      try{
      eventslist = geteventdetails();
      }catch(exception e){}
      DupPromocodecheck= '';
      promotionslist = NEW LIST<Promotion__c>();
      promorecord = NEW Promotion__c();
      
      promorecord.Event__c = selectedeventid;      
      promorecord.Condition_Type__c = 'Quantity Threshold';
      promorecord.Condition_Level__c = 'Item Level';
      promorecord.Promotion_Type__c = 'Multi-Items Discount';
      
      Date dToday = System.Today();
      promorecord.Eff_TimeStamp__c = Datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
      if(eventslist.End_Date__c!= null){
      promorecord.Exp_TimeStamp__c = Datetime.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
      }
      gettypeoptions();
      getstatusoptions();
      promotionslist.add(promorecord );
      
      itempromotionslist = new LIST<Item_Promotion__c>();
      iprecord = new Item_Promotion__c();
      iprecord.Buy_Item_Quantity__c = 1;
      iprecord.Buy_Item__c = 'a089000000Mg123456';
      itempromotionslist.add(iprecord);
      
      itmpromolineitemMAP=  new MAP<Decimal,Item_Promotion__c> ();
      uniqueNo = 0;
      itmpromolineitemMAP.put(uniqueNo ,iprecord);
      
     
       getitems();  
      
    }
    
  
    
//-------------------------- This method is to Create Order level Promotion(Method used in Spend More Save More Promotion).--------------------------
    
    
    Public void createorderpromotion(){
      getpromotionslist();
      
          menubool = TRUE;
          errormessagebool = FALSE;
          createpromotionbool=TRUE;
          createitembool= FALSE;
          createorderbool= TRUE;
          createbuygetbool = FALSE;
          displaypromotionbool = FALSE;
          createbasicpromobool =FALSE;
          editpromobool   = FALSE;
          
      try{
      eventslist = geteventdetails();
      }catch(exception e){}
      DupPromocodecheck= '';
      promotionslist = NEW LIST<Promotion__c>();
      promorecord = NEW Promotion__c();
      
      promorecord.Event__c = selectedeventid;
      promorecord.Condition_Type__c = 'Amount Threshold';
      promorecord.Condition_Level__c = 'Order Level';
      promorecord.Promotion_Type__c = 'Spend More Save More';
     
      Date dToday = System.Today();
      promorecord.Eff_TimeStamp__c = Datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
      if(eventslist.End_Date__c!= null){
      promorecord.Exp_TimeStamp__c = Datetime.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
      }
      
      gettypeoptions();
      getstatusoptions();
      promotionslist.add(promorecord);
      promotionslistMAP = new MAP<Decimal,Promotion__c> ();
      uniqueNo = 0;
      promotionslistMAP.PUT(uniqueNo,promorecord); 
      
    }
    
    
    
    
//-------------------------- This Method is to create BuyXGetY Promotion.-----------------------------
    
    Public void createbuyxgetypromotion(){
     getpromotionslist();
      menubool = TRUE;
      errormessagebool = FALSE;
      createpromotionbool=TRUE;
      createitembool= FALSE;
      createorderbool= FALSE;
      createbuygetbool = TRUE;
      displaypromotionbool = FALSE;
      createbasicpromobool =FALSE;
      editpromobool   = FALSE; 
      
      getitems();     
      try{
      eventslist = geteventdetails();
      }catch(exception e){}
      DupPromocodecheck= '';
      promotionslist = NEW LIST<Promotion__c>();
      promorecord = NEW Promotion__c();
      
      promorecord.Event__c = selectedeventid;
      promorecord.Condition_Type__c = 'Quantity Threshold';
      promorecord.Condition_Level__c = 'Item Level';
      promorecord.Promotion_Type__c = 'Buy Something Get Something';
      
      Date dToday = System.Today();
      promorecord.Eff_TimeStamp__c = Datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
      if(eventslist.End_Date__c!= null){
      promorecord.Exp_TimeStamp__c = Datetime.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
      }
      gettypeoptions();
      getstatusoptions();
      promotionslist.add(promorecord );
    
      itempromotionslist = new LIST<Item_Promotion__c>();
      iprecord = new Item_Promotion__c();
      iprecord.Item_Discount_Value__c = 0;
      iprecord.Buy_Item_Quantity__c = 1;
      iprecord.Buy_Item__c = 'a089000000Mg123456';
      itempromotionslist.add(iprecord);
       
      itmpromolineitemMAP=  new MAP<Decimal,Item_Promotion__c> ();
      uniqueNo = 0;
      itmpromolineitemMAP.put(uniqueNo ,iprecord);
      
      freeitempromotionslist = new LIST<Item_Promotion__c>();
      iprecord= new Item_Promotion__c();
      iprecord.Free_Item_Quantity__c = 1;
      iprecord.Free_Item__c = 'a089000000Mg123456';
      freeitempromotionslist.add(iprecord);
      
      freeitmpromolineitemMAP =  new MAP<Decimal,Item_Promotion__c> ();
      itemUniqueno = 0;
      freeitmpromolineitemMAP.put(itemUniqueno,iprecord);

   }
    
     
//-------------------------- This method is to Add Buy Items for Promotion.(Method used in both Multi-Items Discounts and BuyxGetY Discounts)--------------------------
    
    
    Public void additems(){
        
        BLN_PromoCode_BAL blnAdditembal = New BLN_PromoCode_BAL();
        failuremessageset = blnAdditembal.additem(itempromotionslist); 
    
      if(failuremessageset.size () == 0){
          iprecord = NEW Item_Promotion__c ();   
          if(createbuygetbool == TRUE){
             iprecord.Item_Discount_Value__c = 0;
           }
        
           iprecord.Buy_Item__c = 'a089000000Mg123456';
           itempromotionslist.add(iprecord);
        
           uniqueNo++;
           itmpromolineitemMAP.put(uniqueNo ,iprecord);
           SYSTEM.DEBUG('-----------------ITEMPRMOTIONS' + itmpromolineitemMAP);
        
           errormessagebool = False;
      }
      
      else{
        errormessagebool = TRUE;
       }
      
    }
    
    
//-------------------------- This method is to Add Free item in promotion.(Method used in BUYXGETY Promotion).--------------------------  
    
    
    
    Public void addgetitems(){
      
      BLN_PromoCode_BAL blnAdditembal = New BLN_PromoCode_BAL();
      failuremessageset = blnAdditembal.additem(freeitempromotionslist);
      
      if(failuremessageset.size () == 0){
      iprecord = new Item_Promotion__c();
      iprecord.Free_Item_Quantity__c = 1;
      iprecord.Free_Item__c = 'a089000000Mg123456';
      freeitempromotionslist.add(iprecord);
        itemUniqueno++;
        freeitmpromolineitemMAP.put(itemUniqueno,iprecord);
        SYSTEM.DEBUG('-----------------ITEMPRMOTIONS' + freeitmpromolineitemMAP);
         
         errormessagebool = False;
      }
      
      else{
        errormessagebool = TRUE;
       }
        
        
   }
   
   
//-------------------------- This method is to Add Amount Ranges for promotion.(Method used in Spend More Save More Promotion).--------------------------
   
    Public void Addrangemethod(){
    
      
      promorecord = NEW Promotion__c();
      promorecord.Event__c = selectedeventid;
      promorecord.Condition_Type__c = 'Amount Threshold';
      promorecord.Condition_Level__c = 'Order Level';
      promorecord.Promotion_Type__c = 'Spend More Save More';
      
      Date dToday = System.Today();
      promorecord.Eff_TimeStamp__c = Datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
      if(eventslist.End_Date__c!= null){
      promorecord.Exp_TimeStamp__c = Datetime.newInstance(eventslist.End_Date__c.year(), eventslist.End_Date__c.month(),eventslist.End_Date__c.day());
      }
      promotionslist.add(promorecord );
      uniqueNo++;
      promotionslistMAP.PUT(uniqueNo,promorecord); 
    
    }
    
   
    
//-------------------------- This method is to Delete a buy item in promotion.--------------------------
    
    Public void  deleteitempromoline(){
    
        
     errormessagebool = FALSE;
     
     String  del = apexpages.currentpage().getparameters().get('deletedId');
     
     SYSTEM.DEBUG('=========================== ' + del);
     SYSTEM.DEBUG('====5555555555555===== ' + itmpromolineitemMAP);
    
    BLN_PromoCode_BAL blndelitmpromobal = New BLN_PromoCode_BAL();
    itmpromolineitemMAP = blndelitmpromobal.deleteitempromoline(del,itmpromolineitemMAP);
    
    itempromotionslist  = NEW LIST<Item_Promotion__c>();
   // itempromotionslist = itmpromolineitemMAP.VALUES();
    
     Decimal Count = 0;
       system.debug('itmpromolineitemMAP:' + itmpromolineitemMAP); 
        for(Item_Promotion__c ipc :  itmpromolineitemMAP.values()){
    
            itempromotionslist.add(itmpromolineitemMAP.get(Count));
            Count++;
       }
          
    
      if(itempromotionslist.size() == 0){
            uniqueNo = -1;           
       } 
    }
    
//--------------------------This method is to delete free Item in Promotion(Method called in buyxgety promotion).--------------------------
    
    Public void  deletefreeitempromoline(){
    
    errormessagebool = FALSE;
    String  del = apexpages.currentpage().getparameters().get('deletedId');
     SYSTEM.DEBUG('==========del=========== ' + del);
     SYSTEM.DEBUG('====freeitmpromolineitemMAP===== ' + freeitmpromolineitemMAP);
    
    BLN_PromoCode_BAL blndelitmpromobal = New BLN_PromoCode_BAL();
    freeitmpromolineitemMAP = blndelitmpromobal.deleteitempromoline(del,freeitmpromolineitemMAP);
    
    freeitempromotionslist = NEW LIST<Item_Promotion__c>();
    //freeitempromotionslist = freeitmpromolineitemMAP.VALUES();
    
     Decimal Count = 0;
       system.debug('freeitmpromolineitemMAP:' + freeitmpromolineitemMAP); 
        for(Item_Promotion__c ipc :  freeitmpromolineitemMAP.values()){
    
            freeitempromotionslist.add(freeitmpromolineitemMAP.get(Count));
            Count++;
       }
    
      if(freeitempromotionslist.size() == 0){
            itemUniqueno = -1;           
       }
    }
  
  //--------------------------This method is to delete PromotionLineItem For SpendMore And SaveMore------------------
  
    Public void deletespendmoreline(){
    
    String  del = apexpages.currentpage().getparameters().get('deletedId');
    System.debug('==========del=========== ' + del);
    
    BLN_PromoCode_BAL blndelpromobal = New BLN_PromoCode_BAL();
    promotionslistMAP = blndelpromobal.deletepromoline(del,promotionslistMAP);
    
     System.debug('promotionslistMAP : ' + promotionslistMAP );
    
     promotionslist= NEW LIST<Promotion__c>();
    // promotionslist = promotionslistMAP.VALUES();
    
       Decimal Count = 0;

        for(Promotion__c ipc :  promotionslistMAP.values()){
    
            promotionslist.add(promotionslistMAP.get(Count));
            Count++;
       }
     
          if(promotionslistMAP.size() == 0){
                uniqueNo= -1;           
           }
     }
    
    
//-------------------------- This method is to Cancel promotion.--------------------------
    
    Public pageReference cancelmethod(){
    
            if(editpromobool == TRUE){
                  
                   SYSTEM.DEBUG('PromotionRecord: ' + promorecord);
        
                     menubool = FALSE;
                     createpromotionbool= FALSE;
                     errormessagebool = FALSE;
                     createitembool= FALSE;
                     createorderbool= FALSE;
                     displaypromotionbool = TRUE;
                     createbasicpromobool =FALSE;
                     editpromobool   = FALSE;
                     getpromotionslist();
            }
           
           else{
                     menubool = TRUE;
                     createpromotionbool= FALSE;
                     errormessagebool = FALSE;
                     createitembool= FALSE;
                     createorderbool= FALSE;
                     displaypromotionbool = FALSE;
                     createbasicpromobool =FALSE;
                     editpromobool   = FALSE;
            
            }
        PageReference page1 = new Pagereference('/apex/BLN_Promo_Code');
        page1.setRedirect(true);
        return page1;
    
   }
    
    
    
  
//-------------------------- This method is to save Basic And Multi-Items promotion.--------------------------
    
    Public void savepromotion(){
         SYSTEM.DEBUG('CheckedTicketids' + promoid  );
       failuremessageset = new set<String>(); 
      system.debug(promotionslist.size()+'  PRPMO TYPE '+promotionslist);
      
      if(promotionslist.size() >0){
          if(promotionslist[0].Promotion_Type__c == 'Basic Promo codes')
          {
                BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
               promotionslist[0].Eff_TimeStamp__c= timezonecl.getDateBasedOnEventTimeZone(stdatetimezon,selectedeventid);
               promotionslist[0].Exp_TimeStamp__c= timezonecl.getDateBasedOnEventTimeZone(edtimezon,selectedeventid);
               
                System.debug('####1'+promotionslist[0].Promotion_Type__c);
                String promoid  = Apexpages.Currentpage().getparameters().get('chkArray');
                SYSTEM.DEBUG('CheckedTicketids' + promoid  );
                BLN_PromoCode_BAL blnCheckitmpromotionsbal = New BLN_PromoCode_BAL();
                itempromotionslist= blnCheckitmpromotionsbal.basicitempromotions(promoid ,editpromobool,itempromotionslist,ItempromotionDupMAP);
          }
           
           
            if((promotionslist[0].Promotion_Type__c == 'Multi-Items Discount' || promotionslist[0].Promotion_Type__c == 'Basic Promo codes')  &&  editpromobool == TRUE ){
                BLN_PromoCode_BAL blndelitmpromotionsbal = New BLN_PromoCode_BAL();
                failuremessageset = blndelitmpromotionsbal.deletemethod(itempromotionslist,ItempromotionDupMAP,freeitempromotionslist,freeItempromotionDupMAP);
           }  
        
           if(failuremessageset.size() == 0){ 
           BLN_PromoCode_BAL blnSavepromotionsbal = New BLN_PromoCode_BAL();
            failuremessageset = blnSavepromotionsbal.upsertpromotion(promotionslist,itempromotionslist);
            
            if(failuremessageset.size() == 0){
            
                if(editpromobool == TRUE){
                SYSTEM.DEBUG('EDIT EDIT EDIT ');
                     menubool = FALSE;
                     createpromotionbool= FALSE;
                     errormessagebool = FALSE;
                     createitembool= FALSE;
                     createorderbool= FALSE;
                     displaypromotionbool = TRUE;
                     createbasicpromobool =FALSE;
                     editpromobool   = FALSE;
                     getpromotionslist();
               }
               else{
                     menubool = TRUE;
                     createpromotionbool= FALSE;
                     errormessagebool = FALSE;
                     createitembool= FALSE;
                     createorderbool= FALSE;
                     displaypromotionbool = FALSE;
                     createbasicpromobool =FALSE;
                     editpromobool   = FALSE;
                     system.debug('menubool===='+menubool);
                      system.debug('createpromotionbool===='+createpromotionbool);
                       system.debug('errormessagebool===='+errormessagebool);
                        system.debug('createitembool===='+createitembool);
                         system.debug('createorderbool===='+createorderbool);
                          system.debug('displaypromotionbool===='+displaypromotionbool);
                           system.debug('createbasicpromobool===='+createbasicpromobool);
                          system.debug('editpromobool===='+editpromobool);
                          
                   getpromotionslist();
                   refereshpage();
                      system.debug('menubool123===='+menubool);
                     
               }          
               
                
           }
          else{
             
              errormessagebool = TRUE;
          }
     
        }
         else{
              errormessagebool = TRUE;
         }
    }
    
   }
     public String itemidTemp{get;set;}
   public pagereference refereshpage(){
   system.debug('rrrrrr');
   //itemidTemp= Apexpages.Currentpage().getparameters().get('chkArray');
   //getpromotionslist();
   PageReference page1 = new Pagereference('/apex/BLN_promo_code');
        page1.setRedirect(true);
        promotionslist();
       // savepromotion();
       // getvalidationmethod(quentcheck,byqucheck, pricedistype);
        return page1;
   }
//-------------------------- This method is to save Order promotion.--------------------------
     
   Public void saveorderpromotion(){
              
              SYSTEM.DEBUG('==========promotionslist===============' + promotionslist);
              SYSTEM.DEBUG('====promotionMAP==============' + promotionMAP);
              
      failuremessageset = new Set<String>();        
       
       if(editpromobool == TRUE) 
       {     
          MAP<Id,Promotion__C> promotionDUPMAP = NEW MAP<Id,Promotion__C>();
              for(Promotion__C p : promotionslist){
                  promotionDUPMAP.Put(p.id,p);
              }
              List<Promotion__c> delpromotionlsit = new List<Promotion__c>();
              for(Promotion__c ipl :promotionMAP.values()){
                       if(!promotionDUPMAP.containskey(ipl.id))
                       {
                           delpromotionlsit.add(ipl);
                       }
              }
              if(delpromotionlsit.size()>0){
           
                 BLN_PromoCode_BAL blndelpromotionsbal = New BLN_PromoCode_BAL();
                 itempromotionslist = new List<Item_Promotion__c>();
                 failuremessageset = blndelpromotionsbal.deletepromotionandip(delpromotionlsit,itempromotionslist);
            
              }
              
        } 
       if(failuremessageset.size() == 0){       
              
              BLN_PromoCode_BAL blnsaveorderpromobal = New BLN_PromoCode_BAL();
              failuremessageset = blnsaveorderpromobal.saveorderpromotion(promotionslist);
              
          if(failuremessageset.size() == 0){
            
                errormessagebool = FALSE;
                createitembool= FALSE;
                createorderbool= FALSE;
                createpromotionbool= FALSE;           
                createbasicpromobool =FALSE;
            
                if(editpromobool == TRUE){
                     menubool = FALSE;                 
                     displaypromotionbool = TRUE;                 
                     editpromobool   = FALSE;
                     createorderbool= FALSE;
                      getpromotionslist();
                }
                else{
                    createorderbool= FALSE;
                    menubool = TRUE;
                   displaypromotionbool = FALSE;                 
    
                }            
      
         }
        else{
                errormessagebool = TRUE;
        }
     }   
     else{
        errormessagebool = TRUE;
       }
    
   }
   
   
//-------------------------- This method is to save BUYXGETY promotion.--------------------------
     
    
     Public void savebuyxgetxpromotion(){
    

       
      SYSTEM.DEBUG('===========freeitempromotionslist==============' + freeitempromotionslist);
       SYSTEM.DEBUG('===========freeitempromotionslist==============' + freeItempromotionDupMAP);
        SYSTEM.DEBUG('===========itempromotionslist==============' + itempromotionslist);
       SYSTEM.DEBUG('===========ItempromotionDupMAP==============' + ItempromotionDupMAP);
       failuremessageset = new set<String>();
        
        if(editpromobool == TRUE ){
            BLN_PromoCode_BAL blndelitmpromotionsbal = New BLN_PromoCode_BAL();
            failuremessageset = blndelitmpromotionsbal.deletemethod(itempromotionslist,ItempromotionDupMAP,freeitempromotionslist,freeItempromotionDupMAP);
        }  
       
       if(failuremessageset.size() == 0){ 
       
          System.debug('=========freeitempromotionslist===' + freeitempromotionslist);
       BLN_PromoCode_BAL blnsaveorderpromobal = New BLN_PromoCode_BAL();
       failuremessageset = blnsaveorderpromobal.savebuyxgetypromotion(promotionslist,itempromotionslist,freeitempromotionslist);
      
          
          if(failuremessageset.size() == 0){
        
            if(editpromobool == TRUE){
                 menubool = FALSE;
                 createpromotionbool= FALSE;
                 errormessagebool = FALSE;
                 createitembool= FALSE;
                 createorderbool= FALSE;
                 displaypromotionbool = TRUE;
                 createbasicpromobool =FALSE;
                 editpromobool   = FALSE;
                  getpromotionslist();
           }
           else{
                 menubool = TRUE;
                 createpromotionbool= FALSE;
                 errormessagebool = FALSE;
                 createitembool= FALSE;
                 createorderbool= FALSE;
                 displaypromotionbool = FALSE;
                 createbasicpromobool =FALSE;
                 editpromobool   = FALSE;
           }          
           
         }   
        
          else{
            errormessagebool = TRUE;
          }
      }   
        
      else{
        errormessagebool = TRUE;
      }
     }
    

// This method is to edit promotion.
    public string edithosttzonecurrtime{get;set;}
    public string edithosttzoneendtime{get;set;}
    
    public void  editpromo(){
     
      gettypeoptions();
      getstatusoptions();
      getpromotionslist();
      try{
      eventslist = geteventdetails();
      }catch(exception e){}
      
         promoid  = Apexpages.Currentpage().getparameters().get('promoid');
         
         SYSTEM.DEBUG('promoid:  ' + promotioncodeMAP);
         promotionslist = new List<Promotion__c>();
         SYSTEM.DEBUG('promotioncodeMAP:  ' + promotioncodeMAP.get(promoid));
         promotionslist = promotioncodeMAP.get(promoid); 
         SYSTEM.DEBUG('promotionslist:  ' + promotionslist);
       
         BLN_PromoCode_BAL blneditpromobal = New BLN_PromoCode_BAL();
         itempromotionslist = blneditpromobal.getItemPromotions(promotionslist[0].id);
         SYSTEM.DEBUG('itempromotionslist :  ' + itempromotionslist.size());
      
         DupPromocodecheck = promotionslist[0].Promo_Code__c;
     
     
     if(promotionslist[0].Promotion_Type__c =='Basic Promo codes'){
        
        CheckTicketsforedit= '!@#$%^&';
        ItempromotionDupMAP= new MAP<ID,Item_Promotion__c>();
          if(itempromotionslist.size()>0){
              for(Item_Promotion__c iprecord : itempromotionslist )
                  {
                      CheckTicketsforedit += iprecord.Buy_Item__c + '!@#$%^&';
                      //ItempromotionDupMAP.put(iprecord.Buy_Item__c,iprecord);
                      ItempromotionDupMAP.put(iprecord.ID,iprecord);
                      
                  }
          }
          SYSTEM.DEBUG('CheckTicketsforedit' + CheckTicketsforedit );
                 
              menubool = FALSE;
              createpromotionbool= FALSE;
              errormessagebool = FALSE;
              createbasicpromobool =TRUE;
              createitembool= FALSE;
              createorderbool= FALSE;
              createbuygetbool = FALSE;
              displaypromotionbool = TRUE;
              editpromobool   = TRUE;
             
             promorecord.Type__c =  promotionslist[0].Type__c;
             promorecord.Status__c =  promotionslist[0].Status__c ;
            
            BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
            tz.tZone=eventslist.time_zone__c;
            tz.format='MM/dd/yyyy hh:mm a';
            tz.dateTimeValue=promotionslist[0].Eff_TimeStamp__c;
            edithosttzonecurrtime=tz.getTimeZoneValue();
            
            tz.dateTimeValue=promotionslist[0].Exp_TimeStamp__c;
            edithosttzoneendtime=tz.getTimeZoneValue();
            
             getitems();      
               
               
     }
     
     if(promotionslist[0].Promotion_Type__c =='Multi-Items Discount'){ 
          
          
          
          if(itempromotionslist.size()>0){
          ItempromotionDupMAP= new MAP<ID,Item_Promotion__c>();
          itmpromolineitemMAP=  new MAP<Decimal,Item_Promotion__c> ();
          uniqueNo = -1;
          for(Item_Promotion__c iprecord : itempromotionslist )
              {
                uniqueNo++;
                itmpromolineitemMAP.put(uniqueNo ,iprecord);
                //ItempromotionDupMAP.put(iprecord.Buy_Item__c,iprecord);
                ItempromotionDupMAP.put(iprecord.Id,iprecord);
              }
          }
          System.debug('34235345dgfg ' + ItempromotionDupMAP);      
          
               menubool = FALSE;
               errormessagebool = FALSE;
               createpromotionbool=TRUE;
               createitembool= TRUE;
               createorderbool= FALSE;
               createbuygetbool = FALSE;
               displaypromotionbool = TRUE;
               createbasicpromobool =FALSE;
               editpromobool   = TRUE;
               getitems();
     
     }
     
     if(promotionslist[0].Promotion_Type__c =='Spend More Save More'){   
          promotionMAP = new MAP<Id,Promotion__c>();
          if(promotionslist.size()>0){
              promotionslistMAP = new MAP<Decimal,Promotion__c> ();
              
              uniqueNo = -1;
            System.debug('34235345dgfg ' + promotionslist.size());       
            for(Promotion__c promorecord :promotionslist){
             uniqueNo++; 
              promotionslistMAP.PUT(uniqueNo,promorecord);
              
              promotionMAP.Put(promorecord.ID,promorecord); 
            }
          }
        
      
          menubool = FALSE;
          errormessagebool = FALSE;
          createpromotionbool=TRUE;
          createitembool= FALSE;
          createorderbool= TRUE;
          createbuygetbool = FALSE;
          displaypromotionbool = TRUE;
          createbasicpromobool =FALSE;
          editpromobool   = TRUE;          
     } 
    
     if(promotionslist[0].Promotion_Type__c =='Buy Something Get Something'){ 
          
          List<Item_Promotion__c> Buylist= new List<Item_Promotion__c>();
          LIST<Item_Promotion__c> freelist = new LIST<Item_Promotion__c>();
          freeitmpromolineitemMAP =  new MAP<Decimal,Item_Promotion__c> ();
          ItempromotionDupMAP= new MAP<ID,Item_Promotion__c>();
          freeItempromotionDupMAP= new MAP<ID,Item_Promotion__c>();
          itemUniqueno = -1;
          uniqueNo = -1;
          
                      SYSTEM.DEBUG('itempromotionslistitempromotionslist' + itempromotionslist);
            for(Item_Promotion__c iprecord :itempromotionslist){
             SYSTEM.DEBUG('iprecord iprecord iprecord ' + iprecord );
                if(iprecord.Item_Discount_Value__c != 0.00){
                    freelist.add(iprecord);
                    itemUniqueno ++;
                     freeitmpromolineitemMAP.put(itemUniqueno,iprecord);
                     freeItempromotionDupMAP.put(iprecord.Id,iprecord);
                }
                else{
                
                 Buylist.add(iprecord); 
                   uniqueNo++;
                   itmpromolineitemMAP.put(uniqueNo ,iprecord);
                   ItempromotionDupMAP.put(iprecord.Id,iprecord);

                
                }
             }
           itempromotionslist = new LIST<Item_Promotion__c>();
            itempromotionslist.addAll(Buylist);
            freeitempromotionslist= new LIST<Item_Promotion__c>();
            freeitempromotionslist.addAll(freelist);
            SYSTEM.DEBUG('BUYITEMSLIST' + freeItempromotionDupMAP);
            SYSTEM.DEBUG('GETITEMSLIST' + freeitempromotionslist);
             
              menubool = FALSE;
              errormessagebool = FALSE;
              createpromotionbool=TRUE;
              createitembool= FALSE;
              createorderbool= FALSE;
              createbuygetbool = TRUE;
              displaypromotionbool = TRUE;
              createbasicpromobool =FALSE;
              editpromobool   = TRUE;    
               getitems();
      SYSTEM.DEBUG('===============promotionslistSIZE============='+promotionslist);
      
      
       }
      
   }

// --------------------This Method is to make Promomotion Inactive Or Delete-------------------------------------------------

  public void DeletePromotion(){

    promoid  = Apexpages.Currentpage().getparameters().get('promoid');
    promousedcount= Integer.Valueof(Apexpages.Currentpage().getparameters().get('promousedcount'));
    
          SYSTEM.DEBUG('promoid  ' + promoid  );
          SYSTEM.DEBUG('promousedcount' + promousedcount);
          promotionslist = new List<Promotion__C>();
          promotionslist = promotioncodeMAP.get(promoid); 
          
           
          SYSTEM.DEBUG('PromotionRecord ' + promotionslist );
          BLN_PromoCode_BAL blneditpromobal = New BLN_PromoCode_BAL();
          itempromotionslist = blneditpromobal.getItemPromotions(promotionslist[0].id);
    SYSTEM.DEBUG('itempromotionslist : ' + itempromotionslist );
   
    If(promousedcount!=0){     // Making Promotion Inactive if Usedcount>0
         
          promotionslist[0].status__c = 'Inactive';
          BLN_PromoCode_BAL blnSavepromotionsbal = New BLN_PromoCode_BAL();
          failuremessageset = blnSavepromotionsbal.upsertpromotion(promotionslist,itempromotionslist);
          if(failuremessageset.size()==0){
              getpromotionslist();
          }
          
         else{
            errormessagebool = TRUE;
          }         
          
     }
     
     else{                  // Deleting Promotion If Used Count = 0;
         
         BLN_PromoCode_BAL blndelitmpromotionsbal = New BLN_PromoCode_BAL();
         failuremessageset = blndelitmpromotionsbal.deletepromotionandip(promotionslist,itempromotionslist);
        
         
         if(failuremessageset.size()==0){
           
              getpromotionslist();
              
          }
          
         else{
            errormessagebool = TRUE;
          }
     
     }
     

  }
  @RemoteAction
global static string[] getvalidationmethod( string quentcheck,integer byqucheck, decimal price,string distype){
     list<BLN_Item__c> listitems;
     list<BLN_Item__c> listofitemeswithmoreqt;
     string[] arrvalid ;
     arrvalid= new list<string>();
     string ticketndquantity = ' ';
     string ticketprice = ' ';
     boolean iteprice;
    // listitems= new list<BLN_Item__c>();
    system.debug('@@@@@@@@@'+distype);
    List<String> itemqun = new List<String>();
    itemqun = quentcheck.split('-');
        system.debug('@@@@@@@@@'+itemqun);
       listofitemeswithmoreqt = new list<BLN_Item__c>();
      listitems=[select id,item_count__c,item_name__c,Event__c,price__c from BLN_Item__c where Id IN :itemqun]; 
      for(BLN_Item__c ite:listitems){
      if(byqucheck > ite.item_count__c){
      iteprice=true;
      listofitemeswithmoreqt.add(ite);
      
      }
      else if(price > ite.price__c && distype=='Amount'){
      iteprice=false;
      listofitemeswithmoreqt.add(ite);
      }
      }
      if(listofitemeswithmoreqt.size()>0){
     
      for(BLN_Item__c ite:listofitemeswithmoreqt){
      if(iteprice== true){
      ticketndquantity =ticketndquantity+ite.item_name__c+' '+'Max Quantity is'+'   '+ite.item_count__c+'-';
      system.debug('listitems===='+ticketndquantity); 
      }
      else{
      system.debug('rahebd');
       ticketprice=ticketprice+ite.item_name__c+' '+'ticket price is'+'   '+ite.price__c+'-';
    system.debug('rahebd'+ticketprice);
   }
      }
      }else{
      if(iteprice== true){
      ticketndquantity = '';
      }
      else{
      ticketprice='';
      }
      }
     
      arrvalid.add(ticketndquantity) ;
      arrvalid.add(ticketprice);
  system.debug('ticketndquantit====='+arrvalid[1]);
return arrvalid;
}

}
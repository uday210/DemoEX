public without sharing class BLN_PromoCode_BAL{

/***********************************************************************************************
    *   Controller Name         : BLN_PromoCode_BAL
    *   Date                    : 02/06/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for executing business Logic on Promotions and Item Promotions.
    **************************************************************************************************/

Public SET<STRING> failuremessageset {get;set;}
Public Map<String, String> findDupitems {get;set;}
Public LIST<Item_Promotion__c> itempromotionslist {get;set;}
Public Decimal Uniqueno{get;set;}
Public MAP<Id,Item_Promotion__c> ItempromotionMAP{get;set;}
Public MAP<Id,Item_Promotion__c> ItempromotionDupMAP{get;set;}
Public List<Item_Promotion__c> delitempromolist {get;set;}
Public Item_Promotion__c iprecord {get;set;}
Public LIST<Promotion__c> promotionslist {get;set;}

//------------------ This method is To retrieve details of selected event.--------------------------.

  Public BLN_Event__c eventdetails(String evntid){

         BLN_Event_DAO blneventsdao= NEW BLN_Event_DAO();
         List<BLN_Event__c> eventslist = blneventsdao.getEventDetails(evntid);
         return eventslist[0]; 
  }


//------------------ This method is To retrieve all the items for the selected event--------------------------.

    Public List<BLN_Item__c> itemslist(String evntid){
    
        system.debug('-----------EVENTID-------'+evntid);
         BLN_Item_DAO blntemsdao= NEW BLN_Item_DAO();
         List<BLN_Item__c> itemslist = blntemsdao.getEventItems(evntid);
         return itemslist;
       
    }
    
    //------------------ This method is To retrieve all the item pools for the selected event--------------------------.

    Public List<Item_Pool__c> itemPoollist(String evntid){
         BLN_Item_DAO blntemsdao= NEW BLN_Item_DAO();
         List<Item_Pool__c> itemPoollist = blntemsdao.getEventItemPools(evntid);
         return itemPoollist;
    }
    
    // ---------------- This method is to retrieve currency Details for the event-----------------------.
   
    Public Currency__c getcurrencydetails(String Currencyid){ 
        BLN_Currency_DAO  blncurrencydao= NEW BLN_Currency_DAO ();
        Currency__c currencydetails = new Currency__c();
        
        RETURN currencydetails = blncurrencydao.getCurrencyDetails('ID,NAME, Currency_Name__c, Currency_Symbol__c','ID=\''+Currencyid+'\'');
      
    }
    
    
    // ---------------- This method is to retrieve promotionslist for the event-----------------------.
    
    Public List<Promotion__c> promotionslist(String evntid){
    
        system.debug('-----------EVENTID-------'+evntid);
        
        BLN_Promotion_DAO blnpromotionsdao= NEW BLN_Promotion_DAO();
        List<Promotion__c> promotionlist = new List<Promotion__c>();
        
        return promotionlist = blnpromotionsdao.promotionslist('Event__c=\''+evntid+'\'');
    }
   
    
    // --------------------------------------------- Edit by Mahesh Sakunala ------------------------------------ START -------------------------------
    
    // ------------------------------- Method for retrieving promotion for a particular event ------------------- START -------------------------------
    public LIST<Promotion__c> getPromotionDetails(String EventId,String Promocode){
    
        system.debug('Event Id : '+EventId);
        system.debug('Promotion : '+Promocode);
        
        BLN_Promotion_DAO PromotionDAO = new BLN_Promotion_DAO();
        LIST<Promotion__c> PromotionsList = PromotionDAO.promotionslist('Event__c=\''+EventId+'\' AND Promo_Code__c=\''+Promocode+'\'');
        
        if(PromotionsList.size()>0){
            return PromotionsList;
        }
        else{
            return null;
        }
    }
    // ------------------------------- Method for retrieving promotion for a particular event ---------------------- END ------------------------------
    
    // ------------------------------- Method for retrieving Item Promotions based on EventId & Promotion Id ------- START ----------------------------
    public LIST<Item_Promotion__c> getItemPromotions(String PromotionId){
        
        system.debug('Promotion Id : '+PromotionId);
        
        BLN_ItemPromotion_DAO ItemPromotionDAO = new BLN_ItemPromotion_DAO();
        LIST<Item_Promotion__c> ItemPromotionsList = ItemPromotionDAO.getItemPromotions(PromotionId);
        return ItemPromotionsList;
    }
    // ------------------------------- Method for retrieving Item Promotions based on EventId & Promotion Id -------- END -----------------------------
    
    // --------------------------------------------- Edit by Mahesh Sakunala ------------------------------------- END --------------------------------


    // ------------------------This method is to add an item.-------------------------------------------------

    
    Public SET<STRING> additem(LIST<Item_Promotion__c> itempromlist){
    
     failuremessageset = new SET<STRING>();
         Map<String, String> findDupitems = new Map<String, String>();  
        if(itempromlist.size()>0){
          for(Item_Promotion__c ipl: itempromlist) { 
        system.debug('Buy Item  :' + ipl.Buy_Item__c );
            try{
            if(ipl.Buy_Item__c != null)
             {     
                    if(findDupitems.containsKey(ipl.Buy_Item__c)){
                       failuremessageset.add('Error: Duplicate Ticket found, please change the Ticket');  
                    }
                    else{    
                         findDupitems.put(ipl.Buy_Item__c, ipl.Buy_Item__c);
                    }
             }
              if(ipl.Buy_Item__c == 'a089000000Mg123456'){
                 failuremessageset.add('Error: Please Select Buy Ticket from the list.');  
              }  
          
          
          if(ipl.Free_Item__c != null)
             {     
                    if(findDupitems.containsKey(ipl.Free_Item__c)){
                       failuremessageset.add('Error: Duplicate Ticket found, please change the Ticket ');  
                    }
                    else{    
                         findDupitems.put(ipl.Free_Item__c, ipl.Free_Item__c);
                    }
             }
              if(ipl.Free_Item__c == 'a089000000Mg123456'){
                 failuremessageset.add('Error: Please Select a Free Ticket from the list.');  
              }  
          }catch(exception e){}
          
          }
           
          
       } 
          
    
    RETURN failuremessageset;
    
    }
     
    // -------------------This method is To Insert Promotion and Item Promotion for Basic And Multi-Items promotion---------------------------------------.

    Public  SET<STRING> upsertpromotion(LIST<Promotion__c> prolist,LIST<Item_Promotion__c> itempromlist ){
     system.debug('=============prolist:===== ' +prolist);
        failuremessageset = new SET<STRING>();
        if(itempromlist.size()>0){
         additem(itempromlist);
        }
        ELSE{
        
        failuremessageset.add('Error: Please Select atleast one item for which the PromoCode can be applied.'); 
        
        }
        if(failuremessageset.size()==0)
        {
            BLN_Promotion_DAO blnpromotionsdao= NEW BLN_Promotion_DAO();
            List<Database.upsertResult> saveres = blnpromotionsdao.UpsertPromotion(prolist);
            system.debug('========STATUS MESSAGE= ===============' +saveres );
              failuremessageset = new SET<STRING>();
               for(Database.UpsertResult s : saveres ){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
          
                 }
              System.debug('=========55555555 ==== ' + failuremessageset);
      
          if(failuremessageset.size()==0)
          {
            
              if(itempromlist.size()>0){
               System.debug('=========itempromlist==== ' + itempromlist);
              List<Item_Promotion__c> itempromotionslist= new List<Item_Promotion__c>();
                for(Item_Promotion__c ip : itempromlist ){
                  try{
                    ip.Promotion__c = saveres[0].id;
                   }catch(Exception e){}
                 
                 itempromotionslist.add(ip);
                }
                 System.debug('=========itempromotionslist==== ' + itempromotionslist);
                 BLN_ItemPromotion_DAO blnitempromotionsdao= NEW BLN_ItemPromotion_DAO();
                  List<Database.upsertResult> savres = blnitempromotionsdao.upsertitemPromotion(itempromotionslist);
                  failuremessageset = new SET<STRING>();
                   for(Database.UpsertResult s : savres ){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
                   }
              }
               system.debug('failuremessageset failuremessageset::::' + failuremessageset); 
                      if(failuremessageset.contains('entity is deleted')){
                            failuremessageset = new set<string>();
                       }              
                       system.debug('failuremessageset113 failuremessageset::::' + failuremessageset);  
           RETURN failuremessageset;   
          }
      
         else{
          RETURN failuremessageset;
         }
     }
     else{
          RETURN failuremessageset;
         }
    
    
    
   } 
    
 //------------------------------This method is to Delete a buy item in promotion----------------------------------------------
 
 
  Public MAP<Decimal,Item_Promotion__c> deleteitempromoline(String Del , MAP<Decimal,Item_Promotion__c> itmpromolineitemMAP){
      
      SYSTEM.DEBUG('============del============== ' + del);
      SYSTEM.DEBUG('====itmpromolineitemMAP===== ' + itmpromolineitemMAP);
  
      Decimal deletedId;
          if( null != del){
              deletedId = Decimal.valueOf(del);
          }
        
       if(deletedId != null){ 
             SYSTEM.DEBUG('====deletedId ===== ' + deletedId );
            SYSTEM.DEBUG('====itmpromolineitemMAP:===== ' + itmpromolineitemMAP);
          itmpromolineitemMAP.remove(deletedId);
          itempromotionslist = new LIST<Item_Promotion__c>();
          uniqueNo = -1;
          Decimal count = 0;
          MAP<Decimal,Item_Promotion__c> itempromoremovelineitemMAP = new MAP<Decimal,Item_Promotion__c> ();
           if(itmpromolineitemMAP.values().size()>0){
           for(Item_Promotion__c pl:itmpromolineitemMAP.values()){
            uniqueNo++;
             if(itmpromolineitemMAP.containskey(uniqueNo)){
                      if(count == 1){
                            itempromoremovelineitemMAP.put(uniqueNo-1,itmpromolineitemMAP.get(uniqueNo));
                      }
                      else{
                          itempromoremovelineitemMAP.put(uniqueNo ,itmpromolineitemMAP.get(uniqueNo));
                      }
                     }
                     
                     else{
                     
                     itempromoremovelineitemMAP.put(uniqueNo,itmpromolineitemMAP.get(uniqueNo+1));
                      uniqueNo++;
                      count  = 1;
                     }
                     
               } 
            
         
             } 
             SYSTEM.DEBUG('====itmpromolineitemMAP:===== ' + itmpromolineitemMAP);
           itmpromolineitemMAP=  new MAP<Decimal,Item_Promotion__c> ();
           itmpromolineitemMAP= itempromoremovelineitemMAP.clone();
            
            } 
           
       

   RETURN itmpromolineitemMAP;
  
  }
 
 
 // This Method is to Delete Promotionslineitem for Spend More and Savemore---------------------------------
 
 Public MAP<Decimal,Promotion__c> deletepromoline(String Del , MAP<Decimal,Promotion__c> promotionslistMAP){
 
     Decimal deletedId;
          if( null != del){
              deletedId = Decimal.valueOf(del);
          }
           if(deletedId != null){ 
              promotionslistMAP.remove(deletedId);
              promotionslist = new LIST<Promotion__c>();

           
         /*  MAP<Decimal,Promotion__c> promoremovelineitemMAP = new MAP<Decimal,Promotion__c> ();
           if(promotionslistMAP.values().size()>0){
           System.debug('11111111111 3223 ' + promotionslistMAP);
           for(Promotion__c pl : promotionslistMAP.values()){
                 promotionslist.add(pl);
                 uniqueNo++;
                 promoremovelineitemMAP.put(uniqueNo ,pl);

             } 
            }  */
            
            
             uniqueNo = -1;
            Decimal count = 0;
            MAP<Decimal,Promotion__c> promoremovelineitemMAP = new MAP<Decimal,Promotion__c> ();
           if(promotionslistMAP.values().size()>0){
           System.debug('11111111111 3223 ' + promotionslistMAP);
           for(Promotion__c pl : promotionslistMAP.values()){
            uniqueNo++;


            if(promotionslistMAP.containskey(uniqueNo)){
              if(count == 1){
                    promoremovelineitemMAP.put(uniqueNo-1,promotionslistMAP.get(uniqueNo));
              }
              else{
                  promoremovelineitemMAP.put(uniqueNo ,promotionslistMAP.get(uniqueNo));
              }
            }
                     
            else{
                     
             promoremovelineitemMAP.put(uniqueNo,promotionslistMAP.get(uniqueNo+1));
              uniqueNo++;
              count  = 1;
            }
           }
            
          }  
            
           System.debug('fsfgergerg3223 ' + promoremovelineitemMAP); 
          promotionslistMAP=  new MAP<Decimal,Promotion__c> ();
          promotionslistMAP= promoremovelineitemMAP.clone();
           
           }
     RETURN promotionslistMAP;
  }
 
 
 
 
  //----------------------------SaveOrderPromotion---------------------
  
  
  Public SET<STRING> saveorderpromotion(List<Promotion__c> promotionslist){
  
  
      String Promocode = promotionslist[0].Promo_Code__c;
      String PromotionName = promotionslist[0].Name ;
      DATETIME Eff_TimeStamp = promotionslist[0].Eff_TimeStamp__c;
      DATETIME Exp_TimeStamp = promotionslist[0].Exp_TimeStamp__c;
      Decimal Tusagecount = promotionslist[0].T_Max_Count__c;
      Decimal Iusagecount = promotionslist[0].I_Max_Count__c;
      String status = promotionslist[0].Status__c;
      String Type = promotionslist[0].Type__c;
      
      List<Promotion__c> tobeinsertedpromolist = NEW List<Promotion__c>();
         SYSTEM.DEBUG('==========================' + promotionslist);
      for(Promotion__c p : promotionslist)
     {
            p.Name = PromotionName ;
            p.Promo_Code__c = Promocode ;
            p.Eff_TimeStamp__c = Eff_TimeStamp;
            p.Exp_TimeStamp__c = Exp_TimeStamp;
            p.T_Max_Count__c = Tusagecount;
            p.I_Max_Count__c = Iusagecount ;
            p.Status__c    =   status ; 
            p.Type__c   = Type;
      
        tobeinsertedpromolist.add(p);
     
     }
     
       SYSTEM.DEBUG('==========================' + tobeinsertedpromolist);
       BLN_Promotion_DAO blnpromotionsdao= NEW BLN_Promotion_DAO();
       List<Database.upsertResult> saveordres = blnpromotionsdao.UpsertPromotion(tobeinsertedpromolist);
        system.debug('========STATUS MESSAGE= ===============' +saveordres );
              failuremessageset = new SET<STRING>();
               for(Database.UpsertResult s : saveordres ){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
          
                 }
              System.debug('=========55555555 ==== ' + failuremessageset); 
      
    RETURN failuremessageset;
  
  }
     
   
   
   //-----------------------------SaveBuyxGetyPromotion------------------------------------------
   
   
   
   Public Set<STRING> savebuyxgetypromotion(List<Promotion__c> promotionslist,LIST<Item_Promotion__c> buyitempromlist,LIST<Item_Promotion__c> getitempromlist){
   
    failuremessageset = new SET<STRING>();
        if(buyitempromlist.size()>0){
        failuremessageset = additem(buyitempromlist);
        }
        
     
       if(failuremessageset.size()==0)
        {
           
           if(getitempromlist.size()>0){
             failuremessageset = additem(getitempromlist);
           }
            if(failuremessageset.size()==0)
            {
               BLN_Promotion_DAO blnpromotionsdao= NEW BLN_Promotion_DAO();
               List<Database.upsertResult> saveres = blnpromotionsdao.UpsertPromotion(promotionslist);
               system.debug('========STATUS MESSAGE= ===============' +saveres );
               failuremessageset = new SET<STRING>();
               for(Database.UpsertResult s : saveres ){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
          
               }
              System.debug('=========55555555 ==== ' + failuremessageset);
              if(failuremessageset.size()==0)
             {
                
                List<Item_Promotion__c> itempromlist = new List<Item_Promotion__c>();
                for(Item_Promotion__c ip : buyitempromlist){
                 ip.Promotion__c = saveres[0].id;
                 itempromlist.add(ip);
                }
               //STRING Itemdiscountype = getitempromlist[0].Item_Discount_Type__c;
               //DECIMAL Itemdiscountvalue = getitempromlist[0].Item_Discount_Value__c;
                System.debug('=========getitempromlist==== ' + getitempromlist);
                for(Item_Promotion__c ip : getitempromlist){
                 ip.Promotion__c = saveres[0].id;
                 //ip.Item_Discount_Type__c = Itemdiscountype ;
                 //ip.Item_Discount_Value__c = Itemdiscountvalue ;
                 itempromlist.add(ip);
                }
                
                 System.debug('=========itempromlist==== ' + itempromlist);
                 BLN_ItemPromotion_DAO blnitempromotionsdao= NEW BLN_ItemPromotion_DAO();
                  List<Database.upsertResult> savitempromres = blnitempromotionsdao.upsertitemPromotion(itempromlist);
                  failuremessageset = new SET<STRING>();
                   for(Database.UpsertResult s : savitempromres ){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
                   }
                     if(failuremessageset.contains('entity is deleted')){
                            failuremessageset = new set<string>();
                      }  
                
                 RETURN failuremessageset;   
             }
             else{
              RETURN failuremessageset;
             } 
              
           }
            else{
              RETURN failuremessageset;
             }
       }
        else{
            RETURN failuremessageset;
        }

   }



        //Method to Delete Itempromotions on editing Multi-Items Promotion

   Public Set<String> deletemethod(List<Item_Promotion__c> itempromotionslist ,MAP<ID, Item_Promotion__c> ItempromotionDuppMAP ,List<Item_Promotion__c> freeitempromotionslist ,MAP<ID, Item_Promotion__c> freeItempromotionDuppMAP ){
      
      failuremessageset = new SET<STRING>();
       ItempromotionMAP = new MAP<ID,Item_Promotion__c>();
        if(itempromotionslist.size()>0){
         additem(itempromotionslist);
        }  
          system.debug('=============itempromotionslist -===== ' + itempromotionslist ); 
         if(failuremessageset.size()==0)
        {  
           for(Item_Promotion__c ipl :itempromotionslist ){

                    ItempromotionMAP.PUT(ipl.Id,ipl);
            }
                system.debug('=============ItempromotionDuppMAP-===== ' + ItempromotionDuppMAP);
            system.debug('=============ItempromotionMAP-===== ' + ItempromotionMAP);
               delitempromolist = new List<Item_Promotion__c>();
        
               for(ID ipl :ItempromotionDuppMAP.keyset()){
                 if(!ItempromotionMAP.containskey(ipl) )
                   {
                       delitempromolist.add(ItempromotionDuppMAP.get(ipl));
                   }
                
                 }
               
                system.debug('=============delitempromolist-===== ' +delitempromolist); 
            
               
               if(freeitempromotionslist.size()>0){
               
                   ItempromotionMAP = new MAP<ID,Item_Promotion__c>();
           
                       for(Item_Promotion__c ipl :freeitempromotionslist ){
                            ItempromotionMAP.PUT(ipl.Id,ipl);
                       }
                
                     system.debug('=======ItempromotionMAP-===== ' +ItempromotionMAP); 
                       system.debug('=======freeItempromotionDupMAP-===== ' +freeItempromotionDuppMAP); 
                      for(ID ipl :freeItempromotionDuppMAP.keyset()){
                     
                       if(!ItempromotionMAP.containskey(ipl))
                       {
                           delitempromolist.add(freeItempromotionDuppMAP.get(ipl));
                        }

                    }
               
               }
               
            system.debug('=============delitempromolist-===== ' + delitempromolist);
               if(delitempromolist.size()>0){
                 BLN_ItemPromotion_DAO blnitempromotionsdao= NEW BLN_ItemPromotion_DAO();
                  List<Database.DeleteResult> DR_Dels= blnitempromotionsdao.deleteitmprom(delitempromolist);
                   for(Database.DeleteResult s: DR_Dels){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
                   }
                    system.debug('failuremessageset::::' + failuremessageset); 
                      if(failuremessageset.contains('entity is deleted')){
                            failuremessageset = new set<string>();
                       }              
                       system.debug('failuremessageset113::::' + failuremessageset);            
                      RETURN failuremessageset;   

               }
           system.debug('failuremessageset3242353::::' + failuremessageset); 
         RETURN failuremessageset; 
       }
       else{
       
       RETURN failuremessageset; 
       }
   
   }



// This Method is to construct Itempromotions for Basic Promotions from the selected checkbox values.----------------


  Public List<Item_Promotion__C> basicitempromotions(String promoid  , Boolean editpromobool, List<Item_Promotion__C> itempromotionslist, MAP<ID,Item_Promotion__C> ItempromotionDupMAP){

        
        
         List<String> itempromos = new List<String>();
         itempromos = promoid.split('-');
         
          // For editpromotion--------------------------    
          if(editpromobool  == True){
          
          MAP<ID,Item_Promotion__C> dupitemMap = new MAP<ID,Item_Promotion__C>();
            for(Item_Promotion__C itp : ItempromotionDupMAP.values()){
        
              dupitemMap.put(itp.Buy_Item__c,itp); 
            }
          
          
          
          
          Decimal buyqty = itempromotionslist[0].Buy_Item_Quantity__c;
          string  itmdisctype = itempromotionslist[0].Item_Discount_Type__c;
          Decimal itmdiscvalue  = itempromotionslist[0].Item_Discount_Value__c ;
          
          itempromotionslist = new List<Item_Promotion__c>();
              for(String IpId: itempromos )
              {
               if(dupitemMap.containsKey(IpId)){
                   iprecord = dupitemMap.get(IpId);
                   iprecord.Buy_Item__c = IpId ;
                   iprecord.Buy_Item_Quantity__c = buyqty ;
                   iprecord.Item_Discount_Type__c  = itmdisctype ;
                   iprecord.Item_Discount_Value__c   = itmdiscvalue   ;
                   itempromotionslist.add(iprecord );
              
               }
               else{
                   iprecord = new Item_Promotion__c();
                   iprecord.Buy_Item__c = IpId ;
                   iprecord.Buy_Item_Quantity__c = buyqty ;
                   iprecord.Item_Discount_Type__c  = itmdisctype ;
                   iprecord.Item_Discount_Value__c   = itmdiscvalue   ;
                   itempromotionslist.add(iprecord );
               }
              }
          }
        
        // For Creating New Promotion -----------------------------
          
          if(editpromobool != True){
          Decimal i=0;
          for(String IpId: itempromos )
          {
             if(i == 0){
             itempromotionslist[0].Buy_Item__c = IpId ;
             }
             if(i>0){       
                 iprecord = new Item_Promotion__c();
                 iprecord.Buy_Item_Quantity__c = itempromotionslist[0].Buy_Item_Quantity__c;
                 iprecord.Item_Discount_Type__c  = itempromotionslist[0].Item_Discount_Type__c;
                 iprecord.Item_Discount_Value__c   = itempromotionslist[0].Item_Discount_Value__c ;
                 iprecord.Buy_Item__c = IpId ;
                 itempromotionslist.add(iprecord);
             }
             i++;
             
           }  
          }
          System.Debug('ItemPromotionS lIST-------'  + itempromotionslist) ;



      return itempromotionslist;


   }


 // This Method is to Delete Promotions Record along with its respective itempromotions.----------------------
 
 
 Public SET<STRING> deletepromotionandip(List<Promotion__c> delpromotionlist, List<Item_Promotion__c> deliprecords){
     failuremessageset = new SET<STRING>();
     system.debug('delpromotionlist:' + delpromotionlist);
     system.debug('deliprecords:' + deliprecords);
     
     if(deliprecords.size()>0){
      BLN_ItemPromotion_DAO blnitempromotionsdao= NEW BLN_ItemPromotion_DAO();
      List<Database.DeleteResult> DR_Dels= blnitempromotionsdao.deleteitmprom(deliprecords);
      for(Database.DeleteResult s: DR_Dels){
                        if(!s.isSuccess()){
                            Database.Error error = s.getErrors().get(0);
                            String failedDML =Error.getMessage();             
                            failuremessageset.add(failedDML);
                      
                        }
                       }
      
      }
         system.debug('DFDGDFVCBFGGRR' + failuremessageset.size());
      if(failuremessageset.size()==0)
      {
      
      if(delpromotionlist.size()>0){
       system.debug('delpromotionlist:' + delpromotionlist);
                      BLN_Promotion_DAO blnpromotionsdao= NEW  BLN_Promotion_DAO();
                      List<Database.DeleteResult> DR_Dels= blnpromotionsdao.deleteprom(delpromotionlist);
                       for(Database.DeleteResult s: DR_Dels){
                        if(!s.isSuccess()){
                            Database.Error error = s.getErrors().get(0);
                            String failedDML =Error.getMessage();             
                            failuremessageset.add(failedDML);
                      
                        }
                       }
           RETURN failuremessageset;   
       }
         
      }
       
         RETURN failuremessageset; 
 
 }
 
 
 
 























}
public with sharing class BLN_SuccessController{
/**********************************************************************************************************************************************************************************************
*   Author                  : Mahesh Sakunala
*   Date                    : 02/06/2014 
*   Purpose                 : This class is for Registration Page i.e. User picks Items and fills gives contact information and fills out survey questions and completes registration
*************************************************************************************************************************************************************************************************/

//------------------------------------------- Variables Declaration Start ---------------------------------------------- 
public String EventId{get;set;}
public String BookTicketLink{get;set;}
public Integer EventDaysRemaining{get; set;}
public list<Reg_Setting__c> DisplaySettings{get;set;}
public BLN_Event__c registrationEvent{get; set;}
public Registration_Template__c registrationTemplate{get; set;}
public string orderId{get;set;}
public string error{get;set;}
public string error1{get;set;}
public Cookie  counter {get;set;}
public order__c orders {get;set;}
public string fullUrl{get;set;}
public string siteurl{get;set;}
public String pgreturnforonsite{get;set;}
public string replacecontactsubject{get;set;}
public BLN_Quick_Registration_BAL QuickRegBAL{get;set;}
public List<Reg_Setting__c> EvntEmailPref; //Defined By Anil
public boolean StopMailToAttenee{get;set;}  //Definde By Anil, This flag decides sending of email to Attendee
public boolean StopMailToEventAdmin{get;set;}  //Definde By Anil, This flag decides sending of email to EventAdmin
  public String abnJobid {get; set;}
  public String orderStatus{get;set;}
public GN_User__c GNUSRSDETAILS {get ; set ;} 
public boolean isResend{get;set;}

//-------------------------------------------- Variables Declaration End ----------------------------------------------- 

//------------------------------------------------ Constructor Start --------------------------------------------------- 
public BLN_SuccessController(){
  isResend=false;
}

public void firstMethod(){
     fullUrl =  Site.getBaseUrl();
     siteurl = Label.SiteURL;    
     system.debug('baseurl'+fullUrl) ; 
     system.debug('sitesurl'+siteurl ) ; 
     ID RegId;
    // Abandon Scheduler Job  Id to abart job
    try {
      Cookie abnJob = ApexPages.currentPage().getCookies().get('abnJob');
      abnJobid = abnJob.getValue();
      abnJob = new Cookie('abnJob', null, null, -1, false);
      ApexPages.currentPage().setCookies(new Cookie[] {abnJob});
    } catch (Exception e) {}


     
     try{
     Cookie prcok=ApexPages.currentPage().getCookies().get('prcok');
     pgreturnforonsite=prcok.getValue();
     prcok= new Cookie('prcok',null,null,-1,false);
     ApexPages.currentPage().setCookies(new Cookie[]{prcok});   
     }catch(Exception e){}
     
     try{
         
         string eveidBeforedecode= apexpages.currentpage().getparameters().get('id');
         if(eveidBeforedecode!=null && eveidBeforedecode!=''){
             eventId= EncodingUtil.base64Decode(eveidBeforedecode).toString();
        }
        
        system.debug('WWWWWWWWWWWWWWWWWWWWW '+eventId);
         try{
           string abd='';
            try{
             system.debug('eeeeeeeeeeeeeeeeeee ');
              abd = apexpages.currentpage().getparameters().get('OrdId');
              if(abd==null || abd==''){
                 counter = ApexPages.currentPage().getCookies().get('OrderId');
                if(counter != null){
                  abd = counter.getValue();
                }
              }
              
            }catch(exception er){
               counter = ApexPages.currentPage().getCookies().get('OrderId');
                system.debug('DDDDDDDDDDDDDDDD '+counter );
                if(counter != null){
                  abd = counter.getValue();
                   system.debug('DDDDDDDDDDDDDDDD '+abd );
                }
    
            }
           
           orderId  = EncodingUtil.base64Decode(abd).toString(); 
         
          }catch(exception e){}
           //for trustcommerceventid       
         if(EventId == NULL)  {     
           Cookie tcok=ApexPages.currentPage().getCookies().get('trustcommerceeventnid'); 
           if(tcok!= null){     
          EventId = tcok.getValue();
        }
          }
           
          Cookie vtype=ApexPages.currentPage().getCookies().get('visibleType'); 
           if(null != vtype){
               BookTicketLink = '/BLN_Registration_Eventdex?id='+eventId+'&Visib='+vtype.getValue();
           }else{
              BookTicketLink = '/BLN_Registration_Eventdex?id='+eventId;
           }
          if(Apexpages.currentPage().getParameters().get('status')!='decline'){
     Cookie onsiteorderid= new Cookie('onsiteorderid',orderId,null,-1,false); 
        ApexPages.currentPage().setCookies(new Cookie[] {onsiteorderid});
      }
           system.debug('EEEEEEEEEEEEEEEE '+orderId+'WWWWWWWWWWWWWW '+eventId );  
          
         RegId = apexpages.currentpage().getparameters().get('rid');
          QuickRegBAL = new BLN_Quick_Registration_BAL();
                
          if(orderId!=null && orderId!=''){
            sendMail(orderId,eventId);
          }      
        
                
    
        
       // Getting Registration Template from Registration Template DAO
        if(RegId != NULL){
            registrationTemplate = QuickRegBAL.getRegTempDetails(RegId);                   
        }else{
            if(registrationEvent.Registration_Template__c != NULL)
                registrationTemplate = QuickRegBAL.getRegTempDetails(registrationEvent.Registration_Template__c);
            else{
                List<Registration_Template__c> regtemp = [SELECT id From Registration_Template__c Where Owner.profile.Name =: 'System Administrator'];
                registrationTemplate = QuickRegBAL.getRegTempDetails(regtemp[0].id);
                }
        }   
        
              
    } catch (Exception pageloadException) {
        system.debug('Exception is : '+ pageloadException.getMessage());
    }
    dispsettings();
}

    
     
public BLN_SuccessController(String ForSer){
   isResend = false;
}



//------------------------------------------------- Constructor End ----------------------------------------------------- 
public string ReplaceContactName{get;set;}
public PageReference sendMail(string orderidstr,string eveid){
  siteurl = Label.SiteURL;    
//string orderidstr,string eveid
    GNUSRSDETAILS = new GN_User__c();
  QuickRegBAL = new BLN_Quick_Registration_BAL();
 if(eveid!= NULL){ 
            // Getting Event Details from Event DAO
            registrationEvent = QuickRegBAL.getEventDetails(eveid);   
            BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO();
            GNUSRSDETAILS = GNDAO.existingGnuser(registrationEvent.Organizer_Email__c);   
             //EventDaysRemaining = date.today().daysBetween(registrationEvent.End_Date__c);   
             EventDaysRemaining =   date.today().daysBetween(date.valueof(registrationEvent.End_Date__c));
        }

try{
       BLN_PromoCode_BAL PromotionBAL = new BLN_PromoCode_BAL();
         BLN_Promotion_DAO PromotionDAO = new BLN_Promotion_DAO();
         LIST<Promotion__c> promotionlist  = new LIST<Promotion__c>();
 
      orders =new order__c();
      orders =   [select owner.Name, createdDate, Events__r.Name, Events__r.Start_Date__c, Events__r.Venue_Name__c, Events__r.End_Date__c, Events__r.Description__c, Events__c, o.Fee_Amount__c, o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_GN_User__c, o.BLN_TKT_profile__r.BLN_Company__c, o.Amount_Paid__c, (Select Each_Ticket_Price__c, item__r.event__r.Name , Promotion__c, Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c, order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.BLN_GN_User__r.Email__c, Item_Quantity__c, Item_Price__c, Item_Discount__c, Id, Item__r.Event__r.End_Date__c, item__r.item_name__c, Status__c, Promotion__r.Promo_Code__c, Currency__c, item__r.price__c  From Order_Items__r ), (Select Order_Item__r.Each_Ticket_Price__c, Item_Pool__c, Item_Type__c, item__r.item_name__c, id, tkt_profile__r.BLN_Company__c, tkt_profile__r.BLN_Company__r.Name, tkt_profile__r.BLN_GN_User__r.Email__c, tkt_profile__r.BLN_GN_User__r.user__c, tkt_profile__r.BLN_GN_User__r.user__r.userName, tkt_profile__r.BLN_GN_User__r.user__r.email, tkt_profile__r.First_Name__c, tkt_profile__r.Last_Name__c, Event__c, Order__c, Order_Item__c, Ticket_Status__c, Badge_Label__c, NAme, Item_Type__r.Name, tkt_profile__r.BLN_GN_User__r.user__r.MobilePhone, lastmodifiedDate,item_pool__r.item_type__r.name from Tickets__r), (select Currency_Code__c, Pay_Address__c, Payment_Ref_Number__c, Payment_Mode__c, Payment_Amount__c from Payments__r), BLN_TKT_profile__r.BLN_GN_User__r.user__r.Name, BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName, BLN_TKT_profile__r.BLN_GN_User__r.user__r.MobilePhone, BLN_TKT_profile__r.BLN_GN_User__r.Name, BLN_TKT_profile__r.Last_Name__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Email__c, BLN_TKT_profile__r.TKT_Company__c From Order__c o where Id = : orderidstr ];
     SET<id> ids  = new SET<id>();
     System.debug('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ '+isResend + ' Order Id '+orders);
     if(!isResend){
     try{
     
     if(orders.Order_Status__c=='Abandoned'){ 
      
      MAP<id,Decimal> mapItemBuyQuantity =new MAP<id,Decimal>();
       String promotionId = '';
      for(Order_Item__c  ord : orders.Order_Items__r ){
          System.debug('JJJJJJJJJJJJJ uuuuuuuuuuuuuuu '+ord.Promotion__c);
           if(ord.Promotion__c!=null){
                promotionId = ord.Promotion__c;
                mapItemBuyQuantity.put(ord.Item__c,ord.Item_Quantity__c);
             }        
           } 
          if(promotionId !=null && promotionId !=''){ 
           System.debug('uuuuuuuuuuuuuuu '+promotionId );
           for(Promotion__c p : [select id,T_Used_Count__c,T_Max_Count__c ,(select id,Buy_Item_Quantity__c,Buy_Item__c from Item_Promotions__r ) from Promotion__c where id=:promotionId  ]){ 
                System.debug('ZZZZZZZZZZZZZZZZZZ  '+p); 
                  Decimal pmoappQuan = 0;
                 Decimal tcAvailable = p.T_Max_Count__c - p.T_Used_Count__c; 
                  for(Item_Promotion__c itp :p.Item_Promotions__r){
                    System.debug('YYYYYYYYYYYYYYyYYYYYYYYY '+mapItemBuyQuantity +'  '+itp.Buy_Item__c);
                    if(mapItemBuyQuantity.keySet().contains(itp.Buy_Item__c)){
                     Decimal itemBuyQuan = mapItemBuyQuantity.get(itp.Buy_Item__c);
                     integer decVal = math.mod(integer.valueOf(itemBuyQuan ), integer.valueOf(itp.Buy_Item_Quantity__c));
                     System.debug('AAAAAAAAAAAAAAAAAAAAAAAA '+itemBuyQuan  +' '+ decVal );
                     Decimal tcPmo =0;
                      tcPmo =decVal==0?itemBuyQuan/itp.Buy_Item_Quantity__c:((itemBuyQuan - decVal)/itp.Buy_Item_Quantity__c);
                      if(tcPmo>=tcAvailable){
                         tcPmo = tcAvailable;
                      }
              
                      p.T_Used_Count__c += tcPmo ;
                       System.debug('tcPmo  Count '+tcPmo +'   '+p.T_Used_Count__c);
                      
                   }
                }
                 promotionlist.add(p);
             }        
           } 
         System.debug('promotionlist   '+promotionlist);
          if(promotionlist.size()>0){
           PromotionDAO.UpsertPromotion(promotionlist);
         }
      } else{

      return null;
     }
      }catch(exception er){}
     
      
        try{
                     //Cookie orderIdvalue= ApexPages.currentPage().getCookies().get('OrderId');
                       if (counter != null) {
                            counter = new Cookie('OrderId',null,null,-1,false);
                        }
                        
                       ApexPages.currentPage().setCookies(new Cookie[]{counter });   
      } catch (exception rt) {}
                       
     //Abaring success order schedule
                       
       if(abnJobid!=null && abnJobid!=''){ // This will cancel reserve status change scheduler
            List<CronTrigger> ctList = [SELECT Id FROM CronTrigger where id=:abnJobid];
            system.debug('SchedulerIdToAbart '+ctList.size());
            for(CronTrigger ct : ctList) {
                system.abortJob(ct.id);
            }
        }
   }                    
               
 //for onsite
    
 
  string promocode=''; 
 string  consrtuctTicbody ='<table style="width:100%" cellpadding="0" cellspacing="0" ><tr> <td height="30" bgcolor="#E7E5E5" style="padding-left:15px;border-bottom:1px solid #999;border-top:1px solid #999;background-color:#e7e5e5;border-left:1px solid #999"> <strong>Tickets/Items</strong></td><td width="115" align="right" bgcolor="#e7e5e5" style="font-weight:500;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-right:15px;border-top:1px solid #999;border-bottom:1px solid #999">Price</td> <td width="115" height="30" align="right" bgcolor="#e7e5e5" style="font-weight:500;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-right:15px;border-top:1px solid #999;border-bottom:1px solid #999"><strong>Quantity</strong></td><td align="right" bgcolor="#e7e5e5" style="border-top:1px solid #999;border-bottom:1px solid #999;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-right:15px;border-right:1px solid #999"><strong>Total</strong></td></tr>';
 
 string trvalues ='';
  for(Order_Item__c itOrd : orders.Order_Items__r){
    System.debug('Order itenssssss '+itOrd );
     trvalues += '<tr><td height="30" bgcolor="#E7E5E5" style="padding-left:15px;border-bottom:1px solid #999;border-top:1px solid #999;background-color:#f1f1f1;border-left:1px solid #999">'+itOrd.item__r.item_name__c+'</td><td width="115" align="right" bgcolor="#f1f1f1" style="font-weight:500;padding-right:15px;border-top:1px solid #999;border-bottom:1px solid #999">'+registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c+itOrd.item__r.price__c+'</td><td width="115" height="30" align="right" bgcolor="#f1f1f1" style="font-weight:500;padding-right:15px;border-top:1px solid #999;border-bottom:1px solid #999">'+itOrd.Item_Quantity__c+'</td><td align="right" bgcolor="#f1f1f1" style="border-top:1px solid #999;border-bottom:1px solid #999;padding-right:15px;border-right:1px solid #999">'+registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c+(itOrd.Item_Quantity__c*itOrd.item__r.price__c)+'</td></tr>';  
  }
   consrtuctTicbody +=trvalues +'</table>';
   
  if(orders.Order_Items__r.size()>0){
  promocode =orders.Order_Items__r[0].Promotion__r.Name;
  }
  
  
 
  Payment__c pay = new Payment__c();
      pay = [select id,Currency_Code__c,Order__c,Payment_Amount__c,Pay_Address__c,Payment_Mode__c,Payment_Ref_Number__c,BLN_Pay_Gateway__r.PGateway_Type__r.Name,BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c from Payment__c where order__c=:orderidstr];
    if(!isResend){
      try{
        if(null!=pay){
           if(null!= pay.BLN_Pay_Gateway__c){
               if(pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name=='PayPal' && pay.BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c=='Adaptive'){
  
  
               }else if(pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name=='TrustCommerce'){
                  try{
                   /*pay.credit_card_type__c = Apexpages.currentpage().getparameters().get('card_type'); 
                    pay.credit_card_last_4digits__c = Apexpages.currentpage().getparameters().get('cc');*/
                    if(Apexpages.currentpage().getparameters().get('transid')!=null&&Apexpages.currentpage().getparameters().get('transid')!=''){
                    pay.Payment_Ref_Number__c = Apexpages.currentpage().getparameters().get('transid');
                    DataBase.update(pay,false);
                    }
                  }catch(exception rt){}               
               }
             //Set Status of Order according to payment gateway 
              if(pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name=='Check'){
              if(orderStatus!=null && orderStatus!='')
                orders.Order_Status__c = orderStatus;  
               else
                orders.Order_Status__c='Check Not Received';
                 
                }else{
                   orders.Order_Status__c='Fully Paid';
                  }
           }
       }
      }catch(exception er){}
       // Trying to insert Matchleads Data
        SET<id> tIdForMatchleads = new SET<id>();

     List<Booth_Map__c>  bmp=new List<Booth_Map__c>();
     List<BLN_Sponsorships__c> Sponsorships=new List<BLN_Sponsorships__c>();
     integer leadflag=0;
     for(Ticket__c ty : orders.Tickets__r){
        if(null!=pay.BLN_Pay_Gateway__c)
        ty.Ticket_Status__c='Booked';
         if((ty.Item_Type__r.Name=='MatchLeads Buyer' || ty.Item_Type__r.Name=='MatchLeads Seller') || ( ty.item_pool__r.item_type__r.name=='MatchLeads Buyer' ||  ty.item_pool__r.item_type__r.name=='MatchLeads Seller')){
            tIdForMatchleads.add(ty.id);
         }
        if(ty.item_pool__r.item_type__r.name == 'Booths /Tables'){
            bmp.add(new Booth_Map__c(name=ty.Item_Pool__r.Item_Type__r.Name,Ticket_id__c=ty.id)); 
        }
        if(ty.item_pool__r.item_type__r.name == 'Sponsorship'){
            Sponsorships.add(new BLN_Sponsorships__c(name=ty.Item_Pool__r.Item_Type__r.Name,Ticket_id__c=ty.id)); 
        }
        if(ty.item_pool__r.item_type__r.name == 'Lead Retrieval'){
        leadflag=1;
        }
     }
     try{
       if(leadflag==1){
       List<Reg_Setting__c> leadsettings= [select Id,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Defaullt_Label__c,Setting_Type__c,Included__c from Reg_Setting__c WHERE Event__c =:eveid and (Defaullt_Label__c='Boothleads Tab' or Defaullt_Label__c='Lead Retrieval' or Defaullt_Label__c='With QR Code')];
        for(integer i=0;i<leadsettings.size();i++)
        {
          leadsettings[i].Included__c=true;
        }
        update leadsettings;
        }
     }catch(Exception e){}
      database.update(orders.Tickets__r,false); 
      database.update(orders,false);
       insertMlData(tIdForMatchleads);
      if(bmp.size()>0){
          Database.insert(bmp,false);
      }
      if(Sponsorships.size()>0){
          Database.insert(Sponsorships,false);
      }
     
    }


  //OrgWideEmailAddress Org ;
 
   LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
         BLN_Event_DAO evDAO = new BLN_Event_DAO();
         eventsList =  evDAO.getEventDetails(eveid);
        
       /*try{
        if(eventsList.size()>0){
        registrationEvent  = new BLN_Event__c();
        registrationEvent = eventsList[0];
          Org =  [select id from OrgWideEmailAddress WHERE address=:eventsList[0].owner.username];
        }  
       }catch(exception rt){ 
          Org =  [select id from OrgWideEmailAddress WHERE address='support@boothleads.com'];
       }*/
       
       // system.debug('QQQQQQQQQQQQQQQQQQ '+org);
        
    string replacecontactsubject = '';
        
   //if any template is active with respect to event and Order Confirmation
       system.debug('Eorder=========================================================='+eveid);
       EmailCampaign__c Eorder = new EmailCampaign__c();
       try{
      Eorder = [SELECT Template_Body__c,CampSubject__c,Template_Status__c  From EmailCampaign__c WHERE Event__c =: eveId  AND Template_Type__c = 'System' AND System_Template_Type__c= 'Order Confirmation' AND Template_Status__c = 'Active'  ];
      } catch(exception e){} 
        system.debug('Eorder=========================================================='+Eorder);
       
      // system.debug('Subject=========================================================='+Eorder.CampSubject__c);
       if (Eorder.CampSubject__c != null && Eorder.CampSubject__c != ''){
       replacecontactsubject = Eorder.CampSubject__c;
       system.debug('replacecontactsubject for custom'+replacecontactsubject);
       
      } else {
       replacecontactsubject = 'Your order confirmation for '+eventsList[0].Name;
       system.debug('replacecontactsubject for custom'+replacecontactsubject);
       }
       
       Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
       Messaging.SingleEmailMessage emailTOea = new Messaging.SingleEmailMessage();

       List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
       
              String[] toAddresses= new String[] { orders.BLN_TKT_profile__r.email__c };      /*{ orders.Client_GN_User__r.User__r.username };*/
              email.setToAddresses(toAddresses);
      try {
        /*String[] ccAddresses = new String[] { eventsList[0].owner.username, 'orders@eventdex.com' };
        email.setbccAddresses(ccAddresses);
        System.debug('Bcc Address   ' + ccAddresses);*/
       try{ 
        String[] ccAddresses= new String[] { eventsList[0].Organizer_Email__c};
        emailTOea.setToAddresses(ccAddresses);
       String[] bccAddresses= new String[] {'orders@eventdex.com' };
         
           if(!BLN_isSandboxcls.isSandbox()){
        emailTOea.SetbccAddresses(bccAddresses);
           }
        System.debug('cc Address   '+ccAddresses+' Bcc Address '+bccAddresses);
      }catch(exception ex){ }
              
              

      } catch (exception ex) { }
              system.debug('toAddresses====='+toAddresses);
             EmailTemplate E = new EmailTemplate();
             try{ 
                  E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'BLN Order confirmation']; 
             }catch(exception fr){}
            
            if (Eorder.Template_Body__c!= null && Eorder.Template_Body__c!= ''){ 
             ReplaceContactName = Eorder.Template_Body__c;
      } else {
            ReplaceContactName = E.HtmlValue;
            }
            
            String replacedname ='';
            
             string orgid = UserInfo.getOrganizationId();
            string frd1 ='';
             try{
              if(eventsList[0].Logo_URL__c !=null){
              frd1 ='<a href="'+eventsList[0].Website_Url__c+'" style="cursor:pointer;">';
                 frd1 +='<img src='+siteurl+'/servlet/servlet.ImageServer?id='+eventsList[0].Logo_URL__c+'&oid='+orgid;
          frd1 += ' height="80" width="250" style="margin: 0; border: 0; padding: 0; display: block;"/></a>';
              }else{
               frd1 ='';
               }
            }catch(exception gr){}
            system.debug('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWW '+frd1 );
            system.debug('sssssssssssssssssssssssssssssssssssssssssssssssssssss'+siteurl );
            
            if(frd1!=''){
                  replacedname = ReplaceContactName.Replace('{!eventlogo}', frd1);
                 }else{
                 replacedname = ReplaceContactName.Replace('{!eventlogo}','');
                 }
           
             if(eventsList[0].Name!=null && eventsList[0].Name!=''){
                  replacedname = replacedname.Replace('{!eventname}',eventsList[0].Name);
                  replacecontactsubject = replacecontactsubject.Replace('{!eventname}',eventsList[0].Name);
                 }else{
                 replacedname = replacedname.Replace('{!eventname}','');
                 replacecontactsubject = replacecontactsubject.Replace('{!eventname}','');
                 }      
                
                
                
             if(eventsList[0].Venue_Name__c!=null && eventsList[0].Venue_Name__c!=''){
                  replacedname = replacedname.Replace('{!eventlocation}',eventsList[0].Venue_Name__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!eventlocation}',eventsList[0].Venue_Name__c);
               }else{
                 replacedname = replacedname.Replace('{!eventlocation}','');
                 replacecontactsubject = replacecontactsubject.Replace('{!eventlocation}','');
               }
               
             String evestda = ''; 

                if(eventsList[0].Start_Date__c != null ){
                  DateTime evestartdate = eventsList[0].Start_Date__c;
                  Datetime dt = evestartdate ;//datetime.newInstance(evestartdate.year(), evestartdate.month(), evestartdate.day());
        evestda = dt.format('MMMM d,  yyyy hh:mm a', eventsList[0].Time_Zone__c);
                } 
             
              
              String eveedda= ''; 

                if(eventsList[0].End_Date__c != null ){
                DateTime eveenddate1 = eventsList[0].End_Date__c;
                Datetime dt = eveenddate1;//datetime.newInstance(eveenddate1.year(), eveenddate1.month(), eveenddate1.day());
        eveedda = dt.format('MMMM d,  yyyy hh:mm a', eventsList[0].Time_Zone__c);
                } 
             
             
                  replacedname = replacedname.Replace('{!eventdate}',evestda+' - '+eveedda);
                  replacecontactsubject  = replacecontactsubject.Replace('{!eventdate}',evestda+' - '+eveedda);
               
              /* If(eventsList[0].Start_Time__c!=null && eventsList[0].End_Time__c!=null){
                  replacedname = replacedname.Replace('{!eventdate}',evestda+' '+eventsList[0].Start_Time__c+' - '+eveedda+' '+eventsList[0].End_Time__c);
                  replacecontactsubject  = replacecontactsubject.Replace('{!eventdate}',evestda+' '+eventsList[0].Start_Time__c+' - '+eveedda+' '+eventsList[0].End_Time__c);
               }else{
                replacedname = replacedname.Replace('{!eventdate}','');
                replacecontactsubject = replacecontactsubject.Replace('{!eventdate}','');
               } */
                 
             try{
                  replacedname = replacedname.Replace('{!username}',orders.BLN_TKT_profile__r.First_Name__c+' '+orders.BLN_TKT_profile__r.Last_Name__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!username}',orders.BLN_TKT_profile__r.First_Name__c+' '+orders.BLN_TKT_profile__r.Last_Name__c);
               }catch(exception ed){
               replacedname = replacedname.Replace('{!username}','');
               replacecontactsubject = replacecontactsubject.Replace('{!username}','');
               }
              
                try{
                  replacedname = replacedname.Replace('{!useremail}',orders.BLN_TKT_profile__r.Email__c); /* orders.BLN_TKT_profile__r.BLN_GN_User__r.User__r.username */
                  replacecontactsubject = replacecontactsubject.Replace('{!useremail}',orders.BLN_TKT_profile__r.Email__c); /* orders.BLN_TKT_profile__r.BLN_GN_User__r.User__r.username */
               }catch(exception ed){}
                try{
                  replacedname = replacedname.Replace('{!company}',orders.BLN_TKT_profile__r.TKT_Company__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!company}',orders.BLN_TKT_profile__r.TKT_Company__c);
               }catch(exception ed){
                replacedname = replacedname.Replace('{!company}','');
                replacecontactsubject = replacecontactsubject.Replace('{!company}','');
                system.debug('replacecontactsubject=======================333'+replacecontactsubject);
               }
                try{
                  replacedname = replacedname.Replace('{!orderid}',orders.Name);
                 replacecontactsubject = replacecontactsubject.Replace('{!orderid}',orders.Name);
               }catch(exception ed){
                replacedname = replacedname.Replace('{!orderid}','');
                replacecontactsubject = replacecontactsubject.Replace('{!orderid}','');
               }
               
               
               Datetime myDatetime =orders.createddate;
               Datetime dt2 = datetime.newInstance(myDatetime.year(), myDatetime.month(),myDatetime.day());
               String myDatetimeStr = myDatetime.format('MMMM d,  yyyy');
               
                try{
                  replacedname = replacedname.Replace('{!orderdate}',myDatetimeStr);
                  replacecontactsubject = replacecontactsubject.Replace('{!orderdate}',myDatetimeStr);
               }catch(exception ed){
                replacedname = replacedname.Replace('{!orderdate}','');
                replacecontactsubject = replacecontactsubject.Replace('{!orderdate}','');
               }
                try{
                  replacedname = replacedname.Replace('{!ticket}',consrtuctTicbody );
                  replacecontactsubject= replacecontactsubject.Replace('{!ticket}',consrtuctTicbody );
               }catch(exception ed){
                replacedname = replacedname.Replace('{!ticket}','');
                replacecontactsubject = replacecontactsubject.Replace('{!ticket}','');
               }
                try{
                  replacedname = replacedname.Replace('{!totalamount}',string.valueOf(orders.Order_Sub_Total__c));
                  replacecontactsubject = replacecontactsubject.Replace('{!totalamount}',string.valueOf(orders.Order_Sub_Total__c));
               }catch(exception ed){
                replacedname = replacedname.Replace('{!totalamount}','');
                replacecontactsubject = replacecontactsubject.Replace('{!totalamount}','');
               }
               
               
               if(orders.Order_Taxes__c !=null && orders.Order_Taxes__c>0){
                  replacedname = replacedname.Replace('<tr><td colspan="4">{!displaytax}</td></tr>','<tr><td height="30" colspan="3" align="left" bgcolor="#f3f3f3" style="font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-left:15px;background-color:#e7e5e5;border-left:1px solid #999;border-bottom:1px solid #999">Tax @ '+registrationEvent.Tax_Rate__c+ '%</td><td align="right" bgcolor="#f3f3f3" style="padding-right:15px;color:#000000;font-weight:bold;background-color:#e7e5e5;border-right:1px solid #999;border-bottom:1px solid #999">'+registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c+orders.Order_Taxes__c+'</td></tr> ' );
                   system.debug('$$$$$$$$$$$$$$$  '+replacedname );
                 } else{
                 replacedname = replacedname.Replace('<tr><td colspan="4">{!displaytax}</td></tr>','');
                }
               
               try{
                  replacedname = replacedname.Replace('{!Description}',string.valueOf(orders.Events__r.Description__c));
               }catch(exception ed){
                replacedname = replacedname.Replace('{!Description}','');
               }
               
               try{
                  replacedname = replacedname.Replace('{!signupurl}',siteurl);
                  replacecontactsubject = replacecontactsubject.Replace('{!signupurl}',siteurl);
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!signupurl}','');
                 replacecontactsubject = replacecontactsubject.Replace('{!signupurl}','');
               }
               
                
                try{
                  replacedname = replacedname.Replace('{!discount}',string.valueOf(orders.Order_Discount__c));
               }catch(exception ed){
                replacedname = replacedname.Replace('{!discount}','');
               }
              
                try{
                  replacedname = replacedname.Replace('{!tax}',string.valueOf(orders.Order_Taxes__c));
               }catch(exception ed){ replacedname = replacedname.Replace('{!tax}',''); }
                try {
        replacedname = replacedname.Replace('{!FeeAmount}', registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c + orders.Fee_Amount__c );
      } catch (exception ed) {replacedname = replacedname.Replace('{!FeeAmount}', '');}
               
                  try{
                  replacedname = replacedname.Replace('<tr><td colspan="4">{!fee}</td></tr>','<tr><td colspan="3" height="30" align="left" bgcolor="#f3f3f3" style="font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-left:15px;background-color:#e7e5e5;border-left:1px solid #999;border-bottom:1px solid #999">Fee </td><td align="right" bgcolor="#f3f3f3" style="padding-right:15px;color:#000000;font-weight:bold;background-color:#e7e5e5;border-right:1px solid #999;border-bottom:1px solid #999">'+registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c+orders.Fee_Amount__c+'</td></tr> ');
               }catch(exception ed){replacedname = replacedname.Replace('<tr><td colspan="4">{!fee}</td></tr>','');}
               
                try{
                  replacedname = replacedname.Replace('{!amountpaid}',string.valueOf(orders.Amount_Paid__c));
               }catch(exception ed){replacedname = replacedname.Replace('{!amountpaid}','');}
               try{
                  replacedname = replacedname.Replace('{!Curencyname}',registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c);
      } catch (exception ed) {
        replacedname = replacedname.Replace('{!Curencyname}', '');
               }
               if (orders.Order_Taxes__c != null && orders.Order_Taxes__c > 0) {
        replacedname = replacedname.Replace('{!TaxRate}', 'Tax @ ' + registrationEvent.Tax_Rate__c);
        replacedname = replacedname.Replace('{!Taxes}', registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c + orders.Order_Taxes__c);
        system.debug('$$$$$$$$$$$$$$$  ' + replacedname );
      } else {
        replacedname = replacedname.Replace('{!TaxRate}', '');
        replacedname = replacedname.Replace('{!Taxes}', '');
        
      }
               
                 if(eventsList[0].Street1__c!=null && eventsList[0].Street1__c!='' ){
                  replacedname = replacedname.Replace('{!add1}',eventsList[0].Street1__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!add1}',eventsList[0].Street1__c);
               }else{
                replacedname = replacedname.Replace('{!add1}','');
                replacecontactsubject = replacecontactsubject.Replace('{!add1}','');
               }
               
                try{
                 if(eventsList[0].Street2__c!=null){   
                  replacedname = replacedname.Replace('{!add2}', ', '+eventsList[0].Street2__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!add2}', ', '+eventsList[0].Street2__c);
                 }else{
                     replacedname = replacedname.Replace('{!add2}', '');
                     replacecontactsubject  = replacecontactsubject.Replace('{!add2}', '');
                 }
               }catch(exception ed){
                replacedname = replacedname.Replace('{!add2}','');
                replacecontactsubject  = replacecontactsubject.Replace('{!add2}', '');
               }
            
            
               if(eventsList[0].City__c!=null && eventsList[0].City__c!=''){
                  replacedname = replacedname.Replace('{!city}',eventsList[0].City__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!city}',eventsList[0].City__c);
               }else{
                replacedname = replacedname.Replace('{!city}','');
                replacecontactsubject = replacecontactsubject.Replace('{!city}','');
               }
               
               if(eventsList[0].BLN_State__r.Short_Name__c!=null){
                  replacedname = replacedname.Replace('{!state}',', '+eventsList[0].BLN_State__r.Short_Name__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!state}',', '+eventsList[0].BLN_State__r.Short_Name__c);
               }else{
                  replacedname = replacedname.Replace('{!state}','');
                  replacecontactsubject =  replacecontactsubject.Replace('{!state}','');
               }
             
                if(eventsList[0].ZipCode__c!=null){
                  replacedname = replacedname.Replace('{!zip}',' '+eventsList[0].ZipCode__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!zip}',' '+eventsList[0].ZipCode__c);
               }else{
                replacedname = replacedname.Replace('{!zip}','');
                replacecontactsubject = replacecontactsubject.Replace('{!zip}','');
               }
               
                 try{
                  replacedname = replacedname.Replace('{!eventadminname}',eventsList[0].owner.Name);
                  replacecontactsubject = replacecontactsubject.Replace('{!eventadminname}',eventsList[0].owner.Name);
               }catch(exception ed){
               replacedname = replacedname.Replace('{!eventadminname}','');
                replacecontactsubject = replacecontactsubject.Replace('{!eventadminname}','');
               }
                 try{
                  replacedname = replacedname.Replace('{!eventadminemail}',eventsList[0].owner.username);
                  replacecontactsubject = replacecontactsubject.Replace('{!eventadminemail}',eventsList[0].owner.username);
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!eventadminemail}','');
                 replacecontactsubject = replacecontactsubject.Replace('{!eventadminemail}','');
               } 
                  
                try{
                  replacedname = replacedname.Replace('{!paymenttype}',pay.Payment_Mode__c);
                  replacecontactsubject = replacecontactsubject.Replace('{!paymenttype}',pay.Payment_Mode__c);
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!paymenttype}','');
                 replacecontactsubject = replacecontactsubject.Replace('{!paymenttype}','');
               } 
                  
                if (orders.Order_Discount__c != null && orders.Order_Discount__c > 0) {
        replacedname = replacedname.Replace('{!PromotionName}', ' Promotion Name:(' + promocode + ')' );
        replacedname = replacedname.Replace('{!Discount}', registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c + orders.Order_Discount__c );
        replacecontactsubject = replacecontactsubject .Replace('{!PromotionName}', ' Promotion Name:(' + promocode + ')' );
        replacecontactsubject = replacecontactsubject .Replace('{!Discount}', registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c + orders.Order_Discount__c );
        system.debug('$$$$$$$$$$$$$$$  ' + replacedname );
      } else {
        replacedname = replacedname.Replace('{!PromotionName}', '');
        replacedname = replacedname.Replace('{!Discount}', '' );
        replacecontactsubject = replacecontactsubject .Replace('{!PromotionName}', '' );
        replacecontactsubject = replacecontactsubject .Replace('{!Discount}', '' );
        
      }   
               if(orders.Order_Discount__c!=null && orders.Order_Discount__c>0){
                  replacedname = replacedname.Replace('<tr><td colspan="4">{!displaypromovalue}</td></tr>',' <tr><td colspan="3" height="30" align="left" style="font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-left:15px;background-color:#e7e5e5;border-left:1px solid #999;border-bottom:1px solid #999">Promotion Name:('+promocode+')</td> <td align="right" bgcolor="#f3f3f3" style="padding-right:15px;color:#000000;font-weight:bold;background-color:#e7e5e5;border-right:1px solid #999;border-bottom:1px solid #999">'+registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c+orders.Order_Discount__c+'</td> </tr>' );
                  replacecontactsubject =  replacecontactsubject.Replace('<tr><td colspan="4">{!displaypromovalue}</td></tr>',' <tr><td height="30" colspan="3" align="left" style="font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;padding-left:15px;background-color:#e7e5e5;border-left:1px solid #999;border-bottom:1px solid #999">Promotion Name:('+promocode+')</td> <td align="right" bgcolor="#f3f3f3" style="padding-right:15px;color:#000000;font-weight:bold;background-color:#e7e5e5;border-right:1px solid #999;border-bottom:1px solid #999">'+registrationEvent.BLN_Country__r.Currency__r.Currency_Symbol__c+orders.Order_Discount__c+'</td> </tr>' );
                   system.debug('$$$$$$$$$$$$$$$  '+replacedname );
                 } else{
                 replacedname = replacedname.Replace('<tr><td colspan="4">{!displaypromovalue}</td></tr>','');
                 replacecontactsubject = replacecontactsubject.Replace('<tr><td colspan="4">{!displaypromovalue}</td></tr>','');
                }
               
               
               system.debug('^^^^^^^^^^^^^^^^^^ '+replacedname );
                
               try{
                  replacedname = replacedname.Replace('{!promocode}',promocode );
                  replacecontactsubject = replacecontactsubject.Replace('{!promocode}',promocode );
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!promocode}','');
                 replacecontactsubject = replacecontactsubject.Replace('{!promocode}','');
               }   
               
               string qr = '<img src="';
               qr+='https://chart.googleapis.com/chart?chs=120x120&cht=qr&chl='+orders.id;
               qr+='"  width="100" height="100" />';
             
                try{
                  replacedname = replacedname.Replace('{!qrcode}',qr);
                  replacecontactsubject =  replacecontactsubject.Replace('{!qrcode}',qr);
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!qrcode}','');
                 replacecontactsubject =  replacecontactsubject.Replace('{!qrcode}','');
               } 
               
      string  emailfooter = '';       
                 list<Reg_Setting__c> rglist = new list<Reg_Setting__c>();
   rglist = [SELECT Label_Name__c,Included__c FROM Reg_Setting__c WHERE Setting_Type__c=:'Display' AND Column_Name__c=:'Include Email Footer' AND  Event__c =: eveId limit 1];
   string emailfooterinclude = string.valueof(rglist[0].Included__c);
   if(emailfooterinclude == 'true'){
    emailfooter = '<tr>'+'<td valign="top" height="57"><table width="100%"  border="0" cellpadding="0" cellspacing="0">'
                 +'<tbody><tr>'
                 +'<td width="76%"><table align="left" border="0" cellpadding="0" cellspacing="0" width="43%"><tbody>'
                 +'<tr>'
                 +'<td valign="top" style="padding: 11px 5px; line-height:22px; font-size:12px;" class="center"><a href="mailto:sales@eventdex.com" style="text-decoration:none; color:#7ebdd9; font-weight:bold;">support@eventdex.com</a> | (800) 492-1289 </td>'
                 +'</tr></tbody></table>'             
                 +'<table width="43%" style="margin-top: 15px;" border="0" cellspacing="0" cellpadding="0"><tbody>'
   +'<tr>'
     +'<td> <a href="https://www.facebook.com/eventdex" target="_blank"><img src="https://boothleads.secure.force.com/Eventdex/servlet/servlet.ImageServer?id=015F0000005kIAm&oid=00DF0000000BpyH&lastMod=1459929553000" /></a></td>'
     +'<td><a href="https://twitter.com/eventdexapps" target="_blank"><img src="https://boothleads.secure.force.com/Eventdex/servlet/servlet.ImageServer?id=015F0000005kIB6&oid=00DF0000000BpyH&lastMod=1459929636000" /></a></td>'
     +'<td> <a href="https://www.linkedin.com/company/eventdex" target="_blank"><img src="https://boothleads.secure.force.com/Eventdex/servlet/servlet.ImageServer?id=015F0000005kIB1&oid=00DF0000000BpyH&lastMod=1459929619000" /></a></td>'
     +'<td> <a href="https://www.youtube.com/user/Boothleads" target="_blank"><img src="https://boothleads.secure.force.com/Eventdex/servlet/servlet.ImageServer?id=015F0000005kIBB&oid=00DF0000000BpyH&lastMod=1459929526000" /></a></td>'
     +'<td> <a href="https://play.google.com/store/apps/details?id=com.globalnest&amp;feature=search_result#?t=W251bGwsMSwxLDEsImNvbS5nbG9iYWxuZXN0Il0." target="_blank">'
                       
                       +'<img src="https://boothleads.secure.force.com/Eventdex/servlet/servlet.ImageServer?id=015F0000005kIAw&oid=00DF0000000BpyH&lastMod=1459929590000" /></a></td>'
               
                   +'<td valign="top" style="padding: 5px 0px 0px 0px;margin-left:5px;" class="center"><a href="http://eventdex.com/" target="_blank"  ><span class="center" style="padding: 0px 0px 0px 0px "><a href="http://eventdex.com/" target="_blank"  ><img style="padding-left:136px;" src="https://boothleads.secure.force.com/Eventdex/servlet/servlet.ImageServer?id=015F0000005kIhv&oid=00DF0000000BpyH&lastMod=1459929670000" /></a></span></a></td>'
                 +'</tr></tbody>'
               +'</table>'
 +'</td>'
    +'</tr>';
    }
   system.debug('emailfooterincluded'+emailfooter);
    try{
                  replacedname = replacedname.Replace('{!Emailfooter}',emailfooter);
                  replacecontactsubject =  replacecontactsubject.Replace('{!Emailfooter}',emailfooter);
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!Emailfooter}','');
                 replacecontactsubject =  replacecontactsubject.Replace('{!Emailfooter}','');
               } 
               
              string mapurl = 'http://maps.google.com/maps?q='+eventsList[0].Venue_Name__c+','+eventsList[0].Street1__c+','+eventsList[0].City__c+','+eventsList[0].BLN_State__r.Short_Name__c+' ' +eventsList[0].ZipCode__c+','+eventsList[0].BLN_Country__r.Short_Name__c;
               
                 try{
                  replacedname = replacedname.Replace('{!mapurl}',mapurl);
                  replacecontactsubject = replacecontactsubject.Replace('{!mapurl}',mapurl);
               }catch(exception ed){
                 replacedname = replacedname.Replace('{!mapurl}','');
                 replacecontactsubject =  replacecontactsubject.Replace('{!mapurl}','');
               }
                 String orderemail='';
               
 /*  App_Setting__c app=[select id,name,event_id__c,field_code__c,event_id__r.name,field_value__c from App_Setting__c where event_id__r.name='Default Event(Boothleads)' and field_code__c='orderemail'];
  orderemail=app.field_value__c; */
 // system.debug('orderemail=================================================='+orderemail);
 
 OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'orders'];
    Id OrgWideEmail;
    if ( owea.size() > 0 ) {
        email.setOrgWideEmailAddressId(owea.get(0).Id);
        emailTOea.setOrgWideEmailAddressId(owea.get(0).Id);
        OrgWideEmail = owea.get(0).Id;
    }

              // email.setReplyTo(orderemail);
            //  email.setSenderDisplayName(orderemail);   
            system.debug('replacecontactsubject======================='+replacecontactsubject);
            system.debug('orders.BLN_TKT_profile__r.TKT_Company__c=================='+orders.BLN_TKT_profile__r.TKT_Company__c);
              email.setHtmlBody(replacedname);  
      email.setSubject(replacecontactsubject);
              
    
    
      emailTOea.setHtmlBody(replacedname);
      emailTOea.setSubject('Order confirmation of '+orders.BLN_TKT_profile__r.First_Name__c +' '+orders.BLN_TKT_profile__r.Last_Name__c+' for '+eventsList[0].Name);
        
              
              EmailsList.add(email); 
              
       /* The Below list is defined by Anil, To get the Registration Settings for Particular Event */
             list<String> Clmn = new list<String>{'StopEmailsToAttendee','StopEmailsToEventAdmin'};
              EvntEmailPref = [select Id,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c WHERE Event__c =:eventsList[0].id and Column_Name__c In:Clmn limit 10];
            system.debug('------------EvntEmailPref---Ev Adm-------'+EvntEmailPref[0].Column_Name__c);
            system.debug('------------EvntEmailPref------Attn----'+EvntEmailPref[1].Column_Name__c);

             /* The Below If Condition Defined by Anil, To restrict/Control Sending of Emails to Attendee */
      If(EvntEmailPref.size() > 0) {
        for (Reg_Setting__c rg : EvntEmailPref) {

          if (rg.Included__c == true && rg.Column_Name__c == 'StopEmailsToAttendee' && rg.Event__c == eventsList[0].id ) {
                    StopMailToAttenee = true;
                  }
          if (rg.Included__c == true && rg.Column_Name__c == 'StopEmailsToEventAdmin' && rg.Event__c == eventsList[0].id ) {
                    StopMailToEventAdmin = true;
                  }
          if (rg.Included__c == false && rg.Column_Name__c == 'StopEmailsToAttendee' && rg.Event__c == eventsList[0].id) {
                    StopMailToAttenee = false;

                  }
          if (rg.Included__c == false && rg.Column_Name__c == 'StopEmailsToEventAdmin' && rg.Event__c == eventsList[0].id ) {
                    StopMailToEventAdmin = false;
                  }

                }

             }
             
             
             
      /* Defined by Anil, To restrict/Control Sending of Emails to Attendee */
      if(StopMailToAttenee==false){        
             if(EmailsList.size()>0){
               try{
                   Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email});
          
               }catch(exception ecd){}
            }
         }
         
         
        /* Defined by Anil, To restrict/Control Sending of Emails to Event Admin */
      if (StopMailToEventAdmin == false) {

            try{
                        Messaging.SendEmailResult[] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailTOea});
                    } catch(exception rt){} 

         }   
         
         
         
       }catch(exception rr){error =   rr.getMessage();}
   return NULL;
  }
  public void dispsettings(){
 DisplaySettings = new LIST<Reg_Setting__c>();
        BLN_DisplaySettings_BAL DisplaySettingsBAL = new BLN_DisplaySettings_BAL();
       
        DisplaySettings = DisplaySettingsBAL.getregsettingslist(EventId);
        system.debug(' DISPLAY SETTINGS '+DisplaySettings);
        
}
  //Inserting Matchleads Data
public Void insertMlData(SET<id> ids){
 try{   
  BLN_Insertmldata insMldt = new BLN_Insertmldata();
  insMldt.insertMLData(ids);
  }catch(exception ex){}
}

}
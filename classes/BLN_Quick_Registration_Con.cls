/**************************************************
* @author :Arindam Sarkar
* @date 05/11/2014
* @ This class is used for Quick Registration module
****************************************************/

global without sharing class BLN_Quick_Registration_Con {
public PPPayResponse PayResponse{get;set;} 
public PPResponseEnvelope RespEnvp{get;set;}

public String selectedbdtemname{get;set;}
 public LIST<selectoption> bdstyleslist {get ; set ;}//list for badges created from badgetool
    public PageReference ordertrustpaypal() {
    ticketitems=ticketidorder;
    String xml='';
   String ChargeId='';
    BLN_TrasactionStatus paymentStatus = new BLN_TrasactionStatus();
       BLN_Payments_BAL PaymentsBAL = new BLN_Payments_BAL();
       BLN_VariablesCls variablecls = new BLN_VariablesCls();
       variablecls.EventId =event;
        variablecls.TotalAmount =  onlyticketamount.setScale(2, RoundingMode.HALF_UP)+feeamount.setScale(2, RoundingMode.HALF_UP);
        variablecls.eventAdminAmount = onlyticketamount.setScale(2, RoundingMode.HALF_UP);
         variablecls.blFeeAmount = feeamount.setScale(2, RoundingMode.HALF_UP);
          variablecls.buyerFirstname = ASFirstName;
         variablecls.buyerLastname =ASLastName; 
        variablecls.Company =ASCompanyName;
        variablecls.phone =ASPhone;
        variablecls.currencyCode =eventdetails.BLN_Country__r.Currency__r.Name;
       variablecls.Module ='Onsite';
     // create the Adaptive Toolkit object instance w/ API Credentials
     PPAdaptiveToolkit toolkit;
     String strurl = ApexPages.currentPage().getUrl();
     strurl = strurl.split('apex/')[1];
     strurl=strurl.toUpperCase();
     String pagename='';
     if(strurl.contains('BLN_QUICKREGISTRATION'))
     pagename='BLN_QUICKREGISTRATION';
     if(strurl.contains('BLN_QUICKREGISTRATIONIFRAME'))
     pagename='BLN_QUICKREGISTRATIONIFRAME';
     Cookie prcok= new Cookie('prcok',pagename,null,-1,false);
     ApexPages.currentPage().setCookies(new Cookie[]{prcok}); 
    if(paymentmethod == 'TrustCommerce'){
     Http h = new Http();
        HttpRequest req = new HttpRequest();
        Event_Pay_Gateway__c EGateway =[SELECT Registration_Type__c,Id,Name,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.name,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Name FROM Event_Pay_Gateway__c WHERE Events__c=:event and Registration_Type__c='Onsite' and Pay_Gateway__r.PGateway_Type__r.name='TrustCommerce' limit 1]; 
          variablecls.ANLoginId = EGateway.Pay_Gateway__r.PG_User_Key__c;
          variablecls.ANTransactionKey = EGateway.Pay_Gateway__r.PG_Signature__c;
         paymentStatus = PaymentsBAL.trustCommerce(variablecls);   
            
  SelectedCardType = 'Credit Card';
   }
   else if(paymentmethod=='PayPal')
   {
    SelectedCardType = 'Credit Card';
     variablecls.payKeyDuration = 'PT'+30+'M';
            variablecls.Memo = eventdetails.Name;
      blob eveuyE = Blob.valueOf(event);
             String eventidAfterEncoding = EncodingUtil.base64Encode(eveuyE );
           
            
             variablecls.CancelUrl = Label.SiteURL +'/apex/'+pagename+'?id='+event+'&tab=staffwithpayment';          
             variablecls.ReturnUrl = Label.SiteURL + '/BLN_Success?id='+eventidAfterEncoding ;      
          
   //Get Records
   Event_Pay_Gateway__c EGateway =[SELECT Registration_Type__c,Id,Name,Pay_Gateway__r.PP_Payment_Type__c,Pay_Gateway__r.PP_Fee_Payer__c,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.name,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Name FROM Event_Pay_Gateway__c WHERE Events__c=:event and Registration_Type__c='Onsite' and Pay_Gateway__r.PGateway_Type__r.name='PayPal' limit 1]; 
          variablecls.PaymentType= EGateway.Pay_Gateway__r.PP_Payment_Type__c;
          variablecls.FeesPayer = EGateway.Pay_Gateway__r.PP_Fee_Payer__c;
          variablecls.receiverEventAdm= EGateway.Pay_Gateway__r.PG_Email_Id__c;
          
    List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
    boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='PayPal'];
      variablecls.receiverEventdex=boothleadspaygate[0].PG_Email_Id__c;
      paymentStatus = PaymentsBAL.paypalAdaptive(variablecls);  
     SelectedCardType = 'PayPal';
    }//end of paypal
    if((paymentStatus.transactionId!=null && paymentStatus.transactionId!='') || (paymentStatus.payKey!=null && paymentStatus.payKey!='' ) )
 ChargeId=paymentStatus.transactionId;
 else
 {
                error=paymentStatus.errorMessage;                 
                return null;
                } 
    
    BLN_Item_DAO itdao=new BLN_Item_DAO();
  LIST<BLN_RegistrationnewCon.ItemInnerClass> ItemList= new List<BLN_RegistrationnewCon.ItemInnerClass>();
  Ticket__c maintck=[select id,name,Item__c from Ticket__c where id=:ticketitems];
  BLN_Item__c  BLNItem=itdao.GetItemDetails(' where id=\''+maintck.Item__c+'\'');
BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
Set<Id> blnitemset=new Set<Id>();
blnitemset.add(maintck.Item__c);
MAP<id,LIST<Reg_Setting__c>> RegSettingsMap = RegSettingsBAL.regsettings(blnitemset,event );
LIST<Selectoption> itemWiseCount = new LIST<Selectoption>();
itemWiseCount.add(new Selectoption(string.valueOf(1), string.valueOf(1) ));


 ItemList.add(new BLN_RegistrationnewCon.ItemInnerClass(BLNItem,itemWiseCount,String.valueOf(1),feeamount,''));
  
  
    
   BLN_Ticket_DAO TicketDAO = new BLN_Ticket_DAO();
List<Ticket__c> tckt = TicketDAO.getTickets('id,name,Custom_Barcode__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.TKT_Company__c,Parent_ID__r.Id,Item__r.Payment__c,Item__r.Event__c,Item__r.price__c,Item__r.item_name__c,Item_Type__r.name,item__r.Ticket_Settings__c,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Badgable__c,Item_Pool__r.Ticket_Settings__c,Event__c,Item__c','Event__c=\''+event +'\' AND (id=\''+ticketitems+'\' OR Parent_ID__c=\''+ticketitems+'\')'); 



LIST<BLN_RegistrationnewCon.TicketInnerClass> TicketList= new LIST<BLN_RegistrationnewCon.TicketInnerClass>();
Tkt_Profile__c tktProfileObject= new Tkt_Profile__c();
tktProfileObject.TKT_Company__c=ASCompanyName;


for(integer i=0;i<tckt.size();i++)
{
//BLNItem=itdao.GetItemDetails(' where id=\''+tckt[i].Item__c+'\'');


 //List<Ticket__c> RegTickets = quickbal.getTicketDetail(BLNItem,1); 
 
 tktProfileObject.First_Name__c = ASFirstName;
 tktProfileObject.Last_Name__c = ASLastName;
 tktProfileObject.Email__c = ASUserEmail;
 tktProfileObject.Mobile__c= ASPhone;
tktProfileObject.TKT_Job_Title__c=ASTitle;
// LoggedInGNUser.Company_Name__c = qASCompanyName;
 //LoggedInGNUser.Title__c=qASTitle;
 //BLN_RegistrationnewCon.TicketInnerClass ticketlistnew=new BLN_RegistrationnewCon.TicketInnerClass(tckt[i],1,LoggedInGNUser,1,BLNItem,null,null,null,false,new List<List<NAICS_Code__c>>(),new List<Diversity__c>(),null);
 BLN_RegistrationnewCon.TicketInnerClass ticketlistnew=new BLN_RegistrationnewCon.TicketInnerClass(tckt[i],1,1,BLNItem,RegSettingsMap ,null,null,false,new List<List<NAICS_Code__c>>(),new List<Diversity__c>(),null);
 ticketlistnew.tktProfileObject =tktProfileObject;
 if(nobadgelabel=='false')
 ticketlistnew.customBarcode=ASCustomBarcode;
 TicketList.add(ticketlistnew);
 }
 
 
 BLN_RegistrationnewCon.TicketInnerClass buyerTicketInn=new BLN_RegistrationnewCon.TicketInnerClass();
 Tkt_Profile__c tktProfileObject1= new Tkt_Profile__c();
 tktProfileObject1=tktProfileObject.clone();
 buyerTicketInn.tktProfileObject =tktProfileObject1;
 if(nobadgelabel=='false')
 buyerTicketInn.customBarcode=ASCustomBarcode;
//buyerTicketInn.EachCompany =GNbuyerCompany;
 //buyerTicketInn.EachCompanyExt = new Company_ext__c();
 //buyerTicketInn.designationComp=ASTitle;
 
 string ordstatus =quickbal.insertingTotalorder(ItemList, TicketList,buyerTicketInn,onlyticketamount, 0, feeamount,0, onlyticketamount, mapitemWithFee,null,null, SelectedCardType, paymentmethod,ChargeId, paymentmethod,'Onsite','','');
 System.debug('ordstatus '+ordstatus);
    if(ordstatus=='Success'){ 
    BLN_SchedlerCallClass scCls1 = new BLN_SchedlerCallClass();
    Blob key = Blob.valueOf(quickbal.orderId);
    String encodedCipherText = EncodingUtil.base64Encode(key); 
  if(null!=event){
    blob eveuy = Blob.valueOf(event);
    Cookie trustcommerceeventnid = new Cookie('trustcommerceeventnid',event,null,-1,false); 
     ApexPages.currentPage().setCookies(new Cookie[]{trustcommerceeventnid }); 
                    }
                      Cookie orderIdvalue = new Cookie('OrderId',encodedCipherText,null,-1,false);
                       ApexPages.currentPage().setCookies(new Cookie[]{orderIdvalue });  
                         
       if(paymentStatus.payGatewayName=='trustcommerce')
       scCls1.BLN_SchedlerMethod(120,quickbal.orderId);
       else
       scCls1.BLN_SchedlerMethod(30,quickbal.orderId);
       
       Payment__c paymentObj = new Payment__c();
                paymentObj = [select id,credit_card_last_4digits__c,credit_card_type__c ,BLN_Pay_Gateway__c,Currency_Code__c,Order__c,Payment_Amount__c,Pay_Address__c,Payment_Mode__c,Payment_Ref_Number__c,BLN_Pay_Gateway__r.PGateway_Type__r.Name,BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c from Payment__c where order__c=:quickbal.orderId];
                if(paymentStatus.payGatewayName=='paypaladaptive'||paymentStatus.payGatewayName=='trustcommerce' ){
                    paymentObj.Payment_Ref_Number__c =paymentStatus.payKey;
                   DataBase.SaveResult upRes = Database.update(paymentObj,false);
                   return paymentStatus.pgRef;   
                 }
       
    } 
    
   return null;
    }

    public String CheckNumber{get;set;}
    public String SelectedCardType { get; set; }

    public String CVVNumber { get; set; }

    public String SelectedYear { get; set; }

    public String SelectedMonth { get; set; }

    public String CreditCardNumber { get; set; }
public BLN_UtillDisplayLinks myticket { get; set; }

  
  public void displayPermissions(){
Cookie k = ApexPages.currentPage().getCookies().get('counter');
if(k!=null){
event= k.getValue();
}

myticket = new BLN_UtillDisplayLinks();

BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
BLN_Event__c se = new BLN_Event__c ();
try{
se = blneventdetailbal.eventdetails(event);
myticket.EventName=se.Name;
}catch(exception e){}



myticket.isregistrationPageExpand='expand';
myticket.isonsiteRegistrationPage='active';
myticket.isregistrationPage='';
myticket.tablabel='Onsite Registration';
myticket.EventId = event;
myticket.userPermissions(userInfo.getUserId(),event);



}

     
     
     public List<SelectOption> getGetln() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('en','ENGLISH'));
            options.add(new SelectOption('es','SPANISH'));
            return options;
        }

    public String lnsel { get; set; }

public String presentticket{get;set;}




   


    public PageReference mergeBadge() {
              //cancel badge
          String idInClause = '(\'';

         for (TicketWrapper tktwrapper: twrap){
               if(tktwrapper.selected == true) 
               idInClause += tktwrapper.tckt.Id+ '\',\'';

           }

         idInClause  = idInClause.substring(0,idInClause.length()-2);
         idInClause += ')';
         
        String q = 'select id,name,badge_label__c,cancel_time__c from Badge__c where ticket_id__c in ' + idInClause +' and cancel_time__c=null and Exp_time__c=null';
        List<Badge__c> badges=Database.query(q);
        For(integer i=0;i<badges.size();i++)
        {
          badges[i].cancel_time__c=System.now();           
        } 
        update badges;
        
        //Create badge for the First Ticket and associate all other tickets with that badge
         q = 'select id,name,badge_label__c,Badge_ID__c from Ticket__c where id in ' + idInClause;        
         List<Ticket__c> tckts=Database.query(q);        
                    Badge__c bg=new Badge__c();
                    bg.badge_label__c=badgelabel;
                    bg.ticket_id__c=tckts[0].id;
                        presentticket = tckts[0].id;
                
                    BLN_Badge_DAO bdgdao=new BLN_Badge_DAO();
                   
        BLN_StatusMessage bdgMsg =  bdgdao.insertbadge(bg);
           
              if(bdgMsg .successBool){
          
                 String badgeid=bdgMsg.successId;
                 for(integer i=1;i<tckts.size();i++)
                 {
                   tckts[i].Badge_ID__c=badgeid;
                 }
                 update tckts;
                              
              }
              
        return null;
    }


    public PageReference getSelected() {
         selectedTickets.clear();
         for(TicketWrapper tktwrapper: twrap) {
            if(tktwrapper.selected == true)
              selectedTickets.add(tktwrapper.tckt); }

            return null;
    }

public List<Ticket__c> selectedTickets{get;set;}
  

    public boolean checkboxselected { get; set; }

    public String reason{get;set;}
public String cerrormsg{get;set;}
     //update user
     public PageReference printupdate()
     {
       cerrormsg='';
       String[] ticketidandclientids = ticketitems.split(';');
        String ticketids = ticketidandclientids [0];
        BLN_Ticket_DAO tcktdao = new BLN_Ticket_DAO();
        List<Ticket__c> tc = tcktdao.getTickets('tkt_profile__c,Custom_Barcode__c,Order__c,Order__r.id,Order_Item__c,item__r.Ticket_Settings__c,Order_Item__r.Item__r.id,Order_Item__r.Item__r.item_name__c', 'id=\'' + ticketids + '\'');
        try{tc[0].Custom_Barcode__c=ASCustomBarcode;
        update tc[0];}catch(Exception e){cerrormsg='Custom Barcode already exist';
        string[] ticketidandclientid =new string[]{};
       ticketidandclientid =ticketitems.split(';');
       ticketitems=ticketidandclientid [0];
          
       changebatch();
       return null;}
       quickbal.updateExistingBadge(reason,oldbadgelabel,badgelabel,oldASTitle ,ASTitle ,oldASPhone ,ASPhone,oldASFirstName,ASFirstName,oldASLastName,ASLastName,oldASUserEmail,ASUserEmail,oldASCompanyName,ASCompanyName,ticketitems );
       
       string[] ticketidandclientid =new string[]{};
       ticketidandclientid =ticketitems.split(';');
       ticketitems=ticketidandclientid [0];
          
       changebatch();
       return null;
        
     }
   public Decimal ticketamount{get;set;}
   public Decimal onlyticketamount{get;set;}
   public Decimal feeamount{get;set;}
   public String ticketid{get;set;}
   public String clientid{get;set;}
   public String nobadgelabel{get;set;}
   public Map<id,decimal> mapitemWithFee{get;set;}
   public boolean freeticket{get;set;}
   public String ticketidorder{get;set;}
    public PageReference finditemdetail() {
    try{
    mapitemWithFee = new MAP<id,decimal>();
    badgelabel='';
    freeticket=false;
        string[] ticketidandclientid =new string[]{};
        if(ticketitems.contains(';')==false){
       // changebatch();
       Ticket__c tc=[select id,Custom_Barcode__c,name,(select id,name from badges__r),Item_Type__r.Item_Type_Number__c,Item_Pool__r.Item_type__c,Item_Pool__r.Badge_Label__c,Item_Pool__r.Badgable__c,Item_Type__c,Item__c,Item__r.price__c,Item__r.id,Ticket_Status__c,Parent_ID__c,Item__r.visibility__c from Ticket__c where Item__r.id=:ticketitems and Ticket_Status__c='Available' and Parent_ID__c=null and Item__r.visibility__c='Public' limit 1 for update];
       ticketidorder=tc.id;
       //Making the ticket reserved
       List<id> TciketsIdsFrScduler = new List<id>();
       TciketsIdsFrScduler.add(tc.id);
          tc.Ticket_Status__c='Reserved';
        update tc;
        //This class will create new Scheduler for releasing tickets
        Bln_Scheduler_ticketStatus scCls =new Bln_Scheduler_ticketStatus();    
        scCls.Bln_Scheduler(5,TciketsIdsFrScduler);
       Decimal fee=0;
       if(tc.Item_Pool__r.Badgable__c=='N - No Badge')
       {
         nobadgelabel='true';
       }
       else
       nobadgelabel='false';
       
       
       if(tc.Item_Type__r.Item_Type_Number__c=='IT-000005')//for package
       {
          List<String> itemtype=new List<String>();
          Map<String,Decimal> itemqtymap=new Map<String,Decimal>();
          for(Ticket__c ch:[select id,name,(select id,name from badges__r),Item_Pool__r.Item_type__c,Item_Pool__r.Addon_Count__c,Item_Pool__r.Item_Type__r.Item_Type_Number__c,Parent_ID__c,Item_Type__r.Item_Type_Number__c,Item_Pool__r.Badge_Label__c,Item_Type__c,Item__r.price__c from Ticket__c where Parent_ID__c=:ticketitems])
          {
            itemtype.add(ch.Item_Pool__r.Item_type__c);
            if(ch.Item_Pool__r.Item_Type__r.Item_Type_Number__c=='IT-000001'||ch.Item_Pool__r.Item_Type__r.Item_Type_Number__c=='IT-000003'||ch.Item_Pool__r.Item_Type__r.Item_Type_Number__c=='IT-000004'||ch.Item_Pool__r.Item_Type__r.Item_Type_Number__c=='IT-000011'||ch.Item_Pool__r.Item_Type__r.Item_Type_Number__c=='IT-000018'||ch.Item_Pool__r.Item_Type__r.Item_Type_Number__c=='IT-000025')
            {
             if(ch.Item_Pool__r.Badge_Label__c!=null)
            badgelabel=ch.Item_Pool__r.Badge_Label__c;
            }
            itemqtymap.put(ch.Item_Pool__r.Item_type__c,ch.Item_Pool__r.Addon_Count__c);
          } 
          for(Event_Price__c ep:[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c,Item_type__r.Item_Type_Number__c from Event_Price__c where Event__c=:event and Item_type__c in:itemtype])
          {
            fee+= (((ep.BL_Fee_Percentage__c*tc.Item__r.price__c)/100) + ep.BL_Fee_Amount__c)*itemqtymap.get(ep.Item_type__c);
             
          }
          if(fee==0){
          try{
          Event_Price__c ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c from Event_Price__c where Event__c=:event and Item_type__r.Item_Type_Number__c='IT-000001'];
          fee= ((ep.BL_Fee_Percentage__c*tc.Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
          }catch(Exception e){}
          }
          if(tc.Item__r.price__c==0){
       ticketamount=0;
       freeticket=true;
       onlyticketamount=0;
       feeamount=0;
        mapitemWithFee.put(tc.Item__c,0);
       }
       else
       {
          ticketamount=tc.Item__r.price__c+fee;
       onlyticketamount=tc.Item__r.price__c;
       feeamount=fee;
      mapitemWithFee.put(tc.Item__c,fee);
      }
       }
       else
       {
       try{
       Event_Price__c ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c from Event_Price__c where Event__c=:event and Item_type__c=:tc.Item_Type__c];
       fee= ((ep.BL_Fee_Percentage__c*tc.Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
       if(tc.Item_Type__r.Item_Type_Number__c=='IT-000010'||tc.Item_Type__r.Item_Type_Number__c=='IT-000023'||tc.Item_Type__r.Item_Type_Number__c=='IT-000008'||tc.Item_Type__r.Item_Type_Number__c=='IT-000003'||tc.Item_Type__r.Item_Type_Number__c=='IT-000004'||tc.Item_Type__r.Item_Type_Number__c=='IT-000007')
       {
       ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c,Item_Type__r.Item_Type_Number__c from Event_Price__c where Event__c=:event and Item_Type__r.Item_Type_Number__c='IT-000001'];
       fee= ((ep.BL_Fee_Percentage__c*tc.Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
       }
       }catch(Exception e)
       {}
       if(tc.Item__r.price__c==0){
       ticketamount=0;
       freeticket=true;
       onlyticketamount=0;
       feeamount=0;
        mapitemWithFee.put(tc.Item__c,0);
       }
       else
       {
       ticketamount=tc.Item__r.price__c+fee;
       onlyticketamount=tc.Item__r.price__c;
       feeamount=fee;
        mapitemWithFee.put(tc.Item__c,fee);
        }
       badgelabel=tc.Item_Pool__r.Badge_Label__c;
       } 
        return null;
        }
         ticketidandclientid =ticketitems.split(';');
          ticketid=ticketidandclientid [0];
          clientid=ticketidandclientid [1];
    
    
        Ticket__c tc=quickbal.getItemInfoFrmTicket(ticketid);
        //show Item Client Info and his badge
        oldASUserEmail =ASUserEmail =tc.tkt_profile__r.Email__c;
        oldASLastName =ASLastName =tc.tkt_profile__r.Last_Name__c;
        oldASFirstName =ASFirstName =tc.tkt_profile__r.First_Name__c;
        oldASCompanyName =ASCompanyName =tc.tkt_profile__r.TKT_Company__c;
        oldASTitle =ASTitle =tc.tkt_profile__r.TKT_Job_Title__c;
        oldASPhone =ASPhone =tc.tkt_profile__r.Mobile__c;
        ASCustomBarcode=tc.Custom_Barcode__c;
        oldbadgelabel=badgelabel=tc.badges__r.size()!=0?tc.badges__r[0].badge_label__c:tc.badge_id__r.badge_label__c; 
        if(oldbadgelabel==null)
        oldbadgelabel=badgelabel=tc.Badge_Label__c;
         badgeid=quickbal.getBadgeForTicket(tc.id);
            presentticket = tc.id;
                
         }catch(Exception e){ticketamount=0;}
    
        return null;
    }


     public String orderno{get;set;}
     public String badgeid{get;set;}
       public String badgelabel { get; set; }
     public String ASUserEmail { get; set; } // user Email
        public String ASLastName { get; set; } // User Last Name
        public String ASFirstName { get; set; } // User First Name
        public String ASPhone { get; set; }
        public String ASCustomBarCode { get; set; }
        public String ASTitle { get; set; }
        public String ASCompanyName { get; set; }
        
        //for storing old values
        public String oldASUserEmail { get; set; } // user Email
        public String oldASLastName { get; set; } // User Last Name
        public String oldASFirstName { get; set; } // User First Name
        public String oldASPhone { get; set; }
        public String oldASTitle { get; set; }
        public String oldASCompanyName { get; set; }
        public String oldbadgelabel { get; set; }
        public boolean searchFlag{get;set;}

     
      public void changeBatch()
      {
      if(ticketitems!=null)
        badgeid=quickbal.getBadgeForTicket(ticketitems);
        else
        badgeid='';
      }
      
       /*public class TicketInnerClass{
    
        public String ticketid{get;set;}
       public String qASFirstName{get;set;}
       public String qASLastName{get;set;}
       public String qASUserEmail{get;set;}
       public String qASTitle{get;set;}
       public String qASPhone{get;set;}
       public String qASCompanyName{get;set;}
        }*/
    
  public String completeorder(String qpaymentmethod,String qCheckNumber,String qevent,String qCreditCardNumber,String qselectedMonth,String qselectedyear,String qCVVNumber,Decimal qonlyticketamount,Decimal qfeeamount,Decimal ticketamountplusfee,String qASFirstName,String qASLastName,String qASUserEmail,String qASTitle,String qASPhone,String qASCompanyName,List<String> qticketids)
    {
        BLN_TrasactionStatus paymentStatus = new BLN_TrasactionStatus();
       BLN_Payments_BAL PaymentsBAL = new BLN_Payments_BAL();
       BLN_VariablesCls variablecls = new BLN_VariablesCls();
        variablecls.EventId =qevent;
        variablecls.TotalAmount =  ticketamountplusfee;
        variablecls.eventAdminAmount = qonlyticketamount;
         variablecls.blFeeAmount = qfeeamount;
        variablecls.buyerFirstname = qASFirstName;
         variablecls.buyerLastname =qASLastName; 
        variablecls.CheckNumber = qCheckNumber;
        variablecls.Company =qASCompanyName;
        variablecls.phone =qASPhone;
        variablecls.CreditCardNumber = qCreditCardNumber;
         variablecls.Selectedyear =qselectedyear;
         variablecls.SelectedMonth=qselectedMonth;
         variablecls.CVVNumber =qCVVNumber;
         variablecls.Module ='Onsite';
          variablecls.currencyCode =eventdetails.BLN_Country__r.Currency__r.Name;
        BLN_StatusMessage Response = new  BLN_StatusMessage();
        String ChargeId='';
        if(freeticket==true){
        qpaymentmethod ='Free';
        SelectedCardType='Free';
        }
    if(freeticket!=true){
        if(qpaymentmethod == 'External Pay Gateway')
        {
            SelectedCardType = 'External Pay Gateway';
             paymentStatus = PaymentsBAL.externalPayGatewayPayment(variablecls);
            }
        if(qpaymentmethod == 'Cash')
        {
            SelectedCardType = 'Cash';
             paymentStatus = PaymentsBAL.cashPayment(variablecls); 
            }         
        if(qpaymentmethod == 'Check'){
            SelectedCardType = 'Check';
            paymentStatus = PaymentsBAL.checkPayment(variablecls);
            
        }
        
        if(qpaymentmethod == 'Stripe'){
            // Get Event Payment Gateways from Event PayGateway DAO 
            BLN_EventPayGateway_DAO EventPayGatewayDAO = new BLN_EventPayGateway_DAO();
            LIST<Event_Pay_Gateway__c> EventPayGateWays = EventPayGatewayDAO.getEventPayGateWaysbasedonmodule(variablecls.EventId,'Onsite');
            String adaptivetype='';
            for(Event_Pay_Gateway__c epg:EventPayGateWays){
                if(epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Stripe'){
                   adaptivetype=epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c;
                    variablecls.StripeRefreshToken = epg.Pay_Gateway__r.PG_Signature__c; 
                    variablecls.StripeAccessToken= epg.Pay_Gateway__r.PG_User_Key__c; 
                    variablecls.StripePaymentId = epg.Pay_Gateway__r.Id;
                    variablecls.passsecret=epg.Pay_Gateway__r.PG_Pass_Secret__c;
            }
            }
            
          if(adaptivetype=='Direct')
               paymentStatus = PaymentsBAL.stripeDirectCall(variablecls);
             else
             paymentStatus = PaymentsBAL.stripeAdaptiveCall(variablecls);
             System.debug('paymentStatus   For Stripe '+paymentStatus);
             SelectedCardType='Credit Card';  
        }
        
        if(qpaymentmethod == 'PayPalDirect'){
        Event_Pay_Gateway__c EGateway =[SELECT Registration_Type__c,Id,Name,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.name,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Name FROM Event_Pay_Gateway__c WHERE Events__c=:qevent and Registration_Type__c='Onsite' and Pay_Gateway__r.PGateway_Type__r.name='PayPal' and Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c='Direct' limit 1]; 
        variablecls.receiverEventdex=EGateway.Pay_Gateway__r.PG_User_Key__c;
        variablecls.ANLoginId=EGateway.Pay_Gateway__r.PG_Pass_Secret__c;
        variablecls.ANTransactionKey=EGateway.Pay_Gateway__r.PG_Signature__c;
       paymentStatus = PaymentsBAL.paypalDirectCall(variablecls); 
       SelectedCardType='Credit Card';  
        qpaymentmethod = 'PayPal';   
        }
        if(qpaymentmethod == 'TrustCommerceDirect'){
        Event_Pay_Gateway__c EGateway =[SELECT Registration_Type__c,Id,Name,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.name,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Name FROM Event_Pay_Gateway__c WHERE Events__c=:event and Registration_Type__c='Onsite' and Pay_Gateway__r.PGateway_Type__r.name='TrustCommerce' limit 1]; 
          variablecls.ANLoginId = EGateway.Pay_Gateway__r.PG_User_Key__c;
          variablecls.ANTransactionKey = EGateway.Pay_Gateway__r.PG_Signature__c;
         paymentStatus = PaymentsBAL.trustCommercewithouthost(variablecls);   
        qpaymentmethod = 'TrustCommerce';    
   SelectedCardType='Credit Card'; 
           
        }
        
        if(qpaymentmethod=='Authorize.Net')
        {
           Event_Pay_Gateway__c EGateway =[SELECT Registration_Type__c,Id,Name,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.name,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Name FROM Event_Pay_Gateway__c WHERE Events__c=:qevent and Registration_Type__c='Onsite' and Pay_Gateway__r.PGateway_Type__r.name='Authorize.Net' limit 1]; 
          variablecls.ANLoginId = EGateway.Pay_Gateway__r.PG_User_Key__c;
          variablecls.ANTransactionKey = EGateway.Pay_Gateway__r.PG_Signature__c;
           paymentStatus = PaymentsBAL.authoriZationCall(variablecls);
             System.debug('paymentStatus   For Stripe '+paymentStatus);
              SelectedCardType='Credit Card'; 
    
        }
 
 if((paymentStatus.transactionId!=null && paymentStatus.transactionId!='') )
 ChargeId=paymentStatus.transactionId;
 else
 {
   System.debug('paymentStatus.errorMessage '+paymentStatus.errorMessage);
                error=paymentStatus.errorMessage;                 
                return null;
                }
        //insert user process
       /* BLN_Gnuser_DAO gndao=new BLN_Gnuser_DAO();
        String userid=gndao.insertGnUserprocess(qASFirstName,qASLastName,qASUserEmail,qASTitle,qASPhone,null,null,null,null,null,null);
        
   
        
        //insert company process
        BLN_Company_DAO cdao=new BLN_Company_DAO();
        String companyId=cdao.insertcompanyAnducroleprocess(qevent,qASFirstName,qASLastName,qASUserEmail,userid,qASCompanyName,null,null);
    
    
 
        
        //Insert Pay Address
        BLN_Pay_Address_DAO pdao=new BLN_Pay_Address_DAO();
        BLN_StatusMessage PayAddressMessage=pdao.insertPayAddressprocess(qevent,companyId,userid);
        
        LIST<String> UserIds = new LIST<String>();
        LIST<String> CompanyIds = new LIST<String>();
        UserIds.add(userid);
        CompanyIds.add(companyId);
        MAP<Id,Id> PromotionIdMap = new MAP<Id,Id>();
        
    Response=quickbal.updateTickets(UserIds,CompanyIds,qticketids,qevent,userid,ticketamountplusfee,0,qfeeamount,0,ticketamountplusfee,PromotionIdMap,0,'',PayAddressMessage.SuccessId,SelectedCardType,qpaymentmethod,ChargeId,qpaymentmethod); 
  */
  }
  BLN_Item_DAO itdao=new BLN_Item_DAO();
  LIST<BLN_RegistrationnewCon.ItemInnerClass> ItemList= new List<BLN_RegistrationnewCon.ItemInnerClass>();
  Ticket__c maintck=[select id,name,Item__c from Ticket__c where id=:ticketitems];
  BLN_Item__c  BLNItem=itdao.GetItemDetails(' where id=\''+maintck.Item__c+'\'');
  BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
        Set<Id> blnitemset=new Set<Id>();
blnitemset.add(maintck.Item__c);
MAP<id,LIST<Reg_Setting__c>> RegSettingsMap = RegSettingsBAL.regsettings(blnitemset,event );

LIST<Selectoption> itemWiseCount = new LIST<Selectoption>();
itemWiseCount.add(new Selectoption(string.valueOf(1), string.valueOf(1) ));


 ItemList.add(new BLN_RegistrationnewCon.ItemInnerClass(BLNItem,itemWiseCount,String.valueOf(1),qfeeamount,''));
  
  
    
   BLN_Ticket_DAO TicketDAO = new BLN_Ticket_DAO();
List<Ticket__c> tckt = TicketDAO.getTickets('id,name,Custom_Barcode__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.TKT_Company__c,Parent_ID__r.Id,Item__r.Payment__c,Item__r.Event__c,Item__r.price__c,Item__r.item_name__c,Item_Type__r.name,item__r.Ticket_Settings__c,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Badgable__c,Item_Pool__r.Ticket_Settings__c,Event__c,Item__c','Event__c=\''+event +'\' AND (id=\''+ticketitems+'\' OR Parent_ID__c=\''+ticketitems+'\')'); 



LIST<BLN_RegistrationnewCon.TicketInnerClass> TicketList= new LIST<BLN_RegistrationnewCon.TicketInnerClass>();
Tkt_Profile__c tktProfileObject= new Tkt_Profile__c();
tktProfileObject.TKT_Company__c=qASCompanyName;

for(integer i=0;i<tckt.size();i++)
{
//BLNItem=itdao.GetItemDetails(' where id=\''+tckt[i].Item__c+'\'');


 //List<Ticket__c> RegTickets = quickbal.getTicketDetail(BLNItem,1); 
 
 tktProfileObject.First_Name__c = qASFirstName;
 tktProfileObject.Last_Name__c = qASLastName;
 tktProfileObject.Email__c = qASUserEmail;
 tktProfileObject.Mobile__c= qASPhone;
 tktProfileObject.TKT_Job_Title__c=ASTitle;
 // LoggedInGNUser.Company_Name__c = qASCompanyName;
 //LoggedInGNUser.Title__c=qASTitle;
 //BLN_RegistrationnewCon.TicketInnerClass ticketlistnew=new BLN_RegistrationnewCon.TicketInnerClass(tckt[i],1,LoggedInGNUser,1,BLNItem,null,null,null,false,new List<List<NAICS_Code__c>>(),new List<Diversity__c>(),null);
 BLN_RegistrationnewCon.TicketInnerClass ticketlistnew=new BLN_RegistrationnewCon.TicketInnerClass(tckt[i],1,1,BLNItem,RegSettingsMap ,null,null,false,new List<List<NAICS_Code__c>>(),new List<Diversity__c>(),null);
ticketlistnew.tktProfileObject =tktProfileObject;
if(nobadgelabel=='false')
ticketlistnew.customBarcode=ASCustomBarcode;
 TicketList.add(ticketlistnew);
 }
 
 BLN_RegistrationnewCon.TicketInnerClass buyerTicketInn=new BLN_RegistrationnewCon.TicketInnerClass();
 Tkt_Profile__c tktProfileObject1= new Tkt_Profile__c();
 tktProfileObject1=tktProfileObject.clone();
 buyerTicketInn.tktProfileObject =tktProfileObject1;
 if(nobadgelabel=='false')
 buyerTicketInn.customBarcode=ASCustomBarcode;
 //buyerTicketInn.EachCompany =GNbuyerCompany;
 //buyerTicketInn.EachCompanyExt = new Company_ext__c();
 //buyerTicketInn.designationComp=ASTitle;
 
 string ordstatus =quickbal.insertingTotalorder(ItemList, TicketList,buyerTicketInn,qonlyticketamount, 0, qfeeamount,0, qonlyticketamount, mapitemWithFee,null,null, SelectedCardType, qpaymentmethod,ChargeId, qpaymentmethod,'Onsite','','');
   
    
   if(ordstatus=='Success'){ 
    
    try{
        //Sending email
       BLN_SuccessController blsuc=new BLN_SuccessController(); 
       System.debug('quickbal.orderId '+quickbal.orderId);
       blsuc.eventId=event;
       blsuc.orderId=quickbal.orderId;
       blsuc.sendMail(quickbal.orderId,event); 
    }
    catch(Exception e)
    {
       
    }
      }
    return ordstatus;
    
    }
    public String error{get;set;}
    public PageReference order() {
    //BLN_StatusMessage Response = new  BLN_StatusMessage();
    String Response=null;
    String response1='';
    error='';
    List<String> ticketids=new List<String>();
    String tempticketitems=ticketitems;
    ticketitems=ticketidorder;
        ticketids.add(ticketitems);
    Response =completeorder(paymentmethod,CheckNumber,event,CreditCardNumber,selectedMonth,selectedyear,CVVNumber,onlyticketamount,feeamount,ticketamount,ASFirstName,ASLastName,ASUserEmail,ASTitle,ASPhone,ASCompanyName,ticketids);
    if(Response==null)
    {
       badgeid='';
       presentticket = '';
       ticketitems=tempticketitems;
       return null;
    }
     cerrormsg='';
    if(Response=='Duplicate barcode Found!')
    {
       cerrormsg='Custom Barcode already exist';
       ticketitems=tempticketitems;
       return null;
    } 
    
    
    
   
    

     Ticket__c tc=[select id,name,Item_Pool__c,Item_Pool__r.Badgable__c,Item_Type__r.Name from Ticket__c where id=:ticketitems];
    presentticket= tc.Id;
System.debug('=====================> '+tc);
     if(tc.Item_Pool__r.Badgable__c=='N - No Badge'&&tc.Item_Type__r.Name!='Package')
     {
        error='N - No Badge';
         badgeid='';
         presentticket = '';
       return null;
     }
     if(tc.Item_Type__r.Name!='Package'){
     
      String succesbdgMsg=quickbal.generateBadge(badgelabel,ticketitems,'');
      changebatch();
      }
      else
      {
            //Get all the admission tickets
    List<Ticket__c> admticket=[select id,name,Badge_Label__c,Item_Pool__c,Item_Pool__r.Item_type__r.name,Parent_ID__c from Ticket__c where Parent_ID__c=:ticketitems and Item_Pool__r.Item_type__r.name='Admissions'];
    error='N - No Badge';
    badgeid='';
    presentticket='';
               
     //Get all the line items pool except admission
    List<Item_Pool__c> otherpool=[select id,name,Addon_Parent__c,Item_Count__c,Item_type__r.name from Item_Pool__c where Addon_Parent__c=:tc.Item_Pool__c and Item_type__r.name!='Admissions'];
    try{
    for(integer i=0;i<otherpool.size();i++)
           {
                //get addontickets for that pool
                List<Ticket__c> child=[select id,name,badgeparentid__c,Parent_ID__c,Item_Pool__c from Ticket__c where Parent_ID__c=:ticketitems and Item_Pool__c=:otherpool[i].id];
                Integer j=0;
                for(;j<child.size();j++)
                {
                    if(j==admticket.size())
                    break;
                   child[j].badgeparentid__c=admticket[j].id;
                   
                }
                for(Integer rem=j;rem<child.size();rem++)
                {
                   child[rem].badgeparentid__c=admticket[admticket.size()-1].id;
                }
                  update child;
               
               }
               }catch(Exception e){}
      }
     
      return null;


    }

      public BLN_Quick_Registration_BAL quickbal = new BLN_Quick_Registration_BAL ();
        public string[] emaiiandid{get;set;}
        public string email{get;set;}
        public string eventid{get;set;}
        public string event{get;set;}
        public BLN_Event__c eventdetails {get;set;}
        
        public List<Ticket__c> eventChosenTickets{get;set;}
        public String paymentmethod{get;set;}//holds the values of the selected checkboxes
    public list<selectOption> paymentmethoditems{get;set;}
    
    
    public list<selectOption> MonthsList{get;set;}
    public list<selectOption> YearsList{get;set;}
    public list<selectOption> CreditCardType{get;set;}
    public String selectedEvent {get;set;}
      public List<BLN_Badge_Style__c> Bdstyles {get ; set ;}
   
        
        public  BLN_Quick_Registration_Con ()
        {
        bdstyleslist = new  LIST<selectoption> ();
         cerrormsg='';
         event= Apexpages.currentPage().getParameters().get('id');
          CheckNumber='';
          //displayPermissions(); 
          eventdetails =quickbal.getEventDetails(event); 
           
           selectedEvent =event;
         if(eventdetails==null){
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Event does not Exist');
            ApexPages.addMessage(myMsg);
         return;
         
         
         }  
                //creating bages select listBdstyles = new List<BLN_Badge_Style__c> ();
  
            Bdstyles = [select id,Name,Data__c,Description__c,DefaultOnsiteBadge__c from BLN_Badge_Style__c where Event__c=: selectedEvent AND Module__c like '%Quick Registration%' ORDER BY DefaultOnsiteBadge__c DESC ];

                    for(BLN_Badge_Style__c BTS : Bdstyles ){
                    bdstyleslist.add(new selectoption(BTS.Name,BTS.Description__c));

                
                    }
    //Getting Items to book
            List<BLN_Item__c> items=quickbal.getEventItems(event);
           
       
     myitems = new list<selectOption>();
     if(ApexPages.currentPage().getParameters().get('tab')!=null&&ApexPages.currentPage().getParameters().get('tab')!='attendee'){
     
        myitems=quickbal.getAvailableTickets(items);
     
     }
    searchFlag=false;
    
    paymentmethoditems=new List<selectOption>();
    paymentmethoditems.add(new selectOption('','Select One'));
    for(integer i=0;i<eventdetails.Event_Pay_Gateway__r.size();i++)
    {
      if(eventdetails.Event_Pay_Gateway__r[i].Registration_Type__c =='Onsite'){
      if(eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.PGateway_Type__r.Name=='PayPal'&&eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c=='Direct')
      paymentmethoditems.add(new selectOption('PayPalDirect','PayPalDirect'));
      else if(eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.PGateway_Type__r.Name=='TrustCommerce'&&eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.use_host_page__c==false)
      paymentmethoditems.add(new selectOption('TrustCommerceDirect','TrustCommerceDirect'));
      else if(eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.PGateway_Type__r.Name=='Free')
      {
      }
     else{
      try{
      paymentmethoditems.add(new selectOption(eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.PGateway_Type__r.Name,eventdetails.Event_Pay_Gateway__r[i].Pay_Gateway__r.PGateway_Type__r.Name)); 
      }catch(Exception e){}
      }
      }
    }
    
   //paymentmethoditems.add(new selectOption('PayPalDirect','PayPalDirect'));
    //paymentmethoditems.add(new selectOption('CreditCard','CreditCard'));
    
    //search in chosen
   // eventChosenTickets=quickbal.getBookedTickets(event);

    //Getting Stripe Related Information
        MonthsList= new LIST<SelectOption>();
        YearsList= new LIST<SelectOption>();
        CreditCardType= new LIST<SelectOption>();
    
        LIST<String> monthstring = new LIST<String>{'01','02','03','04','05','06','07','08','09','10','11','12'};
        LIST<String> yearstring = new LIST<String>{'2014','2015','2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030'};
        LIST<String> cardtypestring = new LIST<String>{'Visa','MasterCard','American Express','Discover'};
        String SelectedYear= String.valueOf(system.today().year());
        YearsList.add(new SelectOption(SelectedYear,SelectedYear));
        String y=SelectedYear;
        for(integer l=0; l<= 15; l++){
            y = String.valueof(integer.valueOf(y)+1); 
            YearsList.add(new SelectOption(y,y));           
        }
        
        for(String m: monthstring){
            MonthsList.add(new SelectOption(m,m));
        }
    
        for(String c: cardtypestring){
            CreditCardType.add(new SelectOption(c,c));
        }
        
        
        try{
        Cookie onsiteorderid=ApexPages.currentPage().getCookies().get('onsiteorderid');
               
         
           if(onsiteorderid!= null){     
          Order__c ord=[select id,name from Order__c where id=:onsiteorderid.getValue()];
          orderno=ord.name;
          getOrderDetails();
          Cookie ss= new Cookie('onsiteorderid',null,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{ss});   
          }
          
          }catch(Exception e){}
          
                
         }
         
         
         

        
    public String ticketitems{get;set;}//holds the values of the selected checkboxes
    public list<selectOption> myitems{get;set;}
    public List<Ticket__c> ordtckt{get;set;}
    public List<TicketWrapper> twrap{get;set;}
   public pagereference getOrderDetails()
   {
   selectedTickets=new List<Ticket__c>();
   twrap=new List<TicketWrapper>();
   if(eventdetails==null)
     {
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Event does not Exist');
            ApexPages.addMessage(myMsg);
         return null;
         } 
      ordtckt=quickbal.getClientTicketsbasedonOrderOrEmail(event,orderno);
       
      if(ordtckt.size()!=0)
      {
         myitems = new list<selectOption>();
         for(Ticket__c tc:ordtckt)
         {
          myitems.add(new selectOption(tc.id+';'+tc.tkt_profile__r.BLN_GN_User__c,tc.Order_Item__r.Item__r.item_name__c+'--'+tc.tkt_profile__r.First_Name__c));   
          twrap.add(new TicketWrapper(tc)); 
         }
         
         //loading first record
         ticketitems=ordtckt[0].id+';'+ordtckt[0].tkt_profile__r.BLN_GN_User__c;
         finditemdetail();
         searchFlag=true;
      }
      else
      {
      
        ordtckt=new List<Ticket__c>();
        myitems = new list<selectOption>();
        if(ApexPages.currentPage().getParameters().get('tab')!=null&&ApexPages.currentPage().getParameters().get('tab')!='attendee'){
        List<BLN_Item__c> items=quickbal.getEventItems(event);
        
        myitems=quickbal.getAvailableTickets(items);
        
        }
        ASUserEmail ='';
        ASLastName ='';
        ASFirstName ='';
        ASCompanyName ='';
        badgeid='';
        ASTitle='';
        ASPhone ='';
        badgelabel='';
        searchFlag=false;
      }
      return null;
   }
   
   
    public PageReference processEmail() {

    User u=quickbal.getExistingUser(ASUserEmail);
    if(u.id!=null){
    ASLastName =u.LastName;
    ASFirstName=u.FirstName;
    ASPhone=u.Phone;
    ASTitle=u.title;
    ASCompanyName =u.CompanyName;
    }

        return null;
    }
    
   
   //checkbox logic
   
   public class TicketWrapper
    {
        public Ticket__c tckt{get; set;}
        public Boolean selected {get; set;}
        public TicketWrapper(Ticket__c tc)
        {
            tckt= tc;
            selected = false;
        }
    }
   
   //Avery Print Badge
   public BLN_BadgeTemplate_Styles__c btstyle{get;set;}
   public Badge bg{get;set;}
   public List<Style> elems{get;set;}
       public PageReference printAvery() {
       try
       {
        btstyle=[select BadgeName__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c from BLN_BadgeTemplate_Styles__c where Event__c=:event limit 1];
    //Parse Badge Name
    String badgename=btstyle.BadgeName__c;
    parseBadge(badgename.substring(0,badgename.length()-1));
    elems=new List<Style>(); 
    //Parse Elements
     if(btstyle.FirstRowElement__c!=null&&btstyle.FirstRowElement__c != '')
    parseElement(btstyle.FirstRowElement__c);
     if(btstyle.SecondElement__c!=null&&btstyle.SecondElement__c != '')
    parseElement(btstyle.SecondElement__c);
     if(btstyle.ThirdElement__c!=null&&btstyle.ThirdElement__c != '')
    parseElement(btstyle.ThirdElement__c);
     if(btstyle.FourthElement__c!=null&&btstyle.FourthElement__c != '')
    parseElement(btstyle.FourthElement__c);
    if(btstyle.FifthElement__c!=null&&btstyle.FifthElement__c != '')
    parseElement(btstyle.FifthElement__c );
    
  getSelected();
        Pagereference pg=new PageReference('/apex/AveryBadge');
        pg.setRedirect(false);
        return pg;
        }catch(Exception e)
        {
         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please design an Custom Template LINK:/BL_BadgeTool?eventid='+event);
            ApexPages.addMessage(myMsg);
        return null;  
        }
    }
    
    
    public void parseBadge(String bdg)
   {

     // Parse entire JSON response.
    JSONParser parser = JSON.createParser(bdg);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    bg= (Badge)parser.readValueAs(Badge.class);
                  
                

                }
            }
        }
    }
    
   }
   
   public void parseElement(String elem)
   {
     
    // Parse entire JSON response.
    JSONParser parser = JSON.createParser(elem);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    Style st= (Style)parser.readValueAs(Style.class);
                  elems.add(st);

                }
            }
        }
    }
      
   }
   
  
  
  
  
  public class Style{
  public String id{get;set;}
  public String height{get;set;}
  public String width{get;set;}
  public String positionTop{get;set;}
  public String positionLeft{get;set;}
  public String marginTop{get;set;}
  public String marginRight{get;set;}
  public String marginBottom{get;set;}
  public String marginLeft{get;set;}
  public String paddingTop{get;set;}
  public String paddingRight{get;set;} 
  public String paddingBottom{get;set;} 
  public String paddingLeft{get;set;} 
  public String textAlign{get;set;} 
  public String fontSize{get;set;} 
  public String fontFamily{get;set;} 
  public String textTransform{get;set;} 
  public String contentText{get;set;}   
  public String backgroundColor{get;set;}
  public String opacity{get;set;}
  public String textColor{get;set;}  
  public String qrUrlResult{get;set;}
  public String urlResult{get;set;}
    public Style(String id,String height,String width,String positionTop,String positionLeft,String marginTop,String marginRight,
    String marginBottom,String marginLeft,String paddingTop,String paddingRight,String paddingBottom,String paddingLeft,
    String textAlign,String fontSize,String fontFamily,String textTransform,String contentText,
    String backgroundColor,String opacity,String textColor,String qrUrlResult,String urlResult){
        id=this.id;
        height=this.height;
        width=this.width;
        positionTop=this.positionTop;
        positionLeft=this.positionLeft;
        marginTop=this.marginTop;
        marginRight=this.marginRight;
        marginBottom=this.marginBottom;
        marginLeft=this.marginLeft;
        paddingTop=this.paddingTop;
        paddingRight=this.paddingRight; 
        paddingBottom=this.paddingBottom; 
        paddingLeft=this.paddingLeft; 
        textAlign=this.textAlign; 
        fontSize=this.fontSize; 
        fontFamily=this.fontFamily; 
        textTransform=this.textTransform; 
        contentText=this.contentText; 
        backgroundColor=this.backgroundColor;
        opacity=this.opacity;
        textColor=this.textColor;  
        qrUrlResult=this.qrUrlResult;
        urlResult=this.urlResult;
    }
}


public class Badge{
public String width{get;set;}
public String height{get;set;}
public String backgroundColor{get;set;}

public Badge(String width,String height,String backgroundColor)
{
  this.width=width;
  this.height=height;
  this.backgroundColor=backgroundColor;
  
}
}

  
          
          
          
          
           //autocomplete search code for company----Arindam Sarkar
    
    public Object selectValue{get; set;}
   
     public String searchValue {get; set;}
    public Integer maxHeights {get; set;}
    public Integer height {get; set;}
    public List<SelectOption> results {get; set;}
    public Boolean showList {get; set;}
    Map<String,String> resultsMap;
 
    //This is our seach method that is called every time a character is entered
    public void search(){
  
        showList = true;
        results = new List<SelectOption>();
        resultsMap = new Map<String,String>();
 
        //Using dynamic SOQL we pass the object and the search value
        if(orderno.length() > 0){
            String entry = '%' + orderno + '%';
            //Search by First Name
            String queryString = 'Select id,name,tkt_profile__c,tkt_profile__r.First_Name__c from Ticket__c where Event__c=\''+event+'\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (tkt_profile__r.First_Name__c like :entry)';
            
          List<Ticket__c> listc=Database.query(queryString);
          Set<String> lists=new  Set<String>();
            for(Ticket__c o : listc){
                   lists.add(o.tkt_profile__r.First_Name__c);            
            }
            
            if(listc.size()==0)
            {
                queryString = 'Select id,name,tkt_profile__c,tkt_profile__r.Last_Name__c from Ticket__c where Event__c=\''+event+'\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (tkt_profile__r.Last_Name__c like :entry)';
            
          listc=Database.query(queryString);
          lists=new  Set<String>();
            for(Ticket__c o : listc){
                   lists.add(o.tkt_profile__r.Last_Name__c);            
            }
            }
            
            if(listc.size()==0)
            {
                queryString = 'Select id,name,tkt_profile__c,tkt_profile__r.Email__c from Ticket__c where Event__c=\''+event+'\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (tkt_profile__r.Email__c like :entry)';
            
          listc=Database.query(queryString);
          lists=new  Set<String>();
            for(Ticket__c o : listc){
                   lists.add(o.tkt_profile__r.Email__c);            
            }
            }
            
            if(listc.size()==0)
            {
                queryString = 'Select id,name,tkt_profile__c,tkt_profile__r.TKT_Company__c from Ticket__c where Event__c=\''+event+'\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (tkt_profile__r.TKT_Company__c like :entry)';
            
          listc=Database.query(queryString);
          lists=new  Set<String>();
            for(Ticket__c o : listc){
                   lists.add(o.tkt_profile__r.TKT_Company__c);            
            }
            }
            
            
            if(listc.size()==0)
            {
                queryString = 'Select id,name,tkt_profile__c,Order__r.name from Ticket__c where Event__c=\''+event+'\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (Order__r.name like :entry)';
            
          listc=Database.query(queryString);
          lists=new  Set<String>();
            for(Ticket__c o : listc){
                   lists.add(o.Order__r.name);            
            }
            }
            
            if(listc.size()==0)
            {
                queryString = 'Select id,name,Custom_Barcode__c,tkt_profile__c,Order__r.name from Ticket__c where Event__c=\''+event+'\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (Custom_Barcode__c like :entry)';
            
          listc=Database.query(queryString);
          lists=new  Set<String>();
            for(Ticket__c o : listc){
                   lists.add(o.Custom_Barcode__c);            
            }
            }
            
            
            /*Next we add the results to our list of selectOptions. We also add the values to a map so that when a value
            is selected we can auto fill the search box with the selected value */
            for(String o : lists){
                results.add(new SelectOption(o,o));
                resultsMap.put(o,o);
            }
        }
 
        //Next we inspect the results to set the height and contents of the selectList
        if(orderno.length() == 0){
            showList = false;
        }else if(results.size() == 0 && orderno.length() != 0){
            results.add(new SelectOption('','No matches found'));
            height = 2;
        }else if(results.size() == 1){
            height = 2;
        }else if(results.size() > maxHeights){
            height = maxHeights;
        }else{
            height = results.size();
        }
    }
 
    public String thisval{get;set;}
    //When a value is selected we will auto complete the searchValue
    public void selectValue(){
        showList = false;
        orderno= resultsMap.get((string)thisval);
        
    }
 
    //simply hides the list of resultsyo
    public void hideResults(){
        showList = false;
        
    }

    //end of autocomplete search code
          
    @RemoteAction
    global static String checkUser(String email) {
    BLN_Quick_Registration_BAL quickbal= new BLN_Quick_Registration_BAL();
    user newu=new user();
    newu.email=email;
   String userid=quickbal.checkUser(newu); // Checking user already exists
       string compId ;
       BLN_StatusMessage userMsg;
       
      if(userid==null)
      return 'Not Exist';
      else
      return 'Exist';
    }
    
    @RemoteAction
public static GN_User__c getGnuser(String email)
{

GN_User__c gnUser=new GN_User__c();
   if(email!=null&&email!=''){
   BLN_Quick_Registration_BAL quickbal= new BLN_Quick_Registration_BAL();
    user newu=new user();
    newu.email=email;
   String userid=quickbal.checkUser(newu);
   try{
  gnUser=[select id,First_Name__c,Last_Name__c,User__c,Age__c,DOB__c,Eff_Date__c,Email__c,Gender__c,Home_Phone__c,Is_Active__c,Mobile__c,User_Pic__c,Suffix__c,Prefix__c,Biography__c,Blogger__c,FaceBookId__c,LinkedInId__c,TwitterId__c,Video__c from GN_User__c where User__c=:userid];
 }catch(Exception e){}
  }
  return gnUser;
}    
    


//new code added by uday
@RemoteAction
    public static RenderData getRenderData(String EvId,String styleId) {
   
        
        BLN_CustomBagdeConNew.BadgeWithLayers style = BLN_CustomBagdeConNew.getStyle(styleId);
        
        Decimal width;
        Decimal height;
        String paperSize;
        JSONParser parser = JSON.createParser(style.badge.Data__c);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'canvasWidth' || parser.getText() == 'canvasHeight')) {
                if (parser.getText() == 'canvasWidth') {
                    parser.nextToken();
                    try {
                        width = parser.getDecimalValue();
                    } catch (Exception e) {
                        width = Decimal.valueOf(parser.getText());
                    }
                } else {
                    parser.nextToken();
                    try {
                        height = parser.getDecimalValue();
                    } catch (Exception e) {
                        height = Decimal.valueOf(parser.getText());
                    }
                }
            } else if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'paperSize')) {
                parser.nextToken();
                paperSize = parser.getText();
            }
        }
        LayoutData layoutData = getLayoutDataForSize(width, height,paperSize);
        System.debug('i am at return data');
        return new RenderData(layoutData,style);
    }
    
    public class LayoutData {
        public Integer perPage { get; set; }
        public Integer perRow { get; set; }
        public Decimal topMargin { get; set; }
        public Decimal bottomMargin { get; set; }
        public Decimal leftMargin { get; set; }
        public Decimal rightMargin { get; set; }
        public Decimal horizontalSpacing { get; set; }
        public Decimal verticalSpacing { get; set; }
        public Decimal pageWidth { get; set; }
        public Decimal pageHeight { get; set; }
        
        public LayoutData (
            Integer perPage,
            Integer perRow,
            Decimal topMargin,
            Decimal bottomMargin,
            Decimal leftMargin,
            Decimal rightMargin,
            Decimal horizontalSpacing,
            Decimal verticalSpacing,
            Decimal pageWidth,
            Decimal pageHeight
        ) {
            this.perPage = perPage;
            this.perRow = perRow;
            this.topMargin = topMargin;
            this.bottomMargin = bottomMargin;
            this.leftMargin = leftMargin;
            this.rightMargin = rightMargin;
            this.horizontalSpacing = horizontalSpacing;
            this.verticalSpacing = verticalSpacing;
            this.pageWidth = pageWidth;
            this.pageHeight = pageHeight;
        }
    }
    
    
    
    public static LayoutData getLayoutDataForSize(Decimal width, Decimal height,String papersize) {
    //Avery
        if (width == 4 && height == 3 && papersize=='8.5\" x 11\"') {
            return new LayoutData(
                6, 2,
                1, 1, 0.25, 0.25,
                0, 0,
                8.5, 11
            );
        }
        //A4 printing
        else if (width == 8.5 && height == 11) {
            return new LayoutData(
                1, 1,
                1, 1, 0.25, 0.25,
                0, 0,
                8.5, 11
            );
        }
       //Brother DK1234
        else if (width == 3.4 && height == 2.3) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.4,2.3
            );
        
        }
         //Brother DK1202
        else if (width == 3.9 && height == 2.4) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.9, 2.4
            );
        
        }//
         else if (width == 3.5 && height == 2.25) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.5, 2.25
            );
        
        }//Brother DKN 5224
          else if (width == 3.4 && height == 2.1) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.4, 2.1
            );
        
        }
        //zebra printer
        else {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                4,3
            );
        }
    }
    
    
        public class RenderData {
        public LayoutData layoutData { get; set; }
        public BLN_CustomBagdeConNew.BadgeWithLayers style { get; set; }
        
        public RenderData( LayoutData layoutData, BLN_CustomBagdeConNew.BadgeWithLayers style) {
            this.layoutData = layoutData;
            this.style = style;
        }
    }

    
}
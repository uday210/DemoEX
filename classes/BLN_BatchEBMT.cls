global without sharing class BLN_BatchEBMT implements Database.batchable<Participant>, Database.Stateful,Database.AllowsCallouts
{
   global String Apieventnamebatch{get;set;}
   global String itemid{get;set;}
   global String eveid{get;set;}
   global String t{get;set;}
   public  Map<Id,Map<String,Id>> longstatesparent{get;set;}
   public  Map<Id,Map<String,Id>> shortstatesparent{get;set;}
   public Map<String,Id> longcountries{get;set;}
   public Map<String,Id> shortcountries{get;set;}
    public Map<String,String> inputcountrymap{get;set;}
   public Map<String,String> inputstatemap{get;set;}
   public Map<String,String> inputstatecountrymap{get;set;}
   public Set<String> eventincludecountries{get;set;}
   public BLN_BatchEBMT (String apiename,String lstrftime,String itid,String evid){
    Apieventnamebatch=apiename;
    t=lstrftime;
  itemid = itid;
  eveid=evid;
  
   longstatesparent=new Map<Id,Map<String,Id>>();
    shortstatesparent=new Map<Id,Map<String,Id>>();
    longcountries=new Map<String,Id>(); 
    shortcountries=new Map<String,Id>(); 
    inputcountrymap=new Map<String,String>();
      inputstatemap=new Map<String,String>();
      inputstatecountrymap=new Map<String,String>();
    
     try{
      BLN_Item__c it=[select id,item_name__c,event__c from BLN_Item__c where id=:itid limit 1];
        eventincludecountries=new Set<String>();
      for(BLN_Event_Countries_Include__c ec:[select id,name,BLN_Country__c,BLN_Event__c from BLN_Event_Countries_Include__c where BLN_Event__c=:it.event__c])
      {
        eventincludecountries.add(ec.BLN_Country__c);  
      }  
      }catch(Exception e){}
       try{
            for(State__c state:[SELECT Id, Long_Name__c,Short_Name__c,Country__c  FROM State__c]){
        if(state.Long_Name__c != null && state.Long_Name__c != ''){
      if(longstatesparent.containskey(state.country__c))
      {
      try{
      Map<String,Id> onlystates=new Map<String,Id>();
      onlystates=longstatesparent.get(state.country__c);
      try{onlystates.put(state.Long_Name__c.touppercase(),state.id);}catch(Exception e){}
      longstatesparent.put(state.country__c,onlystates); }catch(Exception e){}
      }
      else{
      try{Map<String,Id> onlystates=new Map<String,Id>();
      try{onlystates.put(state.Long_Name__c.touppercase(),state.id);}catch(Exception e){}
      longstatesparent.put(state.country__c,onlystates);}catch(Exception e){}
      }
      }
      if(state.Short_Name__c != null && state.Short_Name__c != ''){
     
      if(shortstatesparent.containskey(state.country__c))
      {
      try{
      Map<String,Id> onlystates=new Map<String,Id>();
      onlystates=shortstatesparent.get(state.country__c);
      onlystates.put(state.Short_Name__c.touppercase(),state.id);
      shortstatesparent.put(state.country__c,onlystates); }catch(Exception e){}
      }
      else{
      try{Map<String,Id> onlystates=new Map<String,Id>();
      onlystates.put(state.Short_Name__c.touppercase(),state.id);
      shortstatesparent.put(state.country__c,onlystates);}catch(Exception e){}
      }
    }
    }
    }catch(exception ex){}
    
    try{
            for(Country__c country:[SELECT Id, Long_Name__c,Short_Name__c  FROM Country__c]){
    if(country.Long_Name__c != null && country.Long_Name__c != ''){
      longcountries.put(country.Long_Name__c.touppercase(),country.id);
      }
      if(country.Short_Name__c != null && country.Short_Name__c != ''){
      try{shortcountries.put(country.Short_Name__c.touppercase(),country.id);}catch(Exception e){}
    }
    }
    }catch(exception ex){}
    
    
    
     }
     
   global Iterable<Participant> start(Database.batchableContext batchableContext)
   { 
   
   list<Participant> plist=new list<Participant>();
    
   Http CToken = new Http();
   
     //get participants
     HttpRequest reqCToken1 = new HttpRequest();
      HttpResponse resCToken1;
    
        //get token again
          //Encrypt password using XOR
string pwd1='jRhX:6x$Wz*V&X';

            Blob beforeblob = Blob.valueOf(pwd1);
    
    // base64 encode the blob that contains our url param value
    string paramvalue = EncodingUtil.base64Encode(beforeblob);
List<Integer> pwd= BLN_GoScheduleCon.stringToCodePoint(paramvalue);
 String preSharedkey1='1a3FJpDlZt6R87Uj2q78';
 List<Integer> preSharedkey= BLN_GoScheduleCon.stringToCodePoint(preSharedkey1);
 if(preSharedkey.size() < pwd.size())
 preSharedkey.addAll(preSharedkey);
 
for (integer i = 0; i < pwd.size(); i++)
{
pwd[i]=pwd[i]^preSharedkey[i];
}
 

 
 
 String p=String.fromCharArray(pwd);
 String encodedString = EncodingUtil.urlEncode(p,'UTF-8');
 HttpRequest reqCToken = new HttpRequest();
         reqCToken.setEndpoint('https://b-comapi1.mci-group.com/API/Authenticate?ApplicationId=BOOTHLEADS&UserName=boothleads-apiuser1&Password='+encodedString+'&EventCodeList='+Apieventnamebatch);
            //String TBodyParameters = 'card[number]='+vCls.CreditCardNumber+'&card[exp_month]='+vCls.SelectedMonth+'&card[exp_year]='+vCls.Selectedyear+'&card[cvc]='+vCls.CVVNumber;
            reqCToken.setHeader('Content-Type', 'text/json');
            //reqCToken.setBody(TBodyParameters);
            reqCToken.setMethod('GET');
            
            HttpResponse resCToken;
            resCToken = CToken.send(reqCToken);
            system.debug('tk#####'+resCToken.getBody());
       String tk=(String)JSON.deserialize(resCToken.getBody(), String.class);
       
      reqCToken1.setEndpoint('https://b-comapi1.mci-group.com/API/GetParticipantList?AuthenticationToken='+tk+'&EventCode='+Apieventnamebatch+'&LastModificationUTCDate='+t.replace(' ','T'));
        //String TBodyParameters = 'card[number]='+vCls.CreditCardNumber+'&card[exp_month]='+vCls.SelectedMonth+'&card[exp_year]='+vCls.Selectedyear+'&card[cvc]='+vCls.CVVNumber;
            reqCToken1.setHeader('Content-Type', 'text/json');
            //reqCToken.setBody(TBodyParameters);
            reqCToken1.setMethod('GET');
            
            system.debug('resCToken1'+reqCToken1);
            resCToken1 = CToken.send(reqCToken1);
       
       
       
            
            plist=new List<Participant>();
          
           JSONParser parser = JSON.createParser(resCToken1.getBody());
           
    while(parser.nextToken() != null){
        if(parser.getCurrentToken() == JSONToken.START_OBJECT){
           
Participant p1 = (Participant) parser.readValueAs(Participant.class); 
plist.add(p1);
           
        }
        else if(parser.getCurrentToken() == JSONToken.END_ARRAY){
            break;  
        }
    }
       return new BLN_BatchListIteratorEBMT (plist);
       
   }
   global void execute(Database.BatchableContext batchableContext, List<Participant> scope)  
   {
    try{
      for(BLN_ExceptionCountryState__c ec:[select id,name,InputCountry__c,InputState__c,OutputCountry__c,OutputState__c,BLN_Events__c from BLN_ExceptionCountryState__c where BLN_Events__c=:eveid and OutputCountry__c!=null])
   {
   if(ec.InputCountry__c!=null&&ec.OutputCountry__c!=null)
   inputcountrymap.put(ec.InputCountry__c.touppercase(),ec.OutputCountry__c);
   if(ec.InputState__c!=null)
   {
   if(inputstatemap.containskey(ec.InputState__c)&&inputstatemap.get(ec.InputState__c)!=null)
   {
     inputstatemap.put(ec.InputState__c.touppercase(),ec.OutputState__c);
   }
   else if(!inputstatemap.containskey(ec.InputState__c))
   inputstatemap.put(ec.InputState__c.touppercase(),ec.OutputState__c);
   }
   
   if(ec.InputCountry__c==null&&ec.InputState__c!=null){
   inputstatecountrymap.put(ec.InputState__c.touppercase(),ec.OutputCountry__c);
   }
   }}catch(Exception e){}
   
    List<BLN_Event_Countries_Include__c> neweventincludecountries=new List<BLN_Event_Countries_Include__c>();
    List<BLN_ExceptionCountryState__c> excslist=new List<BLN_ExceptionCountryState__c>();
   List<Ticket__c> tcid=[select id,Custom_Barcode__c,Event__c,Tag_No__c,Badge_Label__c,name,item__r.id,item__r.Item_Pool__r.id,Item_Type__c,Item__c,Item__r.price__c,Item_Type__r.Item_Type_Number__c,Ticket_Status__c,Item__r.Event__c,Item__r.item_name__c,Item_Type__r.name,item__r.Ticket_Settings__c,Parent_ID__c,Item_Pool__r.Badgable__c,Item_Pool__r.Ticket_Settings__c from Ticket__c where Item__c=:itemid  and Ticket_Status__c='Available' limit:scope.size()];
   //if only tickets are available
   if(tcid.size()>0)
   {
   BLN_Item_DAO itdao=new BLN_Item_DAO();
   BLN_Item__c  BLNItem=itdao.GetItemDetails(' where id=\''+tcid[0].Item__c+'\''); 
   //calculating fee
        Decimal fee=0;
        Decimal ticketamount,onlyticketamount,feeamount;
        MAP<id,decimal> mapitemWithFee = new MAP<id,decimal>();
        try{
        Event_Price__c ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c from Event_Price__c where Event__c=:BLNItem.event__c and Item_type__c=:tcid[0].Item_Type__c];
       fee= ((ep.BL_Fee_Percentage__c*tcid[0].Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
       if(tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000010'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000023'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000008'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000003'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000004'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000007')
       {
       ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c,Item_Type__r.Item_Type_Number__c from Event_Price__c where Event__c=:BLNItem.event__c and Item_Type__r.Item_Type_Number__c='IT-000001'];
       fee= ((ep.BL_Fee_Percentage__c*tcid[0].Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
       }
        }catch(Exception e){}
       
       try{
       if(tcid[0].Item__r.price__c==0){
       ticketamount=0;
       onlyticketamount=0;
       feeamount=0;
        mapitemWithFee.put(tcid[0].Item__c,0);
       }
       else
       {
       ticketamount=tcid[0].Item__r.price__c+fee;
       onlyticketamount=tcid[0].Item__r.price__c;
       feeamount=fee;
        mapitemWithFee.put(tcid[0].Item__c,fee);
        }
        }catch(exception ex){}   
    if(scope.size()>0)
    {
      //BLN_Quick_Registration_Con  bl=new BLN_Quick_Registration_Con('Service');
  //Ticket__c tc=[select id,event__c,Custom_Barcode__c,name,(select id,name from badges__r),Item_Type__r.Item_Type_Number__c,Item_Pool__r.Item_type__c,Item_Pool__r.Badge_Label__c,Item_Pool__r.Badgable__c,Item_Type__c,Item__c,Item__r.price__c,Item__r.id,Ticket_Status__c,Parent_ID__c,Item__r.visibility__c from Ticket__c where Item__r.id=:itemid and Ticket_Status__c='Available' limit 1];
  //bl.ticketitems=tc.id;
  //Token=System.now()+'';
  //
  Integer i=0;
  for(Participant newp:scope)
  {
  if(newp.StatusCode==null)
  newp.StatusCode='NOT CONFIRMED';
  if(newp.StatusCode.touppercase()=='CONFIRMED'||newp.StatusCode.touppercase()=='OPTIONAL'){
  Tkt_Profile__c tktProfileObject= new Tkt_Profile__c();
  BLN_Address__c workAddress=new BLN_Address__c();
  boolean shortworkstate=false;
  String workstateshortname='';
  boolean workadd=false;
  String ticketid='';
  String workstatename='';
  if(newp.Identifier!=null&&newp.Identifier!='')
  tcid[i].Custom_Barcode__c=newp.Identifier.trim();
  if(newp.Title!=null&&newp.Title!='')
  tktProfileObject.Prefix__c=newp.Title.trim();
  if(newp.CompanyName!=null&&newp.CompanyName!='')
  tktProfileObject.TKT_Company__c=newp.CompanyName.trim();
  if(newp.FirstName!=null&&newp.FirstName!='')
  tktProfileObject.First_Name__c=newp.FirstName.trim();
  if(newp.LastName!=null&&newp.LastName!='')
  tktProfileObject.Last_Name__c=newp.LastName.trim();
  if(newp.EMail!=null&&newp.EMail!='')
  tktProfileObject.Email__c=newp.EMail.tolowercase().trim();
  if(newp.Street!=null&&newp.Street!='')
  {
  workAddress.Address1__c=newp.Street.trim();
  workadd=true;
  }
  if(newp.City!=null&&newp.City!=''){
  workAddress.City__c=newp.City.trim();
  workadd=true;
  }
  if(newp.ZipCode!=null&&newp.ZipCode!=''){
  workAddress.ZipCode__c=newp.ZipCode.trim();
  workadd=true;
  }
  
  //try{
                 if(newp.Country!=null&&newp.Country!=''){
                 
                 if(longcountries.get(newp.Country.touppercase().trim())!=null){

                  workAddress.put('Country__c',longcountries.get(newp.Country.touppercase().trim()));
                  try{
                  if(!eventincludecountries.contains(longcountries.get(newp.Country.touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=longcountries.get(newp.Country.touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(longcountries.get(newp.Country.touppercase().trim()));  
                  }
                  }catch(Exception e){}
                  }else{
                         if(shortcountries.get(newp.Country.touppercase().trim())==null){
                         if(inputcountrymap.containskey(newp.Country.touppercase().trim()))
                         {
                         workAddress.put('Country__c',inputcountrymap.get(newp.Country.touppercase().trim()));
                         try{if(!eventincludecountries.contains(inputcountrymap.get(newp.Country.touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=inputcountrymap.get(newp.Country.touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(inputcountrymap.get(newp.Country.touppercase().trim()));  
                  }}catch(Exception e){}
                         }
                         else
                         ticketid=tcid[i].id;
                       
                         }
                  }
                  
                  if(shortcountries.get(newp.Country.touppercase().trim())!=null){
                  workAddress.put('Country__c',shortcountries.get(newp.Country.touppercase().trim()));
                  try{
                  if(!eventincludecountries.contains(shortcountries.get(newp.Country.touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=shortcountries.get(newp.Country.touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(shortcountries.get(newp.Country.touppercase().trim()));  
                  }
                  }catch(Exception e){}
                  }
                  workadd=true;
                  

                  }
                 
                      //}catch(exception ex){}
  
                try{
                  if(newp.State!=null&&newp.State!=''){
                 workstatename=newp.State.touppercase().trim();
                  workadd=true;
                  }
                  
                  }catch(exception ex){}
  if(workadd==true){
 if(workAddress.Country__c ==null&&workstatename!=null)
 {
 try{
 workAddress.Country__c=inputstatecountrymap.get(workstatename);
 if(inputstatecountrymap.get(workstatename)!=null)
 ticketid='';
  if(inputstatecountrymap.get(workstatename)!=null)
  if(!eventincludecountries.contains(workAddress.Country__c))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=workAddress.Country__c,BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(workAddress.Country__c);  
                  }
                  }catch(Exception e){}
 }
 if(workstatename!=null&&workstatename!=''&&workAddress.country__c!=null&&ticketid == ''){
       Map<String,Id> onlystates=new Map<String,Id>();
       onlystates=longstatesparent.get(workAddress.country__c);
       try{
       if(onlystates.containskey(workstatename))
       workAddress.state__c=onlystates.get(workstatename);
       else
       {
          onlystates=new Map<String,Id>();
       onlystates=shortstatesparent.get(workAddress.country__c);
       try{
       if(onlystates.containskey(workstatename))
       workAddress.state__c=onlystates.get(workstatename);
       else
       {
          if(inputstatemap.containskey(workstatename))
          workAddress.put('State__c',inputstatemap.get(workstatename));
          else
          ticketid=tcid[i].id;
       }
       }catch(Exception e){
       if(inputstatemap.containskey(workstatename))
          workAddress.put('State__c',inputstatemap.get(workstatename));
          else
          ticketid=tcid[i].id;
       }
       }
       }catch(Exception e){
       if(inputstatemap.containskey(workstatename))
          workAddress.put('State__c',inputstatemap.get(workstatename));
          else
          ticketid=tcid[i].id;
       }
 
 }
 
 }
 
  
 
 
    //create order with external paygateway
           BLN_Payments_BAL PaymentsBAL = new BLN_Payments_BAL();
           BLN_TrasactionStatus paymentStatus = new BLN_TrasactionStatus(); 
 BLN_VariablesCls variablecls = new BLN_VariablesCls();
 String SelectedCardType = 'External Pay Gateway';
  paymentStatus = PaymentsBAL.externalPayGatewayPayment(variablecls);
  String ChargeId;
  if((paymentStatus.transactionId!=null && paymentStatus.transactionId!='') )
 ChargeId=paymentStatus.transactionId;
 
 LIST<BLN_RegistrationnewCon.TicketInnerClass> TicketList= new LIST<BLN_RegistrationnewCon.TicketInnerClass>();
 BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
Set<Id> blnitemset=new Set<Id>();
blnitemset.add(tcid[0].Item__c);
MAP<id,LIST<Reg_Setting__c>> RegSettingsMap = RegSettingsBAL.regsettings(blnitemset,BLNItem.event__c);

BLN_RegistrationnewCon.TicketInnerClass ticketlistnew=new BLN_RegistrationnewCon.TicketInnerClass(tcid[i],1,1,BLNItem,null,null,null,false,new List<List<NAICS_Code__c>>(),new List<Diversity__c>(),null);
ticketlistnew.tktProfileObject =tktProfileObject;
if(tcid[i].Custom_BarCode__c!=null&&tcid[i].Custom_BarCode__c!='')
ticketlistnew.custombarcode=tcid[i].Custom_BarCode__c;

if(workadd==true){
ticketlistnew.workAddress=new BLN_Address__c();
ticketlistnew.workAddress=workAddress;
}

ticketlistnew.RegSettingMap=RegSettingsMap;
 TicketList.add(ticketlistnew);
 
LIST<Selectoption> itemWiseCount = new LIST<Selectoption>();
itemWiseCount.add(new Selectoption(string.valueOf(1), string.valueOf(1) ));

LIST<BLN_RegistrationnewCon.ItemInnerClass> ItemList= new List<BLN_RegistrationnewCon.ItemInnerClass>();
 ItemList.add(new BLN_RegistrationnewCon.ItemInnerClass(BLNItem,itemWiseCount,String.valueOf(1),0,''));
 
 BLN_RegistrationnewCon.TicketInnerClass buyerTicketInn=new BLN_RegistrationnewCon.TicketInnerClass();
 Tkt_Profile__c tktProfileObject1= new Tkt_Profile__c();
 tktProfileObject1=tktProfileObject.clone();
 buyerTicketInn.tktProfileObject =tktProfileObject1;
 if(tcid[i].Custom_BarCode__c!=null&&tcid[i].Custom_BarCode__c!='')
buyerTicketInn.custombarcode=tcid[i].Custom_BarCode__c;
if(workadd==true){
buyerTicketInn.workAddress=new BLN_Address__c();
buyerTicketInn.workAddress=workAddress;
}
buyerTicketInn.RegSettingMap=RegSettingsMap;
 
  
    String qpaymentmethod = 'External Pay Gateway';
   BLN_Quick_Registration_BAL quickbal = new BLN_Quick_Registration_BAL ();
   string ordstatus;
   try{
 ordstatus =quickbal.insertingTotalorder(ItemList, TicketList,buyerTicketInn,onlyticketamount, 0, feeamount,0, onlyticketamount, mapitemWithFee,null,null, SelectedCardType, qpaymentmethod,ChargeId, qpaymentmethod,'Onsite','','');
 system.debug('---OrdrStatus@----'+ordstatus);
 }catch(Exception e){}
 
 if(ordstatus=='Success'){ 
  if(ticketid!='') 
  {
     if(newp.State==null){
     BLN_ExceptionCountryState__c excs=new BLN_ExceptionCountryState__c(BLN_Events__c=eveid,BLN_Ticket__c=ticketid,InputCountry__c=newp.Country.trim().touppercase());
     excslist.add(excs);}
     else
     {
     BLN_ExceptionCountryState__c excs=new BLN_ExceptionCountryState__c(BLN_Events__c=eveid,BLN_Ticket__c=ticketid,InputCountry__c=newp.Country.trim().touppercase(),InputState__c=newp.State.trim().touppercase());
     excslist.add(excs);
     }
  } 
    try{
        //Sending email
       //BLN_SuccessController blsuc=new BLN_SuccessController(); 
       //System.debug('quickbal.orderId '+quickbal.orderId);
       //blsuc.eventId=BLNItem.Event__c;
       //blsuc.orderId=quickbal.orderId;
       //blsuc.sendMail(quickbal.orderId,BLNItem.Event__c); 
        order__c orders =new order__c();
      orders =   [select owner.Name,createdDate,Events__r.Name,Events__r.Start_Date__c,Events__r.Venue_Name__c,Events__r.End_Date__c,Events__r.Description__c,Events__c,o.Fee_Amount__c,o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_GN_User__c, o.BLN_TKT_profile__r.BLN_Company__c, o.Amount_Paid__c,(Select Each_Ticket_Price__c,item__r.event__r.Name ,Promotion__c,Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c,order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.BLN_GN_User__r.Email__c,Item_Quantity__c, Item_Price__c, Item_Discount__c, Id,Item__r.Event__r.End_Date__c,item__r.item_name__c,Status__c,Promotion__r.Promo_Code__c,Currency__c,item__r.price__c  From Order_Items__r ),(Select Order_Item__r.Each_Ticket_Price__c,Item_Pool__c,Item_Type__c,item__r.item_name__c,id,tkt_profile__r.BLN_Company__c,tkt_profile__r.BLN_Company__r.Name,tkt_profile__r.BLN_GN_User__r.Email__c,tkt_profile__r.BLN_GN_User__r.user__c,tkt_profile__r.BLN_GN_User__r.user__r.userName,tkt_profile__r.BLN_GN_User__r.user__r.email,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,Event__c,Order__c,Order_Item__c,Ticket_Status__c,Badge_Label__c,NAme,Item_Type__r.Name,tkt_profile__r.BLN_GN_User__r.user__r.MobilePhone,lastmodifiedDate,item_pool__r.item_type__r.name from Tickets__r),(select Currency_Code__c,Pay_Address__c,Payment_Ref_Number__c,Payment_Mode__c,Payment_Amount__c,Registration_Type__c from Payments__r),BLN_TKT_profile__r.BLN_GN_User__r.user__r.Name,BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName,BLN_TKT_profile__r.BLN_GN_User__r.user__r.MobilePhone,BLN_TKT_profile__r.BLN_GN_User__r.Name,BLN_TKT_profile__r.Last_Name__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.TKT_Company__c From Order__c o where Id=: quickbal.orderId];
      orders.Order_Status__c='Fully Paid';
      SET<id> tIdForMatchleads = new SET<id>();
      List<Booth_Map__c>  bmp=new List<Booth_Map__c>();
     List<BLN_Sponsorships__c> Sponsorships=new List<BLN_Sponsorships__c>();
      for(Ticket__c ty : orders.Tickets__r){
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
     }
     for(Payment__c py : orders.Payments__r){
        py.Registration_Type__c='ExtAPI';
     }
      database.update(orders.Tickets__r,false); 
       database.update(orders.Payments__r,false); 
      database.update(orders,false);
      try{   
  BLN_Insertmldata insMldt = new BLN_Insertmldata();
  insMldt.insertMLData(tIdForMatchleads);
  }catch(exception ex){}
      if(bmp.size()>0){
          Database.insert(bmp,false);
      }
      if(Sponsorships.size()>0){
          Database.insert(Sponsorships,false);
      }
    }
    catch(Exception e)
    {
       
    }
  
  //String response=bl.completeorder('Free','',eveid,'','','','',0,0,0,newp.FirstName,newp.LastName,newp.EMail.tolowercase(),newp.Title,'',newp.CompanyName,new List<String>()); 
  }
  else
  {
     try{
         Ticket__c tcu=new Ticket__c(id=tcid[i].id,custom_barcode__c='',Ticket_status__c='Available');
         update tcu;
         }catch(Exception e){}
  }
  i++;
  if(i>=tcid.size())
  break; 
    }
    }
    
     try{
      insert neweventincludecountries;
      }catch(Exception e){}
      
      try{
      insert excslist;
      }catch(Exception e){}
   
   }
   }//end of ticket if
   }
   
   global void finish(Database.BatchableContext batchableContext){
   }
   
 
}
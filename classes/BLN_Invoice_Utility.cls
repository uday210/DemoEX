global without sharing class BLN_Invoice_Utility
{

public String InsertOrder(Id eventId,Decimal totalfeeamount)
{
  BLN_Event__c eve=[select id,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,name,Event_Status__c from BLN_Event__c where id=:eventId];
  //Create an order for event 0(Default Event(Boothleads)
BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
GN_User__c  GN = gndao.gettinggnuser(eve.ownerid);
String gnuid =GN.id;
BLN_Event__c ourevent=[select id,name from BLN_Event__c where name='Default Event(Boothleads)'];
      tkt_profile__c tktPro = new tkt_profile__c(); 
      tktPro.First_Name__c = GN.First_Name__c;
      tktPro.Last_Name__c =GN.Last_Name__c;        
      tktPro.Email__c=GN.Email__c;
      tktPro.BLN_GN_User__c=gnuid;
      tktPro.BLN_Company__c=eve.organizer_id__c;
      DataBase.saveResult tktProInsert= DataBase.insert(tktPro,false);
   Order__c ord=new Order__c();
         ord.Order_Total__c=totalfeeamount;
         ord.Order_Sub_Total__c=totalfeeamount;
         ord.Order_Discount__c=0;
         ord.Fee_Amount__c=0;
         ord.Order_Taxes__c=0;
         if(tktProInsert.isSuccess()){ 
          ord.BLN_Tkt_Profile__c = tktProInsert.getId();
          }
         //ord.Amount_Paid__c=totalamountpaid; 
         //ord.BLN_TKT_profile__r.BLN_GN_User__c=gnuid ;
         //ord.BLN_TKT_profile__r.BLN_Company__c=eve.organizer_id__c ;
         ord.Currency_Code__c=eve.BLN_Country__r.Currency__c;
         //ord.Events__c=ourevent.id;
         ord.Events__c=eventId;
        // ord.Transaction_Status__c='Not Completed';
         ord.order_type__c='EVENT PRODUCER';
         ord.Order_Status__c='Not Paid'; 
         insert ord;
    return ord.id;
}
    
public String CreateOrder(Id eventId){
   BLN_Event__c eve=[select id,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,name,Event_Status__c from BLN_Event__c where id=:eventId];
   //if(eve.Event_Status__c=='Completed')
    //{
    
    //Get all the items for that event
    List<Payment__c> directpaylist=[select id,name,Order__c,Payment_Amount__c,BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,BLN_Pay_Gateway__r.PGateway_Type__r.Name from Payment__c where Order__r.Events__c=:eventId and BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c='Direct' and Payment_Amount__c>0 ];
System.debug(directpaylist);
Set<Id> directpayorderids=new Set<Id>();
For(Payment__c p:directpaylist)
{
   directpayorderids.add(p.Order__c); 
}    
System.debug('order size'+directpayorderids.size());

List<Order__c> ordlist=[select id,Order_Discount__c,Order_Status__c,Fee_Amount__c,Order_Taxes__c,Order_Sub_Total__c,Order_Total__c,Amount_Paid__c,Events__c from Order__c where id in:directpayorderids and (Order_Status__c != 'Cancelled' AND Order_Status__c != 'Abandoned' AND Order_Status__c != 'Not Paid' ) ];
if(ordlist.size()>0)
{
Decimal totalorddiscount=0;
Decimal totalfeeamount=0;
Decimal totalordtax=0;
Decimal totalordsubtotal=0;
Decimal totalordtotal=0;
Decimal totalamountpaid=0;

For(Order__c o:ordlist)
{
  totalorddiscount+=o.Order_Discount__c;
  totalfeeamount+=o.Fee_Amount__c;
  totalordtax+=o.Order_Taxes__c;
  totalordsubtotal+=o.Order_Sub_Total__c;    
  totalordtotal+=o.Order_Total__c;
  totalamountpaid+=o.Amount_Paid__c;
}

//Create an order for event 0(Default Event(Boothleads)
 String ordid=InsertOrder(eventId,totalfeeamount);        
//Create Order Items for event 0(Default Event(Boothleads))
Map<Id,ItemList> itemcountmap;
 List<Order_Item__c > orditems=[select id,Item__c,Item__r.item_name__c,Item__r.price__c,Item__r.item_type__r.BL_Fee_Amt_per_res__c,Item__r.item_type__r.BL_Fee_Pct_per_res__c,Item_Quantity__c,Each_Ticket_Price__c,Item_Total__c,Item_Discount__c,Item_Fee__c,Order__r.Fee_Amount__c,Order__r.Order_Taxes__c,Order__c,Order__r.Events__c,Item__r.service_fee__c from Order_Item__c where Order__r.Events__c=:eventId  and Order__c in:directpayorderids and (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' )
 order by Item__c];
  itemcountmap=new Map<Id,ItemList>();
  for(Order_Item__c itemn:orditems)
  { 
     if(itemcountmap.containsKey(itemn.Item__c))
     {
       ItemList i=itemcountmap.get(itemn.Item__c);
       i.quantity+=itemn.Item_Quantity__c;
       //i.itemtotal+=itemn.Item_Fee__c;
       i.itemtotal=i.ticketprice*i.quantity;
       itemcountmap.put(itemn.Item__c,i);
     }
     
     else
     {
     ItemList i=new ItemList();
     i.itemname=itemn.Item__r.item_name__c;
     i.quantity=itemn.Item_Quantity__c;
     //i.ticketprice=itemn.Item_Fee__c;
     i.ticketprice=itemn.Item__r.item_type__r.BL_Fee_Amt_per_res__c!=0?itemn.Item__r.item_type__r.BL_Fee_Amt_per_res__c:(itemn.Item__r.price__c*itemn.Item__r.item_type__r.BL_Fee_Pct_per_res__c)/100;
     //i.itemtotal=itemn.Item_Fee__c;
     i.itemtotal=itemn.Item__r.item_type__r.BL_Fee_Amt_per_res__c*1;
     itemcountmap.put(itemn.Item__c,i);
     }
  } 
  
 List<Order_Item__c> neworditemlist=new List<Order_Item__c >();          
for(Id key:itemcountmap.keySet())
{ 
neworditemlist.add(new Order_Item__c(Currency__c=eve.BLN_Country__r.Currency__c,Item__c=key,Item_Quantity__c=itemcountmap.get(key).quantity,Item_Total__c=itemcountmap.get(key).itemtotal,Order__c=ordid));
}

insert neworditemlist;
BillCustomer(ordid);
return ordid;
}
   //}
 return '';  
    }
    
    


    
  @future(callout=true)
  public static void BillCustomer(String orderId)
  {
    Order__c ordnew=[select id,name,Order_Total__c,Fee_Amount__c,(select id,name,Item__r.Event__c from Order_Items__r),Order_Status__c from Order__c where id=:orderId]; 
    BLN_Event__c eve=[select id,organizer_id__r.PG_Authorization_Card_Type__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,name,Event_Status__c from BLN_Event__c where id=:ordnew.Order_Items__r[0].Item__r.Event__c];
    if(eve.organizer_id__r.PG_Authorization_Key__c!='Check'){
    Integer amount=Math.round(ordnew.Order_Total__c* 100);  
List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
 boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='Stripe'];
 String  Stripe_API_Key='';     
       if(boothleadspaygate.size()>0){
                 Stripe_API_Key = boothleadspaygate[0].PG_Pass_Secret__c;
                 } 
                 
                 System.debug('Stripe_API_Key'+Stripe_API_Key); 
                 Stripe StripeRequest = new Stripe(Stripe_API_Key); 
           System.debug('amount'+amount); 
StripeResponseModel StripeResponse = StripeRequest.createCharge(eve.organizer_id__r.PG_Authorization_Key__c,String.valueOf(amount),'usd','Event fee');
if(StripeResponse.isError!=true){
     
   // ordnew.Transaction_Status__c='Completed';
ordnew.Order_Status__c='Fully Paid'; 
ordnew.Amount_Paid__c=ordnew.Order_Total__c;
         update ordnew;
  //Create a payment record
Payment__c p=new Payment__c(credit_card_type__c=eve.organizer_id__r.PG_Authorization_Card_Type__c,credit_card_last_4digits__c=eve.organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,Currency_Code__c=eve.BLN_Country__r.Currency__c,Payment_Mode__c='Credit Card',Payment_Amount__c=ordnew.Order_Total__c,Payment_Ref_Number__c=StripeResponse.id,Order__c=orderId);
insert p;
       }
       }
       else if(eve.organizer_id__r.PG_Authorization_Key__c=='Check')
       {
     //  ordnew.Transaction_Status__c='Completed';
ordnew.Order_Status__c='Fully Paid'; 
ordnew.Amount_Paid__c=ordnew.Order_Total__c;
         update ordnew;
  //Create a payment record
Payment__c p=new Payment__c(Currency_Code__c=eve.BLN_Country__r.Currency__c,Payment_Mode__c='Check',Payment_Amount__c=ordnew.Order_Total__c,Order__c=orderId);
insert p;
       }
    
  }  
    
  public void SendInvoice (String OrderId,String emailId)
  {
     Order__c ordnew=[select id,name,Fee_Amount__c,(select id,name,Item__r.Event__c from Order_Items__r),Order_Status__c from Order__c where id=:orderId]; 
     
      BLN_Event__c eve=[select id,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,name,Event_Status__c from BLN_Event__c where id=:ordnew.Order_Items__r[0].Item__r.Event__c];
  String orderemail='';
  try{
  App_Setting__c app=[select id,name,event_id__c,field_code__c,event_id__r.name,field_value__c from App_Setting__c where event_id__r.name='Default Event(Boothleads)' and field_code__c='orderemail'];
  //orderemail=app.field_value__c;
  }catch(Exception e){}
     if(ordnew.Order_Status__c =='Not Paid' || ordnew.Order_Status__c =='Abandoned'){
   
  Messaging.SingleEmailMessage mail = 
      new Messaging.SingleEmailMessage();
  List<String> sendTo = new List<String>();
      sendTo.add(emailId);
      if(orderemail!='')
      sendTo.add(orderemail);
      system.debug('sendtoorderemail'+orderemail);
      mail.setToAddresses(sendTo);
      system.debug('sendtoinvoice'+sendTo);
      if(orderemail!=''){ 
      mail.setReplyTo(orderemail);
      mail.setSenderDisplayName(orderemail); }
      
  mail.setSubject('Invoice Credit Card Not valid');
      String body = 'Your Credit Card is not valid for the Event-'+eve.name+'.Please contact your customer.<br/>Order #:'+ordnew.name+'.<br/><br/><br/><br/><br/>Thanks,<br/>Eventdex';
      mail.setHtmlBody(body);
      
     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    else
    {
    
    User u=[select id,username,name,email from user where username=:emailId limit 1];
     //New instance of a single email message
 Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();
 
// Who you are sending the email to
   mail.setTargetObjectId(u.Id);

   // The email template ID used for the email
   EmailTemplate templateId = [Select id,name from EmailTemplate where name = 'InvoiceTemplate'];
   mail.setTemplateId(templateId.id);
          
   mail.setWhatId(ordnew.Id);    
   mail.setBccSender(false);
   mail.setUseSignature(false);
   if(orderemail!=''){ 
   mail.setReplyTo(orderemail);
   mail.setSenderDisplayName(orderemail);}
   mail.setSaveAsActivity(false);  
 
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
  }  
    
    public class ItemList
   {
   public String itemname{get;set;}
   public Decimal quantity{get;set;}
   public Decimal ticketprice{get;set;}
   public Decimal itemtotal{get;set;}
   }
}
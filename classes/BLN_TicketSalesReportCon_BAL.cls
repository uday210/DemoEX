/***********************************************************************************************
*   Controller Name : BLN_TicketSalesReportCon_BAL
*   Date            : 11/12/2015
*   Author          : Arindam
*   Purpose         : This class is used to display the Ticket Sales Report

**************************************************************************************************/

public without sharing class BLN_TicketSalesReportCon_BAL{
    public BLN_TicketSalesReportCon_BAL(){ }      
       
    
    public List<Item> getTicketSalesReport(List<BLN_Item__c> paramitemlist)
{
List<Item> itemnestedlist=new List<Item> ();
List<BLN_Item__c> itlist=paramitemlist;
List<Id> itemids=new List<Id>();


Map<String,List<Order_Item__c>> orderitemmap=new Map<String,List<Order_Item__c>>();
for(BLN_Item__c bli:itlist)
{
itemids.add(bli.id);

}

List<Order_Item__c> orditemlist=[select id,name,Status__c,Item__c,Order__c,Order__r.Order_Status__c,Item_Total__c,Item_Quantity__c,Item_Discount__c,Item_Fee__c,Tax__c,Order__r.order_type__c from Order_Item__c where Item__c in:itemids and Order__r.Order_Status__c!='Cancelled' AND Order__r.Order_Status__c!='Abandoned' AND Order__r.Order_Status__c!='Not Paid' and Order__r.order_type__c !='EVENT PRODUCER'];

List<Id> orderids=new List<Id>();

for(Order_Item__c ordit:orditemlist)
{
  if(orderitemmap.containskey(ordit.Item__c))
  {
    List<Order_Item__c> orditemlisttemp=orderitemmap.get(ordit.Item__c);
  orditemlisttemp.add(ordit);
  orderitemmap.put(ordit.Item__c,orditemlisttemp); 
  }
  else
  {
  List<Order_Item__c> orditemlisttemp=new List<Order_Item__c>();
  orditemlisttemp.add(ordit);
  orderitemmap.put(ordit.Item__c,orditemlisttemp);
  }
  
  
  

  orderids.add(ordit.Order__c);
}


Map<String,Payment__c> ordpayment=new Map<String,Payment__c>();
List<Payment__c> payments=[select id,name,Order__c,Payment_Amount__c,BLN_Pay_Gateway__r.PGateway_Type__r.Name,BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c from Payment__c where Order__c=:orderids];
for(Payment__c payment:payments)
{
  ordpayment.put(payment.Order__c,payment);
}


for(BLN_Item__c bli:itlist)
{

Item itemnested=new Item();
itemnested.ItemName=bli.item_name__c;
itemnested.ItemCount=Integer.valueOf(bli.item_count__c);
itemnested.ItemType=bli.item_type__r.name;
itemnested.SoldQuantity=0;
itemnested.Price=bli.price__c==null?0:bli.price__c;
Map<String,PaymentClass> paymentmap=new Map<String,PaymentClass>();
try{
for(Order_Item__c orditem:orderitemmap.get(bli.id))
{

   Payment__c payment=ordpayment.get(orditem.Order__c);
   
   if(paymentmap.containskey(payment.BLN_Pay_Gateway__r.PGateway_Type__r.Name+'('+payment.BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c+')'))
   {
     PaymentClass p=paymentmap.get(payment.BLN_Pay_Gateway__r.PGateway_Type__r.Name+'('+payment.BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c+')');
     p.PaymentType=payment.BLN_Pay_Gateway__r.PGateway_Type__r.Name+'('+payment.BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c+')';
   p.Tax+=orditem.Tax__c==null?0:orditem.Tax__c;
   p.Quantity+=orditem.Item_Quantity__c==null?0:orditem.Item_Quantity__c;
   p.Fee+=orditem.Item_Fee__c==null?0:orditem.Item_Fee__c;
   p.Price+=orditem.Item_Total__c==null?0:orditem.Item_Total__c;
    p.Discount+=orditem.Item_Discount__c==null?0:orditem.Item_Discount__c;
   if(payment.BLN_Pay_Gateway__r.PGateway_Type__r.Name=='Free'){
   p.Amount+=0;
    }
   else
   {
   if(orditem.Status__c!='Cancelled')
   p.Amount+=(orditem.Item_Total__c==null?0:orditem.Item_Total__c)+(orditem.Item_Fee__c==null?0:orditem.Item_Fee__c)+(orditem.Tax__c==null?0:orditem.Tax__c)-(orditem.Item_Discount__c==null?0:orditem.Item_Discount__c);
   else
   p.Amount+=(orditem.Item_Total__c==null?0:orditem.Item_Total__c)+(orditem.Item_Fee__c==null?0:orditem.Item_Fee__c)+(orditem.Tax__c==null?0:orditem.Tax__c)+(orditem.Item_Discount__c==null?0:orditem.Item_Discount__c);
   }
   paymentmap.put(p.PaymentType,p);
   }
   else
   {
   PaymentClass p=new PaymentClass();
   p.PaymentType=payment.BLN_Pay_Gateway__r.PGateway_Type__r.Name+'('+payment.BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c+')';
   p.Tax=orditem.Tax__c==null?0:orditem.Tax__c;
   p.Quantity=orditem.Item_Quantity__c==null?0:orditem.Item_Quantity__c;
   p.Fee=orditem.Item_Fee__c==null?0:orditem.Item_Fee__c;
   p.Discount=orditem.Item_Discount__c==null?0:orditem.Item_Discount__c;
   p.Price=orditem.Item_Total__c==null?0:orditem.Item_Total__c;
   if(payment.BLN_Pay_Gateway__r.PGateway_Type__r.Name=='Free'){
   p.Amount=0;
   }
   else
   {
   if(orditem.Status__c!='Cancelled')
   p.Amount=(orditem.Item_Total__c==null?0:orditem.Item_Total__c)+(orditem.Item_Fee__c==null?0:orditem.Item_Fee__c)+(orditem.Tax__c==null?0:orditem.Tax__c)-(orditem.Item_Discount__c==null?0:orditem.Item_Discount__c);
   else
   p.Amount=(orditem.Item_Total__c==null?0:orditem.Item_Total__c)+(orditem.Item_Fee__c==null?0:orditem.Item_Fee__c)+(orditem.Tax__c==null?0:orditem.Tax__c)+(orditem.Item_Discount__c==null?0:orditem.Item_Discount__c);
   }
   paymentmap.put(p.PaymentType,p);
   }
   
  
}
itemnested.Payment=paymentmap.values();
for(PaymentClass p:paymentmap.values())
{
itemnested.Tax+=p.Tax;
itemnested.Fee+=p.Fee;
itemnested.Discount+=p.Discount;
itemnested.Amount+=p.Amount;
itemnested.SoldQuantity+=p.Quantity;
   
}


}catch(Exception e){}
itemnestedlist.add(itemnested);
}

return itemnestedlist;
}



public Class Item
{
public String ItemName{get;set;}
public Integer ItemCount{get;set;}
public String ItemType{get;set;}
public Decimal SoldQuantity{get;set;}
public Decimal Price{get;set;}
public Decimal Tax{get;set;}
public Decimal Fee{get;set;}
public Decimal Discount{get;set;}
public Decimal Amount{get;set;}

public List<PaymentClass> Payment{get;set;}

public Item()
{
Tax=0;
Fee=0;
Discount=0;
Amount=0;

}

}


public Class PaymentClass
{
  public String PaymentType{get;set;}
  public Decimal Tax{get;set;}
  public Decimal Quantity{get;set;}
public Decimal Fee{get;set;}
public Decimal Discount{get;set;}
public Decimal Amount{get;set;}
public Decimal Price{get;set;}
}
    
    }
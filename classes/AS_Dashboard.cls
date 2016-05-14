@RestResource(urlMapping='/AS_Dashboard/*')
  
 global with sharing class AS_Dashboard{
    
    @HttpGet
    global static Container doGet(){
    RestRequest req = RestContext.request;
    String EventID = req.params.get('EventID');
    Container con=new Container();
    decimal totalcount=0,checkincount=0,checkoutcount=0;
  for(Individual_Ticket_Info__c iti:[SELECT Name,Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.customer_key__r.isInserted__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE  AND Registration_Info__r.Event__c=:EventId AND  Registration_Info__r.customer_key__r.isInserted__c=true AND  Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE ORDER BY Name]){
          
            if(iti.isCheckedIn__c==true)
           { 
             checkincount++;   
            }
            else
            {
              checkoutcount++;
            }
            
          totalcount++; 
    
    }
    Decimal checkinpercent,checkoutpercent;
    if(totalcount==0){
    checkinpercent=0;
    checkoutpercent=0;}
    else
    {
     checkinpercent=(checkincount/totalcount)*100;
    checkoutpercent=(checkoutcount/totalcount)*100;
    }
    
    
    con.CheckIn=new CheckIn(totalcount,checkincount,checkinpercent);
    con.CheckOut=new CheckOut(totalcount,checkoutcount,checkoutpercent);
    
    
    
    Decimal TotalTicketQty=0,TotalRevenue=0,TotalTicketsSold=0,Percentage=0;
    for(TicketTypes__c tt:[select id,name,EV_id__c,TT_Sold__c,TT_Available__c,TT_Amount__c,TT_Name__c,(select id,name,Amount__c,customer_key__r.isInserted__c,Tickets_Quantty__c,For_Refund__c from Dummays__r where customer_key__r.isInserted__c=true and Event__c!=null) from TicketTypes__c where EV_id__c=:EventId and TT_Name__c!='Guest'and TT_Name__c!='Attendee Staff'])
    {
      integer soldTicks =0;
       for(Dummay__c d: tt.Dummays__r){
            if(null != d.Tickets_Quantty__c){
             soldTicks += integer.ValueOf(d.Tickets_Quantty__c);
            }
          }
      
       TotalTicketQty=TotalTicketQty+tt.TT_Available__c;
       //TotalRevenue=TotalRevenue+(tt.TT_Sold__c*tt.TT_Amount__c);
        TotalTicketsSold=TotalTicketsSold+soldTicks ;
        
    }
   
   for(Dummay__c dum : [select Name ,(select id,isCancelled__c,Registration_Info__r.Event__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.isCancelled__c,IsItem__c  from Individual_Ticket_Info__r), TicketAmount__c,Tickets_Quantty__c,id,customer_key__c,customer_key__r.isInserted__c,Amount__c from Dummay__c where Event__c=:EventId and customer_key__r.isInserted__c=true]){
      TotalRevenue+=dum.Amount__c; 
    }

   
   
    
    if(TotalTicketQty==0)
     Percentage=0;
     else
    Percentage=(TotalTicketsSold/TotalTicketQty)*100;
    con.Tickets=new Tickets(TotalTicketQty,TotalRevenue,TotalTicketsSold,Percentage);
    
    
    
    Decimal TotalItemQty=0,TotalItemRevenue=0,TotalItemSold=0,ItemPercentage=0;
    for(Item__c tt:[select id,name,Event__c,Sold_Quantity__c,Item_Quantity__c,Cost__c,(select id,name,Amount__c,Tickets_Quantty__c,For_Refund__c from Registration_Info__r) from Item__c where Event__c=:EventId])
    {
    
       for(Dummay__c d: tt.Registration_Info__r){
           TotalItemRevenue=TotalItemRevenue+d.Amount__c; 
        }
    
       TotalItemQty=TotalItemQty+tt.Item_Quantity__c;
       //TotalItemRevenue=TotalItemRevenue+(tt.Sold_Quantity__c*tt.Cost__c);
        TotalItemSold=TotalItemSold+tt.Sold_Quantity__c;
        
    }
     if(TotalItemQty==0)
     ItemPercentage=0;
     else
     ItemPercentage=(TotalItemSold/TotalItemQty)*100;
     con.Items=new Items(TotalItemQty,TotalItemRevenue,TotalItemSold,ItemPercentage);
   
    return con;
    
    
    }
    
    
    
    global class Container
    {
      public CheckIn CheckIn{get;set;}
      public CheckOut CheckOut{get;set;}
      public Tickets Tickets{get;set;}
      public Items Items{get;set;}
    }
    
    global class CheckIn
    {
      public Decimal TotalCount{get;set;}
      public Decimal CheckInCount{get;set;}
      public Decimal Percentage{get;set;}
      public CheckIn(Decimal TotalCount,Decimal CheckInCount,Decimal Percentage)
      {
        this.TotalCount=TotalCount;
        this.CheckInCount=CheckInCount;
        this.Percentage=Percentage;
        
      }
      
    }
    
    
    global class CheckOut
    {
      public Decimal TotalCount{get;set;}
      public Decimal CheckOutCount{get;set;}
      public Decimal Percentage{get;set;}
       public CheckOut(Decimal TotalCount,Decimal CheckOutCount,Decimal Percentage)
      {
        this.TotalCount=TotalCount;
        this.CheckOutCount=CheckOutCount;
        this.Percentage=Percentage;
        
      }
    }
    
    
     global class Tickets
    {
      public Decimal TotalTicketQty{get;set;}
      public Decimal TotalRevenue{get;set;}
      public Decimal TotalTicketsSold{get;set;}
      public Decimal Percentage{get;set;}
       public Tickets(Decimal TotalTicketQty,Decimal TotalRevenue,Decimal TotalTicketsSold,Decimal Percentage)
      {
        this.TotalTicketQty=TotalTicketQty;
        this.TotalRevenue=TotalRevenue;
        this.TotalTicketsSold=TotalTicketsSold;
        this.Percentage=Percentage;
        
      }
    }
    
    
    
    
     global class Items
    {
      public Decimal TotalTicketQty{get;set;}
      public Decimal TotalRevenue{get;set;}
      public Decimal TotalTicketsSold{get;set;}
      public Decimal Percentage{get;set;}
       public Items(Decimal TotalTicketQty,Decimal TotalRevenue,Decimal TotalTicketsSold,Decimal Percentage)
      {
        this.TotalTicketQty=TotalTicketQty;
        this.TotalRevenue=TotalRevenue;
        this.TotalTicketsSold=TotalTicketsSold;
        this.Percentage=Percentage;
        
      }
    }
    
    
    }
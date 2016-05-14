/***********************************************************************************************
*   Controller Name : BLN_AbandonedOrdersReportCon
*   Date            : 02/22/2016
*   Author          : Vineel Ragula
*   Purpose         : This class is to display the Abandoned Orders Report
**************************************************************************************************/

public class BLN_AbandonedOrdersReportCon {   
    
  public String SelectedEvent{get; set;}  
  public List<Order__C> abandonedOrd {get;set;}       
       public BLN_AbandonedOrdersReportCon() {
       try{
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
         if(k!=null){ 
      selectedEvent = k.getValue();
       }
       }catch(exception ee){}
       abandonedOrd = new List<Order__c>();
       abandonedOrd =  [Select id,Name,BLN_TKT_profile__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.TKT_Company__c,BLN_TKT_profile__r.Mobile__c,CreatedDate,BLN_TKT_profile__r.Last_Name__c,BLN_TKT_profile__r.Email__c,Currency_Code__c,Events__c,Fee_Amount__c,Order_Discount__c,Order_Status__c,Order_Sub_Total__c,Order_Taxes__c,Order_Total__c,order_type__c,Amount_Paid__c, (select id,name,Payment_Mode__c,Payment_Ref_Number__c from Payments__r) From Order__c where Order_Status__c='Abandoned' AND Events__c =:selectedEvent];
       BLN_Event__c  seventdet = new BLN_Event__c  ();
       
       system.debug('abandonedOrd==='+abandonedOrd);
       
       }
       
  public date startdte{get;set;} 
  public date enddte { get; set; }
  Public String currencySymbol{get;set;}      
  public BLN_Event__c  se{get;set;}
  public BLN_UtillDisplayLinks   myticket { get; set; }
 
  public PageReference hideEventsTab() {
    try{
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){ 
      selectedEvent = k.getValue();
       }
   
     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     se = new BLN_Event__c  ();
      try{
     se = blneventdetailbal.eventdetails(selectedEvent );
     currencySymbol = se.BLN_Country__r.Currency__r.Currency_Symbol__c;
     }catch(exception e){}
      
        myticket = new BLN_UtillDisplayLinks();
        myticket.isReportsPageExpand='expand';
        myticket.isAbandonedOrderReportPage='active';
        myticket.tablabel='Abandoned Orders Report';
        myticket.EventId = selectedEvent ;    
    
   try{
     myticket.eventName=se.NAme;
    }catch(exception e){}
     myticket.userPermissions(userInfo.getUserId(),selectedEvent);
     }catch(exception ex){}
        return null;
     
    }
    
    
    // Print Abandoned Orders
    public BLN_EventDetails eventInfo1{get; set;}
    public pageReference printabandonedordersummary(){
        eventInfo1= new BLN_EventDetails();
        eventInfo1.eventDetailsToDisplay(selectedEvent);
        pageReference pg =new pageReference('/apex/BLN_PrintAbandonedReport');
        return pg;
    }    
   
              
   // Export Abandoned Orders 
    public pageReference exportabandonedordersummary(){
        pageReference pg = page.BLN_ExportAbandonedReport;
        return pg;
    }         
            
    
}
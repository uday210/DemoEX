public with sharing class BL_TransactionDetailsCon {

 
 public Dummay__c  dumForCalender{get;set;}
 public List<Constomer__c> transactions{get;set;} 
 public decimal checkAmount{get;set;}
 public decimal creditCardAmount{get;set;}
 public decimal cashamount{get;set;}
 public decimal Total{get;set;}
 public string selectedEvent{get;set;}
 public MAP<string,Constomer__c> mapIdWithcum {get;set;}
  public List<Constomer__c> newCusList {get;set;} 
 
  public BL_TransactionDetailsCon(){
    newCusList =new List<Constomer__c>();
    
   selectedEvent =Apexpages.CurrentPage().getParameters().get('id'); 
   dumForCalender = new Dummay__c ();
 
   showReport();  
   newCusList.addAll(transactions);
   tickettype();
  }
  
  
  public List<Constomer__c> showReport(){
     mapIdWithcum  = new MAP<string,Constomer__c>();
     checkAmount = 0.0;
      creditCardAmount = 0.0;
      cashamount=0.0;
      Total =0.0;
      SET<Id> setOftrans = new SET<Id>();
      
        LIst<Dummay__c> dumsListOfthisEve = new LIst<Dummay__c>();
          for(Dummay__c dp : [select id,customer_key__c from Dummay__c  where event__r.id=:selectedEvent]){
             setOftrans.add(dp.customer_key__c); 
          }
  
      transactions = new List<Constomer__c>();
      transactions=[select createdDate,ID,Customer_Name__c,Email__c,Amount_With_Fee__c,Total_Amount__c,Name,Payment_Type__c,Payment_Status__c,payKey__c,(select id,Email__c,First_Name__c,Last_Name__c,payKey__c,Payment_Status__c,Payment_Type__c,Phone__c,DiscountValue__c,Company__c,TicketTypes__r.TT_Name__c,Tickets_Quantty__c,Ticket_Amount__c from Dummays__r),isInserted__c from Constomer__c where ID IN :setOftrans and isInserted__c =true order By createdDate desc];
       for(Constomer__c cu :transactions){
          mapIdWithcum.put(cu.id,cu);  
          if(cu.Payment_Type__c=='Credit Card'){
             creditCardAmount+=cu.Amount_With_Fee__c;
          }else if(cu.Payment_Type__c=='Check'){
             checkAmount+=cu.Amount_With_Fee__c;
          }else if(cu.Payment_Type__c=='Cash'){
             cashamount+=cu.Amount_With_Fee__c;
          }
          //cu.Total_Amount__c =1.0;
          Total +=cu.Amount_With_Fee__c;
          //Amount_With_Fee__c;
          
       }
     return null;
   }
   
   public string selectedInn{get;set;}
   public void updatePaymentDetails(){
   system.debug('AAAAAAAAAAAAAAAAAA'+Apexpages.currentPage().getPArameters().get('selectedInn'));
   selectedInn = Apexpages.currentPage().getPArameters().get('selectedInn');
     Constomer__c cup = new Constomer__c();
     cup = mapIdWithcum.get(selectedInn);
     system.debug('BBBBBBBBBBBBBB '+cup );
     dataBAse.update(cup,false);
     List<Dummay__c> dpList = new List<Dummay__c>();
     
      for(Dummay__c dp :[select id,Payment_Status__c from Dummay__c where customer_key__c=:selectedInn]){
        dp.Payment_Status__c  = cup.Payment_Status__c;
        dpList.add(dp); 
      }
      if(dpList.size()>0){
         dataBAse.update(dpList,false);
      }
     
     
   }
   
  public pageReference  exportTransactions(){
     pageReference pf = new Pagereference('/apex/BL_TransactionDetails_export');
     return pf;
      
  }
  
  public void transactionFilter(){
  date dStart =dumForCalender.End_Date__c ;
  date dEnd =  dumForCalender.Start_Date__c;
  
   checkAmount = 0.0;
      creditCardAmount = 0.0;
      cashamount=0.0;
      Total =0.0;
  
   system.debug('SSSSSSSSSSSSSSSS '+dStart  +'   '+'EEEEEEEEEEEEEEEEEEEEEEE '+dEnd );
     transactions = new  List<Constomer__c>();
      if(dumForCalender.Start_Date__c !=null &&  dumForCalender.End_Date__c != null){
         for(Constomer__c cp :newCusList){
          system.debug('SSSSSSSSSSSSSSSS '+cp.createdDate.date() +'   '+'EEEEEEEEEEEEEEEEEEEEEEE '+dumForCalender.Start_Date__c );
          if(cp.createdDate.date()>=dumForCalender.Start_Date__c && cp.createdDate.date()<=dumForCalender.End_Date__c ){
               transactions.add(cp);
           if(cp.Payment_Type__c=='Credit Card'){
              creditCardAmount+=cp.Amount_With_Fee__c;
          }else if(cp.Payment_Type__c=='Check'){
             checkAmount+=cp.Amount_With_Fee__c;
          }else if(cp.Payment_Type__c=='Cash'){
             cashamount+=cp.Amount_With_Fee__c;
          }
          //cu.Total_Amount__c =1.0;
          Total +=cp.Amount_With_Fee__c;
        }
      }      
      }else{
       transactions.addAll(newCusList);
         for(Constomer__c cp :transactions){
           if(cp.Payment_Type__c=='Credit Card'){
              creditCardAmount+=cp.Amount_With_Fee__c;
          }else if(cp.Payment_Type__c=='Check'){
             checkAmount+=cp.Amount_With_Fee__c;
          }else if(cp.Payment_Type__c=='Cash'){
             cashamount+=cp.Amount_With_Fee__c;
          }
          //cu.Total_Amount__c =1.0;
          Total +=cp.Amount_With_Fee__c;
         }
       
      }
      
  
  }
   public List<TicketTypes__c> ticQuan{set;get;}
  public void tickettype()
  {
    ticQuan = new List<TicketTypes__c>();
ticQuan = [select id,TT_Amount__c,Available__c,Avilable_for_Portal__c,Description__c,Sales_End_Date__c,Sales_Start_Date__c,TT_Sold__c,TT_Available__c,Total_Amount__c,Type__c from TicketTypes__c where EV_id__c= :selectedEvent];
  }
  
}
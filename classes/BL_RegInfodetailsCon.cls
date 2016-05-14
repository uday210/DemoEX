public with sharing class BL_RegInfodetailsCon {

   
 public List<selectOption> options{get;set;}
 public string selectedValue{get;set;}
 public MAP<id,Constomer__c> mapidWithcum{get;set;}
 
 public BL_RegInfodetailsCon(){
  options = new List<selectOption>();
    outParameterList = new List<PaymentDetailInfo>();
   List<Event__c> eventsList =[select id,EV_Title__c from Event__c ];
     if(eventsList.size()>0){
          selectedValue= eventsList[0].id;
      }     
       for(Event__c eve : eventsList){
         options.add(new selectOption(eve.id,eve.EV_Title__c));       
       }
   onchangeEvent();
   
  }
  
 public List<Constomer__c> transactions{get;set;}
    public void  onchangeEvent(){
       mapidWithcum = new MAP<id,Constomer__c>();
       
       LIst<Dummay__c> dumsListOfthisEve = new LIst<Dummay__c>();
       SET<id> setOftrans = new SEt<id>();
         for(Dummay__c dp : [select id,customer_key__c,customer_key__r.isinserted__c from Dummay__c  where event__r.id=:selectedvalue and customer_key__r.isinserted__c=false]){
             setOftrans.add(dp.customer_key__c); 
          }
          system.debug('CCCCCCCCCCCCCCC  '+selectedValue);  
  
      transactions = new List<Constomer__c>();
      transactions=[select createdDate,ID,Customer_Name__c,Email__c,Amount_With_Fee__c,Total_Amount__c,Name,Payment_Type__c,Payment_Status__c,payKey__c,(select id,Email__c,First_Name__c,Last_Name__c,payKey__c,Payment_Status__c,Payment_Type__c,Phone__c,DiscountValue__c,Company__c,TicketTypes__r.TT_Name__c,Tickets_Quantty__c,Ticket_Amount__c from Dummays__r),isInserted__c,dontShow__c from Constomer__c where ID IN :setOftrans and isInserted__c =false and dontShow__c =false order By createdDate desc];
      system.debug('AAAAAAAAAAAAAAAAAAAA '+transactions);  
      
      for(Constomer__c c:transactions){
         mapidWithcum.put(c.id,c);
      }
      
 }
  
  
  public PageReference hideRec() {
  
   Constomer__c cu =new Constomer__c();
   try{
    cu =mapidWithcum.get(Apexpages.currentPage().getPArameters().get('recid'));
     cu.dontShow__c =true;
     database.update(cu,false);
     onchangeEvent();
     }catch(exception er){}
     return null;
    }

  
  
  
  
  public List<PaymentDetailInfo> outParameterList         {get;set;}
  public void checkPaymentStatus(){
    outParameterList = new List<PaymentDetailInfo>();
    string paykeyvalue = ApexPages.currentPage().getParameters().get('ketno');
     ControllerPayDetailApi  con = new ControllerPayDetailApi();
     con.payKey = paykeyvalue;
     con.CommonParametersObjName = 'MyRequestParams';
     con.APICredentialObjName ='SandboxCert';
     con.PayDetail();
     outParameterList = con.outParameterList;
  }
   
}
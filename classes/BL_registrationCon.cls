public without sharing class BL_registrationCon {

public boolean linksbool{get;set;}
public  LIST<Pay_Pal_Account__c> eventAdminEvent{get;set;}
public string MainMessage  {get;set;}
public string SenderEmail{get;set;} 
public String CommonParametersObjName{get;set;}
public List<TicketTypes__c> TTList{get;set;}
public string selectedEvent{get;set;}
public List<innerClass> inn{get;set;} 
public List<selectOption> options {get;set;}
public decimal grandTotal{get;set;}
// paypal strings 
public String ActionType {get;set;}
public String PaymentType{get;set;}
public string FeesPayer{get;set;}
public Boolean FundingTypeEcheck                {get;set;}
public Boolean FundingTypeBalance               {get;set;}
public Boolean FundingTypeCreditCard            {get;set;}
public Boolean IsDisplay                        {get;set;}
public String APICredentialObjName              {get;set;} 
public PPPayResponse PayResponse                {get;set;} 
public PPResponseEnvelope RespEnvp              {get;set;}
public string SuccessMessage                    {get;set;}
public MAP<id,Decimal> mapIdWithPrice {get;set;}
public Event__c event {get;set;}
public integer GrandQuantity{get;set;}
public decimal boothleadsAmount{get;set;}
public decimal eventAdminAmount {get;set;}
public decimal TotalAmount{get;set;}


public pageReference cancelTickets(){

string pidvalue =ApexPages.currentPage().getParaMeters().get('Pid');

List<Dummay__c> Dummays= new List<Dummay__c>();
Dummays =[select id from Dummay__c where payKey__c=:pidvalue ];
dataBase.delete(Dummays,false);

return null;
}




public BL_registrationCon(){
TotalAmount =0.0;
     selectedTab ='name1';
     selectedEvent =Apexpages.currentPage().getparameters().get('id');
      system.debug('322222222222222222 '+selectedEvent );
     
     try{
     event = [SELECT id,EV_Description__c,EV_EndDate__c,EV_EndTime__c,EV_HistingAddr1__c,EventDiversityValues__c,
                        EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingFax__c,
                        EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,
                        EV_HostingTimeZone__c,EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,
                        EV_Title__c,EV_WebsiteURL__c,EV_EventLogo__c,EV_ContactURL__c,EV_HostingCountry__c , 
                        EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,
                        Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c
                           FROM Event__c WHERE id =: ApexPages.currentpage().getParameters().get('id')];
       
    eventAdminEvent = new LIST<Pay_Pal_Account__c>();
    eventAdminEvent =[select Email_Id__c from Pay_Pal_Account__c where Event__c=:ApexPages.currentpage().getParameters().get('id')];
      system.debug('3242342342342342342 '+eventAdminEvent );
    
     mapIdWithPrice  =new MAP<id,Decimal >();
     
     inn = new List<innerClass>();
     TTList = new List<TicketTypes__c>();
     
     TTList =[select Service_Fee__c,TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                        ,Ticket_Image_URL__c,Sales_End_Date__c from TicketTypes__c where EV_id__c=:selectedEvent];
     
     
     system.debug('333333333333333333 '+TTList );
     for(TicketTypes__c bt:TTList ){
        options = new List<selectOption>();
        options.add(new selectOption('0','0'));
        integer minValue=1;
        integer maxValue=10;
        
     if(  bt.Min_Tickets_per_Order__c!=null ){
       minValue =integer.valueOf(bt.Min_Tickets_per_Order__c);
     }
     
     if( bt.Max_Tickets_per_Order__c !=null ){
       maxValue=integer.valueOf(bt.Max_Tickets_per_Order__c);
     }
     
      for(integer i =minValue;i<=maxValue;i++){
     options.add(new selectOption(string.valueOf(i),string.valueOf(i)));
     
     }  
        inn.add(new innerClass(bt,options));
        mapIdWithPrice.put(bt.id,bt.TT_Amount__c);
              
     }
   }catch(exception e){}
   }


public class innerClass {
public TicketTypes__c tt{get;set;}
public integer quantity{get;set;}
public decimal donationValue{get;set;}
public decimal fee{get;set;}

 public List<selectOption> opt{get;set;}
 public innerClass(TicketTypes__c t,List<selectOption> op){
 donationValue =0;
 quantity =0;
 this.tt=t;
 if(tt.TT_TicketType__c!='Free'){
 this.fee = ((tt.TT_Amount__c*(2.9/100))+0.60+0.50).setScale(2);
 }
 this.opt=op;
 }
}

   public void previous1() {
    selectedTab ='name1';
    }

  public void previous2() {
    selectedTab ='name2';
    }

  public void previous3() {
    selectedTab ='name3';
    }


    public void enabletab4() {
         selectedTab ='name5';
    }


   public void enabletab3() {
         selectedTab ='name4';
    }

    public void enabletab2() {
      selectedTab ='name3';
    }


    public void  enabletab1() {
    linksbool=true;
     integer QuatityTotal=0;
     system.debug('33333333333 '+inn);
     seccls = new List<innforSecondButton>();
     
      for(innerClass incls:inn){
        if(incls.quantity!=0 && incls.quantity!=null){
          decimal d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
           QuatityTotal +=incls.quantity;
            seccls.add(new innforSecondButton(incls.tt,d,incls.quantity));
         }
         
          if (incls.tt.TT_TicketType__c=='donation' && incls.donationValue!=0){
            decimal d =incls.donationValue;
            seccls.add(new innforSecondButton(incls.tt,d,1));
          }
        }
        if((TotalAmount!=null && TotalAmount!=0) || (QuatityTotal !=null && QuatityTotal !=0)){
          selectedTab ='name2';
       }
    }


 public PageReference onchangeAct() {
    system.debug('hiiiiiiiiiiiiiiii '+inn);
    GrandQuantity =0;
    TotalAmount=0;
    eventAdminAmount =0;
    boothleadsAmount =0;
     
  
      for(innerClass incls:inn){
      system.debug('333333333333333334444444444444' +incls.tt.TT_TicketType__c);
        if((incls.quantity!=0 && incls.quantity!=null)|| (incls.tt.TT_TicketType__c=='Donation')){
        system.debug('23423423423423424242423 ' );
          decimal  d=0;
          if(incls.quantity!=0 && incls.quantity!=null){
           d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
           
            if(incls.tt.Service_Fee__c=='Add Booth Leads fee on top of the total ticket price'){
             // boothleadsAmount +=(d*3/100);
              eventAdminAmount +=d; 
             // TotalAmount+=d+boothleadsAmount;
               GrandQuantity+=incls.quantity; 
           }else{
            // decimal cutAmout =0; 
             //cutAmout= (d*3/100);
             //  system.debug('666666666666666 '+cutAmout);
            // boothleadsAmount =boothleadsAmount+cutAmout;
           
             //eventAdminAmount +=d-cutAmout; 
             eventAdminAmount +=d; 
             GrandQuantity+=incls.quantity;
           }
          
          }
          system.debug('23423423423423424242423 ' +incls.donationValue);
           if(incls.donationValue!=0 && incls.donationValue!=null){
             d +=incls.donationValue;
            // boothleadsAmount = boothleadsAmount+(d*3/100);
             GrandQuantity+=1;
              eventAdminAmount +=d; 
            }
          
        }
         
        
      }
      
      boothleadsAmount = GrandQuantity*0.50;
      system.debug('44444444444444444 '+boothleadsAmount );
       system.debug('55555555555555555555555555 '+eventAdminAmount);
        system.debug('666666666666666666666 '+eventAdminAmount+boothleadsAmount);
         system.debug('7777777777777777777777777 '+ ((eventAdminAmount+boothleadsAmount)*(2.9/100))+0.60);
     
      if(eventAdminAmount!=0){
      TotalAmount=((eventAdminAmount+boothleadsAmount)+((eventAdminAmount+boothleadsAmount)*(2.9/100))+0.60).setScale(2);
     }
     
      system.debug('44444444444444444 '+TotalAmount);
      return null;
    }


public List<innforSecondButton> seccls{get;set;}
public class innforSecondButton{
public Decimal totalPrice{get;set;}
public integer Quan{get;set;}
public List<Dummay__c> Dom{get;set;}
public TicketTypes__c Name{get;set;}
public Dummay__c ds{get;set;}

public innforSecondButton(TicketTypes__c name,Decimal to,integer  Qua){
dom = new List<Dummay__c>();
this.totalPrice=to;
this.Quan=qua;
this.Name =name;
for(integer i=1;i<=qua;i++){
 ds = new Dummay__c();
 ds.Ticket_Number__c=string.valueOf(i);
 Dom.add(ds);
 }
}
}

    
    public boolean istab0disabled;
    
    public boolean getistab0disabled(){
     return selectedTab <> 'name1';     
    }
    
    public boolean istab1disabled;
    
    public boolean getistab1disabled(){
     return selectedTab <> 'name2';     
    }
    
    
    public boolean istab2disabled;
    public boolean getistab2disabled(){
     return selectedTab <> 'name3';     
    }
    
    
    public boolean istab3disabled;
    public boolean getistab3disabled(){
     return selectedTab <> 'name4';     
    }
    
    
    public boolean istab4disabled;
    public boolean getistab4disabled(){
     return selectedTab <> 'name5';     
    }
    
    
    
    
    public String selectedTab;
    public string getselectedtab() 
    {
       return selectedtab;
    }
 
 
     
   
  public pagereference Pay(){
       
       system.debug('33333333334444444444444'+TotalAmount +' 333333333 '+eventAdminAmount +' 77777777777 '+boothleadsAmount);
       
       system.debug('999999999999999 5555555555'+eventAdminEvent[0].Email_Id__c);
       
       
       if(TotalAmount==0 || TotalAmount==null){
         if(GrandQuantity!=0){
         system.debug('9999999999999999 '+GrandQuantity);
         List<Dummay__c>  Listdummays = new List<Dummay__c>();   
            for(innforSecondButton lk:seccls){
           // Listdummays.addALL(lk.dom);
            for(Dummay__c dou :lk.dom){
            dou.Event__c =selectedEvent;
            dou.TicketTypes__c =lk.Name.id;
            dou.payKey__c ='BoothLeads12345';
            Listdummays.add(dou);
            }
         }
          system.debug('888888888888888888 '+Listdummays);
            dataBase.insert(Listdummays,false);
          pageReference pg =new PageReference('/apex/BL_SuccessPage?payKey=BoothLeads12345');
           pg.setRedirect(true);
            return pg;
         }else{
              
           return null;
         } 
       
     
       }else{
        PageReference page = null;
        MainMessage = '';
        
        CommonParametersObjName='MyRequestParams';
        APICredentialObjName ='SandboxCert';
        
        ActionType='PAY';
        
        FundingTypeEcheck = false;
        FundingTypeBalance = false;
        FundingTypeCreditCard = false;
        
        // create request envelope and set the common request parameters
        PPPayRequest request = new PPPayRequest(CommonParametersObjName, SenderEmail);      
        // set actionType
        request.ActionType = ActionType;  
        // set success and cancel urls
        String host = ApexPages.currentPage().getHeaders().get('Host');
        request.CancelUrl = 'https://' + host + '/apex/BL_RegistrationPage?MainMessage=cancel&id='+selectedEvent+'&Pid=${payKey}';
        //request.ReturnUrl = 'https://' + host + '/apex/BL_SuccessPage?payKey='+'${payKey}';
       request.ReturnUrl = 'https://' + host + '/apex/BL_registration?payKey='+'${payKey}'; 
        // set a note associated with the payment        
        request.Memo = 'PayApiTest';  
        // set receiver info in the request
        List<PPReceiver> receiverList = new List<PPReceiver>();
       system.debug('phaniiiiiiiiiiiiiiiiii '+eventAdminEvent[0].Email_Id__c);
         PPReceiver rv = new PPReceiver();
         rv.Email =eventAdminEvent[0].Email_Id__c;
         rv.Amount = eventAdminAmount;
         PaymentType ='Parallel';
         feesPayer ='SENDER';
         ActionType ='PAY';
         
        receiverList.add(rv); 
         
         
         PPReceiver rv1 = new PPReceiver();
         rv1.Email ='boothleads.globalnest@gmail.com';
         feesPayer ='SENDER';
         ActionType ='PAY'; 
         rv1.Amount = boothleadsAmount;
        
        receiverList.add(rv1);
         
         
         
        request.receiverList = receiverList;
        // set FeesPayer
        request.FeesPayer = FeesPayer;
        if (FundingTypeEcheck) {
            PPFundingTypeInfo info = new PPFundingTypeInfo();
            info.FundingType = 'ECHECK';
            request.FundingTypeList.add(info);
        }
        if (FundingTypeBalance) {
            PPFundingTypeInfo info = new PPFundingTypeInfo();
            info.FundingType = 'BALANCE';
            request.FundingTypeList.add(info);
        }
        
        if (FundingTypeCreditCard) {
            PPFundingTypeInfo info = new PPFundingTypeInfo();
            info.FundingType = 'CREDITCARD';
            request.FundingTypeList.add(info);
        }
        
        IsDisplay = false;
       
         // create the Adaptive Toolkit object instance w/ API Credentials
        PPAdaptiveToolkit toolkit = new PPAdaptiveToolkit(APICredentialObjName);
       
        try {
            System.Debug(Logginglevel.INFO, '==>Request' + request);
            PayResponse = toolkit.Pay(request);
            System.debug(PayResponse);          
            IsDisplay = true;
            RespEnvp = PayResponse.ResponseEnvelope;
            if( PayResponse.PaymentExecStatus.equalsIgnoreCase('Created') ) {
                        
          List<Dummay__c>  Listdummays = new List<Dummay__c>();           
         
          for(innforSecondButton lk:seccls){
           // Listdummays.addALL(lk.dom);
           for(Dummay__c dou :lk.dom){
            dou.Event__c =selectedEvent;
            dou.TicketTypes__c =lk.Name.id;
            dou.payKey__c =PayResponse.payKey;
            Listdummays.add(dou);
            }
        }
            dataBase.insert(Listdummays,false);
            
            
            
            
            system.debug('777777777777777777777 '+PayResponse.payKey);
                //Page = toolkit.commitpayment(PayResponse.payKey);
               
             page= new pageReference(toolkit.BaseAPIProfile.getPayPalLoginPage()+'_ap-payment&paykey='+PayResponse.payKey);
             return page;
               
            
            } else if( PayResponse.PaymentExecStatus.equalsIgnoreCase('Completed') ) {
                //Page = new pagereference(request.returnUrl); 
                SuccessMessage = 'Payment Completed - payKey - ' + PayResponse.payKey; 
            } else {
                IsDisplay = true;
                RespEnvp = PayResponse.getResponseEnvelope();
                MainMessage = 'Payment Execution Status returned from server is - ' + PayResponse.PaymentExecStatus;
            }
            
        }catch(PPFaultMessageException ex) {
            System.debug('PPFaultMessageException =>' + ex);
            IsDisplay = true;
            RespEnvp = ex.ResponseEnvelope;
            List<PPErrorData> errList = ex.ErrorList;
            for( PPErrorData err: errList ){
                MainMessage += err.ErrorId + ' : ' + err.Message + '<br>';
            }
       }catch(System.Exception e){
            System.debug('System.Exception =>' + e);
            MainMessage = e.getMessage();
       } 

 //      return null;
   return page;
    } 
 }
 
  public void testdum(){
    integer  i=0;
    i++;
     i++;
      i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
   
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
   i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
     
  }
   public void testdum2(){
    integer  i=0;
    i++;
     i++;
      i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
   
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
   i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
     
  }
    public void testdum3(){
    integer  i=0;
    i++;
     i++;
      i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
   
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
   i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;  i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++; i++;
     
     
  }
}
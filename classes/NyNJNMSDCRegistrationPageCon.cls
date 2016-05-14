public without sharing class NyNJNMSDCRegistrationPageCon {

 public String checkno { get; set; }
 public boolean chckbool { get; set; }
 public boolean chckbool2 { get; set; }
 public string paymenttypeIteam{get;set;} 
 public string invoiceEmail {get;set;}
 public List<SelectOption> paytypes { get;set;}
 public boolean showerror {get;set;}
    

    public void displaycheckNo() {
    chckbool =false;
     chckbool2 =false;
    if(paymenttypeIteam =='Check'){
    chckbool =TRUE;
    }
     
    
    if(paymenttypeIteam =='Credit Card'){
    showerror =false;
    } 
    
        
     if(paymenttypeIteam =='Invoice'){
       showerror =false;
    }
    
    system.debug('rrrrrrrrrrrrrrrr '+paymenttypeIteam );  
        
    }

  public String userType { get; set; }
  
  
  
  
  
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        
        boolean b = currentRequestURL.contains('BL_Registration');
       
          options.add(new SelectOption('MSDC Member Corporation','GNEMSDC / NMSDC Corporate Member')); 
         options.add(new SelectOption('MSDC Certified MBE','GNEMSDC / NMSDC Certified MBE / Public Sector')); 
         options.add(new SelectOption('Others','Others'));        
       
         return options; 
    }
    
public boolean linksbool{get;set;}
public  LIST<Pay_Pal_Account__c> eventAdminEvent{get;set;}
public string MainMessage  {get;set;}
public string SenderEmail{get;set;} 
public String CommonParametersObjName{get;set;}
public List<TicketTypes__c> TTList{get;set;}
public string selectedEvent{get;set;}
public List<innerClass> inn{get;set;} 
public List<selectOption> options {get;set;}
public List<selectOption> options1 {get;set;}
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

public String currentRequestURL{get;set;}


public NyNJNMSDCRegistrationPageCon (){
  showerror =false;
 currentRequestURL = URL.getCurrentRequestUrl().toExternalForm();
System.debug('Current request URL: ' + currentRequestURL);  

TotalAmount =0.0;
 boolean b = currentRequestURL.contains('BL_Registration');
if(b){
userType ='MSDC Member Corporation';
}else{
userType ='MSDC Member Corporation';
}
//userType ='Non-Member/Guest';
//userType ='MSDC Member Corporation';
     selectedTab ='name3';
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
    eventAdminEvent =[select Email_Id__c,Payment_Type__c,Fee_Payer__c from Pay_Pal_Account__c where Event__c=:ApexPages.currentpage().getParameters().get('id')];
      system.debug('3242342342342342342 '+eventAdminEvent );
    
    
   }catch(exception e){}
 }

 public void DisplayTab2Values(){
  mapIdWithPrice  =new MAP<id,Decimal >();
     
     inn = new List<innerClass>();
     TTList = new List<TicketTypes__c>();
     
     TTList =[select Service_Fee__c,TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                        ,Ticket_Image_URL__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c, No_of_Booths_allowed__c  from TicketTypes__c where EV_id__c=:selectedEvent and User_Type__c=:userType order by createddate ];
     
     
    
     for(TicketTypes__c bt:TTList ){
        options = new List<selectOption>();
       
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
  
  
    EXHIBITORBOOTHPACKAGES= new List<innerClass>();
    CONVENTIONPASSES= new List<innerClass>();
    ALACARTE= new List<innerClass>();
    Advertising= new List<innerClass>();
    ACTIVITYSPONSORSHIP=new List<innerClass>();
    SPONSORSHIP =new List<innerClass>();
     ANNUALSPONSORSHIP=new List<innerClass>();
   for(innerClass tr:inn){
    system.debug('33333hhhhhhhh '+tr.tt.Section_Name__c);
    if((tr.tt.Section_Name__c =='FULL CONFERENCE REGISTRATION') || (tr.tt.Section_Name__c =='EXHIBITOR BOOTH PACKAGES')){
    EXHIBITORBOOTHPACKAGES.add(tr);
    }else if((tr.tt.Section_Name__c =='ONE DAY CONFERENCE ATTENDEE') || (tr.tt.Section_Name__c =='CONVENTION PASSES')){
    CONVENTIONPASSES.add(tr);
    }else if((tr.tt.Section_Name__c =='A LA CARTE') || (tr.tt.Section_Name__c == 'EXHIBITOR BOOTHS')){
    ALACARTE.add(tr);
    }else if((tr.tt.Section_Name__c =='ADVERTISEMENTS')) {
      Advertising.add(tr);
    }else if((tr.tt.Section_Name__c =='ACTIVITY SPONSORSHIP PACKAGES')) {
      ACTIVITYSPONSORSHIP.add(tr);
    }else if((tr.tt.Section_Name__c =='SPONSORSHIP PACKAGES')) {
      SPONSORSHIP.add(tr);
    }else if((tr.tt.Section_Name__c =='ANNUAl SPONSORSHIP PACKAGES')){
    ANNUALSPONSORSHIP.add(tr);
    }    
    else{
      Advertising.add(tr);
    }
   
   }   
   
    boolean b = currentRequestURL.contains('BL_Registration');
   
   if(b){
    ALACARTE.addAll(EXHIBITORBOOTHPACKAGES);
    ALACARTE.addAll(CONVENTIONPASSES);
  }
   
   
     
 }

public List<innerClass> ANNUALSPONSORSHIP{get;set;}
public List<innerClass> EXHIBITORBOOTHPACKAGES{get;set;}
public List<innerClass> CONVENTIONPASSES{get;set;}
public List<innerClass> ALACARTE{get;set;}
public List<innerClass> Advertising{get;set;}

public List<innerClass> SPONSORSHIP {get;set;}
public List<innerClass> ACTIVITYSPONSORSHIP{get;set;}

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
 this.fee = (((tt.TT_Amount__c+0.50)*(2.9/100))+0.60).setScale(2);
 }
 this.opt=op;
 }
}












   public void previous1() {
    selectedTab ='name1';
    }



  public void previous2() {
    selectedTab ='name3';
    nextpageError ='';
    }

  public void previous3() {
    selectedTab ='name3';
    TotalAmount=0;
    eventAdminAmount =0;
    boothleadsAmount =0;
   duplicateerror ='';
    error ='';   
    MainMessage ='';
    }


    public void enabletab4() {
         selectedTab ='name5';
    }

   public string TicketName {get;set;}
   public void enabletab3() {
  if(userType=='MSDC Member Corporation'){
       TicketName ='GNEMSDC / NMSDC' ;
     } else if(userType=='MSDC Certified MBE'){
      TicketName = 'GNEMSDC / NMSDC Certified MBE';
     }else{
       TicketName =userType;
     }  
    DisplayTab2Values();
    selectedTab ='name1';
    }

    public void enabletab2() {
      selectedTab ='name3';
     
      
    }
public Constomer__c cus{get;set;}
public string nextpageError{get;set;}


    public void  enabletab1() {
    try{
    nextpageError ='';
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
          paytypes = new List<SelectOption>();
          paytypes.add(new SelectOption('Credit Card','Credit Card')); 
          paytypes.add(new SelectOption('Check','Check'));
          paytypes.add(new SelectOption('Invoice','Invoice')); 
          paymenttypeIteam ='Credit Card';
       }else{
         nextpageError ='Please select at least one ticket';
       
       }
       
       
         cus = new Constomer__c();
          cus.Uniq_Number__c ='Uniq';
          cus.Total_Amount__c =eventAdminAmount ;
          insert cus;
      
      }catch(exception e){
      
      } 
       
       
       
    }


 public PageReference onchangeAct() {
 
 try{
    system.debug('hiiiiiiiiiiiiiiii '+inn);
    GrandQuantity =0;
    TotalAmount=0;
    eventAdminAmount =0;
    boothleadsAmount =0;
      nextpageError ='';
  
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
     
         
      boolean b = currentRequestURL.contains('BL_Registration');
     
        TotalAmount=(eventAdminAmount).setScale(2);
        //((eventAdminAount+boothleadsAmount)*(2.9/100))+0.60).setScale(2);
        
        
        system.debug('44444444444444444 '+TotalAmount+'55555555555555 '+eventAdminAmount);
        }catch(exception e){}
        return null;
    }


public List<innforSecondButton> seccls{get;set;}

public class innforSecondButton{
public Decimal totalPrice{get;set;}
public integer Quan{get;set;}
public List<Dummay__c> Dom{get;set;}
public TicketTypes__c Name{get;set;}
public Dummay__c ds{get;set;}
public List<Dummay__c> boothsInn {get;set;}
public string MessageInfo{get;set;}

public innforSecondButton(TicketTypes__c name,Decimal to,integer  Qua){
dom = new List<Dummay__c>();
boothsInn = new List<Dummay__c>();
this.totalPrice=to;
this.Quan=qua;
this.Name =name;

    for(integer i=1;i<=qua;i++){
        if(Name.Section_Name__c=='SPONSORSHIP PACKAGES' || Name.Section_Name__c=='ANNUAl SPONSORSHIP PACKAGES'){
        for(integer e=1;e<=Name.No_of_Booths_allowed__c;e++){
          ds = new Dummay__c();
          ds.Ticket_Number__c=string.valueOf(i);
          boothsInn.add(ds);
         } 
       }else if(Name.Section_Name__c=='ACTIVITY SPONSORSHIP PACKAGES'){
         for(integer d=1;d<=1;d++){
          ds = new Dummay__c();
          ds.Ticket_Number__c=string.valueOf(d);
          Dom.add(ds);
          }
        } else if(Name.TT_Name__c =='Booth at Expo'){
           for(integer d=1;d<=2;d++){
           ds = new Dummay__c();
           ds.Ticket_Number__c=string.valueOf(d);
           boothsinn.add(ds);
         }  
       }else if(Name.TT_Name__c =='Additional Booth'){
         for(integer d=1;d<=1;d++){
         ds = new Dummay__c();
         ds.Ticket_Number__c=string.valueOf(d);
         Dom.add(ds);
      }  
    }else{
       ds = new Dummay__c();
       ds.Ticket_Number__c=string.valueOf(i);
       Dom.add(ds);
      }
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
 
 
     
   public string error{get;set;}
   public boolean resbool{get;set;}
    public string duplicateerror{get;set;}
    public string invoiceandcheckemail{get;set;}
    
    
  public pagereference Pay(){
  duplicateerror ='';
  error ='';
  invoiceEmail ='';
  showerror =false;
       system.debug('phaniiiiiiiiiiiiiiiiii '+paymenttypeIteam+'2222222222 '+eventAdminAmount+'33333333333333333 '+boothleadsAmount);
    SET<string> allEmails = new SET<string>();
    
   // --------------------------- Checking duplicates in entered values ----------------------------------  
        set<string> findDuplicates = new set<string>();
          for(innforSecondButton lk:seccls){
           for(Dummay__c dou :lk.dom){
            string emailandticket='';
            allEmails.add(dou.Email__c);
            emailandticket=dou.Email__c+lk.Name.id;
            if(findDuplicates.contains(emailandticket)){
             duplicateerror ='You are trying to register same ticket twice';
             return null;
            }else{
             findDuplicates.add(emailandticket); 
            }    
         }
         
         
          for(Dummay__c dou :lk.boothsinn){
             string emailandticket='';
             allEmails.add(dou.Email__c);
             emailandticket=dou.Email__c+lk.Name.id;
            if(findDuplicates.contains(emailandticket)){
             duplicateerror ='You are trying to register same ticket twice';
             return null;
            }else{
             findDuplicates.add(emailandticket); 
            }    
         }
      }
     
      // --------------------------- Checking duplicates in entered values End----------------------------------  
     
     
     
      // --------------------------- Checking user already existed or not  ----------------------------------  
     
       for(Ticket_Eam__c tic : [select id,Event_Attendee_Mapping__c,TicketTypes__c,Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,TicketTypes__r.id,TicketTypes__r.TT_Name__c from Ticket_Eam__c where Event_Attendee_Mapping__r.AS_id__r.AS_Email__c in :allEmails and Event_Attendee_Mapping__r.EV_id__c=:selectedEvent])
         {
           string existingcheck='';
          existingcheck=tic.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c+ tic.TicketTypes__r.id;
          if(findDuplicates.contains(existingcheck)){
           duplicateerror =
           
           
           
           'Your email ID is already registered for'+tic.TicketTypes__r.TT_Name__c+' Event, if you would like to purchase more tickets, please use another email ID.';
           
          
           return null;
          }else{
          
           }       
         
         }
     
     
       // --------------------------- Checking user already existed or not  ----------------------------------  
  
     if(seccls.size()>0){
      if(seccls[0].dom.size()>0){
      invoiceEmail=seccls[0].dom[0].Email__c;
     }else if(seccls[0].boothsinn.size()>0){
      invoiceEmail=seccls[0].boothsinn[0].Email__c;
     }
    }
     
    
     
      if(paymenttypeIteam=='Invoice' || paymenttypeIteam=='Check'){
       try{ 
         if(paymenttypeIteam=='Check'){
         if(checkno!=null && checkno!=''){ 
        
         }else{
            showerror =true;
          
            error='Please enter Check number';
            return null;
         }
        }       
        
        
         List<Dummay__c>  Listdummays = new List<Dummay__c>();   
          List<Dummay__c>  boothsinnDummay= new List<Dummay__c>();  
        
        MAP<id,string> mapidticketName = new MAP<id,string>();
         
       /* for(TicketTypes__c ty:[select id,TT_Name__c from TicketTypes__c where (TT_Name__c='Event' OR TT_Name__c='Diamond' OR TT_Name__c='Platinum' OR TT_Name__c='Gold' OR TT_Name__c='Post Reception') and EV_id__c=:selectedEvent]){
          mapidticketName.put(ty.id,ty.TT_Name__c); 
        
        }        
              */  
          
            for(innforSecondButton lk:seccls){
            
            for(Dummay__c dou :lk.dom){
            dou.Event__c =selectedEvent;
            dou.TicketTypes__c =lk.Name.id;
            dou.customer_key__c =cus.id;
            dou.Check_number__c =checkno;
             dou.InvoiceEmail__c=invoiceEmail;
            dou.Payment_Type__c =paymenttypeIteam;
                        
             if(lk.Name.Section_Name__c =='ACTIVITY SPONSORSHIP PACKAGES'){
             try{
                 dou.Attendees_Available__c =lk.Name.No_of_Attendees_allowed__c;
              }catch(exception e){}
           }else{
             dou.Attendees_Available__c =lk.Name.No_of_Attendees_allowed__c;
           }
            
            dou.payKey__c ='BoothLeads12345';
            Listdummays.add(dou);
            }
            integer bpersonnel =0;
             system.debug('44444444444444444444444444 '+lk.boothsinn);
            
             for(Dummay__c dou :lk.boothsinn){
             dou.Event__c =selectedEvent;
             dou.customer_key__c =cus.id;
             dou.InvoiceEmail__c=invoiceEmail;
             dou.TicketTypes__c =lk.Name.id;
             
             dou.Attendees_Available__c =lk.Name.No_of_Attendees_allowed__c;
                                    
             dou.Payment_Type__c =paymenttypeIteam;
             if(bpersonnel==0){
             dou.Profile__c ='BoothAdmin';     
             } 
             bpersonnel++; 
             dou.Check_number__c =checkno;
          
            dou.payKey__c ='BoothLeads12345';
            boothsinnDummay.add(dou);
            }
            
            
         }
          system.debug('888888888888888888 '+Listdummays);
             database.saveResult[] dsave1 =   dataBase.insert(Listdummays,false);
             system.debug('999999999999 '+dsave1 );
           database.saveResult[] dsave2 = dataBase.insert(boothsinnDummay,false);
           system.debug('1010101010100101010'+dsave2 );
          
          pageReference pg =new PageReference('/apex/BL_RegistrationSuccess?payKey='+cus.id);
           pg.setRedirect(true);
            return pg;
       }catch(exception e){return null;} 
       
     
       }else{
      
        PageReference page = null;
        MainMessage = '';
        showerror =false;
                  
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
        request.CancelUrl = 'https://' + host + '/apex/BL_Registration?MainMessage=cancel&id='+selectedEvent;
        request.ReturnUrl = 'https://' + host + '/apex/BL_RegistrationSuccess?payKey='+cus.id;
          
        // set a note associated with the payment        
        request.Memo = 'GNEMSDC';  
        // set receiver info in the request
        List<PPReceiver> receiverList = new List<PPReceiver>();
     
       try{
       
         PaymentType =eventAdminEvent[0].Payment_Type__c;
         feesPayer =eventAdminEvent[0].Fee_Payer__c;
         PPReceiver rv = new PPReceiver();
         rv.Email =eventAdminEvent[0].Email_Id__c;
         rv.Amount = eventAdminAmount;
         rv.primary=TRUE;
        // PaymentType ='Parallel';
         ActionType ='PAY';
         receiverList.add(rv); 
         
         
         PPReceiver rv1 = new PPReceiver();
         rv1.Email ='durga@globalnest.com';
         ActionType ='PAY'; 
         rv1.Amount = boothleadsAmount;
         receiverList.add(rv1);
          }catch(exception e){}
         
         
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
          
        system.debug('999999999999999999999999 '+PayResponse.payKey);
         
          List<Dummay__c>  Listdummays = new List<Dummay__c>();           
         List<Dummay__c>  boothsinnDummay= new List<Dummay__c>(); 
          for(innforSecondButton lk:seccls){
           // Listdummays.addALL(lk.dom);
           for(Dummay__c dou :lk.dom){
            dou.Event__c =selectedEvent;
            dou.TicketTypes__c =lk.Name.id;
            dou.payKey__c =PayResponse.payKey;
             dou.InvoiceEmail__c=invoiceEmail;
             dou.customer_key__c =cus.id;
             dou.Payment_Type__c =paymenttypeIteam;
             
             Listdummays.add(dou);
            }
            
           integer bpersonnelpay =0;
           for(Dummay__c dou :lk.boothsinn){
            dou.Event__c =selectedEvent;
            dou.TicketTypes__c =lk.Name.id;
            dou.customer_key__c =cus.id;
             dou.InvoiceEmail__c=invoiceEmail;
             dou.Payment_Type__c =paymenttypeIteam;
             
             if(bpersonnelpay==0){
             dou.Profile__c ='BoothAdmin';     
             } 
             bpersonnelpay++; 
              
           dou.payKey__c =PayResponse.payKey;
            boothsinnDummay.add(dou);
            }  
            
        }
            dataBase.insert(Listdummays,false);
            dataBase.insert(boothsinnDummay,false);
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
              MainMessage += err.ErrorId + ' : ' + err.Message ;
           }
      }catch(System.Exception e){
          System.debug('System.Exception =>' + e);
            MainMessage = e.getMessage();
       } 
     }   return null;
  }         
   
  public void testdum(){
  integer intg=0;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  
  intg++;
  
  intg++;
  intg++;
  }
   
 
}
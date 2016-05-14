public without sharing class BL_TicketTypesCon {

public TicketTypes__c TicketTypes{get;set;}
public List<selectOption> SelectedTicketTypes{get;set;}
public String ServiceFee{get;set;}
public string OtherValue{get;set;}
public Boolean Showwhenselected{get;set;}
public String OtherCategoryValue{get;set;}
public Boolean ShowselectedCatgory{get;set;}
public List<TicketTypes__c> ListOfTicketTypes{get;set;}
public String TicketTypeID{get;set;}
public Boolean ShowTicketTypes{get;set;}
public Boolean ShowDetailsTicketTypes{get;set;}
public Boolean AddTicketTypes{get;set;}
Public transient Blob TicketImage{get; set;}
public String TicketFileName{get;set;}
public Document TicketDocument{get;set;}
Public String SelectedEvent {get;set;}
public List<Event__c> Event{get;set;}
public Boolean noTicketTypeBool{get;set;}
public String PopUpName{get;set;}
public Boolean ShowTicketTypesdiv{get;set;}
public boolean ShowPaymentsdiv{get;set;}
public Pay_Pal_Account__c PayPalAccount{get;set;}
public Boolean ProvideEmail{get;set;}
public List<Pay_Pal_Account__c> paypalAcc {get;set;}
public Boolean RProvideEmail{get;set;}
public Boolean ticketBool{get;set;}
public Boolean paymentBool{get;set;}
public Boolean successPopup{get;set;}
public Boolean ProvideEmailId{get;set;}
public Boolean PayementSettings{get;set;}
public Boolean listTickets{get;set;}
public Boolean RemoveAddTicket{get;set;}
public List<SelectOption> SelectedAccountTypes{get;set;}
public string Accountype{get;set;}
public Boolean PayPalAccountre{get;set;}
public Boolean DotNetre{get;set;}


    
    public BL_TicketTypesCon (){
   
    TicketTypes = new TicketTypes__c();
    PayPalAccount = new Pay_Pal_Account__c(); 
    
    TicketTypes.TT_Amount__c = null;
    ShowPaymentsdiv = True;
    SelectedEvent = ApexPages.currentpage().getParameters().get('event');
    Event = [select id,Ev_Title__c from Event__c where id=:SelectedEvent ];     
    ticketBool = False;
    paymentBool = True;
    ProvideEmailId = False;
    getListOfTickectNames();
    ShowMEthod();
    Accountype = '';
    PayPalAccount.Account_types__c = 'PayPal Account';
    PayPalAccountre = True;
    TocheckPaypalAccount();
    
    }
    
    public List<TicketTypes__c> getListOfTickectNames(){
    
    ListOfTicketTypes = new List<TicketTypes__c>();
    ListOfTicketTypes = [select id,TT_Name__c,TT_Available__c,TT_Amount__c,TT_TicketType__c,Start_Time__c,End_Time__c,Ticket_Category__c,TT_Limit__c,TT_Sold__c,  
                         Avilable_for_Portal__c,Available__c,Ticket_Image_URL__c  from TicketTypes__c where EV_id__c =: SelectedEvent]; 
    
    if(ListOfTicketTypes.size()>0)
      {
      
      noTicketTypeBool=False;
      ShowTicketTypes= True;
      
      } else {
      noTicketTypeBool=true;
      ShowTicketTypes= false;
      }
    return ListOfTicketTypes ;                    
    }
    public List<SelectOption> getTicketTypeValues(){
    SelectedTicketTypes = new List<SelectOption>();
        
   Schema.DescribeFieldResult fieldResult = TicketTypes__c.TT_TicketType__c.getDescribe();
   List<Schema.PicklistEntry> PickListValues = fieldResult.getPicklistValues();
   for( Schema.PicklistEntry f : PickListValues){
      SelectedTicketTypes.add(new SelectOption(f.getLabel(), f.getValue()));
      
   } 
  // SelectedTicketTypes.add(new SelectOption('Other', 'Other'));      
   return SelectedTicketTypes;
}
    public List<SelectOption> getTicketcategoryValues(){
    List<SelectOption> Options = new List<SelectOption>();
        
   Schema.DescribeFieldResult fieldResult = TicketTypes__c.Ticket_Category__c.getDescribe();
   List<Schema.PicklistEntry> PickListValues = fieldResult.getPicklistValues();
   for( Schema.PicklistEntry f : PickListValues){
      Options.add(new SelectOption(f.getLabel(), f.getValue()));
   }
  // Options.add(new SelectOption('Other', 'Other'));             
   return Options ;
}
    public List<SelectOption> getTicketServiceFee(){
    List<SelectOption> Options = new List<SelectOption>();
        
   Schema.DescribeFieldResult fieldResult = TicketTypes__c.Service_Fee__c.getDescribe();
   List<Schema.PicklistEntry> PickListValues = fieldResult.getPicklistValues();
   for( Schema.PicklistEntry f : PickListValues){
      Options.add(new SelectOption(f.getLabel(), f.getValue()));
   }
   return Options ;
}   

    public List<SelectOption> getAccountTypeValues(){
    SelectedAccountTypes = new List<SelectOption>();
        
   Schema.DescribeFieldResult fieldResult = Pay_Pal_Account__c.Account_types__c.getDescribe();
   List<Schema.PicklistEntry> PickListValues = fieldResult.getPicklistValues();
   for( Schema.PicklistEntry f : PickListValues){
   SelectedAccountTypes.add(new SelectOption(f.getLabel(), f.getValue()));
      
   } 
   system.debug('%%%%%%%% %%%%%%%%%%%%%%%%'+SelectedAccountTypes);
  // SelectedTicketTypes.add(new SelectOption('Other', 'Other'));      
   return SelectedAccountTypes;
} 

    public void ForSelectedTicketTypes(){
    
    system.debug(' FFFFFFFFFFFFF FFFFFFFFFFFFF '+TicketTypes.TT_TicketType__c);
    if(TicketTypes.TT_TicketType__c == 'Free' || TicketTypes.TT_TicketType__c == 'Donation'){
    Showwhenselected = False;
    }else{
    Showwhenselected = True;
    TicketTypes.TT_Amount__c = null ;
    }
    }
    
    
    public void DeleteTicket(){
    
    system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypeID );
    TicketTypes__c DeleteId = [select id from TicketTypes__c  where id=:TicketTypeID ];
    delete DeleteId;
    getListOfTickectNames();
    
    }
    
    public void EditTicket(){
     
     PopUpName = 'Edit Ticket';
     system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypeID );   
     TicketTypes = [select id,TT_Name__c,TT_Available__c,TT_Amount__c,Sales_Start_Date__c,  
                    Sales_End_Date__c,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c,Start_Time__c,End_Time__c, 
                    Description__c,Avilable_for_Portal__c,TT_TicketType__c,Ticket_Category__c,  
                    Service_Fee__c,Ticket_Image_URL__c  from TicketTypes__c where id=:TicketTypeID ];
     system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypes.Ticket_Category__c);               
     AddTicketTypes = True; 
      system.debug( ' HHHHHHGGGGGGGGGGHHHHHHHHHH '+TicketTypes.Ticket_Category__c); 
       
   /**  if(TicketTypes.TT_TicketType__c == 'Paid'){
     Showwhenselected = True;
     }else{
     Showwhenselected = False;
     } */
    }
    
    public void AddTicket(){
    TicketTypes = new TicketTypes__c ();
    PopUpName = 'Add Ticket';
    TicketTypes.TT_Amount__c = null; 
    TicketTypes.Avilable_for_Portal__c = True;
    system.debug('GGGGGGGGGGGGGGGGGG'+TicketTypes.TT_TicketType__c );
    //TicketTypes.TT_TicketType__c = 'none';     
    AddTicketTypes = True;
    Showwhenselected = True;
   
    }
    
    public void save(){
        
       if(TicketImage != null && ( TicketFileName != '' || TicketFileName != NULL )){
       system.debug( '1111111111111 '+TicketImage + ' 22222222222222222 '+TicketFileName+' 33333333333333'+ TicketImage);
           if(TicketImage.size()!= null){
            system.debug( '!!!!!!!!!!!'+TicketImage + ' @@@@@@@@@@@@'+TicketFileName+' ############'+ TicketImage);

               if(TicketImage.size() < 102400 ){
                system.debug( '%%%%%%%%%'+TicketImage + ' ^^^^^^^^^^'+TicketFileName+' &&&&&&&&&&&'+ TicketImage);
 
                TicketDocument = new document();
                TicketDocument.body = TicketImage;
                TicketDocument.folderid = '00lF0000001VI7Y';        
                TicketDocument.IsPublic = True;
                TicketDocument.Name = TicketFileName ;
                DataBase.saveResult docSaveResult = DataBase.insert(TicketDocument, false);
                String ToCheckOldImage;
                if(docSaveResult.isSuccess()){            
                if(TicketTypes.Ticket_Image_URL__c != null){
                    system.debug('33333333333333333333333    '+ TicketTypes.Ticket_Image_URL__c);
                    ToCheckOldImage = TicketTypes.Ticket_Image_URL__c;                  
                    Document ToDelete = [SELECT ID, NAME FROM document WHERE id=: ToCheckOldImage ];
                    Database.delete(ToDelete );
                 }                 
                 TicketTypes.Ticket_Image_URL__c = docSaveResult.getId();
                 system.debug(' DDDDDDDDDDDDDD DDDDDDDDDDDDD'+TicketTypes.Ticket_Image_URL__c);             
            }else{            
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
            }
                }
            }
        }    
        
        TicketTypes.EV_id__c = SelectedEvent ;        
       // if(TicketTypes.TT_Amount__c == null)
       // TicketTypes.TT_Amount__c = 0;
        TicketTypes.TT_Sold__c = 0;
        Database.upsert(TicketTypes); 
        getListOfTickectNames();
        system.debug( ' SSSSSSSSSSSSSSS '+TicketTypes);
        AddTicketTypes = False; 
        ShowTicketTypes = True; 
         noTicketTypeBool = True;      
    }
    
    public void cancel(){
        // getListOfTickectNames();
         AddTicketTypes = False;
         ShowDetailsTicketTypes = False;
          
         
    }
    
    public void TicketDetails(){
    EditTicket();
    ShowDetailsTicketTypes = True;
    AddticketTypes  = False;
    }
    
    public void TicketsDiv(){
        
        
       List<Pay_Pal_Account__c> paypalAcc = [select id,Email_Id__c from Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
        if(paypalAcc.size()>0){
        ShowTicketTypesdiv = True;
        ListTickets = True;
        PayementSettings= True;
        ShowPaymentsdiv = False;
        ticketBool = True; 
        paymentBool = False;
        RemoveAddTicket = True;
        }else {
        ProvideEmailId = True;
        paymentBool = True;
        ListTickets = False;
        PayementSettings= True;
        RemoveAddTicket = False;
        }
        
    }
    
    public void Paymentsdiv(){
    ticketBool = False;
    paymentBool = True;
    ShowPaymentsdiv = True; 
    ShowTicketTypesdiv = False;
    
    }
   
    public Void SavePaypal(){
    
    List<Pay_Pal_Account__c> paypalAccounts = [select Account_Types__c,AuthorizationDotNet__c,id,Email_Id__c,AuthorizationDotNetKey__c 
                                               from Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
    System.debug(' %%%%%%%%%% %%%%%%%%%%%%%'+paypalAccounts );                                           
    if(paypalAccounts.size()>0){
    if(paypalAccount.Email_id__c != null  && paypalAccount.Account_Types__c == 'PayPal Account'){
    paypalAccounts[0].Email_id__c = paypalAccount.Email_id__c;
    paypalAccounts[0].AuthorizationDotNet__c = '';
    paypalAccount.AuthorizationDotNet__c = '';
    paypalAccounts[0].AuthorizationDotNetKey__c = '';
    paypalAccount.AuthorizationDotNetKey__c = '';
    
    }
    if(paypalAccount.AuthorizationDotNet__c != null && paypalAccount.Account_Types__c == 'Authorize.Net'){
    paypalAccounts[0].AuthorizationDotNet__c = paypalAccount.AuthorizationDotNet__c;
    paypalAccounts[0].AuthorizationDotNetKey__c = paypalAccount.AuthorizationDotNetKey__c;
    paypalAccounts[0].Email_id__c = '';
    paypalAccount.Email_id__c = '';
    }
    paypalAccounts[0].Account_Types__c = paypalAccount.Account_Types__c;
    database.update(paypalAccounts);
    }
    else{
    
    PayPalAccount.Event__c = SelectedEvent;
    paypalAccount.Email_id__c = paypalAccount.Email_Id__c;
    paypalAccount.Account_Types__c = paypalAccount.Account_Types__c; 
    paypalAccount.AuthorizationDotNet__c = paypalAccount.AuthorizationDotNet__c;
    paypalAccount.AuthorizationdotNetKey__c = paypalAccount.AuthorizationdotNetKey__c;
    database.insert(PayPalAccount);
   
     //successPopup = True;
    
    }
    ShowMEthod();
    TocheckPaypalAccount();
    getListOfTickectNames();
    ProvideEmailId = False;
    }
    
    public void  TocheckPaypalAccount(){
 // try{
  //  PayPalAccount = new Pay_Pal_Account__c();   
    SelectedEvent = ApexPages.currentpage().getParameters().get('event');
    
    List<Pay_Pal_Account__c> paypalAccounts = [select AuthorizationdotNetKey__c,AuthorizationdotNet__c,id,Email_Id__c,Account_Types__c from 
                                               Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
                                               
    if(paypalAccounts .size()>0){
    system.debug('ffffffffffffffff');
    ProvideEmail = False;
    RProvideEmail = True;
    system.debug('******************* ************************'+paypalAccounts [0].Account_Types__c);
    paypalAccount.Account_Types__c = paypalAccounts [0].Account_Types__c;
    if(paypalAccounts [0].Email_Id__c != null && paypalAccounts [0].Account_Types__c == 'PayPal Account'){
    paypalAccount.Email_id__c = paypalAccounts [0].Email_Id__c;
    PayPalAccountre = True;
    DotNetre  = False;
    }if(paypalAccounts[0].AuthorizationdotNet__c != null && paypalAccounts [0].Account_Types__c == 'Authorize.Net'){
    paypalAccount.AuthorizationdotNet__c = paypalAccounts [0].AuthorizationdotNet__c;
    paypalAccount.AuthorizationDotNetKey__c = paypalAccounts [0].AuthorizationdotNetKey__c;
    DotNetre = True;
    PayPalAccountre = False;
    }
    system.debug('ffffffffffffffff');
    }else {
    ProvideEmail = True;
    RProvideEmail = False;
    
    }
 // }catch(Exception ex){
   
   //}
    
    }
    public void Cancelpopup(){
    TocheckPaypalAccount(); 
    ShowMEthod(); 
    }
    
    public void ShowMEthod(){
    TicketsDiv();    
    }
    
    public void TicketList(){
    ShowPaymentsdiv = False;
    ShowTicketTypesdiv = True;
    RemoveAddTicket = True;
    
    }
    
      public void Paymentsett(){
      ShowPaymentsdiv = True;
      ShowTicketTypesdiv = False;
      RemoveAddTicket = False;
      
    }
    
   
    public void SelectedAccounttype(){
    Accountype = ApexPages.currentPage().getParameters().get('AccountTypes');
    system.debug('************************'+Accountype );
    if(Accountype  == 'Authorize.Net'){
    PayPalAccountre = True;
    DotNetre = False;
    }
    else if(Accountype  == 'PayPal Account' ){
    PayPalAccountre = False;
    DotNetre = True;
    }
    }
}
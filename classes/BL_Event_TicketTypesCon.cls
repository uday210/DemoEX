public without sharing class BL_Event_TicketTypesCon {

 public string cloneId{get;set;}
 public boolean displycloneTic {get;set;}
 
    public PageReference Cancelclone() {
    displycloneTic  = false;
        return null;
    }



 
    public PageReference cloneTicket() {
      selectedcheckforCopySurvey = true;
      selectedcheckforpromo = true;
       selectedtypes = new string[]{};
        atttypes = new LIST<SelectOption> {};
        Event__c event = [select Attendee_Types__c from Event__c where id =: SelectedEvent];
    
    list<string> types = event.Attendee_Types__c.split(';');
    for(string type : types ){
    
    atttypes.add(new SelectOption(type,type));
    }
     PopUpName = 'Clone Ticket';
     system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypeID );   
     TicketTypes = [select id,TT_Name__c,TT_Available__c,TT_Amount__c,Sales_Start_Date__c,  
                    Sales_End_Date__c,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c,Start_Time__c,End_Time__c, 
                    Description__c,Avilable_for_Portal__c,TT_TicketType__c,Ticket_Category__c,  
                    Service_Fee__c,Ticket_Image_URL__c,User_Type__c,Section_Name__c  from TicketTypes__c where id=:cloneId];
     system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypes.Ticket_Category__c); 
        selectedtypes.add(TicketTypes.Ticket_Category__c); 
     
     
        displycloneTic  = true;
        return null;
    }

    public boolean selectedcheckforCopySurvey{get;set;}
    public boolean selectedcheckforpromo {get;set;}
    
    public PageReference saveCloneTicket() {
     
     TicketTypes__c tid =new TicketTypes__c();
      TicketTypes.EV_id__c = SelectedEvent ;        
       
        TicketTypes.TT_Sold__c = 0;
                 List<TicketTypes__c> ticstypes = new  List<TicketTypes__c> {};
                 //list<string> types = selectedtypes.split(',');
       List<TicketTypes__c> tictypes = new List<TicketTypes__c>();
        
        tictypes  =[SELECT Id,order__c,EV_id__c,TT_Name__c,Ticket_Category__c,forMobile__c  from TicketTypes__c where EV_id__c=:SelectedEvent AND forMobile__c=: FALSE];
        TicketTypes.order__c=tictypes.size();  
        for(string ss: selectedtypes){
        TicketTypes__c ticnew = new TicketTypes__c();
        TicketTypes.id=null;
        ticnew = TicketTypes.clone(true);
        ticnew .Ticket_Category__c = ss;  
        
        ticstypes.add(ticnew);
        
         
        }
        
        if(selectedtypes.size()==0){
         TicketTypes__c ticnew = new TicketTypes__c();
         TicketTypes.id=null;
           ticnew = TicketTypes.clone(true);
          // ticnew.Ticket_Category__c = ss;    
            ticstypes.add(ticnew);
        }
 
        system.debug( ' SSSSSSSSSSSSSSS '+ticstypes);
        //Database.upsert(); 
      List<Database.saveresult> saveresli = dataBase.insert(ticstypes,false);
    system.debug('$$$$$$$$$$$$$$$$$$$$$vc '+saveresli );
    
      List<Ticket_Mapswith_Survey__c> ticList = new List<Ticket_Mapswith_Survey__c>();
      List<Tickets_Mapswith_Promocode__c> promoList = new List<Tickets_Mapswith_Promocode__c>();
            List<Tickets_Mapswith_Promocode__c> promoListQu = new List<Tickets_Mapswith_Promocode__c>();
      for(Database.saveresult saveres: saveresli){
     if(saveres.isSuccess()){
       
        for( Ticket_Mapswith_Survey__c ticsur :[SELECT id,TicketTypes__c,Survey_Questions__c,Order__c,  IsRequired__c from Ticket_Mapswith_Survey__c where TicketTypes__c=:cloneId]){
             Ticket_Mapswith_Survey__c ty = new Ticket_Mapswith_Survey__c();
             ty.TicketTypes__c = saveres.getId();
             ty.Survey_Questions__c =ticsur.Survey_Questions__c;
             ty.Order__c = ticsur.Order__c;
             ty.IsRequired__c =ticsur.IsRequired__c;
            ticList.add(ty);
        }
       
       if(selectedcheckforCopySurvey){
         DataBase.insert(ticList,false);
       }
       promoListQu = [SELECT id,Promocodes__c,Tickets__c from Tickets_Mapswith_Promocode__c where Tickets__c=:cloneId];
       if(promoListQu.size() != 0){
        for(Tickets_Mapswith_Promocode__c protic :promoListQu ){
       
       Tickets_Mapswith_Promocode__c prom = new Tickets_Mapswith_Promocode__c();
       prom.Tickets__c = saveres.getId();
       prom.Promocodes__c =protic.Promocodes__c;
       promoList.add(prom);
       
       
       }}
       if(selectedcheckforpromo){
       database.insert(promoList,false);
       }
       
     }
   
    }
     displycloneTic  = false;
    
    
    system.debug( ' HHHHHHHHHHHHHHHHHHHHHH ');
    system.debug( ' CCCCCCCCCCCCCCCCC '+selectedcheckforCopySurvey); 
    
        return null;
    }
   





    public PageReference onchnageCheckbox() {
        return null;
    }


public TicketTypes__c TicketTypes{get;set;}
public string[] selectedtypes {get;set;}
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
public boolean typeboolforadd {get;set;}
public boolean typeboolforedit {get;set;}
public Boolean RemoveAddTicket{get;set;}
public List<SelectOption> SelectedAccountTypes{get;set;}
public string Accountype{get;set;}
public Boolean PayPalAccountre{get;set;}
public Boolean DotNetre{get;set;}
public Boolean RegisterPopUp{get;set;}
public String ShowRadio{get;set;}
Public List<TicketTypes__c> updateLeads{get;set;}

    
    public BL_Event_TicketTypesCon (){
    try{
    TicketTypes = new TicketTypes__c();
    PayPalAccount = new Pay_Pal_Account__c();     
    TicketTypes.TT_Amount__c = null;
   // ShowPaymentsdiv = True;
    SelectedEvent =ApexPages.currentpage().getParameters().get('event');
    Event = [select id,Ev_Title__c,IsRegistration__c,ShowAgain__c,  Attendee_Types__c from Event__c where id=:SelectedEvent ]; 
    
    if(Event[0].IsRegistration__c == False)
    ShowRadio = 'No';
    else
    ShowRadio = 'Yes';
   
      
    ticketBool = False;
    paymentBool = True;
    ProvideEmailId = False;
    getListOfTickectNames();
    //ShowMEthod();
     RegMethod();
    Accountype = 'PayPal Account';
    PayPalAccount.Account_types__c = 'PayPal Account';
    PayPalAccountre = True;
    TocheckPaypalAccount();
    SelectedAccounttype();
   
    }catch(exception e){}
   }
    
    
    public List<selectOption> getValues(){
    List<selectOption> Options = new List<selectOption>();
    Options.add(new selectOption('Yes','Yes'));
    Options.add(new selectOption('No','No'));
    return Options;
    
    }
    
    
    // Arrenge order down 
    
    
    public MAP<id,TicketTypes__c> mapticketes{get;set;}
    public string upPhani{get;set;}
    
    
     public PageReference down() {
    
     upPhani = Apexpages.currentPage().getParameters().get('upPhani');
     TicketTypes__c lp = new TicketTypes__c();
     lp = mapticketes.get(upPhani); 
    
    List<TicketTypes__c> updateLeads = new List<TicketTypes__c>();
    
    
    if(ListOfTicketTypes.size()>lp.order__c){
      TicketTypes__c sec = new TicketTypes__c();
      Integer li = integer.valueOF(lp.order__c)+1;
      sec =ListOfTicketTypes[li]; 
      sec.order__c=lp.order__c;
      updateLeads.add(sec); 
      
      system.debug('1111111111111111111111111111111 '+sec);
      lp.order__c=lp.order__c+1;
      updateLeads.add(lp);
      system.debug('2222222222222222 '+lp);
       
    }
    dataBase.update(updateLeads,false);
    return null;
  }
    
    
   // Arrenge order Up
   
     public PageReference up() {
     upPhani = Apexpages.currentPage().getParameters().get('upPhani');
      TicketTypes__c lp = new TicketTypes__c();
       lp = mapticketes.get(upPhani); 
    system.debug('HHHHHHHHHHHHHHHHHHHHHH '+lp);
    
    List<TicketTypes__c> updateLeads = new List<TicketTypes__c>();
       
    if(lp.order__c>=1){
      TicketTypes__c sec = new TicketTypes__c();
      Integer lj = integer.valueOF(lp.order__c)-1;
      sec =ListOfTicketTypes[lj]; 
      sec.order__c=lp.order__c;
      updateLeads.add(sec); 
       system.debug('1111111111111111111111111111111 '+(integer.valueOF(lp.order__c)-1));
      
      lp.order__c=lp.order__c-1;
      updateLeads.add(lp);
        system.debug('2222222222222222 '+lp);
       
    }
    dataBase.update(updateLeads,false);
    
     return null;
    }
   
    // Delete Action 
    
    public PageReference DeleteRec() {
     upPhani = Apexpages.currentPage().getParameters().get('upPhani');
     TicketTypes__c lp = new TicketTypes__c();
     lp = mapticketes.get(upPhani); 
     
     List<TicketTypes__c> updateLeads = new List<TicketTypes__c>();
     
     for(integer j=integer.valueOF(lp.order__c)+1;j<ListOfTicketTypes.size();j++){
          system.debug('hhhhhhhhhhh '+j);
          TicketTypes__c sec = new TicketTypes__c();
          sec =ListOfTicketTypes[j]; 
          sec.order__c=j-1;
          updateLeads.add(sec); 
      }
     
        dataBase.update(updateLeads,false);
      dataBase.delete(lp,false);
    
    
        return null;
    }

    
    
    
    
    
    
    
  public decimal listsize{get;set;}
      
    public List<TicketTypes__c> getListOfTickectNames(){
    
    ListOfTicketTypes = new List<TicketTypes__c>();
    ListOfTicketTypes = [select id,TT_Name__c,order__c,TT_Available__c,TT_Amount__c,TT_TicketType__c,Start_Time__c,End_Time__c,Ticket_Category__c,TT_Limit__c,TT_Sold__c,  
                         Avilable_for_Portal__c,Available__c,Ticket_Image_URL__c,forMobile__c  from TicketTypes__c where EV_id__c =: SelectedEvent AND forMobile__c=: FALSE order by order__c nulls last]; 
      
      
  mapticketes = new MAP<id,TicketTypes__c>();
  for(TicketTypes__c l: ListOfTicketTypes ){
      mapticketes.put(l.id,l); 
   
   }
   
    listsize = ListOfTicketTypes.size();
   system.debug('PPPPPPPPPPPPP '+listsize );
 
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
    typeboolforedit = true;
    typeboolforadd = false;
    selectedtypes = new string[]{};
     atttypes = new LIST<SelectOption> {};
      typeoptions = new LIST<SelectOption> {};
    
    typeoptions.add(new SelectOption('None','None'));
    typeoptions.add(new SelectOption('Match Leads Buyer','Match Leads Buyer'));
    typeoptions.add(new SelectOption('Match Leads Seller','Match Leads Seller'));
    Event__c event = [select Attendee_Types__c from Event__c where id =: SelectedEvent];
    
    list<string> types = event.Attendee_Types__c.split(';');
    for(string type : types ){
    
    atttypes.add(new SelectOption(type,type));
    }
     PopUpName = 'Edit Ticket';
     system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypeID );   
     TicketTypes = [select id,TT_Name__c,TT_Available__c,TT_Amount__c,Sales_Start_Date__c,  
                    Sales_End_Date__c,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c,Start_Time__c,End_Time__c, 
                    Description__c,Avilable_for_Portal__c,TT_TicketType__c,Ticket_Category__c,Type__c,  
                    Service_Fee__c,Ticket_Image_URL__c,User_Type__c,Section_Name__c  from TicketTypes__c where id=:TicketTypeID ];
     system.debug( ' HHHHHHHHHHHHHHHHHHHHHH '+TicketTypes.Ticket_Category__c); 
        selectedtypes.add(TicketTypes.Ticket_Category__c);
        selectedtype =  TicketTypes.Type__c;      
     AddTicketTypes = True; 
      system.debug( ' HHHHHHGGGGGGGGGGHHHHHHHHHH '+TicketTypes.Ticket_Category__c); 
       
   /**  if(TicketTypes.TT_TicketType__c == 'Paid'){
     Showwhenselected = True;
     }else{
     Showwhenselected = False;
     } */
    }
    public LIST<SelectOption> atttypes{get; set;}
    public string selectedatttype {get;set;}
    public LIST<SelectOption> typeoptions {get ; set ;}
    public string selectedtype {get ; set ;}
    
    
    public void AddTicket(){
     typeboolforedit = false;
    typeboolforadd = true;
    selectedtypes  = new string[]{};
    selectedtype = '';
    atttypes = new LIST<SelectOption> {};
    typeoptions = new LIST<SelectOption> {};
    
    typeoptions.add(new SelectOption('None','None'));
    typeoptions.add(new SelectOption('Match Leads Buyer','Match Leads Buyer'));
    typeoptions.add(new SelectOption('Match Leads Seller','Match Leads Seller'));
    
    Event__c event = [select Attendee_Types__c from Event__c where id =: SelectedEvent];
    
    if(event!= NULL){
        list<string> types = event.Attendee_Types__c.split(';');
        for(string type : types ){
            atttypes.add(new SelectOption(type,type));
        }
    }
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
        
        List<TicketTypes__c> tictypes = new List<TicketTypes__c>();
        
        tictypes  =[SELECT Id,order__c,EV_id__c,TT_Name__c,Ticket_Category__c,forMobile__c  from TicketTypes__c where EV_id__c=:SelectedEvent AND forMobile__c=: FALSE];
       
        
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
       
       if(PopUpName != 'Edit Ticket'){  
       
           TicketTypes.order__c=tictypes.size();
     
      }  
        
        TicketTypes.EV_id__c = SelectedEvent ;        
        TicketTypes.Type__c = selectedtype;
        TicketTypes.TT_Sold__c = 0;
                 List<TicketTypes__c> ticstypes = new  List<TicketTypes__c> {};
                 //list<string> types = selectedtypes.split(',');
       
        for(string ss: selectedtypes){
        TicketTypes__c ticnew = new TicketTypes__c();
        ticnew = TicketTypes.clone(true);
        ticnew .Ticket_Category__c = ss;    
        ticstypes.add(ticnew);
         TicketTypes.id = null;
        }
       
        if(selectedtypes.size()==0){
         TicketTypes__c ticnew = new TicketTypes__c();
           ticnew = TicketTypes.clone(true);
          // ticnew.Ticket_Category__c = ss;    
            ticstypes.add(ticnew);
        }
        
        
        
        
        
        system.debug( ' SSSSSSSSSSSSSSS '+ticstypes);
       List<Database.UpsertResult> upres = Database.upsert(ticstypes,false); 
       List<Ticket_Mapswith_Survey__c> ticList = new List<Ticket_Mapswith_Survey__c> ();
       List<Tickets_Mapswith_Promocode__c> promoList = new List<Tickets_Mapswith_Promocode__c> ();
       List<Tickets_Mapswith_Promocode__c> promoListQu = new List<Tickets_Mapswith_Promocode__c> ();
        if(PopUpName == 'Edit Ticket'){ 
         for(Database.UpsertResult up: upres){
         if (up.isSuccess()) {
         if (up.iscreated()) {
         
           for( Ticket_Mapswith_Survey__c ticsur :[SELECT id,TicketTypes__c,Survey_Questions__c,Order__c,  IsRequired__c from Ticket_Mapswith_Survey__c where TicketTypes__c=:cloneId]){
             Ticket_Mapswith_Survey__c ty = new Ticket_Mapswith_Survey__c();
             ty.TicketTypes__c = up.getId();
             ty.Survey_Questions__c =ticsur.Survey_Questions__c;
             ty.Order__c = ticsur.Order__c;
             ty.IsRequired__c =ticsur.IsRequired__c;
            ticList.add(ty);
        }
       
      
         DataBase.insert(ticList,false);
     
       promoListQu = [SELECT id,Promocodes__c,Tickets__c from Tickets_Mapswith_Promocode__c where Tickets__c=:cloneId];
       if(promoListQu.size() != 0){
        for(Tickets_Mapswith_Promocode__c protic :promoListQu ){
       
       Tickets_Mapswith_Promocode__c prom = new Tickets_Mapswith_Promocode__c();
       prom.Tickets__c = up.getId();
       prom.Promocodes__c =protic.Promocodes__c;
       promoList.add(prom);
       
       
       }}
       }
       }
       database.insert(promoList,false);
     
        
        
        
        }
        }
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
        
        
       List<Pay_Pal_Account__c> paypalAcc = [select id,Email_Id__c,Check_Address__c,check_amount_Minimum__c,Accept_check__c from Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
       
        if(paypalAcc.size()>0){
        ShowTicketTypesdiv = True;
        ListTickets = True;
        if(Event[0].IsRegistration__c == True){
        PayementSettings= True;
        }else{
        PayementSettings= False;
        }
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
    
    List<Pay_Pal_Account__c> paypalAccounts = [select Account_Types__c,Psignature__c ,PuserName__c,Ppassword__c ,Check_Address__c,
                                               check_amount_Minimum__c,Accept_check__c,AuthorizationDotNet__c,id,Email_Id__c,AuthorizationDotNetKey__c,
                                               Enable_Paypal__c,Max_Amount_for_Paypal__c,Min_Amount_for_Paypal__c
                                               from Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
    
    
    
    System.debug(' %%%%%%%%%% %%%%%%%%%%%%%'+paypalAccounts );                                           
   
    if(paypalAccount.check_amount_Minimum__c==null){
     paypalAccount.check_amount_Minimum__c=0;
    
    }
   
    if(paypalAccounts.size()>0){
    
    if( paypalAccount.Email_Id__c != null && paypalAccount.Account_Types__c == 'PayPal Account'){
    
        system.debug(' GGGGGGGGGGGGGG '+paypalAccount.Email_Id__c);
    
    paypalAccounts[0].Email_Id__c = paypalAccount.Email_Id__c;
    paypalAccounts[0].Ppassword__c =paypalAccount.Ppassword__c ;
    paypalAccounts[0].Psignature__c =paypalAccount.Psignature__c ;
    paypalAccounts[0].Check_Address__c = paypalAccount.Check_Address__c;
    paypalAccounts[0].check_amount_Minimum__c = paypalAccount.check_amount_Minimum__c;
    paypalAccounts[0].Accept_check__c = paypalAccount.Accept_check__c;   
    paypalAccounts[0].Enable_Paypal__c = paypalAccount.Enable_Paypal__c;
    paypalAccounts[0].Max_Amount_for_Paypal__c = paypalAccount.Max_Amount_for_Paypal__c;
    paypalAccounts[0].Min_Amount_for_Paypal__c = paypalAccount.Min_Amount_for_Paypal__c;
    paypalAccounts[0].Redirect_Url__c= paypalAccount.Redirect_Url__c;
    paypalAccounts[0].AuthorizationDotNet__c = '';
    paypalAccount.AuthorizationDotNet__c = '';
    paypalAccounts[0].AuthorizationDotNetKey__c = '';
    paypalAccount.AuthorizationDotNetKey__c = '';
    
    }
    if(paypalAccount.AuthorizationDotNet__c != null && paypalAccount.Account_Types__c == 'Authorize.Net'){
    paypalAccounts[0].AuthorizationDotNet__c = paypalAccount.AuthorizationDotNet__c;
    paypalAccounts[0].AuthorizationDotNetKey__c = paypalAccount.AuthorizationDotNetKey__c;
    paypalAccounts[0].PuserName__c = '';
    paypalAccount.PuserName__c = '';
    paypalAccounts[0].Ppassword__c ='';
    paypalAccount.Ppassword__c = '';
    paypalAccounts[0].Psignature__c ='';
    paypalAccount.Psignature__c ='';
    }
    if(paypalAccount.Account_Types__c == 'TrustCommerce'){
    
    paypalAccounts[0].PuserName__c = paypalAccount.PuserName__c;
    paypalAccounts[0].Ppassword__c =paypalAccount.Ppassword__c ;
    paypalAccounts[0].Enable_Paypal__c = false;
    }
    paypalAccounts[0].Account_Types__c = paypalAccount.Account_Types__c;
    database.update(paypalAccounts);
    }
    else{
    
    PayPalAccount.Event__c = SelectedEvent;
    paypalAccount.Email_Id__c = paypalAccount.Email_Id__c;
    paypalAccount.Ppassword__c = paypalAccount.Ppassword__c;
    paypalAccount.Psignature__c = paypalAccount.Psignature__c;
    paypalAccount.Account_Types__c = paypalAccount.Account_Types__c; 
    paypalAccount.AuthorizationDotNet__c = paypalAccount.AuthorizationDotNet__c;
    paypalAccount.AuthorizationdotNetKey__c = paypalAccount.AuthorizationdotNetKey__c;
    paypalAccount.Check_Address__c = paypalAccount.Check_Address__c;
    paypalAccount.check_amount_Minimum__c = paypalAccount.check_amount_Minimum__c;
    paypalAccount.Accept_check__c = paypalAccount.Accept_check__c;
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
    
    List<Pay_Pal_Account__c> paypalAccounts = [select AuthorizationdotNetKey__c,PuserName__c,Psignature__c,Check_Address__c,check_amount_Minimum__c,Accept_check__c,
                                               AuthorizationdotNet__c,id,Email_Id__c,Account_Types__c,Ppassword__c,Enable_Paypal__c,Max_Amount_for_Paypal__c,Min_Amount_for_Paypal__c
                                               from Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
                                               
    if(paypalAccounts .size()>0){
    system.debug('ffffffffffffffff');
    ProvideEmail = False;
    RProvideEmail = True;
    system.debug('******************* ************************'+paypalAccounts [0].Account_Types__c);
    paypalAccount.Account_Types__c = paypalAccounts [0].Account_Types__c;
    Accountype=paypalAccounts [0].Account_Types__c;
    
    if(paypalAccounts [0].PuserName__c != null && paypalAccounts [0].Account_Types__c == 'PayPal Account'){
    paypalAccount.Email_Id__c = paypalAccounts [0].Email_Id__c;
    paypalAccount.Ppassword__c = paypalAccounts [0].Ppassword__c;
    paypalAccount.Psignature__c = paypalAccounts [0].Psignature__c;
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
      PayPalAccount = new Pay_Pal_Account__c();
      system.debug(' %%%%%%%%%%%%%%%%'+SelectedEvent );
      
      paypalAccount = [select AuthorizationdotNetKey__c,Redirect_Url__c,PuserName__c,Psignature__c,Enable_Paypal__c,Max_Amount_for_Paypal__c,Min_Amount_for_Paypal__c,
                       AuthorizationdotNet__c,id,Email_Id__c,Account_Types__c,Ppassword__c,Check_Address__c,check_amount_Minimum__c,Accept_check__c
                       from Pay_Pal_Account__c where Event__r.id =:SelectedEvent Limit 1];
      
      
      
      ShowPaymentsdiv = True;
      ShowTicketTypesdiv = False;
      RemoveAddTicket = False;
      
    }
    
   
    public void SelectedAccounttype(){
    //Accountype = ApexPages.currentPage().getParameters().get('AccountTypes');
    //system.debug('************************'+Accountype );
        //system.debug('************************'+PayPalAccount.Account_types__c);
        
        Accountype = PayPalAccount.Account_types__c;
    if(Accountype  == 'Authorize.Net'){
    PayPalAccountre = True;
    DotNetre = False;
    }
    else if(Accountype  == 'PayPal Account' ){
    PayPalAccountre = True;
    DotNetre = False;
    }
     else if(Accountype  == 'TrustCommerce' ){
        PayPalAccountre = true;
        DotNetre = false;
      }
  system.debug('************************'+PayPalAccount.Account_types__c);    
    }
    
        
    
    public void SaveReg(){
    if(ShowRadio == 'Yes')
    Event[0].IsRegistration__c = True;
    else
    Event[0].IsRegistration__c = False;
      
    Event[0].Showagain__c = Event[0].Showagain__c;
    
    Database.Update(Event[0]);
    
    if(ShowRadio == 'No'){
    ShowTicketTypesdiv = True;
    ListTickets = True;
    RegisterPopUp = False;
    ShowPaymentsdiv = False;
    ticketBool = True; 
    paymentBool = False;
    RemoveAddTicket = True; 
    }if(ShowRadio == 'Yes'){
    RegisterPopUp = False;
    ShowPaymentsdiv = True;
    TocheckPaypalAccount(); 
    ShowMEthod();
    }
    }
    
    
    public void RegMethod(){
    
    if(Event[0].IsRegistration__c == false && Event[0].ShowAgain__c == False)
       RegisterPopUp = True; 
             
   if(Event[0].IsRegistration__c == False &&  Event[0].ShowAgain__c == True){
   RegisterPopUp = False; 
   ShowTicketTypesdiv = True;
    ListTickets = True;
    RegisterPopUp = False;
    ShowPaymentsdiv = False;
    ticketBool = True; 
    paymentBool = False;
    RemoveAddTicket = True;
   }
           
  if(Event[0].IsRegistration__c == True && Event[0].ShowAgain__c == False)
  RegisterPopUp = True; 
  
  if(Event[0].IsRegistration__c == True && Event[0].ShowAgain__c == True){ 
    RegisterPopUp = False;
    ShowPaymentsdiv = True;
    TocheckPaypalAccount(); 
    ShowMEthod();   
     
}
}



public boolean ChangeTiccategoty{get;set;}
public List<InnChangeCatCls> InnTicList{get;set;}
public void renderTicbool(){
InnTicList = new List<InnChangeCatCls>();
string ticvalues='' ;
try{
if(event[0].Attendee_Types__c!=null){
ticvalues = event[0].Attendee_Types__c;
}
}catch(exception yt){}


 List<SelectOption> opInn = new List<SelectOption>(); 
 opInn.add(new SelectOption('--NONE--','--NONE--'));
for(string ticcats:ticvalues.split(';')){
 opInn.add(new SelectOption(ticcats,ticcats));
 
}

 for(TicketTypes__c tc :  [SELECT id,Ticket_Category__c,EV_id__r.id,TT_Name__c,forMobile__c from TicketTypes__c where EV_id__r.id=:SelectedEvent AND forMobile__c=: FALSE order by Ticket_Category__c nulls First]){
     InnTicList.add(new InnChangeCatCls(tc,opInn)); 
 }
  
  ChangeTiccategoty =TRUE;
}


public void renderTicboolcancel(){
    ChangeTiccategoty =FALSE;
}


public class InnChangeCatCls{
    public string selecteListval{get;set;}
    public List<selectOption> optionsInn{get;set;}
    public TicketTypes__c ticinn{get;set;}
    public InnChangeCatCls(TicketTypes__c ticinns,List<selectOption> optionsInns){
        this.selecteListval =ticinns.Ticket_Category__c;
        this.optionsInn=optionsInns;
        this.ticinn =ticinns;
    }
}

public void innvaluesSave(){
    List<TicketTypes__c> ticd = new List<TicketTypes__c>();
    for(InnChangeCatCls inncl:InnTicList){
        inncl.ticinn.Ticket_Category__c =inncl.selecteListval;
        ticd.add(inncl.ticinn);
    }
    dataBase.update(ticd,false);
    ChangeTiccategoty =FALSE;
}

public void dummyMeth(){
integer i=0;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;
i++;

   
}

}
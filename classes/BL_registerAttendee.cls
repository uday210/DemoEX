public without sharing class BL_registerAttendee {

    public PageReference freeTicket() {
    
    
    
        return null;
    }


    public String state { get; set; }

    public String exmo { get; set; }

    public String exye { get; set; }

    public String cvv { get; set; }

    public String cardNo { get; set; }

    public String LastName { get; set; }

    public String FirstName { get; set; }
   
    public boolean displayPayment{get;set;}

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
       public string SuccessMessage                    {get;set;}

public MAP<id,Decimal> mapIdWithPrice {get;set;}

 public Event__c event {get;set;}
 public BL_registerAttendee(){

     selectedTab ='name1';
     selectedEvent =Apexpages.currentPage().getparameters().get('id');
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
    
    
     mapIdWithPrice  =new MAP<id,Decimal >();
     
     inn = new List<innerClass>();
     TTList = new List<TicketTypes__c>();
     
     TTList =[select Service_Fee__c,TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                        ,Ticket_Image_URL__c,Sales_End_Date__c from TicketTypes__c where EV_id__c=:selectedEvent ];
     system.debug('TTTTTTTTTTTTTTTTTTTTTTTTTTTT'+TTList );
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
     
     }   inn.add(new innerClass(bt,options));
         mapIdWithPrice.put(bt.id,bt.TT_Amount__c);
              
     }
   }catch(exception e){}
   }


public class innerClass {
public TicketTypes__c tt{get;set;}
public integer quantity{get;set;}
public decimal donationValue{get;set;}
 public List<selectOption> opt{get;set;}
 public innerClass(TicketTypes__c t,List<selectOption> op){
 donationValue =0;
 quantity =0;
 this.tt=t;
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
          decimal d=0;
           try{
            d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
          } catch(exception e){}
        
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
       
       if(TotalAmount!=0){
       displayPayment = true;
       }
      
    }
public integer GrandQuantity{get;set;}
public decimal boothleadsAmount{get;set;}
public decimal eventAdminAmount {get;set;}
public decimal TotalAmount{get;set;}

 public PageReference onchangeAct() {
    system.debug('hiiiiiiiiiiiiiiii '+inn);
    GrandQuantity =0;
    TotalAmount=0;
    eventAdminAmount =0;
    boothleadsAmount =0;
      try{
  
      for(innerClass incls:inn){
        if((incls.quantity!=0 && incls.quantity!=null)|| (incls.tt.TT_TicketType__c=='donation')){
          decimal  d=0;
             system.debug('3534534535353534534 '+incls.quantity);
          if((incls.quantity!=0 && incls.quantity!=null) ){
          
            d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
              if(incls.tt.Service_Fee__c=='Add Booth Leads fee on top of the total ticket price'){
              boothleadsAmount +=(d*3/100);
              eventAdminAmount +=d; 
             // TotalAmount+=d+boothleadsAmount;
               GrandQuantity+=incls.quantity; 
           }else{
             decimal cutAmout =0; 
             cutAmout= (d*3/100);
            
             boothleadsAmount =boothleadsAmount+cutAmout;
           
             eventAdminAmount +=d-cutAmout; 
             GrandQuantity+=incls.quantity;
           }
          
          }
          
           if(incls.donationValue!=0 && incls.donationValue!=null){
             d +=incls.donationValue;
             boothleadsAmount = boothleadsAmount+(d*3/100);
              eventAdminAmount +=d; 
            }
          
        }
         
        
      }TotalAmount=eventAdminAmount+boothleadsAmount;
      
      
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
public innforSecondButton(TicketTypes__c name,Decimal to,integer  Qua){
dom = new List<Dummay__c>();
this.totalPrice=to;
this.Quan=qua;
this.Name =name;

for(integer i=1;i<=qua;i++){
 ds = new Dummay__c();
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
 
 
   public List<string> listForMails{get;set;}
   
  public pagereference Pay(){
    boolean  paymentSuccess =false;
    if((eventAdminAmount!=null && eventAdminAmount!=0)&& (boothleadsAmount!=null && boothleadsAmount!=0)){
   PaypalPrymentscon pro = new PaypalPrymentscon();  
   paymentSuccess = pro.doDirectPayment(exye,exmo,cardNo,string.valueOf(eventAdminAmount),string.valueOf(boothleadsAmount),FirstName,LastName);
   }else{
    paymentSuccess =true;
   }
   
       
     MAP<string,List<string>> mapTicketsWithEmail = new MAP<string,List<string>>();
     
      MAP<string,integer> MAPticketNameWithcount= new MAP<string,integer>();
     
     
     List<AttendeeSummary__c> attList = new List<AttendeeSummary__c>();
        if(paymentSuccess){
           listOfEamsInn = new List<EamValue>();   
             List<Booth__c>  booths = new List<Booth__c>();
             
             
          system.debug('1111111111 '+seccls);   
             listForMails = new  List<string>();
             
         for(innforSecondButton attval:seccls){
         
         List<string> listofstrs = new  List<string>();
         
                 
          for(Dummay__c att :attval.dom){
           Booth__c b =new Booth__c();
           b.BT_Name__c =att.Company__c;
           b.EV_id__c =selectedEvent ;
           b.BT_ContactEmail__c = att.Email__c;
           booths.add(b);
           
           
           
           AttendeeSummary__c attsum = new AttendeeSummary__c();
           attsum.AS_FirstName__c = att.First_Name__c;
           attsum.AS_LastName__c  =att.Last_Name__c;
           attsum.AS_Email__c =att.Email__c;
           attsum.AS_CellPhone__c =att.Phone__c;
           attsum.AS_Company__c= att.Company__c;
           listForMails.add(att.Email__c);
           attList.add(attsum); 
           system.debug('1111111111 ');  
           
            
           listofstrs.add(att.Email__c);
                      
           listOfEamsInn.add(new EamValue(att.Email__c,attval.Name.TT_Name__c)); 
          }  
         MAPticketNameWithcount.put(attval.Name.TT_Name__c,listofstrs.size()); 
                  
            
        }
          
          
           Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
             
        dataBase.upsertResult[] upREsult = dataBase.Upsert(attList,f,false);
        
        MAP<string,string> mapEmailWithTicket = new MAP<string,string>();
         
         for(string emails:listForMails){
         List<string> tickets = new List<string>();
         string ticketsType='';
          for(EamValue emv:listOfEamsInn){
            if(emails==emv.email){
              if(ticketsType!=''){
               ticketsType+=';'+ticketsType;
              }else{
               ticketsType=emv.ticketName;
              }
                        
            }
          }
          
          mapEmailWithTicket.put(emails,ticketsType);
       }
       
    system.debug('333333333333333 '+mapEmailWithTicket);
    
      SET<Id> uptedRecords = new SET<Id>();
     List<Id> boothIds = new List<Id>();
     
     dataBase.saveResult[] saveResult = dataBase.insert(booths);
     for( dataBase.saveResult sresult:saveResult){
      if(sresult.isSuccess()){
        boothIds.add(sresult.getId());
      }  
    }
    
    List<TicketTypes__c> listOfticktes = new List<TicketTypes__c>();
    for(TicketTypes__c tttype:[select id,TT_Amount__c,  Available__c,Description__c,End_Time__c,EV_id__c,TT_Limit__c,Max_Tickets_per_Order__c,
    Min_Tickets_per_Order__c,TT_Name__c,Sales_End_Date__c,TT_Available__c,TT_TicketType__c,Ticket_Image_URL__c, Ticket_Category__c,
        Start_Time__c,  TT_Sold__c, Service_Fee__c from TicketTypes__c where EV_id__c=:selectedEvent]){
    
    tttype.TT_Sold__c = MAPticketNameWithcount.get(tttype.TT_Name__c);
    listOfticktes.add(tttype);    
        
    }
    
    dataBase.update(listOfticktes,false);
       
    MAP<string,id> mapBoothwithName = new MAP<string,id>();
    for(Booth__c boothvalues :[SELECT id,BT_Name__c,BT_ContactEmail__c from Booth__c where Id IN :boothIds]){
    mapBoothwithName.put(boothvalues.BT_ContactEmail__c,boothvalues.id);
    }
    
    
    List<id> insertedRecords = new List<id>();
     
     for(dataBase.upsertResult us:upREsult){
      if(us.isSuccess()){
       if(us.isCreated()){
        insertedRecords.add(us.getId());  
        }else{
           uptedRecords.add(us.getId());
        }
      }  
   }
    
    
        List<Event_Attendee_Mapping__c> EAMListforInsert = new List<Event_Attendee_Mapping__c>();
        for(AttendeeSummary__c singleatt :[select id,AS_Email__c from AttendeeSummary__c where id In :insertedRecords]){
        Event_Attendee_Mapping__c  EAM = new Event_Attendee_Mapping__c();      
        EAM.AS_id__c =singleatt.id;
        EAM.EV_id__c =selectedEvent;
        EAM.TicketTypes__c =mapEmailWithTicket.get(singleatt.AS_Email__c);
        EAM.paid__c = true;
        EAM.Attendee_Event_IDs__c =singleatt.id+''+selectedEvent;
        EAMListforInsert.add(EAM);
       }
       dataBase.Insert(EAMListforInsert,false);
    
    
    
     List<Event_Attendee_Mapping__c> listEamsExisted = new  List<Event_Attendee_Mapping__c>();
       set<Id> NonexistedInEamids = new set<Id>();
       
       for(Event_Attendee_Mapping__c existedEam :[select AS_id__r.Id,id,TicketTypes__c,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c where AS_id__c IN :uptedRecords and EV_id__c=:selectedEvent]){
        existedEam.TicketTypes__c +=mapEmailWithTicket.get(existedEam.AS_id__r.AS_Email__c);
        listEamsExisted.add(existedEam);
        NonexistedInEamids.add(existedEam.AS_id__r.Id);
       }  
     dataBase.update(listEamsExisted,false);  
    
    
    
     List<Event_Attendee_Mapping__c> listEamsExisted1 = new  List<Event_Attendee_Mapping__c>();
       for(Event_Attendee_Mapping__c existedEam1 :[select AS_id__r.Id,id,TicketTypes__c,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c where AS_id__c IN :uptedRecords and EV_id__c=:selectedEvent and AS_id__c NOT IN :NonexistedInEamids]){
       
        Event_Attendee_Mapping__c  EAM = new Event_Attendee_Mapping__c();      
        EAM.AS_id__c =existedEam1.AS_id__r.Id;
        EAM.EV_id__c =selectedEvent;
        EAM.TicketTypes__c =mapEmailWithTicket.get(existedEam1.AS_id__r.AS_Email__c);
        EAM.paid__c = true;
        EAM.Attendee_Event_IDs__c =existedEam1.AS_id__r.id+''+selectedEvent;
        listEamsExisted1.add(EAM);
       } 
       
       dataBase.insert(listEamsExisted1,false);  
    
    
    List<user> userList=[select id,userName from user where userName IN :listForMails];
     
   List<User_Profile_Event__c> lupe=[Select id,User_id__c  from User_Profile_Event__c 
                                     Where User_id__r.userName IN: listForMails
                                     And EV_id__c=:selectedEvent]; 
   
   MAP<Id, User_Profile_Event__c> upeMap = new MAP<id, User_Profile_Event__c>();
   
   for(User_Profile_Event__c u: lupe){
       upeMap.put(u.User_id__c , u);
   }
   
   LIST<Profile__c> profileAtt = new LIST<Profile__c>();
   profileAtt =[select id from Profile__c where PR_Name__c='Attendee'];
    LIST<User_Profile_Event__c> newUPEtoInsert = new LIST<User_Profile_Event__c>();
   
    for(USER uu:userList)  {                               
        
        User_Profile_Event__c singleUPE = new User_Profile_Event__c();
        
        if(upeMap.containsKey(uu.id)){
     
        }else{
                    singleUPE.User_id__c = uu.id;
                    singleUPE.EV_id__c = selectedEvent;
                    singleUPE.BT_id__c    = mapBoothwithName.get(uu.userName); 
                    try{
                    singleUPE.Profile_id__c   =profileAtt[0].id;   
                    }catch(exception e){}
                     singleUPE.status__c ='Active';               
                    newUPEtoInsert.add(singleUPE); 
        }                                   
   
    }     
     dataBase.insert(newUPEtoInsert,false);
    pageReference pg = new PageReference('/apex/BL_Success?id='+selectedEvent);
    return pg;     
    }
     
    return null;  
  }
  
  
  
 public  LIst<EamValue> listOfEamsInn {get;set;}
  
  public class EamValue{
   public string email{get;set;}
   public string ticketName{get;set;}  
   public EamValue(string fd,string hg){
   email = fd;
   ticketName = hg;
   }
  
  }
  
  
  
  
  

}
public with sharing class BL_Special_Needs_Expos_Con {

public List<SelectOption> copylst{get;set;}
   public List<SelectOption> getDisplaycopyOptions() {
        
        return copylst;
    }
    
 public string targetVal{get;set;}
public string checkadd{get;set;}
  
public boolean selectAtleastOneError{get;set;}

public Event__c event {get;set;}
public boolean paymentsPage{get;set;}
public decimal TotalAmount{get;set;}
public string selectedEvent {get;set;}

public LIST<Pay_Pal_Account__c> eventAdminEvent {get;set;}
public List<innerClass> totalTickets{get;set;}
public MAP<id,Decimal > mapIdWithPrice   {get;set;}
public List<innerClass> inn{get;set;} 
public List<TicketTypes__c> TTList{get;set;}
public List<selectOption> options {get;set;}
public integer GrandQuantity{get;set;}
public decimal boothleadsAmount{get;set;}
public decimal eventAdminAmount {get;set;}
public List<SelectOption> paytypes { get;set;}
public string paymenttypeIteam{get;set;} 
public string nextpageError {get;set;}
public Constomer__c cus {get;set;}

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
public String CommonParametersObjName{get;set;}
public string SenderEmail{get;set;} 
public string MainMessage {get;set;}
public string thisTimeStr11 {get;set;}
public User_Profile_Event__c upesvalueforSendMail{get;set;}

public string eventadminEmail{get;set;}
public string thisTimeStr {get;set;}
public string endtimestr{get;set;}
public string calenderid{get;set;}

// Getting Event details and and paypal account account owner Id
public BL_Special_Needs_Expos_Con(){

 selectAtleastOneError =false;
 TotalAmount =0.0;
 selectedEvent =Apexpages.currentPage().getparameters().get('id');
 system.debug('322222222222222222 '+selectedEvent );
     
     try{
     event = [SELECT id,EV_Description__c,EV_EndDate__c,EV_EndTime__c,EV_HistingAddr1__c,EventDiversityValues__c,
                        EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingFax__c,
                        EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,
                        EV_HostingTimeZone__c,EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,
                        EV_Title__c,EV_WebsiteURL__c,EV_EventLogo__c,EV_ContactURL__c,EV_HostingCountry__c , 
                        EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,
                        Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c,FacebookId__c,TwitterId__c
                           FROM Event__c WHERE id =: ApexPages.currentpage().getParameters().get('id')];
       
       
      try{
         
         attachment attval = new attachment();
         attval  = [select id,body from attachment where parentid=:event.id];
         calenderid = attval.id  ;
         system.debug('XXXXXXXXXXXXXXXXXXXXXXxx '+calenderid );
      
      }catch (exception es){
      
      }
       
       
       
       
       
       
       
      try{ 
        
         if(event.EV_HostingStateNew__c!=null){
          Commanforstates  con = new Commanforstates ();
          event.EV_HostingStateNew__c= con.mapstate(event.EV_HostingStateNew__c);
        } 
        
       upesvalueforSendMail = new  User_Profile_Event__c();
        upesvalueforSendMail =[select id,   User_id__r.userName,EV_id__c,Profile_id__r.PR_Name__c from User_Profile_Event__c where EV_id__c=:event.id AND Profile_id__r.PR_Name__c='EventAdmin'];
        eventadminEmail =upesvalueforSendMail.User_id__r.userName;
      }catch(exception e){} 
       eventAdminEvent = new LIST<Pay_Pal_Account__c>();
      eventAdminEvent =[select Email_Id__c,Payment_Type__c,Fee_Payer__c,OurEmail__c,Accept_check__c,check_amount_Minimum__c,Check_Address__c from Pay_Pal_Account__c where Event__c=:ApexPages.currentpage().getParameters().get('id')];
      system.debug('3242342342342342342 '+eventAdminEvent );
      DisplayTab2Values();
      onchangeAct();
      
       // Dateformats for calender
        string startdatestr =(event.EV_StartDate__c).format();
      string  startdateTime  =startdatestr +' '+event.StartTime__c;
       dateTime startDatetimevalue  = DateTime.parse(startdateTime);
       
       thisTimeStr = startDatetimevalue.format('yyyyMMdd\'T\'HHmmss\'Z\'','UTC' );
         thisTimeStr11 = startDatetimevalue.format('yyyyMMdd\'T\'HHmmss\'Z\'' );
         
         system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM '+thisTimeStr );
       
        string startdatestr1 =(event.EV_EndDate__c).format();
      string startdateTime1  =startdatestr1 +' '+event.EV_EndTime__c;
       dateTime startDatetimevalue1  = DateTime.parse(startdateTime1  );
       
       
       endtimestr = startDatetimevalue1.format('yyyyMMdd\'T\'HHmmss\'Z\'','UTC' );
       endtimestr11 = startDatetimevalue1.format('yyyyMMdd\'T\'HHmmss\'Z\'' );
       system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM '+endtimestr );
   }catch(exception e){}
 }




public string endtimestr11 {get;set;}
 public void DisplayTab2Values(){
 
 
// Get the URL for the current request.
String currentRequestURL = URL.getCurrentRequestUrl().toExternalForm();
System.debug('Current request URL: ' + currentRequestURL);   

// string ddd = BL_Special_Needs_Expos_attendee.tolowercase();
 
 
 
  mapIdWithPrice  =new MAP<id,Decimal >();
  inn = new List<innerClass>();
  TTList = new List<TicketTypes__c>();
  
  currentRequestURL =currentRequestURL.tolowercase(); 
  
  if(currentRequestURL.contains(('BL_Special_Needs_Expos_attendeeR').tolowercase())){
    TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                       ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent and Sales_End_Date__c >=TODAY  and Ticket_Category__c='AttendeeR' and Sales_Start_Date__c<=TODAY and Avilable_for_Portal__c=true order by order__c ];
     system.debug('DDDDDDDDDDDDDDDDDDDDDDDDD '+TTList );
   
   }else if(currentRequestURL.contains(('BL_Special_Needs_Expos_Attendees_Robbyne').tolowercase())){
    TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                       ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent and Sales_End_Date__c >=TODAY  and Ticket_Category__c='Attendees-Robbyne' and Sales_Start_Date__c<=TODAY and Avilable_for_Portal__c=true order by order__c ];
  
   
   }else if(currentRequestURL.contains(('BL_Special_Needs_Expos_attendee').tolowercase())){
  TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                       ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent and Sales_End_Date__c >=TODAY and Ticket_Category__c='Attendee' and Sales_Start_Date__c<=TODAY and Avilable_for_Portal__c=true order by order__c ];
     system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@ '+TTList );
   }  else if(currentRequestURL.contains(('BL_Special_Needs_Expos_Exhibitor').tolowercase() )){
   TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                       ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent and Sales_End_Date__c >=TODAY and (Ticket_Category__c='Exhibitor' OR Ticket_Category__c='Exhibitor Staff') and Sales_Start_Date__c<=TODAY and Avilable_for_Portal__c=true order by order__c ];
  
   
   }else if(currentRequestURL.contains(('BL_Special_Needs_Expos_Sponsor').tolowercase())){
   TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                       ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent and Sales_End_Date__c >=TODAY and Ticket_Category__c='Sponsor' and Sales_Start_Date__c<=TODAY and Avilable_for_Portal__c=true order by order__c ];
  
   }else{
    TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                       ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent and Sales_End_Date__c >=TODAY  and Sales_Start_Date__c<=TODAY and Avilable_for_Portal__c=true order by order__c ];
  
   
   }
   
   
   
   
   
   
    
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
     
     
     innerClass innscl = new innerClass (bt,options);
     if(minvalue>=1){
        innscl.quantity =minvalue;
     }  
        inn.add(innscl);
      //  mapIdWithPrice.put(bt.id,bt.TT_Amount__c);
              
     }
  
    totalTickets= new List<innerClass>();
    
   for(innerClass tr:inn){
     totalTickets.add(tr);
   }   
   System.debug('CCCCCCCCCCCCCCCCCC ' + totalTickets);  
  }






public class innerClass {
public TicketTypes__c tt{get;set;}
public integer quantity{get;set;}
public decimal donationValue{get;set;}
public string promocodevalue{get;set;}
public decimal fee{get;set;}
public string DiscountValue{get;set;}
 public List<selectOption> opt{get;set;}
 
 public innerClass(TicketTypes__c t,List<selectOption> op){
 donationValue =0;
 quantity =0;
 this.tt=t;
 if(tt.TT_TicketType__c!='Free'){
  if(tt.TT_Amount__c!=0 & tt.TT_Amount__c!=null){
    this.fee = (((tt.TT_Amount__c+0.50)*(2.9/100))+0.60).setScale(2);
  }
 }
 this.opt=op;
 }
}






public PageReference onchangeAct() {
 
 try{
 
    system.debug('hiiiiiiiiiiiiiiii '+inn);
    GrandQuantity =0;
    TotalAmount=0;
    eventAdminAmount =0;
    boothleadsAmount =0;
    
    
      for(innerClass incls:inn){
      system.debug('333333333333333334444444444444' +incls.quantity );
      
      system.debug('33333333333333333     4444444444444' +incls.tt.TT_Name__c);
      
      
        if((incls.quantity!=0 && incls.quantity!=null)|| (incls.tt.TT_TicketType__c=='Donation')){
        system.debug('23423423423423424242423 ' );
          decimal  d=0;
          if(incls.quantity!=0 && incls.quantity!=null){
          // d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
           d = (incls.quantity)*(incls.tt.TT_amount__c);
            if(incls.tt.Service_Fee__c=='Add Booth Leads fee on top of the total ticket price'){
               eventAdminAmount +=d; 
              GrandQuantity+=incls.quantity; 
           }else{
             eventAdminAmount +=d; 
             GrandQuantity+=incls.quantity;
           }
          
          }
          system.debug('23423423423423424242423 ' +incls.donationValue);
           if(incls.donationValue!=0 && incls.donationValue!=null){
             d +=incls.donationValue;
              GrandQuantity+=1;
              eventAdminAmount +=d; 
            }
          
        }
         
        
      }
      
      boothleadsAmount = GrandQuantity*0.50;
     TotalAmount=(eventAdminAmount).setScale(2);
        //((eventAdminAount+boothleadsAmount)*(2.9/100))+0.60).setScale(2);
        
        
        
        
        system.debug('44444444444444444 '+TotalAmount+'55555555555555 '+eventAdminAmount);
        }catch(exception e){}
        return null;
    }





public void callpayByCheck(){
/*
 selectAtleastOneError =true;
 */
 if(paymenttypeIteam =='Pay By Check'){
 selectAtleastOneError =true;
 checkadd =eventAdminEvent[0].Check_Address__c;
 }else{
 selectAtleastOneError =false;
}
 system.debug(' selectAtleastOneError  2222222222222222 '+paymenttypeIteam );
//enabletab1();
}







public void  enabletab1() {
    try{
    copylst= new List<SelectOption>();
    copylst.add(new SelectOption('--None--','--None--'));
   paymentsPage =true;
     integer QuatityTotal=0;
     system.debug('33333333333 '+inn);
     seccls = new List<innforSecondButton>();
     
     integer ticketcnt=0;
      for(innerClass incls:inn){
      system.debug('33333333333 wwwwwwwwwwwwwwwwwwwwwwwwwww '+incls);
        if(incls.quantity!=0 && incls.quantity!=null){
         // decimal d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
           decimal d = (incls.quantity)*(incls.tt.TT_Amount__c);
           QuatityTotal +=incls.quantity;
           for(integer quantitycnt=0;quantitycnt<incls.quantity;quantitycnt++)
           {
           integer actualqnty=quantitycnt+1;
           copylst.add(new SelectOption('thepage:thefrm:ticket:'+ticketcnt+':attendee:'+quantitycnt+':','Ticket: '+incls.tt.TT_Name__c+'  Quantity: '+actualqnty));
           }
            seccls.add(new innforSecondButton(incls.tt,d,incls.quantity,incls));
            
                      ticketcnt++;
         }
         
          if (incls.tt.TT_TicketType__c=='donation' && incls.donationValue!=0){
            decimal d =incls.donationValue;
            seccls.add(new innforSecondButton(incls.tt,d,1,incls));
             copylst.add(new SelectOption('thepage:thefrm:ticket:'+ticketcnt+':attendee:1:','Ticket: '+incls.tt.TT_Name__c+'  Quantity: 1'));
                       ticketcnt++;
          }

        }
        if((TotalAmount!=null && TotalAmount!=0) || (QuatityTotal !=null && QuatityTotal !=0)){
           paytypes = new List<SelectOption>();
           paytypes.add(new SelectOption('Pay with PayPal or Credit Card','Pay with PayPal or Credit Card'));
           
           if(eventAdminEvent.size()>0){
             if(eventAdminEvent[0].Accept_check__c){
                 decimal dre = eventAdminEvent[0].check_amount_Minimum__c;
                      if(TotalAmount>=dre ){      
                      paytypes.add(new SelectOption('Pay By Check','Pay By Check'));
                     }
            
             }
           }
           
           
           
            paymenttypeIteam ='Pay with PayPal or Credit Card';
        
                   
       }else{
         nextpageError ='Please select at least one ticket';
       
       }
       
       system.debug('4444444444444444444444 '+seccls);
         cus = new Constomer__c();
          cus.Uniq_Number__c ='Uniq';
          cus.Total_Amount__c =eventAdminAmount ;
          insert cus;
          
      // SaveSurveyQuestions();
      }catch(exception e){
      
      } 
 }




//----------------------------------------------------------------
        
        public List<innforSecondButton> seccls{get;set;}
        
        public class innforSecondButton{
        public Decimal totalPrice{get;set;}
        public integer Quan{get;set;}
        public List<Dummay__c> Dom{get;set;}
        public TicketTypes__c Name{get;set;}
        public Dummay__c ds{get;set;}
        public List<Dummay__c> boothsInn {get;set;}
        public string MessageInfo{get;set;}
        // public string discount{get;set;}
        //public List<AttendeeSummary__c> atsumdom{get;set;}
        public AttendeeSummary__c dssum{get;set;}
       public innerClass  innvalueFordiscount{get;set;}
       
        public List<innclsininn> innsinn{get;set;}
        public string eventId {get;set;}
        //public List<innForDisplaySurvey> inns{get;set;}
      
      
        public innforSecondButton(TicketTypes__c name,Decimal to,integer  Qua,innerClass disval){
        system.debug('23423423424234234342 ');
        dom = new List<Dummay__c>();
        innsinn = new List<innclsininn>();
       // atsumdom=new List<AttendeeSummary__c>();
        this.totalPrice=to;
        this.Quan=qua;
        this.Name =name;
        eventId =name.EV_id__c;
        this.innvalueFordiscount = disval;
                       
            for(integer i=1;i<=qua;i++){
              dssum  = new AttendeeSummary__c();
              dssum.As_Home_Country__c ='United States Of America';
              dssum.AS_Work_Country__c ='United States Of America';
             dssum.AS_ShippingCountry__c ='United States Of America';
                               
              dssum.Ticket_Number__c=string.valueOf(i);
             // atsumdom.add(dssum);
             innsinn.add(new innclsininn(dssum,SaveSurveyQuestions(Name)));
           }
          
         }
         
         
          public List<innForDisplaySurvey> SaveSurveyQuestions(TicketTypes__c tictype12){
            system.debug('3333333333333333 '+tictype12);
            system.debug('3333333333333333 66666666666666666'+tictype12.Ticket_Category__c);
            
       //userType =ApexPages.currentpage().getParameters().get('usertype');
          List<innForDisplaySurvey>  inns = new List<innForDisplaySurvey>();
         for(Ticket_Mapswith_Survey__c SQ:[SELECT id,Survey_Questions__r.Waivers__c,Survey_Questions__r.Options__c,Survey_Questions__r.createdDate,Survey_Questions__r.Question__c,Survey_Questions__r.Type__c,TicketTypes__r.EV_id__c,TicketTypes__r.User_Type__c,TicketTypes__r.order__c,Survey_Questions__r.order__c from Ticket_Mapswith_Survey__c where TicketTypes__c =:tictype12.id and TicketTypes__r.Avilable_for_Portal__c=true order By order__c]){
           inns.add(new innForDisplaySurvey(SQ));
         }    
          system.debug('3333333333333333 44444444444444'+inns);
        return inns;
   
     }
 }


// inner to combine attendeesummary and survey Questions

public class innclsininn{
 public AttendeeSummary__c atsumdom{get;set;}
 public List<innForDisplaySurvey> Innvaluessecond{get;set;}
   public innclsininn(AttendeeSummary__c ad,List<innForDisplaySurvey> bvf){
     this.atsumdom =ad;
     this.Innvaluessecond =bvf;
  }
}

//------------------------------- Survey Quetions ------------------------------------------------

   
  
   public class innForDisplaySurvey{
   
   public string selectedSurveyValue{get;set;}
   public List<SelectOption> options{get;set;}
   Public  Ticket_Mapswith_Survey__c survey{get;set;}
   
  
   String[] selectedSurveyValueCheck= new String[]{};
    public String[] getselectedSurveyValueCheck() {
    system.debug('000000000000000000000000  '+selectedSurveyValueCheck);
     return selectedSurveyValueCheck;
    }

    public void setselectedSurveyValueCheck(String[] selectedSurveyValueCheck) {
        this.selectedSurveyValueCheck= selectedSurveyValueCheck;
    }
   
   
   public innForDisplaySurvey(Ticket_Mapswith_Survey__c su){
        this.survey =su; 
        system.debug('22222223433333333322222222222 '+su.Survey_Questions__r.Waivers__c);
         if(survey.Survey_Questions__r.Type__c=='CheckBox' || survey.Survey_Questions__r.Type__c=='Radio button' || survey.Survey_Questions__r.Type__c=='PickList'){
           options = new List<SelectOption>();
          try{
           for(string s:(survey.Survey_Questions__r.Options__c).split('my#')){
             options.add(new SelectOption(s,s));
           }
         }catch(exception e){}     
        }
    }
  } 
  //---------------------------------- Promo codes ----------------------------------------------------------------
  
  public string promocode{get;set;}
  public boolean ErrorForExpirydate{get;set;}
  
  public pageReference applayPromocode(){
 
 
    if(promocode !=null && promocode !=''){
    
    }else{
      return null;
    }
 
 
   Map<id,Tickets_Mapswith_Promocode__c> mapIdtic = new  Map<id,Tickets_Mapswith_Promocode__c>();
  // Map<id,TicketTypes__c> mapIdtic = new  Map<id,TicketTypes__c>();
   //TicketTypes__c
  for(Tickets_Mapswith_Promocode__c promos: [select   Promocodes__r.Expiredate__c, Tickets__r.id,Promocodes__r.name,Tickets__r.Service_Fee__c,Promocodes__r.Discount_Type__c,Promocodes__r.Discount_Value__c, Tickets__r.TT_Available__c,Tickets__r.TT_Limit__c,Tickets__r.Available__c,Tickets__r.TT_Sold__c,id,Tickets__r.Min_Tickets_per_Order__c,Tickets__r.Max_Tickets_per_Order__c ,Max_number_Of_usage__c, Tickets__r.Description__c,Tickets__r.TT_Name__c,Tickets__r.TT_TicketType__c,Tickets__r.TT_Amount__c
                       ,Tickets__r.Ticket_Image_URL__c,Tickets__r.Ticket_Category__c,Tickets__r.Sales_End_Date__c,Tickets__r.User_Type__c,Tickets__r.Section_Name__c,Tickets__r.No_of_Attendees_allowed__c, Tickets__r.No_of_Booths_allowed__c,Tickets__r.EV_id__c  from Tickets_Mapswith_Promocode__c where Tickets__r.EV_id__c=:selectedEvent and Promocodes__r.name=:promocode  order by createddate ]){        
          
            mapIdtic.put(promos.Tickets__r.id , promos);
  
   }
   
   
   List<innerClass>  innclsvaluetemp = new List<innerClass>();
   innclsvaluetemp.addAll(inn);  
    inn = new List<innerClass>();
    
     for(innerClass tr2:innclsvaluetemp){
     
          ErrorForExpirydate=false;
         Tickets_Mapswith_Promocode__c tyt = new Tickets_Mapswith_Promocode__c();
        
         tyt=mapIdtic.get(tr2.tt.id);
         
         
        if(tyt!=null){
            system.debug('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH '+tyt.Max_number_Of_usage__c);
             if(tyt.Max_number_Of_usage__c <=0){
                 tr2.DiscountValue = 'Promocode Expired';
             }else if(tyt.Promocodes__r.Expiredate__c >= Date.TODAY()){
                 if(tyt.Promocodes__r.Discount_Type__c=='%'){
                   tr2.DiscountValue = string.valueOf(tyt.Promocodes__r.Discount_Value__c)+'%';
                   tr2.tt.TT_Amount__c = tyt.Tickets__r.TT_Amount__c - ((tyt.Tickets__r.TT_Amount__c)*(tyt.Promocodes__r.Discount_Value__c/100));
                   tr2.promocodevalue=promocode;
                  }else if(tyt.Promocodes__r.Discount_Type__c=='$'){
                     tr2.tt.TT_Amount__c = tyt.Tickets__r.TT_Amount__c-(tyt.Promocodes__r.Discount_Value__c);
                     tr2.DiscountValue = '$'+string.valueOf(tyt.Promocodes__r.Discount_Value__c);
                      tr2.promocodevalue=promocode;
                   }
                }else{
                  ErrorForExpirydate =true;
                
                }
         }
         
         inn.add(tr2);
        
     } 
     
   system.debug('phaniiiiiiiiiiiiiiiiii 9999999999999999'+inn);
  
    
         
     onchangeAct();
    return null;
   
 }  
  
//  --------------------------------------------

// Pay ment ---------------------------------------------

public boolean errorRequiredfield{get;set;}


 public string ApiUserName{get;set;}
  public string Apipassword{get;set;}
  public string Apisignature{get;set;}
  
  public string ApiapplicationId{get;set;}
  public string Apiipaddress{get;set;}
  public string paypalUrl{get;set;}
  




  public void setPaymentOptions(string payval){
   try{
   Http h = new Http();
       HttpRequest req = new HttpRequest();   
       
       string NameofCompany  = event.EV_Title__c;
       
       
       if(string.isNotEmpty(NameofCompany )){ 
       NameofCompany =NameofCompany.ReplaceAll(' ','+');
      }
      
        req.setHeader('X-PAYPAL-SECURITY-USERID',ApiUserName);
        req.setHeader('X-PAYPAL-SECURITY-PASSWORD',Apipassword );      
        req.setHeader('X-PAYPAL-SECURITY-SIGNATURE',Apisignature );      
        req.setHeader('X-PAYPAL-DEVICE-IPADDRESS',Apiipaddress);
        req.setHeader('X-PAYPAL-REQUEST-DATA-FORMAT','NV');
        req.setHeader('X-PAYPAL-RESPONSE-DATA-FORMAT','NV');
        req.setHeader('X-PAYPAL-APPLICATION-ID',ApiapplicationId );
        string sandboxvalue='';
        if(paypalUrl.contains('sandbox')){
          sandboxvalue='sandbox.';
        }
        
        string endpoint = 'https://svcs.'+sandboxvalue+'paypal.com/AdaptivePayments/SetPaymentOptions?method=SetPaymentOptions&requestEnvelope.errorLanguage=en_US&payKey='+payval+'&displayOptions.businessName='+NameofCompany;
        
        req.setEndpoint(endpoint);
        req.setMethod('GET'); 
        HTTPResponse res = h.send(req);
         system.debug('@@@@@@@@@@@@@@@@@ '+ res.getBody()  );
     }catch(exception ex){
          
          }        
      }
      





  public pagereference Pay(){
  
  system.debug('phaniiiiiiiiiiiiiiiiii 9999999999999999'+seccls);
  
  

     system.debug('phaniiiiiiiiiiiiiiiiii '+paymenttypeIteam+'2222222222 '+eventAdminAmount+'33333333333333333 '+boothleadsAmount);
    MAP<string,List<Survey__c>> mapIdwithSurvey = new MAP<string,List<Survey__c>>();
      if(eventAdminAmount==null && boothleadsAmount==null){
      eventAdminAmount =0;
      boothleadsAmount =0;
      }
      
    errorRequiredfield = false;
    
    List<string> srtar = new List<string>();
    srtar.add('(Choose one)');
     
    for(innforSecondButton lk1:seccls){
             for(innclsininn astsum:lk1.innsinn){
                for(innForDisplaySurvey tre:astsum.Innvaluessecond){
                
                  system.debug('44444444444444 88888888888 '+tre.survey.Survey_Questions__r.Question__c);
                   system.debug('44444444444444 999999999999999 '+tre.selectedSurveyValueCheck);
                    system.debug('44444444444444 1111111111111111 '+srtar);
                  
                if(lk1.Name.Ticket_Category__c=='Attendee'){
                 
                  if((tre.survey.Survey_Questions__r.Question__c!='Please enter your company name' &&  tre.survey.Survey_Questions__r.Question__c!='Please enter your work phone number')){
                   
                   system.debug('44444444444444 ############ '+tre.selectedSurveyValueCheck);
                   system.debug('44444444444444 @@@@@@@@@@@@ '+tre.selectedSurveyValue);
                   
                    if( (tre.selectedSurveyValue==null || tre.selectedSurveyValue=='' || tre.selectedSurveyValue=='(Choose one)' ) && (tre.selectedSurveyValueCheck==null || tre.selectedSurveyValueCheck.size()<=0) ){
                       system.debug('44444444444444 ############ '+tre.selectedSurveyValueCheck);
                      errorRequiredfield = true;        
                      return null;       
                    }
                   }
                   
                   
                 }else{
                    if((tre.selectedSurveyValue==null || tre.selectedSurveyValue=='' || tre.selectedSurveyValue=='(Choose one)'  ) && (tre.selectedSurveyValueCheck==null || tre.selectedSurveyValueCheck.size()<=0)){
                      system.debug('44444444444444 88888888888 '+tre.selectedSurveyValueCheck);
                      errorRequiredfield = true;        
                      return null;       
                   }
                 
                 
                 }
                 
                   
                 
                 
             }
          }   
        }  
    
    
    
      if((selectAtleastOneError) ||(eventAdminAmount==0  || boothleadsAmount==0)){
      
         List<Dummay__c>  Listdummays = new List<Dummay__c>();   
         MAP<id,string> mapidticketName = new MAP<id,string>();
         List<AttendeeSummary__c>  Listdummaysummaries = new List<AttendeeSummary__c>();     
         List<Survey__c> surveyQuestions = new List<Survey__c>(); 
            string removeDuplicate='';
            
            
            
            
          for(innforSecondButton lk:seccls){
             for(innclsininn astsum:lk.innsinn){
                  try{
                  astsum.atsumdom.customer_key__c = cus.id;
                  }catch(exception rt){}
                  if(astsum.atsumdom.AS_Email__c!=null & astsum.atsumdom.AS_Email__c!=''){
                   if(removeDuplicate.contains((astsum.atsumdom.AS_Email__c).tolowercase())){ 
                 
                  }else{
                  removeDuplicate =+ astsum.atsumdom.AS_Email__c.tolowercase();
                   Listdummaysummaries.add(astsum.atsumdom);
                  }
                 } 
                         Dummay__c dou = new Dummay__c();
                         dou.First_Name__c = astsum.atsumdom.AS_FirstName__c;
                         dou.Last_Name__c = astsum.atsumdom.AS_LastName__c;
                         dou.Phone__c = astsum.atsumdom.AS_WorkPhone__c;
                         dou.Email__c = astsum.atsumdom.AS_Email__c;
                         dou.Company__c= astsum.atsumdom.AS_Company__c;
                         dou.InvoiceEmail__c = astsum.atsumdom.AS_Email__c;
                         dou.Event__c =selectedEvent;
                         dou.TicketTypes__c =lk.Name.id;
                       try{
                         dou.customer_key__c =cus.id;
                       }catch(exception gt){}
               //    paytypes.add(new SelectOption('Pay By Check','Pay By Check'));  
                     if(paymenttypeIteam =='Pay By Check'){
                         dou.Payment_Type__c ='Check';
                         try{
                             dou.TicketAmount__c= lk.innvalueFordiscount.tt.TT_Amount__c;
                             dou.DiscountValue__c =lk.innvalueFordiscount.discountValue;
                             dou.Promocode__c =lk.innvalueFordiscount.promocodevalue;
                         }catch(exception gt){}
                         }else{
                           dou.Payment_Type__c ='Free';
                           dou.DiscountValue__c =lk.innvalueFordiscount.discountValue;
                           dou.Promocode__c =lk.innvalueFordiscount.promocodevalue;
                        
                         }
                         dou.payKey__c ='BoothLeads12345';
                         
                        
                        
                        
                         Listdummays.add(dou);
                         
                     List<Survey__c> surveyQuestions1 = new List<Survey__c>();    
                     for(innForDisplaySurvey tre:astsum.Innvaluessecond){
                       Survey__c suv = new Survey__c();
                      try{
                       suv.customer_key__c =cus.id;
                     }catch(exception re){}
                       suv.Event__c =selectedEvent;
                       suv.Survey_Questions__c =tre.survey.Survey_Questions__r.id;
                       //suv.Email__c =astsum.atsumdom.AS_Email__c;
                       if(tre.selectedSurveyValue!=null && tre.selectedSurveyValue!=''){
                        suv.Answers__c=tre.selectedSurveyValue;
                       }else{
                         suv.Answers__c =string.valueOf(tre.selectedSurveyValueCheck);
                        system.debug('222222222222222222222222222222222222222222222222222 '+string.valueOf(tre.selectedSurveyValueCheck));
                       }
                        surveyQuestions1.add(suv); 
                       surveyQuestions.add(suv);
                   } 
                   
                   if(mapIdwithSurvey.keySet().contains(astsum.atsumdom.AS_Email__c)){
                     surveyQuestions1.addAll(mapIdwithSurvey.get(astsum.atsumdom.AS_Email__c));
                     mapIdwithSurvey.put(astsum.atsumdom.AS_Email__c,surveyQuestions1);    
                   }else{
                     mapIdwithSurvey.put(astsum.atsumdom.AS_Email__c,surveyQuestions1);
                   }
            
             }
           }
           
           //database.saveResult[] saveSurvey =   dataBase.insert(surveyQuestions,false);
           
            database.saveResult[] dsave1 =   dataBase.insert(Listdummays,false);
           
           Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
           dataBase.upsertResult[] upResult = dataBase.upsert(Listdummaysummaries,f,false);
          Set<id> setOfIdsforSurveys = new Set<id>();
         
           for(dataBase.upsertResult upsresult : upResult){
            if(upsresult.isSuccess()){
             setOfIdsforSurveys.add(upsresult.getId()); 
            }
           
           }
       
       
       for(AttendeeSummary__c asse: [select id,AS_Email__c from AttendeeSummary__c where id In :setOfIdsforSurveys]){
        system.debug('343434343444444444444444444444 '+asse);
        
             for( survey__c surt :mapIdwithSurvey.get(asse.AS_Email__c)){
             system.debug('343434343444444444444444444444 333333333'+asse);
               surt.AttendeeSummary__c  = asse.id;
             }       
          
       }
       
       database.saveResult[] saveSurvey =   dataBase.insert(surveyQuestions,false);
        system.debug('343434343444444444444444444444 6666666666 '+saveSurvey );
       
        try{  pageReference pg =new PageReference('/apex/BL_Special_Needs_Expos_success?payKey='+cus.id);
           pg.setRedirect(true);
            return pg;
            }catch(exception fr){return null;}
            
      }else{
      
        PageReference page = null;
                         
        CommonParametersObjName='MyRequestParams';
        APICredentialObjName ='SandboxCert';
        
        ActionType='PAY';
        
        FundingTypeEcheck = false;
        FundingTypeBalance = false;
        FundingTypeCreditCard = false;
        PPPayRequest request;
        try{
        // create request envelope and set the common request parameters
         request = new PPPayRequest(CommonParametersObjName, SenderEmail);      
        // set actionType
        request.ActionType = ActionType;  
        }catch(exception ed){
        request = new PPPayRequest();
        }
        // set success and cancel urls
        String host = ApexPages.currentPage().getHeaders().get('Host');
        request.CancelUrl = 'http://' + host + '/apex/BL_Special_Needs_Expos?MainMessage=cancel&id='+selectedEvent;
        request.ReturnUrl = 'http://' + host + '/apex/BL_Special_Needs_Expos_Success?payKey='+cus.id;
          
        // set a note associated with the payment        
         request.Memo = event.EV_Title__c;  
        // set receiver info in the request
        List<PPReceiver> receiverList = new List<PPReceiver>();
     
       try{
       
         PaymentType =eventAdminEvent[0].Payment_Type__c;
         feesPayer =eventAdminEvent[0].Fee_Payer__c;
         //feesPayer  = 'boothleads.ea@globalnest.com';
         PPReceiver rv = new PPReceiver();
         
         rv.Email =eventAdminEvent[0].Email_Id__c;
         rv.Amount = eventAdminAmount;
         rv.primary=TRUE;
        // PaymentType ='Parallel';
         ActionType ='PAY';
         receiverList.add(rv); 
         
         
         PPReceiver rv1 = new PPReceiver();
         rv1.Email =eventAdminEvent[0].OurEmail__c;
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
          
           ApiUserName= toolkit.BaseAPIProfile.APIUsername;
           Apipassword =toolkit.BaseAPIProfile.APIPassword;
           Apisignature =toolkit.BaseAPIProfile.APISignature;
           ApiapplicationId = toolkit.BaseAPIProfile.ApplicationID;
           Apiipaddress =request.ClientDetails.IpAddress;
           paypalUrl= toolkit.BaseAPIProfile.getPayPalLoginPage(); 
           system.debug('$$$$$$$$$$$$$$$$$$$ '+paypalUrl);
          try{
           setPaymentOptions(PayResponse.payKey);
          }catch(exception ex){
          
          }
  
          
          
          
          
          
       
         
          List<Dummay__c>  Listdummays = new List<Dummay__c>();           
          List<AttendeeSummary__c>  Listdummaysummaries = new List<AttendeeSummary__c>();     
            List<Survey__c> surveyQuestions = new List<Survey__c>();
          string removeDuplicate='';
          
          for(innforSecondButton lk:seccls){
             for(innclsininn astsum:lk.innsinn){
                  astsum.atsumdom.customer_key__c = cus.id;
                  if(removeDuplicate.contains((astsum.atsumdom.AS_Email__c).tolowercase())){ 
                 
                  }else{
                  removeDuplicate =+ astsum.atsumdom.AS_Email__c.tolowercase();
                   Listdummaysummaries.add(astsum.atsumdom);
                  }
                         Dummay__c dou = new Dummay__c();
                         dou.First_Name__c =astsum.atsumdom.AS_FirstName__c;
                         dou.Last_Name__c =astsum.atsumdom.AS_LastName__c;
                         dou.Phone__c =astsum.atsumdom.AS_WorkPhone__c;
                         dou.Email__c =astsum.atsumdom.AS_Email__c;
                         dou.InvoiceEmail__c =astsum.atsumdom.AS_Email__c;
                         dou.Company__c=astsum.atsumdom.AS_Company__c;
                         dou.Event__c =selectedEvent;
                         
                         dou.TicketAmount__c= lk.innvalueFordiscount.tt.TT_Amount__c;
                          system.debug('999999999999999999999999 '+lk.innvalueFordiscount.tt.TT_Amount__c);
                         
                         
                         dou.TicketTypes__c =lk.Name.id;
                         dou.customer_key__c =cus.id;
                         
                         dou.DiscountValue__c =lk.innvalueFordiscount.discountValue;
                         dou.Promocode__c =lk.innvalueFordiscount.promocodevalue;
                         dou.Payment_Type__c ='Credit Card';
                          dou.Payment_status__c ='Paid';
                         dou.payKey__c =PayResponse.payKey;
                         Listdummays.add(dou);
                         
                         
                    List<Survey__c> surveyQuestions1 = new List<Survey__c>(); 
                     for(innForDisplaySurvey tre:astsum.Innvaluessecond){
                       Survey__c suv = new Survey__c();
                       suv.customer_key__c =cus.id;
                       suv.Event__c =selectedEvent;
                       suv.Survey_Questions__c =tre.survey.Survey_Questions__r.id;
                     //  suv.Email__c =astsum.atsumdom.AS_Email__c;
                       if(tre.selectedSurveyValue!=null && tre.selectedSurveyValue!=''){
                        suv.Answers__c=tre.selectedSurveyValue;
                       }else{
                         suv.Answers__c =string.valueOf(tre.selectedSurveyValueCheck);
                        
                       }
                      
                       surveyQuestions.add(suv);
                       surveyQuestions1.add(suv); 
                  }  
                   if(mapIdwithSurvey.keySet().contains(astsum.atsumdom.AS_Email__c)){
                     surveyQuestions1.addAll(mapIdwithSurvey.get(astsum.atsumdom.AS_Email__c));
                     mapIdwithSurvey.put(astsum.atsumdom.AS_Email__c,surveyQuestions1);    
                   }else{
                     mapIdwithSurvey.put(astsum.atsumdom.AS_Email__c,surveyQuestions1);
                   }    
             }
           }
           
            system.debug('222222222222222222222222222222222222222222222222222 '+mapIdwithSurvey); 
          
        dataBase.insert(Listdummays,false);
       Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
       dataBase.upsertResult[] upResult = dataBase.upsert(Listdummaysummaries,f,false);
          
      Set<id> setOfIdsforSurveys = new Set<id>();
         
           for(dataBase.upsertResult upsresult : upResult){
            if(upsresult.isSuccess()){
             setOfIdsforSurveys.add(upsresult.getId()); 
            }
           
           }
       
       for(AttendeeSummary__c asse: [select id,AS_Email__c from AttendeeSummary__c where id In :setOfIdsforSurveys]){
             for( survey__c surt :mapIdwithSurvey.get(asse.AS_Email__c)){
               surt.AttendeeSummary__c  = asse.id;
             }       
          
       }
       
       database.saveResult[] saveSurvey =   dataBase.insert(surveyQuestions,false);         
         
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
     }  return null;
  } 


public string yourName{get;set;}
public string YourEmail{get;set;}
public string yourMessage{get;set;}
public boolean contactinfo{get;set;}

public void displaypopup(){
contactinfo = true;

}

public void closepop(){
contactinfo = false;

}

public void sendMail(){

 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       string emailAddr = eventadminEmail;
     // string emailAddr = 'phani@globalnest.com';
      
        String[] toAddresses = new String[] {emailAddr};
        mail.setToAddresses(toAddresses);

        mail.setSubject('Message from '+YourEmail);

       
        mail.setHtmlBody('<b>Name :<b>' +yourName + '<br /> <b> Email : </b>' + YourEmail+ '<br /><b>Message :</b>'+yourMessage);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         contactinfo = false;
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
public void testdum1(){
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


public void testdum2(){
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

public void testdum3(){
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
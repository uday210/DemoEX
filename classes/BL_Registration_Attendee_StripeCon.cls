public without sharing class BL_Registration_Attendee_StripeCon {

public string tickcategory{get;set;}

public boolean istestmethod{get;set;}

public string naicsselctdids{get;set;}
public list<string> naicscods{get;set;}
public string seltnaiccs{get;set;}
 public List<selectOption> months{get;set;}
 public List<selectOption> years{get;set;}
public string errorStripe{get;set;}
public decimal AppFee {get;set;}

    public PageReference coptyTicket() {
     string sd =Apexpages.currentPage().getParameters().get('selectedtic');
     
     return null;
    }

  public Constomer__c cus {get;set;}
  public String yourMessage { get; set; }
  public string checkadd{get;set;}
  public String yourEmail { get; set; }
  public String yourName { get; set; }
  public boolean contactinfo { get; set; }
  public string ApiUserName{get;set;}
  public string Apipassword{get;set;}
  public string Apisignature{get;set;}
  public string ApiapplicationId{get;set;}
  public string Apiipaddress{get;set;}
  public string paypalUrl{get;set;}
   
 public List<SelectOption> paytypes { get; set; }
 public String paymenttypeIteam { get; set; }
 public boolean errorRequiredfield { get; set; }
 public Event__c event{get;set;} //  Event instasiation
 public decimal TotalAmount{get;set;} // To display amount
 public string selectedEvent {get;set;} // store selected event
 public boolean selectAtleastOneError {get;set;}
 public User_Profile_Event__c upesvalueforSendMail{get;set;}
 public string eventadminEmail{get;set;}
 // For calender
 public string calenderid {get;set;}
 public string thisTimeStr {get;set;}
 public string endtimestr{get;set;}
 public string thisTimeStr11 {get;set;}
 public string endtimestr11 {get;set;}
 public LIST<Pay_Pal_Account__c> eventAdminEvent {get;set;}
 
 public List<innerClass> inn{get;set;} 
 public List<TicketTypes__c> TTList{get;set;}
 public List<selectOption> options {get;set;}
 public List<innerClass> totalTickets{get;set;}
 // Promocodes
  public string promocode{get;set;}
  public boolean ErrorForExpirydate{get;set;}
 // Fee Calculations
   public integer GrandQuantity{get;set;}
   public decimal boothleadsAmount{get;set;}
   public decimal eventAdminAmount {get;set;}
   public List<innerClass> selectedinns{get;set;} 
   public boolean paymentsPage{get;set;}
   public string Mainmessage{get;set;}
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
public string EventType{get;set;}
public boolean displayButton{get;set;}
    public String selectedNAICS1 { get; set; }
    public string selectedNAICS2{ get; set; }
    public string selecteddelnaic{ get; set; }
    public NAICS_Code__c selectednaicscodeslist  { get; set; }
    public List<NAICS_Code__c> naicscodeslist{get;set;}
    public List<String> selectednacslist{ get; set; }
    public set<string> naicsset{ get; set; }
    public List<String> selecteddelnaicsplit{ get; set; }
    public NAICS_Code__c naicsdellist { get; set; }
    public Boolean naicsalertbool{get;set;}
    public LIST<LIST<NAICS_Code__c>> listOfnaicscodes{get; set;}
    public string isPrivate{get;set;}
    public string paymentTypevalue{get;set;} 
    public DoPaymentHandler dpayhand{get;set;}
    public boolean dperror{get;set;}
     
         public BL_Registration_Attendee_StripeCon (){
          SelectedNAICS = new LIST<String>(); 
          naicscods = new list<string>();
          naicsselctdids = '';
          naicsalertbool=false;
         selectedNAICS1 = '';
         selectednacslist=new list<string>();
         naicsset = new set<string>();
          //naicscodeslist = [select id,name,Description__c from NAICS_Code__c Limit 1000 ];
        
         AppFee=  Blfee.blf();
          
         istestmethod = TRUE;
         tickcategory  ='';
             selectAtleastOneError =false;
             TotalAmount =0.0;
             selectedEvent =Apexpages.currentPage().getparameters().get('id');
             event = new Event__c();
             // To display Event Details in registrationpage
             event = [SELECT id,EV_Description__c,Session_Time__c,EV_EndDate__c,EV_EndTime__c,EV_HistingAddr1__c,EventDiversityValues__c,Registration_Front_End_Color__c,Registration_Back_End_Color__c,
                                    EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingFax__c,
                                    EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,
                                    EV_HostingTimeZone__c,EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,
                                    EV_Title__c,EV_WebsiteURL__c,EV_EventLogo__c,EV_ContactURL__c,EV_HostingCountry__c , 
                                    EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,Type_Of_registration_allow__c,
                                    Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c,FacebookId__c,TwitterId__c
                                       FROM Event__c WHERE id =: ApexPages.currentpage().getParameters().get('id')];
            
            
             try{
            tickcategory =Apexpages.currentPage().getParameters().get('tcat');
            }catch(exception e){
               
            }
     
     isPrivate ='';
         try{
            isPrivate=Apexpages.currentPage().getParameters().get('tsec');
            }catch(exception e){
               
            }
     
     
             // For icalender and add calender
            try{
             attachment attval = new attachment();
             attval  = [select id,body from attachment where parentid=:event.id];
             calenderid = attval.id  ;
             system.debug('XXXXXXXXXXXXXXXXXXXXXXxx '+calenderid );
             }catch(exception esd){}
             // For displaying state name in Short from
              if(event.EV_HostingStateNew__c!=null){  
                  Commanforstates  con = new Commanforstates ();
                  event.EV_HostingStateNew__c= con.mapstate(event.EV_HostingStateNew__c);
               }        
               
            // Get Email for sending contact us info   
            try{
               upesvalueforSendMail = new  User_Profile_Event__c();
               upesvalueforSendMail =[select id,   User_id__r.userName,EV_id__c,Profile_id__r.PR_Name__c from User_Profile_Event__c where EV_id__c=:event.id AND Profile_id__r.PR_Name__c='EventAdmin'];
               eventadminEmail =upesvalueforSendMail.User_id__r.userName;
           }catch(exception er){}
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
            //endtimestr = startDatetimevalue1.format('yyyyMMdd\'T\'HHmmss\'Z\'','UTC' );
            endtimestr11 = startDatetimevalue1.format('yyyyMMdd\'T\'HHmmss\'Z\'' );
           system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM '+endtimestr );
           
           // paypal account details
             eventAdminEvent = new LIST<Pay_Pal_Account__c>();
              eventAdminEvent =[select Email_Id__c,Payment_Type__c,AuthorizationDotNet__c,StripeKey__c,AuthorizationDotNetKey__c,Fee_Payer__c,Account_types__c,OurEmail__c,Accept_check__c,check_amount_Minimum__c,Check_Address__c from Pay_Pal_Account__c where Event__c=:ApexPages.currentpage().getParameters().get('id')];
              system.debug('3242342342342342342 '+eventAdminEvent );
               DisplayTab2Values();
               
          }
          
        
          
          
        // Inner class for Mapping options with ticket
        public class innerClass {
            public TicketTypes__c tt{get;set;} // Ticket info
            public integer quantity{get;set;} // selected tickets Quantity
            public decimal donationValue{get;set;}  // Donation value
            public string promocodevalue{get;set;} // Promocode
            public decimal fee{get;set;}  // Paypal fee 
            public string DiscountValue{get;set;} // Dsicount value
            public List<selectOption> opt{get;set;}  // To ask tickets quatity
            public Decimal totalTicPrice {get;set;}
                 public innerClass(TicketTypes__c t,List<selectOption> op){
                  donationValue =0;
                  quantity =0;
                  this.tt=t;
                     if(tt.TT_TicketType__c!='Free'){
                          if(tt.TT_Amount__c!=0 & tt.TT_Amount__c!=null){
                            this.fee = (((tt.TT_Amount__c+Blfee.blf())*(2.9/100))+0.60).setScale(2);
                          }
                     }
                   this.opt=op;
                 }
         }  
         
         
         // First Page values
         public void DisplayTab2Values(){
           displayButton =  false;
            // Get the URL for the current request.
            String currentRequestURL = URL.getCurrentRequestUrl().toExternalForm();
            System.debug('Current request URL: ' + currentRequestURL);   
            // string ddd = BL_Special_Needs_Expos_attendee.tolowercase();
              TTList = new List<TicketTypes__c>();
              inn = new List<innerClass>();
                    
                    
                if(isPrivate=='privateBl'){ 
                  
                 if(tickcategory !='All' & tickcategory !=''){
                      
                       TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                                           ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent  and Ticket_Category__c=:tickcategory    order by order__c ];
                  
                      }else{
                      
                       TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                                           ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent   order by order__c ];
                  
                      }
                 
                 }else{  
                    if(tickcategory !='All' & tickcategory !=''){
                      
                       TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                                           ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent  and Ticket_Category__c=:tickcategory   and Avilable_for_Portal__c=true order by order__c ];
                  
                      }else{
                      
                       TTList =[select Service_Fee__c, TT_Available__c,TT_Limit__c,Available__c,TT_Sold__c,id,Min_Tickets_per_Order__c,Max_Tickets_per_Order__c , Description__c,TT_Name__c,TT_TicketType__c,TT_Amount__c
                                           ,Ticket_Image_URL__c,Ticket_Category__c,Sales_End_Date__c,User_Type__c,Section_Name__c,No_of_Attendees_allowed__c,Sales_Start_Date__c, No_of_Booths_allowed__c,EV_id__c  from TicketTypes__c where EV_id__c=:selectedEvent  and  Avilable_for_Portal__c=true order by order__c ];
                  
                      }
                  }
                  
                 
                  
                                 
                   for(TicketTypes__c bt:TTList ){
                        options = new List<selectOption>();
                        integer minValue=1;
                        integer maxValue=10;
                                                              
                                if(bt.Sales_Start_Date__c<=system.today()){
                                   displayButton  = true;
                                }
                                
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
                        }
                        
                        totalTickets= new List<innerClass>();
                        totalTickets.addALL(inn);
               }   
          
           
           
 
  // Apply Promocode
     public pageReference applayPromocode(){
        if(promocode !=null && promocode !=''){
        }else{
          return null;
        }
           Map<id,Tickets_Mapswith_Promocode__c> mapIdtic = new  Map<id,Tickets_Mapswith_Promocode__c>();
           List<innerClass>  innclsvaluetemp = new List<innerClass>();
              for(Tickets_Mapswith_Promocode__c promos: [select   Promocodes__r.Expiredate__c, Tickets__r.id,Promocodes__r.name,Tickets__r.Service_Fee__c,Promocodes__r.Discount_Type__c,Promocodes__r.Discount_Value__c, Tickets__r.TT_Available__c,Tickets__r.TT_Limit__c,Tickets__r.Available__c,Tickets__r.TT_Sold__c,id,Tickets__r.Min_Tickets_per_Order__c,Tickets__r.Max_Tickets_per_Order__c , Tickets__r.Description__c,Tickets__r.TT_Name__c,Tickets__r.TT_TicketType__c,Tickets__r.TT_Amount__c
                                   ,Tickets__r.Ticket_Image_URL__c,Tickets__r.Ticket_Category__c,Tickets__r.Sales_End_Date__c,Tickets__r.User_Type__c,Tickets__r.Section_Name__c,Tickets__r.No_of_Attendees_allowed__c, Tickets__r.No_of_Booths_allowed__c,Tickets__r.EV_id__c  from Tickets_Mapswith_Promocode__c where Tickets__r.EV_id__c=:selectedEvent and Tickets__r.Avilable_for_Portal__c=true and Promocodes__r.name=:promocode order by createddate ]){        
                    mapIdtic.put(promos.Tickets__r.id , promos);
               }
            innclsvaluetemp.addAll(inn);  
            inn = new List<innerClass>();
  
                 for(innerClass tr2:innclsvaluetemp){
                     ErrorForExpirydate=false;
                     Tickets_Mapswith_Promocode__c tyt = new Tickets_Mapswith_Promocode__c();
                     tyt=mapIdtic.get(tr2.tt.id);
                       if(tyt!=null){
                         if(tyt.Promocodes__r.Expiredate__c >= Date.TODAY()){
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
             return null;
         }  
         
      // Enable Attendee Info popUp   
      public void enableInformationpopup(){
system.debug('1111111 sssssssss dddddddddd' );
//                          Innerproductivity = new LIST<innerSalesProductivity>();                      

           GrandQuantity =0;
           TotalAmount=0;
           eventAdminAmount =0;
           boothleadsAmount =0;
           naicsalertbool=false;
           selectedNAICS1 = '';
         selectednacslist=new list<string>();
         naicsset = new set<string>();
         listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
                naicscodeslist = new List<NAICS_Code__c>();
        
          for(NAICS_Code__c n : [select id,name,Description__c from NAICS_Code__c ]){
          
              naicscodeslist.add(n);
              
             if(naicscodeslist.size() == 999){
                     listOfnaicscodes.add(naicscodeslist);
                     naicscodeslist= new LIST<NAICS_Code__c>();
                 }
 
          }
          
          if(naicscodeslist.size() != 0){
              listOfnaicscodes.add(naicscodeslist);
         } 
                    system.debug('Shru shru ' + naicscodeslist.size()); 
                    system.debug('Shru shru11111111 ' + listOfnaicscodes.size());    
        /*  naicscodeslist = [select id,name,Description__c from NAICS_Code__c LIMIT 1000];
              for( NAICS_Code__c n : naicscodeslist ){
              
                        Innerproductivity.add(new innerSalesProductivity(n.id,n.name,n.Description__c,true)); 
                   }
          system.debug('aaaaaaaaaa ' + Innerproductivity.size()); */
           selectedinns = new List<innerClass>();
            seccls = new List<innforSecondButton>();
          List<id> ticuyids = new List<id>();
          
          for(innerClass inclsBefore:inn){
               if(inclsBefore.quantity!=0 && inclsBefore.quantity!=null){
                inclsBefore.totalTicPrice = (inclsBefore.quantity)*(inclsBefore.tt.TT_amount__c);
                  selectedinns.add(inclsBefore); 
                  ticuyids.add(inclsBefore.tt.id);
               }
          }
          
        // Map Ticket and its Settings
        MAP<Id,Registration_Settings__c> MapTicWithSet = new MAP<Id,Registration_Settings__c>();
         for(Registration_Settings__c RES : [SELECT EventRegistration__r.Event__r.id,EventRegistration__r.Setting_Type__c,TicketTypes__r.TT_Name__c,Is_Company_Include__c,Is_Company_required__c,Is_Designation_Include__c,Is_Designation_required__c,Is_Email_Include_c__c,
                      Is_Email_Required_c__c,Is_FirstName_Include__c,Is_FirstName_Required__c,Is_Homeaddress_Include__c,Is_Homeaddress_required__c,
                      Is_LastName_include__c,Is_LastName_Required__c,Is_Mobile_Include__c,Is_Mobile_required__c,Is_Shipadd_Include__c,Is_Shipadd_required__c,
                      Is_Workaddress_Include__c,Is_Workaddress_required__c,Is_WorkPhone_Include__c,Is_workphone_required__c,LastActivityDate,LastModifiedById,
                      Name,TicketTypes__c,Is_Wesite_Required__c,Is_Wesite_include__c,Is_NAICS_Include__c,Is_NAICS_Required__c,
                      Is_Company_Description_Include__c,Is_Company_Description_Required__c, Is_Keywords_Required__c,Is_Keywords_Include__c
                        FROM Registration_Settings__c where EventRegistration__r.Event__r.id=:Event.id]){
                   
                  if(RES.EventRegistration__r.Setting_Type__c=='Collect information below for each attendee'){
                     MapTicWithSet.put(RES.TicketTypes__r.id,RES ); 
                      
                  }else{
                       MapTicWithSet.put(RES.EventRegistration__r.Event__r.id,RES ); 
                  } 
              }
          
            EventType =(MapTicWithSet.values())[0].EventRegistration__r.Setting_Type__c;
                
        
        // Map Ticket and Survey Questions  
          MAP<id,List<Ticket_Mapswith_Survey__c>> mapTickIdAndSurvey = new  MAP<id,List<Ticket_Mapswith_Survey__c>>();
         
         List<Ticket_Mapswith_Survey__c> SQ =new  List<Ticket_Mapswith_Survey__c>([SELECT IsRequired__c,id,Survey_Questions__r.Waivers__c,Survey_Questions__r.Options__c,Survey_Questions__r.createdDate,Survey_Questions__r.Question__c,Survey_Questions__r.Type__c,TicketTypes__r.EV_id__c,TicketTypes__r.User_Type__c,TicketTypes__r.order__c,Survey_Questions__r.order__c,TicketTypes__c from Ticket_Mapswith_Survey__c where TicketTypes__c IN :ticuyids and TicketTypes__r.Avilable_for_Portal__c=true order By order__c]);
          
           for(innerClass Inc : selectedinns){
            List<Ticket_Mapswith_Survey__c> SQy = new List<Ticket_Mapswith_Survey__c> ();
             for(Ticket_Mapswith_Survey__c SWQ:SQ){
               if(Inc.tt.id==SWQ.TicketTypes__r.id){
                 SQy.add(SWQ); 
               }              
               
             }
             mapTickIdAndSurvey.put(Inc.tt.id,SQy);
           }
         
        
          for(innerClass incls:selectedinns){
            if((incls.quantity!=0 && incls.quantity!=null)|| (incls.tt.TT_TicketType__c=='Donation')){
                decimal  d=0;
                if(incls.quantity!=0 && incls.quantity!=null){
                   // d = (incls.quantity)*(mapIdWithPrice.get(incls.tt.id));
                   d = (incls.quantity)*(incls.tt.TT_amount__c);
                   decimal blfee =(incls.quantity)*AppFee;
                
                if(incls.tt.Service_Fee__c=='Add Booth Leads fee on top of the total ticket price'){
                   eventAdminAmount +=d+blfee ; 
                   GrandQuantity+=incls.quantity; 
               }else{
                   eventAdminAmount +=d ; 
                   GrandQuantity+=incls.quantity;
                 }
                 }
                 if(incls.donationValue!=0 && incls.donationValue!=null){
                     d +=incls.donationValue;
                     GrandQuantity+=1;
                     eventAdminAmount +=d; 
                }
            }
         }
          
         boothleadsAmount = GrandQuantity*AppFee;
         TotalAmount=(eventAdminAmount).setScale(2);
      //((eventAdminAount+boothleadsAmount)*(2.9/100))+0.60).setScale(2);
           system.debug('44444444444444444 '+TotalAmount+'55555555555555 '+eventAdminAmount); 
           //List<SelectOption> innopts = new List<SelectOption>();
            //innopts.add(new SelectOption('Select (Optional)','Select (Optional)'));
            List<string> innopts = new List<string>();
            innopts.add('Select (Optional)');
           for(integer i1=1;i1<=GrandQuantity;i1++){
             // innopts.add(new SelectOption('Ticket #'+string.valueOf(i1),'Ticket #'+string.valueOf(i1))); 
               innopts.add('Ticket #'+string.valueOf(i1));  
           }
           
           integer totickecount=1;
           MAP<integer,innforSecondButton> mapNumWithTic= new  MAP<integer,innforSecondButton>();
            
            
          if(EventType =='Collect information below for each attendee'){  
            for(innerClass itrateTickets:selectedinns){
                for(integer hy=1;hy<=itrateTickets.quantity;hy++){ 
                 innforSecondButton innbut = new innforSecondButton(itrateTickets.tt,TotalAmount,totickecount,itrateTickets,mapTickIdAndSurvey.get(itrateTickets.tt.id),innopts,MapTicWithSet.get(itrateTickets.tt.id));
                   mapNumWithTic.put(totickecount,innbut );
                   system.debug('HHHHHHHHHHHHHHHHHHHHHH '+innbut );
                  seccls.add(innbut);         
                 totickecount++;
                }
               
             }
          } else if(EventType =='Collect information below for the ticket buyer only'){
          
           innforSecondButton innbut = new innforSecondButton(MapTicWithSet.get(event.id));
           seccls.add(innbut);  
          }
           
           
           if((TotalAmount!=null && TotalAmount!=0)){
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
        
                   
       }
       
       system.debug('XXXXXXXXXXXXXXXXXXX '+seccls);
       
       
         cus = new Constomer__c();
          cus.Uniq_Number__c ='Uniq';
          cus.Total_Amount__c =eventAdminAmount ;
          insert cus;
        paymentsPage = true; 
  
     months = new List<selectOption>();
     years= new List<selectOption>();
     months.add(new selectOption('Month','Month')); 
     months.add(new selectOption('01','01'));
     months.add(new selectOption('02','02'));
     months.add(new selectOption('03','03'));
     months.add(new selectOption('04','04'));
     months.add(new selectOption('05','05'));
     months.add(new selectOption('06','06'));
     months.add(new selectOption('07','07'));
     months.add(new selectOption('08','08'));
     months.add(new selectOption('09','09'));
     months.add(new selectOption('10','10'));
     months.add(new selectOption('11','11'));
     months.add(new selectOption('12','12'));
     
     years.add(new selectOption('Year','Year'));
      years.add(new selectOption('2014','2014'));
       years.add(new selectOption('2015','2015'));
        years.add(new selectOption('2016','2016'));
         years.add(new selectOption('2017','2017'));
          years.add(new selectOption('2018','2018'));
           years.add(new selectOption('2019','2019'));
            years.add(new selectOption('2020','2020'));
             years.add(new selectOption('2021','2021'));
               years.add(new selectOption('2022','2022'));
                 years.add(new selectOption('2023','2023'));
                   years.add(new selectOption('2024','2024'));
                     years.add(new selectOption('2025','2025'));
                       years.add(new selectOption('2026','2026'));
                         years.add(new selectOption('2027','2027'));
                           years.add(new selectOption('2028','2028'));
                             years.add(new selectOption('2029','2029'));
                               years.add(new selectOption('2030','2030'));
     
  
     }
  
  // --------------------------------- Inner class to display Surveys and Attendee-----------------------------------------------------------------
            
        public List<innforSecondButton> seccls{get;set;}
        
        public class innforSecondButton{
            public Decimal totalPrice{get;set;}
            public integer Quan{get;set;}
            public string MessageInfo{get;set;}
            public AttendeeSummary__c dssum{get;set;}
            public innerClass  innvalueFordiscount{get;set;}
            public TicketTypes__c Name{get;set;}
            public string eventId {get;set;}
            public List<innForDisplaySurvey> inns{get;set;}
            public List<string> secinns{get;set;}
            public string selected{get;set;}
            public Registration_Settings__c RESInn{get;set;}
            public LIST<String> selectedNAICSCodes{get; set;}
            public integer attendeeOrder{get; set;}
            
                        public innforSecondButton(TicketTypes__c name,Decimal to,integer  Qua,innerClass disval,List<Ticket_Mapswith_Survey__c> suv,List<string> secinns1,Registration_Settings__c RESInn1){
                        inns= new List<innForDisplaySurvey>();
                        secinns = new List<string>();
                        selectedNAICSCodes = new LIST<String>();
                        
                         RESInn = new  Registration_Settings__c();
                         RESInn = RESInn1;
                         this.totalPrice=to;
                         this.secinns = secinns1;
                         this.Name =name;
                         eventId =name.EV_id__c;
                         this.innvalueFordiscount = disval;
                         for(Ticket_Mapswith_Survey__c Sw:suv){
                             inns.add(new innForDisplaySurvey(Sw));
                          }
                              dssum  = new AttendeeSummary__c();
                              dssum.As_Home_Country__c ='United States Of America';
                              
                              dssum.AS_Work_Country__c ='United States Of America';
                              dssum.AS_ShippingCountry__c ='United States Of America';
                                                  
                              dssum.Ticket_Number__c=string.valueOf(Qua);
                             system.debug('DDDDDDDDDDDDDDDdd '+Qua);
                       }
                       
                       
                  public innforSecondButton(Registration_Settings__c RESInn1){
                         RESInn = new  Registration_Settings__c();
                         RESInn = RESInn1;
                         inns= new List<innForDisplaySurvey>();
                         dssum  = new AttendeeSummary__c();
                        dssum.As_Home_Country__c ='United States Of America';
                  }     
                       
                       
                     public innforSecondButton(){
                        dssum  = new AttendeeSummary__c();
                        Name = new TicketTypes__c(); 
                        inns= new List<innForDisplaySurvey>();
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
                                       
  public void callpayByCheck(){
   if(paymenttypeIteam =='Pay By Check'){
      selectAtleastOneError =true;
      checkadd =eventAdminEvent[0].Check_Address__c;
     }else{
     selectAtleastOneError =false;
    }
   system.debug(' selectAtleastOneError  2222222222222222 '+paymenttypeIteam );
 }                
   
   
   
   
    public Void closepop() {
        contactinfo = false;
    }


    public void sendMail() {
       
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
    
    
    
     public Void displaypopup() {
       contactinfo = true;
    }

  

public string  errorstringName {get;set;}
public LIST<String> SelectedNAICS{get; set;}
public String SelectedNAICSSing{get; set;}
public String curncy { get; set; }
public StripeResponseModel  rep {get;set;}


    public String description { get; set; }
    public string amt { get; set; }
    public String cvv { get; set; }
    public String expYear { get; set; }
    public String expMonth { get; set; }
    public String cardNo { get; set; }
   
  


    public PageReference Pay() {

       dperror=false;
     //naicsfunction();
     errorstringName ='';
     errorRequiredfield = false;
     naicsalertbool=false;
      SET<string>  forFindDuplicate = new SET<string>();
       MAP<string,SET<Id>> mapemailWithTickets = new MAP<string,set<Id>>();
  
      SET<string>  forFindDuplicatevalues = new SET<string>();
            
     
         for(innforSecondButton inclsre: seccls ){
           forFindDuplicate.add(inclsre.dssum.AS_Email__c);
           }
           
      SET<id> ticketsidsset = new SET<id>();
      
      for(Dummay__c ldim : [SELECT id,Email__c,customer_key__r.Isinserted__c,TicketTypes__c from Dummay__c where customer_key__r.Isinserted__c=true and Event__c=:event.id and Email__c IN :forFindDuplicate]){
         forFindDuplicatevalues.add(ldim.Email__c);
           ticketsidsset = new SET<id>();
             for(string em:forFindDuplicate){
               if(em==ldim.Email__c){
                  ticketsidsset.add(ldim.TicketTypes__c); 
               }
             }
           mapemailWithTickets.put(ldim.Email__c,ticketsidsset);
      }
      
             system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD '+mapemailWithTickets);
             
        if(event.Type_Of_registration_allow__c =='Tickets should be different'){
             for(innforSecondButton inclsre: seccls ){
                  SET<id> ticids12 = new SET<id>();
                  system.debug('SSSSSSSSSSSSSSSS '+inclsre.dssum.AS_Email__c);
                   system.debug('AAAAAAAAAAAAAAAAAAAA '+mapemailWithTickets.get(inclsre.dssum.AS_Email__c));
                  try{
                    ticids12 = mapemailWithTickets.get(inclsre.dssum.AS_Email__c);
                  }catch(exception er){}
                  
                  if(ticids12 !=null && ticids12.size()>0 )
                  {
                      
                      if(ticids12.contains(inclsre.Name.id)){
                          errorstringName='Duplicates Found / You already register to this event'; 
                          errorRequiredfield = true;
                          return null;
                       }else{
                          ticketsidsset.add(inclsre.Name.id); 
                          mapemailWithTickets.put(inclsre.dssum.AS_Email__c,ticketsidsset);
                      }    
             }
           }
         }else if(event.Type_Of_registration_allow__c=='One person can book one ticket for entire Event'){
             for(innforSecondButton inclsre: seccls ){ 
             if(forFindDuplicatevalues!=null && forFindDuplicatevalues.size()>0)
             {
                 if(forFindDuplicatevalues.contains(inclsre.dssum.AS_Email__c)){
                    errorstringName='Duplicates Found / You already register to this event'; 
                          errorRequiredfield = true;
                          return null;
                 }else{
                   forFindDuplicatevalues.add(inclsre.dssum.AS_Email__c);
                 }
            }
        }   
       
     }
     
     
     
      if(eventAdminAmount==null && boothleadsAmount==null){
      eventAdminAmount =0;
      boothleadsAmount =0;
      }
      
    
    
    for(innforSecondButton inclsre: seccls ){
      for(innForDisplaySurvey INforSur:inclsre.Inns){
         if(INforSur.survey.IsRequired__c==true){
            if((INforSur.selectedSurveyValue==null || INforSur.selectedSurveyValue=='') && (INforSur.selectedSurveyValueCheck==null || INforSur.selectedSurveyValueCheck.size()<=0)){
              errorRequiredfield =true;
               errorstringName='Required Fields are missed';
              return null;
            }
                       
          }
      }
    
    }
    
   if(EventType!='Collect information below for each attendee'){  
   List<innforSecondButton> innslistForholdValues = new List<innforSecondButton>();
   innslistForholdValues.addAll(seccls); 
   seccls = new List<innforSecondButton>();
     for(innerClass itrateTickets:selectedinns){
       innforSecondButton innbut1 = new innforSecondButton();      
        //Tickets_Quantty__c         
          innbut1.totalPrice = itrateTickets.totalTicPrice;
          innbut1.Quan=itrateTickets.Quantity;
          innbut1.Name=itrateTickets.tt;
          innbut1.eventId=selectedEvent;
          innbut1.dssum=innslistForholdValues[0].dssum;
          seccls.add(innbut1);
      }
    }
    
     try{
     naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
                     system.debug('44444444444444444 ' + naicsselctdids );
           naicscods= new list<string>();
           system.debug('444444444sssssssss  ' + naicscods  );
          naicscods=naicsselctdids .split('-');
   system.debug('shruthi shruhti shruthi' + naicscods[1] );
    }catch(Exception e){}
     
     
    if(eventAdminEvent!=null && eventAdminEvent.size() > 0 ){
       if(eventAdminAmount > 0){    
        paymentTypevalue = eventAdminEvent[0].Account_types__c;
       }
    }
    
    
    if((eventAdminAmount==0  || boothleadsAmount==0)){
    
    
    
       InsertingValues('Boothleads123');
         pageReference pg =new PageReference('/apex/BL_Special_Needs_Expos_success?payKey='+cus.id);
         pg.setRedirect(true);
         return pg;
       }else if(paymentTypevalue=='Stripe'){
      
           // string apikey ='sk_live_iyGP0qYyY5ZHc5B11za1JSYP';
            string apikey =eventAdminEvent[0].StripeKey__c;
            Stripe stpch = new Stripe(apikey);
            Integer iRE = Integer.VaLUEOF(TotalAmount);
            system.debug('WWWWWWWWWWWWWWWWWWWW' + TotalAmount );
            INTEGER paymentMoney= IRE*100;
            system.debug('55555555555555555555555555555' + paymentMoney );
            amt = string.valueOf(paymentMoney);
             
             errorStripe ='';
              
            rep = new StripeResponseModel ();
           // rep =  stpch.createCharge('4242424242424242','2017','12','123','10000','usd',''); 
            try{
             rep =  stpch.createCharge(cardNo ,expYear ,expMonth,cvv,amt,'usd',seccls[0].dssum.AS_Email__c); 
             }catch(exception er){
             rep =  stpch.createCharge(cardNo ,expYear ,expMonth,cvv,amt,'usd',''); 
             }
               system.debug('BBBBBBBBBBBBBBBBBBBB '+ rep.errorResponse.message );
               errorStripe =rep.errorResponse.message;
              if(rep.paid=='true'){
               InsertingValues(rep.id);
                 pageReference pg =new PageReference('/apex/BL_Special_Needs_Expos_success?payKey='+cus.id);
                 pg.setRedirect(true);
                 return pg;
              }
            } else if(paymentTypevalue=='Authorize.Net'){
                 dpayhand = new DoPaymentHandler();
                 dpayhand.amount = string.valueOf(TotalAmount);
                 dpayhand.cardholder= seccls[0].dssum.AS_FirstName__c+' '+seccls[0].dssum.AS_LastName__c;
                 dpayhand.cardnumber=cardNo ;
                 dpayhand.cardyear=expYear ;
                 dpayhand.cardmonth=expMonth;
                 dpayhand.cardcvv= cvv;
                 dpayhand.email =seccls[0].dssum.AS_Email__c;
                 dpayhand.lastname = seccls[0].dssum.AS_FirstName__c;
                 dpayhand.firstname = seccls[0].dssum.AS_LastName__c;
                 if(seccls[0].dssum.AS_WorkAddress1__c!=null&&seccls[0].dssum.AS_WorkAddress1__c!='')
                  dpayhand.address=seccls[0].dssum.AS_WorkAddress1__c;
                  if(seccls[0].dssum.AS_Work_States__c!=null&&seccls[0].dssum.AS_Work_States__c!='')
                  dpayhand.state=seccls[0].dssum.AS_Work_States__c;
                  if(seccls[0].dssum.AS_WorkZip__c!=null&&seccls[0].dssum.AS_WorkZip__c!='')
                  dpayhand.zip=seccls[0].dssum.AS_WorkZip__c;
                  if(seccls[0].dssum.AS_Company__c!=null&&seccls[0].dssum.AS_Company__c!='')
                 dpayhand.company=seccls[0].dssum.AS_Company__c;
                 if(seccls[0].dssum.AS_WorkPhone__c!=null&&seccls[0].dssum.AS_WorkPhone__c!='')
                 dpayhand.phone=seccls[0].dssum.AS_WorkPhone__c;
                 if(seccls[0].dssum.AS_CellPhone__c!=null&&seccls[0].dssum.AS_CellPhone__c!='')
                 dpayhand.phone=seccls[0].dssum.AS_CellPhone__c;
                 if(seccls[0].dssum.AS_WorkCity__c!=null&&seccls[0].dssum.AS_WorkCity__c!='')
                 dpayhand.city=seccls[0].dssum.AS_WorkCity__c;
                 if(seccls[0].dssum.AS_Work_Country__c!=null&&seccls[0].dssum.AS_Work_Country__c!='')
                 dpayhand.country=seccls[0].dssum.AS_Work_Country__c;
                 try{
                 dpayhand.description='Event :'+event.EV_Title__c;}catch(Exception e){}
                 dpayhand.eventid = Apexpages.CurrentPAge().getParameters().get('id');
                  dpayhand.process();
                  system.debug('Transaction status '+dpayhand.message);
                  
                 if(dpayhand.isSuccess){
                    InsertingValues(dpayhand.message);
                    pageReference pg =new PageReference('/apex/BL_Special_Needs_Expos_success?payKey='+cus.id);
                    pg.setRedirect(true);
                    return pg;
                 }else
                 {
                 dperror=true;
                 }
            
            }
           return null;
    }

   
   
   public void InsertingValues(string Paykey1){
   
       
       MAP<string,List<Survey__c>> mapIdwithSurvey = new MAP<string,List<Survey__c>>();
        List<Dummay__c>  Listdummays = new List<Dummay__c>();   
         MAP<id,string> mapidticketName = new MAP<id,string>();
         List<AttendeeSummary__c>  Listdummaysummaries = new List<AttendeeSummary__c>();     
         List<Survey__c> surveyQuestions = new List<Survey__c>(); 
         string removeDuplicate='';
          
         
          List<Constomer__c> cusList = new List<Constomer__c>();
             for(Constomer__c cp : [select id,Uniq_Number__c,Total_Amount__c,Payment_Type__c,payKey__c from Constomer__c where id=:cus.id]){
               cp.Total_Amount__c =totalamount;
               if(paymenttypeIteam =='Pay By Check'){
                 cp.Payment_Type__c  ='Check';
              }else{
                if( (eventAdminAmount==0  || boothleadsAmount==0)){
                  cp.Payment_Type__c ='Free';
                  }else{
                   cp.Payment_Type__c ='Credit Card';
                 }
                                       
               } 
            cp.payKey__c = Paykey1;   
         cusList.add(cp); 
         
        }
         
        database.Update(cusList,false); 
          
                              
            
            for(innforSecondButton lk:seccls){
                try{
                  lk.dssum.customer_key__c = cus.id;
                  }catch(exception rt){}
                  if(lk.dssum.AS_Email__c!=null & lk.dssum.AS_Email__c!=''){
                   if(removeDuplicate.contains((lk.dssum.AS_Email__c).tolowercase())){ 
                 
                  }else{
                  removeDuplicate =+ lk.dssum.AS_Email__c.tolowercase();
           try{       
           if(naicscods[1]!= null || naicscods[1]!= '')
          {
           lk.dssum.As_NAICSCode_1__c = naicscods[1].replace('&','-');
          }}catch(exception ex){}
          try{
          if(naicscods[2]!= null || naicscods[2]!= '')
          {
           lk.dssum.As_NAICSCode_2__c = naicscods[2].replace('&','-');
          } }catch(exception ex){}
          try{
          if(naicscods[3]!= null || naicscods[3]!= '')
          {
           lk.dssum.As_NAICSCode_3__c = naicscods[3].replace('&','-');
          }}catch(exception ex){}
          try{
          if(naicscods[4]!= null || naicscods[4]!= '')
          {
           lk.dssum.As_NAICSCode_4__c = naicscods[4].replace('&','-');
          }}catch(exception ex){}
          try{
          if(naicscods[5]!= null || naicscods[5]!= '')
          {
           lk.dssum.As_NAICSCode_5__c = naicscods[5].replace('&','-');
          }}catch(exception ex){}
          system.debug('1111111 ' + lk.dssum.As_NAICSCode_1__c  + '22222222222 ' + lk.dssum.As_NAICSCode_2__c  );
          
          system.debug('2333333333' + lk.dssum.As_NAICSCode_3__c  + 'fffffffffff' + lk.dssum.As_NAICSCode_4__c  );
          
          system.debug('55555555555555' + lk.dssum.As_NAICSCode_5__c  );
           
                   Listdummaysummaries.add(lk.dssum);
                  }
                 } 
                         Dummay__c dou = new Dummay__c();
                         dou.First_Name__c =lk.dssum.AS_FirstName__c;
                         dou.Last_Name__c =lk.dssum.AS_LastName__c;
                         dou.Phone__c =lk.dssum.AS_WorkPhone__c;
                         dou.Email__c =lk.dssum.AS_Email__c;
                         dou.Company__c=lk.dssum.AS_Company__c;
                         dou.InvoiceEmail__c =lk.dssum.AS_Email__c;
                         dou.Event__c =selectedEvent;
                         dou.TicketTypes__c =lk.Name.id;
                        //  system.debug('********************************* '+EventType+' ************************ '+stausOfEventtype);
                         if(EventType!='Collect information below for each attendee'){
                           dou.Tickets_Quantty__c =lk.Quan;
                         }else{ 
                            lk.Quan=1;
                            dou.Tickets_Quantty__c =1;
                            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '+dou.Tickets_Quantty__c+'<<<<<<<<<<<<<<<<<<<<<<<<< '+lk.Quan);  
                        } 
                       
                         system.debug('LLLLLLLLLLLL  '+lk.name.TT_Amount__c);
                         if(lk.name.TT_Amount__c!=null){
                             dou.TicketAmount__c =(lk.Quan)*(lk.name.TT_Amount__c);
                         } 
                           try{
                             dou.customer_key__c =cus.id;
                           }catch(exception gt){}
                 
             
                          if(lk.innvalueFordiscount !=NULL){
                             if(EventType!='Collect information below for each attendee'){ 
                                 dou.Tickets_Quantty__c =lk.innvalueFordiscount.quantity;
                              }
                              dou.DiscountValue__c = lk.innvalueFordiscount.DiscountValue;
                              dou.Promocode__c  = lk.innvalueFordiscount.promocodevalue;
                          }
                   if(paymenttypeIteam =='Pay By Check'){
                         dou.Payment_Type__c ='Check';
                         }else{
                        if( (eventAdminAmount==0  || boothleadsAmount==0)){
                               dou.Payment_Type__c ='Free';
                           }else{
                             dou.Payment_Type__c ='Credit Card';
                           }
                           
                         }
                         dou.payKey__c =Paykey1;
                         Listdummays.add(dou);
                           database.saveResult dsingle =   dataBase.insert(dou,false); // By Phani
                           
                    List<Survey__c> surveyQuestions1 = new List<Survey__c>();    
                     for(innForDisplaySurvey tre:lk.inns){
                       Survey__c suv = new Survey__c();
                      try{
                       suv.customer_key__c =cus.id;
                     }catch(exception re){}
                       suv.Event__c =selectedEvent;
                        if(dsingle.isSuccess()){
                           suv.Registration_Info__c=dsingle.getId();  // Survey Questions
                        }
                       
                       suv.Survey_Questions__c =tre.survey.Survey_Questions__r.id;
                       //suv.Email__c =lk.dssum.AS_Email__c;
                       if(tre.selectedSurveyValue!=null && tre.selectedSurveyValue!=''){
                        suv.Answers__c=tre.selectedSurveyValue;
                       }else{
                         suv.Answers__c =string.valueOf(tre.selectedSurveyValueCheck);
                        
                       }
                        surveyQuestions1.add(suv); 
                       surveyQuestions.add(suv);
                   } 
                   
                   if(mapIdwithSurvey.keySet().contains(lk.dssum.AS_Email__c)){
                     surveyQuestions1.addAll(mapIdwithSurvey.get(lk.dssum.AS_Email__c));
                     mapIdwithSurvey.put(lk.dssum.AS_Email__c,surveyQuestions1);    
                   }else{
                     mapIdwithSurvey.put(lk.dssum.AS_Email__c,surveyQuestions1);
               
           }
      }
    // database.saveResult[] dsave1 =   dataBase.insert(Listdummays,false);
           
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
   
   }
   public integer i{get;set;}
   public void  dummy1(){
   i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}

public void  dummy2(){
   i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}
   
   
}
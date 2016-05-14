public class BL_Attendee_RegisterCon {


    public Event__c event{get; set;} 
    public LIST<TicketTypes__c> ticketTypes{get; set;}
    public LIST<selectoption>states{get; set;}
    public LIST<innerTicketType> tickets{get; set;}
    public String EventReqString{get; set;}
    public Boolean successBool{get; set;}
    
    public Boolean primaryBool{get; set;}
    public Boolean businessBool{get; set;}
    public Boolean naicsBool{get; set;}
    public Boolean addressBool{get; set;}
    public Boolean paymentBool{get; set;}
    
    public Boolean headerBusinessBool{get; set;}
    public Boolean headernaicsBool{get; set;}
    public Boolean headeraddressBool{get; set;}
    
    public Boolean registrationBool{get; set;}
    public BL_EventAdminRegistration attendeeSetting{get; set;}
    public AttendeeSummary__c newAttendee{get; set;}
    public String myimageName{get; set;}
    public BLOB attendeeImage{get; set;}
   
   
    public List<Selectoption> diversityFirstLine{get; set;}
    public List<Selectoption> diversitySecondLine{get; set;}
    public LIST<String> selectedValuesFirst{get; set;}
    public LIST<String> selectedValuesSecoend{get; set;}
    // Payment OPrions 
    
    public String BIname{get;set;}
    public String BIfname{get;set;}
    public String BIlname{get;set;}
    public String BIcompany{get;set;}
    public String BIaddress1{get;set;}
    public String BIaddress2{get;set;}
    public String BIcity{get;set;}
    public String BIstate{get;set;}
    public String BIzip{get;set;}
    public String BIphone{get;set;}
    public String BIcountry{get;set;}
    public String BIemail{get;set;}
    public String CardType{get;set;}
    public String cardNumber{get;set;}
    public String cardHolderName{get;set;}
    public String expMonth{get;set;}
    public String expYear{get;set;}
    public String securityCode{get;set;}
    Public String transactionId  {get;set;}
    public String message {get;set;}
    public Decimal amount{get;set;}
    public String redirectUri{get;set;}
    Public String ChoiceVal{get;set;}
    Public String TransactionResult{get;set;}
    public Boolean successBool1{get;set;}
    Public String Errmessage{get;set;}
    
     
    public List<selectoption> getselect()
    {
        List<selectoption> Option = new List<selectoption>();
        Option.add(new selectoption('Male','Male'));
        Option.add(new selectoption('Female','Female'));
        return option;
    }
    
    public BL_Attendee_RegisterCon(){
    
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
        
         ticketTypes= new LIST<TicketTypes__c>();
         newAttendee= new AttendeeSummary__c();
         tickets = new LIST<innerTicketType>();
         
        diversityFirstLine = new List<Selectoption>();
        diversitySecondLine = new List<Selectoption>();
        selectedValuesFirst = new LIST<String>();
        selectedValuesSecoend = new LIST<String>();
         
         successBool= FALSE;
       
       event = [SELECT id,EV_Description__c,EV_EndDate__c,EV_EndTime__c,EV_HistingAddr1__c,EventDiversityValues__c,
                        EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingFax__c,
                        EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,
                        EV_HostingTimeZone__c,EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,
                        EV_Title__c,EV_WebsiteURL__c,EV_EventLogo__c,EV_ContactURL__c,EV_HostingCountry__c , 
                        EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,
                        Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c
                           FROM Event__c WHERE EV_SiteLocation__c =: ApexPages.currentpage().getParameters().get('event')];
    
       
        if(event.EventDiversityValues__c != NULL){
        
            LIST<String> diversity = event.EventDiversityValues__c.split(',');
            
            integer ii = 0;
            for(String diver : event.EventDiversityValues__c.split(';')){
                
                if(Math.mod(ii,2)==0){
                    diversitySecondLine.add(new SelectOption(diver,diver));
                        
                }else{
                    diversityFirstLine.add(new SelectOption(diver,diver));
                }
                
                ii++;
            
            }
            
       }
       
           ticketTypes = [SELECT ID, TT_Name__c, TT_Limit__c, TT_TicketType__c, TT_Amount__c,Avilable_for_Portal__c FROM TicketTypes__c WHERE EV_id__c =: event.id AND Avilable_for_Portal__c = TRUE ORDER BY CreatedDate ];
           
           for(TicketTypes__c t: ticketTypes ){
                tickets.add(new innerTicketType(t,false));
           }
   
            registrationBool = event.EV_QuickReg__c;
            
            redirectUri    = event.EV_RedirectURI__c;
            
            attendeeSetting = new BL_EventAdminRegistration(event.id);
            
            
            headerBusinessBool = (attendeeSetting.PBC || attendeeSetting.SBC || attendeeSetting.NOEmp || attendeeSetting.BEDate || attendeeSetting.BRev || attendeeSetting.BTaxID || attendeeSetting.BDN || attendeeSetting.webUrl || attendeeSetting.blogURL || attendeeSetting.BDesc || attendeeSetting.DT );
            
            headernaicsBool = (attendeeSetting.NAICSCode1|| attendeeSetting.NAICSCode2|| attendeeSetting.NAICSCode3|| attendeeSetting.NAICSCode4|| attendeeSetting.NAICSCode5);
            
            
            system.debug('####################   '+  headerBusinessBool+'      '+   headernaicsBool);
            
            makeFields();
            
                
           
            primaryBool = TRUE;
            businessBool = FALSE;
            addressBool = FALSE;
            naicsBool = FALSE;
            paymentBool = FALSE;
              
          /**
            primaryBool = FALSE;
            businessBool = FALSE;
            addressBool = FALSE;
            naicsBool = FALSE;
            paymentBool = TRUE;
       **/
           //successBool = TRUE;
                        
          if(event.EV_QuickReg__c){
           headerBusinessBool =  FALSE;
           headernaicsBool = FALSE;
           headeraddressBool = TRUE;
           }else {
               headerBusinessBool = (attendeeSetting.PBC || attendeeSetting.SBC || attendeeSetting.NOEmp || attendeeSetting.BEDate || attendeeSetting.BRev || attendeeSetting.BTaxID || attendeeSetting.BDN || attendeeSetting.webUrl || attendeeSetting.blogURL || attendeeSetting.BDesc || attendeeSetting.DT );
               headernaicsBool = (attendeeSetting.NAICSCode1|| attendeeSetting.NAICSCode2|| attendeeSetting.NAICSCode3|| attendeeSetting.NAICSCode4|| attendeeSetting.NAICSCode5);
               headeraddressBool = ( attendeeSetting.workInfo || attendeeSetting.homeInfo ||attendeeSetting.Shippinginfo );
           }
           
           
           
           
    }
    
   public string str{get; set;}
    
    public void nextmethode(){
            
            
            
            str = ApexPages.currentPage().getparameters().get('nextparam');
            
             system.debug('2222222222222222222222        '+  str +'     '+ newAttendee.AS_FirstName__c );  
            
            if(str != NULL && str != '')
            {
             
               if(str == 'BusinessToPrimary' ){
                    primaryBool = TRUE;
                    businessBool = FALSE;
                    naicsBool = FALSE;
                    addressBool = FALSE;
                    paymentBool = FALSE;
                }else if(str == 'PrimaryToBusiness' ){
                    system.debug('333333333333333333       ');  
                    primaryBool = FALSE;
                        if(headerBusinessBool){
                                businessBool = headerBusinessBool;
                                addressBool = FALSE;
                                naicsBool = FALSE;
                                paymentBool = FALSE;
                          }else if(headernaicsBool){
                                businessBool = headerBusinessBool;
                                naicsBool = headernaicsBool;
                                addressBool = FALSE;
                                paymentBool = FALSE;
                          }else if(headeraddressBool){
                                businessBool = headerBusinessBool;
                                naicsBool = headernaicsBool;
                                addressBool = TRUE;
                                paymentBool = FALSE;
                           system.debug('4444444444444        ');  
                          }else{
                              businessBool = FALSE;
                                naicsBool = FALSE;
                                addressBool =FALSE;
                                paymentBool = TRUE;
                          }
                }else if(str == 'BusinessToNaics'){
                   if(headernaicsBool){
                                businessBool = FALSE;
                                naicsBool = TRUE;
                                addressBool = FALSE;
                                paymentBool = FALSE;
                          }else if(headeraddressBool){
                                businessBool = FALSE;
                                naicsBool = FALSE;
                                addressBool = TRUE;
                                paymentBool = FALSE;
                           system.debug('4444444444444        ');  
                          }else{
                              businessBool = FALSE;
                                naicsBool = FALSE;
                                addressBool =FALSE;
                                paymentBool = TRUE;
                             }   
                }else if(str == 'NaicsToAddress'){
                    
                    if(headeraddressBool){
                            businessBool = FALSE;
                            naicsBool = FALSE;
                            addressBool = TRUE;
                            paymentBool = FALSE;
                       system.debug('4444444444444        ');  
                      }else{
                          businessBool = FALSE;
                            naicsBool = FALSE;
                            addressBool =FALSE;
                            paymentBool = TRUE;
                         }  
                }else if(str == 'AddressToPayment'){
                    primaryBool = FALSE;
                    businessBool =FALSE;
                    naicsBool = FALSE;
                    addressBool = FALSE;
                    paymentBool = TRUE;
                }
            }
    }
    
    
    
    public void previousmethode(){
       String str = ApexPages.currentPage().getparameters().get('nextparam');
             system.debug('2222222222222222222222        '+  str +'     '+ newAttendee.AS_FirstName__c );  
        if(str == 'BusinessToPrimary' ){
            primaryBool = TRUE;
            businessBool = FALSE;
            naicsBool = FALSE;
            addressBool = FALSE;
            paymentBool = FALSE;
        }else if(str =='PrimaryToBusiness'){
            if(headerBusinessBool){
                primaryBool = FALSE; 
                businessBool = headerBusinessBool;
                addressBool = FALSE;
                naicsBool = FALSE;
                paymentBool = FALSE;
            }else{
                primaryBool = TRUE; 
                businessBool = FALSE;
                addressBool = FALSE;
                naicsBool = FALSE;
                paymentBool = FALSE;
            
            }
       }else if(str =='BusinessToNaics'){

           if(headernaicsBool){
               primaryBool = FALSE;
                businessBool = FALSE;
                naicsBool = TRUE;
                addressBool = FALSE;
                paymentBool = FALSE;
          }else if(headerBusinessBool){
                primaryBool = FALSE; 
                businessBool = headerBusinessBool;
                addressBool = FALSE;
                naicsBool = FALSE;
                paymentBool = FALSE;
            }else{
                primaryBool = TRUE; 
                businessBool = FALSE;
                addressBool = FALSE;
                naicsBool = FALSE;
                paymentBool = FALSE;
            }
       }else if(str =='NaicsToAddress'){
          primaryBool = FALSE; 
           if(headeraddressBool){
                businessBool = FALSE;
                naicsBool = FALSE;
                addressBool = TRUE;
                paymentBool = FALSE; 
          }else if(headernaicsBool){
              businessBool = FALSE;
                naicsBool = TRUE;
                addressBool =FALSE;
                paymentBool = FALSE;
          }else if(headerBusinessBool){
              businessBool = TRUE;
              naicsBool = FALSE;
              addressBool =FALSE;
              paymentBool = FALSE;
          }else{
              primaryBool = TRUE; 
              businessBool = FALSE;
              naicsBool = FALSE;
              addressBool =FALSE;
              paymentBool = FALSE;
          
          }
            
       }
    }
    public void saveValues(){
    
       
     // @ while testing payments it commneted
        amount= 10;
        
        String DiversityValue='';
        selectedValuesFirst.addAll(selectedValuesSecoend);
        for(String s: selectedValuesFirst){
            DiversityValue += s + ';';
        }
        
        system.debug('HHHHHHHHHH    '+ DiversityValue );
        
        String RegistrationType='';
        for(innerTicketType inn :tickets){
            if(inn.checkTicket){
                RegistrationType += inn.ticket.TT_Name__c +',';
                amount +=inn.ticket.TT_Amount__c;   
            }
        }
        
        system.debug('paypal INtigration start----------------- Call pay pal  ');
         Paynow(); 
        
        if(RegistrationType.contains(',')){
            RegistrationType = RegistrationType.subString(0, RegistrationType.lastIndexOf(','));
        }
        
        Database.UpsertResult myAttendeeSaveResult = Database.upsert(newAttendee,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
        
        Event_Attendee_Mapping__c attmap;
         
         if(myAttendeeSaveResult.isSuccess() )
         {
             if(myAttendeeSaveResult.iscreated())
             {
              attmap = new Event_Attendee_Mapping__c();
              attmap.AS_id__c = myAttendeeSaveResult.getId();
              attmap.Ev_id__c = event.id;
              attmap.Attendee_Event_IDs__c = String.valueOf(myAttendeeSaveResult.getId()) + String.valueOf(event.id);
              attmap.DiversityType__c = DiversityValue;
            //  attmap.EA_AttendeeBarcode__c = myAttendeeSaveResult.getId()+'-'+ApexPages.currentpage().getParameters().get('event');  
            //   system.debug('------------------------------------------------------------------REGTYPES::::::::::-----'+selectedTicTypes);    
              attmap.TicketTypes__c=RegistrationType;
              
              Database.SaveResult myAttendeeJunction = Database.Insert(attmap ,false); 
              
              if(myAttendeeJunction.isSuccess()){
                      successBool= TRUE;
                      attmap.EA_AttendeeBarcode__c = myAttendeeJunction.getId() + '-'+ event.id;
                      
                      update attmap;
                      
                  }
              
              }else{
                  
                   integer ev_att_Jun=[select count() from  Event_Attendee_Mapping__c 
                                             where  AS_id__c =: myAttendeeSaveResult.getId() and
                                             Ev_id__c   =: event.id];
                   if(ev_att_Jun > 0)
                    {
                     
                     EventReqString='Attendee is Already exist';
                    
                    }else{
                      attmap = new Event_Attendee_Mapping__c();
                      attmap.AS_id__c = myAttendeeSaveResult.getId();
                      attmap.Ev_id__c = event.id;
                      attmap.Attendee_Event_IDs__c = String.valueOf(myAttendeeSaveResult.getId()) + String.valueOf(event.id);
                      attmap.DiversityType__c = DiversityValue;
                       // attmap.EA_AttendeeBarcode__c = myAttendeeSaveResult.getId()+'-'+ApexPages.currentpage().getParameters().get('event');  
                    //   system.debug('------------------------------------------------------------------REGTYPES::::::::::-----'+selectedTicTypes);    
                      attmap.TicketTypes__c=RegistrationType;
                        
                    }
                  Database.SaveResult myAttendeeJunction = Database.Insert(attmap ,false); 
                  
                  if(myAttendeeJunction.isSuccess()){
                      successBool= TRUE;
                      attmap.EA_AttendeeBarcode__c = myAttendeeJunction.getId() + '-'+ event.id;
                      
                      update attmap;
                      
                  }
                  
              }
             
         }
         
       
         
                  
    
    }
    
    
    
    
    public void makeFields(){
        
         states = new LIST<selectoption>();
        states.add(new SelectOption('None','--None--'));
        states.add(new SelectOption('AL','Alabama'));
        states.add(new SelectOption('AK', 'Alaska'));
        states.add(new SelectOption('AZ','Arizona'));
        states.add(new SelectOption('AR','Arkansas'));
        states.add(new SelectOption('CA','California'));
        states.add(new SelectOption('CO','Colorado'));
        states.add(new SelectOption('CT','Connecticut'));
        states.add(new SelectOption('DE','Delaware'));
        states.add(new SelectOption('DC','District of Columbia'));
        states.add(new SelectOption('FL','Florida'));
        states.add(new SelectOption('GA','Georgia'));
        states.add(new SelectOption('HI','Hawaii'));
        states.add(new SelectOption('ID','Idaho'));
        states.add(new SelectOption('IL','Illinois'));
        states.add(new SelectOption('IN','Indiana'));
        states.add(new SelectOption('IA','Iowa'));
        states.add(new SelectOption('KS','Kansas'));
        states.add(new SelectOption('KY','Kentucky'));
        states.add(new SelectOption('LA','Louisiana'));
        states.add(new SelectOption('ME','Maine'));
        states.add(new SelectOption('MD','Maryland'));
        states.add(new SelectOption('MA','Massachusetts'));
        states.add(new SelectOption('MI','Michigan'));
        states.add(new SelectOption('MN','Minnesota'));
        states.add(new SelectOption('MS','Mississippi'));
        states.add(new SelectOption('MO','Missouri'));
        states.add(new SelectOption('MT','Montana'));
        states.add(new SelectOption('NE','Nebraska'));
        states.add(new SelectOption('NV','Nevada'));
        states.add(new SelectOption('NH','New Hampshire'));
        states.add(new SelectOption('NJ','New Jersey'));
        states.add(new SelectOption('NM','New Mexico'));
        states.add(new SelectOption('NY','New York'));
        states.add(new SelectOption('NC','North Carolina'));
        states.add(new SelectOption('ND','North Dakota'));
        states.add(new SelectOption('OH','Ohio'));
        states.add(new SelectOption('OK','Oklahoma'));
        states.add(new SelectOption('OR','Oregon'));
        states.add(new SelectOption('PA','Pennsylvania'));
        states.add(new SelectOption('RI','Rhode Island'));
        states.add(new SelectOption('SC','South Carolina'));
        states.add(new SelectOption('SD','South Dakota'));
        states.add(new SelectOption('TN','Tennessee'));
        states.add(new SelectOption('TX','Texas'));
        states.add(new SelectOption('UT','Utah'));
        states.add(new SelectOption('VT','Vermont'));
        states.add(new SelectOption('VA','Virginia'));
        states.add(new SelectOption('WA','Washington'));
        states.add(new SelectOption('WV','West Virginia'));
        states.add(new SelectOption('WI','Wisconsin'));
        states.add(new SelectOption('WY','Wyoming'));
        
        
    }
    
    
    //Paypal Payment Methods
    
       public PageReference Paynow(){
       system.debug('paypal INtigration start-----------------  ');
          PaypalProccessor2 Payprocess =new PaypalProccessor2(BIfname,BIlname,BIaddress1,BIaddress2,BIcity,BIstate,'US',BIzip,CardType,CardNumber,expMonth,expYear,String.ValueOf(amount),event.Paypal_Username__c,event.Paypal_Password__c,event.Signature__c);
         system.debug('paypal INtigration start----------------- Success ');
          Message  = Payprocess.message;
          TransactionId  = Payprocess.transid;
          TransactionResult = Payprocess.apiResult;
          if(Payprocess.result=='Success'){ 
              successBool= TRUE;
          }else{
            Errmessage = Payprocess.Message;
            successBool1= TRUE; 
          }
       return NULL;
}
       public List<SelectOption> getChoiceOpt() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Use Home Address ','Use Home Address ')); 
        options.add(new SelectOption('Use Business Address','Use Business Address')); 
        options.add(new SelectOption('Use Shipping Address ','Use Shipping Address ')); return options; 
    }



      public  void CheckvalAssign(){
     
      System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ChoiceVal'+ChoiceVal);
     
       if(ChoiceVal.contains('Use Home Address')){
       BIfname = newAttendee.AS_FirstName__c;
       BIlname = newAttendee.AS_LastName__c;
       BIemail = newAttendee.AS_Email__c;
       BIphone = newAttendee.AS_WorkPhone__c;
       BIaddress1 =  newAttendee.AS_HomeAddress1__c;
       BIaddress2 =  newAttendee.AS_HomeAddress2__c;
       BIcity     =  newAttendee.AS_HomeCity__c;
       BIstate    =  newAttendee.AS_HomeState__c;
       BIzip      =  String.ValueOf(newAttendee.AS_HomePoBox__c); 
      }
      
        if(ChoiceVal.contains('Use Business Address')){
             BIfname = newAttendee.AS_FirstName__c;
             BIlname = newAttendee.AS_LastName__c;
             BIemail = newAttendee.AS_Email__c;
             BIphone = newAttendee.AS_WorkPhone__c;
              BIaddress1 =  newAttendee.AS_WorkAddress1__c;
              BIaddress2 =  newAttendee.AS_WorkAddress2__c;
              BIcity     =  newAttendee.AS_WorkCity__c;
              BIstate    =  newAttendee.AS_WorkState__c;
              BIzip      =  String.ValueOf(newAttendee.AS_WorkPoBox__c); 
         }
      
       if(ChoiceVal.contains('Use Shipping Addres')){
       BIfname = newAttendee.AS_FirstName__c;
       BIlname = newAttendee.AS_LastName__c;
       BIemail = newAttendee.AS_Email__c;
       BIphone = newAttendee.AS_WorkPhone__c;
       BIaddress1 =  newAttendee.AS_ShippingAddress1__c;
       BIaddress2 =  newAttendee.AS_ShippingAddress2__c;
       BIcity     =  newAttendee.AS_ShippingCity__c;
       BIstate    =  newAttendee.AS_shippingState__c;
       BIzip      =  String.ValueOf(newAttendee.AS_ShippingPoBox__c);   
       }
 
      }
 

       public pageReference RedirectMethod(){
   
      if(redirectUri != NULL){
      pagereference  pf = new pagereference(redirectUri);
      pf.setRedirect(true);
      return pf;
       }
       else{
      pagereference  pf = new pagereference('http://www.boothleads.com');
       pf.setRedirect(true);
       return pf;
       }
      return NULL;
       }
 

         public pageReference RedirectMethod1(){
         successBool1 = FALSE;
         return NULL;
       }

 public class innerTicketType{
        
        public TicketTypes__c ticket{get; set;}
        public Boolean checkTicket{get; set;}
        
        public innerTicketType(TicketTypes__c t, Boolean b ){
            ticket = t;
            checkTicket = b;
        }
 
    }
    
    
  static testMethod void Attendee_Test(){
  
  Event__c event1 = new Event__c(EV_SiteLocation__c='testEvent1',EV_Title__c='testEvent1',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 5392 Name badges',EventDiversityValues__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS');
  insert event1;



AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c=20,AS_BirthDate__c=date.valueOf('1995-05-05'),AS_BlogUrl__c='www.globalnest.com',AS_BusinessDescription__c='fgsdamnabfbhsd',AS_BusinessDunsNumber__c='2450153',
               AS_BusinessEstablishedDate__c=date.valueOf('1995-05-06'),AS_BusinessRevenue__c=324533,AS_BusinessTaxId__c='hngsdvdvf',AS_CellPhone__c='9858590231',
               AS_Company__c='testattendeecompany',AS_DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
               AS_Email__c='test123@noemail.com',AS_FaxNumber__c='9858985032',AS_FirstName__c='testattendeesummaryfirstname',AS_Gender__c='Male',
               AS_HomeAddress1__c='mjbfnmf',AS_HomeAddress2__c='nbdfhj',AS_HomeCity__c='mhsdfgfd',As_Home_Country__c='India',AS_HomePhone__c='6998878422',
               AS_HomePoBox__c=22125,AS_HomePoboxNo__c='84367',As_Home_State__c='Goa',AS_HomeZipcode__c=32121,AS_ImageUrl__c='www.globalnest.com',AS_LastName__c='testattendeelastname',AS_NAICSCode1__c=524621,
               AS_NAICSCode2__c=524421,AS_NAICSCode3__c=524671,AS_NAICSCode4__c=523621,AS_NAICSCode5__c=528921,AS_NumberOfEmployees__c=200,AS_prefixNew__c='mr',
               AS_PrimaryBusinessCategory1__c='Accounting',AS_SecondaryBusinessCategory1__c='Animation',AS_ShippingAddress1__c='dfdf',AS_ShippingAddress2__c='dsyhg',
               AS_ShippingCity__c='asfdsf',As_Shipping_Country__c='India',AS_ShippingPhone__c='3554353132',AS_ShippingPoBox__c=32224,AS_Shippingpoboxno__c='35521',As_Shipping_States__c='Goa',
               AS_shippingzip__c='32122',AS_ShippingZipcode__c=89524,AS_SuffixNew__c='dr',AS_ThroughEventBrite__c=true,AS_Title__c='hmjnhgh',AS_WebsiteUrl__c='hasdas.com',AS_WorkAddress1__c='dsag',
               AS_WorkAddress2__c='fdwe',AS_WorkCity__c='ewqrwd',AS_Work_Country__c='India',AS_WorkPhone__c='3554353132',AS_WorkPoBox__c=52346,AS_Workpoboxno__c='85231',AS_Work_States__c='Goa',AS_WorkZipCode__c=85246,AS_WorkZip__c='89523',
               Registration_type__c='kdsmkas');
   insert att; 
   Event_Attendee_Mapping__c EAM1=new Event_Attendee_Mapping__c(EV_id__c=event1.id,AS_id__c=att.id,DiversityType__c='Service Disabled Veteran Business Enterprise',TicketTypes__c='Reception',EA_AttendeeBarcode__c='a0nvwsdwkde',EA_isBadgePrinted__c=true,IsPrifileUpdate__c=true);
   insert EAM1;
  
   TicketTypes__c TIKTYPE = new TicketTypes__c(TT_Name__c='fulll conference,monday pass', TT_Limit__c=100, TT_TicketType__c='', TT_Amount__c=50,Avilable_for_Portal__c=true,EV_id__c=event1.Id);
   insert TIKTYPE ;
  
  pageReference pageRef = page.BL_Attendee_Register;
  Test.setCurrentpage(pageRef );
  
  
   ApexPages.currentPage().getParameters().put('event' , 'testEvent1');
   BL_Attendee_RegisterCon BLARC = new BL_Attendee_RegisterCon ();
  BLARC.getselect();
   ApexPages.currentPage().getparameters().put('nextparam','BusinessToPrimary');
  BLARC.nextmethode();
  BLARC.previousmethode();
    ApexPages.currentPage().getparameters().put('nextparam','PrimaryToBusiness');
 
  BLARC.nextmethode();
  
   BLARC.previousmethode();
  ApexPages.currentPage().getparameters().put('nextparam','BusinessToNaics');
  BLARC.nextmethode();
   BLARC.previousmethode();
  
  ApexPages.currentPage().getparameters().put('nextparam','NaicsToAddress');
  BLARC.nextmethode();
   BLARC.previousmethode();
  
  ApexPages.currentPage().getparameters().put('nextparam','AddressToPayment');
  BLARC.nextmethode();
   BLARC.previousmethode();
   
  BLARC.RedirectMethod1(); 
  BLARC.redirectUri=NULL;
  BLARC.RedirectMethod();
  BLARC.redirectUri='http://www.boothleads.com';
  BLARC.RedirectMethod();
  BLARC.getChoiceOpt();
  BLARC.ChoiceVal='Use Home Address,Use Business Address,Use Shipping Addres';
  BLARC.CheckvalAssign();
 /** 
  BLARC.BIcity= 'ajm';
BLARC.BIstate= 'CA';
BLARC.BIzip= '4534';
BLARC.expYear= '2017';
BLARC.expMonth= '10';
BLARC.CardNumber= '4202377599771003';
BLARC.CardType= 'Visa';
BLARC.BIfname= 'Venkatesh';
BLARC.BIlname= 'Puppala';

BLARC.BIaddress1= '44';
BLARC.BIaddress2= '433';
//p.payer = 'soi.ve_1343366860_per@gmail.com';
BLARC.amount= 10;
  
  
  
 BLARC.saveValues();
 
 **/
  }  
    
    
    


}
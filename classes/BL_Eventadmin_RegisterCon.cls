public class BL_Eventadmin_RegisterCon {

    public boolean paypalbool{get;set;}
    public String EventSelected{get; set;}

    public BL_EventAdminRegistration attendeesetting{get; set;}
    public LIST<TicketTypes__c> ticketTypes{get; set;}
    public Event__c events{get; set;} 
    
    public Map<ID, TicketTypes__c> ticketTypeMap{get; set;}
    public LIST<String> TicketTypeDelete{get; set;}
    public LIST<innerForTicketTypes> innerTickets{get; set;}
    public Boolean successBool{get; set;}
    
    public Boolean contBool{get; set;}
    public Boolean demographBool{get; set;}
    public Boolean ticketBool{get; set;}
    public Boolean paymentBool{get; set;}
    public Boolean publishBool{get; set;}
    public Boolean QuickRegBool{get; set;}
    public Boolean noTicketTypeBool{get; set;}
    
    
    public Boolean chk1{get;set;}
    public Boolean chk2{get;set;}
    public Boolean chk3{get;set;}
    public Boolean chk{get;set;}
    public String paypalEmail{get;set;}
    public Boolean paypalEmailNotify{get;set;}
    public String paypalSignature{get;set;}
    public String paypalPassword{get;set;}
     
    // ------- SITE URL -------
    public String siteStringError{get; set;}
    public String siteStringErrorstyle{get; set;}
    public Boolean siteStringErrorBool{get; set;}
    
    
    
    /**
    public static string chk1 ='Accept Pay by Check Payments';
    public static string chk2 ='Accept Pay at the Door Payments';
    public static string chk3 ='Accept Send an Invoice Payments';
    **/
    
    public BL_Eventadmin_RegisterCon(){
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
} 
        

         ticketTypes = new LIST<TicketTypes__c>();
         TicketTypeDelete = new LIST<String>();
         innerTickets = new LIST<innerForTicketTypes>();
         successBool = FALSE;
          siteStringErrorBool = TRUE;
         
         
        
     eventSelected = ApexPages.currentpage().getParameters().get('event');
      geteventsRegistration();
      
           
    }
    
    public String paramval{get; set;}
    public String paramassign{get; set;}
    
    public void contactinfo(){

        contBool =TRUE; 
        demographBool =  FALSE;
        ticketBool = FALSE; 
        paymentBool = FALSE; 
        publishBool = FALSE;
        paypalEmailNotify= FALSE; 
    
    }
   
    public void conTodemo(){
  
       if(QuickRegBool)
       {
        contBool = FALSE; 
        demographBool = FALSE;
        ticketBool = TRUE; 
        paymentBool = FALSE; 
        publishBool = FALSE; 
       }else{
        contBool = FALSE; 
        demographBool = TRUE;
        ticketBool = FALSE; 
        paymentBool = FALSE; 
        publishBool = FALSE; 
        
       } 
        
        
        ApexPages.currentPage().getParameters().put('event', eventSelected);
        
    system.debug('TTTTTTTTTTTTTTTTTTTTTTT      m' +  ApexPages.currentPage().getParameters().get('event'));
        
       paramval = 'conTodemo';
    }
    
    public void demoToTicket(){
   
        contBool = FALSE; 
        demographBool = FALSE;
        ticketBool = TRUE; 
        paymentBool = FALSE; 
        publishBool = FALSE; 
    
        paramval = 'demoToTicket';
    }
    
    public void ticketTopayment(){
   
        contBool = FALSE; 
        demographBool = FALSE;
        ticketBool = FALSE; 
        paymentBool = TRUE; 
        publishBool = FALSE; 
    
        paramval = 'ticketTopayment';
    }
    
    
    public void paymentTopublish(){
        

        
        contBool = FALSE; 
        demographBool = FALSE;
        ticketBool = FALSE; 
        paymentBool =FALSE; 
        publishBool = TRUE; 
    
        paramval = 'paymentTopublish';
    }
    
    
    public void moreTickets(){
        
 
      
        TicketTypes__c t = new TicketTypes__c();
                t.EV_id__c = eventSelected;
       //         ticketTypes.add(t);
       innerTickets.add(new innerForTicketTypes(t, innerTickets.size(), t.id));
                  
         noTicketTypeBool = FALSE;
         
          

    }
    
    public void previousAll(){
        
        // String back = ApexPages.currentPage().getParameters().get('contact');
                       
                     //ApexPages.currentpage().getParameters().get('event')];
      //   system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBB  '+ back  + paramassign );
        
            
            if(paramassign =='conTodemo')
                    contactinfo();
                
            else if(paramassign =='demoToTicket' )
                conTodemo();
                
            else if(paramassign =='ticketTopayment' )
                demoToTicket();

            else if( paramassign =='paymentTopublish')
                ticketTopayment();
                
            else 
            paymentTopublish();
            
        
        
        
    }
   
    
    public void checkExiestance(){
        
       
        siteStringErrorBool = TRUE;
        integer it= [SELECT count() FROM Event__c WHERE EV_SiteLocation__c =: events.EV_SiteLocation__c AND id !=: events.id ];
       if(it>0){
           siteStringError = 'Site URL is already existing in our Database';
           siteStringErrorstyle = '#FF0000';
           siteStringErrorBool = FALSE;
       }else{
           siteStringError = 'Site URL is available';
           siteStringErrorstyle = '#00FF00';
           siteStringErrorBool = TRUE;
       }
        
       
       
    }
    
    
    public void SaveAllFields(){
   
        
        if(!QuickRegBool) 
       {
          attendeeSetting.workAdd1 = FALSE;
          attendeeSetting.workAdd2 = FALSE;
          attendeeSetting.workcity = FALSE;
          attendeeSetting.workstate = FALSE;
          attendeeSetting.workCountry = FALSE;
          attendeeSetting.workzip = FALSE;

       }
        // SAVE FIELDS 
       String  selectedAttendeeFields = 'AS_FirstName__c,';
       
        if(attendeeSetting.comp)
        selectedAttendeeFields += 'AS_Company__c,';
        if(attendeeSetting.Prefix)
        selectedAttendeeFields += 'AS_Prefix__c,';
        if(attendeeSetting.sufix)
        selectedAttendeeFields += 'AS_Suffix__c,';
        if(attendeeSetting.Degi)
        selectedAttendeeFields += 'AS_Title__c,';
        if(attendeeSetting.mobile)
        selectedAttendeeFields += 'AS_CellPhone__c,';
        if(attendeeSetting.age)
        selectedAttendeeFields += 'AS_Age__c,';
        if(attendeeSetting.gen)
        selectedAttendeeFields += 'AS_Gender__c,';
        if(attendeeSetting.dob)
        selectedAttendeeFields += 'AS_BirthDate__c,';
        if(attendeeSetting.homeinfo)
        selectedAttendeeFields += 'AS_HomeAddress1__c,';
        if(attendeeSetting.Shippinginfo)
        selectedAttendeeFields += 'AS_ShippingAddress1__c,';
        if(attendeeSetting.workinfo)
        selectedAttendeeFields += 'AS_WorkAddress1__c,';
        if(attendeeSetting.NAICSCode1)
        selectedAttendeeFields += 'AS_NAICSCode1__c,';
        if(attendeeSetting.NAICSCode2)
        selectedAttendeeFields += 'AS_NAICSCode2__c,';
        if(attendeeSetting.NAICSCode3)
        selectedAttendeeFields += 'AS_NAICSCode3__c,';
        if(attendeeSetting.NAICSCode4)
        selectedAttendeeFields += 'AS_NAICSCode4__c,';
        if(attendeeSetting.NAICSCode5)
        selectedAttendeeFields += 'AS_NAICSCode5__c,';
        if(attendeeSetting.PBC)
        selectedAttendeeFields += 'AS_PrimaryBusinessCategory__c,';
        if(attendeeSetting.SBC)
        selectedAttendeeFields += 'AS_SecondaryBusinessCategory__c,';
        if(attendeeSetting.NOEmp)
        selectedAttendeeFields += 'AS_NumberOfEmployees__c,';
        if(attendeeSetting.BEDate)
        selectedAttendeeFields += 'AS_BusinessEstablishedDate__c,';
        if(attendeeSetting.BRev)
        selectedAttendeeFields += 'AS_BusinessRevenue__c,';
        if(attendeeSetting.BTaxID)
        selectedAttendeeFields += 'AS_BusinessTaxId__c,';
        if(attendeeSetting.BDN)
        selectedAttendeeFields += 'AS_BusinessDunsNumber__c,';
        if(attendeeSetting.webUrl)
        selectedAttendeeFields += 'AS_WebsiteUrl__c,';
        if(attendeeSetting.blogURL)
        selectedAttendeeFields += 'AS_BlogUrl__c,';
        if(attendeeSetting.DT)
        selectedAttendeeFields += 'AS_DiversityType__c,';
        if(attendeeSetting.BDesc)
        selectedAttendeeFields += 'AS_BusinessDescription__c,';
        if(attendeeSetting.AttendeePic)
        selectedAttendeeFields += 'AttendeePic,';
        
        
        
    //-------------------------*************   Ending of Include Fields **************---------------------------------    
    //-------------------------*************   start of REQUIRED Fields **************---------------------------------    
        String  selectedAttendeeReqFields = 'AS_FirstName__c,';
       
        if(attendeeSetting.Reqcomp){
         selectedAttendeeFields += 'AS_Company__c,';
         selectedAttendeeReqFields += 'AS_Company__c,';
        }
        if(attendeeSetting.ReqPrefix)
        selectedAttendeeReqFields += 'AS_Prefix__c,';
        if(attendeeSetting.Reqsufix)
        selectedAttendeeReqFields += 'AS_Suffix__c,';
        if(attendeeSetting.ReqDegi)
        selectedAttendeeReqFields += 'AS_Title__c,';
        if(attendeeSetting.Reqmobile){
        selectedAttendeeFields += 'AS_CellPhone__c,';
        selectedAttendeeReqFields += 'AS_CellPhone__c,';
        }
        if(attendeeSetting.Reqage)
        selectedAttendeeReqFields += 'AS_Age__c,';
        if(attendeeSetting.Reqgen)
        selectedAttendeeReqFields += 'AS_Gender__c,';
        if(attendeeSetting.Reqdob)
        selectedAttendeeReqFields += 'AS_BirthDate__c,';
        if(attendeeSetting.Reqhomeinfo)
        selectedAttendeeReqFields += 'AS_HomeAddress1__c,';
        if(attendeeSetting.ReqShippinginfo)
        selectedAttendeeReqFields += 'AS_ShippingAddress1__c,';
        if(attendeeSetting.Reqworkinfo)
        selectedAttendeeReqFields += 'AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkState__c,AS_WorkCountry__c,AS_WorkZip__c,';
        if(attendeeSetting.ReqNAICSCode1)
        selectedAttendeeReqFields += 'AS_NAICSCode1__c,';
        if(attendeeSetting.ReqNAICSCode2)
        selectedAttendeeReqFields += 'AS_NAICSCode2__c,';
        if(attendeeSetting.ReqNAICSCode3)
        selectedAttendeeReqFields += 'AS_NAICSCode3__c,';
        if(attendeeSetting.ReqNAICSCode4)
        selectedAttendeeReqFields += 'AS_NAICSCode4__c,';
        if(attendeeSetting.ReqNAICSCode5)
        selectedAttendeeReqFields += 'AS_NAICSCode5__c,';
        if(attendeeSetting.ReqPBC)
        selectedAttendeeReqFields += 'AS_PrimaryBusinessCategory__c,';
        if(attendeeSetting.ReqSBC)
        selectedAttendeeReqFields += 'AS_SecondaryBusinessCategory__c,';
        if(attendeeSetting.ReqNOEmp)
        selectedAttendeeReqFields += 'AS_NumberOfEmployees__c,';
        if(attendeeSetting.ReqBEDate)
        selectedAttendeeReqFields += 'AS_BusinessEstablishedDate__c,';
        if(attendeeSetting.ReqBRev)
        selectedAttendeeReqFields += 'AS_BusinessRevenue__c,';
        if(attendeeSetting.ReqBTaxID)
        selectedAttendeeReqFields += 'AS_BusinessTaxId__c,';
        if(attendeeSetting.ReqBDN)
        selectedAttendeeReqFields += 'AS_BusinessDunsNumber__c,';
        if(attendeeSetting.ReqwebUrl)
        selectedAttendeeReqFields += 'AS_WebsiteUrl__c,';
        if(attendeeSetting.ReqblogURL)
        selectedAttendeeReqFields += 'AS_BlogUrl__c,';
        if(attendeeSetting.ReqDT)
        selectedAttendeeReqFields += 'AS_DiversityType__c,';
        if(attendeeSetting.ReqBDesc)
        selectedAttendeeReqFields += 'AS_BusinessDescription__c,';
        if(attendeeSetting.ReqAttendeePic)
        selectedAttendeeReqFields += 'AttendeePic,';
        
        if(QuickRegBool) 
       {
           selectedAttendeeFields = 'AS_FirstName__c,AS_Company__c,AS_CellPhone__c,AS_WorkAddress1__c,';
       
        if(attendeeSetting.workAdd1)
        selectedAttendeeReqFields += 'AS_WorkAddress1__c,';
        if(attendeeSetting.workAdd2)
        selectedAttendeeReqFields += 'AS_WorkAddress2__c,';
        if(attendeeSetting.workcity)
        selectedAttendeeReqFields += 'AS_WorkCity__c,';
        if(attendeeSetting.workstate)
        selectedAttendeeReqFields += 'AS_WorkState__c,';
        if(attendeeSetting.workCountry)
        selectedAttendeeReqFields += 'AS_WorkCountry__c,';
        if(attendeeSetting.workzip)
        selectedAttendeeReqFields += 'AS_WorkZip__c,';
       } 
       
       
    
      selectedAttendeeFields = selectedAttendeeFields.substring(0, selectedAttendeeFields.lastIndexOf(','));
     
      selectedAttendeeReqFields = selectedAttendeeReqFields.substring(0, selectedAttendeeReqFields.lastIndexOf(','));
       
         
       events.EV_IncludedFields__c = selectedAttendeeFields ;
       
       events.Ev_RequiredFields__c = selectedAttendeeReqFields ;
       
       events.EV_QuickReg__c = QuickRegBool;
       
       events.EV_Publish__c = TRUE;
       //Payment Details  -  In the case of offline payments
       
        //Payment Details  -  In the case of offline payments
       
       if(chk1 == TRUE){
       events.Accept_Pay_at_the_Door_Payments__c= TRUE;  
       }
       
       if(chk2 == TRUE){
       events.Accept_Pay_by_Check_Payments__c = TRUE;
       }
       
      if(chk3 == TRUE){
       events.Accept_Send_an_Invoice_Payments__c= TRUE;
        }
        
        if(chk1 == FALSE && chk2 == FALSE && chk3 == FALSE ){
        events.Through_Paypal__c = TRUE;
        events.Paypal_Username__c = paypalEmail;
        events.Paypal_Password__c = paypalPassword;
        events.Signature__c  = paypalSignature;
      }
      
       upsert events;
        
        
        
        
        LIST<TicketTypes__c> tick = new LIST<TicketTypes__c>();
        for(innerForTicketTypes inn: innerTickets)
        {
            tick.add(inn.ticket);
        }
        
       LIST<Database.UpsertResult> ticketTypesResult= Database.upsert(tick, false);
      
        For(Database.UpsertResult tt: ticketTypesResult)
        {
           
           system.debug('UUUUUUUUUUUUUUUUUUUUUUUUU     '+ tt.getErrors() );
           
            if(!tt.isSuccess())
            {
            
            }
        }
        
        
        system.debug('VVVVVVVVVVVVVVVV     '+ TicketTypeDelete);
        
        LIST<TicketTypes__c> tt = [SELECT ID FROM TicketTypes__c WHERE ID IN: TicketTypeDelete ];
        
        DataBase.Delete(tt, false); 
        
        
        
        //  events.EV_Publish__c = 
        
        successBool = TRUE;
    }
    
    
    public String dataFromJavaScript{get; set;}
    public void loadData(){
    
        dataFromJavaScript =ApexPages.currentPage().getparameters().get('one');
        
        system.debug('DDDDDDDDDDDDDDDDDDDDDDD    '+  dataFromJavaScript );
    }
    
    
    public void geteventsRegistration(){
       
          if(eventSelected != NULL)
          {
          
           events = [SELECT ID, Name,EV_Title__c, EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,Signature__c,Paypal_Email__c,Paypal_Password__c,Paypal_Username__c,Accept_Pay_at_the_Door_Payments__c,Accept_Pay_by_Check_Payments__c,Accept_Send_an_Invoice_Payments__c FROM Event__c WHERE id =: eventSelected ];
             
           System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Events'+events);
          
           attendeesetting = new BL_EventAdminRegistration(eventSelected);
           
          //  ticketTypes.add(new TicketTypes__c());
            
            if(events.EV_QuickReg__c)
            {
                QuickRegBool = TRUE; 
            }else QuickRegBool = FALSE;
            
            
            ticketTypeMap = new MAP<ID, TicketTypes__c>([select id,TT_Amount__c,EV_id__c, Avilable_for_Portal__c,TT_Available__c, TT_Limit__c, TT_Name__c FROM TicketTypes__c WHERE EV_id__c =:eventSelected ORDER BY CreatedDate ASC ]);
            
           innerTickets = new LIST<innerForTicketTypes>(); 
           integer num = 0; 
           for(id i: ticketTypeMap.keyset() ) 
           {
               innerTickets.add(new innerForTicketTypes(ticketTypeMap.get(i), num, i));
                
               num++; 
           }
           
           ticketTypes = ticketTypeMap.values();
           
           
                     
            system.debug('1111111111111111   '+ ticketTypes );
            
            
            
            if(ticketTypes.isEmpty())
            {
               noTicketTypeBool = TRUE;
               
              
            }
            
            
            
            
          }
            
            demographBool =  FALSE;
            ticketBool = FALSE; 
            paymentBool = FALSE; 
            publishBool = FALSE;
        
        
            contBool = TRUE; 
            
            paypalEmail = events.Paypal_Username__c;
            paypalPassword= events.Paypal_Password__c;
            paypalSignature = events.Signature__c;

           if(events.Accept_Pay_at_the_Door_Payments__c == TRUE){
                        chk1= TRUE;}
       
           if(events.Accept_Pay_by_Check_Payments__c == TRUE){
                      chk2 = TRUE; }
           if(events.Accept_Send_an_Invoice_Payments__c== TRUE){
          chk3= TRUE;}

    }
    
    public void customToQuick(){
   
       
        
        system.debug('FFFFFFFFFFFFFFFFFFFFF   '+ ApexPages.currentPage().getparameters().get('cust'));
        
        String paramchange = ApexPages.currentPage().getparameters().get('cust');
        
        if( paramchange == 'quickToCustom'){
            
            QuickRegBool = FALSE;
            
            contBool = TRUE; 
            demographBool = FALSE;
            ticketBool = FALSE; 
            paymentBool = FALSE; 
            publishBool = FALSE; 
            
        
        
        }else if(paramchange == 'customtoquick'){
            
            QuickRegBool = TRUE;
            
            contBool = TRUE; 
            demographBool = FALSE;
            ticketBool = FALSE; 
            paymentBool = FALSE; 
            publishBool = FALSE; 
            
            
        }
        
        
        
    
    }
    
    public void delTicketType(){
    
   
       try{ 
         system.debug('1111111111111111111111    '+innerTickets.size()+'  4444    ' + ApexPages.currentPage().getparameters().get('deleteTicketType') ) ;
         
         
         String checkDelTic = ApexPages.currentPage().getparameters().get('deleteTicketTypeid');
         
         if(checkDelTic != NULL && checkDelTic != '')
         {
             TicketTypeDelete.add(checkDelTic);
         }
        innerTickets.remove(Integer.valueOf(ApexPages.currentPage().getparameters().get('deleteTicketType')));
        
        system.debug('2222222222222222222    '+innerTickets.size()) ;
         
        
        if(innerTickets.isEmpty())
        {
               noTicketTypeBool = TRUE;
        }else
        {
            LIST<innerForTicketTypes> listforForloop = new LIST<innerForTicketTypes>();
            listforForloop.addAll(innerTickets);
            
            innerTickets = new LIST<innerForTicketTypes>();
            
            Integer num = 0;
            for(innerForTicketTypes inn: listforForloop)
            {
                innerTickets.add(new innerForTicketTypes(inn.ticket, num, inn.ticId));
              num++;
            }
        
        }
        
        
       }catch(Exception e){} 
    
    }
    
    
    
    public class innerForTicketTypes
    {
        public TicketTypes__c ticket{get; set;}
        public Integer tno{get; set;}
        public id ticId{get; set;}
        
        public innerForTicketTypes(TicketTypes__c t, Integer i, id idn)
        {
            ticket = t;
            tno = i;
            ticId = idn;
        }
        
        
    }
    
    
    public pagereference payPalNotifier(){
    
            if(paypalbool==true){ 
            paypalEmailNotify = true;
           }else{
            paypalEmailNotify = false;
           }
   
            return null;    
    
    }
    public PageReference Reportsaction() {
        pagereference pg = new pagereference('/apex/BL_EventAdmin_Reports');
             pg.setredirect(true);
            return pg;
    }


    public PageReference AttendeesAction() {
    pagereference pg = new Pagereference('/apex/QRcode_Eventadmin_Attendees');
    pg.setredirect(true);    
        return pg;
    }


    public PageReference BoothAction() {
    pagereference pg = new Pagereference('/apex/BL_Eventadmin_samplebooth');
    pg.setredirect(true);    
        return pg;
    }


    public PageReference EventAction() {
     pagereference pg = new Pagereference('/apex/BL_Eventadmin_Events');
     pg.setredirect(true);    
        return pg;
        
    }


    public PageReference ProfileSettings() {
     pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile');
     pg.setredirect(true);    
        return pg;
        
    }
    public PageReference DashboardAction() {
       pagereference pg = new pagereference('/apex/BL_Eventadmin_Dashboard');
       pg.setredirect(true);
         return pg;
     }
    static testMethod void testrest(){
    PageReference pageRef = Page.BL_Eventadmin_Register;
    Test.setCurrentPage(pageRef);
    Event__c event1 = new Event__c(EV_Title__c='testEvent1',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 5392 Name badges',EventDiversityValues__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS');
    insert event1;
     apexpages.currentpage().getparameters().put('event' , event1.id);
    BL_Eventadmin_RegisterCon testcon=new BL_Eventadmin_RegisterCon();
    testcon.geteventsRegistration();
    testcon.eventselected=event1.id;
        testcon.geteventsRegistration();
        testcon.contactinfo();
        testcon.conTodemo();
        testcon.demoToTicket();
        testcon.ticketTopayment();
        testcon.paymentTopublish();
        testcon.moreTickets();
        testcon.previousAll();
        testcon.checkExiestance();
        testcon.SaveAllFields();
        
        apexpages.currentpage().getparameters().put('cust' , 'quickToCustom');
         testcon.customToQuick();
         apexpages.currentpage().getparameters().put('cust' , 'customtoquick');
        testcon.customToQuick();
        testcon.delTicketType();
        testcon.payPalNotifier();
        testcon.Reportsaction();
        testcon.AttendeesAction();
        testcon.BoothAction();
        testcon.EventAction();
        testcon.ProfileSettings();
        testcon.DashboardAction();
        
    }

}
@RestResource(urlMapping='/AS_Refresh/*')
  
 global with sharing class AS_Refresh{
    global static User LoginUser;
    global static Event__c eve;
    global static User_Pricing__c PricingInfo; 
    global static LIST<AttendeeSummary__c> UserAttendee = new LIST<AttendeeSummary__c>();
      
    @HttpGet
    global static Container doGet(){
        RestRequest req = RestContext.request;
        String EventID = req.params.get('EventID');
        String UserID = req.params.get('UserID');
        String dd=req.params.get('LastModifiedDate');
        system.debug('^^^ '+EventID+'&&&& '+UserID+'**** '+dd);
        system.debug(req.params.get('LastModifiedDate')+' LAST MODIFIED DATE '+dd);
        Datetime LastModifiedDateTime;
        
        String urlbase =URL.getSalesforceBaseUrl().getHost();
        String orgId = UserInfo.getOrganizationId();
        system.debug(orgId+'  BASE URL '+urlbase);
    
        try{
            String stringDate = dd.substring(6,10) + '-' + dd.substring(3,5) + '-' + dd.substring(0,2) + ' ' +dd.substring(11,19);
            LastModifiedDateTime = datetime.valueOf(stringDate);   
            //LastModifiedDateTime = datetime.valueOf(String.valueOf(LastModifiedDateTime));       
            System.debug('!!!!! '+LastModifiedDateTime);   
            System.debug('Formatted GMT Date '+String.valueOfGmt(LastModifiedDateTime));
            System.debug('Formatted Date '+String.valueOf(LastModifiedDateTime));

        }
        catch(Exception e){}

        Container ct=new Container();
        Commanforstates con = new Commanforstates();
        
        LoginUser = [SELECT Id,ProfileId,Username,FirstName,LastName,Email,Companyphone__c,CompanyName,States__c,Country__c,CompanyCity__c FROM User WHERE Id=:UserID];
        UserAttendee  = [SELECT Id,AS_ImageUrl__c,AS_FirstName__c,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WorkPhone__c,AS_WorkCity__c,AS_WorkState__c,AS_WorkCountry__c FROM AttendeeSummary__c WHERE AS_Email__c=: LoginUser.UserName LIMIT 1];
         
        try{
        PricingInfo = new User_Pricing__c();
        PricingInfo = [SELECT Id,User__c,Subscribed_Date__c,Expiry_Date__c,Pricing__c,UserLimit__c,EventLimit__c,AttendeeLimit__c,Amount__c,Subscription_Type__c,Pricing__r.BLP_AccountType__c,Pricing__r.BLP_UserLimit__c,Pricing__r.BLP_EventLimit__c,Pricing__r.BLP_AttendeeLimit__c,Pricing__r.BLP_Amount__c,Pricing__r.BLP_SignUp__c,Pricing__r.App_Access__c 
                        FROM User_Pricing__c
                        WHERE User__c =:LoginUser.Id];
        }catch(exception e){}
        
        AccountDetails AccDetail= new AccountDetails();
        LIST<App_Settings__c> AppSettingsList= new LIST<App_Settings__c>();
        AppSettingsList= [SELECT ID, Fee__c, Client_Id__c, Secret_Id__c, Redirect_URL__c, Paypal_Key__c FROM App_Settings__c WHERE User_Type__c =: 'ScanAttendee User'];
        
        LIST<Pay_Pal_Account__c> PayPalDetails= new LIST<Pay_Pal_Account__c>();
        PayPalDetails= [SELECT ID, OurEmail__c, Email_Id__c FROM Pay_Pal_Account__c WHERE User_Email__c =: LoginUser.Username];
        system.debug(' PAYPAL DETAILS '+PayPalDetails);
        Decimal Fee=0;
        if(AppSettingsList.size() >0){
            if(AppSettingsList[0].Fee__c != NULL){
                Fee= AppSettingsList[0].Fee__c;
            }else{
                Fee= 0;
            }
            
            AccDetail.ClientId= AppSettingsList[0].Client_Id__c;
            AccDetail.SecretId= AppSettingsList[0].Secret_Id__c; 
            AccDetail.RedirectURL= AppSettingsList[0].Redirect_URL__c;
            AccDetail.PaypalKey= AppSettingsList[0].Paypal_Key__c;

        }
        
        String EventAdminPayPalEmail;  
        system.debug(PayPalDetails.size()+' FILL PAYPAL EMAIL STRING000000000000  '+EventAdminPayPalEmail);
        if(PayPalDetails.size() >0){
            EventAdminPayPalEmail= PayPalDetails[0].Email_Id__c;
            AccDetail.PayPalEmail= PayPalDetails[0].OurEmail__c;
            system.debug(PayPalDetails[0].Email_Id__c+' FILL PAYPAL EMAIL STRING  '+EventAdminPayPalEmail);
        }
        ct.User_Details.add(new User_Details(LoginUser.Id,LoginUser.FirstName,LoginUser.LastName,LoginUser.CompanyName,LoginUser.CompanyCity__c,con.mapstate(LoginUser.States__c),LoginUser.States__c, LoginUser.Companyphone__c,LoginUser.Email,LoginUser.Country__c,con.mapstate(LoginUser.Country__c),UserAttendee[0].AS_ImageUrl__c,PricingInfo.Pricing__r.BLP_AccountType__c,PricingInfo.UserLimit__c,PricingInfo.EventLimit__c,PricingInfo.AttendeeLimit__c,PricingInfo.Amount__c,PricingInfo.Subscribed_Date__c,PricingInfo.Expiry_Date__c,PricingInfo.Pricing__r.BLP_SignUp__c, Fee, EventAdminPayPalEmail));
        ct.AccDetails= AccDetail;
        
        try{
            eve = [SELECT Id, Badge_Name__c, EV_EventLogo__c, Fee_Type__c, Sales_Tax__c, LastModifiedDate,StartTime__c,EV_EndTime__c,EV_HostingStateNew__c,EV_HostingCountryNew__c,EV_HostingZipcode__c,EV_StartDate__c,EV_EndDate__c,EV_Title__c,EV_Description__c,AS_HostingCity__c,EV_HistingAddr1__c,EV_HostingLocation__c,isActive__c FROM Event__c WHERE Id=:EventID AND isActive__c=:true];
            ct.Event_State =  con.mapstate(eve.EV_HostingStateNew__c);
            ct.Event_State_LongCode=eve.EV_HostingStateNew__c;
            ct.Event_ZipCode=eve.EV_HostingZipcode__c;
            ct.Event_Country=con.mapstate(eve.EV_HostingCountryNew__c);
            ct.Event_Country_LongCode=eve.EV_HostingCountryNew__c;
            ct.Event_StartDate=eve.EV_StartDate__c;
            ct.Event_EndDate=eve.EV_EndDate__c;
            ct.Event_Name=eve.EV_Title__c; 
            ct.Event_Decription=eve.EV_Description__c;
            ct.Event_City=eve.AS_HostingCity__c;
            ct.Event_ID=eve.id;
            ct.Event_StartTime=eve.StartTime__c;
            ct.Event_EndTime=eve.EV_EndTime__c;
            ct.Event_Address=eve.EV_HistingAddr1__c;
            ct.Event_Location=eve.EV_HostingLocation__c;
            ct.SalesTax= String.valueOf(eve.Sales_Tax__c);
            ct.BadgeName= eve.Badge_Name__c;
            
            ct.EventLogoImageURL= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve.EV_EventLogo__c; 
                      
            system.debug('  FEE TYPE  '+eve.Fee_Type__c);
            if(eve.Fee_Type__c == 'Include the fee in the ticket price'){
                ct.FeeApplicable= TRUE;
            }else if(eve.Fee_Type__c== 'Charge the fee to the customer'){
                ct.FeeApplicable= FALSE;            
            }
            system.debug(ct.FeeApplicable+'  FEE TYPE  '+eve.Fee_Type__c);            
            ct.isEventAdminStaffUser= FALSE;            
            LIST<User_Profile_Event__c> profileUser= new LIST<User_Profile_Event__c>();
            system.debug(eve.id+'  EVENT ID '+UserID);
            profileUser= [SELECT ID 
                          FROM User_Profile_Event__c 
                          WHERE User_id__c =: UserID
                          AND EV_id__c =: eve.id
                          AND Profile_id__r.PR_Name__c =: 'EventAdmin Staff'
                          AND UEP_isActive__c =: TRUE];
            system.debug(profileUser.size()+'  PORTAL USER '+profileUser);
            if(profileUser.size() >0){
                ct.isEventAdminStaffUser= TRUE;
            }
            
        }
        catch(Exception ex){   
            ct.Error = 'No Such Event Exists!';  
        }
        
    system.debug('@@@@@@ '+eve);
    
    String ticketimageURL ='';
    String itemimageURL ='';
    String EventState ='';
    String EventCountry ='';
    String AttendeeState ='';
    String AttendeeCountry ='';
    
    // Get List Of Events
    LIST<User_Profile_Event__c> EventsList= new LIST<User_Profile_Event__c>();
     EventsList = [SELECT EV_id__r.Status__c,EV_id__r.StartTime__c, EV_id__r.SecondaryCategory__c,
                  EV_id__r.Primary__c, EV_id__r.Name, EV_id__r.Id, EV_id__r.EV_Title__c, EV_id__r.EV_StartDate__c, EV_id__r.EV_HostingZipcode__c, 
                  EV_id__r.EV_HostingTimeZone__c, EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingPostalCode__c,
                  EV_id__r.EV_HostingPhone__c, EV_id__r.EV_HostingLocation__c, EV_id__r.EV_HostingCountry__c,EV_id__r.EV_HostingCountryNew__c,EV_id__r.TwitterId__c,EV_id__r.FacebookId__c,EV_id__r.OrganizerId__c,
                  EV_id__r.EV_HostedByEventBrite__c, EV_id__r.EV_HistingAddr1__c, EV_id__r.EV_EventLogo__c,EV_id__r.CCRDetails_Required__c, 
                  EV_id__r.EV_EndTime__c,EV_id__r.EV_EndDate__c, EV_id__r.EV_Description__c, Profile_id__r.PR_Name__c,EV_id__r.EV_HostingStateNew__c,
                  EV_id__r.CreatedDate,EV_id__r.isActive__c, EV_id__r.Attendee_Tags__c,EV_id__r.EV_HostingOrgName__c, EV_id__r.AS_HostingCity__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.Is_MatchMaking_Event__c, 
                  EV_id__r.Sales_Tax__c, EV_id__r.Fee_Type__c, EV_id__r.Badge_Name__c
                  FROM User_Profile_Event__c 
                  WHERE EV_id__c != NULL 
                  AND EV_id__r.isActive__c =: true
                  AND User_id__c=: LoginUser.ID
                  AND UEP_isActive__c =: TRUE
                  AND (Profile_id__r.PR_Name__c =: 'EventAdmin' OR Profile_id__r.PR_Name__c =: 'EventAdmin Staff')];
    
    for(User_Profile_Event__c ev: EventsList){
        Datetime startDatetime;
        try{
            startDatetime = datetime.newInstance(ev.EV_id__r.EV_StartDate__c, time.newInstance(0,0,0,0));
        }
        catch(Exception e){}
        String myDatetimeStr;
        try{
            myDatetimeStr = startDatetime.format('MMMM d, yyyy');
        }
        catch(Exception e){}                
        Datetime endDatetime;
        try{
            endDatetime  = datetime.newInstance(ev.EV_id__r.EV_EndDate__c, time.newInstance(0,0,0,0));
        }
        catch(Exception e){}
        String myDatetimeStr1;
        try{
            myDatetimeStr1= endDatetime.format('MMMM d, yyyy');
        }
        catch(Exception e){}
        Boolean isDeleted;
        if(ev.EV_id__r.isActive__c == TRUE){
            isDeleted = FALSE;
        }else{
            isDeleted = TRUE;
        }
        Boolean FeeApp= FALSE;
        if(ev.EV_id__r.Fee_Type__c == 'Include the fee in the ticket price'){
            FeeApp= TRUE;
        }else if(ev.EV_id__r.Fee_Type__c== 'Charge the fee to the customer'){
            FeeApp= FALSE;            
        }
        system.debug('  FEE APP '+FeeApp);
        EventState = con.mapstate(ev.EV_id__r.EV_HostingStateNew__c);
        EventCountry = con.mapstate(ev.EV_id__r.EV_HostingCountryNew__c);
        system.debug(ev.EV_id__r.EV_HostingCountryNew__c+'  LONG COUNTRY STATE '+ev.EV_id__r.EV_HostingStateNew__c);
        system.debug(EventCountry +'  SHORT COUNTRY STATE '+EventState );
        String EventLogo= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+ev.EV_id__r.EV_EventLogo__c; 
            
        ct.Edetails.add(new Edetails(ev.EV_id__r.EV_Title__c,myDatetimeStr,myDatetimeStr1,ev.EV_id__r.StartTime__c,ev.EV_id__r.EV_EndTime__c,ev.EV_id__r.EV_HistingAddr1__c,ev.EV_id__r.EV_HostingLocation__c,ev.EV_id__r.id,ev.EV_id__r.AS_HostingCity__c,EventState,ev.EV_id__r.EV_HostingStateNew__c,ev.EV_id__r.EV_Description__c,EventCountry,ev.EV_id__r.EV_HostingCountryNew__c,ev.EV_id__r.EV_HostingZipcode__c,isDeleted, String.valueOf(ev.EV_id__r.Sales_Tax__c), FeeApp, EventLogo, ev.EV_id__r.Badge_Name__c,ev.EV_id__r.EV_HostingCountryNew__c, ev.EV_id__r.EV_HostingZipcode__c));
    }
    
         
    //Get Ticket Types For Event
    for(TicketTypes__c tt:[SELECT Id,isDeleted,LastModifiedDate,EV_id__c,TT_Sold__c,TT_Available__c,TT_Amount__c,TT_Name__c,TT_TicketType__c,Ticket_Category__c,Ticket_Image_URL__c FROM TicketTypes__c WHERE EV_id__c=:EventID and LastModifiedDate >=:LastModifiedDateTime All rows]){
        ticketimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+tt.Ticket_Image_URL__c;
        ct.TicketTypes.add(new TicketTypes(tt.EV_id__c,tt.TT_Name__c ,tt.TT_Amount__c,tt.TT_Available__c,tt.TT_Sold__c,tt.id,tt.TT_TicketType__c,tt.Ticket_Category__c,ticketimageURL,tt.isDeleted));
        system.debug('#### '+tt);
    } 
    
    //Get Items For Event
    for(Item__c item:[SELECT Id,isDeleted,Event__c,Item_name__c,Cost__c,Item_Quantity__c,Item_Image__c,Sold_Quantity__c,isTaxable__c,Sales_Tax__c FROM Item__c WHERE Event__c=:EventID and LastModifiedDate >=: LastModifiedDateTime All rows]){
        itemimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+item.Item_Image__c;
     
        ct.ItemDetails.add(new ItemDetails(item.Event__c,item.Item_name__c,item.Cost__c,item.id,item.Item_Quantity__c,itemimageURL ,item.Sold_Quantity__c,item.isTaxable__c,item.Sales_Tax__c,item.isDeleted));
        system.debug('Item Details:' +Item);
    }  
    system.debug('  EVENT ID FOR TEST '+EventID);
    includeSADetailsToBLEvent insertTickets= new includeSADetailsToBLEvent();          
    insertTickets.insertGuestToAttendee(EventID);
    
    //Get Attendee Details For Event
    for(Event_Attendee_Mapping__c evatmap:[SELECT isDeleted,GuestType__c, EA_AttendeeBarcode__c, MobileCheckInTime__c,IsCancelled__c,AS_id__r.AS_CellPhone__c, AS_id__c,EV_id__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Title__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND (AS_id__r.LastModifiedDate >=: LastModifiedDateTime OR LastModifiedDate>=:LastModifiedDateTime) All rows]){
        system.debug('   ATTENDEE EVENT:  ' +evatmap);
        AttendeeState  = con.mapstate(evatmap.AS_id__r.AS_Work_States__c);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  //  AND IsCancelled__c!= TRUE 
        AttendeeCountry  = con.mapstate(evatmap.AS_id__r.AS_Work_Country__c);
        system.debug(evatmap.AS_Id__r.AS_Lastname__c+'   ATTENDEE DETAILS '+evatmap.MobileCheckInTime__c);
        ct.Attendee_Details.add(new Attendee_Details(evatmap.MobileCheckInTime__c,evatmap.AS_id__c,evatmap.EV_id__c,evatmap.AS_id__r.AS_FirstName__c,evatmap.AS_id__r.AS_LastName__c,evatmap.AS_id__r.AS_Email__c,evatmap.AS_id__r.AS_WorkCity__c,AttendeeState,evatmap.AS_id__r.AS_Work_States__c,evatmap.AS_id__r.AS_Company__c,evatmap.AS_id__r.AS_WorkPhone__c,evatmap.AS_id__r.AS_Title__c,evatmap.AS_id__r.AS_ImageUrl__c,evatmap.AS_id__r.AS_WorkAddress1__c,evatmap.AS_id__r.AS_WorkAddress2__c,AttendeeCountry,evatmap.AS_id__r.AS_Work_Country__c,evatmap.AS_id__r.AS_WorkZip__c,evatmap.IsCancelled__c, evatmap.EA_AttendeeBarcode__c, evatmap.GuestType__c));
    }
     
    //Get Payment Info For Event
    Payment_Info rg=new Payment_Info();  
    for(Individual_Ticket_Info__c iti:[SELECT Name,CreatedDate,Total_Amount__c,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.Item_Quantity__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.Id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Item__r.item_Name__c,Registration_Info__r.Item__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_Id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c=TRUE AND Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c != TRUE AND LastModifiedDate>=: LastModifiedDateTime ORDER BY Name]){
        String ischeckin;
        String DateTimeStr;
        try{
            DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy HH:mm a');
        }
        catch(exception ex){}
        Decimal IndividualAmount;
        if(iti.Registration_Info__r.Item_Quantity__c>1){
            IndividualAmount = iti.Registration_Info__r.TicketAmount__c/iti.Registration_Info__r.Item_Quantity__c;
        }else{
            IndividualAmount = iti.Registration_Info__r.TicketAmount__c;
        }
        
        if(iti.isCheckedIn__c==true)
            ischeckin=iti.Name;
        else
            ischeckin='';
        rg.Item_Payment_Info.add(new Item_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.isCheckedIn__c,IndividualAmount,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.Item__r.item_Name__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c));
    }
   
    for(Individual_Ticket_Info__c iti:[SELECT Name,CreatedDate,Total_Amount__c,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_Id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE AND LastModifiedDate >=: LastModifiedDateTime ORDER BY Name]){
        system.debug('Iti List '+iti);
        String ischeckin;
        String DateTimeStr;
        String CheckInTime;
        String CheckOutTime;
        try{
            DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm a');
        }
        catch(exception ex){}
        if(iti.isCheckedIn__c==true)
            ischeckin=iti.Name;
        else
            ischeckin='';
        for(User_CheckinHistory__c uc: iti.User_CheckinHistory__r){
           CheckInTime = uc.UC_CheckinTime__c;
           CheckOutTime = uc.CheckoutTime__c;
        }
        rg.Ticket_Payment_Info.add(new Ticket_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.Seat__c,ischeckin,iti.Total_Amount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.TicketTypes__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,iti.Registration_Info__r.TicketTypes__r.TT_Name__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c,CheckInTime,CheckOutTime));
    }

    for(Individual_Ticket_Info__c iti:[SELECT Name,Amount__c, Total_Amount__c,Refund_Amount__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,IsCancelled__c,isItem__c,Refund_Date__c,Refund_Mode__c,CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_Id__c FROM Individual_Ticket_Info__c WHERE isCancelled__c =: TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND LastModifiedDate>=: LastModifiedDateTime ORDER BY Name]){
        String ischeckin;
        String DateTimeStr;
        try{
            DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy HH:mm a');
        }
        catch(exception ex){}
        String DateTimeStr1;
        try{
            DateTimeStr1 = iti.Refund_Date__c.format('MMMM d, yyyy HH:mm a');
        }
        catch(exception ex){}
        if(iti.isCheckedIn__c==true){
            ischeckin=iti.Name;
        }
        else{
            ischeckin='';
        }      
        rg.Refund_Info.add(new Refund_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c+' '+iti.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,iti.Registration_Info__r.Check_number__c,iti.Seat__c,ischeckin,iti.Total_Amount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.TicketTypes__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,iti.Registration_Info__r.TicketTypes__r.TT_Name__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c,String.valueOf(iti.Refund_Amount__c),DateTimeStr1,iti.Refund_Mode__c, iti.Amount__c,  iti.Registration_Info__r.Item__r.Item_name__c));
    }  
    ct.Payment_Info.add(rg); 
    try{
     ct.totalAttendee=[SELECT count() FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND IsCancelled__c!= TRUE];}catch(Exception e){}
     return ct;
    }
    
    global class Container
    {
        List<TicketTypes> TicketTypes{get;set;} 
        List<ItemDetails> ItemDetails{get;set;} 
        List<Attendee_Details> Attendee_Details{get;set;} 
        List<User_Details> User_Details{get;set;} 
        List<Edetails> Edetails{get;set;} 
        public Date Event_StartDate{get;set;}
        public Date Event_EndDate{get;set;}
        public String Event_Name{get;set;}
        public String Event_Decription{get;set;}
        public String Event_StartTime{get;set;}
        public String Event_EndTime{get;set;}
        public String Event_Location{get;set;}
        public String Event_Address{get;set;}
        public String Event_City{get;set;}
        public String Event_State{get;set;}
        public String Event_State_LongCode{get;set;}
        public String Event_Country{get;set;}
        public String Event_Country_LongCode{get;set;}
        public String Event_ZipCode{get;set;}
        public Id Event_ID{get;set;}
        public List<Payment_Info> Payment_Info{get;set;}
        public String Error{get;set;}
        public Boolean isEventAdminStaffUser{get; set;}
        public String SalesTax{get; set;}
        public Boolean FeeApplicable{get; set;}
        public String EventLogoImageURL{get; set;}           
        public String BadgeName{get; set;}
        public AccountDetails AccDetails; 
        public Integer totalAttendee{get;set;}                                       
        public Container()
        {
          TicketTypes=new List<TicketTypes>();
          ItemDetails=new List<ItemDetails>();
          Attendee_Details=new List<Attendee_Details>();          
          Payment_Info=new List<Payment_Info>();  
          User_Details= new LIST<User_Details>();   
          Edetails= new LIST<Edetails>(); 
          AccDetails= new AccountDetails();         
        }
    }
    
    
    global class TicketTypes
    {    
        public String Ticket_Name{get;set;}
        public Decimal Ticket_Price{get;set;}
        public Decimal Ticket_Quantity{get;set;}
        public Decimal Ticket_QuantitySold{get;set;}
        public String Ticket_Type{get;set;}
        public String Ticket_Category{get;set;}
        public String Ticket_ImageUrl{get;set;}
        public Id Ticket_Id{get; set;}
        public Id Event_Id{get;set;}
        public Boolean isDeleted{get;set;}
        
       public TicketTypes(Id Event_Id,String tname,Decimal tcktpr,Decimal tcktqnt,Decimal tcktqntsold,Id tid,String ttype,String tcategory,String timage,Boolean isDeleted) {
            this.Event_Id=Event_Id;
            this.Ticket_Name= tname;
            this.Ticket_Price= tcktpr;
            this.Ticket_Quantity= tcktqnt;
            this.Ticket_QuantitySold= tcktqntsold;
            this.Ticket_Id= tid;
            Ticket_Type=ttype;
            Ticket_Category=tcategory;
            Ticket_ImageUrl=timage;
            this.isDeleted=isDeleted;
        }   
    }
    
    global class Edetails{
        public String Event_Name{get;set;}
        public String Event_StartDate{get;set;}
        public String Event_EndDate{get;set;}
        public String Event_StartHour{get;set;}
        public String Event_EndHour{get;set;}
        public String HostingAddr1{get;set;}
        public String Event_Location{get;set;}
        public String Event_ID{get;set;}
        public String HostingCity{get;set;}
        public String HostingState{get;set;}
        public String HostingState_LongCode{get;set;}
        public String Event_Description{get;set;}
        public String Event_Country{get;set;}
        public String Event_Country_LongCode{get;set;}
        public String Event_ZipCode{get;set;}
        public Boolean isDeleted{get;set;}
        public String SalesTax{get;set;}
        public Boolean FeeApplicable{get; set;}
        public String EventLogoImageURL{get; set;}           
        public String BadgeName{get; set;}   
        public String HostingCountry_LongCode{get; set;}   
        public String HostingZipcode{get; set;}      
                                 
        public Edetails(String Event_Name1,String Event_StartDate1,String Event_EndDate1,String Event_StartTime1,String Event_EndTime1,String Event_Address1,String Event_Location1,String Event_ID1,String Event_City1,String Event_State1,String Event_State_LongCode1,String Event_Description1,String Event_Country1,String Event_Country_LongCode1,String Event_ZipCode1,Boolean isDeleted, String SalesTax, Boolean FeeApplicable, String EventLogoImageURL, String BadgeName, String HostingCountry_LongCode, String HostingZipcode){
            this.Event_Name=Event_Name1;
            this.Event_StartDate=Event_StartDate1;
            this.Event_EndDate=Event_EndDate1; 
            this.Event_Description=Event_Description1;
            this.HostingCity=Event_City1;
            this.HostingState=Event_State1;
            this.HostingState_LongCode=Event_State_LongCode1;
            this.Event_ID=Event_ID1;
            this.Event_StartHour=Event_StartTime1;
            this.Event_EndHour=Event_EndTime1;
            this.HostingAddr1=Event_Address1;
            this.Event_Location=Event_Location1;
            this.Event_Country=Event_Country1;
            this.Event_Country_LongCode=Event_Country_LongCode1;
            this.Event_ZipCode=Event_ZipCode1;
            this.isDeleted=isDeleted;
            this.SalesTax= SalesTax;
            this.FeeApplicable= FeeApplicable;
            this.EventLogoImageURL= EventLogoImageURL;
            this.BadgeName= BadgeName;
            this.HostingCountry_LongCode= HostingCountry_LongCode;
            this.HostingZipcode= HostingZipcode;
        }
    }
    
    
    
     global class User_Details{   
     
        public Id UserID{get;set;}
        public String FirstName{get;set;}       
        public String LastName{get;set;}       
        public String Company{get;set;}        
        public String City{get;set;}       
        public String State{get;set;}
        public String State_LongCode{get;set;}
        public String Country{get;set;}
        public String Country_LongCode{get;set;}
        public String PhoneNo{get;set;}
        public String Email{get;set;}
        public String ImageUrl{get;set;}
        public String AccountType{get;set;}
        public Decimal UserLimit{get;set;}
        public Decimal EventLimit{get;set;}
        public Decimal AttendeeLimit{get;set;}
        public Decimal AmountPaid{get;set;}
        public Date SubscribedDate{get;set;}
        public Date ExpiryDate{get;set;}
        public String SignUp{get;set;}
        public Decimal Fee;
        public String EventAdminPayPalEmail{get; set;}
                        
        public User_Details(Id UserID1,String FirstName1,String LastName1,String Company1,String City1,String State1,String State_LongCode1,String PhoneNo1,String Email1,String Country1,String Country_LongCode1,String ImageUrl1,String AccountType1,Decimal UserLimit1,Decimal EventLimit1,Decimal AttendeeLimit1,Decimal AmountPaid1,Date SubscribedDate1,Date ExpiryDate1,String SignUp1, Decimal Fee1, String EventAdminPayPalEmail1){
            this.UserID =UserID1;
            this.FirstName = FirstName1;               
            this.LastName = LastName1;               
            this.Company = Company1;               
            this.City = City1;               
            this.State= State1;   
            this.State_LongCode= State_LongCode1;           
            this.PhoneNo = PhoneNo1;               
            this.Email = Email1;               
            this.Country = Country1;
            this.Country_LongCode = Country_LongCode1;
            this.ImageUrl = ImageUrl1;
            this.AccountType = AccountType1;
            this.UserLimit = UserLimit1;
            this.EventLimit = EventLimit1;
            this.AttendeeLimit = AttendeeLimit1;
            this.AmountPaid = AmountPaid1;
            this.SubscribedDate = SubscribedDate1;
            this.ExpiryDate = ExpiryDate1;
            this.SignUp = SignUp1;
            this.Fee= Fee1;
            this.EventAdminPayPalEmail= EventAdminPayPalEmail1;

        }
    }
    
    global class AccountDetails{
    
        String ClientId;
        String SecretId;
        String RedirectURL;
        String PaypalKey;
        String PayPalEmail;
        
        global AccountDetails(){}
        
        global AccountDetails(String ClientId, String SecretId, String RedirectURL, String PaypalKey, String PayPalEmail){
            
            ClientId= ClientId;
            SecretId= SecretId;
            RedirectURL= RedirectURL;
            PaypalKey= PaypalKey;
            PayPalEmail= PayPalEmail;
                        
        }
    }
    
    global class ItemDetails
    {    
        public String Item_Name{get;set;}
        public Decimal Item_Price{get;set;}
        public Id Item_Id{get; set;}
        public Decimal Item_Quantity{get;set;}
        public String Item_Image{get;set;}
        public Decimal Sold_Quantity{get;set;}
        public boolean isTaxable{get;set;}
        public Decimal SalesTax{get;set;}
        public Id Event_Id{get;set;}
        public Boolean isDeleted{get;set;}
        
       public ItemDetails(Id Event_Id,String iname,Decimal itempr,Id itmid,Decimal Item_Quantity,String Item_Image,Decimal Sold_Quantity,boolean isTaxable,Decimal SalesTax,Boolean isDeleted) {
            this.Event_Id=Event_Id;
            this.Item_Name= iname;
            this.Item_Price= itempr;
            this.Item_Id= itmid;
            this.Item_Quantity=Item_Quantity;
            this.Item_Image=Item_Image;
            this.Sold_Quantity=Sold_Quantity;
            this.isTaxable=isTaxable;
            this.SalesTax=SalesTax;
            this.isDeleted=isDeleted;
        }
       
    }
    
    
    global class Attendee_Details
    {    
       public Id id{get; set;}
       public Id Event_Id{get;set;}
       public String Attendee_FirstName{get;set;}
       public String Attendee_LastName{get;set;}       
       public String Attendee_Email{get;set;}
       public String City{get;set;}
       public String State{get;set;}
       public String State_LongCode{get;set;}
       public String Company{get;set;}
       public String Phone{get;set;}
       public String Designation{get;set;}
       public String Attendee_ImageUrl{get;set;}
       public String Address1{get;set;}
       public String Address2{get;set;}
       public String Country{get;set;}
       public String Country_LongCode{get;set;}
       public String Zipcode{get;set;}
       public String MobileCheckInTime{get;set;} 
       public Boolean isDeleted{get;set;}
       public String QrcodeIds{get; set;}
       public String AttendeeCategory{get; set;}
              
       public Attendee_Details(String MobileCheckInTime,Id attid,Id eventid,String firstname,String lastname,String email,String city,String state,String stateLongCode,String Company,String Phone,String Designation,String Attendee_ImageUrl,String Address1,String Address2,String Country,String CountryLongCode,String Zipcode,Boolean isDeleted, String QrcodeIds, String AttendeeCategory) {
        this.MobileCheckInTime=MobileCheckInTime;
        this.id=attid;
        this.Event_Id=eventid;
        this.Attendee_FirstName=firstname;
        this.Attendee_LastName=lastname;
        this.Attendee_Email=email;
        this.City=city;
        this.State=state;
        this.State_LongCode=stateLongCode;
        this.Company=Company;
        this.Phone=Phone;
        this.Designation=Designation;
        this.Attendee_ImageUrl=Attendee_ImageUrl;
        this.Address1=Address1;
        this.Address2=Address2;
        this.Country=Country;
        this.Country_LongCode=CountryLongCode;
        this.Zipcode=Zipcode; 
        this.isDeleted=isDeleted;
        this.QrcodeIds= QrcodeIds;
        this.AttendeeCategory= AttendeeCategory;
       }
       
    }
    
    global class Payment_Info
    {
      public String Event_Id{get;set;}
      public String Attendee_Id{get;set;}
      List<Ticket_Payment_Info> Ticket_Payment_Info{get;set;} 
      List<Item_Payment_Info> Item_Payment_Info{get;set;} 
      List<Refund_Info> Refund_Info{get;set;}
      
      public Payment_Info()
      {
       Ticket_Payment_Info=new List<Ticket_Payment_Info>();          
       Item_Payment_Info=new List<Item_Payment_Info>();  
       Refund_Info=new List<Refund_Info>();                 
      }
    }
    
    global class Refund_Info{    
    
       public Id Ticket_Id{get; set;}
       public Id Event_Id{get;set;}
       public String Ticket_Number{get;set;}
       public String Payment_Status{get;set;}
       public String Ticket_Name{get;set;}
       public String AttendeeId{get;set;}
       public String ItemId{get;set;}
       public String PaymentType{get;set;}
       public Decimal TicketQuantity{get;set;}
       public String CheckNo{get;set;}
       public String Seat_No{get;set;}
       public String isCheckedIn{get;set;}
       public Decimal TicketAmount{get;set;}
       public String PaymentTime{get;set;}  
       public String PaymentId{get;set;}
       public String PayKey{get;set;}
       public String RefundAmount{get;set;}
       public String RefundDate{get;set;}
       public String AttendeeName{get;set;}
       public String RefundMode{get;set;}
       public Decimal ActualAmount{get; set;}
       public String ItemName{get;set;}
       
       public Refund_Info(String PaymentType,Decimal TicketQuantity,String AttendeeName,String CheckNo,String Seat_No,String isCheckedIn,Decimal TicketAmount,
       String AttendeeId,String ItemId,Id Ticket_Id,Id Event_Id,String Ticket_Number,String Payment_Status,String Ticket_Name,String PaymentTime,String PaymentID,String PayKey,String RefundAmount,String RefundDate,String RefundMode, Decimal ActualAmount, String ItemName) 
       {
         this.PaymentType=PaymentType;
         this.TicketQuantity=TicketQuantity;
         this.AttendeeName=AttendeeName;
         this.CheckNo=CheckNo;
         this.Seat_No=Seat_No;
         this.isCheckedIn=isCheckedIn;
         this.TicketAmount=TicketAmount;
         this.AttendeeId=AttendeeId;
         this.ItemId=ItemId;
         this.Ticket_Id=Ticket_Id;
         this.Event_Id=Event_Id;
         this.Ticket_Number=Ticket_Number;
         this.Payment_Status=Payment_Status;
         this.Ticket_Name=Ticket_Name; 
         this.PaymentTime=PaymentTime;  
         this.PaymentId=PaymentID;
         this.PayKey=PayKey; 
         this.RefundAmount=RefundAmount;
         this.RefundDate=RefundDate;
         this.RefundMode=RefundMode;
         this.ActualAmount= ActualAmount;
         this.ItemName= ItemName;
        }
       
    }
    
    global class Ticket_Payment_Info{    
    
       public Id Ticket_Id{get; set;}
       public Id Event_Id{get;set;}
       public String Ticket_Number{get;set;}
       public String Payment_Status{get;set;}
       public String Ticket_Name{get;set;}
       public String AttendeeId{get;set;}
       public String ItemId{get;set;}
       public String PaymentType{get;set;}
       public Decimal TicketQuantity{get;set;}
       public String CheckNo{get;set;}
       public String Seat_No{get;set;}
       public String isCheckedIn{get;set;}
       public Decimal TicketAmount{get;set;}
       public String PaymentTime{get;set;}  
       public String PaymentId{get;set;}
       public String PayKey{get;set;}
       public String CheckInTime{get;set;}
       public String CheckOutTime{get;set;}
       
       public Ticket_Payment_Info(String PaymentType,Decimal TicketQuantity,String CheckNo,String Seat_No,String isCheckedIn,Decimal TicketAmount,
       String AttendeeId,String ItemId,Id Ticket_Id,Id Event_Id,String Ticket_Number,String Payment_Status,String Ticket_Name,String PaymentTime,String PaymentID,String PayKey,String CheckInTime,String CheckOutTime) 
       {
         this.PaymentType=PaymentType;
         this.TicketQuantity=TicketQuantity;
         this.CheckNo=CheckNo;
         this.Seat_No=Seat_No;
         this.isCheckedIn=isCheckedIn;
         this.TicketAmount=TicketAmount;
         this.AttendeeId=AttendeeId;
         this.ItemId=ItemId;
         this.Ticket_Id=Ticket_Id;
         this.Event_Id=Event_Id;
         this.Ticket_Number=Ticket_Number;
         this.Payment_Status=Payment_Status;
         this.Ticket_Name=Ticket_Name;   
         this.PaymentTime=PaymentTime;
         this.PaymentId=PaymentID; 
         this.PayKey=PayKey; 
         this.CheckInTime=CheckInTime;
         this.CheckOutTime=CheckOutTime;
        } 
    }
    
    global class Item_Payment_Info
    {    
       public Id Event_Id{get;set;}
       public String Payment_Status{get;set;}
       public String Item_Number{get;set;}
       public String AttendeeId{get;set;}
       public String ItemId{get;set;}
       public String Item_Name{get;set;}
       public String PaymentType{get;set;}
       public Decimal ItemQuantity{get;set;}
       public String CheckNo{get;set;}
       public boolean isCheckedIn{get;set;}
       public Decimal ItemAmount{get;set;}
       public String PaymentTime{get;set;}  
       public String PaymentId{get;set;}
       public String PayKey{get;set;}
       
       public Item_Payment_Info(String PaymentType,Decimal ItemQuantity,String CheckNo,boolean isCheckedIn,Decimal ItemAmount,
       String AttendeeId,String ItemId,String Item_Name,Id Event_Id,String Item_Number,String Payment_Status,String PaymentTime,String PaymentID,String PayKey) 
       {
         this.PaymentType=PaymentType;
         this.ItemQuantity=ItemQuantity;
         this.CheckNo=CheckNo;
         this.isCheckedIn=isCheckedIn;
         this.ItemAmount=ItemAmount;
         this.AttendeeId=AttendeeId;
         this.ItemId=ItemId;
         this.Item_Name=Item_Name;
         this.Item_Number=Item_Number;
         this.Event_Id=Event_Id;
         this.Payment_Status=Payment_Status; 
         this.PaymentTime=PaymentTime; 
         this.PaymentId=PaymentID;
         this.PayKey=PayKey;
        }
    }
       
}
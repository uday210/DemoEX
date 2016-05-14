@RestResource(urlMapping='/AS_Login/*')
 
 /**
 * Author : Mahesh Sakunala
 * Email  : mahesh@globalnest.com
 * Phone  : 9666308210
 * AIM    : To retrieve list of events based on the EmailID & Password submitted in the Attendee Scan application.
 */
 
 global with sharing class AS_Login{
    global static String EmailID;
    global static String Password;
    global static User LoginUser;
    global static LIST<Event__c> EventInfo;
    global static LIST<User_Profile_Event__c> EventsList;
    global static User_Pricing__c PricingInfo;
    global static EventDetails evd;
    global static LIST<EventDetails> EventDetails;
    global static String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    global static String orgId = UserInfo.getOrganizationId();
    global static String  Imageheader =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id=';
    global static LIST<AttendeeSummary__c> UserAttendee = new LIST<AttendeeSummary__c>();

    @HttpGet
    global static UserDetails doGet(){
        //Request Context
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        // Getting request parameters from the URL
        EmailID = req.params.get('EmailID');
        Password = req.params.get('Password');
        system.debug('Email is ' + EmailID +'Password is '+Password);
        Commanforstates con = new Commanforstates();
        
        // user details are from here
        try{
            Profile P = [SELECT id,Name FROM Profile WHERE Name='Event Admin'];
            LoginUser = [SELECT Id, IsActive, is_Event_Admin_Staff_User__c, ProfileId,Username,FirstName,LastName,Email,Companyphone__c,CompanyName,States__c,Country__c,CompanyCity__c,ScanAttendee_User__c FROM User WHERE UserName=:EmailID AND Password__c=:Password];
            system.debug(LoginUser.IsActive+'  LOGIN USER DETAILS00000000 '+LoginUser.ScanAttendee_User__c);
            
            if(LoginUser.IsActive == false){
                system.debug(LoginUser.IsActive+'  LOGIN USER DETAILS111111111111 '+LoginUser);
                UserDetails usd = new UserDetails('','The account is inActive,Please Contact Scan Attendee Admin to Activate your Account !');
                return usd; 
            }
        }
        catch(Exception ex){
            UserDetails usd = new UserDetails('','Please Check your credentials');
            return usd;
        }  
        
        if(LoginUser.ScanAttendee_User__c == FALSE){
            LoginUser.ScanAttendee_User__c = TRUE;
            Database.Update(LoginUser, FALSE);
        }
    String imageurl='';
    UserAttendee  = [SELECT Id,AS_ImageUrl__c,AS_FirstName__c,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WorkPhone__c,AS_WorkCity__c,AS_WorkState__c,AS_WorkCountry__c FROM AttendeeSummary__c WHERE AS_Email__c=: EmailID LIMIT 1];
    if(UserAttendee.size()>0){
        imageurl = UserAttendee[0].AS_ImageUrl__c;
    }
    else{
        imageurl = '';
    }
    system.debug(' LOGIN USER ID '+LoginUser.ID);
    EventsList = [SELECT EV_id__r.Status__c,EV_id__r.StartTime__c, EV_id__r.SecondaryCategory__c,
                  EV_id__r.Primary__c, EV_id__r.Name, EV_id__r.Id, EV_id__r.EV_Title__c, EV_id__r.EV_StartDate__c, EV_id__r.EV_HostingZipcode__c, 
                  EV_id__r.EV_HostingTimeZone__c, EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingPostalCode__c,
                  EV_id__r.EV_HostingPhone__c, EV_id__r.EV_HostingLocation__c, EV_id__r.EV_HostingCountry__c,EV_id__r.EV_HostingCountryNew__c,EV_id__r.TwitterId__c,EV_id__r.FacebookId__c,EV_id__r.OrganizerId__c,
                  EV_id__r.EV_HostedByEventBrite__c, EV_id__r.EV_HistingAddr1__c, EV_id__r.EV_EventLogo__c,EV_id__r.CCRDetails_Required__c, 
                  EV_id__r.EV_EndTime__c,EV_id__r.EV_EndDate__c, EV_id__r.EV_Description__c, Profile_id__r.PR_Name__c,EV_id__r.EV_HostingStateNew__c,
                  EV_id__r.CreatedDate,EV_id__r.isActive__c, EV_id__r.Attendee_Tags__c,EV_id__r.EV_HostingOrgName__c, EV_id__r.AS_HostingCity__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.Is_MatchMaking_Event__c, 
                  EV_id__r.Sales_Tax__c, EV_id__r.Fee_Type__c, EV_id__r.Badge_Name__c,EV_id__r.scan_attendee_limit__c
                  FROM User_Profile_Event__c 
                  WHERE EV_id__c != NULL 
                  AND EV_id__r.isActive__c =: true
                  AND User_id__c=: LoginUser.ID
                  AND UEP_isActive__c =: TRUE
                  AND (Profile_id__r.PR_Name__c =: 'EventAdmin' OR Profile_id__r.PR_Name__c =: 'EventAdmin Staff')];
                  //AND EV_id__r.OwnerId =: LoginUser.ID]; 
    
    EventInfo =[SELECT Id, Sales_Tax__c, EV_Title__c,EV_StartDate__c,StartTime__c,EV_EndTime__c,Primary__c,EV_HostingLocation__c,EV_EventLogo__c,Status__c,EV_EndDate__c,EV_Description__c,EV_HistingAddr1__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountry__c,EV_HostingFax__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,EV_HostingTimeZone__c,EV_HostingZipcode__c 
                FROM Event__c 
                WHERE OwnerId =: LoginUser.ID 
                AND isActive__c =: true
                ORDER BY EV_StartDate__c];
    try{
        PricingInfo = new User_Pricing__c();
        PricingInfo = [SELECT Id,User__c,Pricing__c,AttendeeLimit__c,Customer_Stripe_Id__c,Pricing__r.BLP_AccountType__c,Pricing__r.BLP_AttendeeLimit__c 
                       FROM User_Pricing__c
                       WHERE User__c =:LoginUser.ID];
     }            
     catch(Exception ex){ 
    }                 
    EventDetails = new List<EventDetails>();
    LIST<App_Settings__c> AppSettingsList= new LIST<App_Settings__c>();
    LIST<Pay_Pal_Account__c> PayPalDetails= new LIST<Pay_Pal_Account__c>();
        
    AccountDetails AccDetail= new AccountDetails();
    AppSettingsList= [SELECT ID, Fee__c, Client_Id__c, Secret_Id__c, Redirect_URL__c, Paypal_Key__c FROM App_Settings__c WHERE User_Type__c =: 'ScanAttendee User'];
    PayPalDetails= [SELECT ID, OurEmail__c, Email_Id__c FROM Pay_Pal_Account__c WHERE User_Email__c =: EmailId];
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
    String EventAdminPayPalEmail= '';  
    if(PayPalDetails.size() >0){
        AccDetail.PayPalEmail= PayPalDetails[0].OurEmail__c;
        EventAdminPayPalEmail= PayPalDetails[0].Email_Id__c;
    }
    
    UserDetails usd = new UserDetails(LoginUser.Id,LoginUser.FirstName,LoginUser.LastName,LoginUser.CompanyName,LoginUser.CompanyCity__c,con.mapstate(LoginUser.States__c), LoginUser.States__c,LoginUser.Companyphone__c,LoginUser.Username,imageurl,con.mapstate(LoginUser.Country__c),LoginUser.Country__c,LoginUser.username,PricingInfo.Pricing__r.BLP_AccountType__c,PricingInfo.AttendeeLimit__c,PricingInfo.Customer_Stripe_Id__c, LoginUser.is_Event_Admin_Staff_User__c, Fee, EventAdminPayPalEmail);
                         system.debug('  USER DETAILS  '+usd);
    for(User_Profile_Event__c Eat:EventsList){
        evd = new EventDetails();
        evd.Event_ID = Eat.EV_id__r.Id;                    
        evd.Event_Name = Eat.EV_id__r.EV_Title__c;   
        Datetime startDatetime;
        try{
            startDatetime = datetime.newInstance(Eat.EV_id__r.EV_StartDate__c, time.newInstance(0,0,0,0));
        }
        catch(Exception e){}
        String myDatetimeStr;
        try{
            myDatetimeStr = startDatetime.format('MMMM d, yyyy');
        }
        catch(Exception e){}                
        evd.Event_StartDate = myDatetimeStr;                    
        evd.Event_StartHour = Eat.EV_id__r.StartTime__c; 
        Datetime endDatetime;
        try{
            endDatetime  = datetime.newInstance(Eat.EV_id__r.EV_EndDate__c, time.newInstance(0,0,0,0));
        }
        catch(Exception e){}
        String myDatetimeStr1;
        try{
            myDatetimeStr1= endDatetime.format('MMMM d, yyyy');
        }
        catch(Exception e){}
        evd.Event_EndDate = myDatetimeStr1;                   
        evd.Event_EndHour = Eat.EV_id__r.EV_EndTime__c;           
        evd.Event_Location = Eat.EV_id__r.EV_HostingLocation__c;
        evd.Event_Category = Eat.EV_id__r.Primary__c;
        if(Eat.EV_id__r.EV_EventLogo__c != NULL){
            evd.EventLogoImageURL = Imageheader+Eat.EV_id__r.EV_EventLogo__c;                                                     
        }
        evd.Event_Description =  Eat.EV_id__r.EV_Description__c;                    
        evd.HostingAddr1  = Eat.EV_id__r.EV_HistingAddr1__c;                   
        evd.HostingAddr2 = Eat.EV_id__r.AS_HostingAddr2__c;                    
        evd.HostingCity = Eat.EV_id__r.AS_HostingCity__c;                    
        evd.HostingCountry = Eat.EV_id__r.EV_HostingCountry__c;               
        evd.HostingZipcode = Eat.EV_id__r.EV_HostingPostalCode__c;
        evd.HostingPhone = Eat.EV_id__r.EV_HostingPhone__c;
        evd.HostingState =  con.mapstate(Eat.EV_id__r.EV_HostingStateNew__c);
        evd.HostingState_LongCode = Eat.EV_id__r.EV_HostingStateNew__c;
        system.debug(Eat.EV_id__r.EV_HostingCountryNew__c+'    EVENT STATE MAP'+con.mapstate(Eat.EV_id__r.EV_HostingCountryNew__c));
        evd.HostingCountry = con.mapstate(Eat.EV_id__r.EV_HostingCountryNew__c);
        system.debug('  EVENT STATE SHORT FORM '+evd.HostingCountry); 
        evd.HostingCountry_LongCode = Eat.EV_id__r.EV_HostingCountryNew__c;
        evd.HostingZipcode=Eat.EV_id__r.EV_HostingZipcode__c;
        evd.SalesTax= String.valueof(Eat.EV_id__r.Sales_Tax__c);
        //evd.FeeApplicable= TRUE;        
        if(Eat.EV_id__r.Fee_Type__c == 'Include the fee in the ticket price'){
            evd.FeeApplicable= TRUE;
        }else if(Eat.EV_id__r.Fee_Type__c == 'Charge the fee to the customer'){
            evd.FeeApplicable= FALSE;        
        }
        evd.BadgeName= Eat.EV_id__r.Badge_Name__c;
        evd.scan_attendee_limit=Eat.EV_id__r.scan_attendee_limit__c==null?0:Eat.EV_id__r.scan_attendee_limit__c;
        usd.Edetails.add(evd); 

    }
            usd.AccDetails= AccDetail;
            
  
    return usd; 
    }
    
    global class UserDetails{
        Id UserID;
        String FirstName;       
        String LastName;       
        String Company;        
        String City;       
        String State;
        String State_LongCode;
        String ImageUrl;
        String Country;
        String Country_LongCode;
        String PhoneNo;
        String Email;
        String message;
        String error;
        String username;
        String AccountType;
        Decimal AttendeeLimit;
        String CustomerStripeId;
        Boolean isEventAdminStaff;
        Decimal Fee;
        String EventAdminPayPalEmail;
           
        global EventDetails[] Edetails;
        global AccountDetails AccDetails;
        
        global UserDetails(String message1, String error1){
            error = error1;
            message= message1;
        }
        
        global UserDetails(Id UserID1,String FirstName1,String LastName1,String Company1,String City1,String State1,String State_LongCode1,String PhoneNo1,String Email1,String ImageUrl1,String Country1,String Country_LongCode1,String username,String AccountType1,Decimal AttendeeLimit1,String CustomerStripeId1, Boolean isEventAdminStaff1, Decimal Fee1, String EventAdminPayPalEmail1){
            UserID =UserID1;
            FirstName = FirstName1;               
            LastName = LastName1;               
            Company = Company1;               
            City = City1;               
            State= State1; 
            State_LongCode = State_LongCode1;             
            PhoneNo = PhoneNo1;               
            Email = Email1;               
            ImageUrl = ImageUrl1;
            Country = Country1;
            Country_LongCode = Country_LongCode1;
            this.username=username;
            AccountType = AccountType1;
            AttendeeLimit = AttendeeLimit1;
            CustomerStripeId = CustomerStripeId1;
            isEventAdminStaff= isEventAdminStaff1;
            Fee= Fee1;
            EventAdminPayPalEmail= EventAdminPayPalEmail1;
            Edetails = new List<EventDetails>();
            AccDetails= new AccountDetails(); 

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
        
    global class EventDetails{
        Id Event_ID;   
        String Event_Name;       
        String Event_StartDate;       
        String Event_StartHour; 
        String Event_EndDate;       
        String Event_EndHour;
        String Event_Category;
        String Event_Location; 
        String EventLogoImageURL;           
        String Event_Description;       
        String HostingAddr1;       
        String HostingAddr2;        
        String HostingCity;        
        String HostingState;  
        String HostingState_LongCode;     
        String HostingCountry;     
        String HostingCountry_LongCode;   
        String HostingZipcode;       
        String HostingPhone;  
        String SalesTax{get; set;}
        Boolean FeeApplicable{get; set;} 
        String BadgeName{get; set;}
        Decimal scan_attendee_limit{get;set;}
                                      
        global EventDetails(){}

        global EventDetails(Id Event_ID1,String Event_Name1,String Event_StartDate1,String Event_EndDate1,String Event_StartHour1,String Event_EndHour1,String Event_Category1,String Event_Location1,String EventLogoImageURL1,String Status1,String Event_Description1,String HostingAddr1a,String HostingAddr2a,String HostingCity1,String HostingState1,String HostingState_LongCode1,String HostingCountry1,String HostingCountry_LongCode1,String HostingZipcode1,String HostingPhone1, String SalesTax1, Boolean FeeApplicable1, String BadgeName){
            Event_ID = Event_ID1;         
            Event_StartDate = Event_StartDate1;           
            Event_StartHour = Event_StartHour1;
            Event_EndDate = Event_EndDate1; 
            Event_EndHour = Event_EndHour1; 
            Event_Category = Event_Category1;          
            Event_Location = Event_Location1;
            EventLogoImageURL = EventLogoImageURL1;
            Event_Description = Event_Description1;          
            HostingAddr1 = HostingAddr1a;          
            HostingAddr2 = HostingAddr2a;           
            HostingCity = HostingCity1;           
            HostingState = HostingState1; 
            HostingState_LongCode = HostingState_LongCode1;         
            HostingCountry = HostingCountry1;
            HostingCountry_LongCode = HostingCountry_LongCode1;          
            HostingZipcode = HostingZipcode1;           
            HostingPhone = HostingPhone1;  
            SalesTax= SalesTax1;
            FeeApplicable= FeeApplicable1;
            BadgeName= BadgeName;
        }  
    }   
 }
public with sharing class attendeedetailcorporate {


    public string SelectEvent {get ; set ;}
    public string eventname1{get;set;}
    public boolean dolor{get;set;}
    public Profile_Settings__c psett{get;set;}
    public Event_Attendee_Mapping__c Ticketfordetail{get;set;}
    public AttendeeSummary__c attendee{get; set;}
    public boolean shippingstate{get;set;}
    public boolean workstate{get;set;}
    public boolean homestate{get;set;}
    public Boolean ReqFields{get; set;}
    public Boolean  Prefix{get; set;}
    public Boolean  sufix{get; set;}
    public Boolean  Degi{get; set;}
    public Boolean  mobile{get; set;}
    public Boolean  age{get; set;}
    public Boolean  gen{get; set;}
    public boolean registrationtype{get;set;}
    public Boolean  dob{get; set;}
    public Boolean  homeinfo{get; set;}
    public Boolean  Shippinginfo{get; set;}
    public Boolean  workinfo{get; set;}
    public Boolean  NAICSCode1{get; set;}
    public Boolean  NAICSCode2{get; set;}
    public Boolean  NAICSCode3{get; set;}
    public Boolean  PBC{get; set;}
    public Boolean  SBC{get; set;}
    public Boolean  NOEmp{get; set;}
    public Boolean  BEDate{get; set;}
    public Boolean  BRev{get; set;}
    public Boolean  BTaxID{get; set;}
    public Boolean  BDN{get; set;}
    public Boolean  webUrl{get; set;}
    public Boolean  blogURL{get; set;}
    public Boolean  DT{get; set;}
    public Boolean  BDesc{get; set;}
    public String sss {get; set;}
    public Boolean TicType{get;set;}
    public id userid {get;set;}
    public string Workstates{get;set;}
    public string Homestates{get;set;}
    public string Shippingstates{get;set;}
    public string Workcountry{get;set;}
    public string Homecountry{get;set;}
    public string Shippingcountry{get;set;}
    public LIST<Profile_Settings__c> Psettings {get ; set ;} 
    
//-------------------------------------------------------CONSTRUCTOR-------------------------------------------------
    public attendeedetailcorporate ()
    {
    userId =UserInfo.getUserId();
    attendee= new AttendeeSummary__c();
    Ticketfordetail=new Event_Attendee_Mapping__c();
    sss = UserInfo.getUserName();
        //  String sss='mallikarjunan+user35@globalnest.com';
       ReqFields = TRUE;
        Prefix = TRUE;
        sufix = TRUE;
        Degi = TRUE;
        mobile = TRUE;
        age = TRUE;
        gen = TRUE;
        registrationtype=true;
        dob = TRUE;
        homeinfo = TRUE;
        Shippinginfo = TRUE;
        workinfo = TRUE;
        NAICSCode1 = TRUE;
        NAICSCode2 = TRUE;
        NAICSCode3 = TRUE;
        PBC = TRUE;
        SBC = TRUE;
        NOEmp = TRUE;
        BEDate = TRUE;
        BRev = TRUE;
        BTaxID = TRUE;
        BDN = TRUE;
        webUrl = TRUE;
        blogURL = TRUE;
        DT = TRUE;
        BDesc = TRUE;
        map<string,string> states=new map<string,string>();
        states.put('None','None');
        states.put('Alabama','AL');
        states.put('Alaska', 'AK');
        states.put('Arizona','AZ');
        states.put('Arkansas','AR');
        states.put('California','CA');
        states.put('Colorado','CO');
        states.put('Connecticut','CT');
        states.put('Delaware','DE');
        states.put('District of Columbia','DC');
        states.put('Florida','FL');
        states.put('Georgia','GA');
        states.put('Hawaii','HI');
        states.put('Idaho','ID');
        states.put('Illinois','IL');
        states.put('Indiana','IN');
        states.put('Iowa','IA');
        states.put('Kansas','KS');
        states.put('Kentucky','KY');
        states.put('Louisiana','LA');
        states.put('Maine','ME');
        states.put('Maryland','MD');
        states.put('Massachusetts','MA');
        states.put('Michigan','MI');
        states.put('Minnesota','MN');
        states.put('Mississippi','MS');
        states.put('Missouri','MO');
        states.put('Montana','MT');
        states.put('Nebraska','NE');
        states.put('Nevada','NV');
        states.put('New Hampshire','NH');
        states.put('New Jersey','NJ');
        states.put('New Mexico','NM');
        states.put('New York','NY');
        states.put('North Carolina','NC');
        states.put('North Dakota','ND');
        states.put('Ohio','OH');
        states.put('Oklahoma','OK');
        states.put('Oregon','OR');
        states.put('Pennsylvania','PA');
        states.put('Rhode Island','RI');
        states.put('South Carolina','SC');
        states.put('South Dakota','SD');
        states.put('Tennessee','TN');
        states.put('Texas','TX');
        states.put('Utah','UT');
        states.put('Vermont','VT');
        states.put('Virginia','VA');
        states.put('Washington','WA');
        states.put('West Virginia','WV');
        states.put('Wisconsin','WI');
        states.put('Wyoming','WY');                     
        states.put('Andhra Pradesh','Andhra Pradesh');
        states.put('Arunachal Pradesh','Arunachal Pradesh');
        states.put('Assam','Assam');
        states.put('Bihar','Bihar');
        states.put('Chhattisgarh','Chhattisgarh');
        states.put('Goa','Goa');
        states.put('Gujarat','Gujarat');
        states.put('Haryana','Haryana');
        states.put('Himachal Pradesh','Himachal Pradesh');
        states.put('Jammu and Kashmir','Jammu and Kashmir');
        states.put('Jharkhand','Jharkhand');
        states.put('Karnataka','Karnataka');
        states.put('Kerala','Kerala');
        states.put('Madhya Pradesh','Madhya Pradesh');
        states.put('Maharashtra','Maharashtra');
        states.put('Manipur','Manipur');
        states.put('Meghalaya','Meghalaya');
        states.put('Mizoram','Mizoram');
        states.put('Nagaland','Nagaland');
        states.put('Orissa','Orissa');
        states.put('Punjab','Punjab');
        states.put('Rajasthan','Rajasthan');
        states.put('Sikkim','Sikkim');
        states.put('Tamil Nadu','Tamil Nadu');
        states.put('Tripura','Tripura');
        states.put('Uttar Pradesh','Uttar Pradesh');
        states.put('Uttarakhand','Uttarakhand');
        states.put('West Bengal','West Bengal');
        states.put('Andaman and Nicobar Islands','Andaman and Nicobar Islands');
        states.put('Daman and Diu','Daman and Diu');
        states.put('Lakshadweep','Lakshadweep  ');
        states.put('National Capital Territory of Delhi','National Capital Territory of Delhi');                                     
    
        map<string,string> countries = new map<string,string>();
         countries.put('India','India');
         countries.put('United States Of America','USA');
         try{
            Cookie k = ApexPages.currentPage().getCookies().get('counter');
            SelectEvent = k.getValue();
        }catch(exception e){}
    try{
     
      Ticketfordetail=[select id,TicketTypes__c,AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                                 AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,AS_id__r.Exhibitor_company_imageUrl__c,
                                 AS_id__r.AS_Company__c,DiversityType__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,AS_id__r.Keywords__c,
                                 AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                                 AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode_1__c,
                                 AS_id__r.AS_NAICSCode_2__c,AS_id__r.AS_NAICSCode_3__c,AS_id__r.AS_NAICSCode_4__c,AS_id__r.AS_NAICSCode_5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                                 AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                                 AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                                 AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                                 AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                                 AS_id__r.AS_WorkZip__c,AS_id__r.Exceptional_Key_Words__c,EV_id__r.id,AS_id__r.AS_NAICSCode6__c,AS_id__r.AS_NAICSCode7__c,AS_id__r.AS_NAICSCode8__c,AS_id__r.AS_NAICSCode9__c,
                                 AS_id__r.Commodity_1__c,AS_id__r.Commodity_2__c,AS_id__r.Commodity_3__c,AS_id__r.Commodity_4__c,AS_id__r.Commodity_5__c,AS_id__r.DBA__c,AS_id__r.Geographical_Region__c,
                                 AS_id__r.Certificate_Processed_by_RPO__c,AS_id__r.BBB_Number__c,AS_id__r.distribution_Country__c,AS_id__r.Manufactures_Country__c,AS_id__r.References__c,AS_id__r.Revenue_Range__c
                                 FROM Event_Attendee_Mapping__c WHERE AS_id__r.id =:ApexPages.currentPage().getParameters().get('id') limit 1];

      Workstates=states.get(Ticketfordetail.AS_id__r.AS_Work_States__c);
      system.debug(':::::::::::::::;;;HS:::::::::::::::'+Workstates);
      if(Workstates == null){
      Workstates=Ticketfordetail.AS_id__r.AS_Work_States__c;
      }
       system.debug(':::::::::::::::;;;HS:::::::::::::::'+Workstates);
      Homestates=states.get(Ticketfordetail.AS_id__r.As_Home_State__c);
      if(Homestates == null){
      Homestates=Ticketfordetail.AS_id__r.As_Home_State__c;
      }
      system.debug(':::::::::::::::;;;HS:::::::::::::::'+Homestates);
      shippingstates=states.get(Ticketfordetail.AS_id__r.As_Shipping_States__c);
      if(shippingstates == null){
     shippingstates=Ticketfordetail.AS_id__r.As_Shipping_States__c;
      }
      system.debug(':::::::::::::::;;;Ticketfordetail.AS_id__r.AS_Work_Country__c:::::::::::::::'+Ticketfordetail.AS_id__r.AS_Work_Country__c);
      workcountry=countries.get(Ticketfordetail.AS_id__r.AS_Work_Country__c);
       system.debug(':::::::::::::::;;;workcountry:::::::::::::::'+workcountry);
      Homecountry=countries.get(Ticketfordetail.AS_id__r.As_Home_Country__c);
      Shippingcountry=countries.get(Ticketfordetail.AS_id__r.As_Shipping_Country__c);
     if(Ticketfordetail.AS_id__r.AS_BusinessRevenue__c != null)
    {
    dolor=true;
    
    }
      if(Ticketfordetail.TicketTypes__c != null || Ticketfordetail.TicketTypes__c !='' )
      {
Ticketfordetail.TicketTypes__c=Ticketfordetail.TicketTypes__c.removeEnd(',');
      TicType=true;
      }
         system.debug(':::::::::::::::;;;HS:::::::::::::::'+Ticketfordetail.DiversityType__c); 
   /**   if(Ticketfordetail.AS_HomeState__c != 'None')
    {
    homestate=true;
    
    }
    
    if(attendee.AS_WorkState__c != 'None')
   {
   
   workstate=true;
   
   }
    if(attendee.AS_ShippingState__c != 'None')
    {
    
    shippingstate=true;
    }
     */   
    }
     
   catch(exception e){}
   psett=new Profile_Settings__c();
   Psettings = [SELECT id,Corporate_First_Name_Visible__c,
                          Corporate_E_Mail_Visible__c,Corporate_Job_Title_Visible__c,
                            Corporate_Mobile_Phone_Visible__c,
                            Corporate_Company_Visible__c,
                            Corporate_Work_Address_Visible__c,
                            Corporate_Phone_Visible__c,
                            Corporate_NAICS_CODES_Visible__c,
                            Corporate_Procurement_Visible__c,
                            Corporate_Business_Description_Visible__c,
                            Corporate_Salutation_Visible__c,
                            Corporate_Contact_Image_Visible__c,
                            Corporate_DBA_Visible__c,
                            Corporate_Primary_Business_Category_Visi__c,
                            Corporate_Secondary_Business_Category_Vi__c,
                            Corporate_Website_Registration_Link_Vi__c,
                            Corporate_Manufactures_Country_Visible__c,
                            Corporate_Distributors_Country_Visible__c,
                            Corporate_BBB_Number_Visible__c,
                            Corporate_Certificate_Processed_by_RPO_V__c,
                            Corporate_Geographical_Region_Visible__c,
                            Corporate_Company_Logo_Visible__c,
                            Corporate_Additional_Company_Brouchers_V__c,
                            Corporate_Additional_Company_videos_Visi__c,
                            Corporate_Country_Visible__c,
                            Corporate_Commodities_Visible__c,
                            Corporate_Location_Visible__c,
                            Corporate_Table_Room_No_Visible__c,
                            Products_NOT_interested_visible__c,
                            Corporate_exceptional_keywords_visible__c
                         FROM Profile_Settings__c WHERE Event__r.id =: SelectEvent AND Name=: 'Corporate' ];
                         if(Psettings.size()>0){
                         psett=Psettings[0];
                         }
                        // system.debug('*******************'+Psettings[0].Corporate_DBA_Visible__c);
      
    }                                 
    


    public PageReference checkUserId() {
     if(userInfo.getUserType()=='guest'){
            Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
            pg.setredirect(true);
            return pg;
       } else{
            return null;
       }    
    }
 
 



}
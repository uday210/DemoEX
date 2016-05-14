public without sharing class attendeedetail {

/***********************************************
//Changes Made date     Developer          Reason 
//16/7/2015             Unni Krishna       Adding 6,7,8,9 Commodities in the Query
//16/7/2015             Unni Krishna       Adding GSA Schedule to the Query 

***********************************************/
    
    public string eventname1{get;set;}
    public boolean dolor{get;set;}
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
    public List<Survey__c> listOfSurveys{get;set;} 
    public string selectedEvent{get;set;}
    public Event_Attendee_Mapping__c evm {get ; set ;}
    public list<Profile_Settings__c>  pfsett{set;get;}
      
    
//-------------------------------------------------------CONSTRUCTOR-------------------------------------------------
    public attendeedetail ()
    {
   // selectedEvent=ApexPages.currentPage().getParameters().get('eventid');
    
        //pfsett= new Profile_Settings__c();
        pfsett= new list<Profile_Settings__c>();
          
        system.debug('lllllll'+selectedEvent);
    listOfSurveys = new List<Survey__c>();
    userId =UserInfo.getUserId();
    attendee= new AttendeeSummary__c();
    Ticketfordetail=new Event_Attendee_Mapping__c();
    
         evm = [Select id,EV_id__r.Is_Webank_event__c,EV_id__r.id from Event_Attendee_Mapping__c WHERE id =: ApexPages.currentPage().getParameters().get('id') ];

    
    pfsett =[SELECT id,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,
             First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,MBE_Work_Address_Visibility__c,
             Work_Address__c,Work_phone__c,Additional_Company_Brouchers__c,Additional_Company_videos__c,BBB_Number__c,
             Business_Duns_Number__c,Business_Established_Date__c,Business_Revenue__c,Business_Tax_ID__c,Business_Type__c,Cage_Code__c,
             Certificate_Processed_by_RPO__c,Certifications__c,Commodities__c,Country__c,DBA__c,Distributors_Country__c,Geographical_Region__c,
             GSA_Schedule_Contract_Number__c,Job_Title__c,Manufatures_Country__c,Number_Of_Employees__c,Primary_Business_Category__c,Products_Services__c,
             References__c,Revenue_Range__c,Salutation__c,Secondary_Business_Category__c,Small_Business_IMAGE__c,State__c,Uploaded_Company_Brochures__c,Uploaded_Video__c,
             Website__c,Zip_Code__c,Company_Logo__c,MBE_Products_Services_Visible__c,MBE_LastName_Visible__c,MBE_Email_Visible__c,
             MBE_Job_Title_Visible__c,MBE_First_Name_Visible__c,MBE_Work_Phone_Visible__c,MBE_Procurement_Needs_Visible__c,MBE_Business_Description_Visible__c,
             MBE_NAICS_CODES_Visible__c,MBE_Small_Business_Image_Visible__c,MBE_Title_Visible__c,MBE_Mobile_Phone_Visible__c,
             MBE_Salutation_Visible__c,MBE_Company_Visible__c,MBE_DBA_Visible__c,MBE_Website_Visible__c,MBE_Address_1_Visible__c,MBE_Address_2_Visible__c,
             MBE_City_Visible__c,MBE_Country_Visible__c,MBE_Zip_Code_Visible__c,MBE_State_Visible__c,MBE_Additional_Company_Brouchers_Visible__c,
             MBE_Manufatures_Country_Visible__c,MBE_Distributors_Country_Visible__c,MBE_Uploaded_Company_Brochures_Visible__c,MBE_Company_Logo_Visible__c,
             MBE_Business_Duns_Number_Visible__c,MBE_Business_Established_Date_Visible__c,MBE_BBB_Number_Visible__c,MBE_Additional_Company_videos_Visible__c,
             MBE_Business_Revenue_Visible__c,MBE_Revenue_Range_Visible__c,MBE_Business_Tax_ID_Visible__c,MBE_Cage_Code_Visible__c,
             MBE_GSA_Schedule_Contract_Number_Visible__c,MBE_Number_Of_Employees_Visible__c,MBE_Primary_Business_Category_Visible__c,MBE_Certifications_Visible__c,
             MBE_Secondary_Business_Category_Visible__c,MBE_Certificate_Processed_by_RPO_Visible__c,MBE_Geographical_Region_Visible__c,MBE_References_Visible__c,
             MBE_References2_Visible__c,
             Reference2__c,
             Scope_of_Work__c,
             Scope_of_Work2__c,
             MBEScope_of_Work2_Visible__c,
             MBEScope_of_Work__c,
             MBE_Business_Type_Visible__c,MBE_Commodities_Visible__c,MBE_Uploaded_Video_Visible__c ,
             Year_in_Business__c,
            MBE_Year_in_Business_Visible__c,
            Business_Structure__c,
            Business_Structure_Visible__c,
            FaxNumber__c,
            FaxNumber_Visible__c,
            Ethnicity__c,
            MBE_Ethnicity_Visible__c,
            Secondary_Email__c,MBEAny_non_WBENC_awards_received_visible__c,MBECompanyhavefacility_partneroutsideUSA__c,
            MBE_Secondary_Email_Visible__c
             FROM Profile_Settings__c WHERE Event__r.id =:evm.EV_id__r.id AND Name=:'MBE'];
        
    
        
        System.debug('rrrrrrrrrr'+pfsett);
        
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
     
     if(evm.EV_id__r.Is_Webank_event__c == False){
      Ticketfordetail=[select id,AS_id__c,TicketTypes__c,AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                                 AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,AS_id__r.Keywords__c,
                                 AS_id__r.AS_Company__c,DiversityType__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,
                                 AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                                 AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode_1__c,
                                 AS_id__r.AS_NAICSCode_2__c,AS_id__r.AS_NAICSCode_3__c,AS_id__r.AS_NAICSCode_4__c,AS_id__r.AS_NAICSCode_5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                                 AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                                 AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                                 AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                                 AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                                 AS_id__r.AS_WorkZip__c,EV_id__c,AS_id__r.AS_NAICSCode1__c ,AS_id__r.AS_NAICSCode2__c ,AS_id__r.AS_NAICSCode3__c ,AS_id__r.AS_NAICSCode4__c ,AS_id__r.AS_NAICSCode5__c,
                                 AS_id__r.DBA__c,AS_id__r.Geographical_Region__c,AS_id__r.Certificate_Processed_by_RPO__c,AS_id__r.BBB_Number__c,AS_id__r.Commodity_1__c,AS_id__r.Commodity_2__c,AS_id__r.Commodity_3__c,AS_id__r.Commodity_4__c,AS_id__r.Commodity_5__c,AS_id__r.Commodity_6__c,AS_id__r.Commodity_7__c, AS_id__r.Commodity_8__c, AS_id__r.Commodity_9__c,
                                 AS_id__r.distribution_Country__c,AS_id__r.Manufactures_Country__c,AS_id__r.References__c,AS_id__r.Scope_of_Work__c,AS_id__r.References2__c,AS_id__r.Scope_of_Work2__c,AS_id__r.Revenue_Range__c,AS_id__r.AS_NAICSCode9__c,AS_id__r.AS_NAICSCode8__c,AS_id__r.AS_NAICSCode7__c,AS_id__r.AS_NAICSCode6__c,AS_id__r.Any_non_WBENC_awards_received__c,AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
                                 AS_id__r.Year_in_business__c,AS_id__r.Business_Structure__c,AS_id__r.AS_Secondary_Email__c,AS_id__r.Ethnicity__c,AS_id__r.GSA_Schedule__c
                                 FROM Event_Attendee_Mapping__c WHERE Id=:ApexPages.currentPage().getParameters().get('id')];
                                 
                                 
                                  
        
                                

            }else{
            
            Ticketfordetail=[select id,TicketTypes__c,MBE_Profile__r.AS_shippingzip_c__c,MBE_Profile__r.AS_Age__c,MBE_Profile__r.AS_BirthDate__c,MBE_Profile__r.AS_BlogUrl__c,MBE_Profile__r.AS_BusinessDescription__c,MBE_Profile__r.AS_BusinessDunsNumber__c,
                                 MBE_Profile__r.AS_BusinessEstablishedDate__c,MBE_Profile__r.AS_BusinessRevenue__c,MBE_Profile__r.AS_BusinessTaxId__c,MBE_Profile__r.AS_CellPhone__c,MBE_Profile__r.Key_words__c,
                                 MBE_Profile__r.AS_Company__c,DiversityType__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.AS_FaxNumber__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_Gender__c,
                                 MBE_Profile__r.AS_HomeAddress1__c,MBE_Profile__r.AS_HomeAddress2__c,MBE_Profile__r.AS_HomeCity__c,MBE_Profile__r.As_Home_Country__c,MBE_Profile__r.AS_HomePhone__c,
                                 MBE_Profile__r.As_Home_State__c,MBE_Profile__r.AS_HomeZip__c,MBE_Profile__r.AS_ImageUrl__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_NAICSCode_1__c,
                                 MBE_Profile__r.AS_NAICSCode_2__c,MBE_Profile__r.AS_NAICSCode_3__c,MBE_Profile__r.AS_NAICSCode_4__c,MBE_Profile__r.AS_NAICSCode_5__c,MBE_Profile__r.AS_NumberOfEmployees__c,MBE_Profile__r.As_prefixNew__c,
                                 MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MBE_Profile__r.AS_SecondaryBusinessCategory1__c,MBE_Profile__r.AS_ShippingAddress1__c,MBE_Profile__r.AS_ShippingAddress2__c,
                                 MBE_Profile__r.AS_ShippingCity__c,MBE_Profile__r.As_Shipping_Country__c,MBE_Profile__r.AS_ShippingPhone__c,MBE_Profile__r.As_Shipping_States__c,MBE_Profile__r.AS_ShippingZipcode__c,
                                 MBE_Profile__r.As_SuffixNew__c,MBE_Profile__r.AS_Title__c,MBE_Profile__r.AS_WebsiteUrl__c,MBE_Profile__r.AS_WorkAddress1__c,
                                 MBE_Profile__r.AS_WorkAddress2__c,MBE_Profile__r.AS_WorkCity__c,MBE_Profile__r.AS_Work_Country__c,MBE_Profile__r.AS_WorkPhone__c,MBE_Profile__r.AS_Work_States__c,
                                 MBE_Profile__r.AS_WorkZip__c,EV_id__c,MBE_Profile__r.Business_Structure__c,MBE_Profile__r.Year_in_business__c,MBE_Profile__r.GSA_Schedule__c,
                                 MBE_Profile__r.DBA__c,MBE_Profile__r.Geographical_Region__c,MBE_Profile__r.Certificate_Processed_by_RPO__c,MBE_Profile__r.BBB_Number__c,MBE_Profile__r.Commodity_1__c,MBE_Profile__r.Commodity_2__c,MBE_Profile__r.Commodity_3__c,MBE_Profile__r.Commodity_4__c,MBE_Profile__r.Commodity_5__c,MBE_Profile__r.Commodity_6__c,MBE_Profile__r.Commodity_7__c, MBE_Profile__r.Commodity_8__c, MBE_Profile__r.Commodity_9__c,
                                 MBE_Profile__r.distribution_Country__c,MBE_Profile__r.Manufactures_Country__c,MBE_Profile__r.References__c,MBE_Profile__r.Scope_of_Work__c,MBE_Profile__r.References2__c,MBE_Profile__r.Scope_of_Work2__c,MBE_Profile__r.Revenue_Range__c,MBE_Profile__r.AS_NAICSCode9__c,MBE_Profile__r.AS_NAICSCode8__c,MBE_Profile__r.AS_NAICSCode7__c,MBE_Profile__r.AS_NAICSCode6__c,MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,MBE_Profile__r.Any_non_WBENC_awards_received__c,    
                                 MBE_Profile__r.Ethnicity__c,MBE_Profile__r.AS_Secondary_Email__c,
                                 AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                                 AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,AS_id__r.Keywords__c,
                                 AS_id__r.AS_Company__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,
                                 AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                                 AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode_1__c,
                                 AS_id__r.AS_NAICSCode_2__c,AS_id__r.AS_NAICSCode_3__c,AS_id__r.AS_NAICSCode_4__c,AS_id__r.AS_NAICSCode_5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                                 AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                                 AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                                 AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                                 AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                                 AS_id__r.AS_WorkZip__c,AS_id__r.AS_NAICSCode1__c ,AS_id__r.AS_NAICSCode2__c ,AS_id__r.AS_NAICSCode3__c ,AS_id__r.AS_NAICSCode4__c ,AS_id__r.AS_NAICSCode5__c,
                                 AS_id__r.DBA__c,AS_id__r.Geographical_Region__c,AS_id__r.Certificate_Processed_by_RPO__c,AS_id__r.BBB_Number__c,AS_id__r.Commodity_1__c,AS_id__r.Commodity_2__c,AS_id__r.Commodity_3__c,AS_id__r.Commodity_4__c,AS_id__r.Commodity_5__c,AS_id__r.Commodity_6__c,AS_id__r.Commodity_7__c, AS_id__r.Commodity_8__c, AS_id__r.Commodity_9__c,
                                 AS_id__r.distribution_Country__c,AS_id__r.Manufactures_Country__c,AS_id__r.References__c,AS_id__r.Scope_of_Work__c,AS_id__r.References2__c,AS_id__r.Scope_of_Work2__c,AS_id__r.Revenue_Range__c,AS_id__r.AS_NAICSCode9__c,AS_id__r.AS_NAICSCode8__c,AS_id__r.AS_NAICSCode7__c,AS_id__r.AS_NAICSCode6__c,AS_id__r.Any_non_WBENC_awards_received__c,AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
                                 AS_id__r.Year_in_business__c,AS_id__r.Business_Structure__c,AS_id__r.AS_Secondary_Email__c,AS_id__r.Ethnicity__c,AS_id__r.GSA_Schedule__c
                                 FROM Event_Attendee_Mapping__c WHERE Id=:ApexPages.currentPage().getParameters().get('id')];

            system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMythily'+Ticketfordetail);
            
            
             
    
        
    
            
            }
           
      listOfSurveys  =[SELECT Answers__c,AttendeeSummary__c,customer_key__c,Event__c,Survey_Questions__r.Question__c,customer_key__r.isInserted__c  from Survey__c where AttendeeSummary__c=:Ticketfordetail.AS_id__c and Event__c=:Ticketfordetail.EV_id__c and customer_key__r.isInserted__c=true];


      system.debug(' eeeeeeeeeeeeeeeeeeeeeeee '+listOfSurveys  );






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
      if(workcountry== null){
    workcountry=Ticketfordetail.AS_id__r.AS_Work_Country__c;
    }
       system.debug(':::::::::::::::;;;workcountry:::::::::::::::'+workcountry);
      Homecountry=countries.get(Ticketfordetail.AS_id__r.As_Home_Country__c);
      if(Homecountry== null){
      Homecountry=Ticketfordetail.AS_id__r.As_Home_Country__c;
      }
      Shippingcountry=countries.get(Ticketfordetail.AS_id__r.As_Shipping_Country__c);
      
      if(Shippingcountry== null){
      Shippingcountry=Ticketfordetail.AS_id__r.As_Shipping_Country__c;
      }
      
      
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
   
      
    }                                 
    
    
    
    
    

    
    
    
    public PageReference reportact() {
        pagereference pg = new pagereference('/apex/BL_EA_reports');
             pg.setredirect(true);
            return pg;
    }

     public PageReference Dashboardaction() {
    pagereference pg = new pagereference('/apex/BL_EA_Dashboard');
         pg.setredirect(true);
            return pg;
        
    }
    public PageReference Attendees() {
    pagereference pf=new pagereference('/apex/BL_eventadmin_attendees?id='+ApexPages.currentPage().getParameters().get('eventid'));
    
        return pf;
    }


    public PageReference CustomerAdminAct() {
        pagereference pg = new Pagereference('/apex/BL_Eventadmin_BoothAdmins');
            pg.setredirect(true);
                return pg;
    }


    public PageReference Events() {
         Pagereference pg = new Pagereference('/apex/BL_EventAdmin_Events');
        Pg.setredirect(true);
        return pg;
    }


    public PageReference ProfileSettings() {
        Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile');
            Pg.setredirect(true);
            Return pg;
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
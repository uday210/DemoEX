@isTest(SeeAllData=true)
public  class Test_profileDao{
    public static testMethod void myUnitTest() {
    
     account aa=new account(name='govtnm');
        insert aa;
        
         contact con=new contact(lastname='n',accountid = aa.id);
            insert con;
         Profile p = [select id from profile where name='Attendee'];
         
    
    User u = new User(alias = 'test123', email='test123890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles',username='test123890@noemail.com');
                  insert u;
    
    Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event;
     
      AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
         AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',
         AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
         AS_Email__c = 'test12356789@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
         AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',
         AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',
         AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921', AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',
         AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',
         AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
         AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',
         AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',
         Registration_type__c = 'kdsmkas');
     insert att;
     
                 
                   MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        //a.SystemModstamp='AAA'; 
       // a.OwnerId=u.id; 
        a.Name='Vineel'; 
        //a.LastModifiedDate='22-10-1987'; 
        //a.LastModifiedById=23-10-1987;
        //a.LastActivityDate=24-10-1987; 
        //a.IsDeleted=Del; 
        //a.Id='u.id'; 
        //a.CreatedDate=25-10-1987; 
        //a.CreatedById=26-10-1987; 
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';  
        a.AttendeeSummary__c=att.id;
    insert a;      
     
     Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                  Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                  KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                  Work_phone__c= true , Event__c = event.id );
                                  
                  insert pse; 
                  
                  profileDao pd =  new profileDao();
                  
                  pd.getSettings(event.id,'mbe');
    
    }
  }
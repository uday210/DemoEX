@isTest
public class Test_BL_surveyReportcon{ 
  
  static testMethod void myUnitTest() {
   
   contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'temst220', email='tesnt12v3fl@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='tesnt12v3fl@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;       
                  
         
     // ------------------ Boothtadmin Insert ---------------------
         
       user bAdmin =  new User(alias = 'tetboot', email='testbootghadminff@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testbootghadminff@noemail.com');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
         
                  
       Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
       insert  customProfile;
       
       Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  customProfileBooth;
       
       
       
      Id  profileId=customProfile.Id;
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;
      AttendeeSummary__c attSummary1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
      AS_Email__c = 'testt12389011@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
             insert attSummary1 ;
      Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = EventId, AS_id__c = attSummary1.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
     
    
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA; 
      MMQuestion__c mm = new MMQuestion__c(Events__c=eve.id,IsConditional__c=true,IsInclude__c=true,IsRequired__c=false,Order_No__c=1,Type__c='text',Whom__c='mbe');
      insert mm;
      Option__c op= new Option__c(order__c=1,Question__c=mm.id);
      insert op;
      Qaj__c q= new Qaj__c(Option__c=op.id,Question__c=mm.id);
      insert q;
      
      Answer__c ans = new Answer__c(Ans__c='how ar u?',Ans_By__c=EAM1.id,Answer_Default__c=true,Answer_Order__c=1,Option__c=op.id,Question__c=mm.id,Surveyor__c=EAM1.id);
      insert ans;
           cookie  counter = new Cookie('counter',EventId,null,-1,false);
       ApexPages.currentPage().setCookies(new Cookie[]{counter});
      ApexPages.currentPage().getParameters().get('EventId');
      BL_surveyReportcon bl= new BL_surveyReportcon();
      
      
      }
      }
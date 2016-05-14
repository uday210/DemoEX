@istest(SeeAllData= true)


public class Test_SA_ResetPasswordController 
{
  static testmethod void Testmethod_SA_ResetPasswordController(){
  
  contact con = new contact(firstname='test',lastname='pass');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
       
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'prof', email='pass@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States', Password__c='global281',
                  timezonesidkey='America/Los_Angeles', username='pass@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin Staff',PR_Version__c='1.5');        
       insert  EventAdminProfile;
       
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;
      
            
     AttendeeSummary__c  att1= new AttendeeSummary__c ();
      att1.AS_Email__c='pass@noemail.com';
      att1.AS_FirstName__c='manu';
      att1.AS_LastName__c='Sa';
      
      insert att1;
      
      Event_Attendee_Mapping__c eam1= new Event_Attendee_Mapping__c();
      eam1.AS_id__c= att1.id;
      eam1.Boothleads_Profile__c= 'Attendee';
      eam1.EV_id__c= eve.id;
      eam1.IsBoothLeadsAttendee__c= TRUE;
      eam1.checkbox_dataTable__c= TRUE;
      insert eam1;
     
      
      User_Profile_Event__c upe= new User_Profile_Event__c();
      
      upe.Attendee_Summary__c= att1.id;
      upe.EV_id__c= eve.id;
      upe.EventAdmin_Id__c = UserInfo.getUserId();
      upe.UEP_isActive__c= TRUE;
      upe.Profile_id__c=EventAdminProfile.Id;
      upe.User_id__c= U.Id;
      
      insert upe;
      
      
      
      Cookie  counter = new Cookie('counter',eve.id,null,-1,false);
      ApexPages.currentPage().setCookies(new Cookie[]{counter});
      system.runas(u){ 
      SA_ResetPasswordController editProfile= new SA_ResetPasswordController();
      editProfile.newPassword= 'global123';
      editProfile.verifyNewPassword= 'global123';
      editProfile.oldpassword= 'global281';
      editProfile.changePassword();                           
      editProfile.checkUserId();
      editProfile.dummyclassforcode();    
      editProfile.dummyclass2forcode();      
      
     } 
      
        
   }
}
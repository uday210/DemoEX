@istest(SeeAllData= true)
public class Test_SA_SignUpController{
  static testmethod void Testmethod_SA_SignUpController(){
  
Profile p = [select id from profile where name='Standard User'];

Profile pe = [select id from profile where name='System Administrator'];
       
 // ------------------ Eventadmin Insert ---------------------
 
 
 
 User u = new User(alias = 'sa', email='samanasa@sa.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='manasa', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',password__c = 'Tetste12',
                  timezonesidkey='America/Los_Angeles', username='test@global.com',ScanAttendee_User__c = TRUE);
                  insert u;
                  Id eventAdminId=u.id;    


User uu = new User(alias = 'ak', email='akon@sa.com',
                  emailencodingkey='UTF-8',profileid = pe .Id,lastname='akon', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',password__c = 'Tetst12312',
                  timezonesidkey='America/Los_Angeles', username='test2@global.com',ScanAttendee_User__c = False);
                  insert uu;



   
   Profile__c EventAdminStaffProfile= new Profile__c (PR_Name__c='EventAdmin Staff',PR_Version__c='4.0');        
       insert  EventAdminStaffProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;
   
   
   
     AttendeeSummary__c att= new AttendeeSummary__c(AS_FirstName__c='shruthi', AS_LastName__c='Reddy', AS_Email__c = 'test@global.com', AS_Company__c= 'Globalnest', 
                                          AS_Title__c = 'Miss', AS_CellPhone__c = '90000000000' );
     insert att; 
     
     
      User_Profile_Event__c upe= new User_Profile_Event__c();
      
      upe.Attendee_Summary__c= att.id;
      upe.EV_id__c= eve.id;
      upe.EventAdmin_Id__c = UserInfo.getUserId();
      upe.UEP_isActive__c= TRUE;
      upe.Profile_id__c=EventAdminStaffProfile.Id;
      upe.User_id__c= u.Id;
      
      insert upe;
      
      BL_Pricing__c Prit = new BL_Pricing__c();
      Prit.BLP_AccountType__c ='Free';
      insert Prit;
      
      
      
      Cookie  counter = new Cookie('counter',eve.id,null,-1,false);
      ApexPages.currentPage().setCookies(new Cookie[]{counter});
       system.runas(u){
      SA_SignUpController SignUp= new SA_SignUpController();
      SignUp.Password='Tetste12';
      SignUp.Loginname = 'test@global.com';
       SignUp.Login();
       
        SignUp.ASUserEmail = 'SSSS@global.com';
       
        SignUp.ASLastName='Reddy';
         SignUp.ASFirstName= 'shruthi'; 

        
       //SignUp.BLS_SignUpUser();
       
       SignUp.ASUserEmail = 'test2@global.com';
       //SignUp.BLS_SignUpUser();
       
        SignUp.ASUserEmail = 'test@global.com';
       //SignUp.BLS_SignUpUser();
       
       SignUp.U.password__c='Tetste12';
      SignUp.U.Email= 'test@global.com';
       SignUp.close(); 
      SignUp.forgotPassword();
       SignUp.BLS_CancelSignUpUser();
       //SignUp.insertUpe(U.Id,att.id);
      }
      
      
     
}




}
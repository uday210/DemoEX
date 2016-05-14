@isTest(seeAllData=True)
public class Test_MM_ChangepasswordCon {

    public static testMethod void Test_MM_ChangepasswordCon(){
        
        account acc=new account();
        acc.name='Booth Leads';            
        insert acc;
        
       Contact cont = new contact();
        cont.AccountId = acc.Id;
        cont.Email = 'test80@noemail.com';
        cont.FirstName = 'Testing';
        cont.LastName = 'Testing';
        insert cont;
        
        Contact cont1 = new contact();
        cont1.AccountId = acc.Id;
        cont1.Email = 'test81@noemail.com';
        cont1.FirstName = 'Testing';
        cont1.LastName = 'Testing';
        insert cont1;
        
        Contact cont2 = new contact();
        cont2.AccountId = acc.Id;
        cont2.Email = 'test82@noemail.com';
        cont2.FirstName = 'Testing';
        cont2.LastName = 'Testing';
        insert cont2;
        
        
        
        Profile pr = [select id from Profile where name='Event Admin']; 
         
        
        User u1 = new User(alias = 'test80', email='test80@noemail.com',
                           emailencodingkey='UTF-8',profileid = pr.Id,lastname='Testing', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States',ContactId=cont.Id,
                           timezonesidkey='America/Los_Angeles', username='test80@noemail.com',password__c='global120');
        insert u1;
        Profile pr1 = [select id from Profile where name='booth Admin'];  
        
        User u2 = new User(alias = 'test80', email='test81@noemail.com',
                           emailencodingkey='UTF-8',profileid = pr1.Id,lastname='Testing', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States',ContactId=cont1.Id,
                           timezonesidkey='America/Los_Angeles', username='test81@noemail.com',password__c='global120');
        insert u2;
        Profile pr2 = [select id from Profile where name='Attendee'];  
        
        User u3 = new User(alias = 'test80', email='test82@noemail.com',
                           emailencodingkey='UTF-8',profileid = pr2.Id,lastname='Testing', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States',ContactId=cont2.Id,
                           timezonesidkey='America/Los_Angeles', username='test82@noemail.com',password__c='global120');
        insert u3;
        
        Contact c = new Contact(lastname = 'test',
                        firstname = 'test',
                      email = 'test@example.com',
                      accountId = acc.id);
        insert(c);
        
        Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;

         Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,EV_Publish__c =true,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
        
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=u1.id,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=u1.id,UEP_isActive__c=false);         
      insert upeEA; 
        
       User_Profile_Event__c upeEA1= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=u2.id,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=u2.id,UEP_isActive__c=false);         
       insert upeEA1;
       
       User_Profile_Event__c upeEA2= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=u3.id,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=u3.id,UEP_isActive__c=false);         
      insert upeEA2;
       
         cookie  counter = new Cookie('counter',EventId,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        system.runAs(u1){
             //Cookie k = ApexPages.currentPage().getCookies().put('counter',EventId);
            
            //SelectEvent = k.getValue();
            MM_ChangepasswordCon mmc=new MM_ChangepasswordCon();
            mmc.urlReturn = apexpages.currentpage().getparameters().put('urlreturn','test');
            mmc.oldPassword = 'global120';
            mmc.newPassword = 'global123';
            mmc.VerifyNewPassword = 'global123';          
            mmc.CheckUser();
            mmc.changePassword();
            
            
        }  
        system.runAs(u2){
            
            MM_ChangepasswordCon mmc0=new MM_ChangepasswordCon();
            mmc0.urlReturn = apexpages.currentpage().getparameters().put('urlreturn','test');
            mmc0.oldPassword = 'global120';
            mmc0.newPassword = 'global123';
            mmc0.VerifyNewPassword = 'global123';        
            mmc0.CheckUser();
            mmc0.changePassword();
            
            
        } 
        system.runAs(u3){
            Test.startTest();
            MM_ChangepasswordCon mmc1=new MM_ChangepasswordCon();
            mmc1.urlReturn = apexpages.currentpage().getparameters().put('urlreturn','test');
            mmc1.oldPassword = 'global120';
            mmc1.newPassword = 'global123';
            mmc1.VerifyNewPassword = 'global123';      
            mmc1.CheckUser();
            mmc1.changePassword();
            Test.stopTest();
        
        }  


        
    }
}
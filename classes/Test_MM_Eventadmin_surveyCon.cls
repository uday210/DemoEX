@isTest
public class Test_MM_Eventadmin_surveyCon{ 
  
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
      MMQuestion__c mm = new MMQuestion__c(Events__c=eve.id,IsConditional__c=true,IsInclude__c=true,IsRequired__c=false,Order_No__c=1,Type__c='text',Whom__c='mbe');
      insert mm;
      Option__c op= new Option__c(order__c=1,Question__c=mm.id);
      insert op;
      Qaj__c q= new Qaj__c(Option__c=op.id,Question__c=mm.id);
      insert q;
        cookie  counter = new Cookie('counter',EventId,null,-1,false);
       ApexPages.currentPage().setCookies(new Cookie[]{counter});
       ApexPages.currentPage().getParameters().get('eve.id');
      MM_Eventadmin_surveyCon cc = new MM_Eventadmin_surveyCon();
      
      cc.firstMethod();
      cc.addSurveyQuetion();
      
      cc.addOptions();
      cc.AddOpt();
      //Apexpages.currentPage().getParameters().put(counter,5);
       //cc.deleteOpt();
       cc.Cancel();
       cc.saveQuestion();
       ApexPages.currentPage().getParameters().put('pidvalue',mm.id);
       //cc.deletePQuestion();
       //ApexPages.currentPage().getParameters().put('pidvalue',mm.id);
        cc.EditPQuestion();
        ApexPages.currentPage().getParameters().put('pidvalue',mm.id);
        cc.addCondition();
         ApexPages.currentPage().getParameters().put('pidvalue',mm.id);
         ApexPages.currentPage().getParameters().put('sq',q.id);
        cc.EditSQuestion();
        ApexPages.currentPage().getParameters().put('sq',q.id);  
        cc.deleteSQuestion();
        
      
      
      
      }
      }
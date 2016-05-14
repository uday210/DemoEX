@isTest
public with sharing class Test_MM_Surevycon{

static testMethod void TestMethod_MM_Surevycon(){
contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'tst220', email='tesntv12v3fl@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='tesntv12v3fl@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;       
                  
         
     // ------------------ Boothtadmin Insert ---------------------
         
       user bAdmin =  new User(alias = 'tetboot', email='testbootghadminff@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testbootghadminff@noemail.com');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
         
                  
       Profile__c customProfile= new Profile__c (PR_Name__c='Attendee',PR_Version__c='1.5');        
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
      
      AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
     string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
     
     Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
     insert event_att_map ;           
     
      User_Profile_Event__c upebooth = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=profileId,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
      insert upebooth; 
      
      User_Profile_Event__c upebooth1 = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate');         
      insert upebooth1; 
     //Event_Attendee_Mapping__c getEvent_att_map = new Event_Attendee_Mapping__c ();
     //getEvent_att_map  =[select id,Attendee_Event_IDs__c,EV_id__c,AS_id__c from Event_Attendee_Mapping__c  where Id=:event_att_map.Id];
     MMQuestion__c mm = new MMQuestion__c(Events__c=eve.id,IsConditional__c=true,IsInclude__c=true,IsRequired__c=false,Order_No__c=1,Type__c='text',Whom__c='mbe');
      insert mm;
      Option__c op= new Option__c(order__c=1,Question__c=mm.id);
      insert op;
      Qaj__c q= new Qaj__c(Option__c=op.id,Question__c=mm.id);
      insert q;
      
      Answer__c ans = new Answer__c(Ans__c='how ar u?',Ans_By__c=event_att_map.id,Answer_Default__c=true,Answer_Order__c=1,Option__c=op.id,Question__c=mm.id,Surveyor__c=event_att_map.id);
      insert ans;
      MM_Surevycon mmcon= new MM_Surevycon();
       mmcon.firstMethod(eve.id,u.id);
       mmcon.surveyQuetionsMethod(event_att_map.id);
       
      //mmcon.Save(mmcon.queInn);
       //mmcon.AndObject();
       //mapAnsInn = new MAP<id,List<Answer__c>>();
      
      //MM_Surevycon.QueQithOpt que = new MM_Surevycon.QueQithOpt(mm,null,null);
      }
      
      }
@isTest
public class Test_MM_ProfileCon  {

    public static testMethod void testdoget(){
    
       user uname=[select createdby.id from user where profile.Name = 'system Administrator' AND Isactive = true Limit 1];
       
       account acc=new account();
       acc.name='Booth Leads';
       acc.ownerid=uname.id;       
       insert acc;
        
       Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User']; 
      User u2 = new User(Alias = 'newUser', Email='newuserww@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p1.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='newuserww@testorg.com');
        insert u2;
      // The following code runs as user u3. 
         User u3 = [SELECT Id FROM User WHERE UserName='newuserww@testorg.com'];
         
        
    User uu = new User(Alias = 'newUser', Email='test123t@cpokgn.com', 
         EmailEncodingKey='UTF-8', LastName='Testing33', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p1.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='test123t@cpokgn.com');
        insert uu;    
        
     system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA '+acc.id);
     // Event Inserting 
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_Publish__c =true,
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_StartDate__c=date.valueOf('2013-09-24'),
                             EV_EndDate__c=date.valueOf('2013-09-25'),
                             MM_Start_Date__c =date.valueOf('2013-09-24'),
                             MM_Firstaday_startTime__c='2:00 PM',
                             MM_Firstaday_EndTime__c='6:00 PM',
                             MM_Slot_Timeperiod__c='10',
                             MatchMaking_Type__c='Semi Open',
                             Status__c='Event in Progress',
                             Is_Webank_event__c=true
                                   
                             );
      insert eve;
      Id EventId=eve.Id;
      
        Event__c eve1 = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_Publish__c =true,
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_StartDate__c=date.valueOf('2013-09-24'),
                             EV_EndDate__c=date.valueOf('2013-09-25'),
                             MM_Start_Date__c =date.valueOf('2013-09-24'),
                             MM_Firstaday_startTime__c='2:00 PM',
                             MM_Firstaday_EndTime__c='6:00 PM',
                             MM_Slot_Timeperiod__c='10',
                             MatchMaking_Type__c='Semi Open',
                             Status__c='Event in Progress',
                             Is_Webank_event__c=false
                                   
                             );
      insert eve1;
        
        
      system.debug('WQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ '+EventId);
      
     // Login user 
       contact  con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con;
           
       AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123t@cpokgn.com';
        att.AS_Company__c ='global';
        att.AS_NAICSCode_1__c='12345&23456&23456&45679';
        att.AS_NAICSCode_2__c='12345&23456&23456&45679';
        att.AS_NAICSCode_3__c='12345&23456&23456&45679';
        att.AS_NAICSCode_4__c='12345&23456&23456&45679';
        att.AS_NAICSCode_5__c='12345&23456&23456&45679';
        att.AS_NAICSCode6__c='12345&23456&23456&45679';
        att.AS_NAICSCode7__c='12345&23456&23456&45679';
        att.AS_NAICSCode8__c='12345&23456&23456&45679';
        att.AS_NAICSCode9__c='12345&23456&23456&45679';
        att.Commodity_1__c='Accounting';
        att.Commodity_2__c='Advertising';
        insert att;
        
        
         
        
          list<NAICS_Code__c>  ll = new list<NAICS_Code__c>();
        NAICS_Code__c naicscode1= new NAICS_Code__c();
              naicscode1.Name='1234';
              naicscode1.Description__c='Naics Sample1';
              insert naicscode1;
              ll.add(naicscode1);
               NAICS_Code__c naicscode2= new NAICS_Code__c();
              naicscode2.Name='2345';
              naicscode2.Description__c='Naics Sample2';
              insert naicscode2;
           ll.add(naicscode2);
           
            NAICS_Code__c naicscode3= new NAICS_Code__c();
              naicscode3.Name='3456';
              naicscode3.Description__c='Naics Sample3';
              insert naicscode3;
              
              
              
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id,DiversityType__c='Minority Owned Business Enterprise'); 
        insert eam;
        
        Profile p = [select id from Profile where name='attendee'];
        
        user u = new user(alias = 'test1234', email='test1234@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles', username='test1234@noemail.com');
                  insert u;
         system.debug('XXXXXX123XXXXXXXXXXXXXx '+U );
        Id attendeeId =u.id;  
         system.debug('XXXXXXXXXXXXXXXXXXXXXXXXXx '+attendeeId );
    
        
      // inserting profile Cus    
      Profile__c attendeeProfile= new Profile__c (PR_Name__c='attendee',PR_Version__c='1.5');        
       insert  attendeeProfile;  
       
     // Insert upe for login user  
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
     insert upeEA;   
     system.debug('WWWWWWWWWWWWWWWWWWWWWWW  '+EventId);
        
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
    insert a;
    
        Attachment attt=new Attachment();
        attt.Name='Attachmet1';
        attt.Body=blob.valueOf('testcontent1');
        attt.Description='Attachmnt Description';
        attt.ContentType='html';
        attt.ParentId=att.id;
        insert attt;
    
    cookie  counter = new Cookie('counter',EventId,null,-1,false);
     PageReference pageRef = Page.MM_Profile;
     Test.setCurrentPage(pageRef);
       ApexPages.currentPage().setCookies(new Cookie[]{counter});
       Cookie k = ApexPages.currentPage().getCookies().get('counter');
           
   system.debug('AAAAAAAAAAAAWWWWWWWWWWW '+k);
     
     
     System.RunAs(u){
    MM_ProfileCon profile = new MM_ProfileCon();
    profile.myimageName='cpk';
    profile.attendeeImage=blob.valueOf(profile.myimageName);
    profile.save();
    }
   
    upeEA.MAtchMakingProfile__c ='Corporate';
    update upeEA;   
    System.RunAs(u){
     MM_ProfileCon profile = new MM_ProfileCon();
     profile.nodiversity='abcd';
     profile.NaicsBoolean=true; 
     profile.imageerror=false;   
     profile.exebitorimageerror=true;
     profile.selectedNAICS1='hhdjj';
     profile.selectedNAICS2='fef';
     profile.selecteddelnaic='llok'; 
     profile.delbool=true;
     profile.selectEvent = counter.getvalue();
     profile.exhibitorImageName ='cpk';
     profile.ExhibitorImage=blob.valueOf(profile.exhibitorImageName );
     profile.getmyfile();
     //profile.savepro();
     profile.naicscodesfun();
     profile.NAICS1Mod ='sda';
     profile.NAICS2Mod ='sadad';
     profile.NAICS3Mod ='12eqweq3456';
     profile.NAICS4Mod ='123qeq456';
     profile.NAICS5Mod ='qeq';
     //profile.commchangeids='wwww';
     //profile.updateUser(id.att);   
     profile.CheckUser();
     System.runAs(u3) {
       //profile.delattachment();
     }
     profile.commodityfun();
     //profile.delvideo();
     profile.saveDiversity();
    profile.naicschangeselctdids=att.id+'-'+att.id;
        
    profile.commchangeselctdids=att.id+'-'+att.id;
        
    profile.save();
/*   
   profile.youtubevideo.YouTubeId_c__c='<iframe width="854" height="510" src="https://www.youtube.com/embed/afK95S3UeyU" frameborder="0" allowfullscreen></iframe><iframe width="854" height="510" src="https://www.youtube.com/embed/tpBQmR95aPI" frameborder="0" allowfullscreen></iframe>';
    profile.youtubevideo.AttendeeSummary__c=att.id;
  profile.optionsAttdiversity.add('test1');
  profile.optionsAttdiversity.add('test2');
  profile.optionsattdiversity2.add('mtest1');
   profile.optionsattdiversity2.add('mtest2');
   profile.optionsevediversity2.add(new SelectOption('sgr','sgr'));
    profile.optionsevediversity2.add(new SelectOption('sgr1','sgr1'));
    profile.optionsevediversity.add(new SelectOption('bsgr1','bsgr1'));
    profile.optionsevediversity.add(new SelectOption('besgr1','besgr1'));
   profile.listinn.add(new MM_ProfileCon.inn('Global Event',profile.optionsAttdiversity ,profile.optionsevediversity2,profile.optionsevediversity,eam.id,profile.optionsattdiversity2));
   
    profile.savepro();  */
        
     MM_ProfileCon profile2 = new MM_ProfileCon();
     profile2.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id;        
     profile2.commchangeselctdids=att.id+'-'+att.id+'-'+att.id;
     profile2.save();
     //profile2.savepro();
        
     MM_ProfileCon profile3 = new MM_ProfileCon();
     profile3.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile3.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile3.save();
     //profile3.savepro();
        
     MM_ProfileCon profile4 = new MM_ProfileCon();
     profile4.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile4.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile4.save();
    // profile4.savepro();
     
     test.startTest();
     MM_ProfileCon profile5 = new MM_ProfileCon();
     profile5.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile5.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile5.save();
   //  profile5.savepro(); 
   
     MM_ProfileCon profile6 = new MM_ProfileCon();
     profile6.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile6.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile6.save();
   //  profile6.savepro();
        
     MM_ProfileCon profile7 = new MM_ProfileCon();
     profile7.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile7.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile7.save();
   //  profile7.savepro();
     
     MM_ProfileCon profile8 = new MM_ProfileCon();
     profile8.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile8.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile8.save();
    // profile8.savepro();
        
     MM_ProfileCon profile9 = new MM_ProfileCon();
     profile9.naicschangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;        
     profile9.commchangeselctdids=att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id+'-'+att.id;
     profile9.save();
  //   profile9.savepro();
     test.stopTest();
        
    MM_ProfileCon.inn i= new MM_ProfileCon.inn('raj',null,null,null,null,null);
    MM_ProfileCon profile1 = new MM_ProfileCon();

    eve1.Is_Webank_event__c=false;
   // profile.delattachment();    
      
      MM_ProfileCon mm_pr = new MM_ProfileCon();
      mm_pr.Select0=true;
      mm_pr.Select1=true;
      mm_pr.Select2=true;
      mm_pr.Select3=true;
      mm_pr.Select4=true;
      mm_pr.Select5=true;
      mm_pr.Select6=true;
      mm_pr.Select7=true;
      mm_pr.Select8=true;
      mm_pr.Select9=true;
      mm_pr.Select10=true;
      mm_pr.Select11=true;
      mm_pr.Select12=true;
      mm_pr.Select13=true;
      mm_pr.Select14=true;
      mm_pr.saveDiversitypro();
      mm_pr.updatemath();
      mm_pr.saveDiversity();
      
    MM_ProfileCon.updateUser(att.id);
 // ApexPages.currentPage().getParameters().put('deletedId', attt.id) ; 
 //   mm_pr.delattachment();
        //mm_pr.savepro();
    
  
        
     }
    
    }
    
 }
@istest

public class Test_BL_AttendeesImportCon
{
  static testmethod void Testmethod_BL_AttendeesImportCon()
  {
              
                   
            Profile p = [select id from profile where name='Standard User'];   
            User u = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US',country='United States',
            timezonesidkey='America/Los_Angeles', username='tes98673@noemail.com');
            insert u;  
            
            account a=new account(name='govtnm');
            insert a;
            
            contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
            insert m;      
            
            user EAdmin =  new User(alias = 'testboot', email='testeventadmin@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US',country='United States',
            timezonesidkey='America/Los_Angeles', username='testeventadmin@noemail.com');
            
            insert EAdmin ;
            
            
            user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US',country='United States',
            timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com');
            
            insert bAdmin ;
            
            
            Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
            insert  customProfile;
            
            Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
            insert  customProfileBooth;  
            
            Profile__c customprofilebpl = new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='1.5');
            insert customProfilebpl;
            
             Profile__c customAttendee = new Profile__c (PR_Name__c='Attendee',PR_Version__c='1.5');
            insert customAttendee;
            
            
            Event__c event = new Event__c(EV_Title__c = 'Test Event', StartTime__c = '09:00 AM', EV_EndTime__c='09:00 PM',EV_StartDate__c = Date.newInstance(2012,05,01),EV_EndDate__c = Date.newInstance(2012,05,01) );
            insert event;
            
            SecurityControls__c sc = new SecurityControls__c(EV_id__c = event.id, EV_Req_Fields__c= 'AS_FirstName__c' );
            insert sc;
            
            System.currentPageReference().getParameters().put('id', event.id);
            
            
            BL_AttendeesImportCon imp= new BL_AttendeesImportCon();
            
            string fieldsOf = 'Attendee_FirstName__c,Attendee_LastName__c,Attendee_Company__c,Attendee_EmailId__c,Attendee_NewPrefix__c,Attendee_NewSuffix__c,Attendee_Designation__c,Attendee_ShippingPhoneNumber__c, Attendee_CellPhoneNumber__c,Attendee_Age__c,Attendee_Gender__c,Attendee_BirthDate__c,Attendee_HomePhoneNumber__c,Attendee_HomeAddress__c,Attendee_HomeAddress1__c,Attendee_HomeCity__c,Attendee_HomeState__c,Attendee_HomePOBox__c,Attendee_ShippingAddress__c,Attendee_ShippingAddress2__c,Attendee_shippingCity__c,Attendee_shippingState__c,Attendee_ShippingPOBox__c,Attendee_WorkPhone__c,Attendee_WorkAddress__c,Attendee_WorkAddress1__c,Attendee_Workcity__c,Attendee_WorkState__c,Attendee_WorkPOBox__c,Attendee_NAICS_Code1__c,Attendee_NAICS_Code2__c,Attendee_NAICS_Code3__c,Attendee_PrimaryBusinessCategory1__c,Attendee_SecondaryBusinessCategory2__c,Attendee_Business_NoOfEmployees__c,Attendee_BusineesEstablished_Date1__c,Attendee_BusinessRevenue__c,Attendee_BusinessTaxId__c,Attendee_Business_DnB_Id__c,Attendee_WebsiteURL__c,Attendee_BlogURL__c,Attendee_DiversityType1__c,Attendee_BusineesDescription__c,AttendeePic';
            
            imp.dataFromJavaScript = String.valueOf('Prefix,Last Name,First Name,Email Id,Designation,Mobile Number,Shipping Phone Number, Work Fax Number,Gender,Home Address 1,Home City,Home Zip Codek,Work Address 2,Work State,Shipping Address 1,Shipping City \r ym,mn2,mn3,mallik@mallik.com,mn4,mn4,mm4,7896541230,25,male,24,02/05/1985,$4231,this is businessdescrption????:::::******&&&&&&%%%%;;;;TestfileName'); 
            
            imp.contentFile = blob.valueOf('Prefix,Last Name,First Name,Email Id,Designation,Mobile Number,Shipping Phone Number, Work Fax Number,Gender,Home Address 1,Home City,Home Zip Codek,Work Address 2,Work State,Shipping Address 1,Shipping City'); 
            
            String RecordsForTesting = 'ym,mn2,mn3,mallik@mallik.com,mn4,mn4,mm4,7896541230,25,male,24,02/05/1985,$4231,this is businessdescrption';
            
            AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
            insert attSummary;
            Set<Id> attid = new Set<Id>();
            attid.add(attSummary.Id);
            
            list<AttendeeSummary__c> duke= new list<AttendeeSummary__c>();
            duke.add(attSummary);
            string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(event.id);   
          
            imp.checkUserId();
            imp.Events();
            imp.Attendees();
            imp.reportact();
            imp.DataImportaction();
            imp.CustomerAdminAct();
            imp.ProfileSettings();
            imp.getEvents();
            imp.DashboardAction();
            imp.clickUpload();
            imp.cancelInSelect();
            imp.exportToCSV();
            imp.loadData();
            imp.dummy();
            imp.MMExhibitorsdir();
            imp.MMAttendeesdir();
            imp.EventAdminDashboard();
            imp.CloseHelppopup();
            imp.searchStr='Test1';
            imp.singleEvent='Test2';
            BL_AttendeesImportCon.UnSuccessPop=1;
            imp.BeforeInsert=2;
            imp.AfterInsert=3;
            imp.Successbool=true;
            imp.DataImportBool=false;
            imp.DBValue='Test3';
            imp.DBValue2='Test4';
            imp.csvHeadersForFail='Test5';
            imp.allFields1='Test6';
            imp.allFields2='Test7';
            imp.ShowMapping=true;
            List<String> str = new List<String>();
            str.add('test9');
            str.add('Test8');
            imp.selectedValue=str;
            imp.totalAttendee=duke;
            BL_AttendeesImportCon.Successpop=1;
            imp.phnumber='9898988989';
            imp.reqMissing=duke;
            //imp.getResults();
            BL_AttendeesImportCon.validateEMail('test@test.com');
            List<String> AAP= new List<String>();
            AAP.add('Test10');
            AAP.add('Test11');
           // BL_AttendeesImportCon.checkMapping(AAP, AAP, AAP, 'event', 111, 123, 'rtyuio', event.id ,AAP);
            // validateNAICSCode(125478);
            // imp.s='9948822877';
            // BL_AttendeesImportCon.ValidatePhone('1234567890');
             string AllattendeeEmail='attSummary.id';
            // BL_AttendeesImportCon.insertUsers(attid,string.valueof(event.id));
             BL_AttendeesImportCon.UnSuccessRecords=6;
             imp.duplicatesOfAttendees=duke;
             // string fliename='test.csv';
             //BL_AttendeesImportCon.checkMapping(null, null, null,event.id, 123, 234,'test',event.id,customProfileBooth.id);
             //imp.CheckMap();
            //  LIST<InnerClass> innnnn = new LIST<InnerClass>();
            // innnnn = new InnerClass('Prefix', 'Prefix');
            // imp.innnnn.add(new innerclass('Prefix','Prefix')); 
            // system.debug('44444444444444444444444444444'+ imp.innnnn);
            // system.debug('wwwwwwwwwwwwwwwwwwwwwwww'+ userinfo.getUserId());
             // checkMapping(RecordsForTesting.split(','), fieldsOf.split(','),  fieldsOf.split(','), String.valueOf(event.id), 10 , 15, 'testfileName',event.id );
            // checkMapping(LIST<String> records100, LIST<String> Scolumns, LIST<String> DBFields, string singleEvent, Integer oldRec, Integer CSVRec,string fileName, id eventIdFor )
            // checkMapping(LIST<String> , LIST<String>, LIST<String>, string, Integer , Integer,string , id  )
            // checkMapping(LIST<String>, LIST<String>, LIST<String>, String, Integer, Integer, String, Id) 

            }
            
  }
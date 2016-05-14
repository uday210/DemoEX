global without sharing class ReadAndPopulateDataBatch implements Database.batchable<String>, Database.Stateful
{
   LIST<String> records;
   LIST<String> mySelectdValue;
    LIST<String> myInfo ;
    String singleEvent;
    Integer BeforeInsert;
    Integer rowCount;
    String nameFile;
    ID eventIdForAtt;
    list<string> profiles;
    Map<String,String> badgetype{get;set;}
    Map<String,String> badgecategory{get;set;}
   
   private static final Integer SCOPE_SIZE = 100;
    public ReadAndPopulateDataBatch (LIST<String> records,LIST<String> mySelectdValue,LIST<String> myInfo,String singleEvent,Integer BeforeInsert,Integer rowCount,String nameFile,ID eventIdForAtt,list<string> profiles){
    this.records=records;
    this.mySelectdValue=mySelectdValue;
    this.myInfo=myInfo;
    this.singleEvent=singleEvent;
    this.BeforeInsert=BeforeInsert;
    this.rowCount=rowCount;
    this.nameFile=nameFile;
    this.eventIdForAtt=eventIdForAtt;
    this.profiles=profiles;
    
    }
   global Iterable<String> start(Database.batchableContext batchableContext)
   { 
       return new ListIterator(records);
   }
   global void execute(Database.BatchableContext batchableContext, List<String> scope)  
   {
       //TODO: Create a map with the column name and the position.
       
       checkMapping(scope, mySelectdValue, myInfo,singleEvent,BeforeInsert,rowcount, nameFile , eventIdForAtt ,profiles);
   }
   global void finish(Database.BatchableContext batchableContext){}
   
   public Static Integer Successpop{get; set;}
   public Static Integer UnSuccesspop{get; set;}
   public static Integer UnSuccessRecords{get; set;} 
        public LIST<AttendeeSummary__c> duplicatesOfAttendees{get; set;} //Tofind the duplicates in the CSV File
        public static MAP<String, String> dataForUpsert{get; set;}
        public static MAP<String, String> dataForDiversity{get; set;}
   
   global void checkMapping(LIST<String> records100, LIST<String> Scolumns, LIST<String> DBFields, string singleEvent, Integer oldRec, Integer CSVRec,string fileName, id eventIdFor ,list<string> profiles )
       { 
                   
             system.debug('FFFFFFFFFFFFFFFFF'+ eventIdFor );
             
               Successpop = 0;
               UnSuccessPop=0;
               //MyDataImport myDI = new MyDataImport();
               LIST<String> hunrecords = new LIST<String>();
               
               dataForUpsert = new MAP<String, String>();
               dataForDiversity = new MAP<String, String>();
              
               integer hunreccount=0;
                     
               LIST<AttendeeSummary__c> totAttendee100  = new LIST<AttendeeSummary__c>();
             
               LIST<AttendeeSummary__c> afterAttendee = new LIST<AttendeeSummary__c>();  
               LIST<String> SuccessCSVRecords = new LIST<String>();
               LIST<String> UnsuccessCSVRecords = new LIST<String>();
               LIST<String> DuplicateCSVRecords = new LIST<String>();
               
              id eventId = eventIdFor;
               
              // LIST<AttendeeSummary__c>  eventAttendees = new LIST<AttendeeSummary__c>();
               MAP<String ,AttendeeSummary__c>  myEventAttendeesMap = new MAP<String, AttendeeSummary__c>();
              //eventAttendees = [select id, AS_Email__c,AS_FirstName__c,AS_LastName__c FROM AttendeeSummary__c WHERE Event_Id__c=: singleEvent];
        /*
              for(AttendeeSummary__c toMap :eventAttendees)
              {
                  myEventAttendeesMap.put(toMap.Attendee_EmailId__c.trim()+toMap.Attendee_FirstName__c+toMap.Attendee_LastName__c , toMap);
              }
              */
              
               String insertedId = '';
               LIST<String> insetedEmails = new LIST<String>();
               
               DataImport_SavePoint__c dbsavePoint = new DataImport_SavePoint__c();
               // QR_Eventadmin__c eventAdminid = new QR_Eventadmin__c();
               //-------------------------------------------------      
                    system.debug('`````````````````````````````````````````````'+ myEventAttendeesMap );
                
                    system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+ records100.size());
             
             totAttendee100.addAll(MyDataImportRotate( records100 ,Scolumns, DBFields, singleEvent,myEventAttendeesMap ));
            
             
             system.debug('**************************************'+totAttendee100);
                     
                            
               /*      if(records100.size()>=250 )  
                     {
                          for(String tenrec: records100)
                          {

                            if(hunreccount == 500)
                            {
                            totAttendee100.addAll(MyDataImportRotate( hunRecords ,Scolumns, DBFields, singleEvent,myEventAttendeesMap ));
                            hunrecords = new LIST<String>();
                            hunreccount=0;
                            
                            }
                           else{
                               hunRecords.add(tenrec);
                                hunreccount++; 
                           }   
                        }
                        if(hunreccount != 0)
                        {
                            totAttendee100.addAll(MyDataImportRotate( hunRecords ,Scolumns, DBFields, singleEvent,myEventAttendeesMap));
                        }
                     }else
                      {
                         system.debug('~~~~~~~~~~~~~~~~~~~~~'+ myEventAttendeesMap );
                         totAttendee100.addAll(MyDataImportRotate( records100 ,Scolumns, DBFields, singleEvent,myEventAttendeesMap ));
                      }
                      
              */       
              //-------------------------------------------         
          //  BeforeAttendee = [select id FROM AttendeeSummary__c WHERE Event_Id__c =: singleEvent];
           
            
          //--//  eventAdminid = [select id FROM QR_Eventadmin__c WHERE User_ID__c =: UserInfo.getUserId()];
           
           system.debug('oooooooooooooooooooooooooooo'+ UserInfo.getUserId());
           
           //Code to search description for selectyed naics code By Thirupathi
            Database.UpsertResult[] MySaveResult = Database.upsert(totAttendee100,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField()  ,false);
             
          // Schema.DescribeFieldResult F = AttendeeSummary__c.Attendee_EmailId__c.getDescribe();
         //  Schema.sObjectField T = F.getSObjectField();
           
           
           LIST<ID> event_Attendee_Mappaing = new LIST<ID>(); // For Adding Junction Object-----------
          
           
         //  Database.UpsertResult[] MySaveResult = Database.upsert(totAttendee100,T, false);  
             UnSuccessRecords = 0;
             Integer csvRecordsCount=0;
             Integer Afterinsert= 0;  ///////////////********* [select count() FROM AttendeeSummary__c WHERE Event_Id__c =: singleEvent];
              for(Database.UpsertResult rer : MySaveResult){
              
                  
                 if(!rer.isSuccess())
                 {
                     // When the record is fails-----------------
                     Database.Error Inserterrors = rer.getErrors()[0]; 
                     system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+ csvRecordsCount+'REC'+records100[csvRecordsCount]);
                     
                         unsuccessCSVRecords.add(records100[csvRecordsCount] );
                     system.debug('**************************************'+ unsuccessCSVRecords[UnSuccessRecords]+ 'eeeeeeeeeee'+ rer.getErrors()[0]);
                     
                       csvRecordsCount++;
                       UnSuccessRecords ++;
                 } else if(rer.isSuccess())
                 {
                         // insertedId.add(rer.getId());

                        event_Attendee_Mappaing.add(rer.getId());

                        SuccessCSVRecords.add(records100[csvRecordsCount]); 
                        csvRecordsCount++;
                  }
                }
            

                MAP<ID, AttendeeSummary__c> afterSaveMap = new MAP<ID, AttendeeSummary__c>([SELECT ID,AS_uniqueField__c,AS_Email__c FROM AttendeeSummary__c WHERE ID IN: event_Attendee_Mappaing for update]);
                list<AttendeeSummary__c> attli = new list<AttendeeSummary__c> ();
                attli = [SELECT ID,AS_uniqueField__c,AS_Email__c FROM AttendeeSummary__c WHERE ID IN: event_Attendee_Mappaing for update];
                list<string> emails = new list<string>();
                set<id> attids = new set<id> ();
                MAP<string,string> attmapids = new MAP<string,string> ();
                for(AttendeeSummary__c emi : attli ){
                emails.add(emi.AS_Email__c);
                attids.add(emi.id);
                attmapids.put(emi.AS_Email__c,emi.id);
                }
               // List<string> vals = new list<string>();
               //string urlid = ApexPages.currentpage().getparameters().get('id');
            system.debug('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu  11 '+emails +'   '+emails.size());
            system.debug('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu   222'+attids.size());
             //vals= urlid.split('111');
               LIST<Event_Attendee_Mapping__c> EventATtendeeMap = new LIST<Event_Attendee_Mapping__c>();
               //List<string> profilekey = vals[1].split('222');
               for(id mapId: event_Attendee_Mappaing)
               {
                   Event_Attendee_Mapping__c SingleMapping = new Event_Attendee_Mapping__c();
                  
                 
                   
                   SingleMapping.AS_id__c = mapId;
                   SingleMapping.EV_id__c = eventId;
                   SingleMapping.Attendee_Event_IDs__c = (String)mapId+eventId;
                   SingleMapping.TicketTypes__c = dataForUpsert.get(afterSaveMap.get(mapId).AS_uniqueField__c);
                   SingleMapping.DiversityType__c = dataForDiversity.get(afterSaveMap.get(mapId).AS_Email__c);
                   try{
                   SingleMapping.TicketTypesBP__c=badgetype.get(afterSaveMap.get(mapId).AS_Email__c);
                   SingleMapping.GuestType__c=badgecategory.get(afterSaveMap.get(mapId).AS_Email__c);
                   }catch(Exception e){}
                   try{
                   if(profiles[0] != 'BoothLeads'){
                   SingleMapping.IsMatchMakingAttendee__c = true;
                   }
                   if(profiles[1] == 'Corporate'){
                    SingleMapping.Boothleads_Profile__c = 'BoothAdmin';
                   }}catch(Exception e){}
                   EventATtendeeMap.add(SingleMapping);
               
               }

                Database.upsertResult[] AttEventJun = Database.upsert(EventATtendeeMap , Event_Attendee_Mapping__c.Attendee_Event_IDs__c.getDescribe().getSObjectField() , false);
                insertUsers(attids,eventId );
                ///////////////FOR INSERTING BOOTHS(MYTHILY)
                MAP<string,id> mapBooth = new MAP<string,id>();
                List<booth__c> booths = new List<booth__c>();
                    for(AttendeeSummary__c att:[select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from AttendeeSummary__c where Id IN :attids for update]){
                        booth__c boothinsert = new booth__c();   
                        boothinsert.BT_Name__c=att.AS_Company__c;
                        boothinsert.EV_id__c = eventId;   
                        boothinsert.BT_ContactName__c = att.AS_FirstName__c +' '+att.AS_LastName__c ;   
                        boothinsert.BT_ContactEmail__c = att.AS_Email__c;   
                        boothinsert.BT_ContactPhone__c = att.AS_WorkPhone__c;    
                        booths.add(boothinsert); 
                        
                        }  
                        Database.SaveResult[] MySaveResultBooth =dataBase.insert(booths,false);       
                        for(booth__c bo:booths){
                        mapBooth.put(bo.BT_ContactEmail__c,bo.id);
                        }
                ///////////////////////////////////////////////////
                 list<User_Profile_Event__c> UPEINSERT = new list<User_Profile_Event__c> ();
               List<user> use = new list<user>();
             try {
                 use = [select id,companyName,username from User where username IN: emails];
             } catch (exception e) {}
            Profile__c profil = [select id, Name from Profile__c where PR_Name__c = : 'Attendee'];
            Profile__c profil1 = [select id, Name from Profile__c where PR_Name__c = : 'BoothAdmin']; 
           
             System.debug('use.size() '+use.size());
             System.debug('UserInfo.getUserId() '+UserInfo.getUserId());
            
              if (use.size() != 0) {
              for(User uu : use){
              User_Profile_Event__c uperec = new User_Profile_Event__c ();
              uperec.EV_id__c = eventId;
               uperec.BT_id__c =mapBooth.get(uu.username);
                 uperec.UEP_isActive__c = true;
                 uperec.User_id__c = uu.id;
                 uperec.BoothAdmin_id__c = uu.id;
                 uperec.Attendee_Event_IDs__c = attmapids.get(uu.username)+'-'+eventId;
                 try{if(profiles[1] == 'Corporate'){
                    uperec.Profile_id__c = profil1.id;
                     uperec.MAtchMakingProfile__c = 'Corporate';
                   }else{
                   uperec.Profile_id__c = profil.id;
                    uperec.MAtchMakingProfile__c = 'MBE';
                   }
                   if(profiles[0] == 'MatchLeads'){
                   uperec.IsMatchMakingUser__c = true;
                   }}catch(Exception e){uperec.Profile_id__c = profil.id;}
                 
                 uperec.EventAdmin_Id__c=UserInfo.getUserId();
              UPEINSERT.add(uperec);
             
              }
              }
              else{
                          
              }
              Database.upsertResult[] upeJun = Database.upsert(UPEINSERT , User_Profile_Event__c.Attendee_Event_ids__c.getDescribe().getSObjectField() , false);
              system.debug('uuuuuuuuuuuuuuuuuuuuupepppppppppppppp'+upeJun);
                integer insertRec=0;
                integer updateRec=0;
                
                for(Database.UpsertResult rer : AttEventJun){
                
                    if(rer.IsSuccess())
                    {
                        if(rer.isCreated())
                        {
                            insertRec++;
                            insertedId += rer.getId()+','; //ID's are storing in "DataBase Save Point" For Roll Back 
                        }else if(!rer.isCreated()){
                            updateRec++;
                        
                        }
                    
                    }
                    
                    system.debug('UUUUUUUUUUUUUUUUUUUUU'+ rer );
                
                }
                
               MAP<ID, Event_Attendee_Mapping__c> barCodeUpdate = new MAP<id, Event_Attendee_Mapping__c>([select id, EA_AttendeeBarcode__c,EV_id__c FROM Event_Attendee_Mapping__c WHERE ID IN: insertedId.split(',')]);
                
               LIST<Event_Attendee_Mapping__c> barCodeUpdateList = new LIST<Event_Attendee_Mapping__c>([select id, EA_AttendeeBarcode__c,EV_id__c FROM Event_Attendee_Mapping__c WHERE ID IN: insertedId.split(',')]);
                
            system.debug('JJJJJJJJJJJJJJJJJJJ  333333333 '+barCodeUpdateList.size() );     
          //  system.debug('JJJJJJJJJJJJJJJJJJJ  2222222 '+barCodeUpdateList.values().size() ); 
             
                for(Event_Attendee_Mapping__c e: barCodeUpdateList )
                {
                      Event_Attendee_Mapping__c ee= new Event_Attendee_Mapping__c ();
                      ee = barCodeUpdate.get(e.id);
                      ee.EA_AttendeeBarcode__c = e.id+'-'+e.EV_id__c;
                      if(e.id==ee.id){
                         barCodeUpdate.put(e.id, ee);
                     } 
                }
                
                 system.debug('JJJJJJJJJJJJJJJJJJJ  111111111 '+barCodeUpdate.Values().size() );
                Database.SaveResult[] barcodeJun = Database.update(barCodeUpdate.Values(), false);
               
                for(Database.SaveResult ds: barcodeJun )
                {
                    system.debug('JJJJJJJJJJJJJJJJJJJ   '+  ds );
                }
                
                
                
             //  afterAttendee  = [select id,Attendee_EmailId__c FROM AttendeeSummary__c WHERE (Event_Id__c =: singleEvent AND id !=: BeforeAttendee) ];
              
              
              
                afterinsert = [select Count() FROM Event_Attendee_Mapping__c WHERE EV_id__c =: eventId];
             
             system.debug('JJJJJJJJJJJJJJJJJJJ   '+  SuccessCSVRecords.size() );
               system.debug('KKKKKKKKKKKKKKKKKKK   '+  CSVRec );
              // system.debug('TTTTTTTTTTTTTTTTTTT   '+  ds );
               
             
               //Successpop = SuccessCSVRecords.size();
               //UnSuccessPop = CSVRec - Successpop -1;
               
                Successpop = records100.size();
               UnSuccessPop = records100.size()- Successpop;
               
               String success =  'Number of records imported: '+ records100.size() + '<br/>'+
                                 'Number of records created successfully: '+ insertRec +'<br/>'+
                                 'Number of records updated successfully: '+ updateRec +'<br/>'+
                                 'Number of records failed: '+ UnSuccessPop +'<br/>'+ 
                                 'Number of records prior to import: '+ OldRec +'<br/>'+
                                 'Total number of records: '+Afterinsert+ '<br/><br/>';
                
               String emailMessage =  'BoothLeads.com has just completed your import process!'+'<br/><br/>'+
                                       success +
                                       'We strongly recommend that you check a few of your imported records to verify that your information was imported as expected.'+'<br/><br/>'+
                                       'If you encounter any problems or have any questions, please contact Boothleads Customer Support.<br/><br/>'+
                                       'Thank you! <br/> BoothLeads Customer Support <br/> support@boothleads.com <br/> Phone: 1-(800)-492-1289' ;
                
                
                system.debug('MALLIKKKKKKKKKKK'+ 'OOOOOORRRRR'+ insertedId+'QQQQQQQQ'+ FileName );
                if(insertedId != '' && FileName != NULL)
                {
                    
                    system.debug('STARTEDDDDDDDDDDDDDDDDDDDDDDDD');
                    dbsavePoint.DS_FileName__c = FileName;
                    dbsavePoint.DS_ImportedHistory__c = success;
                    dbsavePoint.DS_ImportedId__c = insertedId.subString(0, insertedId.lastIndexOf(','));
                    dbsavePoint.User_id__c = Userinfo.getUserId();
                    dbsavePoint.DS_TotalRecords__c = Successpop;
                    dbsavePoint.Event__c = eventId;
                    
                    insert dbsavePoint;
                    
                    system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
                    
                }
                
                String mailCSVAttachment='';
                for(String ss: UnsuccessCSVRecords)
                {
                  mailCSVAttachment = mailCSVAttachment + ss.replaceAll(',',' ').replaceAll(';;;:::', ',')+'\r';
                }
                
                
               mailCSVAttachment = mailCSVAttachment.substringBefore('????:::::******&&&&&&%%%%;;;;');
             system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+ mailCSVAttachment );
              /*  mailCSVAttachment += ('\n'+'SUccess Records'+'\n');
                
                for(String suc: SuccessCSVRecords)
                {
                   string recordString = suc;
                   mailCSVAttachment = mailCSVAttachment + recordString;
                } */
    Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
                
                //Prepare Mail For Failure Attachments
                if(unsuccessCSVRecords.size()!=0){
                if(mailCSVAttachment!=null&&mailCSVAttachment!=''&&mailCSVAttachment!='null'){
                blob csvBlob = Blob.valueOf(mailCSVAttachment);
                string csvname= 'Import Attendees Failures.csv';
                csvAttc.setFileName(csvname);
                csvAttc.setBody(csvBlob);}}
                
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                 String[] toAddresses = new String[] {UserInfo.getUserName()};
                 
                 mail.setToAddresses(toAddresses);
                 mail.setReplyTo('support@boothleads.com');
                 mail.setSubject('Import Attendees Summary');
                 mail.setPlainTextBody(emailMessage);
                 mail.setHtmlBody(emailMessage);
                 if(unsuccessCSVRecords.size()!=0){
                 if(mailCSVAttachment!=null&&mailCSVAttachment!=''&&mailCSVAttachment!='null')
                 mail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});}
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
              
       }
   
   //Written by mythily to insert users for supporting ML
         
        global static void insertUsers(set<id> setOfatts ,string eventName ){
            ////////////////////////////////////////
            LIst<string> insertedRequiredUsers = new LIst<string>();
            List<string> AllattendeeEmail = new  List<string>();
            LIST<USER> InserteduserList =new  LIST<USER>();
            MAP<string,sobject> mapEmailwithatt = new  MAP<string,sobject>();
             MAP<string,id> mapContact = new MAP<string,id>();

            Map<string,AttendeeSummary__c> mapEmailwithatt2 = new Map<string,AttendeeSummary__c>();
            event__c eve = new event__c();
            
            //Profiles
            Profile__c profileCustom = new Profile__c();
            profileCustom =[select id,PR_Name__c from Profile__c where PR_Name__c='BoothAdmin' limit 1]; 
            List<profile> profileList =[select id from profile where name='Booth Admin'];
            
            // Event     
            eve =[select  EV_Title__c from event__c where id=:eventName limit 1];
            string eventName1 =eve.EV_Title__c; 
            
            
            for(AttendeeSummary__c att:[select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from AttendeeSummary__c where Id IN :setOfatts for update]){
            AllattendeeEmail.add(att.AS_Email__c);   
            mapEmailwithatt.put(att.AS_Email__c,att); 
            
            } 
          
            // ------------------------------------ setup objects  -----------------------------------------
            // Inserting contacts 
            List<contact> conList = new List<contact>(); 
            user uname=[select id from user where profile.Name Like 'System Administrator' and isActive=true Limit 1]; 
            for(AttendeeSummary__c attsum : [select AS_FirstName__c ,AS_Company__c,AS_LastName__c,AS_Email__c from   AttendeeSummary__c  where  id IN :setOfatts]){
             

            account acc=new account();
            if(attsum.AS_Company__c==null||attsum.AS_Company__c=='')
            acc.name=attsum.AS_FirstName__c+' '+attsum.AS_LastName__c;
            else
            acc.name=attsum.AS_Company__c;  
            //acc.ownerid = '005Z0000000oyN7';
            acc.ownerid=uname.id;          
            insert acc; 
         
            contact con = new contact();
            con.FirstName =attsum.AS_FirstName__c;
            con.lastName= attsum.AS_LastName__c;
            con.Email =attsum.AS_Email__c;
            // Con.AccountId='001F000000rVD6z';
           // Con.AccountId='001F000001DhQdr';
            con.AccountId=acc.id;
            conList.add(Con);
            }
            database.Saveresult[] conSaveres = database.insert(conList,false);
            
            for(contact co:conList){
            mapContact.put(co.email,co.id);
            } 
            
            
            
            // Inserting users 
            for(AttendeeSummary__c atts : [select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from AttendeeSummary__c  where AS_Email__c NOT IN :insertedRequiredUsers and AS_Email__c IN :AllattendeeEmail for update]){
            user u = new user(); 
            u.FirstName =atts.AS_FirstName__c;
            u.LastNAme =atts.AS_LastName__c;
            u.CompanyName =atts.AS_Company__c;
            u.email =atts.AS_Email__c;
            u.userName=atts.AS_Email__c;
            u.Company_website__c=atts.AS_WebsiteUrl__c;
            u.CompanyAddr1__c=atts.AS_WorkAddress1__c;
            u.CompanyAddr2__c=atts.AS_WorkAddress2__c;
            u.CompanyCity__c=atts.AS_WorkCity__c;
            u.Country__c =atts.AS_Work_Country__c;
            u.CompanyFaxNumber__c=atts.AS_FaxNumber__c;
            u.Companyphone__c =atts.AS_WorkPhone__c;
            u.States__c  =atts.AS_Work_States__c;
            u.contactId=mapContact.get(u.email);
            u.Alias ='BAdmin';
            u.ProfileID =profileList[0].id;
            u.isActive =false;
            u.LocaleSidKey ='en_US';
            u.LanguageLocaleKey ='en_US';
            u.TimeZoneSidKey ='America/Los_Angeles';
            u.EmailEncodingKey='UTF-8';
            InserteduserList.add(u);
            }
            Database.UpsertResult[] MySaveResultUser =dataBase.upsert(InserteduserList,false); 
            system.debug('boooooooooooooooooth admin '+MySaveResultUser);
            
            /////////////////////////////////////////////////////            
       }
       
      
       
        global LIST<AttendeeSummary__c> MyDataImportRotate(LIST<String> record100, LIST<String> ColNum, LIST<String> DBFields, String singleEvent, Map<String, AttendeeSummary__c> eventAttendeesMap )
       {
           
           badgetype=new Map<String,String>();
           badgecategory=new Map<String,String>();
           LIST<AttendeeSummary__c> oneTransactionTotalAttendees = new LIST<AttendeeSummary__c>();  

            MAP<String, String> checkDuplicate = new MAP<String, String>();
            
            SET<String> setForStatesToCountry = new SET<String>();
            
            setForStatesToCountry.addAll(DBFields);
            
            StateCountry sc = new StateCountry();
              transient MAP<string,NAICS_Code__c>  mapNamewithId = new MAP<string,NAICS_Code__c>();
              Commanforstates comstates = new Commanforstates();
              
              for(NAICS_Code__c n : [select id,name,Description__c from NAICS_Code__c ]){
                  mapNamewithId.put(n.Name,n);
              }    
                 
                          
              for(String singrec: record100)
              {
                  AttendeeSummary__c singleAttendee = new AttendeeSummary__c(); 
                     
                    System.debug('111111111111111111111111111'+ singrec);
                    
                     System.debug('AAAAAAAAAAAAAAAAAAAAAAA'+ record100 );
                      System.debug('BBBBBBBBBBBBBBBBBBBBBBBBB'+ ColNum);
                       System.debug('CCCCCCCCCCCCCCCCCCCCCCC'+ DBFields);
                    //    System.debug('DDDDDDDDDDDDDDDDDDDDDDDDD'+ singrec);
                     //    System.debug('EEEEEEEEEEEEEEEEEEEEEEEE'+ singrec);
                         
                    
                    
                     
                    LIST<String> Record = singrec.split(';;;:::');
                      System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$'+ Record);
                      integer DBRow = 0;
                        
                     integer firstNamenum = 0;
                     integer lastNamenum = 0;
                     integer emailnum = 0;
              
                       for(String rec: ColNum)
                       {
                        try{ 
                          System.debug('##########################'+ DBFields[DBRow]);
                          System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+ Record[Integer.ValueOf(Rec)]);
                           }catch(Exception e){} 
                         try{ 
                          
                          try{
                               if(Record[Integer.ValueOf(Rec)].contains('"'))
                                {
                                 Record[Integer.ValueOf(Rec)]= Record[Integer.ValueOf(Rec)].replaceAll('"','');
            
                                }            
                               }catch(Exception e){}           
                                          
                             If(DBFields[DBRow] =='AS_Email__c' || DBFields[DBRow] =='AS_DiversityType__c')
                             {
                                  if(DBFields[DBRow] =='AS_Email__c'){try{
                                     if(!checkDuplicate.containsKey(Record[Integer.ValueOf(Rec)].trim().toLowerCase()) ){
                                         checkDuplicate.put(Record[Integer.ValueOf(Rec)].trim().toLowerCase(), singrec);
                                         singleAttendee.put(DBFields[DBRow] ,Record[Integer.ValueOf(Rec)].trim().toLowerCase());
                                         
                                         emailnum = Integer.ValueOf(Rec);
                                         
                                       }
                                     }catch(Exception e){}  
                                 }else{
                                     try{
                                         dataForDiversity.put(Record[Integer.ValueOf(emailnum)].trim().toLowerCase(), Record[Integer.ValueOf(Rec)].trim());
                                     }catch(Exception e){}
                                 }
                             }          
                         
                             Else if(DBFields[DBRow]=='AS_Age__c'||DBFields[DBRow]=='AS_NumberOfEmployees__c'||DBFields[DBRow]=='AS_BusinessRevenue__c')
                             {
                                
                               if(DBFields[DBRow]=='AS_BusinessRevenue__c'){
                                    try{
                                    Decimal ss=0.0;
                                   
                                      if(String.ValueOf(Record[Integer.ValueOf(Rec)].trim()).contains('$'))
                                      {
                                           String ss1 = Record[Integer.ValueOf(Rec)].trim().SubString(1).replaceAll(',','');
                                           ss = Decimal.ValueOf(ss1);
                                      }else ss =   Decimal.ValueOf(Record[Integer.ValueOf(Rec)].trim().replaceAll(',',''));
                                         
                                     if(ss != 0.0)
                                     singleAttendee.put(DBFields[DBRow] , ss);
                                    }catch(Exception e){}
                               
                               }else{ 
                                    try{
                                     singleAttendee.put(DBFields[DBRow] , Integer.valueOf(Record[Integer.ValueOf(Rec)].trim()));
                                     }catch(Exception e){}
                                 }
                             }
                             Else If(DBFields[DBRow]=='AS_BirthDate__c'|| DBFields[DBRow]=='AS_BusinessEstablishedDate__c')
                             {
                                try{
                                 singleAttendee.put(DBFields[DBRow] , Date.parse(Record[Integer.ValueOf(Rec)].trim()));
                                }catch(Exception e){}
                             }
                             Else If(DBFields[DBRow]=='TicketTypesBP__c')
                             {
                                try{
                                 badgetype.put(singleAttendee.AS_Email__c,Record[Integer.ValueOf(Rec)].trim());
                                }catch(Exception e){}
                             }
                             Else If(DBFields[DBRow]=='GuestType__c')
                             {
                                try{
                                badgecategory.put(singleAttendee.AS_Email__c,Record[Integer.ValueOf(Rec)].trim());
                                }catch(Exception e){}
                             }
                             Else If(DBFields[DBRow]=='AS_WorkPhone__c'||DBFields[DBRow]=='AS_CellPhone__c'||DBFields[DBRow]=='AS_HomePhone__c'||DBFields[DBRow]=='AS_ShippingPhone__c')
                             {
                                try{
                                    
                                       singleAttendee.put(DBFields[DBRow] , ValidatePhone(Record[Integer.ValueOf(Rec)].trim()));
                                    }catch(Exception e){}
                             
                             }Else If(DBFields[DBRow]=='Registration_type__c' || DBFields[DBRow]=='AS_LastName__c' ){
                                 
                                 if(DBFields[DBRow]=='AS_LastName__c'){
                                   try{
                                     singleAttendee.put(DBFields[DBRow] , capitalizeFirstLetters(Record[Integer.ValueOf(Rec)].trim()));
                                     lastNamenum = Integer.ValueOf(Rec);

                                     String regs = (Record[Integer.ValueOf(firstNamenum)].trim() + Record[Integer.ValueOf(lastNamenum)].trim() + Record[Integer.ValueOf(emailnum)].trim()).replaceAll(' ','');
                                     singleAttendee.put('AS_uniqueField__c' , regs);
                                     }catch(Exception e){}
                                 } else{
                                    try{
                                     String regs = (Record[Integer.ValueOf(firstNamenum)].trim() + Record[Integer.ValueOf(lastNamenum)].trim() + Record[Integer.ValueOf(emailnum)].trim()).replaceAll(' ','');
                                     dataForUpsert.put(regs, Record[Integer.ValueOf(Rec)].trim());
                                   }catch(Exception e){}
                                 }
                                 
                                 
                               // system.debug('0000000000000000000000000000000000'+ dataForUpsert);
                                
                             }else if(DBFields[DBRow]=='AS_Work_States__c'){ 
                                try{
                                system.debug('000000000000000000000000000000000000000'+ ( ((Record[Integer.ValueOf(Rec)].trim()).length() == 2 )? ( sc.StateCountry(sc.states.get(Record[Integer.ValueOf(Rec)].trim())) ) : sc.StateCountry(Record[Integer.ValueOf(Rec)].trim())));
                                 string stateValue = comstates.longToShortConversion(Record[Integer.ValueOf(Rec)].trim()).toLowercase();
                                 singleAttendee.put(DBFields[DBRow] ,stateValue );
                                
                                 if(!setForStatesToCountry.contains('AS_Work_Country__c') ){
                                    // singleAttendee.put('AS_Work_Country__c'  , ((Record[Integer.ValueOf(Rec)].trim()).length() == 2)? ( sc.StateCountry(sc.states.get(Record[Integer.ValueOf(Rec)].trim())) ) : sc.StateCountry(Record[Integer.ValueOf(Rec)].trim()) );
                                      singleAttendee.put('AS_Work_Country__c'  , sc.StateCountry(stateValue) );
                                      system.debug('000000000000000000000000000000000000000  1111 '+ stateValue +'    '+  sc.StateCountry(stateValue));
                                 }else{
                                    singleAttendee.put('AS_Work_Country__c'  , sc.StateCountry(stateValue) );
                                    system.debug('000000000000000000000000000000000000000  2222 '+ stateValue +'    '+  sc.StateCountry(stateValue));
                         
                                 }
                                }catch(Exception e) {}
                             }else if(DBFields[DBRow]=='As_Home_State__c'){ 
                              try{
                                system.debug('1111111111111111111111111111111111'+ ( ((Record[Integer.ValueOf(Rec)].trim()).length() == 2 )? ( sc.StateCountry(sc.states.get(Record[Integer.ValueOf(Rec)].trim())) ) : sc.StateCountry(Record[Integer.ValueOf(Rec)].trim())));
                                singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                                 if(!setForStatesToCountry.contains('As_Home_Country__c') ){
                                     singleAttendee.put('As_Home_Country__c' , ((Record[Integer.ValueOf(Rec)].trim()).length() == 2)? ( sc.StateCountry(sc.states.get(Record[Integer.ValueOf(Rec)].trim())) ) : sc.StateCountry(Record[Integer.ValueOf(Rec)].trim()) );
                                     
                                 }
                                }catch(Exception e) {}
                             }else if(DBFields[DBRow]=='As_Shipping_States__c'){ 
                             
                                try{
                                system.debug('2222222222222222222222222222222222222'+ ( ((Record[Integer.ValueOf(Rec)].trim()).length() == 2 )? ( sc.StateCountry(sc.states.get(Record[Integer.ValueOf(Rec)].trim())) ) : sc.StateCountry(Record[Integer.ValueOf(Rec)].trim())));
                                
                                system.debug('?????????????????????????????????????'+  sc.StateCountry(Record[Integer.ValueOf(Rec)].trim()));
                                 singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                                 
                                 if(!setForStatesToCountry.contains('As_Shipping_Country__c') ){
                                     singleAttendee.put('As_Shipping_Country__c' , ((Record[Integer.ValueOf(Rec)].trim()).length() == 2)? ( sc.StateCountry(sc.states.get(Record[Integer.ValueOf(Rec)].trim())) ) : sc.StateCountry(Record[Integer.ValueOf(Rec)].trim()) );
                                     
                                 }
                                }catch(Exception e) {}
                             }
                  // Written by thirupathi for NAICS Codes description searching           
                    else if(DBFields[DBRow]=='As_NAICSCode_1__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            if(!setForStatesToCountry.contains('As_NAICSCode_1__c') ){
                                String nCodeTemp1=singleAttendee.As_NAICSCode_1__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp1);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp1 Limit 1];
                                String codeDesc1=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('As_NAICSCode_1__c' , codeDesc1);                       
                            }
                        }catch(Exception e) {}
                    }
                    
                    else if(DBFields[DBRow]=='As_NAICSCode_2__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            if(!setForStatesToCountry.contains('As_NAICSCode_2__c') ){
                                String nCodeTemp2=singleAttendee.As_NAICSCode_2__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp2);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp2 Limit 1];
                                String codeDesc2=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('As_NAICSCode_2__c' , codeDesc2);                       
                            }
                        }catch(Exception e) {}
                    }
                    
                    else if(DBFields[DBRow]=='As_NAICSCode_3__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            if(!setForStatesToCountry.contains('As_NAICSCode_3__c') ){
                                String nCodeTemp3=singleAttendee.As_NAICSCode_3__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp3);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp3 Limit 1];
                                String codeDesc3=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('As_NAICSCode_3__c' , codeDesc3);                       
                            }
                        }catch(Exception e) {}
                    }
                    
                    else if(DBFields[DBRow]=='As_NAICSCode_4__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            if(!setForStatesToCountry.contains('As_NAICSCode_4__c') ){
                                String nCodeTemp4=singleAttendee.As_NAICSCode_4__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp4);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp4 Limit 1];
                                String codeDesc4=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('As_NAICSCode_4__c' , codeDesc4);                       
                            }
                        }catch(Exception e) {}
                    }
                    
                     else if(DBFields[DBRow]=='As_NAICSCode_5__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            if(!setForStatesToCountry.contains('As_NAICSCode_5__c') ){
                                String nCodeTemp5=singleAttendee.As_NAICSCode_5__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp5);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp5 Limit 1];
                                String codeDesc5=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('As_NAICSCode_5__c' , codeDesc5); 
                                //System.debug('********123:'+codeDesc5);                      
                            }
                        }catch(Exception e) {}
                    }
                    
                    else if(DBFields[DBRow]=='AS_NAICSCode6__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            System.debug('WRKNG     WRKNG ');
                            //if(!setForStatesToCountry.contains('AS_NAICSCode6__c') ){
                                String nCodeTemp6=singleAttendee.AS_NAICSCode6__c;
                                //System.debug('@@@@@@@123:'+nCodeTemp6);
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp6);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp6 Limit 1];
                                String codeDesc6=ncObj.Name+' '+ncObj.Description__c;
                                //System.debug('#######123:'+codeDesc6);
                                singleAttendee.put('AS_NAICSCode6__c' , codeDesc6);                       
                            //}
                        }catch(Exception e) {}
                    }
                    
                     else if(DBFields[DBRow]=='AS_NAICSCode7__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            //if(!setForStatesToCountry.contains('AS_NAICSCode7__c') ){
                                String nCodeTemp7=singleAttendee.AS_NAICSCode7__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp7);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp7 Limit 1];
                                String codeDesc7=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('AS_NAICSCode7__c' , codeDesc7);                       
                            //}
                        }catch(Exception e) {}
                    }
                    
                    else if(DBFields[DBRow]=='AS_NAICSCode8__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                           //if(!setForStatesToCountry.contains('AS_NAICSCode8__c') ){
                                String nCodeTemp8=singleAttendee.AS_NAICSCode8__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp8);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp8 Limit 1];
                                String codeDesc8=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('AS_NAICSCode8__c' , codeDesc8);                       
                           // }
                        }catch(Exception e) {}
                    }
                    
                    else if(DBFields[DBRow]=='AS_NAICSCode9__c'){
                        try{singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                            
                            //if(!setForStatesToCountry.contains('AS_NAICSCode9__c') ){
                                String nCodeTemp9=singleAttendee.AS_NAICSCode9__c;
                                NAICS_Code__c ncObj=mapNamewithId.get(nCodeTemp9);
                                //[Select Id, Description__c, Name from NAICS_Code__c Where Name= :nCodeTemp9 Limit 1];
                                String codeDesc9=ncObj.Name+' '+ncObj.Description__c;
                                singleAttendee.put('AS_NAICSCode9__c' , codeDesc9);                       
                            //}
                        }catch(Exception e) {}
                    }
                    
                          
                             Else{
                                 try{
                                 singleAttendee.put(DBFields[DBRow] , Record[Integer.ValueOf(Rec)].trim());
                                 

                                }catch(Exception e){} 
                           }
                           
                           
                           if(DBFields[DBRow]=='AS_FirstName__c'){
                            singleAttendee.put(DBFields[DBRow] , capitalizeFirstLetters(Record[Integer.ValueOf(Rec)].trim()));
                            firstNamenum = Integer.ValueOf(Rec);
                         } 
                           
                           }Catch(Exception e){}
                        DBRow++;
    
                     } 
                     
                     system.debug('4444444444444444444444444'+ singleAttendee );
                     system.debug('GGGGGGGGGGGGGGGGGGGGG'+ singleAttendee.AS_Work_States__c+'**********'+singleAttendee.AS_FirstName__c+'&&&&&&&'+singleAttendee.AS_LastName__c ); 
                    system.debug('HHHHHHHHHHHHHHHHHHHHH'+ singleAttendee.AS_Work_Country__c );
                    system.debug('IIIIIIIIIIIIIIIIIIIIIII'+ singleAttendee.As_Shipping_States__c );
                    system.debug('JJJJJJJJJJJJJJJJJJJJJJJ'+ singleAttendee.As_Shipping_Country__c );
                    system.debug('KKKKKKKKKKKKKKKKKKKKKK'+ singleAttendee.As_Home_State__c );
                    system.debug('LLLLLLLLLLLLLLLLLLLLLL'+ singleAttendee.As_Home_Country__c );
                     system.debug('NCNCNCNCNCNCCN:'+ singleAttendee.As_NAICSCode_1__c );
                                
                   oneTransactionTotalAttendees.add( singleAttendee);
                 // End of Single Field    
                           
          }
       
       return oneTransactionTotalAttendees;
            
       }
       
       
       
       public static String ValidatePhone(String s)
        {
          Boolean isValid;
          
          String phoneString =s.replace(')','').replace('(','').replace(' ','').replace('-','');
          String  phNumber;  
            Pattern phonePattern = Pattern.compile('\\D*?(\\d\\D*?){10}'); 
            Pattern numericPattern = Pattern.compile('[0-9]{10}');
       
            Matcher phoneMatcher = phonePattern.matcher(phoneString );
            Matcher   numericMatcher = numericPattern.matcher(phoneString );
            
           if(numericMatcher.matches())  
           {  
               isValid =true;
                string countrycode = phoneString .Substring(0, 3); 
                string Areacode = phoneString .Substring(3, 6); 
                string number23 = phoneString .Substring(6,phoneString .Length()); 
                
              phNumber='('+countrycode+')' +' '+Areacode+'-' +number23 ;
            }else{  
             
              isValid =false;
           }  
          return phNumber;  
        }
        
        
        
        
        
        //---------------------------------------------------- Test Methods ----------------------------------------------------------------------
  public integer i{get;set;}

  public static String capitalizeFirstLetters(String name) {
    name = name.toLowerCase();
    String result = '';
    //List of separators after which we should capitalize letter
    String[] separatorList = new String[]{' ','-'};
    if (name != null && name != '') {
        result = name;
        for(String separator : separatorList){
            String tmpResult = '';
            for (String iter : result.split('[' + separator+']+')) {                
                if (iter != null && iter != '') {
                    if (iter.length() > 1) {  
                        tmpResult += iter.substring(0,1).toUpperCase() + iter.substring(1,iter.length()) + separator;
                    }
                    else {
                        tmpResult += iter.substring(0,1).toUpperCase() + separator;
                    }
                }
            }
            result = tmpResult.substring(0, tmpResult.length() - 1);
        }
    }
    return result;
}
 
}
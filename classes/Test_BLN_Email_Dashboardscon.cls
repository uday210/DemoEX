@isTest(SeeAllData=true)

global class Test_BLN_Email_Dashboardscon {

    static testMethod void TestMethod_BLN_Email_Dashboardscon() {

        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        system.runas(U){
            
           // User userInfo1= new User();
            //userInfo1= globalTest.createUserForGNUser();  
              User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
                      

            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);  
              
            BLN_Event__c insertEvent= new BLN_Event__c();
            insertEvent.Name= 'Default Event(Boothleads)';
            insertEvent.Start_Date__c= system.today();
            insertEvent.End_Date__c= system.today()+4; 
            //insertEvent.Start_Time__c= '7:00 AM';
            //insertEvent.End_Time__c= '4:00 PM'; 
            insertEvent.venue_name__c= 'Hyderabad';
            insertEvent.Organizer_Email__c= 'manasatest@gmail.com';
            insertEvent.organizer_id__c= CompanyInfo.id;
            insertEvent.BLN_State__c= Stateinfo.Id;
            insertEvent.BLN_Country__c= countryInfo.Id;
            insert insertEvent; 
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo1.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             // User userForGN= new User();
           // userForGN= globalTest.createUserForGNUser();
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            if(ticket.Tkt_profile__r.Email__c!=null){
             ticket.Tkt_profile__r.Email__c='gn@gnps.com';
             }
            //inserting email template
            EmailTemplate validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'name';
            validEmailTemplate.DeveloperName = 'unique_name_addSomethingSpecialHere';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = UserInfo.getUserId();
            insert validEmailTemplate ;  
            
            // inserting campaign template for order confirmation  
            EmailCampaign__c nwemailcamp1 = new EmailCampaign__c();
            nwemailcamp1.Name = 'Product Intro of Match Leads';
            nwemailcamp1.CampFromEmailId__c =  'vineel.ragula@globalnest.com';
            nwemailcamp1.CampFromName__c = 'VineelR';
            nwemailcamp1.CampEmailTemplate__c = validEmailTemplate.id;
            nwemailcamp1.CampSubject__c = 'Hello';
            nwemailcamp1.CampType__c = 'Announcement';
            nwemailcamp1.Event__c=eventInfo.id;
            nwemailcamp1.Template_Type__c = 'System';
            nwemailcamp1.Template_Status__c = 'Active';
            nwemailcamp1.System_Template_Type__c = 'Order Confirmation';
            nwemailcamp1.Template_Body__c = 'ssssssssssssssssssssssssssssssssssssssss';
            nwemailcamp1.ToList__c = 'SPONSOR';
            nwemailcamp1.auto_schedule_Type__c = 'Days before the event';
            nwemailcamp1.Ext_mail_server_apikey__c='c9c7504e8dedeaa15523bb30ac7046d2-us9';
            nwemailcamp1.Ext_mail_server_CampaignId__c='testid';
            nwemailcamp1.Email_Send_Date__c=system.today();
            nwemailcamp1.Email_Status__c ='Sent';
            insert nwemailcamp1;   
            
            EmailCampaign__c nwemailcamp2 = new EmailCampaign__c();
            nwemailcamp2.Name = 'Product Intro of Lead Retrieval';
            nwemailcamp2.CampFromEmailId__c =  'sai.d@globalnest.com';
            nwemailcamp2.CampFromName__c = 'SaiD';
            nwemailcamp2.CampEmailTemplate__c = validEmailTemplate.id;
            nwemailcamp2.CampSubject__c = 'Hello';
            nwemailcamp2.CampType__c = 'Announcement';
            nwemailcamp2.Event__c=eventInfo.id;
            nwemailcamp2.Template_Type__c = 'System';
            nwemailcamp2.Template_Status__c = 'InActive';
            nwemailcamp2.System_Template_Type__c = 'Order Confirmation';
            nwemailcamp2.Template_Body__c = 'ssssssssssssssssssssssssssssssssssssssss';
            nwemailcamp2.ToList__c = 'SPONSOR';
            nwemailcamp2.auto_schedule_Type__c = 'Days before the event';
            nwemailcamp2.Ext_mail_server_apikey__c='c9c7504e8dedeaa15523bb30ac7046d2-us9';
            nwemailcamp2.Ext_mail_server_CampaignId__c='testid';
            nwemailcamp2.Email_Send_Date__c=system.today();
            nwemailcamp2.Email_Status__c ='Sent';
            insert nwemailcamp2; 
            
            EmailCampaign__c nwemailcamp = new EmailCampaign__c();
            nwemailcamp.Name = 'Test Product Intro of Match Leads';
            nwemailcamp.CampFromEmailId__c =  'deepthi.kollu@globalnest.com';
            nwemailcamp.CampFromName__c = 'DeepthiK';
            nwemailcamp.CampEmailTemplate__c = validEmailTemplate.id;
            nwemailcamp.CampSubject__c = 'Hello';
            nwemailcamp.CampType__c = 'Announcement';
            nwemailcamp.Event__c=eventInfo.id;
            nwemailcamp.Template_Type__c = 'Custom';
            nwemailcamp.Template_Status__c = 'Active';
            nwemailcamp.System_Template_Type__c = 'Order Confirmation';
            nwemailcamp.Template_Body__c = 'ssssssssssssssssssssssssssssssssssssssss';
            nwemailcamp.ToList__c = 'SPONSOR';
            nwemailcamp.auto_schedule_Type__c = 'Days before the event';
            nwemailcamp.Ext_mail_server_apikey__c='c9c7504e8dedeaa15523bb30ac7046d2-us9';
            nwemailcamp.Ext_mail_server_CampaignId__c='testid';
            nwemailcamp.Email_Send_Date__c=system.today();
            nwemailcamp.Email_Status__c ='Sent';
            insert nwemailcamp; 
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            // calling all static methods    
            BLN_Email_Dashboardscon.getemailtempoptions(validEmailTemplate.id);
           // BLN_Email_Dashboardscon.gettempactive(eventInfo.id);
            BLN_Email_Dashboardscon.getemailtempoptionsforstand(nwemailcamp1.id);
            BLN_Email_Dashboardscon.createemailtempoptions('tempname','html','campsubj',eventInfo.id);
            BLN_Email_Dashboardscon.createemailtempoptionsforstand('tempnames','htmls','campsubjs',eventInfo.id);
            
        
            try{
                BLN_Email_Dashboardscon.verifyemailwithMC('69b275318dbc3fb10d6beaf18c8f31e3-us9');
             }catch(Exception e){}
            
            BLN_Email_Dashboardscon obj = new BLN_Email_Dashboardscon();
            obj.displaybtn=true;
            obj.myticket= new BLN_UtillDisplayLinks();
            obj.sentstatus= true;
            obj.radiochecked='test';
            obj.GNUSERS=new LIST<GN_User__c>();
            obj.emailcampslist= new List<EmailCampaign__c>();
            obj.lc= new List<EmailCampaign__c>();
            obj.teststr='test';
            
            obj.MCApiKeyInputVal='test';
            obj.pimlstat='test';
            obj.pilrstat='test';
            obj.lrsrstat='test';
            obj.SelectedApiKey ='test';
            obj.selectedCampId='test';
            obj.pimldat=null;
            obj.pilrdat=null;
            obj.lrsrdat=null;
            obj.mbsrdat=null;
            obj.uniqueApiKeyRecords=new List<selectOption>();
            obj.uniqueApiKeys=new Map<String,EmailCampaign__c>();
            
             obj.displayerror1='test';
            obj.ListIdsAndNames=new List<selectOption>();
            //obj.alllists=new List<Data>();
            
            Apexpages.Currentpage().getparameters().put('apikeyString','test');
            obj.ImportMcList();
            
            
            obj.MCListId='test';
            obj.MCSegmentId='test';
            obj.SegmentIdsAndNames=new List<selectOption>();
            obj.selectedRadio ='test';
            obj.schetime='test';
            obj.radiooptions =new list<selectoption>();
            obj.mbsrstat='test';
            obj.SegmentId='test';
            
            obj.alllists=new List<BLN_Email_Dashboardscon.Data>();
           obj.templateId='test';
            obj.emailcamp=new EmailCampaign__c();  
            obj.McTempId='test';  
            //public string McTempId{get;set;}              
            
            
            /*
            DateTime dt = DateTime.now();
            String formattedDt = dt.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
            
            */
            
           
            
            
            BLN_Email_Dashboardscon bed = new BLN_Email_Dashboardscon();
            LIST<ticket__c> ticlst=new list<ticket__c>();
           /* try{
             ticket.Tkt_profile__r.Email__c='gn@gn.com';
             }catch(Exception e){}
            ticlst.add(ticket);
            bed.Ticket1=ticlst;
           */ 
            //ticlst.add(ticket);
            //bed.Ticket1=ticlst;
            try{
           bed.Ticket1.add(ticket);
           }catch(Exception e){}
            bed.selectedeventid=eventinfo.id;
            
            BLN_Email_Dashboardscon.emailauthentication blnobj = new  BLN_Email_Dashboardscon.emailauthentication();
            blnobj.verifyactivation='test';
            blnobj.fromemailcheck='test2';
           
            /* 
              global class emailauthentication{ 
   public string verifyactivation{get;set;}
   public string fromemailcheck{get;set;}
   
   }
            */
            
            
            Test.startTest();
           if(Test.isRunningTest()){
                bed.ImportMcList();
                bed.SaveMCAPIKey();
                bed.campaignId = nwemailcamp1.id; 
                bed.SaveMCAPIKey();
                bed.itype='Attendee,';
                bed.getEmails();
                Apexpages.Currentpage().getparameters().put('campaignid',nwemailcamp1.id);
                
                try{
                    bed.resend();
                }catch(exception e){}
                Apexpages.Currentpage().getparameters().put('templateid',validEmailTemplate.id);
                Apexpages.Currentpage().getparameters().put('tempbody',nwemailcamp1.Template_Body__c);
                Apexpages.Currentpage().getparameters().put('emailsubject',nwemailcamp1.CampSubject__c);
                bed.syscusttemplateoverwrite();
                
                Apexpages.Currentpage().getparameters().put('templateid',nwemailcamp1.id);
                Apexpages.Currentpage().getparameters().put('selectedtemp',validEmailTemplate.id);
                bed.templateactivefun();
                
                Apexpages.Currentpage().getparameters().put('campid',nwemailcamp1.id);
                Apexpages.Currentpage().getparameters().put('tempbody',nwemailcamp1.Template_Body__c);
                Apexpages.Currentpage().getparameters().put('emailsubject',nwemailcamp1.CampSubject__c);
                bed.syscustcamptemplateoverwrite();
                
                bed.eventdetails();
                try{
                    bed.CampaignReport();
                }catch(exception e1){}
                
                
                DateTime dt1 = DateTime.now();
                String formattedDt1 = dt1.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
                Apexpages.Currentpage().getparameters().put('scheduledate',formattedDt1);
                Apexpages.Currentpage().getparameters().put('daysbeforedd','10');
                try{
                    bed.autoschedule();
                }catch(exception e2){}
                
                 //DateTime dt2 = DateTime.now();
               // String formattedDt2 = dt2.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
                Apexpages.Currentpage().getparameters().put('scheduledate','');
                Apexpages.Currentpage().getparameters().put('daysbeforedd','10');
                try{
                    bed.autoschedule();
                }catch(exception en1){}
                try{
                    bed.campaignSend();
                }catch(exception e3){}
                
                
                bed.displayerror='test';
                Apexpages.Currentpage().getparameters().put('campaignid',nwemailcamp1.id);
                bed.SaveMCAPIKey();
                
                Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                Apexpages.Currentpage().getparameters().put('segid','testseg');
                
                try{              
                    
                    //tc.Tkt_profile__r.Email__c!=null && tc.Tkt_profile__r.Email__c!=''
                    bed.Ticket1.add(ticket);
                    bed.listsubscribe();
                }catch(exception e4){}
                try{
                    bed.segementMemebersAdd();
                }catch(exception e5){}
                

                string mcapikey = Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                string mclistid = Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                // bed.ImportMcListSegments();
                 
                 
                 
                 
                 
                Apexpages.Currentpage().getparameters().put('campaignid',nwemailcamp1.id);
                bed.deleteremcamp();
                
                
                BLN_Email_Dashboardscon.Data blnemaildash = new BLN_Email_Dashboardscon.Data(12,'stp3','stp4',True,False,'stp7','stp8','stp9','stp10',13,'stp12','stp13','stp14','stp15',Null,Null);
                BLN_Email_Dashboardscon.StaticSegments blnemstat = new BLN_Email_Dashboardscon.StaticSegments('stat1','stat2','stat3','stat4','stat5');
               
                blnemaildash.Id='test';
                
                 
                Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                Apexpages.Currentpage().getparameters().put('segName','testseg');
                try { 
                bed.creatingSegment();
                } catch(exception eex) {}
                
                
                Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                Apexpages.Currentpage().getparameters().put('templatename','testtemplate'); 
                Apexpages.Currentpage().getparameters().put('htmltemplate','htmltemplate');
                try{
                bed.emailTemplateAdd();
                } catch(exception esc) {}
                
                Apexpages.Currentpage().getparameters().put('campaignid',nwemailcamp1.id);
                Apexpages.Currentpage().getparameters().put('toemail','vineel.ragula@globalnest.com');
                
                JSONGenerator gn = JSON.createGenerator(true);
                    gn.writeStartObject();
                    gn.writeStringField('apikey',nwemailcamp1.Ext_mail_server_apikey__c);
                    gn.writeStringField('cid',nwemailcamp1.id);
                    gn.writeFieldName('test_emails');
                    gn.writeStartArray();
                    gn.writeString('vineel.ragula@globalnest.com');
                    gn.writeEndArray();
                    gn.writeEndObject();
                    
                     //E = [SELECT Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: campaignId  ];

                try {
                
                    bed.sendtestemail();
                } catch(exception ess) {}
                
                BLN_Email_Dashboardscon.Stats emstat = new BLN_Email_Dashboardscon.Stats();
                emstat.member_count = 12;
                emstat.unsubscribe_count = 13;
                emstat.cleaned_count = 14; 
                emstat.member_count_since_send = 15; 
                emstat.unsubscribe_count_since_send = 16; 
                emstat.cleaned_count_since_send = 17; 
                emstat.campaign_count = 18;
                emstat.grouping_count = 19;
                emstat.group_count = 20; 
                emstat.merge_var_count = 21; 
                emstat.avg_sub_rate = 22; 
                emstat.avg_unsub_rate = 23; 
                emstat.target_sub_rate = 24; 
                emstat.click_rate = 0.2; 
                emstat.date_last_campaign = 'stats';
                
                Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                try { 
                    bed.ImportMcListSegments();
                } catch(exception ess) {}
                
                Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                Apexpages.Currentpage().getparameters().put('segid','testseg');
                Apexpages.Currentpage().getparameters().put('templatename','testtemplate');
                Apexpages.Currentpage().getparameters().put('htmltemplate','htmltemplate');    
                Apexpages.Currentpage().getparameters().put('frmname','Vineel');
                Apexpages.Currentpage().getparameters().put('emailsub',nwemailcamp1.CampSubject__c);
                Apexpages.Currentpage().getparameters().put('fromemail','deepthi@globalnest.com');
                Apexpages.Currentpage().getparameters().put('campname',nwemailcamp.Name);
                Apexpages.Currentpage().getparameters().put('camptype',nwemailcamp.CampType__c);
                Apexpages.Currentpage().getparameters().put('sftemplateid','sftempid');
                try{
                bed.createCampaignInMC();
                bed.createCampaignInMCstandard();
                }catch(exception ees){}
                
                
                
                Apexpages.Currentpage().getparameters().put('apikeyString',nwemailcamp1.Ext_mail_server_apikey__c);
                Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                Apexpages.Currentpage().getparameters().put('segid','testseg');
                Apexpages.Currentpage().getparameters().put('templatename','testtemplate');
                Apexpages.Currentpage().getparameters().put('htmltemplate','htmltemplate');    
                Apexpages.Currentpage().getparameters().put('frmname','Vineel');
                Apexpages.Currentpage().getparameters().put('emailsub',nwemailcamp1.CampSubject__c);
                Apexpages.Currentpage().getparameters().put('fromemail','deepthi@globalnest.com');
                Apexpages.Currentpage().getparameters().put('campname',nwemailcamp.Name);
                Apexpages.Currentpage().getparameters().put('camptype',nwemailcamp.CampType__c);
                Apexpages.Currentpage().getparameters().put('sftemplateid','sftempid');
                
                try{
                bed.createCampaignInMCstandard();
                }catch(exception ees){}
                
                
                Apexpages.Currentpage().getparameters().put('listid','7d410a2ae1');
                Apexpages.Currentpage().getparameters().put('segid','testseg');
                Apexpages.Currentpage().getparameters().put('templatename','testtemplate');
                Apexpages.Currentpage().getparameters().put('htmltemplate','htmltemplate');    
                Apexpages.Currentpage().getparameters().put('frmname','Vineel');
                Apexpages.Currentpage().getparameters().put('emailsub',nwemailcamp1.CampSubject__c);
                Apexpages.Currentpage().getparameters().put('fromemail','deepthi@globalnest.com');
               // Apexpages.Currentpage().getparameters().put('scheduledate','scheduleddt');
                //Apexpages.Currentpage().getparameters().put('daysbeforedd','daysbfedd');
                 DateTime dt = DateTime.now();
                String formattedDt = dt.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
                Apexpages.Currentpage().getparameters().put('scheduledate',formattedDt);
                Apexpages.Currentpage().getparameters().put('daysbeforedd','10');
                Apexpages.Currentpage().getparameters().put('campname',nwemailcamp.Name);
                Apexpages.Currentpage().getparameters().put('camptype',nwemailcamp.CampType__c);
                Apexpages.Currentpage().getparameters().put('sftemplateid','sftempid');
                
                try{
                bed.createCampaignInMCstandardSched();
                }catch(exception ees){}
                
            }
            Test.stopTest();  
        }
    }  
}
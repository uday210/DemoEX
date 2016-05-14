@isTest(seeAllData=true)
public class Test_BLN_AttendeesController{

  string fullUrl =  Site.getBaseUrl();
   
    
    static testmethod void Testmethod_BLN_AttendeesController(){
       
    
    //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
     //   U= globalTest.createUser();        
        
            Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

            User u = new User(alias = 'Test', email='testcode1235689@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1235689@noemail.com');
            Database.insert(u);
        
        
        
            system.runas(U){
            
                    
            
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
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            eventInfo.Time_Zone__c='America/New_York';
            update(eventInfo);
            
            BLN_BadgeTemplate_Styles__c badTStyleInfo=new BLN_BadgeTemplate_Styles__c();
            badTStyleInfo=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            Reg_Setting__c regSettingsInfo4= new Reg_Setting__c();
            regSettingsInfo4= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            list<Reg_Setting__c> regsettinginfo3 = new list<Reg_Setting__c>();
            regsettinginfo3.add(regSettingsInfo1);
            
            
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
           // Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
                
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            Ticket__c insertTicket  = [select id,Name,Badge_Label__c,Tag_No__c,tkt_profile__r.BLN_GN_User__c,Item__c,Event__c
                                       from Ticket__c where id =:ticket.id];
                
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
             Item_Type__c insertItemType= new Item_Type__c();
             insertItemType.Name= 'Admissions';
            insertItemType.Badge_Label__c= 'BadgeLabel';
            insertItemType.Order__c= 22.12;
            insertItemType.Add_On__c= TRUE;
            insertItemType.Unlimited__c=false;
        
            insert insertItemType;
        
                
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
                       
            
            
            
            BLN_BadgeTemplate_Styles__c badTempStyl=new BLN_BadgeTemplate_Styles__c ();
            badTempStyl=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Badge__c bdg= new Badge__c();
            bdg=globalTest.createBadge(insertTicket.id);
            
            
                
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool2.Id, item.Id, companyInfo.Id, NULL, 'Regular', 'AS_Last_Name__c');
            
            Role__c BLNRole = new Role__c();
            BLNRole.Role_type__c = 'BoothLeads';
            BLNRole.Name = 'Event Admin';
            Insert BLNRole;    
                
            PageReference pageRef = Page.BLN_Mytickets;
            Test.setCurrentPage(pageRef);
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_BadgeTemplate_Styles__c bt= new BLN_BadgeTemplate_Styles__c(Name='Custom1',Event__c =eventInfo.id,
            FirstRowElement__c='[{"id":"badgeLogo","height":64,"width":121,"positionTop":5,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(fullUrl/resource/1415706031000/qrcodelogoimage)","urlResult":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCABAAHoDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCOiiiu45x6xOwyBxTvIf2/Opf+Xf8A4DVbJ9TSGSeQ/t+dHkP7fnUeT6mjJ9TQIk8h/b86PIf2/Oo8n1NGT6mgCTyH9vzo8h/b86j3H1NKqu33cmgB/kP7fnR5D+350xg6/eyKTJ9TQA8wuBnGfpUdWrf/AFf41VPWhAFTL90fSoamX7o+lTIaIaKKKsRa/wCXf/gNVatqN0AHqKj/AHUX+01ShjEhZ/Yepp/lwj5S3PrUbys/HQegplMRI8LLyOR7VHT0lZOhyPSpMxy9flagCCpI5igxgEUpgcHAwR60vlxx8yNk+lADJJTIMEYFMqfZHIPkO0+lRPGydR+NCAsW/wDq/wAaqnrVm3/1f41WPWhDCpl+6PpUNTL90fSpkCIaKKKsRa/5d/8AgNValWYhdpUEUean/PIUhkVFS+an/PIUean/ADyFAiKipfNT/nkKPNT/AJ5CgBgkcDAY4ptS+an/ADyFHmp/zyFAEVSpORw3zCjzU/55CjzU/wCeQoAnj2lcp0qmetTefgYVAKhoQwqZfuj6VDUy/dH0qZAi1tX0H5U9LfchfCqgONzUmD6GpElZY/LZA6Zzhs8H8KQxptyCoVVfd02c0n2eTcF8lsnkDbUq3DKfljRV2lSoB5B9T1pVuZEUKiKqgHgA96WoEX2WX/ng/wD3xSLbyMoZYWIPQhetSJPInlYUfujleKebnMcQ8oFo88nPc59aLsCBbd3GVhYj2WhbaRgCsLEHoQvWrC3sqsG2IWBznB/pTDcSb4mCgeUcqMHHXNF2BD5LZA8s5boNvWljgMhYKo+VSxz6CpxcsICgB3kk7iPu564qKGRoWYhQ25SpBz0ouwI1j3nCJuPoBmnfZ33BfJbce22pFmKbgsSAMMMOeR+dPS6IGxox5eCNozRdgQG3kBAMLZboNvWkeEpjfGVz0yMVaa6wqLFGAqqVIOeQev8AnNQvKzxrGECopzgZ6/jRdgQ7V9B+VGB6ClwfSilIaP/Z"}]',SecondElement__c='[{"id":"badgeTicket","height":40,"width":210,"line-height":40,"position":"absolute","positionTop":25,"positionLeft":130,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"20px","fontFamily":"Times New Roman","textTransform":"none","contentText":"Full Conference","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]',ThirdElement__c='[{"id":"badgeFullName","height":36,"width":352,"line-height":36,"position":"absolute","positionTop":75,"positionLeft":5,"marginTop":"10px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"34px","fontFamily":"Times New Roman","textTransform":"uppercase","contentText":"JANE DOE","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]',FourthElement__c='[{"id":"badgeJobTitle","height":30,"width":352,"line-height":30,"position":"absolute","positionTop":120,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"20px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"28px","fontFamily":"Times New Roman","textTransform":"none","contentText":"Managing Partner","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]',FifthElement__c='[{"id":"badgeQrCode","height":125,"width":125,"positionTop":160,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(fullUrl+/resource/1415706031000/qrcodelogoimage)"}]',SixthElement__c='[{"id":"badgeCompanyName","height":28,"width":210,"line-height":28,"position":"absolute","positionTop":190,"positionLeft":135,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"24px","fontFamily":"Times New Roman","textTransform":"none","contentText":"Acme Corp","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]',BadgeName__c='{"name":"BL-Template-4","width":360,"height":288,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAEqAXIDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCzlUjBI7Cm+dH6H8qJf9QPwqvTSEWPOj9D+VHnR+h/Kq9OwBTsFybzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKOKLBcn86P0P5UedH6H8qg4o4osFyfzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKCKLAT+dH6H8qUSoTjH6VWpyffH1osFy3gegowPQUtFSMTA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUY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"},');
            insert bt;
            
            ApexPages.currentPage().getParaMeters().put('ticketid',insertTicket.Name);
            ApexPages.currentPage().getParaMeters().put('label',insertTicket.Badge_Label__c);
            
            Apexpages.currentPage().getParameters().put('TicketIdparam',insertTicket.Id);
            Apexpages.currentPage().getParameters().put('bl1',insertTicket.Badge_Label__c);
            Apexpages.currentPage().getParameters().put('rowID1',insertTicket.Name);
            Apexpages.currentPage().getParameters().put('rowID2',insertTicket.Name); 
            Apexpages.currentPage().getParameters().put('sn1',insertTicket.Tag_No__c);
            Apexpages.currentPage().getParameters().put('rowID3',insertTicket.Name); 
            Apexpages.currentPage().getParameters().put('bs1','Not Printed');
            Apexpages.currentPage().getParameters().put('ticketName',insertTicket.Name);
            Apexpages.currentPage().getParameters().put('ticketid_list',insertTicket.Name);
            Apexpages.currentPage().getParameters().put('ticketid_list22',insertTicket.Name);
            Apexpages.currentPage().getParameters().put('ticketid_list33',insertTicket.Name);
            Apexpages.currentPage().getParameters().put('naicsCodes',naicsCodeInfo1.id+'-'+naicsCodeInfo1.id+'-'+naicsCodeInfo1.id);                                                                
            Apexpages.currentPage().getParameters().put('ticketid1',insertTicket.Name);   
            Apexpages.currentPage().getParameters().put('newbstate','Not Printed');                                                                
            Apexpages.currentPage().getParameters().put('ticketid_list44',insertTicket.Name); 
            Apexpages.currentPage().getParameters().put('ticketid_list11',insertTicket.Name); 
            //Apexpages.currentPage().getParameters().put('email_list','test@test1.com,test@test2.com');
            Apexpages.currentPage().getParameters().put('email_list',' ,');
            
            Apexpages.currentPage().getParameters().put('restoftheticket',insertTicket.id);                                                              
            Apexpages.currentPage().getParameters().put('parentticket',ticket1.id);
                                                                            
            Apexpages.Currentpage().getparameters().put('assignBadgeTemp','Attendee');
            Apexpages.Currentpage().getparameters().put('seatIDAssign','123');
            Apexpages.currentPage().getParameters().put('newbadge','Attendee');
            Apexpages.currentPage().getParameters().put('ticketid1',insertTicket.Name);
            
            ApexPages.currentPage().getParameters().put('search[value]', 'yut yt');
            
                                                                            
             BLN_AttendeesController attCon=new BLN_AttendeesController();
             
              attcon.convertBadgeState();
              
              //MY CODE START
               //varialbes assignemt
               
               
               //static variables
               BLN_AttendeesController.BadgeAlltkt= new List<Ticket__c>();
               //normal variables
              attCon.tagName = 'test';
              attCon.pCompName= 'test';
              attCon.myticket = new BLN_UtillDisplayLinks();
              attCon.Z= 5;
              attCon.se= new BLN_Event__c();
              attCon.blnMyticketsBal= new BLN_Mytickets_BAL();
              attCon.checkinHistoryList= new List<Tstatus__c>();
              attCon.ListOfListAttendees=new LIst<List<BLN_Attendees_BAL.inncls>>();            
              
              attCon.unheckedids= 'test';
              
              attCon.statusId= new SET<Id>();
              attCon.rgListTemp= new List<Reg_Setting__c>();
              attCon.attendeeSettingList= new List<Reg_Setting__c>();
              attCon.btstyle= new BLN_Badge_Style__c();
              attCon.bdLayers= new List<BLN_Badge_Layer__c>();
              attCon.bg= new BLN_AttendeesController.Badge('test','test','test');
              attCon.elems= new List<BLN_AttendeesController.Style>();
              attCon.unheckedids= 'test';
              
              
              attCon.evlogo= new Bln_Event__c();
              // attCon.btstyle= new BLN_Badge_Style__c();
             // attCon.btstyle= new BLN_Badge_Style__c();
              BLN_AttendeesController.MergeTicket blnattndecontrl = new BLN_AttendeesController.MergeTicket();
              blnattndecontrl.TicketId='test1';
              blnattndecontrl.TicketName='test2';
              blnattndecontrl.AttendeeName='test3';
              
              //attCon.AttendeeName='test4';
              attCon.selected_ticNameTemp1=new list<string>();
              
              attCon.selected_ticlistTemp22=new list<string>();
              attCon.selected_ticlistTemp33=new list<string>(); 
              attCon.selectedmergebadgelabel='test3';
              attCon.mergeticketlist=new list<selectoption >(); 
              
              
              attCon.companyName ='test4';
              attCon.compext =new Company_Ext__c();
              attCon.settingsForbuyerMAp=new MAP<id,List<Reg_Setting__c>>();
              attCon.settingsForbuyer=new  List<Reg_Setting__c>();
              attCon.ucrole=new  UC_Role__c();
              attCon.ticketLevelQuestions =new  List<BLN_AttendeesController.surveyCls>();
              attCon.eventLevelQuestions =new  List<BLN_AttendeesController.surveyCls>();
                 
                       
    
              
            
              
             
                
              BLN_AttendeesController.packagebreak blnpkgbrk= new BLN_AttendeesController.packagebreak();
              blnpkgbrk.Ticket= 'test';
              blnpkgbrk.TicketId= 'test';
              blnpkgbrk.TicketBadgelabel= 'test';
              blnpkgbrk.TicketGnuserName= 'test';
              blnpkgbrk.LineItems=new list<string>();
              blnpkgbrk.LineItemsId=new list<string>();
              
             
              
             // BLN_AttendeesController.surveyCls blnsurvcls= new BLN_AttendeesController.surveyCls();
             // BLN_AttendeesController.surveyCls.question
              //blnsurvcls.question=new Item_Question__c();
             // blnsurvcls.answers=new List<user_Answer__c>();
              BLN_AttendeesController.surveyCls blnsurvcls2= new BLN_AttendeesController.surveyCls(new Item_Question__c(),new List<user_Answer__c>());
              ID blnid=ticket1.id;
              Ticket__c blnsobj=null;
              // BLN_AttendeesController.SubWrapper  blnsubwrpr= new BLN_AttendeesController.SubWrapper( ticket1,blnid);
              //method calling
               List<String> lststng = new List<String>();
               lststng.add('test');
               lststng.add('test1');
               lststng.add('test2');
               lststng.add(ticket.id);
                lststng.add(ticket1.Id);
                
               List<String> lststng1 = new List<String>();
               lststng.add('test');
               lststng.add('test1');
               lststng.add('test2');
              
              BLN_AttendeesController.filterclass ff=new BLN_AttendeesController.filterclass(null,null);
              //static methods
                BLN_AttendeesController.getTicketTypesForFilter(eventInfo.Id);
                BLN_AttendeesController.getFilterTags(eventInfo.Id);
                BLN_AttendeesController.getNotprintedcount(ticket1.Id);
                BLN_AttendeesController.getBadgecreatedornot(ticket1.Id);
                BLN_AttendeesController.genpdf(lststng);
                BLN_AttendeesController.genpdf(lststng1);
             //   BLN_AttendeesController.getAttendeeData('test',new List<String>());
                
                
              
              
              //Normal methods
              
              attcon.selected_ticlistTemp44 = new List<String>(lststng);
               attCon.assignRole();
              attCon.assignTagActionFunction();
              attCon.assigningTagOptions();
              attCon.selected_ticlist();
              attCon.getSroles();
              
              Apexpages.currentPage().getParameters().put('tagarray','mylist');
              attCon.assignTag();
              attCon.CloseGuests();
              attCon.createBadgeLabel();
              attCon.createSeatNumber();
              attCon.changeBadgeStatus();
              attCon.displayPermissions();
              attCon.attSetSetUpForReports();
              attCon.regForReport();
              
              
              try{
              attCon.updateExistingBadgenotprinted(); 
              }catch(Exception e){}
              
                        
                    
              
               attCon.closeGuest();
               attCon.assigningSeatNumber();
               attCon.assigningbadgelabel();
               attCon.update_mergelabels();
                  
               BLN_AttendeesController.SubWrapper blnattndrendata = new BLN_AttendeesController.SubWrapper(ticket,ticket.id,'ItemType');
               BLN_AttendeesController.DataTableWrapper blndatatablwrper= new BLN_AttendeesController.DataTableWrapper(4,10,5,new List<BLN_AttendeesController.SubWrapper>());
               blndatatablwrper.selected=true;
       
              
              //MY CODE END
              
              
       /*       BLN_AttendeesController.getLayoutDataForSize(4,3,'8.5\" x 11\"');
              BLN_AttendeesController.getLayoutDataForSize(8.5,11,'8.5\" x 11\"');
               BLN_AttendeesController.getLayoutDataForSize(3.4,2.3,'8.5\" x 11\"');
               BLN_AttendeesController.getLayoutDataForSize(3.9,2.4,'8.5\" x 11\"');
               BLN_AttendeesController.getLayoutDataForSize(3.5,2.25,'8.5\" x 11\"');
               BLN_AttendeesController.getLayoutDataForSize(3.4,2.1,'8.5\" x 11\"');
               BLN_AttendeesController.getLayoutDataForSize(1.1,2.1,'8.5\" x 11\"');
               
               BLN_AttendeesController.openPDF('test');*/
               /*  
               List<String> lststng = new List<String>();
               lststng.add('test');
               lststng.add('test1');
               lststng.add('test2');
               * /              
               BLN_AttendeesController.getAttendeeData('test',lststng);             
              

               BLN_AttendeesController.RenderData blnattndrend = new   BLN_AttendeesController.RenderData('test',BLN_AttendeesController.getLayoutDataForSize(3.5,2.25,'8.5\" x 11\"'),null); 
                   
              
             //attCon.mapticWithId  = new MAP<id,ticket__c>(); 
             //attCon.mapticWithId.put(insertTicket.id,insertTicket); // Map tickets with its id  
 
             //attCon.mapguIdWithGNU = new MAP<id,GN_User__c>();
             //attCon.mapguIdWithGNU.put(gnUser.Id,gnUser); 
             
            /* List<BLN_Attendees_BAL.inncls>  attendeeList = new List<BLN_Attendees_BAL.inncls>();
             BLN_Attendees_BAL.inncls tcin=new BLN_Attendees_BAL.inncls(insertTicket);
             tcin.selectCheckBox=true;
             attendeeList.add(tcin);
             BLN_AttendeesController.openPDF('test');
             */             
              
             try{
                   //  BLN_AttendeesController.getRenderData('test','test','test');  
                 }catch(Exception e){}  
                 
                 ApexPages.currentPage().getParameters().put('length','12');
                 ApexPages.currentPage().getParameters().put('columns[6][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[7][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[8][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[12][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[13][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[15][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 
                 try{
                     attcon.processData(); 
                 }catch(Exception e){}   
                 
                 ApexPages.currentPage().getParameters().put('search[value]', 'yut  yt dsf');
                  ApexPages.currentPage().getParameters().put('columns[6][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                  ApexPages.currentPage().getParameters().put('columns[7][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[8][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[12][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[13][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 ApexPages.currentPage().getParameters().put('columns[15][search][value]','|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\|asdasd^(sds)$asads\\');
                 
                 try{
             attcon.processData();
                 }catch(Exception e){}   
                 
                          
             //attcon.processData();
             attcon.dataTableJson = 'test';    
              try{
                    Apexpages.currentPage().getParameters().put('allpages','false');
                    Apexpages.currentPage().getParameters().put('unckedlist','myList');
             attcon.update_seatNos();
             attcon.update_badgelabels();
             Apexpages.currentPage().getParameters().put('allpages','true');
                    Apexpages.currentPage().getParameters().put('unckedlist','myList');
                    attcon.update_badgelabels();
                 }catch(Exception e){}    
                 try{
                      attCon.Allids.add(ticket1.Id);
                      attCon.Allids.add(ticket1.Id);
                      attCon.Allids.add(ticket1.Id);
                      attCon.Allids.add(ticket1.Id);
                    Apexpages.currentPage().getParameters().put('allpages','true');
                    Apexpages.currentPage().getParameters().put('unckedlist','myList');
                     attcon.update_seatNos(); 
                 }catch(Exception e){}  
                 try{
                      
                    Apexpages.currentPage().getParameters().put('allpages','false');
                    Apexpages.currentPage().getParameters().put('unckedlist','myList');
                  attcon.update_badgelabels();
                 }catch(Exception e){} 
             //attcon.update_seatNos();
             test.startTest();  
             
             
             
             
            /* attcon.update_badgelabels();
             attcon.update_mergelabels();
             attcon.convertBadgeState();
             attcon.assigningSeatNumber();
             attcon.assigningbadgelabel();
             attcon.closeGuest();
             attcon.companyName = 'test';
             attcon.updateExistingBadgenotprinted();
             attcon.selected_ticlist();
             attcon.assignRole();
             attCon.getSroles();
             //attCon.ListOfListAttendees = new LIst<List<BLN_Attendees_BAL.inncls>>();
             //attCon.ListOfListAttendees.add(attendeeList);
             attCon.selected_ticlistTemp44 = new List<string>();
             attCon.selected_ticlistTemp44.add(insertTicket.Name);
             attCon.assignTag();
             attCon.assignTagActionFunction();                                                               
             attcon.CloseGuests();
             //attCon.checkinHistory();                                                                            
             attCon.createBadgeLabel();
             attCon.createSeatNumber();
             attCon.changeBadgeStatus();
             test.startTest();  
             attCon.displayPermissions();
             attCon.attSetSetUpForReports();                                                               
             attCon.regForReport(); */
             //attCon.cancelHistoryDetail();            
             //attCon.mainMethod();                                                               
             //attCon.SaveGuests();
             //attCon.allBuyers(); 
             //attCon.orderDetails();
             //attCon.cancelOrdDetailatt();
             attCon.parseBadge('{"name":"BL-Template-4","width":360,"height":288,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAEqAXIDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCzlUjBI7Cm+dH6H8qJf9QPwqvTSEWPOj9D+VHnR+h/Kq9OwBTsFybzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKOKLBcn86P0P5UedH6H8qg4o4osFyfzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKCKLAT+dH6H8qUSoTjH6VWpyffH1osFy3gegowPQUtFSMTA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUY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"}');//debug required
            
            
            BLN_AttendeesController.Style sClass=new BLN_AttendeesController.Style(eventInfo.id,'4.2','2.9','6.9','2.3','7.2','3.4',
                                                            '8.2','4.2','9.1','4.3','6.3','9.2',
                                                            'left','12','arial','adhoc','update',
                                                            'blue','fine','red','web','website');
             
            attCon.parseElement('{"name":"BL-Template-4","width":360,"height":288,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAEqAXIDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCzlUjBI7Cm+dH6H8qJf9QPwqvTSEWPOj9D+VHnR+h/Kq9OwBTsFybzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKOKLBcn86P0P5UedH6H8qg4o4osFyfzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKCKLAT+dH6H8qUSoTjH6VWpyffH1osFy3gegowPQUtFSMTA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUY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"}');//debug required
           
            BLN_AttendeesController.Badge bdgClass=new BLN_AttendeesController.Badge('200','100','Yellow');
             attCon.printingbadge();
             //attCon.updateExistingBadgenotprinted();
            attCon.selectedbdtemname='Custom1';
             attCon.selectedprinter='Avery_6'; 
             //attCon.genpdf(); 
             attCon.selectedprinter='Avery_8';
             //attCon.genpdf(); 
             attCon.selectedprinter='Zebra';
             //attCon.genpdf(); 
             attCon.selectedprinter='Brother';
            // attCon.genpdf(); 
             attCon.selectedprinter ='Avery_6';                                                               
             attCon.findtemplate();
             attCon.selectedprinter='Avery_8';
             attCon.findtemplate();
             attCon.selectedprinter='Zebra';                                                               
            attCon.findtemplate();
            attCon.getPrinterlist();
             try{
             attCon.getTicketToMergeList();
             }catch(exception eee){}
            attCon.selectedtickets=insertTicket.id;
             attCon.mergeBadge();
             attCon.getMergeList();
            attCon.selectedunmergetickets=insertTicket.id;
            attCon.cancelBadge();
            attCon.getPackageList();                                                                       
             attCon.selectedpackagetickets = item.id;                                                              
             attCon.getPackageListContent();
             attCon.ticketpoolid =  insertTicket.id+','+insertTicket.id;                                                              
             try {attCon.previewpackage(); } catch (exception e) {}
            attCon.splitpackage();
            Apexpages.currentPage().getParameters().put('allitemid','myList');
            attCon.MergeItemSaves();
            attCon.AssignRoleToAttendee();
            attCon.getItemList();
            
            Apexpages.currentPage().getParameters().put('search','tp h');
            Apexpages.currentPage().getParameters().put('arrVar',ticket.id);
            Apexpages.currentPage().getParameters().put('ttypefilter','myList');
            Apexpages.currentPage().getParameters().put('tnamefilter','myList');
            Apexpages.currentPage().getParameters().put('blabelfilter','myList');
            Apexpages.currentPage().getParameters().put('bstatusfilter','myList');
            Apexpages.currentPage().getParameters().put('cstatusfilter','myList'); 
            
            attCon.userSelectAttendeesToExport();
            attCon.exportSelectedTicketBatch();
            
             BLN_Reg_Settings_DAO   regsetdao = new BLN_Reg_Settings_DAO();
                                                                            
             List<Reg_Setting__c> reglst = new List<Reg_Setting__c>();
             reglst.add(regSettingsInfo1);
             regsetdao.deleteRegset(reglst);
             regsetdao.insRegset(reglst);             
             regsetdao.updateSet(reglst);
             regsetdao.getregsetlist('eventInfo.Id');
             List<id> lsd = new List<id>();
             lsd.add(ItemPool.Id);
             regsetdao.itemSettings(lsd); 
             regsetdao.setsResitem('regset1','regset2'); 
             regsetdao.setsResevent('regset3','regset4');
            
             set<id> setid = new set<id>();
             setid.add(ItemPool.Id);   
     
             regsetdao.bookedRegSettingList(setid,'eventInfo.Id');
             test.stopTest();
            //attCon.deleteAttendee();
        }       
    
    }
}
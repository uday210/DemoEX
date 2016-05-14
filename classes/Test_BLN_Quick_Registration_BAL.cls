@isTest(SeeAllData=true)
public class Test_BLN_Quick_Registration_BAL{
    public static testmethod void Testmethod_BLN_Quick_Registration_Con(){
        globalForTestClass    globalTest= new globalForTestClass();
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
        // ------------------ Eventadmin Insert ---------------------
        
        User u = new User(alias = 'Test', email='testcode@noemail.com',
                          emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                          localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                          timezonesidkey='America/Los_Angeles', username='testcode@noemail.com');
        database.insert(u,false);
        
        
        system.runas(u){
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            GN_User__c  userForGN = new GN_User__c();
            userForGN = globalTest.createGNUser(u, countryInfo.Id, stateInfo.Id);
            
            User userForGNC= new User();
            userForGNC= globalTest.createUserForGNUser();

            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            NAICS_Code__c nacc=  new  NAICS_Code__c();
            nacc.Name='111110';
            nacc.Description__c='Soybean Farming';
            insert nacc;
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company__c companyInfo1= new Company__c();
            companyInfo1= globalTest.createCompany(userForGNC.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id,countryInfo.Id, stateInfo.Id);            
            
            Company_Ext__c companyExtInfo1= new Company_Ext__c();
            companyExtInfo1= globalTest.createCompanyExt(companyInfo1.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id,countryInfo.Id, stateInfo.Id);            
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGNC);           
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            EmailCampaign__c emailCampaignInfo= new EmailCampaign__c();
            emailCampaignInfo= globalTest.createEmailCampaign(eventInfo);           
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c Ticket= new Ticket__c();        
            Ticket=globalTest.createTicket(eventInfo.id,item.Id,itemPool.Id,itemType.Id, insertOrder1.id, tktprof.Id);
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.id, NULL, NULL, 'Display', 'Sales Message');
            
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.id, NULL, NULL, 'Event Staff','Sales Message');
            
            Role__c Role= new Role__c();
            Role= globalTest.createRole();
            role.Role_ShortName__c='trole';
            update Role;
            
            
            UC_Role__c ucro = new UC_Role__c();
            ucro.GN_User__c= userForGN.id;
            ucro.event__c = eventInfo.id;
            ucro.RoleId__c= role.id;
            ucro.company__c = companyInfo.id;
            ucro.Title__c= 'senior engineer';
            ucro.user_type__c='event admin';
            insert ucro;
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGNC,countryInfo.Id, Stateinfo.Id);

            Badge__c bdg= new Badge__c();
            bdg=globalTest.createBadge(Ticket.id);
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
            
            Promotion__c promotion4= new Promotion__c();
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
            
            PGateway_Type__c pgt = new PGateway_Type__c(Name='cash');
            insert pgt;
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pw;
            
            Payment__c pp= new Payment__c();
            pp.BLN_Pay_Gateway__c=pw.id;
            pp.credit_card_last_4digits__c='1245';
            pp.credit_card_type__c='vasa';
            pp.Currency_Code__c=currenyInfo.id;
            pp.Order__c=insertOrder1.id;
            pp.Payment_Amount__c=100;
            pp.Payment_Mode__c='cash';
            insert pp;
            
             Registration_Template__c  rgtemp = globalTest.createRegistrationTemplate();
          
            
            
            Question__c ques = new Question__c();
            //ques.Name='QUE-000051';
            ques.Event__c=eventinfo.id;
            ques.Question_Text__c='how do you know this event?';
            ques.Question_Order__c=1;
            insert ques;
            
              
          BLN_Answer__c usaa= new BLN_Answer__c();
            usaa.Answer_Default__c=true;
            usaa.Answer_Order__c=1;
            usaa.Answer_Text__c='tescccc';
            usaa.BLN_Question__c=ques.id;
            insert usaa;
             
              BLN_Answer__c usaa1= new BLN_Answer__c();
            usaa1.Answer_Default__c=true;
            usaa1.Answer_Order__c=1;
            usaa1.Answer_Text__c='tescccc';
            usaa1.BLN_Question__c=ques.id;
            insert usaa1;
             
             list<BLN_Answer__c> lu = new list<BLN_Answer__c>();
            
             lu.add(usaa);
              lu.add(usaa1);
              
              Item_Question__c ic = new Item_Question__c();
              ic.Event__c=eventinfo.id;
              ic.IQ_Order__c=1;
              ic.isRequired__c=true;
              ic.Item__c=item.id;
              ic.Item_Pool__c=ItemPool.id;
              ic.Question__c=ques.id;
              ic.Visibility__c=true;
              ic.Question_Level__c='Ticket Level';
              insert ic;
              
            BLN_Quick_Registration_BAL qregBAL=new BLN_Quick_Registration_BAL();
            
            
            qregBAL.getExistingUser(u.email);
            qregBAL.getExistingUser('testttt@testttt.com');
            qregBAL.geteventDetails(eventInfo.Id);
            qregBAL.getEventItems(eventInfo.Id);
            qregBAL.getBadgeForTicket(Ticket.Id);
            //qregBAL.getBookedTickets(eventInfo.Id);
            qregBAL.getItemInfoFrmTicket(Ticket.Id);
            qregBAL.deleteDT(insertOrder1.id);
            try{
            qregBAL.updateExistingBadge('t1','t2','t3','t4','t5','t6','t7','t8','t9','t10','t11','t12',gnUser.email__c,'t14','t15',string.ValueOf(Ticket.Id)+';');
            }catch(exception ee){}
            
            Map<String,String> mapsstt = new Map<String,String>();
            mapsstt.put(Ticket.id,bdg.Badge_Label__c);
            qregBAL.generateBadgeMultiple(mapsstt);
            
             PageReference pageRef = Page.Bln_Dashboard;
             Test.setCurrentPage(pageRef);
            BLN_RegistrationnewCon regcon=new BLN_RegistrationnewCon();
            List<BLN_RegistrationnewCon.ItemInnerClass> listreginner = new List<BLN_RegistrationnewCon.ItemInnerClass>();
            
            MAP<Id,LIST<Reg_Setting__c>> RSMap=new MAP<Id,LIST<Reg_Setting__c>>();
            LIST<Reg_Setting__c> reglst=new LIST<Reg_Setting__c>();
            reglst.add(regSettingsInfo1);
            RSMap.put(regSettingsInfo1.id,reglst);

            set<id> pid=new set<id>();
            pid.add(itempool.id);
            
            List<NAICS_Code__c> naicslst=new List<NAICS_Code__c> ();
           // naicslst.add(naicsCodeInfo1);
             naicslst.add(nacc);
            
            List<List<NAICS_Code__c>> naicsll=new List<List<NAICS_Code__c>>();
            naicsll.add(naicslst);  

            
            Diversity__c div= new Diversity__c();
            div.Order__c=1;
            insert div;
            
            List<Diversity__c> divers=new List<Diversity__c>();
            divers.add(div);
           
            BLN_RegistrationnewCon.TicketInnerClass tcs=new BLN_RegistrationnewCon.TicketInnerClass(ticket,0001,10,item,null,null,countryInfo.id,true,naicsll,divers,pid);
           
            BLN_RegistrationnewCon.ItemInnerClass tktinn = new  BLN_RegistrationnewCon.ItemInnerClass(item,null,'90',0.25,'testttt'); 
           List<BLN_RegistrationnewCon.ItemInnerClass> listregtickinner1 = new List<BLN_RegistrationnewCon.ItemInnerClass>();
           listregtickinner1.add(tktinn);
           
           List<BLN_RegistrationnewCon.TicketInnerClass> listregtickinner = new List<BLN_RegistrationnewCon.TicketInnerClass>();
           listregtickinner.add(tcs);
           BLN_RegistrationnewCon.TicketInnerClass tbl = new BLN_RegistrationnewCon.TicketInnerClass();
             List<BLN_RegistrationnewCon.TicketInnerClass> blnticinner= new List<BLN_RegistrationnewCon.TicketInnerClass>();
            MAP<id,decimal> mapiddec = new MAP<id,decimal>();
            mapiddec.put(item.Id, 0.75);
            MAP<id,decimal> mapiddec1 = new MAP<id,decimal>();
            mapiddec1.put(item.Id, 0.75);
            
            try{
           qregBAL.insertingTotalorder(listregtickinner1, listregtickinner, tbl, 0.12, 0.13, 0.14, 0.15, 0.16, mapiddec, mapiddec1, promotion1, 'chargety','cash','chargeid','paypal', 'Module', 'cardnum', 'keyname');
            }catch(exception eeee){}
            
            BLN_RegistrationnewCon.UserAnswerInnerClass lccc = new BLN_RegistrationnewCon.UserAnswerInnerClass(ques,lu,null,true,ic);
          
            List<BLN_RegistrationnewCon.UserAnswerInnerClass> lstuseransinner = new List<BLN_RegistrationnewCon.UserAnswerInnerClass>();
            lstuseransinner.add(lccc);
            
           //u BLN_Quick_Registration_BAL.surveyQuestions blnqkbal = new BLN_Quick_Registration_BAL.surveyQuestions(gnUser.id,lstuseransinner,item,Ticket, true,eventInfo.Id);
            
              test.startTest();
            qregBAL.getClientTicketsbasedonOrderOrEmail(eventInfo.Id,'oddemai');
            //qregBAL.generateBadgeMultiple();
            qregBAL.checkUser(u);
            qregBAL.checkCompany(companyInfo);
            qregBAL.checkUserEmail(u.email);
            qregBAL.insertGNUser(userForGN);
            qregBAL.updateUser(u);
            
            qregBAL.insertCompany(companyInfo,companyExtInfo);
            qregBAL.insertUser(u);
            qregBAL.insertUCRole(u.Id,companyInfo.Id,eventinfo.Id,ucro.name);
            qregBAL.insertUCRolewithUtype(u.Id,companyInfo.Id,eventinfo.Id,ucro.name,ucro.user_type__c);
            qregBAL.insertUCRolewithTitle(u.Id,companyInfo.Id,eventinfo.Id,ucro.name,ucro.user_type__c,ucro.Title__c);
            LIST<BLN_Item__c> itemlist=new LIST<BLN_Item__c>();
            itemlist.add(item);
            qregBAL.getAvailableTickets(itemlist);
            
            qregBAL.getTicketDetail(Item,1);
            map<string,gn_user__c> mapgnuser = new map<string,gn_user__c>();
            mapgnuser.put(tktprof.Email__c,gnUser);
            set<string> strst = new set<string>{'Shipping Address','Billing Address','Work Address','Home Address'};
            qregBAL.AssignAddressProfileStuff(tcs,mapgnuser,strst);
            qregBAL.getEventPayGateWays(eventInfo.id);
            qregBAL.userPicInsert1('StringToBlob','myDoc');
            qregBAL.userPicInsert('StringToBlob','myDoc');
            qregBAL.getBookedTickets(eventInfo.id);
            set<id> stid = new SET<id>{ticket.id};
            qregBAL.insertMlData(stid);
             qregBAL.insertAttSum(new List<Tkt_profile__c>{tktprof} );
            LIST<String> uidlst=new LIST<String>();
            uidlst.add(u.id);
            LIST<String> compIDList=new LIST<String>();
            compIDList.add(companyInfo.Id);
            LIST<String> ticIDList=new LIST<String>();
            ticIDList.add(ticket.id);
            try{
          //u  qregBAL.updateTickets(uidlst,compIDList,ticIDList,EventInfo.Id,u.Id,15,1,1,1,10,null,2,'test PromoCode',  'PayAddress',  'ChargeType', 'PGatewayType','ChargeId', 'Check', 'Module');
            }catch(exception e){}
            try{
            qregBAL.getRegTempDetails(rgtemp.id);
            }catch(exception ee){}
          
                qregBAL.checkUser(u);
                qregBAL.checkCompany(companyinfo);
                qregBAL.checkUserEmail(u.email);
                qregBAL.insertGNUser(userForGN);
                qregBAL.insertUser(u);
                qregBAL.updateUser(u);
                qregBAL.insertCompany(companyinfo,companyExtInfo);
                try{
                    qregBAL.insertUCRole(u.Id,companyinfo.Id,eventinfo.Id,role.name);
                }catch(exception eeee){}
                 
            try {
                qregBAL.insertUCRolewithUtype(userForGN.Id,companyInfo.Id,eventInfo.Id,Role.Id,ucro.user_type__c); 
            }catch(exception ee){}
            
             
                

            SET<string> sttstng = new SET<string>();
            sttstng.add('sttstn');
            
            List<GN_user__c> lstgnu = new List<GN_user__c>();
            lstgnu.add(gnUser);
            
            
            
            try {
                qregBAL.insertingusers(lstgnu);
             
            } catch(exception eec) {}
            
           itemType.Name = 'Package';
           update itemType;
           Item.Ticket_Settings__c = 'Collect info from All Attendees';
           update item;
           
           qregBAL.getTicketDetail(Item,1);
           BLN_Quick_Registration_BAL.surveyQuestions svy = new BLN_Quick_Registration_BAL.surveyQuestions(lstuseransinner ,item,ticket,true,eventinfo.id);
           list<BLN_Quick_Registration_BAL.surveyQuestions> svyl= new list<BLN_Quick_Registration_BAL.surveyQuestions>();
           svyl.add(svy);
        qregBAL.surveyAnswersInsertion(svyl);
           
           UC_Role__c ucro1 = new UC_Role__c();
            ucro1.GN_User__c= userForGN.id;
            ucro1.event__c = eventInfo.id;
            ucro1.RoleId__c= role.id;
            ucro1.company__c = companyInfo1.id;
            ucro1.Title__c= 'senior engineer';
            ucro1.user_type__c='event admin';
            insert ucro1;
        
           qregBAL.inserUcroleNew(companyInfo1.id,userForGN.id,true,role.id);
           qregBAL.insertCompanyExtNew(tcs,companyInfo1.id);
            BLN_Address__c tktaddress = new BLN_Address__c();
        tktaddress.Address1__c = 'Address1';
        tktaddress.Address2__c = 'Address2';
        tktaddress.City__c = 'hyd';
        tktaddress.Country__c = countryInfo.id;
        tktaddress.State__c = stateInfo.id;
        tktaddress.ZipCode__c = '85258';
               insert tktaddress;
               qregBAL.InsertHomeAdd(tktaddress);
               
                 Tkt_profile__c insertTktprofile= new Tkt_profile__c();
        
       
        insertTktprofile.First_Name__c= 'testfname';
        insertTktprofile.Last_Name__c= 'testlname';
        insertTktprofile.Email__c= u.email;
        insertTktprofile.TKT_Job_Title__c= u.Title;
        //insertTktprofile.BLN_GN_User__c = insertGNUser.Id;
        insert insertTktprofile;
        qregBAL.compNaics(nacc.id,insertTktprofile.id,companyInfo1.id,userForGN.id);
        BLN_Commodities__c comd = new BLN_Commodities__c();
        comd.Description__c='Accounting';
         insert comd;
         qregBAL.compCommodity(comd.id,insertTktprofile.id,companyInfo1.id,userForGN.id);
         
        Diversity__c divv = new Diversity__c();
        divv.Name   ='MINORITY OWNED BUSINESS ENTERPRISE';
        divv.Order__c=2;
        insert divv;
         qregBAL.compDivesity(divv.id,insertTktprofile.id,companyInfo1.id,userForGN.id);
           test.stopTest();
            }
            BLN_Quick_Registration_BAL blm= new BLN_Quick_Registration_BAL();
            //blm.insertingTotalorder(listreginner, listregtickinner, blnticinner, 0.12, 0.13, 0.14, 0.15, 0.16, mapiddec, mapiddec, promotion1, 'chargety', string.valueof(pp.Payment_Mode__c),'chargeid', string.valueOf(pp.Payment_Ref_Number__c),'Module', 'cardnum', 'keyname');
   }
}
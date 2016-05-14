@isTest(SeeAllData=true)
public class Test_BLN_Quick_Registration_Con{
public static BLN_Event__c eventInfo ;
public static list<string> nestring;

public static testmethod void Testmethod_BLN_Quick_Registration_Con(){
 globalForTestClass    globalTest= new globalForTestClass();
    
        Account acc= new Account(Name='nestacc');
        insert acc;
        
        contact con = new contact(firstname='gnnest',lastname='gnestuser',AccountId=acc.id);
        insert con;
        
        Profile p = [select id from profile where name='Event Admin1'];
        
        User U= new User(alias = 'gn', email='gnestuser@noemail.com', firstname= 'fngnst', Phone= '9700772445',ContactId= con.Id,
                         emailencodingkey='UTF-8',profileid = p.Id,lastname='gnusernest', languagelocalekey='en_US',
                         localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNestpvtltd',
                         timezonesidkey='America/Los_Angeles', username='gnestuser@noemail.com', Title= 'SFDC Developer pro');
        database.insert(U,false);
        system.runas(U){
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);          
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Company__c  companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(U.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id,countryInfo.Id, stateInfo.Id);            
            
            
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);     
            
            PGateway_Type__c ptype=new PGateway_Type__c(Name='paypal',Adaptive_Type__c='Direct');
            insert ptype;
            
            
            Pay_Gateway__c pgway = new Pay_Gateway__c(PGateway_Type__c=ptype.id,Company__c=companyInfo.id,PG_Signature__c='test',PG_User_Key__c='pk_test_zjcSlJ9fW9wqITilILis7pt9');
            insert pgway;
            
            Event_Pay_Gateway__c  eventpaygatway =new Event_Pay_Gateway__c(Events__c = eventInfo.id,Pay_Gateway__c = pgway.id,Registration_Type__c = 'Onsite' );
            insert eventpaygatway ;
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(u);

            
            Order__c Orderinfo= new Order__c();
            Orderinfo=  globalTest.createOrder(tktprof.id, u.id, companyInfo.id, eventInfo.id, currenyInfo.Id);
            
            ApexPages.currentPage().getParameters().put('id',eventInfo.id);
            
            cookie  onsiteorderid= new Cookie('onsiteorderid',Orderinfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{onsiteorderid});
            
            
            
            cookie  counter= new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            
            Order__c Orderdetails= [select id,name from Order__c where id =: Orderinfo.id];
            
            
            
            Item_Type__c itemType2= new Item_Type__c();
            itemType2= globalTest.createItemType();
            
             Event_Price__c ineventprice= new Event_Price__c();
             ineventprice=globalTest.createEventPrice(eventInfo.id,itemType2.id);
             
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            
            Item_Pool__c  ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType2.Id, NULL, trackInfo.id);
            
            BLN_Item__c   item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType2.Id, eventInfo.id);
            
            BLN_BadgeTemplate_Styles__c Badgetemplateinfo=new BLN_BadgeTemplate_Styles__c();
            Badgetemplateinfo =  globalTest.createBadgeTemplateStyle(eventInfo.id);
            
             Ticket__c Ticketinfo1= new Ticket__c();        
            Ticketinfo1=globalTest.createTicket(eventInfo.id,item.Id,itemPool.Id,itemType2.Id, Orderinfo.id, tktprof.id);
            
            
            Ticket__c Ticketinfo= new Ticket__c();        
            Ticketinfo=globalTest.createTicket(eventInfo.id,item.Id,itemPool.Id,itemType2.Id, Orderinfo.id, tktprof.id);
            
            Badge__c badgesinfo = new Badge__c(ticket_id__c = Ticketinfo.id);
            insert badgesinfo ;
        
                BLN_Quick_Registration_Con  BLquickReg = new BLN_Quick_Registration_Con ();
               // BLquickReg.pagename='BLN_QUICKREGISTRATIONIFRAME';
            cookie  prcok= new Cookie('prcok','BLN_QUICKREGISTRATIONIFRAME',null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{prcok});
                
                BLquickReg.freeticket = false;
                BLquickReg.orderno=Orderdetails.name;
                BLquickReg.displayPermissions();
                BLquickReg.getGetln();
                system.debug('@@event'+BLquickReg.event);
                system.debug('@@orderno'+BLquickReg.orderno);
                BLquickReg.search();
                BLquickReg.ticketitems=Ticketinfo.id ;
                //BLquickReg.getOrderDetails();
                BLquickReg.orderno=null;
                BLquickReg.getOrderDetails();
                
                
                BLquickReg.ASUserEmail ='gnestuser@noemail.com';
                BLquickReg.processEmail();
                
                BLquickReg.printAvery();
                BLN_Quick_Registration_Con.Style ste=new BLN_Quick_Registration_Con.Style('dfsde3','3','2','4','3','4','4px','5px','6px','7px','3px','4px','8px','center','12px','Arial','none','none','none','0.5','Red','none','none');
                BLN_Quick_Registration_Con.Badge bdge=new BLN_Quick_Registration_Con.Badge('5px','8px','yellow');
                
                BLquickReg.selectValue();
                
                BLquickReg.hideResults();
                BLquickReg.ticketitems=Ticketinfo.id ;
                BLquickReg.changeBatch();
                BLquickReg.finditemdetail();
                
                
                Item_Type__c itemtypeupd= [select id,Item_Type_Number__c from Item_Type__c where id =: itemType2.id];
                itemtypeupd.Item_Type_Number__c = 'IT-000005';
                update itemtypeupd;
                
                BLquickReg.finditemdetail();
                nestring = new list<string>();
                nestring.add(string.valueof(Ticketinfo.id));
                nestring.add(string.valueof(Ticketinfo.id));
               // BLquickReg.completeorder('External Pay Gateway','5241',string.valueof(eventInfo.id),'1254563254125415','05','2016','253',25,5,30,'john','miller','john.m@gmail.com','ticket buy','9848924586','geo india',nestring);
                
                Role__c Role= new Role__c();
                Role= globalTest.createRole();
                role.Role_ShortName__c='trole';
                update Role;
                
            
                UC_Role__c ucro = new UC_Role__c();
                ucro.GN_User__c= gnUserInfo.id;
                ucro.event__c = eventInfo.id;
                ucro.RoleId__c= role.id;
                ucro.company__c = companyInfo.id;
                ucro.Title__c= 'senior engineer';
                insert ucro;
            
                test.starttest();
            
                Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
                //BLquickReg.completeorder('PayPalDirect','5241',string.valueof(eventInfo.id),'1254563254125415','05','2016','253',25,5,30,'john','miller','john.m@gmail.com','ticket buy','9848924586','geo india',nestring);
                
                BLN_User_DAO userDAO=new BLN_User_DAO();
                userDAO.account_Contact(con);
                userDAO.createUser(u);
                userDAO.checkLoggedInUser(u.Email,u.Password__c);
                userDAO.getUser(u.Id);
                userDAO.updateUser(u);
                List<user> userlist=new List<user>();
                userlist.add(u);
                userDAO.insertUserBulk(userlist);
                userDAO.updateuserBulk(userlist);
                userDAO.insertGNUser(gnUserInfo);
                userDAO.cloneGNUser(gnUserInfo.id);
                userDAO.getGNUser(gnUserInfo.id);
                
                List<id> conids=new List<id>();
                conids.add(con.id);
                userDAO.conList(conids);
            
                List<id> uids=new List<id>();
                uids.add(u.id);
                userDAO.getusers(uids);
            
                List<contact> conlst=new List<contact>();
                conlst.add(con);
                userDAO.account_Contact(conlst);
                
                SET<string> emails=new SET<string>();
                emails.add(u.Username);
                userDAO.checkUsersWExists(emails);
                
                userDAO.checkLoggedInUser(u.Username,u.Password__c);

                test.stoptest();
                PGateway_Type__c ptype_upd=[select id, name from PGateway_Type__c where id =:ptype.id];
                ptype_upd.name = 'TrustCommerce';
                update ptype_upd;
                try{
                    BLquickReg.paymentmethod = 'TrustCommerce';
                    PageReference pageRef = Page.BLN_QUICKREGISTRATIONIFRAME;
                    Test.setCurrentPage(pageRef);       
                    BLquickReg.ordertrustpaypal();
                }catch(Exception e) {}
                 
                try{
                    PGateway_Type__c ptype_upd_pd=[select id, name from PGateway_Type__c where id =:ptype.id];
                    ptype_upd_pd.name = 'PayPal';
                    update ptype_upd_pd;
                    PageReference pageRef1 = Page.BLN_QUICKREGISTRATIONIFRAME;
                    Test.setCurrentPage(pageRef1); 
                    BLquickReg.paymentmethod = 'PayPal';
                    Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
                    BLquickReg.ordertrustpaypal();
                }catch(Exception e) {}
                try{
                    BLquickReg.twrap.add(new BLN_Quick_Registration_Con.TicketWrapper(Ticketinfo));
                    BLquickReg.twrap[0].selected = true;
                    BLquickReg.mergeBadge();
                }catch(Exception e) {}
                try{
                    BLquickReg.reason = 'no reason';
                    BLquickReg.oldbadgelabel='Attendee';
                    BLquickReg.badgelabel = 'Exibhitor';
                    BLquickReg.oldASTitle ='Gn user';
                    BLquickReg.ASTitle ='New Gn user';
                    BLquickReg.oldASPhone ='9863682125';
                    BLquickReg.ASPhone='9863682725';
                    BLquickReg.oldASFirstName='john';
                    BLquickReg.ASFirstName='kerry';
                    BLquickReg.oldASLastName='mer';
                    BLquickReg.ASLastName='pet';
                    BLquickReg.oldASUserEmail='olduser@gmail.com';
                    BLquickReg.ASUserEmail='newuser@gmail.com';
                    BLquickReg.oldASCompanyName='google';
                    BLquickReg.ASCompanyName='Microsoft';
                    BLquickReg.ticketitems=Ticketinfo.id+';'+Ticketinfo.id ;
                    
                    
                    BLquickReg.printupdate();
                }catch(Exception e) {}
                /********************************/
                try{
                    BLquickReg.paymentmethod = 'PayPalDirect';
                    BLquickReg.CheckNumber = '5241';
                    BLquickReg.event     = string.valueof(eventInfo.id);
                    BLquickReg.CreditCardNumber  = '1254563254125415';
                    BLquickReg.selectedMonth  = '05';
                    BLquickReg.selectedyear  = '2016';
                    BLquickReg.CVVNumber  = '253';
                    BLquickReg.onlyticketamount = 25.00;
                    BLquickReg.feeamount = 5.00;
                    BLquickReg.ticketamount = 30;
                    BLquickReg.ASFirstName = 'johny';
                    BLquickReg.ASLastName = 'miller';
                    BLquickReg.ASUserEmail  = 'john.m@gmail.com';
                    BLquickReg.ASTitle  = 'ticket buy';
                    BLquickReg.ASPhone = '9848924586';
                    BLquickReg.ASCompanyName  = 'geo india';
                    BLquickReg.ticketitems = Ticketinfo.id;
                    
                    BLquickReg.order();
                }catch(Exception e) {}
                try{
                ptype_upd.name = 'Stripe';
                   update ptype_upd;
                 BLquickReg.paymentmethod = 'Stripe';
                 BLquickReg.order();
                }catch(Exception e) {}
                 try{
                  ptype_upd.name = 'TrustCommerce';
                   update ptype_upd;
                 BLquickReg.paymentmethod = 'TrustCommerceDirect';
                 BLquickReg.order();
                }catch(Exception e) {}
                 try{
                  ptype_upd.name = 'Authorize.Net';
                   update ptype_upd;
                 BLquickReg.paymentmethod = 'Authorize.Net';
                 BLquickReg.order();
                }catch(Exception e) {}
                try{
                 BLquickReg.paymentmethod = 'Cash';
                 BLquickReg.order();
                }catch(Exception e) {}
                try{
                 BLquickReg.paymentmethod = 'External Pay Gateway';
                 BLquickReg.order();
                }catch(Exception e) {}
                try{
                 BLquickReg.paymentmethod = 'Check';
                 BLquickReg.order();
                }catch(Exception e) {}
                /*
                BLquickReg.ApiUserName = 'cnrtta_api1.gmail.com';
                BLquickReg.Apipassword ='1367832750';
                BLquickReg.Apisignature ='ABZZ.hNPAmUppF0oKHxXQSYXD-t3ANQAi0uz1rygrOBr0e8UVZm2w1To';
                BLquickReg.ApiapplicationId = 'app213';
                BLquickReg.Apiipaddress = 'add hyd';
                BLquickReg.paypalUrl = 'https://api-3t.sandbox.paypal.com/2.0/';
                BLquickReg.ActionType='PAY';
                try{
                BLquickReg.setPaymentOptions('PayPal');
                }catch(Exception e) {}
                */
                BLquickReg.lnsel = 'xye';
                // BLquickReg.emaiiandid.add('xyz@gmail.com');
                BLquickReg.email  = 'abc@gmail.com';
                BLquickReg.eventid = string.valueof(eventInfo.id);
                // BLquickReg.selectValue=
                
                BLquickReg.searchValue = 'secce';
                BLquickReg.maxHeights = 2;
                BLquickReg.checkboxselected = true;
                BLquickReg.error = 'N - No Badge';
                //BLquickReg.eventChosenTickets.add(Ticketinfo);
               // BLquickReg.eventdetails = null;
                BLquickReg.getOrderDetails(); 
                BLN_Quick_Registration_Con.checkUser('');
                BLN_Quick_Registration_Con.getGnuser('');
                BLN_Quick_Registration_Con.getGnuser('test@gmail.com');
                
                
                BLN_Role_DAO rlDAO=new BLN_Role_DAO();
                rlDAO.userRole('trole');
                Registration_Template__c rtc=new Registration_Template__c(name='mytemplate',Template_Image_URL__c='https://upload.wikimedia.org/wikipedia/commons/3/33/Vanamo_Logo.png');
                insert rtc;
                BLN_RegTemplate_DAO brt=new BLN_RegTemplate_DAO();
                Registration_Template__c rt=new Registration_Template__c();
                rt=brt.getRegTempDetails(rtc.id);
                BLquickReg.RespEnvp=null;
                BLquickReg.PayResponse=null;
                try{
                ptype_upd.name = 'TrustCommerce';
                update ptype_upd;
                BLquickReg.paymentmethod='TrustCommerce';
                BLquickReg.ordertrustpaypal();
                }catch(Exception e){}
                try{
                BLquickReg.paymentmethod = 'PayPal';
                ptype_upd.name = 'PayPal';
                    update ptype_upd;
                BLquickReg.ordertrustpaypal();
                }catch(Exception e){}
                try{
                 BLquickReg.eventdetails = null;
                BLquickReg.getOrderDetails(); 
               
                }catch(Exception e){}
              BLN_Quick_Registration_Con quicks=new  BLN_Quick_Registration_Con();
             
                BLquickReg.twrap.add(new BLN_Quick_Registration_Con.TicketWrapper(Ticketinfo1));
                    BLquickReg.twrap[0].selected = true;
                    BLquickReg.getSelected();
                    
                    BLquickReg.ticketitems=item.id ;
                    Ticketinfo.Ticket_Status__c='Available';
                    Ticketinfo.Parent_ID__c=NULL;
                    update Ticketinfo;
                    item.visibility__c='Public';
                    update item;
                    Ticket__c Ticketinfock= new Ticket__c();        
            Ticketinfock=globalTest.createTicket(eventInfo.id,item.Id,itemPool.Id,itemType2.Id, Orderinfo.id, tktprof.id);
            Ticketinfock.Parent_ID__c=Ticketinfo.id;
            update Ticketinfock;
                     BLquickReg.finditemdetail();
                   
                
                      
}       
}
}
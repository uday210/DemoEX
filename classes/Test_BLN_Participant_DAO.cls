/**
    * Developer: Vineel 
    * Date: Nov 12' 2015
    */
    @isTest
    public class Test_BLN_Participant_DAO {
        
        static testMethod void TestMethod_BLN_Participant_DAO() {
            
            globalForTestClass globalTest= new globalForTestClass();
            User u= new User();
            u= globalTest.createUserForGNUser();
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            NAICS_Code__c naicsCodeInfo1 = new NAICS_Code__c();
            naicsCodeInfo1 =globalTest.createNaicsCode();
            
            
            NAICS_Code__c naicsCodeInfo2 = new NAICS_Code__c();
            naicsCodeInfo2 =globalTest.createNaicsCode();
            
            
            Company_Ext__c companyExtInfo = new Company_Ext__c();
            companyExtInfo = globalTest.createCompanyExt(CompanyInfo.id,naicsCodeInfo1.Id,naicsCodeInfo2.Id,countryInfo.Id,Stateinfo.Id);
            
            
            // Inserting item type with admission
            Item_Type__c insertItemType= new Item_Type__c();
            insertItemType.Name= 'Admissions';
            insertItemType.Badge_Label__c= 'BadgeLabel';
            insertItemType.Order__c=1;
            insertItemType.Add_On__c= False;
            insertItemType.Unlimited__c=false;
            insertItemType.Badgable__c = 'B - Badge';
            
            insert insertItemType;
            
            // inserting pool for admission ticket 
            Item_Pool__c insertItemPool= new Item_Pool__c();
            insertItemPool.Event__c= eventinfo.Id;
            insertItemPool.Item_Pool_Name__c= 'Admission';
            insertItemPool.item_type__c= insertItemType.id;
            insertItemPool.Item_Count__c= 12;
            // insertItemPool.Addon_Parent__c= insertItemType.id;
            insertItemPool.Addon_Count__c= 0;
            insertItemPool.Ticket_Settings__c   = 'Collect info from Buyers only';
            insert insertItemPool;
            
            // Inserting item
            BLN_Item__c insertItem= new BLN_Item__c();
            insertItem.item_name__c= 'Admission';
            insertItem.Item_Pool__c= insertItemPool.id;
            insertItem.item_type__c= insertItemType.id;
            insertItem.Visibility__c  ='public';
            insertItem.Event__c= eventinfo.Id;
            insertItem.price__c= 22.50;
            insertItem.Payment__c= 'Paid';
            insertItem.item_count__c= 12;
            insertItem.Taxable__c = false;
            insertItem.sale_start__c=System.today()-1;
            insertItem.sale_end__c=System.today()+2;
            insertItem.Ticket_Settings__c   = 'Collect info from Buyers only';
            insert insertItem;
            
            // insert promotion
            Promotion__c pro = new Promotion__c();
            pro.Promo_Code__c = 'Basic';
            pro.Promotion_Type__c = 'Basic Promo codes';
            pro.Condition_Type__c ='Quantity Threshold';
            pro.Discount_Type__c ='Percent';
            pro.Discount_Value__c =0.0;
            pro.Eff_TimeStamp__c = system.today();
            pro.Event__c = eventinfo.Id;
            pro.Exp_TimeStamp__c =system.today()+1;
            pro.I_Max_Count__c =12;
            pro.Status__c ='active';
            pro.T_Max_Count__c  =12;
            pro.T_Used_Count__c =0;
            pro.Type__c = 'Promo code';
            insert pro;
            
            PGateway_Type__c ptype = new PGateway_Type__c();
            ptype.Online_Flag__c = true;
            ptype.Onsite_Flag__c =true;
            ptype.Name = 'Cash';
            insert ptype;
            
            Pay_Gateway__c paygatecom = new Pay_Gateway__c();
            paygatecom.Company__c = CompanyInfo.id;
            paygatecom.PGateway_Type__c = ptype.id;
            insert paygatecom;
            
            Event_Pay_Gateway__c epay = new Event_Pay_Gateway__c();
            epay.Events__c = eventinfo.Id;
            epay.Pay_Gateway__c = paygatecom.id;
            epay.Registration_Type__c = 'Online';
            insert epay;
            
            // insert item promocode
            Item_Promotion__c itp = new Item_Promotion__c();
            itp.Buy_Item__c = insertItem.id;
            itp.Item_Discount_Type__c = 'Percent';
            itp.Item_Discount_Value__c = 50;
            itp.Promotion__c = pro.id;
            insert itp;  
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(u);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, u.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Order_Item__c insertOrderItem = new Order_Item__c();        
            insertOrderItem =globalTest.createOrderItem(insertItem.id,insertOrder1.id,pro.id,currenyInfo.id);
            
            ticket__c ticket=new ticket__c();
            ticket=globalTest.createTicket(eventinfo.Id,insertitem.Id, insertItemPool.Id, insertItemType.Id,insertOrder1.Id, tktprof.id);
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,insertItem.Id,que.Id);
            
            BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
            
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            BLN_Room__c rum= new BLN_Room__c();
            rum= globalTest.createRoom(eventInfo.id);
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            
            Agenda__c agd = new Agenda__c();
            agd = globalTest.createAgenda(eventInfo.id,trackInfo.id);
            
            
            Time_Slots__c tslot= new Time_Slots__c();
            tslot= globalTest.createTimeSlot(agd.id,rum.id);
            
            Participant__c  partcpnt= new Participant__c ();
            partcpnt= globalTest.createParticipant(gnUser.Id,tslot.id);
            
            List<Participant__c> listofparti = new List<Participant__c>();
            listofparti.add(partcpnt);
            
            BLN_Participant_DAO participantdaotest = new BLN_Participant_DAO();
            participantdaotest.allParticipants(eventInfo.Id);
            participantdaotest.freeParticipants(eventInfo.Id);
            participantdaotest.insertParticipants(listofparti);
            
            
            
        }
        
    }
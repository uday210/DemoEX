@istest
public class Test_BLN_LeadRetrievalCon{
    public static testmethod void Testmethod_BLN_LeadRetrievalCon(){
    
    globalForTestClass globalTest= new globalForTestClass();
    
     Profile p = [select id from profile where name='System Administrator'];
     userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
     

     User u = new User(alias = 'Test', email='testcode123vb@noemail.com',
                       emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                       localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                       timezonesidkey='America/Los_Angeles', username='testcode123vbc@noemail.com');
    insert u;
    
    
    
    
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
            
            User userInfo= new User();
            userInfo= globalTest.createUserForGNUser();
                        
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(userInfo, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, stateInfo.Id);
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof=globalTest.createTktprofile(userInfo);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
        Question__c que = new Question__c();
        que=globalTest.createQuestion(eventInfo.id);
        
        Item_Question__c itemQue = new Item_Question__c();
        itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
        
       BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
             
        User_Answer__c  usrAns = new User_Answer__c();
        usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
        
        
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            //ticket.tkt_profile__c= tktprof.id;
           // update ticket;
        
            Lead_Scan__c ls=new Lead_Scan__c();
        ls.First_Name__c='testa';
        ls.Last_Name__c='testb';
            ls.Event__c=eventInfo.id;
            //ls.Scanee_User__c=gnUserInfo.id;
            ls.Scanner_Company__c=companyInfo.id;
            ls.Scanner_User__c=gnUser.id;
            ls.Lead_Status__c='Active';
            insert ls;
            
            Device_Usage__c du=new Device_Usage__c();
            du.Event__c=eventInfo.id;
            //du.User__c=gnUserInfo.id;
            insert du;
        
            que.OwnerId=gnUserInfo.User__c;
            update que;
            
            itemQue.Question_Level__c='Lead Retrieval';
            update itemQue;

            //usrAns.User__c=ls.Scanee_User__c;
            //update usrAns;
        
        Company_Ext__c CompanyExt= new Company_Ext__c();
        CompanyExt= globalTest.createCompanyExt(companyInfo.id, naicsCodeInfo1.id,naicsCodeInfo2.Id,countryInfo.Id,stateInfo.Id);
        
            Reg_Setting__c rsett = new Reg_Setting__c();
            rsett.Event__c = eventInfo.id;
            rsett.Included__c =true;
            insert rsett;
            
            PageReference pageRef1 = Page.BLN_LeadRetrieval;
            Test.setCurrentPage(pageRef1);
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_LeadRetrievalCon lrcon = new BLN_LeadRetrievalCon();
            lrcon.displayPermissions();
            ApexPages.currentPage().getParameters().put('search','');
            lrcon.expLeadAction();
            ApexPages.currentPage().getParameters().put('search[value]','');
            ApexPages.currentPage().getParameters().put('start','0');
            ApexPages.currentPage().getParameters().put('length','10');
            lrcon.processData();
            //lrcon.selectedeventid=eventInfo.id;
            BLN_LeadScan_DAO lsDAO=new BLN_LeadScan_DAO ();
            string condition=' AND id=\'' + ls.id + '\'';
            lsDAO.getLeadScan(eventInfo.id,condition);
            apexpages.currentpage().getparameters().put('showId',ls.id);
            lrcon.showpopup();
            apexpages.currentpage().getparameters().put('editLead',ls.id);
            lrcon.editLead();
           // lrcon.countryStates();
           // lrcon.statesBasedOnCountry();
            
            
            lrcon.SavePopup();
            lrcon.closePopup();
            
            lrcon.printLeads();
            lrcon.exportLeads();
            lrcon.salesorgExport();

        lsDAO.getLeads(u.Id, eventInfo.id, companyInfo.id);
        lsDAO.Leadexistchk(eventInfo.id, gnuser.id, u.Id);
        lsDAO.getLeadScan_dashboard(eventInfo.id,'');
        lsDAO.getLeads(u.Id,eventInfo.id, companyInfo.id,'',null);
        set<id> lids = new set<id>();
        lids.add(ls.id);
        lsDAO.leadRecords(lids);
        
        BLN_LeadRetrieval_BAL lrBAL=new BLN_LeadRetrieval_BAL();
        lrBAL.insertLead(ticket, u.Id, eventInfo.id, companyInfo.id,null);
        //lrBAL.showleaddetails(ls.id,eventInfo.id);
        list<Lead_Scan__c> lslist=new list<Lead_Scan__c>();
        lslist.add(ls);
        lrBAL.maintableVals(eventInfo.id,lslist);
        list<Ticket__c> tct = new list<Ticket__c>();
        tct.add(ticket);
        LIST<datetime> st=new LIST<datetime>();
        st.add(system.now());
        lrBAL.insertLead(tct,u.id,eventInfo.id, companyInfo.id,st);
        BLN_LeadRetrieval_BAL.qaclass qa=new BLN_LeadRetrieval_BAL.qaclass('testque','testans');
        BLN_LeadRetrieval_BAL.editqaclass edtqa=new BLN_LeadRetrieval_BAL.editqaclass(que,usrAns);
        
        apexpages.currentpage().getparameters().put('deleteLead',ls.id);
        lrcon.deleteLead();
    
    }
    
    }   
}
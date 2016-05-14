@isTest(SeeAllData=true)
public class Test_BLN_Gnuser_DAO {
    static testmethod void Testmethod_BLN_Gnuser_DAO(){
    
    User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    U= globalTest.createUser();
    
    system.runas(U){
        
         NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
        
        User userForGN= new User();
        userForGN= globalTest.createUserForGNUser();
        
        Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof=globalTest.createTktprofile(userForGN);
        
        Company__c companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(u.Companyname);
        
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
        
        Country__c countryInfo= new Country__c ();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
        
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
        
        Company_Ext__c companyExtInfo= new Company_Ext__c();
        companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
        
        GN_User__c  gnUser= new GN_User__c();
        gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
        tktprof.bln_gn_user__c=gnUser.id;
        update tktprof;
        system.debug('@@@tktprof'+tktprof);
        BLN_Event__c eventInfo= new  BLN_Event__c();
        eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
        
         Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            UC_Role__c ucRoleInfo= new UC_Role__c();
            ucRoleInfo= globalTest.createUCRole(companyInfo.Id, eventInfo.Id, gnUser.id, u.Id, roleInfo.id);  
        
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
                   
        Order_Item__c orderItem= new Order_Item__c();
        orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
        
        
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
        
        BLN_GNUser_BAL gnuBAL  = new BLN_GNUser_BAL();
        gnuBAL.upsertGNUser(companyinfo.name);
        
        BLN_Gnuser_DAO gnuDAO=new BLN_Gnuser_DAO();
        set<id> gids=new set<id>();
        gids.add(userForGN.id);
        gids.add(gnUser.id);
        gnuDAO.getGnuserList(gids);
        
        gnuDAO.InsertGNUser(gnUser);
        List<GN_User__c> gnlist=new List<GN_User__c>();
        gnlist.add(gnUser);
        gnuDAO.InsertGNUser(gnlist);
        gnuDAO.gettingUserRoleData(gnUser.id);
        gnuDAO.gettingCmpnyExtData(companyinfo.id);
        gnuDAO.existingGnuser(gnUser.email__c);
        SEt<string> mailset=new SEt<string>();
        mailset.add(gnUSer.email__c);
        gnuDAO.existingGnusers(mailset);
        gnuDAO.gettinggnuser(userForGN.id);
        gnuDAO.insertGnUserprocess('FirstName', 'LastName', 'sai@globalnest.com', 'title', '9999999999', 'address1', 'address2', 'city', 'hyd', 'India', '11111');
       GN_User__c insertGNUser= new GN_User__c();
        
        insertGNUser.User__c= u.id;
       
        insertGNUser.Email__c='sai1@globalnest.com';
        insertGNUser.First_Name__c= 'FirstName';
        insertGNUser.Last_Name__c= 'LastName';
        insertGNUser.Home_Phone__c= '9999999999';
       
        
        insert insertGNUser;
       
        //gnuDAO.updateGNUser(insertGNUser,'sai@globalnest.com',ticket.id,'dadadadd');
    }
    }

}
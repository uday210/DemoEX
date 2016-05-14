/*************************************************************************
 * Developer: Vineel 
 * Date: 9 Sep' 2015
 * Purpose: New Test Class

**************************************************************************/


@isTest
public class Test_BLN_Company_DAO {

    public static testMethod void testMethod_BLN_Company_DAO() {
        
        
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        System.runAs(U){
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
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

            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            GN_User__c  gnUser1= new GN_User__c();
            gnUser1= globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Type__c itemTypelr= new Item_Type__c();
            itemTypelr= globalTest.createItemType13();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPoollr= new Item_Pool__c();
            ItemPoollr= globalTest.createItemPool(eventInfo.id, itemTypelr.Id, NULL,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c itemlr= new BLN_Item__c();
            itemlr= globalTest.createItem(ItemPoollr.Id, itemTypelr.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket.note__c = 'abcd';
            update ticket; 
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, itemlr.Id, itemPoollr.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            
            Event_Price__c evntpr = new Event_Price__c();
            evntpr= globalTest.createEventPrice(eventInfo.Id, itemTypelr.Id);
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);            
            tstatus__c tstat = new tstatus__c();
            tstat = globalTest.createTstatus(ticket.Id);
         
            BLN_Company_DAO blncom = new BLN_Company_DAO();
            
            blncom.checkCompany(companyInfo.name);
            blncom.insertCompany(companyInfo);    
            blncom.updateCompany(companyInfo);
            blncom.insertcompdetails(companyInfo.Id,companyExtInfo);
            try { 
            blncom.queryCompanyId(companyInfo.Name);    
            } catch(exception ess) {}
            
            try { 
            blncom.queryPersonalCompanyId(gnUser.Email__c);
            } catch(exception ess) {}
            
            blncom.queryCompany(companyInfo.Id);
            
            SET<Company__c> setcom = new SET<Company__c>();
            setcom.add(companyInfo);
            blncom.insertCompanyBulk(setcom);
            
            List<String> lstng = new List<String>();
            lstng.add('strling');
            blncom.getcompanies(lstng);
            
            SET<String> ststng = new SET<String>();
            ststng.add('companyInfo');
            blncom.compinies(ststng);
            
            List<Id> lscomId = new List<Id>();
            lscomId.add(companyInfo.Id);
            blncom.companiesForEvent(lscomId);
            
            blncom.gnusercompanies('blncom1');
            
            //try{
            blncom.insertcompanyAnducroleprocess(eventInfo.Id,'Vineel','Ragula','vineel.ragula1111@globalnest.com',insertOrder1.Id,'Globalnest1111','GNDesc','www.globalnest.com');
           // }catch(exception eee){}
            
            blncom.insertcompanyAnducroleprocess(eventInfo.Id,'Vineel','Ragula','vineel.ragula22222@globalnest.com',insertOrder1.Id,'','GNDesc2222','www.globalnest.com');
            blncom.getCompany('Globalnest','vineel.ragula1@globalnest.com');
            blncom.checkPersonalAccount('vineel.ragula2@globalnest.com');
            
            blncom.ComapList(lscomId);
            blncom.upsertCompanyExt(companyExtInfo);
            
            SET<id> cpIds=new SET<id>();
            cpIds.add(companyInfo.id);
            blncom.ComapList(cpIds);
            
        }
    }
    
}
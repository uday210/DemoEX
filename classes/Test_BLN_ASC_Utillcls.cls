@isTest(seeAllData=true)
public class Test_BLN_ASC_Utillcls{

  string fullUrl =  Site.getBaseUrl();
   
    
    static testmethod void Testmethod_BLN_ASC_Utillcls(){
       
    
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
            List<Company__c> cmplist = new List<Company__c>();
            cmplist.add(companyInfo);
            
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
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            Tkt_profile__c  tktprof1 = new Tkt_profile__c();
            
            tktprof=globalTest.createTktprofile(userForGN);
            tktprof.TKT_Company__c='test';
            update tktprof;
            
            tktprof1=globalTest.createTktprofile(userForGN);
            tktprof1.TKT_Company__c='test';
            update tktprof1;
            System.debug('Kkkkkkk '+tktprof1);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof1.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            System.debug('insertOrder1 '+insertOrder1);
            
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
            
            list<Ticket__c> tktlist = new list<Ticket__c>();
            tktlist.add(ticket);
            //tktlist.add(ticket1);
            
             Item_Type__c insertItemType= new Item_Type__c();
             insertItemType.Name= 'Admissions';
            insertItemType.Badge_Label__c= 'BadgeLabel';
            insertItemType.Order__c= 22.12;
            insertItemType.Add_On__c= TRUE;
            insertItemType.Unlimited__c=false;
        
            insert insertItemType;
            
              
            BLN_Room__c broom=new BLN_Room__c ();
            broom = globalTest.createRoom(eventInfo.id);
        
        Hash_Tag__c tagInfo1= new Hash_Tag__c();
            tagInfo1= globalTest.createTag(eventInfo.Id);
            
            list<Hash_Tag__c> taglst= new list<Hash_Tag__c>();
            taglst.add(tagInfo1);
        
            Agenda__c agd = new Agenda__c();
            agd = globalTest.createAgenda(eventInfo.id,trackInfo.id);
            
            
            Time_Slots__c tslot= new Time_Slots__c();
            tslot= globalTest.createTimeSlot(agd.id,broom.id);
            
            Participant__c  partcpnt= new Participant__c ();
            partcpnt= globalTest.createParticipant(gnUser.Id,tslot.id);
            
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
      list<Order_Item__c> orderItemlist = new list<Order_Item__c>();
        orderItemlist.add(orderItem);
dateTime d= eventInfo.End_Date__c;
 Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id);
            insert payobj;
BLN_Sponsorships__c spn1 = new BLN_Sponsorships__c(Sponsorship_Category__c='textbc',Ticket_ID__c=ticket1.id,Logo_Size__c='Large');
 insert spn1;
Booth_Map__c    BoothMap=new Booth_Map__c(Name = 'Public Booth',BLN_Room__c = broom.id ,Ticket_id__c = ticket1.id,Booth_Size__c = '5'  );
            insert BoothMap;   
            
      // public inncls(order__c od,List<order_Item__c> orderit,dateTime d,payment__c paym,List<Ticket__c> ticin,List<Company__c> lComps,List<Hash_Tag__c> tTags){               
             BLN_Mytickets_BAL.inncls ordersList =new BLN_Mytickets_BAL.inncls(insertOrder1,orderItemlist,d,payobj,tktlist,cmplist,taglst);
        
        
      
            
            BLN_ASC_Utillcls bau = new BLN_ASC_Utillcls();
            
        BLN_ASC_Utillcls.companyInfo  baucinfo = new BLN_ASC_Utillcls.companyInfo(tktprof);
       BLN_ASC_Utillcls.appSttings  baucappSttings = new BLN_ASC_Utillcls.appSttings (regSettingsInfo1);
try{ 
BLN_ASC_Utillcls.TktProfileInfo bauctktinfo = new BLN_ASC_Utillcls.TktProfileInfo(insertOrder1);

     }catch(Exception e){
     }
try{ 
   BLN_ASC_Utillcls.TktProfileInfo bauctktinfo1 = new BLN_ASC_Utillcls.TktProfileInfo(tktprof);
    }
    catch(Exception e){}    

try{ 
   BLN_ASC_Utillcls.TktProfileInfo bauctktinfo2 = new BLN_ASC_Utillcls.TktProfileInfo(partcpnt);
    }
    catch(Exception e){}    
    try{ 
   BLN_ASC_Utillcls.OrderInfo bauOrderInfo = new BLN_ASC_Utillcls.OrderInfo(insertOrder1);
    }
    catch(Exception e){}    
    BLN_ASC_Utillcls.PaymentInfo baupay = new BLN_ASC_Utillcls.PaymentInfo(payobj);
    BLN_ASC_Utillcls.PaymentInfo baupay1 = new BLN_ASC_Utillcls.PaymentInfo(insertOrder1,payobj);
    BLN_ASC_Utillcls.ItemInfo baupayitem = new BLN_ASC_Utillcls.ItemInfo(orderItem);
BLN_ASC_Utillcls.TicketInfo bauTicketInfo = new BLN_ASC_Utillcls.TicketInfo(ticket1);
    BLN_ASC_Utillcls.SponsorshipInfo bauspinfo = new BLN_ASC_Utillcls.SponsorshipInfo(spn1);
        BLN_ASC_Utillcls.boothInfo bufinfo = new BLN_ASC_Utillcls.boothInfo(BoothMap);
        
        
    System.debug('uuuuu'+ordersList);
       System.debug('uuuuu'+u.id);
       System.debug('uuuuu'+eventInfo.id);
     
       
        
            //bau.parseInncls(ordersList);
        
           
        }       
    
    }
}
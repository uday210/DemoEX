@istest
public class Test_BLN_LS_UpdateLead{
     static testmethod void Test_BLN_LS_UpdateLead(){
     
    globalForTestClass globalTest= new globalForTestClass();
    
   Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
         User u = new User(alias = 'Tes8t', email='testc8ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='testc8ode123x1@noemail.com');
                           
        system.runas(U){
                            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);

            system.debug('@@@tktprof'+tktprof.id);
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(u, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
          BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
                                Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            //ticket.Client_Company__c= companyInfo.id;
            update ticket;
            
            Lead_Scan__c ls=new Lead_Scan__c();
            ls.First_Name__c='testa';
            ls.Last_Name__c='testb';
            ls.Event__c=eventInfo.id;
            //ls.Scanee_User__c=gnUserInfo.id;
            ls.Scanner_Company__c=companyInfo.id;
            ls.Scanner_User__c=gnUser.id;
            ls.scan_time__c=system.today();
            ls.user_pic__c='www.testURL.com';
            ls.followup_date__c = date.today();
            
            insert ls;
            
            //List<Lead_Scan__c> lsc = new List<Lead_Scan__c>();
            //Lsc.add(ls);
            
            badge__c badge=new badge__c();
            badge.ticket_id__c=ticket.id;
            insert badge;
            
            test.startTest();
            //try{
            System.RestContext.request = new RestRequest();
            
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.httpMethod = 'POST';
            req.requestURI = '/services/apexrest/DemoUrl';
            
            //string bodys = '[{"Prefix__c" : "Mr.","followup_date__c" : "2015-09-07T17:36:00.000+0000","zip__c" : "","Rating__c" : 4,"Street2__c" : "","Scan_Time__c" : "2015-09-01T17:37:11.000+0000","Title__c" : "Deepu Title","Street1__c" : "","Event__c" : "a17M0000002BiaZIAS","state__c" : "a0zM0000006yKM3IAM","Lead_Status__c" : "","Company__c" : "Yes Email Company Private Limited","Last_Name__c" : "K Reddy","City__c" : "My city","user_pic__c" : "testimage","Scanner_Company__c" : "a0wM0000003RyqoIAC","Work_Phone__c" : "(342) 431-2432","Scanner_User__c" : "a1RM0000001gKASMA2","country__c" : "a0xM0000004KmloIAC","Scanee_User__c" : "a1RM0000001tjTSMAY","Id" : "a1ZM00000012WvTMAU","notes__c" : "rfsdafsadfdsafdsafsd","First_Name__c" : "Deepu","Suffix__c" : ""}]';
            
            
         //string bodys =  '{"LeadScan" : [{"Prefix__c" : "Mr.","zip__c" : "","Rating__c" : 0,"Street2__c" : "","Scan_Time__c" : "2015-10-09T19:10:27.000+0000","Title__c" : "Developer","Street1__c" : "Street 12,Florence","Event__c" : "a17M00000039yjHIAQ","state__c" : "a0zM0000006yKLeIAM","Lead_Status__c" : "","Company__c" : "PASS-GCA","Last_Name__c" : "DURGA PRASAD","City__c" : "Florence","user_pic__c" : "","Scanner_Company__c" : "a0wM0000003NWQUIA4","Work_Phone__c" : "(994) 829-2926","Scanner_User__c" : "a1RM0000001gKASMA2","country__c" : "a0xM0000004KmloIAC","Scanee_User__c" : "a1RM0000001iwHoMAI","Id" : "a1ZM0000001k6WTMAY","notes__c" : "Notes","First_Name__c" : "BABU","Suffix__c" : "Sr."}],"Lead_Qualifiers" : []} ';
         
        string bodys =  '{ "LeadScan" : [ { "Prefix__c" : "", "zip__c" : "", "Cell_Phone__c" : "(125) 184-6464", "Street2__c" : "sgjdhijgd", "Rating__c" : 0, "Title__c" : "", "Street1__c" : "tudgidxu", "Event__c" : "a1954000000CdIJAA0", "BLN_State__c" : "a2K54000000Cc4sEAC", "Company__c" : "ibm", "Lead_Status__c" : "", "City__c" : "dusudhcgi", "Last_Name__c" : "anil", "user_pic__c" : "kjhgjkghjkgjhkjkcghjkhghvh", "Scanner_Company__c" : "a1O54000000ClEQEA0", "BLN_TKT_profile__c" : "a2N54000000Cez6EAC", "Work_Phone__c" : "(424) 353-7535", "Scanner_User__c" : "a1c54000000CrTRAA0", "BLN_Country__c" : "a1P54000000CiVLEA0", "Id" : "a1j54000000CbmmAAC", "notes__c" : "", "First_Name__c" : "anil", "Suffix__c" : "" } ], "Lead_Qualifiers" : [ { "scannerId" : "00554000000MUcPAAW", "scanneeId" : "'+tktprof.Id+'", "questionOrder" : "1", "questionLevel" : "Lead Retrieval", "scanneAns" : "aaaaass", "questionText" : "fgjj", "eventId" : "a1954000000CdIJAA0", "answerId" : "", "question_Id" : "", "itemQuetion_Id" : "" } ] }';
        //'{"LeadScan":[{"Cell_Phone__c":"(996) 666-6665","City__c":"Florence ","Company__c":"bradit Info Tech LLC","Event__c":"a17L0000001TgzTIAS","First_Name__c":"Bradit","Home_Phone__c":"","Id":"a1ZL00000095OVxMAM","Last_Name__c":"Gry","Lead_Status__c":"","Prefix__c":"","Rating__c":"3","Scan_Time__c":"2015-10-15T19:33:00.000+0000","Scanner_User__c":"a1RL0000004GE3rMAG","Scanner_Company__c":"a0wL00000059ySkIAI","Scanner_User__c":"a1RL0000004G7y4MAC","Street1__c":"","Street2__c":"","Suffix__c":"","Title__c":"Director","Work_Phone__c":"(526) 325-4785","BLN_Country__c":"a0xL0000003lEQzIAM","followup_date__c":"2015-11-16T16:40:00","notes__c":"hhhhhhh","BLN_State__c":"a0zL0000004bjlbIAA","user_pic__c":"testpic","zip__c":""}],"Lead_Qualifiers":[{"eventId":"a17L0000001TgzTIAS","scanneeId":"';
      // bodys=bodys+tktprof.Id;
      // bodys=bodys+'","itemQuetion_Id":"a1XL00000037FT1MAM","questionOrder":"1","questionText":"how are you.?","question_Id":"a1qL0000000PWnEIAW","scannerId":"005L00000034II4IAM"},{"eventId":"a17L0000001TgzTIAS","itemQuetion_Id":"a1XL00000037FTBMA2","questionOrder":"2","questionText":"Addes new question","question_Id":"a1qL0000000PWpvIAG","scannerId":"005L00000034II4IAM"},{"eventId":"a17L0000001TgzTIAS","itemQuetion_Id":"a1XL00000037FrNMAU","questionOrder":"3","questionText":"3 q","question_Id":"a1qL0000000PXePIAW","scannerId":"005L00000034II4IAM"}]}';
       
       system.debug('@@@bodys'+bodys);    
            blob b = blob.valueOf(bodys);
            req.requestBody= b;
            
            RestContext.request = req;
            RestContext.response= res;
            
            
            BLN_ResponseMsg msg=new BLN_ResponseMsg();
            msg.ldvalueAssign('Message','You have successfully updated data !',TRUE); 
            

        User_Answer__c Uans = new User_Answer__c();
         //Uans.User__c = gnUserInfo.id;
         Uans.UAnswer_Text__c = 'Test Answer';
         Uans.UAnswer_Text_Update__c = 'Test Answer Updated';
         Uans.Ticket__c = ticket.id;
         
         Insert Uans;
         
         User_Answer__c userGiveAnswer =[select BLN_Answer__c,Item_Question__c,UAnswer_Text__c from User_Answer__c where id=:Uans.Id limit 1];
         
        BLN_LS_UpdateLead blnascitem = new BLN_LS_UpdateLead();
            
            
            
            BLN_LS_UpdateLead.cls_leadqualifier Lqfr = new BLN_LS_UpdateLead.cls_leadqualifier();
        Lqfr.eventId = 'a17L0000001TgzTIAS';
        Lqfr.questionText = 'Test Quat';
        Lqfr.scannerId = '005L00000034II4IAM';
        Lqfr.questionOrder = '1';
        Lqfr.questionLevel = 'Quation Levl';
        Lqfr.scanneeId = '005L00000034II4IAM';
        Lqfr.scanneAns = 'ScannAns';
        Lqfr.question_Id = 'a1qL0000000PWpvIAG';
        Lqfr.itemQuetion_Id = 'ItemQution Id';
        Lqfr.answerId = Uans.id;
        
        //question_Id":"a1qL0000000PWpvIAG","scannerId":"005L00000034II4IAM
            
            
            List<BLN_LS_UpdateLead.cls_leadqualifier> lqf = new List<BLN_LS_UpdateLead.cls_leadqualifier>();
            lqf.add(Lqfr);
            
            BLN_LS_UpdateLead.mainclass mncls = new BLN_LS_UpdateLead.mainclass();
            mncls.LeadScan = new List<Lead_Scan__c>{ls};
           mncls.Lead_Qualifiers = new List<BLN_LS_UpdateLead.cls_leadqualifier>{lqfr};
        
        BLN_LS_UpdateLead.leadscan LdSc = new BLN_LS_UpdateLead.leadscan();
         LdSc.fielsName = 'Test first name';
         LdSc.fieldValue = 'test Field Value';
         
         BLN_LS_UpdateLead.container Cntr = new BLN_LS_UpdateLead.container();
         Cntr.leadID = 'leadID';
         Cntr.leadpicString = 'LeadPicString'; 
         
         
         

    BLN_LS_UpdateLead.leadqalifier_res Lqfier = new BLN_LS_UpdateLead.leadqalifier_res(Uans,'testQutionId',52.26,'Test Quation','test');
    
   BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
            
              BLN_LS_UpdateLead.maincontainer mnCntner = new BLN_LS_UpdateLead.maincontainer();
                mnCntner.respMsg = new BLN_ResponseMsg();
                mnCntner.leadImageUrls = new List<BLN_LS_UpdateLead.container>{Cntr};
                mnCntner.Lead_Qualifiers_List = new list<BLN_LS_UpdateLead.leadqalifier_res>{Lqfier};
                
                
            
            BLN_LS_UpdateLead.mainClass Mncl = new BLN_LS_UpdateLead.mainClass();
            BLN_LS_UpdateLead.maincontainer mnc = new BLN_LS_UpdateLead.maincontainer();
            mnc = BLN_LS_UpdateLead.doPost();
            
            
            string bodys1 =  '{ "LeadScan" : [ { "Prefix__c" : "", "zip__c" : "", "Cell_Phone__c" : "(125) 184-6464", "Street2__c" : "sgjdhijgd", "Rating__c" : 0, "Title__c" : "", "Street1__c" : "tudgidxu", "Event__c" : "a1954000000CdIJAA0", "BLN_State__c" : "a2K54000000Cc4sEAC", "Company__c" : "ibm", "Lead_Status__c" : "", "City__c" : "dusudhcgi", "Last_Name__c" : "anil", "user_pic__c" : "", "Scanner_Company__c" : "a1O54000000ClEQEA0", "BLN_TKT_profile__c" : "a2N54000000Cez6EAC", "Work_Phone__c" : "(424) 353-7535", "Scanner_User__c" : "a1c54000000CrTRAA0", "BLN_Country__c" : "a1P54000000CiVLEA0", "Id" : "a1j54000000CbmmAAC", "notes__c" : "", "First_Name__c" : "anil", "Suffix__c" : "" } ], "Lead_Qualifiers" : [ { "scannerId" : "00554000000MUcPAAW", "scanneeId" : "'+tktprof.Id+'", "questionOrder" : "1", "questionLevel" : "Lead Retrieval", "scanneAns" : "aaaaass", "questionText" : "fgjj", "eventId" : "", "answerId" : "", "question_Id" : "a1qL0000000PWpvIAG", "itemQuetion_Id" : "a1XL00000037FT1MAM" } ] }';
            blob b1 = blob.valueOf(bodys1);
            req.requestBody= b1;
            try{
            mnc = BLN_LS_UpdateLead.doPost();
            }catch(exception ee){}
            test.StopTest();
            
        }
    }
}
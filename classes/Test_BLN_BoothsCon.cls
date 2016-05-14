@isTest
public without sharing class Test_BLN_BoothsCon{

public static testMethod void TestMethod_BLN_BoothsCon(){

     globalForTestClass globalTest= new globalForTestClass();
        Account acc= new Account(Name='Globalnestcom');
         insert acc;
    
        contact con = new contact(firstname='gne',lastname='usere',AccountId=acc.id);
        insert con;
        Profile p = [select id from profile where name='Attendee'];


         User U= new User(alias = 'gn', email='BLN_BoothsCon@noemail.com', firstname= 'fngn', Phone= '9652563232',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnusere', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest llc',
                                  timezonesidkey='America/Los_Angeles', username='BLN_BoothsCon@noemail.com', Title= 'SFDC Developer');
        database.insert(U,false);
        system.runas(u){
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
          
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
        Company__c     companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(u.Companyname);
       // GN_User__c  gnUser= new GN_User__c();
           // gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
        BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);        

         Item_Type__c itemType2= new Item_Type__c();
            itemType2= globalTest.createItemType();
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
        

             Item_Pool__c  ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType2.Id, NULL, trackInfo.id);
            
             BLN_Item__c   item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType2.Id, eventInfo.id);

            Ticket__c ticket =new Ticket__c(Event__c = eventInfo.id,Item__c = item.id ,Item_Pool__c = ItemPool.id,Item_Type__c = itemType2.id, Ticket_Status__c = 'Available');
                 insert ticket ;
             
            BLN_Room__c broom=new BLN_Room__c ();
            broom = globalTest.createRoom(eventInfo.id);     
            
         Booth_Map__c    BoothMap=new Booth_Map__c(Name = 'Public Booth',BLN_Room__c = broom.id ,Ticket_id__c = ticket.id,Booth_Size__c = '5'  );
            insert BoothMap;   
            
          Booth_Map__c    BoothMap1=new Booth_Map__c(Name = 'Public Booth',BLN_Room__c = broom.id ,Ticket_id__c = ticket.id,Booth_Size__c = '5'  );
            insert BoothMap1;   
            list<Booth_Map__c> blist = new list<Booth_Map__c>();
            blist.add(BoothMap);
            blist.add(BoothMap1);
                
Ticket__c tctn=[select Name from Ticket__c where id = : ticket.id];
BLN_Room__c  nroom=[select Name from BLN_Room__c  where id = : broom.id];
 Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(u);
            
BLN_Sponsorships__c spn1 = new BLN_Sponsorships__c(Sponsorship_Category__c='textbc',Ticket_ID__c=tctn.id,Logo_Size__c='Large');
 insert spn1;
 BLN_Sponsorships__c spn = new BLN_Sponsorships__c(Sponsorship_Category__c='textba',Ticket_ID__c=tctn.id,Logo_Size__c='Large');
 insert spn;
 BLN_Sponsorships__c spn2 = new BLN_Sponsorships__c(Sponsorship_Category__c='textb',Ticket_ID__c=tctn.id,Logo_Size__c='Large');
 insert spn2;
 
 list<BLN_Sponsorships__c> listsp= new list<BLN_Sponsorships__c>();
 listsp.add(spn1);
 listsp.add(spn);
 listsp.add(spn2);
 Document document = new Document();
document.AuthorId = UserInfo.getUserId();
document.FolderId = UserInfo.getUserId();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=tktprof.id;
        insert attach;
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:tktprof.id];
        System.assertEquals(1, attachments.size());
   

cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
BLN_BoothsCon blbooth=new BLN_BoothsCon();
blbooth.sponsorticlist=listsp;
ApexPages.currentPage().getParameters().put('nw_bsizetxtval','6');
ApexPages.currentPage().getParameters().put('row_tid4',BoothMap.id);
system.debug('@@tickename'+ApexPages.currentPage().getParameters().put('row_tid4',BoothMap.id));
blbooth.update_newboothsize();

ApexPages.currentPage().getParameters().put('newbooth','20');
ApexPages.currentPage().getParameters().put('ticketlist1',tctn.Name+','+tctn.Name);

blbooth.update_boothareas();

ApexPages.currentPage().getParameters().put('newroom',nroom.Name);
ApexPages.currentPage().getParameters().put('ticketlist',tctn.Name+','+tctn.Name);

blbooth.update_boothRooms();

ApexPages.currentPage().getParameters().put('new_bRoom',nroom.Name);
ApexPages.currentPage().getParameters().put('row_tid3',BoothMap.id);

blbooth.update_boothRoom() ;

ApexPages.currentPage().getParameters().put('new_bArea','25');
ApexPages.currentPage().getParameters().put('row_tid2',BoothMap.id);

blbooth.update_boothArea();

ApexPages.currentPage().getParameters().put('new_bNo','8');
ApexPages.currentPage().getParameters().put('row_tid1',BoothMap.id);

blbooth.update_boothNo();

ApexPages.currentPage().getParameters().put('new_bsize','9');
ApexPages.currentPage().getParameters().put('row_tid',BoothMap.id);

blbooth.update_boothsize();

blbooth.displayPermissions();
//blbooth.BoothMapListprint;
blbooth.printBooths();
apexpages.currentpage().getparameters().put('searchKey','testna');
apexpages.currentpage().getparameters().put('start','2');
apexpages.currentpage().getparameters().put('length','2');
blbooth.ExhibitorsprocessData();

apexpages.currentpage().getparameters().put('deletedIdsp','attach.id');
try{
blbooth.delattachment();
}catch(Exception e){}

apexpages.currentpage().getparameters().put('deletedId','sponsorEdit.Ticket_id__r.tkt_profile__r.id');
try{
blbooth.delattachmentsp();
}catch(Exception e){}

BLN_BoothsCon.dynamicboothsize(eventinfo.id);
BLN_BoothsCon.dynamicboothnumbers(eventinfo.id);
blbooth.closePopup();
//blbooth.AttName;
//blbooth.AttNamespon;
//blbooth.AttData;
//blbooth.iframelink;
//blbooth.iframelinkspon;
//blbooth.imageData;
BLN_BoothsCon.SubWrapper dtp= new BLN_BoothsCon.SubWrapper(BoothMap,BoothMap.id);
        blbooth.boothedit=NULL;
        blbooth.exbPic=NULL;
        blbooth.exbImageName='test';

        apexpages.currentpage().getparameters().put('editID','test');
        
        BLN_BoothsCon  blnbothcon = new BLN_BoothsCon();            
        blnbothcon.sponsorEdit= new  BLN_Sponsorships__c (); 
        string bodys = '{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
        blnbothcon.spPic= bodys;
        blnbothcon.spImageName='test';
        blnbothcon.exbPic=bodys;
        blnbothcon.selectedBoothSize='test';
        blnbothcon.BoothInformation=new LIST<SelectOption>();
        blnbothcon.exbImageName='test';
        blnbothcon.exbPic=bodys;
         blnbothcon.boothedit=new booth_map__c();          
        try{
            blnbothcon.editMethod();
            
            }
            catch(Exception e){
                
                                          
            }
                try{
                    blnbothcon.editspMethod();
                    }
                    catch(Exception e){}
                  try{
                    blnbothcon.SavespPopup();
                    }
                    catch(Exception e){}  
                    
                blnbothcon.printSponsors();
                 
            try{
                    
                    blnbothcon.SavePopup();
                    blnbothcon.closePopup();
                    blnbothcon.closePopup();
                }
                catch(Exception e){}
                
        apexpages.currentpage().getparameters().put('new_sc','test');        
        apexpages.currentpage().getparameters().put('spid','test'); 
                  
        BLN_Sponsorships__c  bsc = new  BLN_Sponsorships__c (); 
        bsc.Sponsorship_Category__c  = 'RAJ Sponsor';
        bsc.Display_Order__c = 1;
        bsc.Logo_Size__c = 'snall';
        bsc.Ticket_ID__c = ticket.id;
        insert bsc;
        
      
        
        try{
        blnbothcon.save_sponscat();
        }catch(exception e){}
      apexpages.currentpage().getparameters().put('displayOrder','test');
      try{
        blnbothcon.updateDisplayOrder();
          }catch(exception e){}
          
          BLN_Sponsorships__c  bsc1 = new  BLN_Sponsorships__c (); 
        bsc1.Sponsorship_Category__c  = 'RAJ Sponsorvvv';
        bsc1.Display_Order__c = 1;
        bsc1.Logo_Size__c = 'Medium';
        bsc1.Ticket_ID__c = ticket.id;
        insert bsc1;
        BLN_BoothsCon dcon= new BLN_BoothsCon();
         Apexpages.currentPage().getParameters().put('new_sc','trggg');
       Apexpages.currentPage().getParameters().put('spid',bsc1.id);
        dcon.save_sponscat();


}
}
}
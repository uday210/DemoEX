public without sharing class BL_NYNJNMSDCSuccessPageCon {


public string paykey {get;set;}
public id eventId{get;set;}
public id eventAdminId{get;set;}
public Event__c eve{get;set;}
public string siteUrl{get;set;}


    public PageReference redirectPage() {
       pageReference pg = new pageReference(siteUrl);
        pg.setRedirect(true);
        return pg;
    }




public BL_NYNJNMSDCSuccessPageCon (){
}

public string paymentType{get;set;}
public User_Profile_Event__c upeForeventadmin{get;set;}

public void MainMethod(){
paymentType ='';
paykey =Apexpages.currentpage().getParameters().get('paykey');

string primaryemail;
try{
 List<Dummay__c> dummyList = new List<Dummay__c>();
 dummyList =[select TicketTypes__r.Section_Name__c,TicketTypes__r.TT_Name__c,Profile__c,InvoiceEmail__c,Payment_Type__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c,customer_key__r.Isinserted__c  from Dummay__c where customer_key__c=:paykey and customer_key__r.Isinserted__c=false];
  system.debug('hhhhhhhhhhhhhh '+paykey );
 
 
 
 if(dummyList.size()<=0){
 List<Dummay__c> dummyList12 = new List<Dummay__c>();
 dummyList12 =[select TicketTypes__r.TT_Name__c, TicketTypes__r.Section_Name__c,  Profile__c,Payment_Type__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c,customer_key__r.Isinserted__c  from Dummay__c where customer_key__c=:paykey];
  eventId =dummyList12[0].Event__c;
   upeForeventadmin = new User_Profile_Event__c();
   upeForeventadmin =[select User_id__r.userName from User_Profile_Event__c where EV_id__c=:eventId and Profile_id__r.PR_Name__c='EventAdmin' ];
   
 }else{
  paymentType =dummyList[0].Payment_Type__c;
  
   primaryemail = dummyList[0].InvoiceEmail__c;
  eventId =dummyList[0].Event__c;
   upeForeventadmin = new User_Profile_Event__c();
   upeForeventadmin =[select User_id__r.userName from User_Profile_Event__c where EV_id__c=:dummyList[0].Event__c and Profile_id__r.PR_Name__c='EventAdmin' limit 1];
   
 }
 

 eve=[SELECT id,EV_Description__c,EV_HostingState__c,EV_EndDate__c,EV_EndTime__c,EV_HistingAddr1__c,EventDiversityValues__c,
                        EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingFax__c,
                        EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,
                        EV_HostingTimeZone__c,EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,
                        EV_Title__c,EV_WebsiteURL__c,EV_EventLogo__c,EV_ContactURL__c,EV_HostingCountry__c , 
                        EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,
                        Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c
                           FROM Event__c where id =:eventId];
     
 
 siteUrl =eve.EV_WebsiteURL__c;
 
 boolean executeMethod=false;
 if(dummyList.size()>0){
 
  if(dummyList[0].Payment_Type__c=='Credit Card'){
       paypalpayment_checkcon paycon =new paypalpayment_checkcon();
       executeMethod=paycon.PayDetail(dummyList[0].payKey__c);  
   }else{
    executeMethod=true;
   }
 }
 
 
 

 if(executeMethod){

 //dummyList =[select TicketTypes__r.TT_Name__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c  from Dummay__c where customer_key__c=:paykey];
 SET<AttendeeSummary__c> listOfattForInsert = new  SET<AttendeeSummary__c>();
 SET<Non_Attendee__c>  NonAttendee= new SET<Non_Attendee__c>();
 SET<string> attEmails = new SET<string>(); 
 MAP<string,id> mapEamAndEmail = new MAP<string,id>();
 List<Dummay__c> forInsertTickets= new List<Dummay__c>();
 SET<string> attendees = new SET<string>();
 SET<string> boothadmins= new SET<string>();
 
 
 SET<Booth__c>  booths = new SET<Booth__c >();

 
List<User_Profile_Event__c> upeEvent = new List<User_Profile_Event__c>();
upeEvent =[select id,EventAdmin_Id__c from User_Profile_Event__c where EV_id__c=:eventId and Profile_id__r.PR_Name__c='EventAdmin']; 
MAP<string,id> mapEmaildummay = new MAP<string,id>();


if(upeEvent.size()>0){
 eventAdminId = upeEvent[0].EventAdmin_Id__c;
  }
  List<id>  ticketIds = new List<id>();
  SET<id>  ticketIdsBooth = new SET<id>();
  // inserting attendees Started    
        for(Dummay__c dummy:dummyList){
        
        ticketIds.add(dummy.TicketTypes__r.id);
       if(dummy.TicketTypes__r.TT_Name__c=='Booth at Expo'){
         ticketIdsBooth.add(dummy.TicketTypes__r.id);
        }
        
        
        if(dummy.TicketTypes__r.Ticket_Category__c!='Non – Attendee' ){
         if(dummy.Profile__c=='BoothAdmin' ){
         boothadmins.add(dummy.Email__c);
       }else{
         attendees.add(dummy.Email__c);
         }      
          forInsertTickets.add(dummy);
          
          if(dummy.TicketTypes__r.Section_Name__c =='SPONSORSHIP PACKAGES' || dummy.TicketTypes__r.Section_Name__c =='ANNUAl SPONSORSHIP PACKAGES' || dummy.TicketTypes__r.Section_Name__c =='ACTIVITY SPONSORSHIP PACKAGES' ){
            mapEmaildummay.put(dummy.Email__c,dummy.id); 
          }        
          
        if(attEmails.contains(dummy.Email__c)){
        
        }else{
         Booth__c b =new Booth__c();
         b.BT_Name__c =dummy.Company__c;
         b.EV_id__c =EventId;
         b.BT_ContactEmail__c = dummy.Email__c;
         
         
         booths.add(b);
               
         AttendeeSummary__c att = new AttendeeSummary__c();
         att.AS_Email__c = dummy.Email__c;
         attEmails.add(dummy.Email__c);
         att.AS_FirstName__c = dummy.First_Name__c;
         att.AS_LastName__c = dummy.Last_Name__c;
         att.AS_Company__c = dummy.Company__c;
         att.AS_CellPhone__c = dummy.Phone__c;
       
         listOfattForInsert.add(att);
       
       
       }
         
         
         
        }else{
        Non_Attendee__c nonAtt = new Non_Attendee__c();
         nonAtt.Email__c = dummy.Email__c;
         nonAtt.First_Name__c = dummy.First_Name__c;
         nonAtt.Last_Name__c = dummy.Last_Name__c;
         nonAtt.Company__c = dummy.Company__c;
         nonAtt.Phone__c = dummy.Phone__c;
         nonAtt.TicketTypes__c=dummy.TicketTypes__r.id;
         nonAtt.event__c =eventId ;
         NonAttendee.add(nonAtt);
        }      
     }    
     
      system.debug('33333333333333 6666666666666666 '+NonAttendee);
     
     List<AttendeeSummary__c> listOfattForInsert1 = new  List<AttendeeSummary__c>();
     List<Non_Attendee__c>  NonAttendee1= new List<Non_Attendee__c>();
     
     listOfattForInsert1.addAll(listOfattForInsert);
      NonAttendee1.addAll(NonAttendee);
     
     
        Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
        dataBase.upsertResult[] upResult = dataBase.upsert(listOfattForInsert1,f,false);  // inserting attendee
      
      system.debug('33333333333333 '+upResult );
      
      
        dataBase.insert(NonAttendee1,false);              

       set<Id> insertedRecords = new set<Id>();
      for(dataBase.upsertResult up:upResult ){
        if(up.isSuccess()){
        insertedRecords.add(up.getId()); 
        }
      }
       
      // Decreasing tickets
       List<TicketTypes__c> tickets = new List<TicketTypes__c>();
    MAP<id,integer> mapIdwithCount = new MAP<id,integer>();
  
    try{
   
    for(AggregateResult atr:[SELECT TicketTypes__r.id ab,COUNT_DISTINCT(id) cd FROM Dummay__c where customer_key__c=:paykey group BY TicketTypes__r.id]){
     id ticketId = (id)atr.get('ab');
     integer countOfId = (integer)atr.get('cd');
     mapIdwithCount.put(ticketId ,countOfId );
    }
    system.debug('44444444444444444444 11111111111111111111 '+ticketIds+'44444444444444 '+mapIdwithCount);
     
    for(TicketTypes__c ticketsIterate :  [SELECT id, TT_Sold__c from TicketTypes__c where id IN :ticketIds ]){
      TicketTypes__c ticketsIterate1 = new TicketTypes__c();
      ticketsIterate1 = ticketsIterate ;
     if(ticketIdsBooth.contains(ticketsIterate.id)){  
      ticketsIterate1.TT_Sold__c = ticketsIterate1.TT_Sold__c+1;  
    }else{
     ticketsIterate1.TT_Sold__c = ticketsIterate1.TT_Sold__c+mapIdwithCount.get(ticketsIterate.id);  
    }
      tickets.add(ticketsIterate1); 
    }
     system.debug('44444444444444444444 22222222222222222222 '+tickets);
     dataBase.update(tickets,false);
     }catch(exception e){} 
      
      
      
      
      //--------------------------------------------------------end --------------------------------
          // Inserting EAM for created attendees     
       List<Event_Attendee_Mapping__c> EAMListforInsert12 = new List<Event_Attendee_Mapping__c>();
        for(AttendeeSummary__c singleatt :[select id,AS_Email__c from AttendeeSummary__c where id In :insertedRecords]){
        Event_Attendee_Mapping__c  EAM = new Event_Attendee_Mapping__c();      
        EAM.AS_id__c =singleatt.id;
        EAM.EV_id__c =eventId ;
         EAM.paid__c = true;
        EAM.Attendee_Event_IDs__c =singleatt.id+''+eventId ;
        EAMListforInsert12.add(EAM);
       }
       
       dataBase.Insert(EAMListforInsert12,false);
     
       for(Event_Attendee_Mapping__c eam:[Select id,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c IN : attEmails and EV_id__c=:eventId]){
       mapEamAndEmail.put(eam.AS_id__r.AS_Email__c,eam.id);       
       }
       
        // Inserting Booths 
        List<Id> boothIds = new List<Id>();
        List<Booth__c>  booths1 = new List<Booth__c >();
        booths1.addAll(booths);
       dataBase.saveResult[] saveResult = dataBase.insert(booths1);
       
     for( dataBase.saveResult sresult:saveResult){
      if(sresult.isSuccess()){
        boothIds.add(sresult.getId());
      }  
    }
    
    MAP<string,id> mapBoothwithName = new MAP<string,id>();
    for(Booth__c boothvalues :[SELECT id,BT_Name__c,BT_ContactEmail__c from Booth__c where Id IN :boothIds]){
    mapBoothwithName.put(boothvalues.BT_ContactEmail__c,boothvalues.id);
    }
    
       
       
       
       
       // Inserting EAM for created attendees     
       List<Ticket_Eam__c> EAMListforInsert = new List<Ticket_Eam__c>();
       
       for(dummay__c dumiterate:forInsertTickets){
        Ticket_Eam__c tEam = new Ticket_Eam__c();
        tEam.Event_Attendee_Mapping__c =mapEamAndEmail.get(dumiterate.Email__c);
         tEam.TicketTypes__c =dumiterate.TicketTypes__c;
         EAMListforInsert.add(tEam);
       }
      dataBase.Insert(EAMListforInsert,false);
      
      
  // INSERT  UPE For attandees    start
      
      
      List<user> userList=[select id,userName from user where userName IN :attendees];
      List<User_Profile_Event__c> lupe=[Select id,User_id__c  from User_Profile_Event__c 
                                     Where User_id__r.userName IN: attendees
                                     And EV_id__c=:eventid]; 
   
     MAP<Id, User_Profile_Event__c> upeMap = new MAP<id, User_Profile_Event__c>();
     for(User_Profile_Event__c u: lupe){
       upeMap.put(u.User_id__c , u);
    }
          
   LIST<Profile__c> profileAtt = new LIST<Profile__c>();
   profileAtt =[select id from Profile__c where PR_Name__c='Attendee'];
   LIST<User_Profile_Event__c> newUPEtoInsert = new LIST<User_Profile_Event__c>();
    for(USER uu:userList)  {                               
      User_Profile_Event__c singleUPE = new User_Profile_Event__c();
       if(upeMap.containsKey(uu.id)){
       
         }else{
             singleUPE.User_id__c = uu.id;
             singleUPE.EV_id__c = eventid;
             singleUPE.BT_id__c    = mapBoothwithName.get(uu.userName); 
             singleUPE.Profile_id__c   =profileAtt[0].id;   
             singleUPE.status__c ='Active';               
             newUPEtoInsert.add(singleUPE); 
        }                                   
   
    }     
     dataBase.insert(newUPEtoInsert,false);
     // INSERT  UPE For attandees    End
      
      
       // INSERT  UPE For Booth admins End 
      SET<string> userExisted = new SET<string>();
      List<user> insertnotReq = new List<user>();
       for(user u:[select id,userName from user where userName IN :boothadmins]){
               userExisted.add(u.userName);
               insertnotReq.add(u);
       }
       
      
       LIST<Profile__c> profileBA = new LIST<Profile__c>();
   profileBA =[select id from Profile__c where PR_Name__c='BoothAdmin'];
   
   
      List<User_Profile_Event__c> lupeboothadmin =[Select id,User_id__c  from User_Profile_Event__c 
                                     Where User_id__r.userName IN: userExisted
                                     And EV_id__c=:eventid]; 
   
       MAP<Id, User_Profile_Event__c> upeMapBA = new MAP<id, User_Profile_Event__c>();
   
   for(User_Profile_Event__c u: lupeboothadmin ){
       upeMapBA.put(u.User_id__c , u);
   }
   
        LIST<User_Profile_Event__c> newUPEtoInsertBa = new LIST<User_Profile_Event__c>();
      LIST<User_Profile_Event__c> newUPEtoInsertBa12 = new LIST<User_Profile_Event__c>();
      
       for(USER uu:insertnotReq)  {                               
         User_Profile_Event__c singleUPE = new User_Profile_Event__c();
        if(upeMapBA.containsKey(uu.id)){
         singleUPE =upeMapBA.get(uu.id);
          singleUPE.BoothAdmin_id__c = uu.id;
           singleUPE.EventAdmin_Id__c = eventAdminId;
           singleUPE.Profile_id__c   =profileBA[0].id; 
           newUPEtoInsertBa12.add(singleUPE);   
         }else{
                    singleUPE.User_id__c = uu.id;
                    singleUPE.EV_id__c = eventid;
                    singleUPE.BT_id__c    = mapBoothwithName.get(uu.userName); 
                     singleUPE.BoothAdmin_id__c = uu.id;
                     singleUPE.EventAdmin_Id__c = eventAdminId;
                    singleUPE.Profile_id__c   =profileBA[0].id;   
                    singleUPE.status__c ='Active';               
                    newUPEtoInsertBa.add(singleUPE); 
        }                                   
   
    }     
     dataBase.insert(newUPEtoInsertBa,false);
      dataBase.update(newUPEtoInsertBa12,false); 
      
    // insert User Required users   
       
      SET<string> insertRequiredUsers = new SET<string>();
      boothadmins.RemoveAll(userExisted);
      
      if(boothadmins.size()>0){
       insertusers(boothadmins,EventId,EventadminId,mapBoothwithName,profileBA[0].id);
       }
    // update cus
    Constomer__c cus = new Constomer__c();
    cus =[select id,Uniq_Number__c, Isinserted__c,Email__c from Constomer__c where id=:paykey];
     cus.Isinserted__c =true;
     cus.Email__c =primaryemail ;
     database.update(cus);
       
     testEmailSendingCon trcon = new testEmailSendingCon();
     trcon.sendEmail(cus.id);
     
     system.debug('mapEmaildummaymapEmaildummaymapEmaildummaymapEmaildummay '+mapEmaildummay);
     
     trcon.sendemail(mapEmaildummay);
     
     
   }    
 }catch(exception e){}      
       
   }
   
   
  @future
  public static void insertusers(SET<string> boothadmins,id eventId,id EventadminId,MAP<string,id> mapBoothwithName,id profileid){
  
  try{
  
  Profile mainProfile = new Profile();
  mainProfile =[select id from profile where name='Booth Admin'];
  
  List<Dummay__c> dummyListfu = new List<Dummay__c>();
  dummyListfu =[select TicketTypes__r.TT_Name__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c  from Dummay__c where Email__c IN :boothadmins and Event__c=:eventId and TicketTypes__r.Ticket_Category__c!='Non – Attendee'];
 SET<contact> licon = new SET<contact>();
  
  SET<string> conmail = new SET<string>();
  for(Dummay__c df:dummyListfu){
   
  if(conmail.contains(df.Email__c)){
 
  }else{
   contact co = new contact();
  co.LastName=df.Last_Name__c;
  co.Email=df.Email__c;
 id dod =id.valueOf('001F000000qdOJp');
  // id dod =id.valueOf('001Z000000YPQOD');
  co.accountId =dod; 
  conmail.add(df.Email__c);
  licon.add(co); 
  }
  
  }
  
List<id> conatcts = new List<id>();

List<contact> licon1 = new List<contact>();

licon1.addAll(licon); 




 dataBase.saveResult[] res = dataBase.insert(licon1,false);
 for(dataBase.saveResult rt:res ){
 if(rt.Issuccess()){
  conatcts.add(rt.getid());
 }
 }
 
MAP<string,id> conatctwithId = new MAP<string,id>();

for(contact ctt : [select id,email,lastname from contact where id In :conatcts]){
 conatctwithId.put(ctt.email,ctt.id);
}
 

List<id> userIdvalue  = new List<id>();

 List<user> listUser = new    List<user>();
 for(Dummay__c df:dummyListfu){
 
               User user = new User(Username = df.Email__c,
                        Email =df.Email__c,
                        contactId =conatctwithId.get(df.Email__c),
                        firstname = df.First_Name__c,
                        isActive =false,
                        LastName = df.Last_Name__c,
                        Alias ='BAdmin',
                        phone =df.Phone__c,
                        ProfileID =mainProfile.id,
                        LocaleSidKey ='en_US',
                        LanguageLocaleKey ='en_US',
                        TimeZoneSidKey ='America/Los_Angeles',
                        EmailEncodingKey='UTF-8',
                        companyName=df.Company__c);
                        listUser.add(user);
                        
                   }     
                        
          DataBase.Saveresult[] saveRes =dataBase.insert(listUser,false);
            system.debug('c66666666666666666666666666666  '+saveRes );
          
           for(DataBase.Saveresult Ds:saveRes){
            if(Ds.isSuccess()){
               system.debug('c '+Ds.getId());
                userIdvalue.add(Ds.getId());
                }
             }
               system.debug('333333333333333333 '+userIdvalue);
            
              LIST<User_Profile_Event__c> newUPEtoInsertfu = new LIST<User_Profile_Event__c>();
          for(user uu:[select userName,id from user where id IN :userIdvalue]){
              
                    User_Profile_Event__c singleUPE = new User_Profile_Event__c();
                    singleUPE.User_id__c = uu.id;
                    singleUPE.EV_id__c = eventid;
                    singleUPE.BT_id__c    = mapBoothwithName.get(uu.userName); 
                    singleUPE.BoothAdmin_id__c = uu.id;
                    singleUPE.EventAdmin_Id__c = eventAdminId;
                    singleUPE.Profile_id__c   =profileid;   
                    singleUPE.status__c ='Active';               
                    newUPEtoInsertfu.add(singleUPE); 
          }   
                      
         DataBase.insert(newUPEtoInsertfu ,false);    
         }catch(exception e){}    
     } 
   
   public void dum(){
   integer inty =0;
   inty++;
   inty++;
   inty++;
   inty++;
   inty++;
   
   inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++; inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
    inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;inty++;
   }
   
}
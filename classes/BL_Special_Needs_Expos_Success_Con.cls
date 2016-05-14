public without sharing class BL_Special_Needs_Expos_Success_Con {
public string paymentType{get;set;}
public User_Profile_Event__c upeForeventadmin{get;set;}
public string paykey {get;set;}
public id eventId{get;set;}
public Event__c eve{get;set;}
public string siteUrl{get;set;}
public boolean Exhibitorbool{get;set;}
public String IPNpaypalkey{get;set;}
public  MAP<string,Dummay__c> mapEmailAndTicket {get;set;}
  public PageReference redirectPage() {
  try{
       pageReference pg = new pageReference(siteUrl);
        pg.setRedirect(true);
    
       return pg; 
       }catch(exception e){}
      return null;
    }

public string type{get;set;}

public string profileValue{get;set;}
public void MainMethod(){
Exhibitorbool = false;
paymentType ='';
paykey =Apexpages.currentpage().getParameters().get('paykey');

//for trustcommerce key
String token=Apexpages.currentpage().getParameters().get('token');
String status=Apexpages.currentpage().getParameters().get('status');
if(token!=null&&status=='approved')
{
       paykey=token;
}
//


//when controlled from ipn paypal
if(IPNpaypalkey!=null)
paykey=IPNpaypalkey;
//
try{
//type=Apexpages.currentpage().getParameters().get('type');
}catch(exception ew){
//type='xyz';

}

string primaryemail;


string paymentStatus ='';
string paymentKey='';


 List<Dummay__c> dummyList = new List<Dummay__c>();
 if(token!=null)//for trust commerce
 dummyList =[select Promocode__c,Payment_Status__c,TicketTypes__r.Section_Name__c,Tickets_Quantty__c,TicketTypes__r.Type__c,TicketTypes__r.TT_Name__c,Profile__c,InvoiceEmail__c,customer_key__r.payKey__c,Payment_Type__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c,customer_key__r.Isinserted__c,Event__r.Is_MatchMaking_Event__c  from Dummay__c where customer_key__r.payKey__c=:paykey and customer_key__r.Isinserted__c=false];
 else //for paypal
 dummyList =[select Promocode__c,Payment_Status__c,TicketTypes__r.Section_Name__c,Tickets_Quantty__c,TicketTypes__r.Type__c,TicketTypes__r.TT_Name__c,Profile__c,InvoiceEmail__c,Payment_Type__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c,customer_key__r.Isinserted__c,Event__r.Is_MatchMaking_Event__c  from Dummay__c where customer_key__c=:paykey and customer_key__r.Isinserted__c=false];
 
  system.debug('hhhhhhhhhhhhhh '+paykey );
 
 
 
 if(dummyList.size()>=0){
   List<Dummay__c> dummyList12 = new List<Dummay__c>();
     if(token!=null)//for trust commerce
    dummyList12 =[select Promocode__c,Payment_Status__c,TicketTypes__r.TT_Name__c,Tickets_Quantty__c,TicketTypes__r.Type__c, TicketTypes__r.Section_Name__c,customer_key__r.payKey__c,Profile__c,Payment_Type__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c,customer_key__r.Isinserted__c,Event__r.Is_MatchMaking_Event__c  from Dummay__c where customer_key__r.payKey__c=:paykey];
    else //for paypal
    dummyList12 =[select Promocode__c,Payment_Status__c,TicketTypes__r.TT_Name__c,Tickets_Quantty__c,TicketTypes__r.Type__c, TicketTypes__r.Section_Name__c,  Profile__c,Payment_Type__c,TicketTypes__r.id,Company__c,Email__c,Event__c,First_Name__c,Last_Name__c,payKey__c,Phone__c,TicketTypes__c,TicketTypes__r.Ticket_Category__c,customer_key__r.Isinserted__c,Event__r.Is_MatchMaking_Event__c  from Dummay__c where customer_key__c=:paykey];
    eventId =dummyList12[0].Event__c;
  
   upeForeventadmin = new User_Profile_Event__c();
   upeForeventadmin =[select User_id__r.userName from User_Profile_Event__c where EV_id__c=:eventId and Profile_id__r.PR_Name__c='EventAdmin' ];
   
 }else{
  paymentType =dummyList[0].Payment_Type__c;
  paymentStatus =dummyList[0].Payment_Status__c;
  paymentKey =dummyList[0].payKey__c;
  
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
                        Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c,Is_MatchMaking_Event__c
                           FROM Event__c where id =:eventId];
     
 
 siteUrl =eve.EV_WebsiteURL__c;
 MAP<string,Event_Attendee_Mapping__c> mapEamAndEmail = new MAP<string,Event_Attendee_Mapping__c>();
 
 
 mapEmailAndTicket = new MAP<string,Dummay__c>();
 
 
  // inserting attendees Started    
  List<id>  ticketIds = new List<id>();
  SET<AttendeeSummary__c> listOfattForInsert = new  SET<AttendeeSummary__c>();
   List<Dummay__c> forInsertTickets= new List<Dummay__c>();
    SET<string> attEmails = new SET<string>(); 
     List<Booth__c>  booths = new List<Booth__c >();
     SEt<string> promocodesset = new SEt<string>();
     
     
      for(Dummay__c dummy:dummyList){
         mapEmailAndTicket.put(dummy.Email__c,dummy);
           forInsertTickets.add(dummy);
           attEmails.add(dummy.Email__c);
           ticketIds.add(dummy.TicketTypes__r.id);
           
           if(dummy.Promocode__c!=null && dummy.Promocode__c!=''){
             promocodesset.add(dummy.Promocode__c);
           }
           
         if(dummy.TicketTypes__r.Ticket_Category__c == 'Exhibitor' ||dummy.TicketTypes__r.Ticket_Category__c == 'Exhibitor Staff')
         {
          Exhibitorbool = true;
         }
         
         Booth__c b =new Booth__c();
         b.BT_Name__c =dummy.Company__c;
         b.EV_id__c =dummy.Event__c;
         b.BT_ContactEmail__c = dummy.Email__c;
         b.BT_ContactName__c =dummy.First_Name__c+' '+dummy.Last_Name__c;
         booths.add(b);
     }     
     
     system.debug('HHHHHHYYYYYYYYYYYYYYYYYYYYYYYY '+ticketIds  +'OOOOOOOOOOOOOOOOOOOOOOOOOOO '+mapEmailAndTicket );
      List<Tickets_Mapswith_Promocode__c> tmpcList = new List<Tickets_Mapswith_Promocode__c>();
      MAP<id,integer> MapIdWithTmap  = new MAP<id,integer>();
      
    
    
    try{
     for(Tickets_Mapswith_Promocode__c tmp : [select id,Tickets__c,Promocodes__r.Name,Max_number_Of_usage__c  from Tickets_Mapswith_Promocode__c where Tickets__c IN :ticketIds and Promocodes__r.Name IN :promocodesset]){
          decimal quanval = 0;
          for(Dummay__c dummy:dummyList){
           if(tmp.Tickets__c==dummy.TicketTypes__c){ 
                  if(dummy.Tickets_Quantty__c==0 || dummy.Tickets_Quantty__c==null){
                     quanval += 1   ;        
                    }else{
                       quanval +=  dummy.Tickets_Quantty__c;
                    }
              }
             } 
        
        Tickets_Mapswith_Promocode__c tmp1 = new Tickets_Mapswith_Promocode__c() ;
        tmp1 =tmp;
           tmp1.Max_number_Of_usage__c -= quanval ;
        tmpcList.add(tmp1); 
        //  MapIdWithTmap.put(tmp.Tickets__c ,quanval );  
     }
     
     
     
     
     
     
     
     if(tmpcList.size()>0){
     list<dataBase.saveResult> tyres =  dataBase.update(tmpcList,false);
     system.debug('JJJJJJJJJJJJJJJJJJJJJJJJJJ '+tyres);
     }
     
     
   }catch(exception err){}
     
     
      MAP<string,id> mapBoothwithName = new MAP<string,id>();
     Set<id> boothIds = new SET<id>();
 try{
    // inserting booths 
   
     dataBase.saveResult[] saveResult = dataBase.insert(booths);
     for( dataBase.saveResult sresult:saveResult){
      if(sresult.isSuccess()){
        boothIds.add(sresult.getId());
      }  
    }
    
   
    for(Booth__c boothvalues :[SELECT id,BT_Name__c,BT_ContactEmail__c from Booth__c where Id IN :boothIds]){
       mapBoothwithName.put(boothvalues.BT_ContactEmail__c,boothvalues.id);
    }    
 }catch(exception e){}
 

       
       
 
       for(Event_Attendee_Mapping__c eam:[Select id,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c IN : attEmails and EV_id__c=:eventId]){
       mapEamAndEmail.put(eam.AS_id__r.AS_Email__c,eam);       
       }
       
       
       
         // Inserting EAM for created attendees     
       List<Event_Attendee_Mapping__c> EAMListforInsert12 = new List<Event_Attendee_Mapping__c>();
        for(AttendeeSummary__c singleatt :[select id,AS_Email__c, customer_key__c from AttendeeSummary__c where   AS_Email__C IN :mapEmailAndTicket.keySet() and AS_Email__C NOT IN :mapEamAndEmail.keySet() ]){
        Event_Attendee_Mapping__c  EAM = new Event_Attendee_Mapping__c();      
        EAM.AS_id__c =singleatt.id;
        EAM.EV_id__c =eventId ;
        EAM.paid__c = true;
        EAM.Attendee_Event_IDs__c =singleatt.id+''+eventId ;
        EAMListforInsert12.add(EAM);
       }
       
       dataBase.Insert(EAMListforInsert12,false);
       
        for(Event_Attendee_Mapping__c eam:[Select id,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c IN : attEmails and EV_id__c=:eventId]){
       mapEamAndEmail.put(eam.AS_id__r.AS_Email__c,eam);       
       } 
       
   // Inserting EAM tickets for created attendees     
       List<Ticket_Eam__c> EAMListforInsert = new List<Ticket_Eam__c>();
       LIST<Event_Attendee_Mapping__c> eamslist  = new LIST<Event_Attendee_Mapping__c> ();
        SET<id> EAMSET = new SET<id> ();
       for(dummay__c dumiterate:forInsertTickets){
        Ticket_Eam__c tEam = new Ticket_Eam__c();
        tEam.Event_Attendee_Mapping__c =mapEamAndEmail.get(dumiterate.Email__c).id;
         tEam.TicketTypes__c =dumiterate.TicketTypes__c;
      system.debug('fffffffffffffffffff'+dumiterate.TicketTypes__c);
           
            //IF(dumiterate.TicketTypes__r.Ticket_Category__c == 'MBE' || (dumiterate.TicketTypes__r.Ticket_Category__c == 'Corporate' && dumiterate.TicketTypes__r.TT_Name__c == 'One on One Session')){              
                IF(dumiterate.TicketTypes__r.Type__c == 'Match Leads Seller'  ){
                Event_Attendee_Mapping__c ee = mapEamAndEmail.get(dumiterate.Email__c);
                ee.Boothleads_Profile__c = 'Attendee';
                EAMSET.add(ee.id);
             }     
            EAMListforInsert.add(tEam);
        }
        for(Event_Attendee_Mapping__c eam:[Select id,AS_id__r.AS_Email__c,Attendee_Types__c from Event_Attendee_Mapping__c  where id IN : EAMSET]){
                    eam.IsMatchMakingAttendee__c = TRUE;
                    eamslist.add(eam);
                }
        update eamslist;
          Constomer__c cus = new Constomer__c();
          if(token!=null)//for trust commerce
          cus =[select id,Uniq_Number__c, Isinserted__c,Email__c,Payment_Status__c,Payment_Type__c,payKey__c from Constomer__c where payKey__c=:paykey];
          else//for paypal
          cus =[select id,Uniq_Number__c, Isinserted__c,Email__c,Payment_Status__c,Payment_Type__c,payKey__c from Constomer__c where id=:paykey];
            if( cus.Isinserted__c ==false){
               dataBase.Insert(EAMListforInsert,false);
            }
 
 // decresing tickets 
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
      ticketsIterate1.TT_Sold__c = ticketsIterate1.TT_Sold__c+mapIdwithCount.get(ticketsIterate.id);  
      tickets.add(ticketsIterate1); 
    }
     system.debug('44444444444444444444 22222222222222222222 '+tickets);
     dataBase.update(tickets,false);
     }catch(exception e){} 
      
        SET<string> nouserRecords =new  SET<string>();  
      
      
    // Inserting UPES
   try{ 
    List<user> userList=[select id,userName from user where userName IN :attEmails];
     for(user upt :userList){
     nouserRecords.add(upt.username); 
     }
    system.debug('ZZZZZZZZZZZZZZZZZZZZZZZZ '+mapEmailAndTicket );
    
     MAP<string,Dummay__c> mapEmailAndTicket12 = new MAP<string,Dummay__c>();
     mapEmailAndTicket12 = mapEmailAndTicket;
    
    
    if(eve.Is_MatchMaking_Event__c==true){ 
      insertFreshUsers(nouserRecords,mapEmailAndTicket,mapBoothwithName );
    }
    
    
    system.debug('BBBBBBBBBBBBBBBBBBBB '+mapEmailAndTicket12);
     
   List<User_Profile_Event__c> lupe=[Select id,User_id__c  from User_Profile_Event__c 
                                     Where User_id__r.userName IN: attEmails
                                     And EV_id__c=:eventid]; 
   
   MAP<Id, User_Profile_Event__c> upeMap = new MAP<id, User_Profile_Event__c>();
     
   
   for(User_Profile_Event__c u: lupe){
       upeMap.put(u.User_id__c , u);
   }
   
   LIST<Profile__c> profileAtt = new LIST<Profile__c>();
   profileAtt =[select id from Profile__c where PR_Name__c='Attendee'];
   LIST<User_Profile_Event__c> newUPEtoInsert = new LIST<User_Profile_Event__c>();
   LIST<User_Profile_Event__c> toUpdateMatchleads= new LIST<User_Profile_Event__c>();
   
   
   
   
   
    for(USER uu:userList)  {                               
        
        User_Profile_Event__c singleUPE = new User_Profile_Event__c();
        
        if(upeMap.containsKey(uu.id)){
        try{
                  if(eve.Is_MatchMaking_Event__c ==true){  
                     User_Profile_Event__c upemm = new User_Profile_Event__c();  
                      upemm = upeMap.get(uu.id);
                
                      Dummay__c dum4 = new Dummay__c();
                      dum4=mapEmailAndTicket.get(uu.UserNAme);
                      if((dum4.TicketTypes__r.Ticket_Category__c=='Corporate' || dum4.TicketTypes__r.Ticket_Category__c=='BoothAdmin' ||  dum4.TicketTypes__r.Type__c == 'Match Leads Buyer')&& (dum4.TicketTypes__r.Type__c != 'Match Leads Seller')){
                        upemm.MAtchMakingProfile__c ='Corporate';
                      }else if(dum4.TicketTypes__r.Ticket_Category__c=='SPONSOR'){
                         upemm.MAtchMakingProfile__c ='SPONSOR';
                      } 
                       else if(dum4.TicketTypes__r.Ticket_Category__c=='Prime Partner'){
                       LIST<Profile__c> profileAtt1 = new LIST<Profile__c>();
                       profileAtt1 =[select id from Profile__c where PR_Name__c='CorporateStaff'];
                         singleUPE.MAtchMakingProfile__c ='CorporateStaff';
                         singleUPE.Profile_id__c   =profileAtt1[0].id;
                      }
                        //if((dum4.TicketTypes__r.Ticket_Category__c=='Corporate'&& dum4.TicketTypes__r.TT_Name__c == 'One on One Session') || dum4.TicketTypes__r.Ticket_Category__c=='MBE' ){
                        IF(dum4.TicketTypes__r.Type__c == 'Match Leads Buyer' || dum4.TicketTypes__r.Type__c == 'Match Leads Seller'  ){
                        upemm.IsMatchMakingUser__c=true;
                        }
                        upemm.IsMatchMakingUser__c=true;
                        toUpdateMatchleads.add(upemm);
                }
          }catch(exception br){}
          
        }else{
                    singleUPE.User_id__c = uu.id;
                    singleUPE.EV_id__c = eventid;
                    singleUPE.BT_id__c  = mapBoothwithName.get(uu.userName); 
                   
                      
                    singleUPE.status__c ='Active';
                    try{  
                     if(eve.Is_MatchMaking_Event__c ==true){ 
                      
                      Dummay__c dum3 = new Dummay__c();
                      dum3=mapEmailAndTicket.get(uu.UserNAme);
                      if((dum3.TicketTypes__r.Ticket_Category__c=='Corporate' || dum3.TicketTypes__r.Ticket_Category__c=='BoothAdmin' || dum3.TicketTypes__r.Ticket_Category__c=='Exhibitor' ||  dum3.TicketTypes__r.Type__c == 'Match Leads Buyer') && (dum3.TicketTypes__r.Type__c != 'Match Leads Seller') ){
                           singleUPE.MAtchMakingProfile__c ='Corporate';
                            singleUPE.Profile_id__c   =profileAtt[0].id; 
                          
                      } else if(dum3.TicketTypes__r.Ticket_Category__c=='SPONSOR'){
                         singleUPE.MAtchMakingProfile__c ='SPONSOR';
                          singleUPE.Profile_id__c   =profileAtt[0].id; 
                      }
                      else if(dum3.TicketTypes__r.Ticket_Category__c=='Prime Partner'){
                      
                      LIST<Profile__c> profileAtt1 = new LIST<Profile__c>();
                       profileAtt1 =[select id from Profile__c where PR_Name__c='CorporateStaff'];
                         singleUPE.MAtchMakingProfile__c ='CorporateStaff';
                         singleUPE.Profile_id__c   =profileAtt1[0].id;
                         
                      }
                        singleUPE.BoothAdmin_id__c = uu.id;
                        // if((dum3.TicketTypes__r.Ticket_Category__c=='Corporate'&& dum3.TicketTypes__r.TT_Name__c == 'One on One Session') || dum3.TicketTypes__r.Ticket_Category__c=='MBE' ){
                       IF(dum3.TicketTypes__r.Type__c == 'Match Leads Buyer' || dum3.TicketTypes__r.Type__c == 'Match Leads Seller'  ){
                        singleUPE.IsMatchMakingUser__c=true;
                        }
                     }  }catch(exception fr){}          
                    newUPEtoInsert.add(singleUPE); 
              }                                   
   
    }     
     dataBase.insert(newUPEtoInsert,false);
     system.debug('GGGGGGGGGGGGGGGGGGGGGGGGGGGGGG '+toUpdateMatchleads);
     if(toUpdateMatchleads.size()>0){
        dataBase.update(toUpdateMatchleads,false);
     }
    
    
    
   }
   catch(exception e){}   
      
 // 
    
     if(cus.isinserted__c == false){
       User_Profile_Event__c uprd =[select id,User_id__c from User_Profile_Event__c  where EV_id__c=:eventId and Profile_id__r.PR_Name__c='EventAdmin' limit 1];
     
        // if(type !='EventAdmin'){
              if(eve.id !='a00F000000BKxqI'){
                 SendEmailAfterReg_SucessCon  trcon = new SendEmailAfterReg_SucessCon ();
                 trcon.sendEmail(cus.id);
               }
         //   } 
      }
         
     cus.Isinserted__c =true;
     cus.Email__c =primaryemail ;
    /* cus.Payment_Type__c =paymentType;
     cus.payKey__c =paymentKey;*/
      cus.Payment_Status__c='Paid';
     system.debug('ZZZZZZZZZZZZZZZZZZ '+cus);
     database.update(cus);
 }
 
    public void insertFreshUsers(SET<string> usersL,MAP<string,Dummay__c> dummyForusers, MAP<string,id> forBooths ){
      
      SET<string> dumstoRemoveDuplicate1 = new  SET<string>();
     
       SET<string> dumstoRemoveDuplicate = new  SET<string>();
         dumstoRemoveDuplicate1 = dummyForusers.keySet();
         
         for(string dfe : dumstoRemoveDuplicate1 ){
           if(usersL.contains(dfe)){
          
           }else{
             dumstoRemoveDuplicate.add(dfe);
           }
         }
         
         
         
         
        // dumstoRemoveDuplicate.removeAll(usersL1);
         
          system.debug('******************  '+dummyForusers);
       
        List<contact> licon = new List<Contact>();
        
        for(string ut:dumstoRemoveDuplicate){
          Dummay__c df = new Dummay__c();
          df = dummyForusers.get(ut);
          contact co = new contact();
          co.LastName=df.Last_Name__c;
          co.Email=df.Email__c;
           id dod =id.valueOf('001F000000qdOJp');
           //id dod =id.valueOf('001Z000000mP1C8');
           co.accountId =dod; 
           licon.add(co);
        }
        
        dataBase.saveResult[] res = dataBase.insert(licon,false);
        List<Id> conatcts = new List<Id>();
          for(dataBase.saveResult rt:res ){
             if(rt.Issuccess()){
             conatcts.add(rt.getid());
          }
       }
 
     MAP<string,id> conatctwithId = new MAP<string,id>();

    for(contact ctt : [select id,email,lastname from contact where id In :conatcts]){
      conatctwithId.put(ctt.email,ctt.id);
     }
     
      List<user> listUser = new List<user>();
     
      profile pa=[select id from Profile where Name='Attendee'];
         profile  pb=[select id from Profile where Name='Booth Admin'];
         
          MAP<string,Id> profiles = new MAP<string,Id>();
            for(Profile__c pro:[select id,PR_Name__c from Profile__c]){
                profiles.put(pro.PR_Name__c,pro.id); 
            }
         for(string ut:dumstoRemoveDuplicate){
          Dummay__c df1 = new Dummay__c();
             df1 = dummyForusers.get(ut);
          
                       User user = new User();
                        user.Username = df1.Email__c;
                        user.Email =df1.Email__c;
                        user.contactId =conatctwithId.get(df1.Email__c);
                        user.firstname = df1.First_Name__c;
                        user.isActive =true;
                        user.LastName = df1.Last_Name__c;
                        user.Alias ='BAdmin';
                        user.phone =df1.Phone__c;
                        if((df1.TicketTypes__r.Ticket_Category__c == 'Exhibitor' || df1.TicketTypes__r.Ticket_Category__c == 'Corporate' || df1.TicketTypes__r.Ticket_Category__c == 'Sponsor' || df1.TicketTypes__r.Type__c == 'Match Leads Buyer')&&(df1.TicketTypes__r.Type__c == 'Match Leads Seller')){
                          user.ProfileID =pb.id;
                        }else{
                        user.ProfileID =pa.id;
                        }
                        user.LocaleSidKey ='en_US';
                        user.LanguageLocaleKey ='en_US';
                        user.TimeZoneSidKey ='America/Los_Angeles';
                        user.EmailEncodingKey='UTF-8';
                        user.companyName=df1.Company__c;
                        listUser.add(user);
        }
        
         DataBase.Saveresult[] saveUserRes =dataBase.insert(listUser,false);
         system.debug('c66666666666666666666666666666  '+saveUserRes );
          system.debug('NNNNNNNNNNNNNNNNNN S '+dummyForusers  );  
          
          
         SET<Id> userIdvalue = new SET<Id>();
         
            for(DataBase.Saveresult Ds:saveUserRes ){
            if(Ds.isSuccess()){
               system.debug('c '+Ds.getId());
                userIdvalue.add(Ds.getId());
                }
             }
               system.debug('333333333333333333 '+userIdvalue);
                system.debug('TTTTTTTTTTTTTTTTTT S '+dummyForusers  );    
         LIST<User_Profile_Event__c> newUPEtoInsertfu = new LIST<User_Profile_Event__c>();
          
          
          
             for(user uu:[select userName,id from user where id IN :userIdvalue]){
                     Dummay__c df2 = new Dummay__c();
                      df2 = dummyForusers.get(uu.userName);
              
                    User_Profile_Event__c singleUPE = new User_Profile_Event__c();
                    singleUPE.User_id__c = uu.id;
                    singleUPE.EV_id__c = eve.id;
                    singleUPE.BT_id__c = forBooths.get(uu.userName); 
                    singleUPE.BoothAdmin_id__c = uu.id;
                    //singleUPE.EventAdmin_Id__c = eventAdminId;
                    
                        
                   
                        if(df2.Event__r.Is_MatchMaking_Event__c==true){
                            if((df2.TicketTypes__r.Ticket_Category__c == 'Exhibitor' || df2.TicketTypes__r.Ticket_Category__c == 'Corporate'|| df2.TicketTypes__r.Type__c == 'Match Leads Buyer')&& (df2.TicketTypes__r.Type__c != 'Match Leads Seller')){
                               singleUPE.MAtchMakingProfile__c ='Corporate';
                               singleUPE.Profile_id__c=profiles.get('BoothAdmin');
                             }else if(df2.TicketTypes__r.Ticket_Category__c =='Sponsor'){
                               singleUPE.MAtchMakingProfile__c ='Sponsor';
                               singleUPE.Profile_id__c=profiles.get('Sponsor');
                             }else if(df2.TicketTypes__r.Ticket_Category__c =='Prime Partner'){
                              singleUPE.MAtchMakingProfile__c ='CorporateStaff';
                              singleUPE.Profile_id__c   =profiles.get('CorporateStaff');
                             }else{
                                 singleUPE.MAtchMakingProfile__c ='Mbe';
                                 singleUPE.Profile_id__c=profiles.get('Attendee');
                             }
                             
                             
                             
                             //if((df2.TicketTypes__r.Ticket_Category__c == 'Corporate' && df2.TicketTypes__r.TT_Name__c == 'One on One Session') || df2.TicketTypes__r.Ticket_Category__c == 'MBE' ){
                               IF(df2.TicketTypes__r.Type__c == 'Match Leads Buyer' || df2.TicketTypes__r.Type__c == 'Match Leads Seller'  ){
                                  singleUPE.IsMatchMakingUser__c=true;
                              }
                              system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+singleUPE);
                            
                        }else{
                        
                         if((df2.TicketTypes__r.Ticket_Category__c == 'Exhibitor' || df2.TicketTypes__r.Ticket_Category__c == 'Corporate' || df2.TicketTypes__r.Type__c == 'Match Leads Buyer')&&(df2.TicketTypes__r.Type__c == 'Match Leads Seller')){
                             singleUPE.Profile_id__c=profiles.get('BoothAdmin');
                          }else if(df2.TicketTypes__r.Ticket_Category__c == 'Sponsor'){
                           singleUPE.Profile_id__c=profiles.get('Sponsor');
                          }else{
                            singleUPE.Profile_id__c=profiles.get('Attendee');
                          }
                         
                        }
                    
                    
                    
                    singleUPE.status__c ='Active';               
                    newUPEtoInsertfu.add(singleUPE); 
          }   
             system.debug('BBDDDDDDDDDDDDDDDD S '+dummyForusers  );          
         DataBase.insert(newUPEtoInsertfu ,false); 
         
       
 
    }
 
 

}
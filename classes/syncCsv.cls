@RestResource(urlMapping='/SyncCsv/*')

global without sharing class syncCsv{

    @httpPost
    global static totalTrasactioninfo parseJSONString(){
 
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    string eventId=req.params.get('eventId');
    Blob reqbody =req.requestBody;
    string jsonStr = reqbody.toString();
    system.debug('GGGGGGGGGGGGGGGGGG '+eventId);
    system.debug('JJJJJJJJJJJJJJJJJJ '+jsonStr);
    //String jsonStr = '{"AttendeeInfo":[{""fname":"Sak","lname":"Mahesh","email":"sakmahesh3@globalnest.com","wphone":"(228) 555-8007","company":"globalnest","state":"NJ","designation":"Developer","waddress":"patrikaNagar","city":"Hyderabad","zip":"07751","lineItems":[{"UnitPrice":1.0,"Quantity":5,"TicketType":"Paid","totalQuantity":50,"ProductName":"Pencil","PaymentStatus":"Paid","PaymentType":"Check","seatnumbers":"a1,a2"},{"UnitPrice":1.0,"Quantity":1,"TicketType":"Free","ProductName":"Eraser","totalQuantity":50,"PaymentStatus":"Not Paid","PaymentType":"Cash","seatnumbers":"a1,a2"}]}]}';
    
    List<AttendeeInfo> invArry= new List<AttendeeInfo>();
    Tickets ticketArry= new Tickets();
    LIST<TicketTypes__c> TicketNamesList= new LIST<TicketTypes__c>();
    MAP<String, TicketTypes__c> TicketNamesListMAP= new MAP<String, TicketTypes__c>();
    MAP<String, Decimal> ticketsToDecrease= new MAP<String, Decimal>();
    MAP<String, Decimal> toIncreaseTicketQuantity= new MAP<String, Decimal>();
    MAP<String, TicketTypes__c> InsertTicketsMAP= new MAP<String, TicketTypes__c>();  
       
    TicketNamesList=[SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Available__c, TT_TicketType__c, Available__c, TT_Sold__c FROM TicketTypes__c WHERE EV_id__c =: eventId];
    for(TicketTypes__c tic: TicketNamesList){   
        TicketNamesListMAP.put(tic.TT_Name__c.toLowerCase(), tic);
    }


    // Parse entire JSON response. 
    
    JSONParser parser = JSON.createParser(jsonStr);
    while(parser.nextToken() != null){
        // Start at the array of invoices. 
    
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null){

                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {

                    AttendeeInfo inv = (AttendeeInfo)parser.readValueAs(AttendeeInfo.class);
                    invArry.add(inv);
                    system.debug('Invoice number: ' + inv);
                     for(Tickets tic: inv.lineItems){
                        system.debug(' SINGLE TICKET  '+tic.productName);
                        
                        if(toIncreaseTicketQuantity.containsKey(tic.productName.toLowerCase())){
                            Decimal ticketQuantity= toIncreaseTicketQuantity.get(tic.productName.toLowerCase());
                            ticketQuantity= ticketQuantity+ tic.quantity;
                            toIncreaseTicketQuantity.put(tic.productName.toLowerCase(), ticketQuantity);                        
                        }else{
                            toIncreaseTicketQuantity.put(tic.productName.toLowerCase(), tic.quantity);                                                
                        }
                         if(TicketNamesListMAP.get(tic.productName.toLowerCase()) == NULL){
                
                            TicketTypes__c insertTicket= new TicketTypes__c();
                            insertTicket.TT_Name__c = tic.productName;
                            insertTicket.EV_id__c = eventId;    
                            insertTicket.TT_Amount__c= tic.unitPrice;
                            insertTicket.TT_Available__c= tic.totalQuantity;
                            insertTicket.TT_TicketType__c= tic.TicketType;
                            insertTicket.TT_Sold__c= 0;
                                                                                    
                            InsertTicketsMAP.put(tic.productName, insertTicket);
                            
                        }  
                    }
                    String s = JSON.serialize(inv);
                    system.debug('Serialized invoice: ' + s);

                    parser.skipChildren();
                }
            }
        }
    }  

    List<AttendeeSummary__c> attsumList = new List<AttendeeSummary__c>(); // list for inserting attendees
    List<Constomer__c> cusinsert = new List<Constomer__c>();
    List<Dummay__c> dumList = new List<Dummay__c>();
    List<Event_Attendee_Mapping__c> eamList = new List<Event_Attendee_Mapping__c>();
     
    SET<id> toGetCus = new SET<Id>(); 
    SET<string> emailset = new SET<string>(); // to check email Duplicate
    SET<id> ticketIds = new SEt<Id>(); // Ticket ids 
    MAP<String, String> AttendeeCategoryMAP= new MAP<String, String>();
    
    // INSERTING NEW TICKETS
    LIST<TicketTypes__c> insertTicketTypes= new LIST<TicketTypes__c>();
    for(TicketTypes__c ticket: InsertTicketsMAP.values()){
       if(ticket.TT_Available__c < toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase())){
           ticket.TT_Available__c= toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase());
           insertTicketTypes.add(ticket);
       }else{
           insertTicketTypes.add(ticket);
       }
    
    }
    Database.SaveResult[] InsertedTicketsResult= Database.Insert(insertTicketTypes);
    system.debug('  TICKETS INSERTED OR NOT   '+InsertedTicketsResult);
    
    //UPDATING EXISTING TICKETS   
    LIST<TicketTypes__c> updateTicketTypes= new LIST<TicketTypes__c>();
    for(TicketTypes__c ticket: TicketNamesListMAP.values()){
       if(ticket.Available__c < toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase())){
           ticket.TT_Available__c= ticket.TT_Sold__c+ toIncreaseTicketQuantity.get(ticket.TT_Name__c.toLowerCase());
           updateTicketTypes.add(ticket);
       }else{
           updateTicketTypes.add(ticket);
       }
    
    }
    Database.SaveResult[] UpdatedTicketsResult= Database.Update(updateTicketTypes);
    system.debug('  TICKETS UPDATED OR NOT   '+UpdatedTicketsResult);       
       
    integer i=0;  
    
    TicketNamesList=[SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Available__c, TT_TicketType__c FROM TicketTypes__c WHERE EV_id__c =: eventId AND Available__c > 0];
    for(TicketTypes__c tic: TicketNamesList){   
       TicketNamesListMAP.put(tic.TT_Name__c.toLowerCase(), tic);
    }
    MAP<String, AttendeeSummary__c> attsumListMAP= new MAP<String, AttendeeSummary__c>();
    for(AttendeeInfo att:invArry){
        string cusName = 'Uniq'+string.valueOf(i);

        i++;
        system.debug('$$$ '+att.email);
        
        AttendeeSummary__c attsum = new AttendeeSummary__c();
        attsum.AS_FirstName__c =att.fname;
        attsum.AS_LastName__c =att.lname;
        attsum.AS_Email__c =att.email;
        attsum.AS_company__c = att.company;
        attsum.AS_Title__c=att.designation;
        attsum.AS_Work_Country__c='United States Of America';
        attsum.AS_WorkAddress1__c=att.waddress;
        attsum.AS_WorkCity__c=att.city;
        attsum.AS_WorkZip__c=att.zip;
        attsum.AS_WorkPhone__c=att.wphone;
        AttendeeCategoryMAP.put(att.email, att.AttendeeCategory);
        
        Commanforstates  con = new Commanforstates ();
        attsum.AS_Work_States__c=  con.longToShortConversion(att.state);
        //attsumList.add(attsum);
        attsumListMAP.put(attsum.AS_Email__c.toLowerCase(), attsum);
        
        if(emailset.contains(att.email)){
        
        }else{            
            emailset.add(att.email);            
            Constomer__c cus  = new Constomer__c();
            cus.Email__c= att.email;
            cus.Customer_Name__c= att.fname+' '+att.lname;
            cus.Uniq_Number__c = cusName;
            cus.Isinserted__c = true;
            cusinsert.add(cus);
        }

      system.debug(att.lineItems.size()+'  GGGGGGGGGGGG '+att.lineItems);
      
        for(Tickets ti: att.lineItems){
            system.debug(ti.unitPrice+'  TICKET '+ti.quantity+'  '+ti.productName);
            Dummay__c dum = new Dummay__c();
            dum.First_Name__c=att.fname;
            dum.Last_Name__c=att.lname;
            dum.Email__c=att.email;
            dum.Event__c=eventId;
            dum.temp__c= att.email;
            dum.temp2__c =cusName;
            dum.Tickets_Quantty__c=ti.quantity;
            if(TicketNamesListMAP.get(ti.productName.toLowerCase()) != NULL){
                dum.TicketTypes__c= TicketNamesListMAP.get(ti.productName.toLowerCase()).id;
                dum.TicketAmount__c=ti.quantity*ti.unitPrice;
            }else{
                dum.TicketTypes__c= TicketNamesListMAP.get('guest').id;
                dum.TicketAmount__c= 0;
            }
            
             system.debug('111111111111111111111 '+dum);
            dum.temp3__c=ti.productName;
            try{

            }
            catch(exception e){}
            dum.Seat_Number__c=ti.seatnumbers;
            dum.Payment_Status__c=ti.PaymentStatus;
            dum.Payment_Type__c=ti.PaymentType;
            system.debug(' REG INFO SINGLE '+dum);
            dumList.add(dum);
        }
    }
            system.debug(' REG INFO LIST  '+dumList);
            
    Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
    dataBase.upsertResult[] upResult = dataBase.upsert(attsumListMAP.values(),f,false);  // Inserting Attendees
     system.debug('111111111111111111111 '+upResult );
       SET<Id> attIds = new SET<Id>();
        for(dataBase.upsertResult ures :upResult  ){
          if(ures.isSuccess()){
              attIds.add(ures.getId());
          }
        }
     LIST<AttendeeSummary__c> AttList= new LIST<AttendeeSummary__c>();
     AttList= [SELECT ID, AS_Email__c, (SELECT ID, GuestType__c, IsCancelled__c FROM Event_Attendee_Mapping__r WHERE EV_id__c =: EventId) FROM AttendeeSummary__c WHERE ID IN : attIds];
     LIST<Event_Attendee_Mapping__c> eamListToUpdate= new LIST<Event_Attendee_Mapping__c>();     
     if(AttList.size() >0){
         for(AttendeeSummary__c att: AttList){
             LIST<Event_Attendee_Mapping__c> eamListForAtt= new LIST<Event_Attendee_Mapping__c>();
             eamListForAtt= att.Event_Attendee_Mapping__r;
             if(eamListForAtt.size() ==0){
                 Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
                 eam.AS_id__c =att.Id;
                 eam.EV_id__c = eventId;
                 eam.Attendee_Event_IDs__c =att.Id+'-'+eventId;
                 if(AttendeeCategoryMAP.containsKey(att.AS_Email__c)){
                     if(AttendeeCategoryMAP.get(att.AS_Email__c) != NULL){
                         eam.GuestType__c= AttendeeCategoryMAP.get(att.AS_Email__c);                    
                     }else{
                         eam.GuestType__c= 'Attendee';                                    
                     }
                 }    
                 eamList.add(eam);            
            }else{
                eamListForAtt[0].IsCancelled__c= FALSE;
                if(AttendeeCategoryMAP.get(att.AS_Email__c) != NULL){
                    eamListForAtt[0].GuestType__c= AttendeeCategoryMAP.get(att.AS_Email__c);                    
                }else{
                    eamListForAtt[0].GuestType__c= 'Attendee';                                    
                }
                eamListToUpdate.add(eamListForAtt[0]);
            }

         }
     }
                
    // Inserting EAM  
    dataBase.saveResult[] saveEamList = dataBase.insert(eamList,false);
    Database.Update(eamListToUpdate, FALSE); 
      system.debug('22222222222222 '+saveEamList );
    MAP<String, Event_Attendee_Mapping__c> EAMListMAP= new MAP<String, Event_Attendee_Mapping__c>();
    for(Event_Attendee_Mapping__c  EamsforMAp : [SELECT id,AS_Id__r.AS_Email__c from Event_Attendee_Mapping__c where AS_Id__r.AS_Email__c IN :emailset and EV_id__c=:eventId]){
        EAMListMAP.put(EamsforMAp.AS_Id__r.AS_Email__c,EamsforMAp);
    } 
    
    // Inserting payment Info object  
    dataBase.saveResult[] cusResult = dataBase.insert(cusinsert,false); 
    system.debug('3333333333333333333333333333 '+cusResult );
    
    for(dataBase.saveResult savecusres : cusResult ){
        if(savecusres.isSuccess()){
            toGetCus.add(savecusres.getId()); 
        }
    }
    MAP<String, String> CustomerKeyMAP= new MAP<String, String>();    
    for(Constomer__c  cu:[select id,Uniq_Number__c, Email__c, name from Constomer__c   where Id IN :toGetCus]){
        CustomerKeyMAP.put(cu.Email__c, cu.id);
        
    }
       

    List<Dummay__c> insertDummy = new List<Dummay__c>();
    
    for(Dummay__c  dup: dumList){
        dup.Event_Attendee_Mapping__c= EAMListMAP.get(dup.Email__c).Id;
        dup.AttendeeSummary__c= EAMListMAP.get(dup.Email__c).AS_Id__c;
        dup.customer_key__c =CustomerKeyMAP.get(dup.Email__c);
        insertDummy.add(dup);
    }
    system.debug(insertDummy.size()+'  INSERT DUMMY '+insertDummy);
   dataBase.saveResult[] dummyRes = dataBase.insert(insertDummy,false);
    system.debug(dummyRes.size()+'   $$$$$$$$$$$$$$$$$$$ '+dummyRes );
    SET<id> insertedDums= new SET<id>();
    
       for(dataBase.saveResult dunres:dummyRes ){
            if(dunres.isSuccess()){
              insertedDums.add(dunres.getId()); 
           }
       }
    
    LIST<Dummay__c> RegInfoList= new LIST<Dummay__c>();
    RegInfoList=[SELECT ID, Tickets_Quantty__c, Available_Quantity__c, TicketTypes__r.id FROM Dummay__c WHERE ID IN: insertedDums];
    
    if(RegInfoList.size() >0){
        for(Dummay__c dum: RegInfoList){
            if(ticketsToDecrease.containsKey(dum.TicketTypes__r.id)){
                Decimal countToIncrease= ticketsToDecrease.get(dum.TicketTypes__r.id);
                countToIncrease= countToIncrease+ dum.Tickets_Quantty__c;
                ticketsToDecrease.put(dum.TicketTypes__r.id, countToIncrease);
            }else if(! ticketsToDecrease.containsKey(dum.TicketTypes__r.id)){
                ticketsToDecrease.put(dum.TicketTypes__r.id, dum.Tickets_Quantty__c);             
            } 
        }
    }
    
            system.debug(ticketsToDecrease.size()+'  DECRESSE '+ticketsToDecrease);
           
           
              
    LIST<TicketTypes__c> TicketsList= new LIST<TicketTypes__c>();
    LIST<TicketTypes__c> updateTicketsList= new LIST<TicketTypes__c>();
    TicketsList=[SELECT Id,TT_Sold__c, TT_Name__c,EV_id__c,TT_Amount__c,TT_Available__c, TT_TicketType__c FROM TicketTypes__c WHERE EV_id__c =: eventId AND ID IN: ticketsToDecrease.keyset()];
    for(TicketTypes__c tic: TicketsList){
        ticketIds.add(tic.id);
        tic.TT_Sold__c= tic.TT_Sold__c+ ticketsToDecrease.get(tic.Id);
        updateTicketsList.add(tic);
    }
    Database.update(updateTicketsList, FALSE);
    
     List<ticketInformation> ticinfovalues = new List<ticketInformation>();
    
    for(TicketTypes__c existing : [SELECT id,TT_Name__c,Available__c,TT_Amount__c,TT_TicketType__c,TT_Sold__c,TT_Available__c from TicketTypes__c where Id IN :ticketIds]){
        ticinfovalues.add(new ticketInformation(existing));
    }
    
    MAP<id,List<individualTicketInfo>> mapIndWithTic= new MAP<id,List<individualTicketInfo>>(); //  for Individual ticket Info
    
    List<Individual_Ticket_Info__c> inIndividual = new List<Individual_Ticket_Info__c>([select id,IsCheckedIn__c,Registration_Info__c,Seat__c,Name,CreatedDate from Individual_Ticket_Info__c where Registration_Info__c IN :insertedDums]);
    
    for(Id resIds :insertedDums){
        List<individualTicketInfo> indList = new List<individualTicketInfo>();
        for(Individual_Ticket_Info__c ind :inIndividual  ){
            if(resIds ==ind.Registration_Info__c){
                indList.add(new individualTicketInfo(ind));
            }
        }
        mapIndWithTic.put(resIds,indList);
    }
    
    system.debug(attIds +'******************** '+mapIndWithTic);
  
    List<Dummay__c> dumsforResponse = new List<Dummay__c>([SELECT Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c, Event_Attendee_Mapping__r.GuestType__c, Event_Attendee_Mapping__r.EA_AttendeeBarcode__c, Event_Attendee_Mapping__r.AS_id__c, id,First_Name__c,Last_Name__c,Email__c,Tickets_Quantty__c,TicketAmount__c,TicketTypes__r.Available__c,TicketTypes__r.TT_Sold__c,TicketTypes__r.TT_Name__c,TicketTypes__r.TT_Amount__c,TicketTypes__c,Payment_Status__c,Payment_Type__c,customer_key__r.Name from Dummay__c where Id IN :insertedDums]);
    List<attendeeInformation> mapDummmywithAttendee= new List<attendeeInformation>();
    
    for(AttendeeSummary__c attid : [select id,AS_FirstName__c,AS_LastName__c,AS_Email__c,AS_Title__c,AS_company__c,AS_WorkPhone__c,AS_WorkAddress1__c,AS_WorkCity__c,AS_Work_States__c,AS_WorkZip__c from AttendeeSummary__c where Id IN :attIds ]){
        List<registrationInformation> reginforval= new List<registrationInformation>();
        String AttCategory='';
        String AttQrCode= '';

        for(Dummay__c dfre : dumsforResponse ){
            if(attid.id==dfre.Event_Attendee_Mapping__r.AS_id__c){
                reginforval.add(new registrationInformation(dfre,mapIndWithTic.get(dfre.id)));
                AttCategory= dfre.Event_Attendee_Mapping__r.GuestType__c;
                AttQrCode= dfre.Event_Attendee_Mapping__r.EA_AttendeeBarcode__c;
               
                system.debug('  ATTENDEE CATEGORY  '+AttCategory);
            }
        }
        system.debug(attid+'  ATTENDEE ID '+AttCategory+'   '+reginforval);
        mapDummmywithAttendee.add(new attendeeInformation( attid, AttCategory, AttQrCode, reginforval));
        system.debug(mapDummmywithAttendee.size()+'  ALL ATTENDEE INFORMATION '+mapDummmywithAttendee);
    }
    
    system.debug('XXXXXXXXXXXXXXXXXXXXXXXx '+mapDummmywithAttendee);
    system.debug('YYYYYYYYYYYYYYYYY '+ticinfovalues);
    
    totalTrasactioninfo ticinfo = new totalTrasactioninfo(ticinfovalues,mapDummmywithAttendee);
    //totalTrasactioninfo ticinfo = new totalTrasactioninfo(mapDummmywithAttendee);
    
    return ticinfo ;
}
 
    public class AttendeeInfo{
        
        public string fname{get;set;}
        public string lname{get;set;}
        public string email{get;set;}
        public string company{get;set;}
        public string designation{get;set;}
        public string wphone{get;set;}
        public string waddress{get;set;}
        public string city{get;set;}
        public string state{get;set;}
        public string zip{get;set;}
        public String AttendeeCategory{get; set;}
        
        List<Tickets> lineItems{get;set;}
        
        public AttendeeInfo(integer qn, string fn,string ln,string em,string comp,string title,string wp,string wa,string ct,string st,string zp,String AttendeeCategory, List<Tickets> liList) {
            this.fname = fn;
            this.lname= ln;
            this.email= em;
            this.company = comp;
            this.designation= title;
            this.wphone= wp;
            this.waddress= wa;
            this.city= ct;
            this.state= st;
            this.zip= zp;
            this.AttendeeCategory= AttendeeCategory;
            this.lineItems= liList.clone();
            system.debug('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH PPPPPPPPPPPPPPPP '+lineItems);
        }
    }  

    public class Tickets{
        public Double unitPrice;
        public integer quantity;
        public string TicketType{get;set;}
        public String productName;
        public double totalQuantity{get;set;}
        public string PaymentStatus{get;set;}
        public string PaymentType{get;set;}
        public string seatnumbers{get;set;}
    }


    global class totalTrasactioninfo{
        public List<attendeeInformation> attendeeInformations{get;set;}
        public List<ticketInformation> ticketInformations{get;set;}
        
        public totalTrasactioninfo(List<ticketInformation> ti, List<attendeeInformation> ai){
            ticketInformations = new List<ticketInformation>();
            attendeeInformations = new  List<attendeeInformation>();
            this.attendeeInformations = ai;
            this.ticketInformations = ti;
        }
    }

    public class ticketInformation{
        public id id{get;set;}
        public string ticketName{get;set;}
        public string ticketType{get;set;}
        public decimal ticketPrice{get;set;}
        public decimal availableTickets{get;set;}
        public decimal totalSoldTickets{get;set;}
        
        public ticketInformation(TicketTypes__c tk){
            this.id = tk.id;
            this.ticketName = tk.TT_Name__c;
            this.ticketType = tk.TT_TicketType__c;
            this.ticketPrice =tk.TT_Amount__c;
            this.availableTickets = tk.Available__c;
            this.totalSoldTickets=tk.TT_Sold__c;
        }
    }


    public class attendeeInformation{
        public id attendeeId{get;set;}
        public string FirstName {get;set;}
        public string LastName {get;set;}
        public string Email {get;set;}
        public string Designation{get;set;}
        public string Company{get;set;}
        public string Phone{get;set;}
        public string Address{get;set;}
        public string City{get;set;}
        public string State{get;set;}
        public string Zip{get;set;}
        public string AttendeeCategory{get;set;}
        public string QrCode{get;set;}
                
        public List<registrationInformation> registrationInfo{get;set;}
 

        public attendeeInformation(AttendeeSummary__c asi, String AttendeeCategory, string QrCode, List<registrationInformation> de){
            this.attendeeId=asi.id;
            this.FirstName =asi.AS_firstName__c;
            this.LastName =asi.AS_LastName__c;
            this.Email =asi.AS_Email__c;
            this.Designation=asi.AS_Title__c;
            this.Company=asi.AS_company__c;
            this.Phone=asi.AS_WorkPhone__c;
            this.Address=asi.AS_WorkAddress1__c;
            this.City=asi.AS_WorkCity__c;
            this.State=asi.AS_Work_States__c;
            //this.State= State;
            this.Zip=asi.AS_WorkZip__c;
            this.AttendeeCategory= AttendeeCategory;
            this.QrCode= QrCode;
            registrationInfo= new List<registrationInformation>();
            this.registrationInfo =de;
        }
    }

    public class registrationInformation{
        public id TicketId {get;set;}
        public decimal totalSoldQuantity{get;set;}
        public double ticketsPrice{get;set;}
        public string ticketName{get;set;}
        public string PaymentStatus{get;set;}
        public string PaymentType{get;set;}
        public string PaymentId{get;set;}
        public String TransactionId{get;set;}
        
        public List<individualTicketInfo> individualTicketInformation{get;set;}
        
        public registrationInformation(Dummay__c dc ,List<individualTicketInfo> fg){
            this.TicketId= dc.TicketTypes__c;
            this.ticketsPrice = dc.TicketAmount__c;
            this.totalSoldQuantity = dc.Tickets_Quantty__c;
            this.ticketName  = dc.TicketTypes__r.TT_Name__c;
            this.PaymentStatus = dc.Payment_Status__c;
            this.PaymentType = dc.Payment_Type__c;
            this.PaymentId= dc.id;
            this.TransactionId = dc.customer_key__r.Name;
            individualTicketInformation= new List<individualTicketInfo>();
            this.individualTicketInformation=fg;
        }
    }

    public class individualTicketInfo{
        public boolean isCheckdin{get;set;}
        public string name{get;set;}
        public string Seat{get;set;}
        public string PaymentTime{get;set;}
        
        public individualTicketInfo(Individual_Ticket_Info__c ITI){
            this.name=ITI.Name;
            this.isCheckdin=ITI.IsCheckedIn__c;
            this.Seat=ITI.Seat__c;
            String DateTimeStr;
            try{
                DateTimeStr = ITI.CreatedDate.format('MMMM d, yyyy HH:mm a');
            }
            catch(Exception e){} 
            this.PaymentTime = DateTimeStr;
        }
    }


}
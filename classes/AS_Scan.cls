@RestResource(urlMapping='/AS_Scan/*')

 global with sharing class AS_Scan{
    global static String EveId;
    global static String User_Id;
    global static String EAMId;
    global static String OrderId;
    
    global static Event_Attendee_Mapping__c AtSummary; 
    global static User LoginUser;
    global static Event__c EventDetail;
    global static EachTicketDetails etd;
    global static EachEAMDetails eamd;
    global static List<EachTicketDetails> EachTicketDetails;

        
    @HttpGet
    global static UserDetails doGet(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        EveId= req.params.get('EventId');
        User_Id  = req.params.get('UserId');
        EAMId = req.params.get('QRcode');
        OrderId= req.params.get('OrderId');
                 
        system.debug(OrderId+'  SCAN ATTENDEE PARAMETERS  '+EveId+ '$$$$$ '+User_Id+' ^^^^^  '+EAMId); 
        // User details are from here
        try{
            LoginUser = [SELECT Id,Username,FirstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City FROM User WHERE Id=:User_Id];
   
            if(LoginUser.IsActive = false){
                UserDetails usd = new UserDetails('The account is inActive,Please Contact Boothleads!','');
                return usd; 
            } 

        }catch(Exception ex){
            UserDetails usd = new UserDetails('','The Credentials are not matching with DB');
            return usd;
        }
        
        if(EAMId != NULL){
         SET<id> EamIdDup = new SET<id>();
        // string attId =(EAMId.split('-'))[1];
          
         // This code is to handle if user have multiple EAMs(Added BY Phani)
         for(Event_Attendee_Mapping__c em: [select id,AS_Id__c from Event_Attendee_Mapping__c where id=:EAMId]){
             for(Event_Attendee_Mapping__c emInn: [select id,AS_Id__c from Event_Attendee_Mapping__c where EV_id__c=:EveId  and AS_Id__c=:em.AS_id__c]){
                EamIdDup.add(emInn.id); 
             }
              EamIdDup.add(em.id);
         }
         //Arindam written for custom barcode
         for(Event_Attendee_Mapping__c em: [select id,Custom_Barcode__c,AS_Id__c from Event_Attendee_Mapping__c where Custom_Barcode__c=:EAMId]){
             for(Event_Attendee_Mapping__c emInn: [select id,AS_Id__c from Event_Attendee_Mapping__c where EV_id__c=:EveId  and AS_Id__c=:em.AS_id__c]){
                EamIdDup.add(emInn.id); 
             }
              EamIdDup.add(em.id);
         }
         //end of it
         System.debug('Eam Ids for individual tickets '+EamIdDup);
        //------------------------ End ------------------------------
        // Event details are from here
            try{
                EventDetail = [SELECT Id,isActive__c FROM Event__c WHERE Id=: EveId AND isActive__c=:true];
       
                if(EventDetail.IsActive__c = false){
                    UserDetails usd = new UserDetails('No Such Event exists','');
                    return usd; 
                } 
            }
            catch(Exception ex){
                UserDetails usd = new UserDetails('','No Such Event exists');
                return usd;
            }
    
            try{
            LIST<User_Profile_Event__c> listOfUpe = new  LIST<User_Profile_Event__c>();
            listOfUpe =[SELECT id, EV_id__r.Event_Type__c 
                        FROM User_Profile_Event__c 
                        WHERE EV_id__c!=NULL 
                        AND User_id__c!=NULL
                        AND EV_id__c=:EveId
                        AND User_id__c=:User_Id
                        AND UEP_isActive__c =: TRUE];
                        
           // if(listOfUpe.size()>0){ Commented By Phani
                    AtSummary = new Event_Attendee_Mapping__c();
                    AtSummary = [SELECT id,Ev_Id__r.Id,AS_Id__r.Id,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Title__c, MobileCheckInTime__c,
                                         AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Work_Country__c,EV_id__r.EV_Title__c ,EV_id__r.Event_Type__c,AS_id__r.As_Home_Country__c,
                                         AS_id__r.As_Home_State__c,AS_id__r.AS_HomePhone__c,AS_id__r.AS_CellPhone__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_HomeCity__c,AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,isDeleted,EA_AttendeeBarcode__c,GuestType__c
                                 FROM Event_Attendee_Mapping__c 
                                 WHERE Id IN :EamIdDup limit 1];
               System.debug('Eam Ids for individual tickets '+AtSummary );                   
           // }// By Phani
            //  System.debug('Eam Ids for individual tickets '+EamIdDup);
            LIST<Individual_Ticket_Info__c> ticketlist = [SELECT Id,Name,IsCancelled__c,IsCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.First_Name__c,Registration_Info__r.Last_Name__c,Registration_Info__r.Company__c,Registration_Info__r.Email__c,Registration_Info__r.Event__c,Event_Attendee_Mapping__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_Id__r.AS_FirstName__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_Id__r.AS_LastName__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_Id__r.AS_Email__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_Id__r.AS_Company__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Event_Attendee_Mapping__r.Ev_Id__c 
                                                          FROM Individual_Ticket_Info__c 
                                                          WHERE Event_Attendee_Mapping__c!=NULL 
                                                          AND IsItem__c != TRUE
                                                          AND IsCancelled__c=FALSE
                                                          AND Event_Attendee_Mapping__r.Ev_Id__c =: EveId
                                                          AND Event_Attendee_Mapping__c IN :EamIdDup ORDER BY Name];
            EachTicketDetails = new List<EachTicketDetails>(); 
            
            
            //Added By Arindam
             //Get Payment Info For Event
        Payment_Info rg=new Payment_Info();  
        for(Individual_Ticket_Info__c iti:[SELECT Name, Total_Amount__c, Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.Item_Quantity__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Item__r.item_Name__c,Registration_Info__r.Item__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EveId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c=TRUE AND Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c != TRUE and Registration_Info__r.Event_Attendee_Mapping__c IN :EamIdDup ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true)
                ischeckin=iti.Name;
            else
                ischeckin='';
            rg.Item_Payment_Info.add(new Item_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.isCheckedIn__c,iti.Total_Amount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.Item__r.item_Name__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c));
        }
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EveId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE and  Registration_Info__r.Event_Attendee_Mapping__c IN :EamIdDup ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            String CheckInTime;
            String CheckOutTime;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true)
                ischeckin=iti.Name;
            else
                ischeckin='';
            for(User_CheckinHistory__c uc: iti.User_CheckinHistory__r){
               CheckInTime = uc.UC_CheckinTime__c;
               CheckOutTime = uc.CheckoutTime__c;
            }
            rg.Ticket_Payment_Info.add(new Ticket_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.Seat__c,ischeckin,iti.Registration_Info__r.IndividualAmount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.TicketTypes__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,iti.Registration_Info__r.TicketTypes__r.TT_Name__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c,CheckInTime,CheckOutTime));
        }
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Amount__c, Refund_Amount__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,IsCancelled__c,isItem__c,Refund_Date__c,Refund_Mode__c,CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c FROM Individual_Ticket_Info__c WHERE isCancelled__c =: TRUE AND Registration_Info__r.Event__c=:EveId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL and Registration_Info__r.Event_Attendee_Mapping__c IN :EamIdDup ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            String DateTimeStr1;
            try{
                DateTimeStr1 = iti.Refund_Date__c.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true){
                ischeckin=iti.Name;
            }
            else{
                ischeckin='';
            }      
            rg.Refund_Info.add(new Refund_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c+' '+iti.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,iti.Registration_Info__r.Check_number__c,iti.Seat__c,ischeckin,iti.Registration_Info__r.IndividualAmount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.TicketTypes__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,iti.Registration_Info__r.TicketTypes__r.TT_Name__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c,String.valueOf(iti.Refund_Amount__c),DateTimeStr1,iti.Refund_Mode__c, iti.Amount__c, iti.Registration_Info__r.Item__r.Item_name__c));
        }    
            
            
            //end
            
            
            
            
            
            UserDetails usd = new UserDetails(AtSummary.Ev_Id__r.Id,AtSummary.AS_Id__r.Id,AtSummary.Id,AtSummary.AS_Id__r.AS_FirstName__c,AtSummary.AS_Id__r.AS_LastName__c, AtSummary.MobileCheckInTime__c);
        
        //Added By Arindam
        String AttendeeState ='';
        String AttendeeCountry =''; 
         Commanforstates  getShortForm= new Commanforstates ();
            AttendeeState= getShortForm.mapstate(AtSummary.AS_id__r.AS_Work_States__c);
            AttendeeCountry= getShortForm.mapstate(AtSummary.AS_id__r.AS_Work_Country__c);
          Attendee_Details at=new Attendee_Details(AtSummary.MobileCheckInTime__c,AtSummary.AS_Id__r.Id,AtSummary.Ev_Id__r.Id,AtSummary.AS_id__r.AS_FirstName__c,AtSummary.AS_id__r.AS_LastName__c,AtSummary.AS_id__r.AS_Email__c,AtSummary.AS_id__r.AS_WorkCity__c,AttendeeState,AtSummary.AS_id__r.AS_Work_States__c,AtSummary.AS_id__r.AS_Company__c,AtSummary.AS_id__r.AS_WorkPhone__c,AtSummary.AS_id__r.AS_Title__c,AtSummary.AS_id__r.AS_ImageUrl__c,AtSummary.AS_id__r.AS_WorkAddress1__c,AtSummary.AS_id__r.AS_WorkAddress2__c,AttendeeCountry,AtSummary.AS_id__r.AS_Work_Country__c,AtSummary.AS_id__r.AS_WorkZip__c,AtSummary.isDeleted, AtSummary.EA_AttendeeBarcode__c, AtSummary.GuestType__c);
           usd.Attendee_Details =at;
        
        //end
        
        
            for(Individual_Ticket_Info__c iti:ticketlist){
                etd = new EachTicketDetails();
                etd.PaymentId = iti.Name;  
                etd.PaymentStatus = iti.Registration_Info__r.Payment_Status__c;
                etd.TicketId = iti.Registration_Info__r.TicketTypes__c;
                etd.TicketName = iti.Registration_Info__r.TicketTypes__r.TT_Name__c; 
                etd.isCheckedIn = iti.IsCheckedIn__c;  
                etd.SeatNumber = iti.Seat__c;  
                usd.ETdetails.add(etd); 
            }
            usd.Payment_Info=rg;
            return usd; 
            }
            catch(Exception ex){
                UserDetails usd = new UserDetails('','No Tickets found');
                return usd;
            }
            return null;
        }else if(OrderId != NULL){
            system.debug(User_Id+'  ORDER ID '+OrderId );
            LIST<Dummay__c> RegInfoList= new LIST<Dummay__c>();
            RegInfoList= [SELECT ID, Event__c, Event_Attendee_Mapping__r.AS_Id__c,
                          Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.EA_AttendeeBarcode__c, 
                          TicketTypes__r.TT_Name__c,Event_Attendee_Mapping__r.AS_Id__r.AS_FirstName__c,
                           Event_Attendee_Mapping__r.AS_Id__r.AS_LastName__c, Event_Attendee_Mapping__r.AS_Id__r.AS_Company__c,  
                           Event__r.EV_EventLogo__c, Event_Attendee_Mapping__r.AS_Id__r.AS_Title__c,
                           Event_Attendee_Mapping__r.GuestType__c, Event_Attendee_Mapping__r.MobileCheckInTime__c,Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c,Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c,Event_Attendee_Mapping__r.AS_id__r.AS_ImageUrl__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress2__c,Event_Attendee_Mapping__r.AS_id__r.AS_Work_Country__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkZip__c,Event_Attendee_Mapping__r.isDeleted,
                          (SELECT ID, Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.EA_AttendeeBarcode__c FROM Individual_Ticket_Info__r)  
                          FROM Dummay__c
                          WHERE customer_key__r.Name =: OrderId
                          AND Event__c != NULL];
            system.debug(RegInfoList.size()+'   REG INFO LIST '+RegInfoList);
            if(RegInfoList.size() >0){
                String EventId= RegInfoList[0].Event__c;
                system.debug('  EVENT ID '+EventId);
                try{
                    EventDetail= new Event__c();
                    EventDetail= [SELECT Id, EV_EventLogo__c, isActive__c FROM Event__c WHERE Id=: EventId AND isActive__c=:TRUE];
                       
                    if(EventDetail.IsActive__c = FALSE){
                        UserDetails usd = new UserDetails('No Such Event exists','');
                        return usd; 
                    } 
                }catch(Exception ex){
                    UserDetails usd = new UserDetails('','No Such Event exists');
                    return usd;
                }
                LIST<User_Profile_Event__c> listOfUpe = new  LIST<User_Profile_Event__c>();
                listOfUpe=[SELECT id, EV_id__r.Event_Type__c 
                           FROM User_Profile_Event__c 
                           WHERE EV_id__c!=NULL 
                           AND User_id__c!=NULL
                           AND EV_id__c=:EventId
                           AND User_id__c=:User_Id
                           AND UEP_isActive__c =: TRUE];                     
                system.debug(listOfUpe.size()+'   UPE LIST '+listOfUpe);
                if(listOfUpe.size() >0){
                     String Tickets='';
                     String orgId= UserInfo.getOrganizationId();
                     String EventLogo= 'https://c.cs11.content.force.com/servlet/servlet.ImageServer?oid='+orgId+'&id='+EventDetail.EV_EventLogo__c; 
                     for(Dummay__c reg: RegInfoList){
                         if(reg.TicketTypes__c != NULL){
                             Tickets+= reg.TicketTypes__r.TT_Name__c+',';                               
                         }    
                      } 
                      if(Tickets.endswith(',')){
                          Tickets= Tickets.subString(0,Tickets.lastIndexOf(','));
                      }                        
                     UserDetails usd = new UserDetails(OrderId, EventId, EventLogo);
                    SET<Id> EAMIds= new SET<Id>();

                    for(Dummay__c reg: RegInfoList){

                        if(! EAMIds.contains(reg.Event_Attendee_Mapping__c)){
                            eamd= new EachEAMDetails();
                            eamd.AttendeeId= reg.Event_Attendee_Mapping__r.AS_Id__c;
                            eamd.BarCode= reg.Event_Attendee_Mapping__r.EA_AttendeeBarcode__c;
                            eamd.FirstName = reg.Event_Attendee_Mapping__r.AS_Id__r.AS_FirstName__c;
                            eamd.LastName= reg.Event_Attendee_Mapping__r.AS_Id__r.AS_LastName__c;
                            eamd.Company= reg.Event_Attendee_Mapping__r.AS_Id__r.AS_Company__c;                            
                            eamd.JobTitle= reg.Event_Attendee_Mapping__r.AS_Id__r.AS_Title__c;                                                        
                            eamd.AttendeeCategory= reg.Event_Attendee_Mapping__r.GuestType__c;
                            eamd.TicketList= Tickets;
                            
                            
                            //Added By Arindam
        String AttendeeState ='';
        String AttendeeCountry =''; 
         Commanforstates  getShortForm= new Commanforstates ();
            AttendeeState= getShortForm.mapstate(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c);
            AttendeeCountry= getShortForm.mapstate(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_Country__c);
                          Attendee_Details at=new Attendee_Details(reg.Event_Attendee_Mapping__r.MobileCheckInTime__c,reg.Event_Attendee_Mapping__r.AS_Id__c,reg.Event__c,reg.Event_Attendee_Mapping__r.AS_Id__r.AS_FirstName__c,reg.Event_Attendee_Mapping__r.AS_Id__r.AS_LastName__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c,AttendeeState,reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_Title__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_ImageUrl__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress2__c,AttendeeCountry,reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_Country__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkZip__c,reg.Event_Attendee_Mapping__r.isDeleted, reg.Event_Attendee_Mapping__r.EA_AttendeeBarcode__c, reg.Event_Attendee_Mapping__r.GuestType__c);
                          usd.Attendee_Details =at;
        
        //end
                            
                            
                            
                            EAMIds.add(reg.Event_Attendee_Mapping__c);                           
                            usd.EAMDetails=eamd;
                             
                        }
                       //https://c.cs11.content.force.com/servlet/servlet.ImageServer?oid=00DZ0000000pGvZMAU&id=015Z0000000PJQdIAO
                    }       

                  //Added By Arindam
                            
                //Get Payment Info For Event
        Payment_Info rg=new Payment_Info();  
        for(Individual_Ticket_Info__c iti:[SELECT Name, Total_Amount__c, Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.Item_Quantity__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Item__r.item_Name__c,Registration_Info__r.Item__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EveId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c=TRUE AND Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c != TRUE and Registration_Info__r.Event_Attendee_Mapping__c in:EAMIds ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true)
                ischeckin=iti.Name;
            else
                ischeckin='';
            rg.Item_Payment_Info.add(new Item_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.isCheckedIn__c,iti.Total_Amount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.Item__r.item_Name__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c));
        }
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EveId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE and  Registration_Info__r.Event_Attendee_Mapping__c in:EAMIds ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            String CheckInTime;
            String CheckOutTime;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true)
                ischeckin=iti.Name;
            else
                ischeckin='';
            for(User_CheckinHistory__c uc: iti.User_CheckinHistory__r){
               CheckInTime = uc.UC_CheckinTime__c;
               CheckOutTime = uc.CheckoutTime__c;
            }
            rg.Ticket_Payment_Info.add(new Ticket_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.Seat__c,ischeckin,iti.Registration_Info__r.IndividualAmount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.TicketTypes__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,iti.Registration_Info__r.TicketTypes__r.TT_Name__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c,CheckInTime,CheckOutTime));
        }
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Amount__c, Refund_Amount__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,IsCancelled__c,isItem__c,Refund_Date__c,Refund_Mode__c,CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c FROM Individual_Ticket_Info__c WHERE isCancelled__c =: TRUE AND Registration_Info__r.Event__c=:EveId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL and Registration_Info__r.Event_Attendee_Mapping__c in:EAMIds ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            String DateTimeStr1;
            try{
                DateTimeStr1 = iti.Refund_Date__c.format('MMMM d, yyyy h:mm:ss a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true){
                ischeckin=iti.Name;
            }
            else{
                ischeckin='';
            }      
            rg.Refund_Info.add(new Refund_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c+' '+iti.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,iti.Registration_Info__r.Check_number__c,iti.Seat__c,ischeckin,iti.Registration_Info__r.IndividualAmount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.TicketTypes__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,iti.Registration_Info__r.TicketTypes__r.TT_Name__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c,String.valueOf(iti.Refund_Amount__c),DateTimeStr1,iti.Refund_Mode__c, iti.Amount__c, iti.Registration_Info__r.Item__r.Item_name__c));
        }    
               
               //end
           usd.Payment_Info=rg;
              

                    return usd;
                }               
            
            }
            return null;
        } 
       
        return null;   
    }

    
    global class UserDetails{
        String EventId;
        String AttendeeId;
        String AttendeeFirstName;
        String AttendeeLastName;
        String CheckInDateTime;
        String QRCode;    
        String message;
        String error;
        public Payment_Info Payment_Info{get;set;}
        public Attendee_Details Attendee_Details{get;set;}
        
        global EachTicketDetails[] ETdetails;
        
        global UserDetails(String message1, String error1){
            error = error1;
            message= message1;
            Payment_Info=new Payment_Info();
           
        }
        
        global UserDetails(String EventId1, String AttendeeId1,String QRCode1,String AttendeeFirstName1,String AttendeeLastName1, String CheckInDateTime1){
            EventId = EventId1;
            AttendeeId= AttendeeId1;
            QRCode=QRCode1;
            AttendeeFirstName=AttendeeFirstName1;
            AttendeeLastName=AttendeeLastName1;
            if(CheckInDateTime1!=null ){   
             CheckInDateTime= CheckInDateTime1;
             }else{
               CheckInDateTime =''; 
             }
            ETdetails = new List<EachTicketDetails>();
            Payment_Info=new Payment_Info();
            
        } 
         
        global EachEAMDetails EAMDetails;
        String OrderName;
        String EventLogo;
        
        global UserDetails(String OrderName1, String EventId1, String EventLogo1){
            OrderName= OrderName1;
            EventId= EventId1;
            EventLogo= EventLogo1;
            EAMDetails= new EachEAMDetails();
            Payment_Info=new Payment_Info();
            
        }  
        
    }
    
    global class EachTicketDetails{
        String TicketId;
        String TicketName;
        Boolean isCheckedIn;     
        String PaymentId; 
        String PaymentStatus;
        String SeatNumber;
        
        global EachTicketDetails(){}
        
        global EachTicketDetails(String TicketId1,String TicketName1,Boolean isCheckedIn1,String PaymentId1,String PaymentStatus1,String SeatNumber1){
            TicketId=TicketId1;
            TicketName=TicketName1;
            isCheckedIn=isCheckedIn1;
            PaymentId=PaymentId1;
            PaymentStatus=PaymentStatus1;
            SeatNumber=SeatNumber1;
        }
    }
    

    global class EachEAMDetails{
        String AttendeeId;
        String FirstName;
        String LastName; 
        String BarCode;
        String Company;
        String JobTitle;
        String AttendeeCategory;
        String TicketList;        
                
        global eachEAMDetails(){}
        
        global eachEAMDetails(String AttendeeId, String FirstName, String LastName, String BarCode, String Company, String JobTitle, String AttendeeCategory, String TicketList){
            this.AttendeeId= AttendeeId;
            this.FirstName= FirstName;
            this.LastName= LastName;
            this.BarCode= BarCode;
            this.Company= Company;
            this.JobTitle= JobTitle;
            this.AttendeeCategory= AttendeeCategory;
            this.TicketList= TicketList;
        }
    }
    
    
    
   //Added by Arindam on 16/3/2015 
     global class Payment_Info
    { 
       List<Ticket_Payment_Info> Ticket_Payment_Info{get;set;} 
      List<Item_Payment_Info> Item_Payment_Info{get;set;} 
      List<Refund_Info> Refund_Info{get;set;}
      
      public Payment_Info()
      {
       Ticket_Payment_Info=new List<Ticket_Payment_Info>();          
       Item_Payment_Info=new List<Item_Payment_Info>(); 
       Refund_Info=new List<Refund_Info>();         
      }
    }
     global class Refund_Info{    
    
       public Id Ticket_Id{get; set;}
       public Id Event_Id{get;set;}
       public String Ticket_Number{get;set;}
       public String Payment_Status{get;set;}
       public String Ticket_Name{get;set;}
       public String AttendeeId{get;set;}
       public String ItemId{get;set;}
       public String PaymentType{get;set;}
       public Decimal TicketQuantity{get;set;}
       public String CheckNo{get;set;}
       public String Seat_No{get;set;}
       public String isCheckedIn{get;set;}
       public Decimal TicketAmount{get;set;}
       public String PaymentTime{get;set;}  
       public String PaymentId{get;set;}
       public String PayKey{get;set;}
       public String RefundAmount{get;set;}
       public String RefundDate{get;set;}
       public String AttendeeName{get;set;}
       public String RefundMode{get;set;}
       public Decimal ActualAmount{get; set;}
       public String ItemName{get;set;}
       
       public Refund_Info(String PaymentType,Decimal TicketQuantity,String AttendeeName,String CheckNo,String Seat_No,String isCheckedIn,Decimal TicketAmount,
       String AttendeeId,String ItemId,Id Ticket_Id,Id EventId,String Ticket_Number,String Payment_Status,String Ticket_Name,String PaymentTime,String PaymentID,String PayKey,String RefundAmount,String RefundDate,String RefundMode, Decimal ActualAmount, String ItemName) 
       {
         this.PaymentType=PaymentType;
         this.TicketQuantity=TicketQuantity;
         this.AttendeeName=AttendeeName;
         this.CheckNo=CheckNo;
         this.Seat_No=Seat_No;
         this.isCheckedIn=isCheckedIn;
         this.TicketAmount=TicketAmount;
         this.AttendeeId=AttendeeId;
         this.ItemId=ItemId;
         this.Ticket_Id=Ticket_Id;
         this.Event_Id=EventId;
         this.Ticket_Number=Ticket_Number;
         this.Payment_Status=Payment_Status;
         this.Ticket_Name=Ticket_Name; 
         this.PaymentTime=PaymentTime;  
         this.PaymentId=PaymentID;
         this.PayKey=PayKey; 
         this.RefundAmount=RefundAmount;
         this.RefundDate=RefundDate;
         this.RefundMode=RefundMode;
         this.ActualAmount= ActualAmount;
         this.ItemName= ItemName;
        }
       
    }
    
     global class Ticket_Payment_Info{    
    
       public Id Ticket_Id{get; set;}
       public Id Event_Id{get;set;}
       public String Ticket_Number{get;set;}
       public String Payment_Status{get;set;}
       public String Ticket_Name{get;set;}
       public String AttendeeId{get;set;}
       public String ItemId{get;set;}
       public String PaymentType{get;set;}
       public Decimal TicketQuantity{get;set;}
       public String CheckNo{get;set;}
       public String Seat_No{get;set;}
       public String isCheckedIn{get;set;}
       public Decimal TicketAmount{get;set;}
       public String PaymentTime{get;set;}  
       public String PaymentId{get;set;}
       public String PayKey{get;set;}
       public String CheckInTime{get;set;}
       public String CheckOutTime{get;set;}
       
       public Ticket_Payment_Info(String PaymentType,Decimal TicketQuantity,String CheckNo,String Seat_No,String isCheckedIn,Decimal TicketAmount,
       String AttendeeId,String ItemId,Id Ticket_Id,Id EventId,String Ticket_Number,String Payment_Status,String Ticket_Name,String PaymentTime,String PaymentID,String PayKey,String CheckInTime,String CheckOutTime) 
       {
         this.PaymentType=PaymentType;
         this.TicketQuantity=TicketQuantity;
         this.CheckNo=CheckNo;
         this.Seat_No=Seat_No;
         this.isCheckedIn=isCheckedIn;
         this.TicketAmount=TicketAmount;
         this.AttendeeId=AttendeeId;
         this.ItemId=ItemId;
         this.Ticket_Id=Ticket_Id;
         this.Event_Id=EventId;
         this.Ticket_Number=Ticket_Number;
         this.Payment_Status=Payment_Status;
         this.Ticket_Name=Ticket_Name;   
         this.PaymentTime=PaymentTime;
         this.PaymentId=PaymentID; 
         this.PayKey=PayKey; 
         this.CheckInTime=CheckInTime;
         this.CheckOutTime=CheckOutTime;
        }
       
    }
    
    global class Item_Payment_Info
    {    
       public Id Event_Id{get;set;}
       public String Payment_Status{get;set;}
       public String Item_Number{get;set;}
       public String AttendeeId{get;set;}
       public String ItemId{get;set;}
       public String Item_Name{get;set;}
       public String PaymentType{get;set;}
       public Decimal ItemQuantity{get;set;}
       public String CheckNo{get;set;}
       public boolean isCheckedIn{get;set;}
       public Decimal ItemAmount{get;set;}
       public String PaymentTime{get;set;}  
       public String PaymentId{get;set;}
       public String PayKey{get;set;}

       public Item_Payment_Info(String PaymentType,Decimal ItemQuantity,String CheckNo,boolean isCheckedIn,Decimal ItemAmount,
       String AttendeeId,String ItemId,String Item_Name,Id EventId,String Item_Number,String Payment_Status,String PaymentTime,String PaymentID,String PayKey) 
       {
         this.PaymentType=PaymentType;
         this.ItemQuantity=ItemQuantity;
         this.CheckNo=CheckNo;
         this.isCheckedIn=isCheckedIn;
         this.ItemAmount=ItemAmount;
         this.AttendeeId=AttendeeId;
         this.ItemId=ItemId;
         this.Item_Name=Item_Name;
         this.Item_Number=Item_Number;
         this.Event_Id=EventId;
         this.Payment_Status=Payment_Status; 
         this.PaymentTime=PaymentTime; 
         this.PaymentId=PaymentID;
         this.PayKey=PayKey;
        }
    }    
    
     global class Attendee_Details
    {    
       public Id id{get; set;}
       public Id Event_Id{get;set;}
       public String Attendee_FirstName{get;set;}
       public String Attendee_LastName{get;set;}       
       public String Attendee_Email{get;set;}
       public String City{get;set;}
       public String State{get;set;}
       public String State_LongCode{get;set;}
       public String Company{get;set;}
       public String Phone{get;set;}
       public String Designation{get;set;}
       public String Attendee_ImageUrl{get;set;}
       public String Address1{get;set;}
       public String Address2{get;set;}
       public String Country{get;set;}
       public String Country_LongCode{get;set;}
       public String Zipcode{get;set;}
       public String MobileCheckInTime{get;set;} 
       public Boolean isDeleted{get;set;}
       public String QrcodeIds{get; set;}
       public String AttendeeCategory{get; set;}
                      
       public Attendee_Details(String MobileCheckInTime,Id attid,Id eventid,String firstname,String lastname,String email,String city,String state,String stateLongCode,String Company,String Phone,String Designation,String Attendee_ImageUrl,String Address1,String Address2,String Country,String CountryLongCode,String Zipcode,Boolean isDeleted, String QrcodeIds, String AttendeeCategory) {
         if(MobileCheckInTime!=null){
           this.MobileCheckInTime=MobileCheckInTime;
         }else{
           this.MobileCheckInTime='';
         }
         this.id=attid;
         this.Event_Id=eventid;
         this.Attendee_FirstName=firstname;
         this.Attendee_LastName=lastname;
         this.Attendee_Email=email;
         this.City=city;
         this.State=state;
         this.State_LongCode=stateLongCode;
         this.Company=Company;
         this.Phone=Phone;
         this.Designation=Designation;
         this.Attendee_ImageUrl=Attendee_ImageUrl;
         this.Address1=Address1;
         this.Address2=Address2;
         this.Country=Country;
         this.Country_LongCode=CountryLongCode;
         this.Zipcode=Zipcode; 
         this.isDeleted=isDeleted;
         this.QrcodeIds= QrcodeIds;
         this.AttendeeCategory= AttendeeCategory;
         
        }
       
    } 
    
}
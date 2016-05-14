@RestResource(urlMapping='/AS_attSearch/*')
  
 global with sharing class AS_attSearch{
    
    @HttpGet
    global static Container doGet(){
       RestRequest req = RestContext.request;
        
        system.debug(req.params.get('EventID')+' LOGIN USER ID FROM APP '+req);
        String EventID = req.params.get('EventID');
        String LoginId = req.params.get('LoginUserId');       
        String searchStr= req.params.get('searchStr'); 
         
        Container ct=new Container();
        Commanforstates con = new Commanforstates();
        
        
         //Get Event Details
          try{
            Event__c eve = [SELECT Id, Badge_Name__c, Fee_Type__c, Sales_Tax__c, LastModifiedDate,StartTime__c,EV_EndTime__c,EV_HostingStateNew__c,EV_HostingCountryNew__c,EV_HostingZipcode__c,EV_StartDate__c,EV_EndDate__c,EV_Title__c,EV_Description__c,AS_HostingCity__c,EV_HistingAddr1__c,EV_HostingLocation__c,isActive__c FROM Event__c WHERE Id=:EventID AND isActive__c=:true];
          /*  ct.Event_State =  con.mapstate(eve.EV_HostingStateNew__c);
            ct.Event_State_LongCode=eve.EV_HostingStateNew__c;
            ct.Event_ZipCode=eve.EV_HostingZipcode__c;
            ct.Event_Country=con.mapstate(eve.EV_HostingCountryNew__c);
            ct.Event_Country_LongCode=eve.EV_HostingCountryNew__c;
            ct.Event_StartDate=eve.EV_StartDate__c;
            ct.Event_EndDate=eve.EV_EndDate__c;
            ct.Event_Name=eve.EV_Title__c; 
            ct.Event_Decription=eve.EV_Description__c;
            ct.Event_City=eve.AS_HostingCity__c;
            ct.Event_ID=eve.id;
            ct.Event_StartTime=eve.StartTime__c;
            ct.Event_EndTime=eve.EV_EndTime__c;
            ct.Event_Address=eve.EV_HistingAddr1__c;
            ct.Event_Location=eve.EV_HostingLocation__c;
            ct.isEventAdminStaffUser= FALSE;  
            ct.SalesTax= String.valueOf(eve.Sales_Tax__c); 
            ct.BadgeName= eve.Badge_Name__c;
            
            if(eve.Fee_Type__c == 'Include the fee in the ticket price'){
                ct.FeeApplicable= TRUE;
            }else if(eve.Fee_Type__c == 'Charge the fee to the customer'){
                ct.FeeApplicable= FALSE;        
            }
*/
            LIST<User_Profile_Event__c> profileUser= new LIST<User_Profile_Event__c>();
            system.debug(eve.id+'  EVENT ID '+LoginId);
            profileUser= [SELECT ID 
                          FROM User_Profile_Event__c 
                          WHERE User_id__c =: LoginId
                          AND EV_id__c =: eve.id
                          AND Profile_id__r.PR_Name__c =: 'EventAdmin Staff'
                          AND UEP_isActive__c =: TRUE];
            system.debug(profileUser.size()+'  PORTAL USER '+profileUser);
            if(profileUser.size() >0){
                ct.isEventAdminStaffUser= TRUE;
            }
            system.debug(ct.isEventAdminStaffUser+'  PORTAL EVENT ADMIN ');
        
        }
        catch(Exception ex){   
            ct.Error = 'No Such Event Exists!';  
        }
      
        string urlbase =URL.getSalesforceBaseUrl().getHost();
        string orgId = UserInfo.getOrganizationId();
        String ticketimageURL ='';
        String itemimageURL ='';
        String AttendeeState ='';
        String AttendeeCountry ='';
        
      /*  LIST<TicketTypes__c> ExistingTicketsList= new LIST<TicketTypes__c>();
        ExistingTicketsList= [SELECT ID, TT_Name__c FROM TicketTypes__c WHERE (TT_Name__c =: 'Guest' OR TT_Name__c =: 'Attendee Staff') AND EV_id__c =: EventId];
        includeSADetailsToBLEvent insertTickets= new includeSADetailsToBLEvent();        
        system.debug(LoginId+'  DETAILS TO CALL CLASS '+EventID);
        if(ExistingTicketsList.size() == 0){   
            insertTickets.insertTicketsForEvent( LoginId, EventID);
        }
        insertTickets.insertGuestToAttendee(EventID);
        //Get Ticket Types For Event
        for(TicketTypes__c tt:[SELECT Id,isDeleted,LastModifiedDate,EV_id__c,TT_Sold__c,TT_Available__c,TT_Amount__c,TT_Name__c,TT_TicketType__c,Ticket_Category__c,Ticket_Image_URL__c FROM TicketTypes__c WHERE EV_id__c=:EventID All rows]){
            ticketimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+tt.Ticket_Image_URL__c;
            ct.TicketTypes.add(new TicketTypes(tt.EV_id__c,tt.TT_Name__c ,tt.TT_Amount__c,tt.TT_Available__c,tt.TT_Sold__c,tt.id,tt.TT_TicketType__c,tt.Ticket_Category__c,ticketimageURL,tt.isDeleted));
            system.debug('#### '+tt);
        } 
    
        //Get Items For Event
        for(Item__c item:[SELECT Id,isDeleted,Event__c,Item_name__c,Cost__c,Item_Quantity__c,Item_Image__c,Sold_Quantity__c,isTaxable__c,Sales_Tax__c FROM Item__c WHERE Event__c=:EventID All rows]){
            itemimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+item.Item_Image__c;
            ct.ItemDetails.add(new ItemDetails(item.Event__c,item.Item_name__c,item.Cost__c,item.id,item.Item_Quantity__c,itemimageURL ,item.Sold_Quantity__c,item.isTaxable__c,item.Sales_Tax__c,item.isDeleted));
            system.debug('Item Details:' +Item);
        }    
     */   
      
      string strAtt = '%'+searchStr+'%';
      SET<id> eamAttId = new SEt<id>();
        //Get Attendee Details For Event
        for(Event_Attendee_Mapping__c evatmap:[SELECT GuestType__c, isDeleted,EA_AttendeeBarcode__c, MobileCheckInTime__c,IsCancelled__c,AS_id__c,EV_id__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Title__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND IsCancelled__c!= TRUE and (AS_Id__r.AS_FirstName__c Like :strAtt  OR AS_Id__r.AS_LastName__c Like :strAtt  OR AS_Id__r.AS_Email__c Like :strAtt OR AS_Id__r.AS_Company__c Like :strAtt) LIMIT 100 All rows ]){
            eamAttId.add(evatmap.id);
            Commanforstates  getShortForm= new Commanforstates ();
            AttendeeState= getShortForm.mapstate(evatmap.AS_id__r.AS_Work_States__c);
            AttendeeCountry= getShortForm.mapstate(evatmap.AS_id__r.AS_Work_Country__c);
            system.debug(evatmap.AS_id__r.AS_Email__c+'   '+AttendeeState+'  ATTENDEE STATE'+evatmap.AS_id__r.AS_Work_States__c+'  '+AttendeeCountry+ '   ' + evatmap.AS_id__r.AS_Work_Country__c );
            ct.Attendee_Details.add(new Attendee_Details(evatmap.MobileCheckInTime__c,evatmap.AS_id__c,evatmap.EV_id__c,evatmap.AS_id__r.AS_FirstName__c,evatmap.AS_id__r.AS_LastName__c,evatmap.AS_id__r.AS_Email__c,evatmap.AS_id__r.AS_WorkCity__c,AttendeeState,evatmap.AS_id__r.AS_Work_States__c,evatmap.AS_id__r.AS_Company__c,evatmap.AS_id__r.AS_WorkPhone__c,evatmap.AS_id__r.AS_Title__c,evatmap.AS_id__r.AS_ImageUrl__c,evatmap.AS_id__r.AS_WorkAddress1__c,evatmap.AS_id__r.AS_WorkAddress2__c,AttendeeCountry,evatmap.AS_id__r.AS_Work_Country__c,evatmap.AS_id__r.AS_WorkZip__c,evatmap.isDeleted, evatmap.EA_AttendeeBarcode__c, evatmap.GuestType__c));
        }
         
         
       system.debug('DDDDDDDDDDDDD '+eamAttId );  
        //Get Payment Info For Event
        Payment_Info rg=new Payment_Info();  
        for(Individual_Ticket_Info__c iti:[SELECT Name, Total_Amount__c, Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.Item_Quantity__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Item__r.item_Name__c,Registration_Info__r.Item__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c=TRUE AND Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c != TRUE and Registration_Info__r.Event_Attendee_Mapping__c IN :eamAttId ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm a');
            }
            catch(exception ex){}
            if(iti.isCheckedIn__c==true)
                ischeckin=iti.Name;
            else
                ischeckin='';
            rg.Item_Payment_Info.add(new Item_Payment_Info(iti.Registration_Info__r.Payment_Type__c,1,iti.Registration_Info__r.Check_number__c,iti.isCheckedIn__c,iti.Total_Amount__c,iti.Event_Attendee_Mapping__r.AS_id__c,iti.Registration_Info__r.Item__c,iti.Registration_Info__r.Item__r.item_Name__c,iti.Registration_Info__r.Event__c,iti.Name,iti.Registration_Info__r.Payment_Status__c,DateTimeStr,iti.Registration_Info__r.customer_key__r.Name,iti.Registration_Info__r.payKey__c));
        }
   
     
     // Individual_Ticket_Info__c  iti1= [SELECT Name,Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE and Registration_Info__r.Event_Attendee_Mapping__c IN :eamAttId ORDER BY Name];
     // system.debug('DDDDDDDDDDDDD '+[select id,Event__c,Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.isCancelled__c from Dummay__c  where Event_Attendee_Mapping__c in :eamAttId]);
      
        for(Individual_Ticket_Info__c iti:[SELECT Name,Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE and Registration_Info__r.Event_Attendee_Mapping__c IN :eamAttId ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            String CheckInTime;
            String CheckOutTime;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm a');
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
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Amount__c, Refund_Amount__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,IsCancelled__c,isItem__c,Refund_Date__c,Refund_Mode__c,CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c FROM Individual_Ticket_Info__c WHERE isCancelled__c =: TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL and Registration_Info__r.Event_Attendee_Mapping__c IN :eamAttId ORDER BY Name]){
            String ischeckin;
            String DateTimeStr;
            try{
                DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy h:mm a');
            }
            catch(exception ex){}
            String DateTimeStr1;
            try{
                DateTimeStr1 = iti.Refund_Date__c.format('MMMM d, yyyy h:mm a');
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
        ct.Payment_Info.add(rg);  
      
        return ct;
    }
    
    global class Container
    {
        //List<TicketTypes> TicketTypes{get;set;} 
       // List<ItemDetails> ItemDetails{get;set;} 
        List<Attendee_Details> Attendee_Details{get;set;}
         
       /* public Date Event_StartDate{get;set;}
        public Date Event_EndDate{get;set;}
        public String Event_Name{get;set;}
        public String Event_Decription{get;set;}
        public String Event_StartTime{get;set;}
        public String Event_EndTime{get;set;}
        public String Event_Location{get;set;}
        public String Event_Address{get;set;}
        public String Event_City{get;set;}
        public String Event_State{get;set;}
        public String Event_State_LongCode{get;set;}
        public String Event_Country{get;set;}
        public String Event_Country_LongCode{get;set;}
        public String Event_ZipCode{get;set;}
        public Id Event_ID{get;set;}
        */
        public List<Payment_Info> Payment_Info{get;set;}
        
        
        public String Error{get;set;}
        public String SalesTax{get;set;}
        public Boolean isEventAdminStaffUser{get; set;}
        public Boolean FeeApplicable{get; set;}
        public String BadgeName{get; set;}
                                
        public Container()
        {
            //TicketTypes=new List<TicketTypes>();
           // ItemDetails=new List<ItemDetails>();
            Attendee_Details=new List<Attendee_Details>();
            Payment_Info=new List<Payment_Info>();          
        }
    }
    
    
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

     global class TicketTypes
    {    
        public String Ticket_Name{get;set;}
        public Decimal Ticket_Price{get;set;}
        public Decimal Ticket_Quantity{get;set;}
        public Decimal Ticket_QuantitySold{get;set;}
        public String Ticket_Type{get;set;}
        public String Ticket_Category{get;set;}
        public String Ticket_ImageUrl{get;set;}
        public Id Ticket_Id{get; set;}
        public Id Event_Id{get;set;}
        public Boolean isDeleted{get;set;}
        
       public TicketTypes(Id Event_Id,String tname,Decimal tcktpr,Decimal tcktqnt,Decimal tcktqntsold,Id tid,String ttype,String tcategory,String timage,Boolean isDeleted) {
            this.Event_Id=Event_Id;
            this.Ticket_Name= tname;
            this.Ticket_Price= tcktpr;
            this.Ticket_Quantity= tcktqnt;
            this.Ticket_QuantitySold= tcktqntsold;
            this.Ticket_Id= tid;
            Ticket_Type=ttype;
            Ticket_Category=tcategory;
            Ticket_ImageUrl=timage;
            this.isDeleted=isDeleted;
        }   
    }
  
     global class ItemDetails
    {    
        public String Item_Name{get;set;}
        public Decimal Item_Price{get;set;}
        public Id Item_Id{get; set;}
        public Decimal Item_Quantity{get;set;}
        public String Item_Image{get;set;}
        public Decimal Sold_Quantity{get;set;}
        public boolean isTaxable{get;set;}
        public Decimal SalesTax{get;set;}
        public Id Event_Id{get;set;}
        public Boolean isDeleted{get;set;}
        
       public ItemDetails(Id Event_Id,String iname,Decimal itempr,Id itmid,Decimal Item_Quantity,String Item_Image,Decimal Sold_Quantity,boolean isTaxable,Decimal SalesTax,Boolean isDeleted) {
            this.Event_Id=Event_Id;
            this.Item_Name= iname;
            this.Item_Price= itempr;
            this.Item_Id= itmid;
            this.Item_Quantity=Item_Quantity;
            this.Item_Image=Item_Image;
            this.Sold_Quantity=Sold_Quantity;
            this.isTaxable=isTaxable;
            this.SalesTax=SalesTax;
            this.isDeleted=isDeleted;
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
         
         this.MobileCheckInTime=MobileCheckInTime;
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
       String AttendeeId,String ItemId,Id Ticket_Id,Id Event_Id,String Ticket_Number,String Payment_Status,String Ticket_Name,String PaymentTime,String PaymentID,String PayKey,String RefundAmount,String RefundDate,String RefundMode, Decimal ActualAmount, String ItemName) 
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
         this.Event_Id=Event_Id;
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
       String AttendeeId,String ItemId,Id Ticket_Id,Id Event_Id,String Ticket_Number,String Payment_Status,String Ticket_Name,String PaymentTime,String PaymentID,String PayKey,String CheckInTime,String CheckOutTime) 
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
         this.Event_Id=Event_Id;
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
       String AttendeeId,String ItemId,String Item_Name,Id Event_Id,String Item_Number,String Payment_Status,String PaymentTime,String PaymentID,String PayKey) 
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
         this.Event_Id=Event_Id;
         this.Payment_Status=Payment_Status; 
         this.PaymentTime=PaymentTime; 
         this.PaymentId=PaymentID;
         this.PayKey=PayKey;
        }
     }
  }
@RestResource(urlMapping='/AS_AttendeeLoadMore/*')
  
 global with sharing class AS_AttendeeLoadMore{
    
    @HttpGet
    global static Container doGet(){
        RestRequest req = RestContext.request;
        String EventID = req.params.get('EventID');
        integer offset=Integer.valueOf(req.params.get('offset'));
        integer limits=Integer.valueOf(req.params.get('limit')==null?'0':req.params.get('limit'));
         List<Event_Attendee_Mapping__c> eamListforevent = new List<Event_Attendee_Mapping__c>();
         if(limits==0)
         eamListforevent  =  [SELECT GuestType__c,isDeleted,EA_AttendeeBarcode__c, MobileCheckInTime__c,IsCancelled__c,AS_id__c,EV_id__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Title__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND IsCancelled__c!= TRUE order by lastmodifieddate desc,MobileCheckInTime__c desc];         
         else
         eamListforevent  =  [SELECT GuestType__c,isDeleted,EA_AttendeeBarcode__c, MobileCheckInTime__c,IsCancelled__c,AS_id__c,EV_id__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Title__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND IsCancelled__c!= TRUE order by lastmodifieddate desc,MobileCheckInTime__c desc limit :limits offset :offset  ];
       Container ct=new Container();
       //ct.totalAttendee=[SELECT count() FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND IsCancelled__c!= TRUE];
         String AttendeeState ='';
        String AttendeeCountry =''; 
        //Get Attendee Details For Event
         SET<id> eamIdsfilterTicks = new SET<id>();
        for(Event_Attendee_Mapping__c evatmap:eamListforevent  ){
        Commanforstates  getShortForm= new Commanforstates ();
            eamIdsfilterTicks.add(evatmap.id); 
            AttendeeState= getShortForm.mapstate(evatmap.AS_id__r.AS_Work_States__c);
            AttendeeCountry= getShortForm.mapstate(evatmap.AS_id__r.AS_Work_Country__c);
           ct.Attendee_Details.add(new Attendee_Details(evatmap.MobileCheckInTime__c,evatmap.AS_id__c,evatmap.EV_id__c,evatmap.AS_id__r.AS_FirstName__c,evatmap.AS_id__r.AS_LastName__c,evatmap.AS_id__r.AS_Email__c,evatmap.AS_id__r.AS_WorkCity__c,AttendeeState,evatmap.AS_id__r.AS_Work_States__c,evatmap.AS_id__r.AS_Company__c,evatmap.AS_id__r.AS_WorkPhone__c,evatmap.AS_id__r.AS_Title__c,evatmap.AS_id__r.AS_ImageUrl__c,evatmap.AS_id__r.AS_WorkAddress1__c,evatmap.AS_id__r.AS_WorkAddress2__c,AttendeeCountry,evatmap.AS_id__r.AS_Work_Country__c,evatmap.AS_id__r.AS_WorkZip__c,evatmap.isDeleted, evatmap.EA_AttendeeBarcode__c, evatmap.GuestType__c));
        }
        
        //Get Payment Info For Event
        Payment_Info rg=new Payment_Info();  
        for(Individual_Ticket_Info__c iti:[SELECT Name, Total_Amount__c, Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.Item_Quantity__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Item__r.item_Name__c,Registration_Info__r.Item__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c=TRUE AND Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c != TRUE and Registration_Info__r.Event_Attendee_Mapping__c IN :eamIdsfilterTicks AND  Registration_Info__r.customer_key__r.isInserted__c=true ORDER BY Name]){
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
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Registration_Info__r.Available_Quantity__c, CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Registration_Info__r.Event_Attendee_Mapping__r.IsCancelled__c,(SELECT Id,Name,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__r.isCheckedIn__c FROM User_CheckinHistory__r ORDER BY Name DESC LIMIT 1) FROM Individual_Ticket_Info__c WHERE isCancelled__c != TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__c!=NULL AND Event_Attendee_Mapping__r.isCancelled__c != TRUE AND IsItem__c!=TRUE and  Registration_Info__r.Event_Attendee_Mapping__c IN :eamIdsfilterTicks AND  Registration_Info__r.customer_key__r.isInserted__c=true ORDER BY Name]){
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
    
        for(Individual_Ticket_Info__c iti:[SELECT Name,Amount__c, Refund_Amount__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,IsCancelled__c,isItem__c,Refund_Date__c,Refund_Mode__c,CreatedDate,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.payKey__c,Event_Attendee_Mapping__r.AS_id__r.id,Registration_Info__r.Payment_Type__c,Registration_Info__r.Tickets_Quantty__c,Registration_Info__r.Check_number__c,Registration_Info__r.Seat_Number__c,Registration_Info__r.TicketAmount__c,Registration_Info__r.customer_key__r.Name,Registration_Info__r.AttendeeSummary__c,Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.TicketTypes__c,Registration_Info__r.Event__c,Registration_Info__r.Name,Registration_Info__r.Ticket_Amount__c,Registration_Info__r.IndividualAmount__c,Registration_Info__r.Payment_Status__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c FROM Individual_Ticket_Info__c WHERE isCancelled__c =: TRUE AND Registration_Info__r.Event__c=:EventId AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL and Registration_Info__r.Event_Attendee_Mapping__c IN :eamIdsfilterTicks AND  Registration_Info__r.customer_key__r.isInserted__c=true ORDER BY Name]){
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
    
    
    global class Container
    {
        //public Integer totalAttendee{get;set;}
        public List<Attendee_Details> Attendee_Details{get;set;}
        public List<Payment_Info> Payment_Info{get;set;}
       
        public Container()
        {
            
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
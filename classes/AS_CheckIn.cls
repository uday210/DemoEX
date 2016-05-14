@RestResource(urlMapping='/AS_CheckIn/*')

    global with sharing class AS_CheckIn{
    @HttpPost  
    global static Container doPost(){
        RestRequest req = RestContext.request;  
        String EventID = req.params.get('Event_Id');
        RestResponse response = RestContext.response;  
        String jSONRequestBody=req.requestBody.toString().trim(); 
        
        JSONParser jsonParser = JSON.createParser(jSONRequestBody); 
        List<String> TicketNumber=new List<String>();
        List<String> isCheckIn=new List<String>();
        
        List<String> AttendeeIds=new List<String>();
        List<String> MobileCheckInTime=new List<String>();
      /*  
        SET<String> AttendeeIdsSet=new SET<String>();
        SET<String> MobileCheckInTimeSet=new SET<String>();
        */
        
        List<String> CheckInTime=new List<String>();
        List<String> UserId=new List<String>();
        System.debug('Getting body '+jSONRequestBody);
        
        while(jsonParser.nextToken() != null){
        
             if(jsonParser.getText()=='AttendeeId'){
                     jsonParser.nextToken();
                       if(null!=jsonParser.getText() && ''!=jsonParser.getText()){  
                          AttendeeIds.add(jsonParser.getText());                          
                      }
                  }
       
                  if(jsonParser.getText()=='MobileCheckInTime'){
                        jsonParser.nextToken();
                       if(null!=jsonParser.getText() && ''!=jsonParser.getText()){  
                          MobileCheckInTime.add(jsonParser.getText());                        
                        
                        }
                    }
        
        
            if(jsonParser.getCurrentToken() == JSONToken.START_ARRAY ){
            
                while(jsonParser.nextToken() != JSONToken.END_ARRAY){
                    if(jsonParser.getText()=='AttendeeId'){
                        jsonParser.nextToken();
                        if(null!=jsonParser.getText() && ''!=jsonParser.getText()){ 
                          AttendeeIds.add(jsonParser.getText());                          
                        }
                    }
                    if(jsonParser.getText()=='MobileCheckInTime'){
                        jsonParser.nextToken();
                         if(null!=jsonParser.getText() && ''!=jsonParser.getText()){
                           MobileCheckInTime.add(jsonParser.getText());
                         }                       
                    }
                    if(jsonParser.getText()=='TicketNumber'){
                        jsonParser.nextToken();
                        TicketNumber.add(jsonParser.getText());                          
                    }
                    if(jsonParser.getText()=='CheckInTime'){
                        jsonParser.nextToken();
                        CheckInTime.add(jsonParser.getText());                        
                    }
                    if(jsonParser.getText()=='isCheckIn'){
                        jsonParser.nextToken();
                        isCheckIn.add(jsonParser.getText());                          
                    }
                    if(jsonParser.getText()=='ScannedBy'){
                        jsonParser.nextToken();
                        UserId.add(jsonParser.getText());                          
                    }
                }
            }
        }
        
        Container ct=new Container();    
                    
        try{
            List<Event_Attendee_Mapping__c> att=[SELECT id,MobileCheckInTime__c,Is_CheckedIn__c FROM Event_Attendee_Mapping__c WHERE EV_id__c =: EventID AND AS_id__c IN :AttendeeIds limit 1];
            system.debug('### '+att);
            LIST<Event_Attendee_Mapping__c> UpdateAttendees= new LIST<Event_Attendee_Mapping__c>();
            for(Event_Attendee_Mapping__c a:att){
              for(integer i=0;i<TicketNumber.size();i++){   
              System.debug('PPPPPPPPPPPPPP '+a.Is_CheckedIn__c+'   '+isCheckIn[i].tolowerCase()); 
              if(Boolean.valueOf(isCheckIn[i]) == TRUE){
                      if(a.Is_CheckedIn__c != TRUE){
                          a.Is_CheckedIn__c = Boolean.valueOf(isCheckIn[i]);
                      } 
                    }
                 }
                 a.MobileCheckInTime__c = MobileCheckInTime[0]; 
                 UpdateAttendees.add(a); 
               
            }
            database.update(UpdateAttendees, FALSE);
            system.debug('%%%% '+att);
        }
        catch(Exception e){}
            
        try{
            ct.Ticket_Details=new List<Ticket_Details>();
            LIST<Individual_Ticket_Info__c> reslist= new LIST<Individual_Ticket_Info__c>();
            LIST<User_CheckinHistory__c> insertuclist= new LIST<User_CheckinHistory__c>();
            LIST<User_CheckinHistory__c> CheckinList= new LIST<User_CheckinHistory__c>();
            LIST<User_CheckinHistory__c> updateCheckinList= new LIST<User_CheckinHistory__c>();    
                    
           // ct.FailedRecords = new List<ct.FailedRecords>();
            
            for(integer j=0;j<TicketNumber.size();j++){
            
                Individual_Ticket_Info__c res=[SELECT Latest_Date_Time__c, Name,isCheckedIn__c,Seat__c,Scanned_by__c,Registration_Info__c,Registration_Info__r.Event__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_Id__c,Registration_Info__r.AttendeeSummary__c FROM Individual_Ticket_Info__c WHERE Name=:TicketNumber[j]];
                System.debug('QQQQQQQQQ '+res.isCheckedIn__c +'   '+Boolean.valueOf(isCheckIn[j].tolowerCase())); 
                boolean statusOfind = res.isCheckedIn__c;
                if( res.isCheckedIn__c == Boolean.valueOf(isCheckIn[j].tolowerCase())){
                  ct.FailedRecords.add(new FailedRecordscls(TicketNumber[j],res.isCheckedIn__c));
                }else{
                  res.isCheckedIn__c=Boolean.valueOf(isCheckIn[j]);
                }
                res.Latest_Date_Time__c= CheckInTime[j];
                res.Scanned_by__c=UserId[j];
                reslist.add(res);
                
                CheckinList = [SELECT Id,UC_CheckinTime__c,CheckoutTime__c,Individual_Ticket_Info__c FROM User_CheckinHistory__c WHERE Individual_Ticket_Info__r.Name =: TicketNumber[j]]; 
                String CheckedOutTime;
                if(CheckinList.size() > 0){
                    system.debug('  CHECK STATUS '+isCheckIn[j]);
                    if(Boolean.valueOf(isCheckIn[j]) == FALSE){
                        system.debug('  CHECK OUT0000000000 '+isCheckIn[j]);
                        for(User_CheckinHistory__c Checkin: CheckinList){
                            if(Checkin.UC_CheckinTime__c != NULL && Checkin.CheckoutTime__c == NULL){
                                Checkin.CheckoutTime__c = CheckInTime[j];
                                updateCheckinList.add(Checkin);
                                system.debug('  CHECK OUT1111111 '+isCheckIn[j]);
                            }
                        }
                    }
                    else{
                      if(res.isCheckedIn__c != statusOfind){
                        User_CheckinHistory__c uc = new User_CheckinHistory__c();
                        uc.UC_CheckinTime__c = CheckInTime[j];
                        uc.Individual_Ticket_Info__c = res.id;
                        insertuclist.add(uc);     
                      }  
                    }
                }else{
                
                    User_CheckinHistory__c uc = new User_CheckinHistory__c();
                    system.debug('&&&&&& '+CheckInTime[j]);
                    uc.UC_CheckinTime__c = CheckInTime[j];
                    uc.Individual_Ticket_Info__c = res.id;
                    insertuclist.add(uc);
                
                }  
            }  
            database.update(reslist,FALSE);  
            //database.update(CheckinList,FALSE);  
            database.update(updateCheckinList,FALSE);              
            system.debug('##### '+insertuclist); 
            Database.SaveResult[] srList = Database.insert(insertuclist, false);
            
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    System.debug('Check In ID: ' + sr.getId());
                }
                else{            
                    for(Database.Error err : sr.getErrors()) {                
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    }
                }
            }
            
            Ticket_Details tt=new Ticket_Details();
            String a='',b='',c='',d='';

            for(Individual_Ticket_Info__c dm:[SELECT Name,isCheckedIn__c,Seat__c,Scanned_by__c,Registration_Info__c,Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.MobileCheckInTime__c,Registration_Info__r.Event__c,Event_Attendee_Mapping__r.AS_Id__c,Registration_Info__r.TicketTypes__c,Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.AttendeeSummary__c FROM Individual_Ticket_Info__c WHERE Registration_Info__r.Event__c!= NULL AND Registration_Info__r.Event_Attendee_Mapping__c!=NULL AND Registration_Info__r.Event__c=:EventID AND IsItem__c= FALSE AND IsCancelled__c!= TRUE AND Event_Attendee_Mapping__r.AS_Id__c In:AttendeeIds AND Name IN : TicketNumber])
            {
                system.debug('$$$ '+dm);
                
                a=a+dm.Registration_Info__r.TicketTypes__c+',';
                b=b+dm.Registration_Info__r.TicketTypes__r.TT_Name__c+',';
                if(dm.isCheckedIn__c == true){
                    c=c+dm.Name+',';
                }
                else{
                    c=c+''+',';
                }
                d=d+dm.Name+',';
                tt.UserId=dm.Scanned_by__c;
                tt.AttendeeId=dm.Event_Attendee_Mapping__r.AS_Id__c;
                if(dm.Event_Attendee_Mapping__r.MobileCheckInTime__c!=null){
                tt.MobileCheckInTime=dm.Event_Attendee_Mapping__r.MobileCheckInTime__c;
                }else{
                tt.MobileCheckInTime='';
                }
            }
            try{
                a=a.substring(0,a.length()-1);
                b=b.substring(0,b.length()-1);
                c=c.substring(0,c.length()-1);
                d=d.substring(0,d.length()-1);
            }
            
            catch(Exception e){}
            
            tt.TicketNumbers=c;
            tt.TicketName=b;
            tt.TicketId=a;  
            tt.RegTicketNumbers=d;
            ct.Ticket_Details.add(tt);
            ct.message='success'; 
        }  
        catch(Exception e){
            ct.error=e.getMessage();
        }
        return ct;     
    }
    
    global class Container{
        public List<Ticket_Details> Ticket_Details{get;set;}
        public String message{get;set;}
        public String error{get;set;}
        public List<FailedRecordscls> FailedRecords = new List<FailedRecordscls>();
    }
    
   global class FailedRecordscls {
     public string TicketNumbers{get;set;}
     public string Message{get;set;}
     public string IsCheckdin{get;set;}
     
     public FailedRecordscls(string s,boolean b){
       this.TicketNumbers = s;
       this.IsCheckdin= string.valueOf(b);
        this.Message = 'This record is already Checkidin';
     }
     
   }
   
    global class Ticket_Details{
        public String AttendeeId{get;set;}
        public String TicketId{get;set;}
        public String TicketNumbers{get;set;}
        public String RegTicketNumbers{get;set;}
        public String TicketName{get;set;}
        public String MobileCheckInTime{get;set;}
        public String Userid{get;set;}
    }

 }
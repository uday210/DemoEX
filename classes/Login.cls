@RestResource(urlMapping='/LOGIN/*')

/*
 * AUTHOR : Venkatesh 
 * Email :  venkatesh@globalnest.com
 * AIM : To verify mobile user login
 ***/  
 
global class Login {
    
   // global static User_Profile_Event__c LoginUser;
    global static User LoginUser;
    global static List<Event_Attendee_Mapping__c> EventAttendee;
    global static String EmailId;
    global static String Password;
    //global static UserDetails userde;
    global static EventDetails evd;    
    global static List<EventDetails> EventDetails;
    global static String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    global static String orgId = UserInfo.getOrganizationId();
    global static String  Imageheader =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id=';
    global static AttendeeSummary__c UserAttendee = new AttendeeSummary__c();
    global static string ImageBlob;
    global static Attachment attBody;
            
      @HttpGet
       global static UserDetails doGet(){
       //Request Context
               RestRequest req = RestContext.request;
                RestResponse res = RestContext.response;
                System.debug('@@@@request'+req);  
                 List<id> listOfevents = new List<id>();
                EmailId = req.params.get('EmailID');
                System.debug('@@@@EmailId'+EmailId);  
                Password = req.params.get('Password');
                System.debug('@@@@Password'+Password);  
           // user  details are from here       
                try{
                    //LoginUser = [Select User_id__r.Id,User_id__r.FirstName,User_id__r.LastName,User_id__r.CompanyName,User_id__r.City,User_id__r.State,
                                        // User_id__r.Email, User_id__r.Phone From  User_Profile_Event__c where User_id__r.UserName=:EmailId AND  User_id__r.Password__c=:Password AND User_id__r.IsActive=True];
                
                
             //LoginUser = [Select Id,FirstName,LastName,CompanyName,City,State,
                                                                                                                                                                                                                                                                    //Email,Phone From User where UserName=:EmailId AND  Password__c=:Password AND IsActive=True ];
             List<User_Profile_Event__c>  listUPes = new LIst<User_Profile_Event__c>();
             listUPes =[select id,EV_id__c from User_Profile_Event__c where User_id__r.userName=:EmailId ];
            
             for(User_Profile_Event__c ut:listUPes ){
             listOfevents.add(ut.EV_id__c);
             }

             LoginUser = [Select Id,FirstName,LastName,CompanyName,City,State,Country__c,ProfileId,Email,Phone,States__c,Zipcode__c From User where UserName=:EmailId AND  Password__c=:Password AND IsActive=True ];
                
             
                UserAttendee  = [Select id,AS_ImageUrl__c from AttendeeSummary__c att where  att.AS_Email__c=:LoginUser.Email];

                try{
                
                attBody =[select id, body from Attachment  where parentId =:UserAttendee.id]; 
                ImageBlob = EncodingUtil.base64Encode(attBody.body);
                }     
                    
                catch(Exception ex){
                
                }    
                                        
             // LoginUser = [Select Id,FirstName,LastName,CompanyName,City,State,
              System.debug('@@@@@LoginUser'+LoginUser);
               If(LoginUser.IsActive = false){
                                                            
                    UserDetails usd = new UserDetails('The accountis inActive,Please Contact Administrator!','');
                    return usd;
                   }else if(LoginUser.ProfileId=='00eO0000000Dkr4IAC'){
                   
                    UserDetails usd = new UserDetails('','Event Admin cannot access mobile app');
                    System.debug('3333333333 '+usd);
return usd;
                    }
                    
                    
                }
                
          
                 catch(Exception ex){
                 System.debug('@@@@@ex'+ex.getMessage());
                 UserDetails usd = new UserDetails('','The Credentials are not matching with DB');
                 return usd;
                }
               
              // Event Information from here   
               
              
              EventAttendee =[Select EV_id__r.id,EV_id__r.EV_Title__c,EV_id__r.EV_StartDate__c,EV_id__r.StartTime__c,EV_id__r.EV_EndTime__c,EV_id__r.EV_HostingLocation__c,EV_id__r.EV_EventLogo__c,EV_id__r.Status__c,EV_id__r.EV_EndDate__c,EV_id__r.EV_Description__c, 
                                                                                                    EV_id__r.EV_HistingAddr1__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingCountry__c,EV_id__r.EV_HostingFax__c,EV_id__r.EV_HostingPhone__c,EV_id__r.EV_HostingPostalCode__c,EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingTimeZone__c,EV_id__r.EV_HostingZipcode__c  From Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:EmailId and EV_id__c IN :listOfevents
                                                                                                                        Order By EV_id__r.EV_StartDate__c];
              /**
                                                                                EventAttendee =[Select EV_id__r.id,EV_id__r.EV_Title__c,EV_id__r.EV_StartDate__c,EV_id__r.StartTime__c,EV_id__r.EV_EndTime__c,EV_id__r.EV_HostingLocation__c,EV_id__r.EV_EventLogo__c,EV_id__r.Status__c,EV_id__r.EV_EndDate__c,EV_id__r.EV_Description__c, 
                                                                                                    EV_id__r.EV_HistingAddr1__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingCountry__c,EV_id__r.EV_HostingFax__c,EV_id__r.EV_HostingPhone__c,EV_id__r.EV_HostingPostalCode__c,EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingTimeZone__c,EV_id__r.EV_HostingZipcode__c  From Event_Attendee_Mapping__c where AS_id__r.AS_Email__c='boothleads.ba@gmail.com' Order By EV_id__r.EV_StartDate__c];
                                                                                **/    
                System.debug('@@@@@EventAttendee'+EventAttendee);            
                                                                                                                                            
                  EventDetails = new List<EventDetails>();
                 
                 
                 
              //UserDetails usd = new UserDetails(LoginUser.User_id__r.Id,LoginUser.User_id__r.FirstName,LoginUser.User_id__r.LastName,LoginUser.User_id__r.CompanyName,LoginUser.User_id__r.City,LoginUser.User_id__r.State,
                                        // LoginUser.User_id__r.Phone,LoginUser.User_id__r.Email);
                 
                 
                   UserDetails usd = new UserDetails(LoginUser.Id,LoginUser.FirstName,LoginUser.LastName,LoginUser.CompanyName,LoginUser.City,LoginUser.States__C, LoginUser.Phone,LoginUser.Email,ImageBlob,LoginUser.Country__c);
                 
                 
                 for(Event_Attendee_Mapping__c Eat:EventAttendee){
                    
                    //EventDetails 

evd = new EventDetails();

System.debug('@@@@@evd'+evd);
                    
                    evd.Event_ID = Eat.EV_id__r.id;
                    
                    evd.Event_Name = Eat.EV_id__r.EV_Title__c;
                    
                    evd.Event_StartDate = Eat.EV_id__r.EV_StartDate__c;
                    
                    evd.Event_StartHour = Eat.EV_id__r.StartTime__c;
                    
                    evd.Event_EndHour = Eat.EV_id__r.EV_EndTime__c;
                    
                   // evd.Event_Location = Eat.EV_id__r.EV_HostingLocation__c+' '+ Eat.EV_id__r.EV_HistingAddr1__c+' '+Eat.EV_id__r.AS_HostingAddr2__c+' '+Eat.EV_id__r.AS_HostingCity__c+' '+Eat.EV_id__r.EV_HostingPhone__c+' '+Eat.EV_id__r.EV_HostingPostalCode__c+' '+Eat.EV_id__r.EV_HostingState__c+' '+Eat.EV_id__r.EV_HostingCountry__c;
                    
                    evd.Event_Location = Eat.EV_id__r.EV_HostingLocation__c;
                    evd.EventLogoImageURL = Imageheader+Eat.EV_id__r.EV_EventLogo__c;
                    
                    evd.Status = Eat.EV_id__r.Status__c;
                    
                    evd.Event_Date = String.ValueOf(Eat.EV_id__r.EV_EndDate__c);
                    
                    evd.Event_Description =  Eat.EV_id__r.EV_Description__c; 
                    
                    evd.HostingAddr1  = Eat.EV_id__r.EV_HistingAddr1__c;
                    
evd.HostingAddr2 = Eat.EV_id__r.AS_HostingAddr2__c;
                    
evd.HostingCity = Eat.EV_id__r.AS_HostingCity__c;
                    
                    evd.HostingCountry = Eat.EV_id__r.EV_HostingCountry__c;
                    
                
evd.HostingZipcode = Eat.EV_id__r.EV_HostingPostalCode__c;
                  
                    

evd.HostingPhone = Eat.EV_id__r.EV_HostingPhone__c;
                 
                    usd.Edetails.add(evd);
                    
                 }
                                                                                                                                                                                                                            
                System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@EventDetails'+usd.Edetails);                
                                                                                                                                                                                                                            
                                                                                                                                                                                                                            
                                                                                
                                                                                                                        
               System.debug('@@@@@usd'+usd);
        
                
                return usd;
                
               
                
            }







 global class UserDetails{
            
            Id UserID;
            
            String FirstName;
            
            String LastName;
            
            String Company;
            
            String City;
            
            String State;
            
            String PhoneNo;
            
            String Email;
            
           String message;
                
           String error;
           
           string  dtime;
           
           String ImageUrl;
           String Country;
            
            global EventDetails[] Edetails;
            
                global UserDetails(String message1, String error1){
                    
                    error = error1;
                
                    message= message1;
                }
            global UserDetails(Id UserID1,String FirstName1,String LastName1, String Company1,String City1,String State1,String PhoneNo1,String Email1,String ImageUrl1,String Country1){
                
                UserID =UserID1;
                FirstName = FirstName1;
                
                LastName = LastName1;
                
                Company = Company1;
                
                City = City1;
                
                State= State1;
                
                PhoneNo = PhoneNo1;
                
                Email = Email1;
                
                ImageUrl = ImageUrl1;
                Country = Country1;
                dtime=string.valueOf(system.now());
                Edetails = new List<EventDetails>();
                
            }
            
            }
            
  global  class EventDetails{
                
                
                
                Id Event_ID;
                
                String Event_Name;
                
                Date Event_StartDate;
                
                String Event_StartHour;
                
                String Event_EndHour;
                
               
                
                String Event_Location;
                
                String EventLogoImageURL;
                
                String Status;
                
                String Event_Date;
                
                String Event_Description;
                
                String HostingAddr1;
                
                String HostingAddr2;
                
                String HostingCity;
                
                String HostingState;
                
                String HostingCountry;
                
                String HostingZipcode;
                
                String HostingPhone;
                
                
                global EventDetails(){
                    
                }
                
             
      global EventDetails(Id Event_ID1,String Event_Name1,Date Event_StartDate1,String Event_StartHour1,String Event_EndHour1,String Event_Location1,String EventLogoImageURL1,String Status1,String Event_Date1,String Event_Description1,String HostingAddr1a,String HostingAddr2a,String HostingCity1,String HostingState1,String HostingCountry1,String HostingZipcode1,String HostingPhone1)
      {
                    
                  
                 
                    Event_ID = Event_ID1;
                    
                    Event_StartDate = Event_StartDate1;
                    
                    Event_StartHour = Event_StartHour1;
                    
                    Event_EndHour =Event_EndHour1;
                    
                    Event_Location = Event_Location1;
                    
                    Event_Date = Event_Date1;
                    
                    EventLogoImageURL = EventLogoImageURL1;
                    
                    Status = Status1;
                    
                    Event_Description = Event_Description1;
                    
HostingAddr1 = HostingAddr1a;
                    
HostingAddr2 = HostingAddr2a;
                    
HostingCity = HostingCity1;
                    
HostingState = HostingState1;
                    
HostingCountry = HostingCountry1;
                    
HostingZipcode = HostingZipcode1;
                    
                    HostingPhone = HostingPhone1;
                    
                    
                    
}
 }  
 
 
 
       
            
    // -------------------------------- Test Class -------------------------
  static testMethod void testRest() {
       contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
       user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
       emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
       localesidkey='en_US',country='United States',
       timezonesidkey='America/Los_Angeles', username='boothadmin@boothleads.com',CompanyName='Nest',Title='dev');
       insert u;
       System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
       u.password__c =rt.getPassword();
   
       update u;
       string pwd =rt.getPassword();
      
            
       AttendeeSummary__c attsum = new AttendeeSummary__c(AS_FirstName__c='phani',AS_LastName__c='Testing',AS_Email__c='boothadmin@boothleads.com');
       insert attsum ;
      
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
       EV_EndDate__c = Date.Parse('01/18/2014'),
       EV_StartDate__c = Date.Parse('01/18/2014'),
       EV_EndTime__c='09:00 AM',
       StartTime__c='11:00 AM');
       insert eve;
      
       string attendeeEvent= string.valueOf(attsum.Id)+string.valueOf(eve);
      
       Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=eve.Id,AS_id__c=attsum.Id);
       insert event_att_map ;
      
      
      
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/LOGIN';
       RestContext.request.addParameter('EmailID', 'boothadmin@boothleads.com');
       RestContext.request.addParameter('Password',pwd );
       LOGIN.doGet();
      EventDetails eventdetailsInn = new EventDetails(eve.Id,eve.EV_Title__c,eve.EV_StartDate__c,'','','','','Event In Progress','','','','','hyd','Ap','India','1234','9874563210');
      UserDetails userDetail = new UserDetails('Message','Error');
     
      
       }          
     
     
     
     
}
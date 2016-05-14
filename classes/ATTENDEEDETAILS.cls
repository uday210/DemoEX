@RestResource(urlMapping='/ATTENDEEDETAILS/*')

/*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : ATTENDEEDETAILS is for  getting Attendee Summary Information
 */


  global with sharing class ATTENDEEDETAILS{
    
  global static String EventId;
  global static String UserID; 
  
  global static List<Event_Attendee_Mapping__c>  EAmapping;
    
   global static List<AttendeeDetails1> AD1 = new List<AttendeeDetails1>();  
   
     @HttpGet
    
    global static List<AttendeeDetails1>  doGet(){
    
     RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    System.debug('@@@@@req'+req);
    
    EventId = req.params.get('EventId');
    
    System.debug('@@@@@EventId'+EventId);
    
    UserID  = req.params.get('UserID');
   System.debug('@@@@@UserID'+UserID);
    
    try{
         User u = [select Email,username from User where id =:UserID];
            System.debug('@@@@@u'+u);
          Event_Attendee_Mapping__c Emap = [select id from  Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c=:u.Email AND  EV_id__r.id =:EventId limit 1];        
               System.debug('@@@@@Emap'+Emap);
        }
        
      catch(Exception ex) {
     
     AttendeeDetails1 b1 = new AttendeeDetails1('You are not registered to this event');
            
    System.debug('@@@@@b1'+b1 );
  
    AD1.add(b1);         
          
     return AD1;
        }  
    
    try{
    
    EAmapping = [Select AS_id__r.id,AS_id__r.AS_Title__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_WorkState__c,EA_AttendeeBarcode__c from Event_Attendee_Mapping__c where EV_id__r.id=:EventId Order by AS_id__r.id];
   
    System.debug('@@@@@EAmapping'+EAmapping );
   
   
   For(Event_Attendee_Mapping__c EAM :EAmapping  ){
   
   
   AttendeeDetails1 at1 = new AttendeeDetails1(EAM.AS_id__r.id,EAM.AS_id__r.AS_ImageUrl__c,EAM.AS_id__r.AS_FirstName__c,EAM.AS_id__r.AS_LastName__c,EAM.AS_id__r.AS_Company__c,EAM.AS_id__r.AS_Email__c,EAM.AS_id__r.AS_WorkPhone__c,EAM.AS_id__r.AS_WorkCity__c,EAM.AS_id__r.AS_WorkState__c,EAM.AS_id__r.AS_Title__c,EAM.EA_AttendeeBarcode__c,EAM.id);
   
      System.debug('@@@@@at1 '+at1);
   
    AD1.add(at1);         
          
    
   
   
   }
   
    return AD1;

   
    }
    
    
    catch(exception ex){
    
    AttendeeDetails1 b1 = new AttendeeDetails1('Attendees are not registered to the event!');
            
    System.debug('@@@@@b1'+b1 );
  
    AD1.add(b1);         
          
     return AD1;
    
    }
    
    
    
    return null;
    
    }
    
    
    
  global class AttendeeDetails1{
    
   ID Attendee_QR_ID;
   
   String Image_URL;
   
   String FirstName;
   
   String LastName;
   
   String Company;
  
   String Email;
   
   String PhoneNo;

   String City;

   String State;

   String message;
   
   String Barcode;
 
   String Title;
   
   String BarcodeId;
   
   
   global AttendeeDetails1( ID Attendee_QR_ID1,String Image_URL1,String  FirstName1, String  LastName1,String Company1,String Email1, String PhoneNo1,String City1,String State1,String Title1,String Barcode1,String BarcodeId1){
   
   Attendee_QR_ID = Attendee_QR_ID1;
   
   Image_URL = Image_URL1;
   
   FirstName = FirstName1;
   
   LastName = LastName1;
   
   Company = Company1;
   
   Email = Email1;
   
   PhoneNo = PhoneNo1;
   
   City = City1;
   
   State = State1;
   
   Title = Title1;
   
   Barcode = Barcode1;
   
   BarcodeId = BarcodeId1;
   
   }
   
   
   global AttendeeDetails1(String message1){
   
   message = message1;
   
   }
    }
  
 
    
    
    }
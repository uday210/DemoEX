public without sharing class BL_Eventadmin_addAttendeesCon {

    public PageReference deleteRecord() {
    string s= ApexPages.currentPage().getParaMeters().get('sendingId');
    system.debug('YYYYYYYYYYYYYYYY '+s);
    Dummay__c d= new Dummay__c();
    try{
    d =[select id,Email__c from Dummay__c where id=:s];
    string email = d.Email__c;
    
    List<Event_Attendee_Mapping__c> eams = new List<Event_Attendee_Mapping__c>();
    eams =[select AS_id__r.AS_Email__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:email ];
     updateUser(email);
    List<AttendeeSummary__c> attList = new List<AttendeeSummary__c>();
    attList =[select id from AttendeeSummary__c where AS_Email__c=:email];
       
    List<User_Profile_Event__c> upes = new List<User_Profile_Event__c>();
    upes =[select id from User_Profile_Event__c where User_id__r.userName=:email ];
   
  
        
    dataBase.delete(upes,false);
    DataBase.delete(eams,false );
    DataBase.delete(attList,false );
   
   
    
    dataBase.DeleteResult res2= dataBase.delete(d,false);
    system.debug('ZZZZZZZZZZZZZZZz '+res2);
     }catch(exception e){}
    firstMethod();
    return null;
    }

@future 
public static void updateUser(string email){
  List<user> ut2 = new List<user>();
     for(user  ut:[select username,email,isActive  from user where userName=:email ]){
      List<string> str = new List<string>();
      str = ut.userName.split('@');
    
      string s1=str[0]+math.random()+'@';
      string abc = s1+str[1];
      ut.email=abc;
      ut.userName =abc;
      ut.isactive =false;
      ut2.add(ut);
       dataBase.saveResult[] res =  dataBase.update(ut2,false);
      system.debug('YYYYYYYYYYYYYYYY 33333333333333'+res );
    }
}

public List<Dummay__c> sponserDhippackages{get;set;}
public Event__c event{get;set;}
public MAP<id,Dummay__c> mapDummay {get;set;}
public id eventid{get;set;}
 public BL_Eventadmin_addAttendeesCon(){
 firstMethod();
 
 }

 public void firstMethod(){
 try{
 eventid = Apexpages.currentpage().getParameters().get('id');
 mapDummay =new MAP<id,Dummay__c>();
 event = new Event__c();
 sponserDhippackages = new List<Dummay__c>();
 sponserDhippackages  = [select id,First_Name__c,Event__c,Event__r.id,Last_Name__c,Email__c,Phone__c,Attendees_Available__c,TicketTypes__r.TT_Name__c from Dummay__c where (TicketTypes__r.Section_Name__c ='SPONSORSHIP PACKAGES' OR TicketTypes__r.Section_Name__c ='ANNUAl SPONSORSHIP PACKAGES' OR TicketTypes__r.Section_Name__c ='ACTIVITY SPONSORSHIP PACKAGES') and Event__c=:eventid];
 event =[select id,EV_EventLogo__c,EV_HistingAddr1__c,AS_HostingAddr2__c ,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingCountry__c ,EV_Title__c,EV_StartDate__c,StartTime__c,EV_EndDate__c,EV_EndTime__c,EV_HostingStateNew__c  from Event__c ];

 }catch(exception e){}
 }


}
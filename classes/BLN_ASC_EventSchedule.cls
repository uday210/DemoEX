@RestResource(urlMapping='/BLN_ASC_EventSchedule/*')
/***********************************************************************************************
*   Service Name : BLN_ASC_EventSchedule
*   Date            : 07/01/2015
*   Author          : Arindam Sarkar
*   Purpose         : This class is for getting all event schdule from timeslot and aganeda object
************************************************************************************************/
  

    global with sharing class BLN_ASC_EventSchedule{
   
    global static BLN_SeminarsCon semcon{get;set;}
    @HttpPost  
    global static List<Container> doPost(){
        RestRequest req = RestContext.request;  
        String EventID = req.params.get('Event_Id');
        
             
        RestResponse response = RestContext.response; 
        semcon=new BLN_SeminarsCon();
        semcon.selectedeventid=EventID;
        semcon.gaterFields();
        semcon.onchangeAct();
        BLN_Event_DAO evdao=new BLN_Event_DAO();
        String timezone;
        List<BLN_Event__c> eve=evdao.getEventDetails(EventID);
        if(eve.size()>0)
        {
           timezone=eve[0].Time_Zone__c;
        }
        
        List<Container> conlist=new List<Container>();
        for(integer i=0;i<semcon.seminarInn.size();i++)
        {
           System.debug('sssssss:'+semcon.seminarInn.size());
            for(integer j=0;j<semcon.seminarInn[i].agendaList.size();j++){
           Container con=new Container();
           con.TrackDescription=semcon.seminarInn[i].agendalist[j].Agenda_Description__c==null?'':semcon.seminarInn[i].agendalist[j].Agenda_Description__c;
          
           for(Time_Slots__c tm:semcon.seminarInn[i].agendaList[j].Time_Slots__r)
           {
           con.AgendaID=semcon.seminarInn[i].agendaList[j].Id;
           con.ProgrammeName=semcon.seminarInn[i].agendaList[j].Name;
           Datetime startdate= tm.Slot_Start_date__c;
           String stringstartdate= startdate.format('yyyy-MM-dd', timezone); 
 
           con.ProgrammeDate=stringstartdate;
           String stringstarttime= startdate.format('hh:mm a',timezone);
           con.StartTime=stringstarttime;
           Datetime endtime= tm.Slot_End_date__c;
           String stringendtime= endtime.format('hh:mm a',timezone);
           con.EndTime=stringendtime;
           
           }
           
           con.tktprofiles=new List<tktprofile>();
           
           for(Participant__c pc:semcon.agendaParticipants.get(semcon.seminarInn[i].agendaList[j].id))
           {
              tktprofile gn=new tktprofile();
              gn.FirstName=pc.BLN_TKT_profile__r.First_Name__c==null?'':pc.BLN_TKT_profile__r.First_Name__c;
              gn.LastName=pc.BLN_TKT_profile__r.Last_Name__c==null?'':pc.BLN_TKT_profile__r.Last_Name__c;
              
              // Added Id, Email, title,Pic, Company
              gn.tktprofile_Id                = pc.BLN_TKT_profile__r.id==null?'':pc.BLN_TKT_profile__r.id;         
              gn.tktprofile_Email_Id          = pc.BLN_TKT_profile__r.Email__c==null?'':pc.BLN_TKT_profile__r.Email__c;                           
              gn.tktprofile_Pic_URL           = pc.BLN_TKT_profile__r.User_Pic__c==null?'':pc.BLN_TKT_profile__r.User_Pic__c;
              gn.tktprofile_Company           = pc.BLN_TKT_profile__r.TKT_Company__c==null?'':pc.BLN_TKT_profile__r.TKT_Company__c;
              gn.tktprofile_Youtube           = pc.BLN_TKT_profile__r.Video__c==null?'':pc.BLN_TKT_profile__r.Video__c;
              gn.tktprofile_Twitter           = pc.BLN_TKT_profile__r.TwitterId__c==null?'':pc.BLN_TKT_profile__r.TwitterId__c;
              gn.tktprofile_SpeakerBlog       = pc.BLN_TKT_profile__r.Blogger__c==null?'':pc.BLN_TKT_profile__r.Blogger__c;
              gn.tktprofile_linkedin          = pc.BLN_TKT_profile__r.LinkedInId__c==null?'':pc.BLN_TKT_profile__r.LinkedInId__c;
              gn.tktprofile_Facebook          = pc.BLN_TKT_profile__r.FaceBookId__c==null?'':pc.BLN_TKT_profile__r.FaceBookId__c;
              gn.tktprofile_CompanyWebSite    = pc.BLN_TKT_profile__r.Company_Website_URL__c==null?'':pc.BLN_TKT_profile__r.Company_Website_URL__c;
              gn.tktprofile_CompanyLogo       = pc.BLN_TKT_profile__r.Company_Logo__c==null?'':pc.BLN_TKT_profile__r.Company_Logo__c;
              gn.tktprofile_Biography         = pc.BLN_TKT_profile__r.Biography__c==null?'':pc.BLN_TKT_profile__r.Biography__c;
              gn.tktprofile_City              = pc.BLN_TKT_profile__r.Home_Address__r.City__c==null?'':pc.BLN_TKT_profile__r.Home_Address__r.City__c;
              gn.tktprofile_State             = pc.BLN_TKT_profile__r.Home_Address__r.State__c==null?'':pc.BLN_TKT_profile__r.Home_Address__r.State__c;
              gn.tktprofile_Country           = pc.BLN_TKT_profile__r.Home_Address__r.Country__c==null?'':pc.BLN_TKT_profile__r.Home_Address__r.Country__c;
              con.tktprofiles.add(gn);
           }
           
           con.ROOMS=new List<ROOM>();
           
           for(Time_Slots__c tm:semcon.seminarInn[i].agendaList[j].Time_Slots__r)
           {
           if(tm.Room__r.NAME!=null){
           ROOM r=new ROOM();
           r.ROOMNAME=tm.Room__r.NAME;
           r.ROOMNUMBER=tm.Room__r.Room_Number__c;
           con.ROOMS.add(r);}
           
           }
           
           
           
           conlist.add(con);
           }
        }
        
        return conlist;
        
        
      }
      
      
      
      global class Container
      {
        public String AgendaID{get;set;}
        public String ProgrammeName{get;set;}
        public String ProgrammeDate{get;set;}
        public String StartTime{get;set;}
        public String EndTime{get;set;}
        public List<tktprofile> tktprofiles{get;set;}
        public List<ROOM> ROOMS{get;set;}
        public String TrackDescription{get;set;}
      }
      
      global class tktprofile
      {
        public String FirstName{get;set;}
        public String LastName{get;set;}
        
        // Added Id, Email, title,Pic, Company
        public String tktprofile_Id{get;set;}
        public String tktprofile_Email_Id{get;set;}
        public String tktprofile_Pic_URL{get;set;}
        public String tktprofile_Company{get;set;}
        public String tktprofile_Youtube{get;set;}
        public String tktprofile_Twitter{get;set;}
        public String tktprofile_SpeakerBlog{get;set;}
        public String tktprofile_linkedin{get;set;}
        public String tktprofile_Facebook{get;set;}       
        public String tktprofile_CompanyWebSite{get;set;}
        public String tktprofile_CompanyLogo{get;set;}
        public String tktprofile_Biography{get;set;}
        public String tktprofile_City{get;set;}
        public String tktprofile_State{get;set;}
        public String tktprofile_Country{get;set;}
        
        
      }
      
      
      global class ROOM
      {
        public String ROOMNAME{get;set;}
        public String ROOMNUMBER{get;set;}
      }
      
      
    
      
      
      }
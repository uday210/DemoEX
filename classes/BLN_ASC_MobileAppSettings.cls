@RestResource(urlMapping='/BLN_ASC_MobileAppSettings/*')
/***********************************************************************************************
*   Service Name : BLN_ASC_MobileAppSettings
*   Date            : 25/06/2015
*   Author          : Sai 
*   Purpose         : This class is for getting visibility for Mobile App Settings
************************************************************************************************/
  

    global with sharing class BLN_ASC_MobileAppSettings{
    
    @HttpPost  
    global static MainContainer1 doPost(string EventID,string Userid){
        RestRequest req = RestContext.request;  
      if(EventID==null){
        EventID=req.params.get('Event_Id');
        }
        if(Userid==null)
        Userid=req.params.get('User_id');
        
        boolean Seminarsflag=false;
        boolean Exhibitorflag=false;
        boolean Sponsorsflag=false;
        boolean Speakersflag=false;
        BLN_Reg_Settings_DAO regDAO;
        BLN_Ticket_DAO ticDAO;
        MainContainer1 mc=new MainContainer1();
             
        RestResponse response = RestContext.response;
        
        bln_app_settings_BAL appcon=new bln_app_settings_BAL();
        appcon.checkticdetails(EventID);
        Seminarsflag= appcon.Seminarsflag;
        Exhibitorflag= appcon.Exhibitorflag;
        Sponsorsflag= appcon.Sponsorsflag;
        Speakersflag= appcon.Speakersflag;

        
         regDAO = new BLN_Reg_Settings_DAO();
         List<Reg_Setting__c> Reg=  regDAO.getregsetlist(EventID);
         
         List<Container> container=new List<Container>();
         
         boolean leadbool=false;
         leadbool=getleadinclude(EventID,Userid);
         
         for(Reg_Setting__c tc:Reg)
         {
          Container cnt=new Container();
         
          if((tc.Defaullt_Label__c!='Speakers')&& (tc.Defaullt_Label__c!='Sponsors' ) && (tc.Defaullt_Label__c!='Exhibitors')&& (tc.Defaullt_Label__c!='Seminars' )){
          cnt.eventid = EventID;
          cnt.id = tc.id;
          cnt.ColumnName=tc.Defaullt_Label__c;
          cnt.Columnlabel=tc.Label_Name__c==null?'':tc.Label_Name__c;
          if(tc.Defaullt_Label__c=='Lead Retrieval' && leadbool==true){
              cnt.Include=tc.Included__c;
          }else if(tc.Defaullt_Label__c=='Lead Retrieval' && leadbool==false){
              cnt.Include=leadbool;
          }else{
              cnt.Include=tc.Included__c;
          }
          
          container.add(cnt); 
         }else if((tc.Defaullt_Label__c=='Speakers' && Speakersflag==true) || (tc.Defaullt_Label__c=='Sponsors' && Sponsorsflag==true) || (tc.Defaullt_Label__c=='Exhibitors' && Exhibitorflag==true) || (tc.Defaullt_Label__c=='Seminars' && Seminarsflag==true))
          {
          cnt.eventid = EventID;
          cnt.id = tc.id;
          cnt.ColumnName=tc.Defaullt_Label__c;
          cnt.Columnlabel=tc.Label_Name__c==null?'':tc.Label_Name__c;
          cnt.Include=tc.Included__c;
          
          container.add(cnt); 
         }
         }
          mc.details=new List<Container>();
         mc.details=container;
        return mc;
      }
      
      
      
      global Class Container
      {    public string EventID{get;set;}
           public String ColumnName{get;set;}
           public String Columnlabel{get;set;}
           public Boolean Include{get;set;}
           public string id{get;set;}
      }
      
  global class MainContainer1
      {
         List<Container> details{get;set;}

      }
      
      global static boolean getleadinclude(string EventID,string Userid){
          LIST<ticket__c> tlist=new LIST<ticket__C>();
          boolean leadbool=false;
          tlist=[select Item_Pool__r.Item_Type__r.Name,Item_Type__r.Name from ticket__c where Order__r.Order_Status__c IN ('Partially Paid','Fully Paid','Check Not Received') AND Ticket_Status__c!='Cancelled' and tkt_profile__r.BLN_GN_User__r.User__c=:Userid and Event__c = :EventID];
         
          for(ticket__c t:tlist){
              if(t.Item_Pool__r.Item_Type__r.Name == 'Lead Retrieval'||t.Item_Type__r.Name == 'Lead Retrieval')
                      leadbool=true;
          }
          return leadbool;
      }
      
      }
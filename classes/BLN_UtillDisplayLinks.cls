public class BLN_UtillDisplayLinks{
 
 public string tablabel {get;set;}
 public string eventId {get;set;}
  public string eventName {get;set;}
  public string eventTimezone{get;set;}
  
  public string iseventsExpand{get;set;}
  
 public string isDashboardPage{get;set;}
 public string isSADashboardPage {get;set;}
 public string isBLDashboardPage {get;set;}
 public string isTicketsPage{get;set;}
 public string ispromocodesPage{get;set;}
 public string issurveyPage{get;set;}
 
 // Attendee PAge
 public string isAttendeesPage{get;set;}
 public string isimportAttendeesPage{get;set;}
 public string isAttendeeSettingsPage{get;set;}
 
  //Booths Page
 public string isBoothsPage{get;set;}
 
 //leads page
 public string isLeadRetrieval{get;set;}
 public string isLeadExpand{get;set;}
 public string isLeadReport{get;set;}
 public string isLeadExbReport{get;set;}
 
 
 //AppSettings Page
 public string isAppSettingsPage{get;set;}
 
// Ragistration Page
 public string isregistrationPage{get;set;}
 public string isonsiteRegistrationPage{get;set;}
 public string isIframeRegSetPage{get;set;}
 public string isDispalySettingsPage{get;set;}  
 public string isDisplaySettingsPage{get;set;} 
 public string ispaymentSettingsPage{get;set;}
  
 // Seminars Page...............................
 public string isSeminorsPage{get; set;}
 public String isSeminorsPageExpand{get; set;}
 public String isTracksPage{get; set;}
 public string isroomsPage{get; set;}
 public String isSpeackersPage{get; set;}
 public String iseventschedulePage{get; set;}
 public String isLRAdminAct{get;set;} 
 //public String isLeadExpand{get;set;}
    // Reports Page...............................
    public string isReportsPageExpand{get;set;}
    public string isSurveyQuestionReportsPageExpand{get;set;}      
    public string isOrderReportPage{get; set;}
    public string isAbandonedOrderReportPage {get;set;}
    public string isOrdersummaryReportPage {get; set;}
    public String isTicketReportPage{get; set;}
    public string isAttendeeReportPage{get; set;}
    public String isAttendeeDetailReportPage{get; set;}
    public String isPromocodeReportPage{get; set;}
    public String isSurveyQuestionReportPage{get; set;}
    public String isCheckinHistoryReportPage{get;set;}
    public String isnotCheckinReportPage{get;set;}
    public String isrevisitReportPage{get;set;}
    public String isFirstVisitReportPage{get;set;}
    
    public String isSurveyByQuestionReportPage{get; set;}
    public String isSurveyByTicketReportPage{get; set;}
    public String isSurveyByAttendeeReportPage{get; set;}
 // --------------------------------------------------------------------- Expand Page ------------------------------------------ 
  public string isTicketsPageExpand{get;set;}
 
 // Attendee PAge
 public string isAttendeesPageExpand{get;set;}

// Ragistration Page
 public string isregistrationPageExpand{get;set;}
 public string isemailsPage{get;set;}
 public string isemailcampaignpage {get ; set ;}
 public string ispushnotificationPage{get;set;}
 
// ---------------------------------------------------------- End ----------------------------------------------
 
 
 // Orders Page
 public string isOrdersPage{get;set;}
 //Event Staff Page
 public string isEventsettingsExpand {get ; set ;}
 public string isEventsettings {get ; set ;}
 public string isEventsettingsPage {get ; set ;}
 public string isEventstaffPage {get ; set ;}
 public string isEventstaffsettingsPage {get ; set ;}
 
 // Booleans to display or hide according to role
    public boolean isAttendee {get;set;}
    public boolean isBoothAdmin {get;set;}
    public boolean isBoothStaff {get;set;}
    public boolean isCompanyAdmin {get;set;}
    public boolean isEventAdmin {get;set;}
    public boolean isEventStaff {get;set;}
    public boolean isMatchLeadsBuyer {get;set;}
    public boolean isMatchLeadsSeller {get;set;}
    //FOR EVENT STAFF SETTINGS
    public boolean IstickettabAvailable {get ; set ;}
    public boolean IsAttendeeTabAvailable {get ; set ;}
    public boolean IsDashboardTabAvailable {get ; set ;}
    public boolean IsRegistrationTabAvailable {get ; set ;}
    public boolean IsReportsTabAvailable {get ; set ;}
    public boolean IsSeminarTabAvailable {get ; set ;}
    public boolean IsEventSettingsTabAvailable {get ; set ;}
    public string isTicketFeeSettingsPage {get ; set ;}
    public boolean IsLeadTabAvailable {get ; set ;}
    public boolean IsScanAttendeeSessionAvailable {get ; set ;}
    public BLN_Ticket_DAO ticDAO{get;set;}
    public boolean isproductbuyer{get;set;}
    public boolean iseveOganizer{get;set;}
    public boolean IsSurveyQuestionReportsTabAvailable {get ; set ;}
      
   //Match Leads Tab variables
    public string isMatchDshbrd{get;set;}
    public string isMatchLdsClndr{get;set;}
    public string isMatchLeadsApoint{get;set;}
    public string isMatchCalndrSetup{get;set;}
    public string isMatchLdsByrSetup{get;set;}
    public string isMatchLdsSllr{get;set;}
    public string isMatchLdsFilterSetup{get;set;}
    public string isMatchLeadsTab{get;set;}
    public string IsMatchSchedule{get;set;}
    public string isMatchMakingEvent{get;set;}
    public boolean isMMavailable{get;set;}
      
    // Documents page and Gallery Page
    public String  isdocumentsPage{get;set;}
    public String isgalleryPage{get;set;}
    public boolean IsSATabAvailable{get;set;}
    public string isSAExpand {get ; set ;}
    public string isSAreportExpand {get ; set ;}
    public string eventStatus{get;set;}

    public LIST<Reg_Setting__c> ESsettings {get ; set ;}
    
       public void userPermissions(string uid , string eveid){
         ESsettings  = new LIST<Reg_Setting__c>();
         
         system.debug('         eveid' +eveid);
         BLN_Event__c eve=new BLN_Event__c();
        try{ 
         eve =[select id,name,Organizer_Email__c,owner.email,Event_Status__c from BLN_Event__c where id=:eveid];
         }catch(exception er){}
         
         eventStatus = eve.Event_Status__c;
         
           isEventAdmin = true; // This is temparary i am giving. In general we should use for loop which is in comment.
         
             IsAttendeeTabAvailable = true;
             IstickettabAvailable = true;
             IsDashboardTabAvailable = true;
             IsReportsTabAvailable = true;
             IsSurveyQuestionReportsTabAvailable =true;
             IsSeminarTabAvailable = true;
             IsRegistrationTabAvailable = true;
             IsSATabAvailable=false;
             isMMavailable = false;
             
             if((isLeadRetrieval==''||isLeadRetrieval==null)&&(isBLDashboardPage=='' || isBLDashboardPage==null)&&(isLeadExbReport=='' || isLeadExbReport==null)&&(isLeadReport=='' || isLeadReport==null))
             iseventsExpand = 'expand';
             isproductbuyer =false;
    if(eveid!='All'){
                if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.OwnerId==UserInfo.getuserid()){
                    iseveOganizer = true;
                }else{
                    iseveOganizer = false;
                }
    
    
                ticDAO= new BLN_Ticket_DAO();
                LIST<ticket__c> ticTemp=new list<ticket__c>(); 
                string s1='Lead Retrieval';
                string temp='';
                
                if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.OwnerId==UserInfo.getuserid()){
                temp=' WHERE event__r.id = \''+eveid+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\'';
                }else{
                temp=' WHERE event__r.id = \''+eveid+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\''+' AND tkt_profile__r.bln_gn_user__r.User__c = '+'\''+uid+'\'';
                }
                ticTemp = ticDAO.userOrderAndTickets(temp);
               
                BLN_Ticket_DAO ticDAO1= new BLN_Ticket_DAO();
                LIST<ticket__c> ticTemp1=new list<ticket__c>(); 
                string s2='Scan Attendee';
                string temp1='';
                
                if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.OwnerId==UserInfo.getuserid()){
                temp1=' WHERE event__r.id = \''+eveid+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s2+'\''+'AND Ticket_Status__c!=\'Cancelled\'';
                }else{
                temp1=' WHERE event__r.id = \''+eveid+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s2+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\''+' AND tkt_profile__r.bln_gn_user__r.User__c = '+'\''+uid+'\'';
                }
                ticTemp1 = ticDAO.userOrderAndTickets(temp1);
               
                if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.OwnerId==UserInfo.getuserid()){
                    isproductbuyer =false;
                     if(ticTemp.size()>0)
                    IsLeadTabAvailable = true;
                    if(ticTemp1.size()>0)
                    IsSATabAvailable=true;
                }else{
                    if(ticTemp.size()>0){
                    IsLeadTabAvailable = true;
                    isproductbuyer =true;
                    isEventAdmin = false;
                    
                    }
                    if(ticTemp1.size()>0){
                    IsSATabAvailable=true;
                    //isproductbuyer =true;
                    }
                }
                
                if(ticTemp1.size()>0){
                    IsScanAttendeeSessionAvailable=true;
                    }
                
                if(ticTemp.size()>0){
                    IsLeadTabAvailable = true;
                    }
                    
                     //scan attendee app checking
                    if(iseveOganizer !=true){
                List<BLN_Scanusr_item__c> sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:eve.id and BLN_Item_Pool__c !=null limit 1];
                    if(sc.size()>0){
                    IsScanAttendeeSessionAvailable=true; 
                    isEventAdmin =false;
                     //IsLeadTabAvailable =false;
                     //isproductbuyer =false;
                    }
                    }
                    
                    
            }
                    
         }
      
public string LoginUserId{get;set;}
public GN_User__c gnuserinfo{get;set;}
public BLN_UtillDisplayLinks(){


 LoginUserId = Userinfo.getUserId();
        //system.debug('@@@LoginUserId'+[select First_Name__c, Last_Name__c from GN_User__c WHERE User__r.id=: LoginUserId]);
       try{
       gnuserinfo= [select First_Name__c, Last_Name__c from GN_User__c WHERE User__r.id=: LoginUserId];
       }catch(exception e){}


}

     
}
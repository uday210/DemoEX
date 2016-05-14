@RestResource(urlMapping='/ED_UserInfo/*')
global class ED_UserInfo_Service{
static BLN_Gnuser_DAO gn_dao = new BLN_Gnuser_DAO();
static BLN_Events_BAL eventsBAL = new BLN_Events_BAL();
static ResContainer res = new ResContainer();
static BLN_EventsListCon all_events = new BLN_EventsListCon();

@HttpPost
global static ResContainer getUserInfo(){
 //HttpRequest req = new HttpRequest();
 RestRequest req = RestContext.request;
 string user_id= req.params.get('user_id'); 
 res.User_Info= gn_dao.gettinggnuser(user_id);
 res.Register_Events= eventsBAL.listOfEvents(user_id);
 res.organization_id = UserInfo.getOrganizationId();
 res.Upcoming_Events = all_events.upcomingEvents;
 res.status = 'success';
 return res;
}

global class ResContainer{
 public string organization_id = ''; 
 public string status='';
 public GN_User__c User_Info = new GN_User__c();
 public list<BLN_Event__c> Register_Events = new list<BLN_Event__c>();
 public LIST<BLN_Event__c> Upcoming_Events = new List<BLN_Event__c>();
}

}
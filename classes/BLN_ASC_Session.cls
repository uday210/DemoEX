/* **************************************************************************************************
 Service Name    : BLN_ASC_Session
*  Date            : 02/17/2016
*  Author          : Phani Kumar Ch
*  Purpose         : This will check how many sessions user has and it will send list of previous
                      sessions to revoke session.
***************************************************************************************************** */

@RestResource(urlMapping = '/BLN_ASC_Session/*')

global class BLN_ASC_Session {
    @HttpPost
    global static BLN_Session_BAL.maincontainer doPost() {
        RestRequest req = RestContext.request;
        String Uid = req.params.get('User_id');
        String appname = req.params.get('appname').toUpperCase();
        String deviceId = req.params.get('device');
        String token = req.params.get('token');
        String eventId = req.params.get('Event_id');
	    String push='';
        String deviceType ='';
        if(appname=='EVENTDEX')
           deviceType = req.params.get('DeviceType');
        try{
         push = req.params.get('push');
        }catch(exception er){           
        }

        BLN_Session_BAL.maincontainer mncon = new BLN_Session_BAL.maincontainer();
        BLN_Session_BAL sesBal = new BLN_Session_BAL();
        BLN_Event_DAO blneventsdao = NEW BLN_Event_DAO();
         System.debug(' User id '+uId+'  '+appName +'   '+deviceId +'  Eid '+eventId+'   '+token+'  '+deviceType);
        try {
            List<BLN_Event__c> eventslist = blneventsdao.getEventDetails(eventId);
            BLN_Event__c blnEve = new BLN_Event__c();
            if (eventslist.size() > 0) {
                blnEve = eventslist[0];
            } else {
                mncon.msg = 'Sorry Event Not Found!';
                return mncon;
            }
             mncon = sesBal.getsessions(uId, deviceId, appname, token, eventId,push,deviceType);
           } Catch(exception er) {
            mncon.msg = er.getMessage();
        }
        return mncon;
    }
}
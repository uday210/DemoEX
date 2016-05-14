global with sharing class BLN_Session_BAL {
    public BLN_Session_DAO ssDao = new BLN_Session_DAO();
    public BLN_Ticket_DAO tcDao = new BLN_Ticket_DAO();
    //This method will check already session there it will update or else it will insert new record
    public Void insertSession(String uId, String dId, String appName, String token, String eId,string push,String deviceType) {
        List<BLN_Session__c> ssList = new List<BLN_Session__c>();
        ssList = ssDao.getUsrActSessions(uId, appName, dId, eId);
         System.debug(' User  id '+uId+'  '+appName +'   '+dId +'  Eid '+eId+'   '+token +'  '+deviceType);
        if (ssList.size() > 0) {
            for (BLN_Session__c ss : ssList) {
                ss.Token__c =  token;
                if(deviceType!='')
                 ss.DeviceType__c = deviceType;
            }
            Database.update(ssList, false);
        } else {
            BLN_Session__c ssin = new BLN_Session__c();
            ssin.Application__c = appName;
            ssin.Device_Id__c   = dId;
            ssin.Status__c      = 'Active';
            ssin.Token__c       = token;
            ssin.User__c        = uId;
            ssin.BLN_Events__c   = eId;
            ssin.PusunotificationId__c = push;
            ssin.DeviceType__c = deviceType;
            Database.SaveResult savres = Database.insert(ssin, false);
            System.debug(' Save Result '+savres);
        }
    }

    //Getting all previous sessions for cancel
    public maincontainer getsessions(String uId, String dId, String appName, String token, String eId,String push,String deviceType) {
        maincontainer container = new maincontainer();
        List<BLN_Session__c> calCelList =new List<BLN_Session__c>();
        Integer buyQuantity = 0;
         //container.SessionsCount = 0;
        container.msg= 'Success';
        if (appName.toUpperCase() != 'EVENTDEX') // Getting user buy Quantity for Scan Attendee
            buyQuantity = tcDao.getTicketsQuan(uId, eId, 'Scan Attendee');
        else
            buyQuantity = tcDao.getTicketsQuan(uId, eId, 'Lead Retrieval'); //Getting user buy Quantity for Eventdex

        if (buyQuantity > 0) {
            insertSession(uId, dId, appName, token, eId,push,deviceType); //Inserting Current Token to DataBase
            Integer currentSessions = 0; 
            BLN_Event_DAO event = new BLN_Event_DAO();
             Integer perTcCount = 0;
              try{ 
                if (appName.toUpperCase() != 'EVENTDEX') 
                  perTcCount = Integer.valueOf(event.getEventInfo(eId).AllowedDevicescount__c);
                 else
                   perTcCount = Integer.valueOf(event.getEventInfo(eId).AllowedLRDevicescount__c);
                  if(perTcCount>0)
                    buyQuantity =perTcCount*buyQuantity;
                  container.SessionsCount = perTcCount ;  
                }catch(exception er){} 
              System.debug(' HHHHHHHHHHHH '+buyQuantity +' JJJJJJJJJJjjj '+ssDao.getUsrAct(uId, appName,  eId));
            for (BLN_Session__c sso : ssDao.getUsrAct(uId, appName,  eId)) {
                currentSessions++;
               if(appName.toUpperCase() != 'EVENTDEX') {
                if (buyQuantity < currentSessions) {
                    container.sessionsTocancel.add(sso);    // Adding sessions for Revoke
                    sso.Status__c ='Cancel';
                    calCelList.add(sso);
                    System.debug(' NNNNNNNNNN'+container.sessionsTocancel);
                 }
               }else{
                  container.sessionsTocancel.add(sso);    // Adding sessions for Revoke
                } 
             }
             System.debug(' MMMMMMMMMMM '+container.sessionsTocancel);
           if(calCelList.size()>0)
             Database.update(calCelList,false);

           if (perTcCount >= currentSessions && appName.toUpperCase() == 'EVENTDEX') {
            container.sessionsTocancel = new List<BLN_Session__c>();
            }
        } else {
            container.msg= 'You Have to Buy ' + appName + ' Ticket';
        }
        return container;
    }

    global class maincontainer {
        public String msg{get; set;}
        public List<BLN_Session__c> sessionsTocancel {get; set;}
        public Integer SessionsCount {get; set;}
        public maincontainer() {
            sessionsTocancel = new List<BLN_Session__c>();
        }
    }
}
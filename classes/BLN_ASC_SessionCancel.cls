/* **************************************************************************************************
 Service Name    : BLN_ASC_Session
*  Date            : 02/17/2016
*  Author          : Phani Kumar Ch
*  Purpose         : This will update record with cancel status
***************************************************************************************************** */

@RestResource(urlMapping = '/BLN_ASC_SessionCancel/*')
global class BLN_ASC_SessionCancel {
    public Static BLN_Session_DAO ssDao= new BLN_Session_DAO();
    @HttpPost
    global static maincontainer doPost() {
        RestRequest req = RestContext.request;
        maincontainer container = new maincontainer();
        String sessionId = req.params.get('SessionId');
        try{
         BLN_Session__c sess = new BLN_Session__c();
         sess = ssDao.getSession(sessionId);
         if(null != sess){
             sess.Status__c = 'Cancel';
             Database.SaveResult dSav = Database.update(sess,false);
            if(dSav.isSuccess()){
              container.msg = 'Success';
            }else{
                container.msg = 'Update Failed';
            }
         }
        }catch(exception yt){           
         container.msg = 'Update Failed';
        }
       return container; 
     }   
    
     global class maincontainer {
        public String msg{get; set;}
     }
}
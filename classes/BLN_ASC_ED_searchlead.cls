@RestResource(urlMapping='/BLN_ASC_ED_searchlead')
global class BLN_ASC_ED_searchlead {
  @HttpGet
   global Static BLN_ls_Fetchleads.Leadslist  doPost(){ 
    RestRequest req = RestContext.Request;
    String loginUserId = req.params.get('loginUserId');
    String eventId = req.params.get('eventId');
     String searchStr = req.params.get('searchStr');
     BLN_LeadScan_DAO lsDao = new BLN_LeadScan_DAO();
     List<Lead_Scan__c> leadlisttemp=new List<Lead_Scan__c>();
     String condition = ' AND (First_Name__c like \''+searchStr+'%\' OR Last_Name__c like \''+searchStr+'%\' OR Lead_Email__c like \''+searchStr+'%\' OR Company__c like \''+searchStr+'%\')';
     leadlisttemp = lsDao.getLeadScan(eventId,condition);
     BLN_LS_Fetchleads_BAL fetchBal = new BLN_LS_Fetchleads_BAL();
     BLN_ls_Fetchleads.Leadslist myleads = new BLN_ls_Fetchleads.Leadslist();
     myleads.user_Q_nd_A = fetchBal.getSurveyAns(leadlisttemp,loginUserId,eventId);//Get survey questions related to lead
    myleads.leadsList = leadlisttemp;
     myleads.LastModifiedDate =system.now().format('YYYY-MM-dd HH:mm:ss','GMT');
    if(leadlisttemp.size()>0)
        myleads.msg.ldvalueAssign('','',true);
      else
        myleads.msg.ldvalueAssign('Error','No leads found',false);
        system.debug('myleads======'+myleads);
      return myleads;
   }    
}
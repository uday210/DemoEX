/***********************************************************************************************
*   Controller Name : BLN_ls_Fetchleads
*   Date            : 16/07/2015(DD/MM/YY)
*   Author          : Phani Kumar Ch
*   Purpose         : This is for fetching lead
**************************************************************************************************/
@RestResource(urlMapping='/BLN_ls_Fetchleads')
global with sharing class BLN_ls_Fetchleads {
   Static Leadslist myleads = new Leadslist();
  @HttpGet
   global Static Leadslist doPost(){  
     String loginUserId;
     String eventId; 
     String luCompId ;  
     RestRequest req = RestContext.Request;
     loginUserId = req.params.get('loginUserId');
     eventId = req.params.get('eventId');
     luCompId = req.params.get('luCompId');
    String lstleadId = req.params.get('lstleadId');
    String requestedDate = req.params.get('LastModifiedDate');
         DateTime lmDate;
         if(requestedDate != '' && requestedDate != null)
          lmDate  = dateTime.valueofGmt(requestedDate);
          System.debug('PPPPPPP '+lmDate);
     BLN_Leadscan_DAO bld = new BLN_Leadscan_DAO();
      
      List<Lead_Scan__c> leadlisttemp=new List<Lead_Scan__c>();

    If(lstleadId!=null && lstleadId!='' && requestedDate!=null && requestedDate!='')
    leadlisttemp.addAll(bld.getLeads(loginUserId, eventId, luCompId,lstleadId,lmDate));
    else
     leadlisttemp.addAll(bld.getLeads(loginUserId, eventId, luCompId));
         
     System.debug('OOOOOOOOOOOOO '+leadlisttemp.size());
     myleads.leadsList = leadlisttemp;
     
     myleads.LastModifiedDate =system.now().format('YYYY-MM-dd HH:mm:ss','GMT');
     BLN_LS_Fetchleads_BAL fetchBal = new BLN_LS_Fetchleads_BAL();
     myleads.user_Q_nd_A = fetchBal.getSurveyAns(leadlisttemp,loginUserId,eventId);
     /***********************************************************************/
      if(leadlisttemp.size()>0)
        myleads.msg.ldvalueAssign('','',true);
      else
        myleads.msg.ldvalueAssign('Error','No leads found',false);
        system.debug('myleads======'+myleads);
      return myleads;
   }
      
   global class Leadslist{
      public BLN_ResponseMsg msg=new BLN_ResponseMsg();
      public List<Lead_Scan__c> leadsList{get;set;}
      public list<BLN_LS_Fetchleads_BAL.wrap_userbasedlist> user_Q_nd_A {get;set;}
      public String LastModifiedDate{get;set;}

   }
                        
                
            }
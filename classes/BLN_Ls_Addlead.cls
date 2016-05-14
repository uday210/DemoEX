/***********************************************************************************************
*   Controller Name : BLN_ls_addlead
*   Date            : 16/07/2015(DD/MM/YY)
*   Author          : Phani Kumar Ch
*   Purpose         : This is for making lead
**************************************************************************************************/
@RestResource(urlMapping='/BLN_ls_addlead')
global class BLN_Ls_Addlead {
     Static leadDetails ldetails = new leadDetails();
   @HttpPost
   global Static leadDetails doPost(){  
     BLN_Badge_DAO badgeDao = new BLN_Badge_DAO();  
     BLN_Leadscan_DAO lsDao = new BLN_Leadscan_DAO();
     BLN_LeadRetrieval_BAL lrdBal = new BLN_LeadRetrieval_BAL();
     BLN_Ticket_DAO tkdao= new BLN_Ticket_DAO();
     String barcodeId;
     String loginUserId;
     String eventId; 
     String luCompId ;
     DateTime sTime ;
     RestRequest req = RestContext.Request;
     barcodeId = req.params.get('barcodeid');
     loginUserId = req.params.get('loginUserId');
     eventId = req.params.get('eventId');
     luCompId = req.params.get('luCompId');
     //sTime = DateTime.valueOf(req.params.get('sTime'));
     //sTime=sTime.addHours(-4);
     string dt=req.params.get('sTime');
      BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
     sTime=timezonecl.getDateBasedOnEventTimeZone(dt,'GMT');
     system.debug('stime'+stime);
        Badge__c bg = new Badge__c();
        ticket__c tck = new ticket__c();
        if(barcodeId!=null && barcodeId!='')      
           bg = badgeDao.getTicketsInfo(barcodeId,eventId);
        if(null!=bg){
          if(eventId!=bg.Ticket_id__r.Event__c){
           ldetails.msg.ldvalueAssign('Error','Badge does not belong to this event!',false);
           ldetails.evid = bg.Ticket_id__r.Event__c;
          }else if(bg.Cancel_Reason__c!=null)
            ldetails.msg.ldvalueAssign('Error','Badge is cancelled!',false);  
          else if(bg.Exp_time__c!=null)
            ldetails.msg.ldvalueAssign('Error','Badge is expired!',false);  
          else{
              system.debug('bg.Tickets__r.size()1'+bg.Tickets__r+bg);
             if(bg.Tickets__r.size()>0){
                 system.debug('bg.Tickets__r.size()'+bg.Tickets__r.size());
                if(lsDao.Leadexistchk(eventId,bg.Tickets__r[0].tkt_profile__c,loginUserId).size()>0)
                  ldetails.msg.ldvalueAssign('Error','Badge is already scanned!',false);
                else{
                  if(bg.Tickets__r[0].Ticket_Status__c=='Booked'){
                    ldetails.leadScan = lrdBal.insertLead(bg.Tickets__r[0],loginUserId,eventId,luCompId,sTime);
                     if(null != ldetails.leadScan){
                       ldetails.msg.validbadge = true;
                     }else{
                       ldetails.msg.ldvalueAssign('Error','File not saved!',false);
                     }
                  }else{
                     ldetails.msg.ldvalueAssign('Error','Badge is not valid!',false);  
                  }
                }    
              } 
          } 
        }else{
        
           //ldetails.msg.ldvalueAssign('Error','Badge is not valid!',false); 
           tck = tkdao.getcustombarcode(barcodeId,eventId );
         if( tck==null){
           ldetails.msg.ldvalueAssign('Error','Badge is not valid!',false); 
         }else if(eventId!=tck.Event__c){
           ldetails.msg.ldvalueAssign('Error','Badge does not belong to this event!',false);
           ldetails.evid = tck.Event__c;
          }else{
              
             //if(tck.size()>0){
                
                if(lsDao.Leadexistchk(eventId,tck.tkt_profile__c,loginUserId).size()>0)
                  ldetails.msg.ldvalueAssign('Error','Badge is already scanned!',false);
                else{
                  if(tck.Ticket_Status__c=='Booked'){
                    ldetails.leadScan = lrdBal.insertLead(tck,loginUserId,eventId,luCompId,sTime);
                     if(null != ldetails.leadScan){
                       ldetails.msg.validbadge = true;
                     }else{
                       ldetails.msg.ldvalueAssign('Error','File not saved!',false);
                     }
                  }else{
                     ldetails.msg.ldvalueAssign('Error','Badge is not valid!',false);  
                  }
                }    
              //} 
          }
        }
       return ldetails; 
    }

    global class leadDetails{
        public BLN_ResponseMsg msg=new BLN_ResponseMsg();
        public String evid{get;set;}
        public Lead_Scan__c leadScan{get;set;}
      
    } 
}
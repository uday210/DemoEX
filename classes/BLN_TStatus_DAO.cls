public without sharing class BLN_TStatus_DAO{
/***********************************************************************************************
*   Controller Name : BLN_TStatus_DAO
*   Date            : 24/12/2014
*   Author          : Rajesh Kumar Ch
*   Purpose         : This class is DAO Class, includes necessary database operation.
**************************************************************************************************/

    public BLN_StatusMessage insertTStatus(List<Tstatus__c> TicketStatus){
        dataBase.saveResult[] saveRes = dataBase.insert(TicketStatus,false); 
        return new BLN_StatusMessage(saveRes);
    }
    
    public List<Tstatus__c> getTStatusByIds(List<Id> TstsIds){
    
        return  [SELECT Id, Tstatus_name__c,scan_time__c,Scan_source__c, Ticket__c,CreatedDate FROM Tstatus__c WHERE Id IN : TstsIds ];
    }

    public List<AggregateResult> gettstatusitems(String uId, String Eid){
    system.debug(Eid+'uIdrajendrq'+uId);
    GN_User__c gn =[select User__c from GN_User__c where id=:uId];
    
  list<AggregateResult> groupedResults =[select count(id) cn,Ticket__r.Item_Pool__c tiemid from Tstatus__c where Ticket__r.Event__c=:Eid AND Owner.id=:gn.User__c group by Ticket__r.Item_Pool__c];
system.debug('groupedResults==='+groupedResults);
    return groupedResults;
    }

    //Written By Mythily For Revisit Report
    public List<Tstatus__c> EventTstatuses(id Eventid){
    
    return [Select id,scan_time__c,Tstatus_name__c, Ticket__c,
                    Ticket__r.tkt_profile__r.Email__c ,Ticket__r.tkt_profile__r.TKT_Company__c,Ticket__r.tkt_profile__r.First_Name__c,Ticket__r.tkt_Profile__r.Last_Name__c  
                   From Tstatus__c WHERE Ticket__r.Event__c =: Eventid];
    
    }

}
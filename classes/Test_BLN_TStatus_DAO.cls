@istest
public class Test_BLN_TStatus_DAO{
        static testmethod void Testmethod_BLN_TStatus_DAO(){
        Tstatus__c ts = new Tstatus__c();
        insert ts;
        List<Tstatus__c> tst = new List<Tstatus__c>();
        BLN_TStatus_DAO bd = new BLN_TStatus_DAO();
        bd.insertTStatus(tst);
        
        
        List<Id> tsd = new List<Id>();
        bd.getTStatusByIds(tsd);
        
    }
   }
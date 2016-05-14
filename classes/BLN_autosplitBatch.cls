global without sharing class BLN_autosplitBatch implements Database.batchable<String>, Database.Stateful
{
    public List<String> tidsList{get;set;}
    public BLN_autosplitBatch(List<String> tidsList1){
        tidsList =new List<String>();
        tidsList = tidsList1;
    }
    global Iterable<String> start(Database.BatchableContext BC) {
        return tidsList;
    }

    global void execute(Database.BatchableContext info, List<String> scope) {
        for(integer i=0;i<scope.size();i++){
            BLN_Quick_Registration_BAL qrBAL= new BLN_Quick_Registration_BAL();
            qrBAL.autosplitpackage(scope[i]);
        }
        
    }

    global void finish(Database.BatchableContext info) {}

}
public with sharing class BLN_generateScanId{
    public Integer counter = 0; // Even after 70 attempts also if we dont get uniq it will terminate program
    public Static boolean tohandlerecursive = true;
    public boolean isScanedTc=false;
// This method will insert scan id till it becomes uniq
    public Void insertScanId(List<Ticket__c> tcs) {
        //counter++;
        MAP<id, Ticket__c> maptIdWithTc = new MAP<id, Ticket__c>();
        for (Ticket__c tc : tcs) {
            if (tc.Ticket_Status__c == 'Abandoned' || isScanedTc) {
                /*Integer random = (integer) (Math.random() * (99999 - 10000)) + 10000;*/
                //unique number generation using datetime and md5 alogorith
                String ticketcode=tc.Name.substringAfter('-');
                tc.Uniq__c = tc.Event__c + ticketcode;
                tc.Scan_Id__c = ticketcode;
                maptIdWithTc.put(tc.id, tc);
            }
        }
        //List<Ticket__c> failedRecUpdate = new List<Ticket__c>();
        Database.SaveResult[] ds = Database.update(tcs, false);
        /*System.debug('Insert Values ' + ds);
        SET<id> successIds = new SET<id>();
        for (Database.SaveResult dSav : ds) {
            if (dSav.isSuccess()) { // Successed record ids
                successIds.add(dSav.getId()); //
            }
        }
        for (id tIds : maptIdWithTc.keySet()) {
            if (!successIds.contains(tIds)) // Failed Records
                failedRecUpdate.add(maptIdWithTc.get(tIds));
        }
        if (failedRecUpdate.size() > 0 && counter < 70) {
            insertScanId(failedRecUpdate); // calling same method again to get different uniq value
        }*/
    }
}
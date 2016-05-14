trigger sendInvoice on Order__c (after update) {

for(Order__c ord:[select id,(select id,name,Item__r.Event__c from Order_Items__r),Order_Status__c,name,Events__c from Order__c  where id in:trigger.newMap.keyset()])
{
    if(ord.Order_Status__c != 'Cancelled' && ord.Order_Status__c != 'Abandoned' && ord.Order_Status__c != 'Not Paid' )
    {
    BLN_Event__c defaulteve=[select id,name from BLN_Event__c where id=:ord.Events__c];
     BLN_Event__c eveactual=[select id,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,name,Event_Status__c from BLN_Event__c where id=:ord.Order_Items__r[0].Item__r.Event__c];
     if(defaulteve.name=='Default Event(Boothleads)'){
    BLN_Invoice_Utility bln=new BLN_Invoice_Utility();
    try{
   bln.SendInvoice (ord.id,eveactual.Organizer_Email__c);
   }catch(Exception e){}
   }
    }
}

}
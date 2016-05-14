public with sharing class BLN_CheckinCheckoutDetails {

        public ticket__c ticCheckin{get;set;}
    public LIST<tstatus__C> Checkintime{get;set;}
    public LIST<tstatus__C> Checkouttime{get;set;}
    public string scanBy{get;set;}
    public string Device{get;set;}
       
       public BLN_CheckinCheckoutDetails(ticket__c ticCheckin1){
      ticCheckin=ticCheckin1;
      scanBy=ticCheckin.tstatus_id__r.Owner.Name;
      Device=ticCheckin.tstatus_id__r.Device_Name__c;
      Checkintime = new LIST<tstatus__C>();
      Checkouttime = new LIST<tstatus__C>();

      for(tstatus__C ts:ticCheckin.tstatus__r){
        if(ts.Tstatus_name__c == true)
        {
          Checkintime.add(ts);
        }
        else if(ts.Tstatus_name__c == false ){
          Checkouttime.add(ts);
        }
              }
       }
}
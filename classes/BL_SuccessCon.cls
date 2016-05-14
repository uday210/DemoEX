public with sharing class BL_SuccessCon {
public  Event__c eve{get;set;}
public BL_SuccessCon(){
system.debug('444444444444444444 '+ApexPages.currentPage().getParameters().get('id'));
eve=[SELECT id, name, EV_Title__c, EV_Description__c,EV_HostingStateNew__c, EV_EventLogo__c,EV_HostingLocation__c,
                                        EV_StartDate__c,EV_EndDate__c,EV_SiteLocation__c FROM Event__c where id =: ApexPages.currentPage().getParameters().get('id')];
            
}
  
}
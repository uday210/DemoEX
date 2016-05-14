public without sharing class statessample1con {

public AttendeeSummary__c ass{get;set;}
public AttendeeSummary__c country{get;set;}

public statessample1con(){
ass= new AttendeeSummary__c();
country= new AttendeeSummary__c();

country.AS_Work_Country__c='United States of America';
}
}
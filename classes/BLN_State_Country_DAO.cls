public without sharing class BLN_State_Country_DAO{

    public State__c getstate(string stateid){
        State__c state=[select Short_Name__c,Long_Name__c from State__c where id = :stateid];
        return state;
    }
    
    public Country__c getcountry(string countryid){
        Country__c country=[select Short_Name__c,Long_Name__c,Currency__c from Country__c where id = :countryid];
        return country;
    }
}
public with sharing class BLN_Address_DAO {
    public BLN_Address__c getAddress(String addId) {
      return [SELECT id,Address1__c,Address2__c,City__c,Country__c,Country__r.Long_Name__c,PoBox__c,State__c,ZipCode__c from BLN_Address__c where id=:addId];    
    }
    public string insertadd(string add1,string add2,string city,string country,string state,string pobox,string Zip){
    BLN_Address__c GNADD = new BLN_Address__c();
    GNADD.Address1__c = add1;
    GNADD.Address2__c = add1;
    GNADD.City__c = city;
    GNADD.Country__c = country;
    GNADD.State__c = state;
    GNADD.PoBox__c = pobox;
    GNADD.ZipCode__c = Zip;
    insert GNADD;
    system.debug('::::::::::::::::::::HID:::::::::::::;;'+GNADD.id);
    return GNADD.id;
    
    }
}
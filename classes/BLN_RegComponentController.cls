/*Author-Arindam
Date:10/03/2016
Purporse:This is used by attendee,buyer,payment component*/
global class BLN_RegComponentController{
public BLN_RegistrationnewCon3 ThePageController{get;set;}


  @RemoteAction
  global static List<SObject> statesBasedOnCountry(String country) {
    //eventCurrency =  Currencies;
    return [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__c FROM State__c WHERE Country__c = : country];
  }
   
    //builds a picklist of values based upon the passed information
    public static List<selectOption> getPickValues(Sobject object_name, String field_name, String first_val) {
        System.debug('111111111111111:'+object_name);
        System.debug('222222222222222222:'+field_name);
        System.debug('333333333333333:'+first_val);
        List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
        if ( first_val != null ) { //if there is a first value being provided
            options.add(new selectOption(first_val, first_val)); //add the first option
        }
        Schema.sObjectType sobject_type = object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get(field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            options.add(new selectOption(a.getLabel(), a.getValue()));  //add the value and label to our final list
        }
        return options; //return the List
    }

@RemoteAction
    global static List<selectOption> getPrefixes() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Prefix__c', null);
    }
    @RemoteAction
    public static List<selectOption> getSuffixes() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Suffix__c', null);
    }
    @RemoteAction
    public static List<selectOption> getPrimaryBusinessCategory() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Primary_Business_Category__c', null);
    }
    @RemoteAction
    public static List<selectOption> getSecondaryBusinessCategory() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Secondary_Business_Category__c', null);
    }
  
}
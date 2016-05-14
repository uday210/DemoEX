public with sharing class AttendeeSummary_Dao {
   public SET<String> getExistingAtt(List<String> emails) {
      MAP<String,AttendeeSummary__c> unWithatt = new MAP<string,AttendeeSummary__c>();
      for(AttendeeSummary__c att : [SELECT id,AS_Email__c from AttendeeSummary__c where AS_Email__c IN :emails ]){
         unWithatt.put(att.AS_Email__c,att);
      } 
      return unWithatt.keySet();  
    }
    public List<AttendeeSummary__c> attSum(String email){
       return [SELECT Exhibitor_company_imageUrl__c,AddedBy__c,AS_Age__c,AS_BirthDate__c,AS_BlogUrl__c,AS_BusinessDescription__c,AS_BusinessDunsNumber__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_CageCode__c,AS_CellPhone__c,AS_Company__c,AS_DiversityType__c,AS_Email__c,AS_FaxNumber__c,AS_FirstName__c,AS_Gender__c,AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,AS_HomeCountry__c,AS_HomePhone__c,AS_HomePoboxNo__c,AS_HomePoBox__c,AS_HomeState__c,AS_HomeZipcode__c,AS_HomeZip__c,As_Home_Country__c,As_Home_State__c,AS_ImageUrl__c,AS_LastName__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,As_NAICSCode_1__c,As_NAICSCode_2__c,As_NAICSCode_3__c,As_NAICSCode_4__c,As_NAICSCode_5__c,AS_NumberOfEmployees__c,As_prefixNew__c,AS_Prefix__c,AS_PrimaryBusinessCategory1__c,AS_PrimaryBusinessCategory__c,As_SecondaryBusinessCategory1__c,AS_SecondaryBusinessCategory__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingCountry__c,AS_ShippingPhone__c,AS_Shippingpoboxno__c,AS_ShippingPoBox__c,AS_ShippingState__c,AS_ShippingZipcode__c,AS_shippingzip__c,As_Shipping_Country__c,As_Shipping_States__c,As_SuffixNew__c,AS_Suffix__c,AS_ThroughEventBrite__c,AS_Title__c,AS_uniqueField__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkCountry__c,AS_WorkPhone__c,AS_Workpoboxno__c,AS_WorkPoBox__c,AS_WorkState__c,AS_WorkZipCode__c,AS_WorkZip__c,AS_Work_Country__c,AS_Work_States__c,Business_type__c,customer_key__c,EventBriteCount__c,Exceptional_Key_Words__c,FetchStatus__c,FullName__c,Id,IsDeleted,isFetched__c,isUpdated__c,Keywords__c,Name,Registration_type__c,Ticket_Number__c,Total_Name__c,updateRevenue__c FROM AttendeeSummary__c where AS_EMail__c = :email];
    }

   public List<AttendeeSummary__c> allFieldsAtt(SET<String> emails){
    String SobjectApiName = 'AttendeeSummary__c';
    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
     Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
     String commaSepratedFields = '';
      for(String fieldName : fieldMap.keyset()){
          if(fieldName.contains('__c') || fieldName=='Name'){
            if(commaSepratedFields == null || commaSepratedFields == ''){
              commaSepratedFields = fieldName;
            }else{
              commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
          }
        }
      String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where AS_Email__c IN :emails';
      return Database.query(query);
  }
}
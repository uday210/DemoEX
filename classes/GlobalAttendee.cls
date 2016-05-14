public without sharing class GlobalAttendee{

public AttendeeSummary__c  ReturnAttendee(string email){
      try{
      AttendeeSummary__c atta = new AttendeeSummary__c();
      atta=[Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,Keywords__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c,a.AS_NAICSCode7__c,
                   a.AS_NAICSCode8__c,a.AS_NAICSCode9__c,a.AS_NAICSCode6__c,
                  a.AS_BusinessRevenue__c,a.Exceptional_Key_Words__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,a.DBA__c,
                 a.Geographical_Region__c,
                 a.Certificate_Processed_by_RPO__c,
                 a.BBB_Number__c,
                 a.Commodity_1__c,
                 a.Commodity_2__c,
                 a.Commodity_3__c,
                 a.Commodity_4__c,
                 a.Commodity_5__c,
                  a.distribution_Country__c,
                a.Manufactures_Country__c,
                 a.References__c,
                 a.Revenue_Range__c, 

                  Exhibitor_company_imageUrl__c From AttendeeSummary__c a where a.AS_Email__c =:email];
            return atta ;
           
            }catch(exception e){return null;}

}




}
@RestResource(urlMapping='/PrivateMbeProfile/*')

/*
 * AUTHOR : Phani
 * Email :  phani@globalnest.com
 * AIM :    To update the User information from the mobile  clients
 ***/  
 
 global without Sharing class MMPrivateMbeProfile{
 
 @HttpPost
  global static AllDetails doPost(){
 
       RestRequest req = RestContext.request;
       RestResponse res = RestContext.response;
       String UserName= req.params.get('UserEmail');
       String eveid= req.params.get('Eveid');
       system.debug('UserName '+UserName +' Event id '+eveid);
       
       AllDetails alDetail = new AllDetails();
       
       FetchEventdetails evedetails= new FetchEventdetails();
       if(eveid!=null && eveid!=''){  
          try{
            if(null !=evedetails.evedetails(eveid)){
                 
                    for(Event_Attendee_Mapping__c eam : [select id,MBE_Profile__c from Event_Attendee_Mapping__c where  AS_Id__r.As_Email__c=:UserName and EV_id__c=:eveid]){
                        if(eam.MBE_Profile__c !=null ){
                             MBE_Profile__c mbeprofiles = new MBE_Profile__c();
                             try{
                              if(evedetails.evedetails(eveid).Is_Webank_event__c){
                                mbeprofiles = [Select  AttendeeSummary__c,a.Ethnicity__c,a.AS_Secondary_Email__c,  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                                  a.AS_WorkZipCode__c,a.AS_WorkPhone__c, 
                                  a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Key_Words__c,
                                  a.AS_WebsiteUrl__c, a.AS_Title__c, 
                                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                                  a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                                  a.AS_HomePhone__c,a.AS_HomeCity__c,
                                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                                  a.References__c,a.Revenue_Range__c,a.distribution_Country__c,a.Manufactures_Country__c,a.DBA__c,a.BBB_Number__c,a.Commodity_1__c,a.Commodity_2__c,a.Commodity_3__c,a.Commodity_4__c,a.Commodity_5__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,
                                  a.AS_NAICSCode6__c,a.AS_NAICSCode7__c,a.AS_NAICSCode8__c,a.AS_NAICSCode9__c,
                                  AS_BusinessDunsNumber__c,AS_BusinessTaxId__c,Business_Structure__c,Company_Certifications__c,Year_in_business__c,FaxNumber__c,(SELECT Id, Name,Description,ContentType FROM Attachments) from MBE_Profile__c a Where id=:eam.MBE_Profile__c];
                                 
                                   GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(mbeprofiles);
                                   alDetail.userProfile.add(Guser);
                               }else{
                                     GlobalUtillClass.UserDetails Guser1= new GlobalUtillClass.UserDetails('This Event is not Private Mbe ');
                                     alDetail.userProfile.add(Guser1);
                               }  
                              }catch(exception er){
                                  GlobalUtillClass.UserDetails Guser2= new GlobalUtillClass.UserDetails(er.getMessage());
                                  alDetail.userProfile.add(Guser2);
                              }
                        }
                    }                  
                 }
          
           }catch(exception er){} 
          }   
       return alDetail;
  }
  
   global class AllDetails{ 
      List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
   }
}
@RestResource(urlMapping='/MMATTSearch/*')


global without Sharing class MMATTSerach{

 @httpPost
 global static AllDetails doPost(){

     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;     
     string keyword;
     String isMM;
     eveid =req.params.get('eveid');
     keyword = req.params.get('keyword');
     isMM = req.params.get('isMM');
     system.debug('eveid---'+eveid);
     system.debug('keyword---'+keyword);
     String mykey;
     
     
     AllDetails alDetail = new AllDetails();
     
     if(keyword == '' || keyword == NULL){
             GlobalUtillClass.globalMessage emptkey = new GlobalUtillClass.globalMessage('Please Enter keyword');
             alDetail.globalMessage.add(emptkey);
             return alDetail;
            }/*else{
            mykey = '%' + keyword + '%';
            system.debug('mykey---'+mykey);
            }*/
     
         //List<User_Profile_Event__c> upeulist = new List<User_Profile_Event__c>();
         //upeulist = [SELECT Id, BoothAdmin_id__c, User_id__c,Attendee_Summary__r.Id FROM User_Profile_Event__c WHERE EV_id__c =: eveid AND MAtchMakingProfile__c = 'MBE' AND IsMatchMakingUser__c = TRUE AND Request_for_upgrade_profile__c=false  ];
         Event__c eveobj = new Event__c();
         string selectedEventId  ='';
         FetchEventdetails evedetails= new FetchEventdetails();
        if(eveid!=null && eveid!=''){  
             eveobj = evedetails.evedetails(eveid);
             selectedEventId =  eveobj.id;
         } 
         
         List<Event_Attendee_Mapping__c> eamlist = new List<Event_Attendee_Mapping__c>();
         
       if(eveobj.Is_Webank_event__c){  
         eamlist = [select AS_id__r.Id,MBE_Profile__r.Revenue_Range__c,MBE_Profile__r.Scope_of_Work2__c,MBE_Profile__r.Scope_of_Work__c,MBE_Profile__r.References2__c,MBE_Profile__r.References__c,MBE_Profile__r.Year_in_business__c,MBE_Profile__r.AS_NAICSCode9__c,MBE_Profile__r.AS_NAICSCode8__c,MBE_Profile__r.AS_NAICSCode7__c,MBE_Profile__r.AS_NAICSCode6__c,MBE_Profile__r.AS_Work_States__c,AS_Id__r.AS_ImageUrl__c,MBE_Profile__r.AS_ImageUrl__c,Ev_id__r.Is_Webank_event__c,id,DiversityType__c,MBE_Profile__c,As_id__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.Key_Words__c,MBE_Profile__r.As_NAICSCode_1__c,MBE_Profile__r.As_NAICSCode_2__c,MBE_Profile__r.As_NAICSCode_3__c,MBE_Profile__r.As_NAICSCode_4__c,MBE_Profile__r.As_NAICSCode_5__c,MBE_Profile__r.Commodity_1__c,MBE_Profile__r.Commodity_2__c,MBE_Profile__r.Commodity_3__c,MBE_Profile__r.Commodity_4__c,MBE_Profile__r.Commodity_5__c,MBE_Profile__r.GSA_Schedule__c,MBE_Profile__r.AS_BusinessRevenue__c,MBE_Profile__r.AS_NumberOfEmployees__c,MBE_Profile__r.Geographical_Region__c,MBE_Profile__r.Company_Certifications__c,MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MBE_Profile__r.AS_CellPhone__c
 from Event_Attendee_Mapping__c where EV_id__c=:selectedEventId  and IsMatchMakingAttendee__c=true AND  Boothleads_Profile__c ='Attendee' and EV_id__c!=null ];      
           system.debug('number of upes-----------------'+eamlist.size()+'--------'+eamlist);
       }else{
       
        eamlist =  [select MBE_Profile__r.Id,AS_Id__r.Revenue_Range__c,AS_Id__r.Scope_of_Work2__c,AS_Id__r.Scope_of_Work__c,AS_Id__r.References2__c,AS_Id__r.References__c,AS_Id__r.Year_in_business__c,AS_Id__r.AS_NAICSCode9__c,AS_Id__r.AS_NAICSCode8__c,AS_Id__r.AS_NAICSCode7__c,AS_Id__r.AS_NAICSCode6__c,AS_Id__r.AS_Work_States__c,AS_Id__r.AS_ImageUrl__c,Ev_id__r.Is_Webank_event__c,id,DiversityType__c,AS_Id__r.AS_FirstName__c,AS_Id__r.AS_LastName__c,AS_Id__r.FullName__c,AS_Id__r.AS_Email__c,AS_Id__r.AS_Company__c,AS_Id__r.As_NAICSCode_1__c,AS_Id__r.As_NAICSCode_2__c,AS_Id__r.As_NAICSCode_3__c,AS_Id__r.As_NAICSCode_4__c,AS_Id__r.As_NAICSCode_5__c,AS_Id__r.Commodity_1__c,AS_Id__r.Commodity_2__c,AS_Id__r.Commodity_3__c,AS_Id__r.Commodity_4__c,AS_Id__r.Commodity_5__c,AS_Id__r.GSA_Schedule__c,AS_Id__r.AS_BusinessRevenue__c,AS_Id__r.AS_NumberOfEmployees__c,AS_Id__r.Geographical_Region__c,AS_Id__r.Company_Certifications__c,AS_Id__r.AS_PrimaryBusinessCategory1__c,AS_Id__r.AS_CellPhone__c
 from Event_Attendee_Mapping__c where EV_id__c=:selectedEventId  and IsMatchMakingAttendee__c=true AND  Boothleads_Profile__c ='Attendee' and EV_id__c!=null];      
              
       }
       
         if(eamlist.size()<=0){
             GlobalUtillClass.globalMessage Guser45 = new GlobalUtillClass.globalMessage('Event Not Found');
             alDetail.globalMessage.add(Guser45);
             return alDetail;
            }  
         
         
         List<Id> listOfattendees = new List<Id>();
         List<Id> listOfMbe = new List<Id>();
         MAP<String, String> UserDetails= new MAP<String, String>();
         MM_GlobalSearch gnsearch = new MM_GlobalSearch();
         keyword = keyword.toLowerCase();
         for(Event_Attendee_Mapping__c upe :eamlist )
         {
              string findStrInrec = gnsearch.Gnsearch(upe,upe.Ev_id__r.Is_Webank_event__c);
              if(findStrInrec.contains(keyword)){
                 listOfMbe.add(upe.MBE_Profile__r.Id);
                 listOfattendees.add(upe.AS_id__r.Id);
               }
           
           UserDetails.put(upe.AS_id__r.Id, '');
         }  
         
          
       //  if(keyword.isNumeric() == TRUE && keyword.length() == 6){
         
         if(eveobj.Is_Webank_event__c){
          for(MBE_Profile__c mbe_profile:[SELECT Any_non_WBENC_awards_received__c,AS_Age__c,AS_BirthDate__c,AS_BlogUrl__c,AS_BusinessDescription__c,AS_BusinessDunsNumber__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId_c__c,AS_BusinessTaxId__c,AS_CageCode__c,AS_CellPhone__c,AS_Company__c,AS_DiversityType__c,AS_Email__c,AS_FaxNumber__c,AS_FirstName__c,AS_Gender__c,AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,AS_HomePhone__c,AS_HomePoBox__c,AS_HomeZip__c,As_Home_Country__c,As_Home_State__c,AS_ImageUrl__c,AS_LastName__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,As_NAICSCode_1__c,As_NAICSCode_2__c,As_NAICSCode_3__c,As_NAICSCode_4__c,As_NAICSCode_5__c,AS_NumberOfEmployees__c,As_prefixNew__c,AS_PrimaryBusinessCategory1__c,As_SecondaryBusinessCategory1__c,AS_Secondary_Email__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingPhone__c,AS_ShippingPoBox__c,AS_ShippingState__c,AS_ShippingZipcode__c,AS_shippingzip_c__c,As_Shipping_Country__c,As_Shipping_States__c,As_SuffixNew__c,AS_Title__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkPhone__c,AS_WorkZipCode__c,AS_WorkZip__c,AS_Work_Country__c,AS_Work_States__c,AttendeeSummary__c,BBB_Number__c,Business_Structure__c,Business_type__c,Certificate_Processed_by_RPO__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,Companyhaveafacility_partneroutsideUSA__c,Company_Certifications__c,CreatedById,CreatedDate,DBA__c,distribution_Country__c,Ethnicity__c,Event_Organizer_Id__c,Exceptional_Key_Words__c,Exhibitor_company_imageUrl__c,FaxNumber__c,FullName__c,Geographical_Region__c,GSA_Schedule__c,Id,IsDeleted,Key_Words__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Manufactures_Country__c,Name,OwnerId,References2__c,References__c,Revenue_Range__c,Scope_of_Work2__c,Scope_of_Work__c,SystemModstamp,Total_Name__c,Year_in_business__c,AttendeeSummary__r.AS_ImageUrl__c FROM MBE_Profile__c  where id in : listOfMbe
                                     ]){
             
             GlobalUtillClass.MMATTSearchRes srchres = new GlobalUtillClass.MMATTSearchRes(mbe_profile, UserDetails.get(mbe_profile.id)); 
             alDetail.MMATTSearchRes.add(srchres);
              }
         }else{
          for(AttendeeSummary__c asr:[SELECT AddedBy__c,Any_non_WBENC_awards_received__c,AS_Age__c,AS_BirthDate__c,AS_BlogUrl__c,AS_BusinessDescription__c,AS_BusinessDunsNumber__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_CageCode__c,AS_CellPhone__c,AS_Company__c,AS_DiversityType__c,AS_Email__c,AS_FaxNumber__c,AS_FirstName__c,AS_Gender__c,AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,AS_HomeCountry__c,AS_HomePhone__c,AS_HomePoboxNo__c,AS_HomePoBox__c,AS_HomeState__c,AS_HomeZipcode__c,AS_HomeZip__c,As_Home_Country__c,As_Home_State__c,AS_ImageUrl__c,AS_LastName__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,As_NAICSCode_1__c,As_NAICSCode_2__c,As_NAICSCode_3__c,As_NAICSCode_4__c,As_NAICSCode_5__c,AS_NumberOfEmployees__c,As_prefixNew__c,AS_Prefix__c,AS_PrimaryBusinessCategory1__c,AS_PrimaryBusinessCategory__c,As_SecondaryBusinessCategory1__c,AS_SecondaryBusinessCategory__c,AS_Secondary_Email__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingCountry__c,AS_ShippingPhone__c,AS_Shippingpoboxno__c,AS_ShippingPoBox__c,AS_ShippingState__c,AS_ShippingZipcode__c,AS_shippingzip__c,As_Shipping_Country__c,As_Shipping_States__c,As_SuffixNew__c,AS_Suffix__c,AS_ThroughEventBrite__c,AS_Title__c,AS_uniqueField__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkCountry__c,AS_WorkPhone__c,AS_Workpoboxno__c,AS_WorkPoBox__c,AS_WorkState__c,AS_WorkZipCode__c,AS_WorkZip__c,AS_Work_Country__c,AS_Work_States__c,BBB_Number__c,biography__c,Business_Structure__c,Business_type__c,Certificate_Processed_by_RPO__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,Companyhaveafacility_partneroutsideUSA__c,Company_Certifications__c,CreatedById,CreatedDate,customer_key__c,DBA__c,distribution_Country__c,Ethnicity__c,EventBriteCount__c,Exceptional_Key_Words__c,Exhibitor_company_imageUrl__c,FetchStatus__c,FullName__c,Geographical_Region__c,GSA_Schedule__c,Id,IsDeleted,isFetched__c,isUpdated__c,Keywords__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Manufactures_Country__c,Name,OwnerId,References2__c,References__c,Registration_type__c,Revenueupdate__c,Revenue_Range__c,Scope_of_Work2__c,Scope_of_Work__c,SystemModstamp,Ticket_Number__c,Total_Name__c,updateRevenue__c,Year_in_business__c,Youtube_Link__c FROM AttendeeSummary__c  where id in : listOfattendees]){
             
             GlobalUtillClass.MMATTSearchRes srchres = new GlobalUtillClass.MMATTSearchRes(asr, UserDetails.get(asr.id)); 
             alDetail.MMATTSearchRes.add(srchres);
             }
         }
        
     //}
     
     /* else{
     
     
          if(eveobj.Is_Webank_event__c){
          
               for(MBE_Profile__c mbe_profile:[Select Commodity_1__c,Commodity_2__c,Commodity_3__c ,Commodity_4__c,Commodity_5__c,AS_BusinessDescription__c,AS_WorkPhone__c,id,AS_FirstName__c, AS_LastName__c, AS_Email__c, AS_Company__c, AS_NAICSCode_1__c, AS_NAICSCode_2__c, AS_NAICSCode_3__c, AS_NAICSCode_4__c, AS_NAICSCode_5__c,
                                         AS_WorkAddress1__c, AS_WorkAddress2__c, AS_WorkZip__c, As_SecondaryBusinessCategory1__c, AS_Title__c, AS_WebsiteUrl__c, AS_CellPhone__c, 
                                         AS_PrimaryBusinessCategory1__c, AS_ImageUrl__c, Company_Certifications__c, AS_NumberOfEmployees__c,
                                         AS_Work_States__c, AS_WorkCity__c, Business_type__c, AS_DiversityType__c, GSA_Schedule__c, AS_BusinessRevenue__c, AS_BusinessEstablishedDate__c, Key_Words__c,Revenue_Range__c
                                         from MBE_Profile__c
                                         where id in : listOfMbe 
                                         and (AS_FirstName__c LIKE : '%'+keyword+'%' 
                                         or AS_LastName__c LIKE : '%'+keyword+'%' 
                                         or AS_Email__c LIKE : '%'+keyword+'%' 
                                         or AS_Company__c LIKE : '%'+keyword+'%' 
                                         or Commodity_1__c LIKE : '%'+keyword+'%'
                                         or Commodity_2__c LIKE : '%'+keyword+'%'
                                         or Commodity_3__c LIKE : '%'+keyword+'%'
                                         or Commodity_4__c LIKE : '%'+keyword+'%'
                                         or Commodity_5__c LIKE : '%'+keyword+'%'
                                         or AS_PrimaryBusinessCategory1__c LIKE : '%'+keyword+'%'
                                         or Company_Certifications__c =: keyword
                                         or AS_Work_States__c LIKE : '%'+keyword+'%' 
                                         or AS_WorkCity__c LIKE : '%'+keyword+'%'
                                         or Business_type__c =: keyword
                                         or GSA_Schedule__c LIKE : '%'+keyword+'%' )]){
                                     
             
             
             GlobalUtillClass.MMATTSearchRes srchres = new GlobalUtillClass.MMATTSearchRes(mbe_profile, UserDetails.get(mbe_profile.id)); 
             alDetail.MMATTSearchRes.add(srchres);
             
              }
          
          }else{
          
                     for(AttendeeSummary__c asr:[Select Commodity_1__c,Commodity_2__c,Commodity_3__c ,Commodity_4__c,Commodity_5__c,AS_BusinessDescription__c,AS_WorkPhone__c,id,AS_FirstName__c, AS_LastName__c, AS_Email__c, AS_Company__c, AS_NAICSCode_1__c, AS_NAICSCode_2__c, AS_NAICSCode_3__c, AS_NAICSCode_4__c, AS_NAICSCode_5__c,
                                         AS_WorkAddress1__c, AS_WorkAddress2__c, AS_WorkZip__c, As_SecondaryBusinessCategory1__c, AS_Title__c, AS_WebsiteUrl__c, AS_CellPhone__c, 
                                         AS_PrimaryBusinessCategory__c, AS_ImageUrl__c, Company_Certifications__c, AS_NumberOfEmployees__c,
                                         AS_WorkState__c, AS_WorkCity__c, Business_type__c, AS_DiversityType__c, GSA_Schedule__c, AS_BusinessRevenue__c, AS_BusinessEstablishedDate__c, Keywords__c,Revenue_Range__c
                                         from AttendeeSummary__c
                                         where id in : listOfattendees 
                                         and (AS_FirstName__c LIKE : '%'+keyword+'%' 
                                         or AS_LastName__c LIKE : '%'+keyword+'%' 
                                         or AS_Email__c LIKE : '%'+keyword+'%' 
                                         or AS_Company__c LIKE : '%'+keyword+'%' 
                                         or Commodity_1__c LIKE : '%'+keyword+'%'
                                         or Commodity_2__c LIKE : '%'+keyword+'%'
                                         or Commodity_3__c LIKE : '%'+keyword+'%'
                                         or Commodity_4__c LIKE : '%'+keyword+'%'
                                         or Commodity_5__c LIKE : '%'+keyword+'%'
                                         or AS_PrimaryBusinessCategory__c LIKE : '%'+keyword+'%'
                                         or Company_Certifications__c =: keyword
                                         or AS_WorkState__c LIKE : '%'+keyword+'%' 
                                         or AS_WorkCity__c LIKE : '%'+keyword+'%'
                                         or Business_type__c =: keyword
                                         or GSA_Schedule__c LIKE : '%'+keyword+'%' )]){
                                     
             
             
             GlobalUtillClass.MMATTSearchRes srchres = new GlobalUtillClass.MMATTSearchRes(asr, UserDetails.get(asr.id)); 
             alDetail.MMATTSearchRes.add(srchres);
             
              }
          }   
          
    } */
         
     
     
     
     return alDetail;  

}

global class AllDetails{
List<GlobalUtillClass.globalMessage> globalMessage = new List<GlobalUtillClass.globalMessage>();
List<GlobalUtillClass.MMATTSearchRes> MMATTSearchRes= new List<GlobalUtillClass.MMATTSearchRes>();
}
}
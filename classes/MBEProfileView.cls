public with sharing class MBEProfileView {


public string selectedEvent {get ; set ;}
public MBEProfileView(){
    cookie counter =   ApexPages.currentPage().getCookies().get('counter');
    selectedEvent = counter.getValue();
    viewProfile();

}
public Profile_Settings__c pfsett{get;set;}
public Event__c eventone {get ; set ;}
public Event_Attendee_Mapping__c vewProfileEAM {get ; set ;}
public list<Attachment> attchments {get ; set ;}
public List<Widget__c> videos {get ; set ;}
public List<Custom_Widget__c> cvideos {get ; set ;}
public void viewProfile(){
    pfsett= new Profile_Settings__c();
    profileDao pfdao = new profileDao();
          if(selectedEvent != '' && selectedEvent != null ){      
            for(Profile_Settings__c ps :pfdao.getSettings(selectedEvent ,'MBE')){
              pfsett = ps ;
              break;
            }
          }   
    Commanforstates cd12121 = new Commanforstates ();
    eventone = new Event__c();
    string Email = Userinfo.getUsername();
    eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:selectedEvent];
    vewProfileEAM = new  Event_Attendee_Mapping__c();
    attchments = new list<Attachment>();
        if(eventone.Is_Webank_event__c == false){ 
            
            vewProfileEAM =[SELECT  DiversityType__c,  AS_id__r.Id,
            AS_id__r.AS_WorkZipCode__c,
            AS_id__r.AS_WorkState__c,
            AS_id__r.AS_WorkPoBox__c,
            AS_id__r.AS_WorkPhone__c,
            AS_id__r.As_prefixNew__c,
            AS_id__r.AS_WorkCountry__c,
            AS_id__r.AS_WorkCity__c, 
            AS_id__r.AS_WorkAddress2__c, 
            AS_id__r.AS_WorkAddress1__c, 
            AS_id__r.AS_WebsiteUrl__c, 
            AS_id__r.AS_Title__c, 
            AS_id__r.AS_ThroughEventBrite__c,
            AS_id__r.AS_Suffix__c, 
            AS_id__r.AS_ShippingZipcode__c,
            AS_id__r.AS_ShippingState__c, 
            AS_id__r.AS_ShippingPoBox__c, 
            AS_id__r.AS_ShippingPhone__c,
            AS_id__r.AS_ShippingCountry__c,
            AS_id__r.AS_ShippingCity__c, 
            AS_id__r.AS_CageCode__c, 
            AS_id__r.GSA_Schedule__c,
            AS_id__r.Business_type__c, 
            AS_id__r.DBA__c,
            AS_id__r.Geographical_Region__c,
            AS_id__r.Certificate_Processed_by_RPO__c,
            AS_id__r.BBB_Number__c,
            AS_id__r.Commodity_1__c,
            AS_id__r.Commodity_2__c,
            AS_id__r.Commodity_3__c,
            AS_id__r.Commodity_4__c,
            AS_id__r.Commodity_5__c,AS_id__r.Commodity_6__c,
            AS_id__r.Commodity_7__c,
            AS_id__r.Commodity_8__c,
            AS_id__r.Commodity_9__c,
            AS_id__r.distribution_Country__c,
            AS_id__r.Manufactures_Country__c,
            AS_id__r.References__c,
            AS_id__r.References2__c,
            AS_id__r.Scope_of_Work__c,
            AS_id__r.Scope_of_Work2__c,
            AS_id__r.Any_non_WBENC_awards_received__c,
            AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
            AS_id__r.Revenue_Range__c, 
            AS_id__r.AS_NAICSCode9__c,
            AS_id__r.AS_NAICSCode8__c,
            AS_id__r.AS_NAICSCode7__c,
            AS_id__r.AS_NAICSCode6__c,
            AS_id__r.Company_Certifications__c,
            AS_id__r.AS_ShippingAddress2__c, AS_id__r.AS_ShippingAddress1__c,
            AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_Prefix__c, 
            AS_id__r.Exhibitor_company_imageUrl__c,AS_id__r.AS_NumberOfEmployees__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_3__c, 
            AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_1__c, AS_id__r.AS_LastName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_HomeZipcode__c,
            AS_id__r.AS_HomeState__c, AS_id__r.AS_HomePoBox__c, AS_id__r.AS_HomePhone__c, AS_id__r.AS_HomeCountry__c, AS_id__r.AS_HomeCity__c,
            AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_Gender__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_FaxNumber__c,
            AS_id__r.Ethnicity__c,AS_id__r.AS_Secondary_Email__c,
            AS_id__r.Business_Structure__c,AS_id__r.Year_in_business__c,
            AS_id__r.AS_Email__c, AS_id__r.AS_DiversityType__c, AS_id__r.AS_Company__c, AS_id__r.AS_CellPhone__c, 
            AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessDescription__c,
            AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_Age__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_Country__c,AS_id__r.As_Home_State__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_shippingzip__c,
            AS_id__r.AS_BusinessDunsNumber__c,AS_id__r.Keywords__c  FROM Event_Attendee_Mapping__c WHERE EV_id__r.id =: selectedEvent  AND AS_id__r.AS_Email__c =:Email];
            attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=: vewProfileEAM.AS_id__c];
            videos = [Select id,YouTubeId_c__c From Widget__c Where AttendeeSummary__r.id =: vewProfileEAM.AS_id__c];
            if(vewProfileEAM.AS_id__r.AS_Work_States__c != null && vewProfileEAM.AS_id__r.AS_Work_States__c != ''){
            vewProfileEAM.AS_id__r.AS_Work_States__c=cd12121.mapstate(vewProfileEAM.AS_id__r.AS_Work_States__c);
        }
        }else{
            vewProfileEAM = [Select  AS_id__c,MBE_Profile__r.As_prefixNew__c ,MBE_Profile__r.As_SuffixNew__c,MBE_Profile__r.As_Shipping_Country__c,MBE_Profile__r.As_Shipping_States__c,MBE_Profile__r.SystemModstamp, MBE_Profile__r.OwnerId, MBE_Profile__r.Name, MBE_Profile__r.LastModifiedDate, MBE_Profile__r.LastModifiedById,
            MBE_Profile__r.LastActivityDate, MBE_Profile__r.IsDeleted, MBE_Profile__r.Id, MBE_Profile__r.CreatedDate, MBE_Profile__r.CreatedById,MBE_Profile__r.Exhibitor_company_imageUrl__c,
            MBE_Profile__r.AS_WorkZipCode__c,MBE_Profile__r.AS_WorkPhone__c, 
            MBE_Profile__r.AS_WorkCity__c, MBE_Profile__r.AS_WorkAddress2__c, MBE_Profile__r.AS_WorkAddress1__c, MBE_Profile__r.Key_Words__c,
            MBE_Profile__r.AS_WebsiteUrl__c, MBE_Profile__r.AS_Title__c, 
            MBE_Profile__r.AS_ShippingZipcode__c, MBE_Profile__r.AS_ShippingState__c, MBE_Profile__r.AS_ShippingPoBox__c, MBE_Profile__r.AS_ShippingPhone__c, 
            MBE_Profile__r.AS_ShippingCity__c, MBE_Profile__r.AS_ShippingAddress2__c, MBE_Profile__r.AS_ShippingAddress1__c,
            MBE_Profile__r.AS_SecondaryBusinessCategory1__c, MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
            MBE_Profile__r.AS_NumberOfEmployees__c, MBE_Profile__r.AS_NAICSCode_5__c, MBE_Profile__r.AS_NAICSCode_4__c, MBE_Profile__r.AS_NAICSCode_3__c, 
            MBE_Profile__r.AS_NAICSCode_2__c, MBE_Profile__r.AS_NAICSCode_1__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_ImageUrl__c,
            MBE_Profile__r.AS_HomePhone__c,MBE_Profile__r.AS_HomeCity__c,
            MBE_Profile__r.DBA__c,
            MBE_Profile__r.Geographical_Region__c,
            MBE_Profile__r.Certificate_Processed_by_RPO__c,
            MBE_Profile__r.BBB_Number__c,
            MBE_Profile__r.Commodity_1__c,
            MBE_Profile__r.Commodity_2__c,
            MBE_Profile__r.Commodity_3__c,
            MBE_Profile__r.Commodity_4__c,
            MBE_Profile__r.Commodity_5__c,
            MBE_Profile__r.distribution_Country__c,
            MBE_Profile__r.Manufactures_Country__c,
            MBE_Profile__r.References__c,
            MBE_Profile__r.References2__c,
            MBE_Profile__r.Scope_of_Work__c,
            MBE_Profile__r.Scope_of_Work2__c,
            MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
            MBE_Profile__r.Any_non_WBENC_awards_received__c,
            MBE_Profile__r.Revenue_Range__c,
            MBE_Profile__r.AS_NAICSCode9__c,
            MBE_Profile__r.AS_NAICSCode8__c,
            MBE_Profile__r.AS_NAICSCode7__c,
            MBE_Profile__r.AS_NAICSCode6__c,MBE_Profile__r.Commodity_6__c,
            MBE_Profile__r.Commodity_7__c,
            MBE_Profile__r.Commodity_8__c,
            MBE_Profile__r.Commodity_9__c,
            MBE_Profile__r.Ethnicity__c,MBE_Profile__r.AS_Secondary_Email__c,
            MBE_Profile__r.AS_HomeAddress2__c, MBE_Profile__r.AS_HomeAddress1__c, MBE_Profile__r.AS_Gender__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_FaxNumber__c,
            MBE_Profile__r.AS_Email__c, MBE_Profile__r.AS_DiversityType__c, MBE_Profile__r.AS_Company__c, MBE_Profile__r.AS_CellPhone__c, MBE_Profile__r.AS_CageCode__c,MBE_Profile__r.GSA_Schedule__c,
            MBE_Profile__r.AS_BusinessRevenue__c, MBE_Profile__r.AS_BusinessEstablishedDate__c, MBE_Profile__r.AS_BusinessDescription__c, MBE_Profile__r.Business_type__c,MBE_Profile__r.Exceptional_Key_Words__c,
            MBE_Profile__r.AS_BlogUrl__c, MBE_Profile__r.AS_BirthDate__c, MBE_Profile__r.AS_Age__c,MBE_Profile__r.AS_Work_Country__c,MBE_Profile__r.AS_Work_States__c,MBE_Profile__r.As_Home_Country__c,MBE_Profile__r.As_Home_State__c,MBE_Profile__r.AS_WorkZip__c,MBE_Profile__r.AS_HomeZip__c,DiversityType__c,
            MBE_Profile__r.Business_Structure__c,MBE_Profile__r.Year_in_business__c,
            MBE_Profile__r.AS_BusinessDunsNumber__c,MBE_Profile__r.AS_BusinessTaxId__c,MBE_Profile__r.Company_Certifications__c from Event_Attendee_Mapping__c WHERE EV_id__r.id =: selectedEvent  AND MBE_Profile__r.AS_Email__c =:Email]; 
            system.debug(':::::::::::::;;mythily:::::::::::::::'+vewProfileEAM);
            system.debug('nnnnnnnn'+vewProfileEAM.MBE_Profile__r.References2__c);
                if(vewProfileEAM.MBE_Profile__r.AS_Work_States__c != null && vewProfileEAM.MBE_Profile__r.AS_Work_States__c !=''){
                    vewProfileEAM.MBE_Profile__r.AS_Work_States__c=cd12121.mapstate(vewProfileEAM.MBE_Profile__r.AS_Work_States__c);
                }
            attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=: vewProfileEAM.MBE_Profile__r.id];
            cvideos = new list<Custom_Widget__c>();
            cvideos = [Select id,YouTubeId_c__c From Custom_Widget__c Where MBE_Profile__r.id =: vewProfileEAM.MBE_Profile__r.id];
            system.debug('ooooooooo'+vewProfileEAM.MBE_Profile__r.References2__c);
        }
    system.debug('llllllllll'+vewProfileEAM);
    }
   







}
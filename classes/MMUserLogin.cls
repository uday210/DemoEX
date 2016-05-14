@RestResource(urlMapping='/MMUserLogin/*')


global without Sharing class MMUserLogin{

 @httpPost
 global static AllDetails doPost(){

     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string userName;     
     string passWord;
     String isMM;
     userName =req.params.get('userName');
     passWord = req.params.get('passWord');
     isMM = req.params.get('isMM');
    
     
     
     //if(isMM = 'TRUE' ){
     
     AllDetails alDetail = new AllDetails();
     
    List<user> users = new List<user>();
    // AttendeeSummary__c AttendeeId = new AttendeeSummary__c();
     system.debug('userName '+userName );
     system.debug('passWord '+passWord );
     users = [select title,Id,Username,firstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City from User where Username=:userName and Password__c=:passWord];
     //AttendeeId=[select id from AttendeeSummary__c where AS_Email__c =: users.userName];
    
     if(users.size()>0){ 
     
         List<AttendeeSummary__c> att =new List<AttendeeSummary__c>();
           att = [select AS_Work_Country__c,id,AS_ImageUrl__c,AS_Email__c, AS_CellPhone__c,AS_WorkPhone__c,AS_Work_States__c,AS_WorkCity__c,AS_Title__c,AS_Company__c,AS_FirstName__c,AS_LastName__c from AttendeeSummary__c where AS_Email__c=:userName];
            string imgurl;
             if(att.size()>0){
               imgurl =att[0].AS_ImageUrl__c;
            }
     
            string attvalues='';
            //  system.debug('PPPPPPPPPPPPPPPPPPPPPP '+[select id,EA_AttendeeBarcode__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:userName]);
            for(Event_Attendee_Mapping__c listOfjun:[select id,EA_AttendeeBarcode__c  from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:userName] ){
               if(attvalues!='' && (listOfjun.EA_AttendeeBarcode__c!=null)){
                 attvalues+=','+listOfjun.EA_AttendeeBarcode__c;
                }else{
                  attvalues=listOfjun.EA_AttendeeBarcode__c;
                }
            }
     
           /*  for(){
             
             }*/
            
            //for(user Us :users ){
              //GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(Us,att);
            if(att.size()>0){   
              GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(att[0] ,attvalues,users[0].id);
              alDetail.userProfile.add(Guser);
             }
           // }
         
                /* Commented on  27-02-2014 due to changes in login functionality, now login is based on user oject only coz UPE is not filling when user sign up  */
               /*List<User_Profile_Event__c> upesList = new List<User_Profile_Event__c>();
               upesList =[select User_id__r.userName,User_id__r.Isactive,User_id__r.Issignup__c,IsMatchMakingUser__c,Request_for_upgrade_profile__c,MAtchMakingProfile__c from User_Profile_Event__c where  User_id__c=:users[0].id]; 
                 if(upesList.size()>0){
                    if(upesList[0].IsMatchMakingUser__c==false){
                        GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Your are not Match Making user');
                         alDetail.userProfile.add(Guser45);
                         return alDetail;
                    }else if(upesList[0].Request_for_upgrade_profile__c ==true && upesList[0].MAtchMakingProfile__c=='Corporate'){
                       GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Your registration for Matchmaking as a Corporate is still pending, Please contact the Event Administrator Jerilynn Clarke at jclarke@gnemsdc.org  (203) 288-9744.');
                         alDetail.userProfile.add(Guser45);
                         return alDetail;
                    }
                 }else{
                  GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Please signup before you login');
                 
                    GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('No events found');
                         alDetail.userProfile.add(Guser45);
                         //return alDetail;
                 }*/
                  /* Commented on  27-02-2014 due to changes in login functionality, now login is based on user oject only coz UPE is not filling when user sign up  */
               }else{
        GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Invalid credentials');
         alDetail.userProfile.add(Guser45);
         return alDetail;
       }  
    
       

 
     List<Id> listOfEvents = new List<Id>();
     MAP<ID, String> loginUserProfile = new MAP<ID, String>();
    //try{ 
    List<AttendeeSummary__c> attlist = [SELECT ID, NAME FROM AttendeeSummary__c WHERE AS_Email__c =: userName ];
    // AttendeeSummary__c  attend = [SELECT ID, NAME FROM AttendeeSummary__c WHERE AS_Email__c =: userName ];
     AttendeeSummary__c  attend = attlist [0];
    
     for(User_Profile_Event__c upes:[SELECT u.User_id__c, u.Profile_id__c,u.Profile_id__r.PR_Name__c, MAtchMakingProfile__c, u.EV_id__c,u.EV_id__r.Is_MatchMaking_Event__c FROM User_Profile_Event__c u 
                                     WHERE User_id__r.userName=:userName 
                                     AND IsMatchMakingUser__c =: TRUE 
                                     AND Profile_id__r.PR_Name__c != 'EventAdmin']){
      
      system.debug('upeids+++++++++++++++++'+upes.id);
      
        listOfEvents.add(upes.EV_id__c);
        system.debug('List of events============='+listOfEvents.size());
         Event__c eve = new Event__c();
        
         // Added condition for Checking Is Match Making evnt or not
        if(upes.MAtchMakingProfile__c == 'MBE' && upes.EV_id__r.Is_MatchMaking_Event__c== TRUE){
            
            eve = [SELECT ID, NAME, e.EV_HostingZipcode__c,e.MM_Start_Date__c,e.MM_End_Date__c,e.MM_Firstaday_startTime__c,e.MM_Firstaday_EndTime__c, e.Status__c,
                  (SELECT ID, MM_slot_StartTime__c, NAME, MM_slot_Date__c, MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,
                  MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                  MM_To_UPE__r.User_id__r.Id, MM_To_UPE__r.BT_id__r.MM_TableNo__c, EV_id__r.EV_Title__c, EV_id__r.Id ,EV_id__r.Match_Making_Schedules__c
                  FROM EventSchedule__r WHERE MM_To_EAM__r.AS_id__c =: attend.Id AND Is_Matchmaking__c = TRUE),
                  (SELECT Id, Name, Profile_id__r.PR_Name__c FROM User_Profile_Event__r WHERE User_id__r.userName=:userName AND IsMatchMakingUser__c = TRUE), 
                  (SELECT Id, MatchLeads_Date__c, Start_time__c, End_Time__c FROM MatchLeads_Days__r ),
                  (select id,name,Default_Name__c,Alias_Name__c from Tags__r),
                  e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, 
                  e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, 
                  e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, e.TwitterHashTag__c,e.Match_Making_Schedules__c,
                   e.AS_HostingAddr2__c, e.MatchMaking_Type__c,Is_Webank_event__c,(SELECT Additional_Company_Brouchers__c,Additional_Company_videos__c,Any_non_WBENC_awards_received__c,BBB_Number__c,Business_Description__c,Business_Duns_Number__c,Business_Established_Date__c,Business_Revenue__c,Business_Structure_Visible__c,Business_Structure__c,Business_Tax_ID__c,Business_Type__c,Cage_Code__c,Certificate_Processed_by_RPO__c,Certifications__c,Commodities__c,Companyhaveafacility_partneroutsideUSA__c,Company_Logo__c,Company_Name__c,Contact_Image__c,Corporate_Additional_Company_Brouchers_V__c,Corporate_Additional_Company_videos_Visi__c,Corporate_Address_1_Visible__c,Corporate_Address_2_Visible__c,Corporate_BBB_Number_Visible__c,Corporate_Business_Description_Visible__c,Corporate_Certificate_Processed_by_RPO_V__c,Corporate_City_Visible__c,Corporate_Commodities_Visible__c,Corporate_Company_Logo_Visible__c,Corporate_Company_Visible__c,Corporate_Contact_Image_Visible__c,Corporate_Country_Visible__c,Corporate_DBA_Visible__c,Corporate_Distributors_Country_Visible__c,Corporate_exceptional_keywords_visible__c,Corporate_E_Mail_Visible__c,Corporate_First_Name_Visible__c,Corporate_Geographical_Region_Visible__c,Corporate_Job_Title_Visible__c,Corporate_Location_Visible__c,Corporate_Logo_Visible__c,Corporate_Manufactures_Country_Visible__c,Corporate_Mobile_Phone_Visible__c,Corporate_NAICS_CODES_Visible__c,Corporate_Phone_Visible__c,Corporate_Primary_Business_Category_Visi__c,Corporate_Procurement_Visible__c,Corporate_Salutation_Visible__c,Corporate_Secondary_Business_Category_Vi__c,Corporate_State_Visible__c,Corporate_Table_Room_No_Visible__c,Corporate_Website_Registration_Link_Vi__c,Corporate_Work_Address_Visible__c,Corporate_ZIP_Code_Visible__c,Country__c,CreatedById,CreatedDate,DBA__c,Distributors_Country__c,Email_Id__c,Ethnicity__c,Event__c,exceptional_keywords__c,FaxNumber_Visible__c,FaxNumber__c,First_Name__c,Geographical_Region__c,GSA_Schedule_Contract_Number__c,Id,IsDeleted,Job_Title__c,KeyWords__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Last_Name__c,Location__c,Manufatures_Country__c,MBEAny_non_WBENC_awards_received_visible__c,MBECompanyhavefacility_partneroutsideUSA__c,MBEScope_of_Work2_Visible__c,MBEScope_of_Work__c,MBE_Additional_Company_Brouchers_Visible__c,MBE_Additional_Company_videos_Visible__c,MBE_Address_1_Visible__c,MBE_Address_2_Visible__c,MBE_BBB_Number_Visible__c,MBE_Business_Description_Visible__c,MBE_Business_Duns_Number_Visible__c,MBE_Business_Established_Date_Visible__c,MBE_Business_Revenue_Visible__c,MBE_Business_Tax_ID_Visible__c,MBE_Business_Type_Visible__c,MBE_Cage_Code_Visible__c,MBE_Certificate_Processed_by_RPO_Visible__c,MBE_Certifications_Visible__c,MBE_City_Visible__c,MBE_Commodities_Visible__c,MBE_Company_Logo_Visible__c,MBE_Company_Visible__c,MBE_Country_Visible__c,MBE_DBA_Visible__c,MBE_Distributors_Country_Visible__c,MBE_Email_Visible__c,MBE_Ethnicity_Visible__c,MBE_First_Name_Visible__c,MBE_Geographical_Region_Visible__c,MBE_GSA_Schedule_Contract_Number_Visible__c,MBE_Job_Title_Visible__c,MBE_LastName_Visible__c,MBE_Manufatures_Country_Visible__c,MBE_Mobile_Phone_Visible__c,MBE_NAICS_CODES_Visible__c,MBE_Number_Of_Employees_Visible__c,MBE_Primary_Business_Category_Visible__c,MBE_Procurement_Needs_Visible__c,MBE_Products_Services_Visible__c,MBE_References2_Visible__c,MBE_References_Visible__c,MBE_Revenue_Range_Visible__c,MBE_Salutation_Visible__c,MBE_Secondary_Business_Category_Visible__c,MBE_Secondary_Email_Visible__c,MBE_Small_Business_Image_Visible__c,MBE_State_Visible__c,MBE_Title_Visible__c,MBE_Uploaded_Company_Brochures_Visible__c,MBE_Uploaded_Video_Visible__c,MBE_Website_Visible__c,MBE_Work_Address_Visibility__c,MBE_Work_Phone_Visible__c,MBE_Year_in_Business_Visible__c,MBE_Zip_Code_Visible__c,Mobile__c,NAICS_Codes__c,Name,Number_Of_Employees__c,OwnerId,Primary_Business_Category__c,Products_NOT_interested_visible__c,Products_Services__c,Reference2__c,References__c,Revenue_Range__c,Salutation__c,Scope_of_Work2__c,Scope_of_Work__c,Secondary_Business_Category__c,Secondary_Email__c,Small_Business_IMAGE__c,State__c,SystemModstamp,Title__c,Uploaded_Company_Brochures__c,Uploaded_Video__c,Website__c,Work_Address__c,Work_phone__c,Year_in_business_Visible__c,Year_in_Business__c,Zip_Code__c FROM Profile_Settings__r) From Event__c e where Id =: upes.EV_id__c ];
           
       // Added condition for Checking Is Match Making evnt or not
        }else if(upes.MAtchMakingProfile__c == 'Corporate' && upes.EV_id__r.Is_MatchMaking_Event__c== TRUE ){
            eve = [SELECT ID, NAME, e.EV_HostingZipcode__c,e.MM_Start_Date__c,e.MM_End_Date__c,e.MM_Firstaday_startTime__c,e.MM_Firstaday_EndTime__c, e.Status__c,
                  (SELECT ID, MM_slot_StartTime__c, NAME, MM_slot_Date__c, MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, 
                  MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_Company__c, MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_EAM__r.AS_id__r.Id, 
                  MM_To_UPE__r.BT_id__r.MM_TableNo__c, EV_id__r.EV_Title__c, EV_id__r.Id,EV_id__r.Match_Making_Schedules__c
 FROM EventSchedule__r WHERE MM_To_UPE__c =: upes.id  AND Is_Matchmaking__c = TRUE),
                  (SELECT Id, Name, Profile_id__r.PR_Name__c FROM User_Profile_Event__r WHERE User_id__r.userName=:userName  AND IsMatchMakingUser__c = TRUE),
                  (SELECT Id, MatchLeads_Date__c, Start_time__c, End_Time__c FROM MatchLeads_Days__r ), 
                  (select id,name,Default_Name__c,Alias_Name__c from Tags__r), 
                  e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, e.EV_HostingPhone__c, 
                  e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, 
                  e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, e.TwitterHashTag__c,e.Match_Making_Schedules__c,
 e.AS_HostingAddr2__c, e.MatchMaking_Type__c,Is_Webank_event__c ,(SELECT Additional_Company_Brouchers__c,Additional_Company_videos__c,Any_non_WBENC_awards_received__c,BBB_Number__c,Business_Description__c,Business_Duns_Number__c,Business_Established_Date__c,Business_Revenue__c,Business_Structure_Visible__c,Business_Structure__c,Business_Tax_ID__c,Business_Type__c,Cage_Code__c,Certificate_Processed_by_RPO__c,Certifications__c,Commodities__c,Companyhaveafacility_partneroutsideUSA__c,Company_Logo__c,Company_Name__c,Contact_Image__c,Corporate_Additional_Company_Brouchers_V__c,Corporate_Additional_Company_videos_Visi__c,Corporate_Address_1_Visible__c,Corporate_Address_2_Visible__c,Corporate_BBB_Number_Visible__c,Corporate_Business_Description_Visible__c,Corporate_Certificate_Processed_by_RPO_V__c,Corporate_City_Visible__c,Corporate_Commodities_Visible__c,Corporate_Company_Logo_Visible__c,Corporate_Company_Visible__c,Corporate_Contact_Image_Visible__c,Corporate_Country_Visible__c,Corporate_DBA_Visible__c,Corporate_Distributors_Country_Visible__c,Corporate_exceptional_keywords_visible__c,Corporate_E_Mail_Visible__c,Corporate_First_Name_Visible__c,Corporate_Geographical_Region_Visible__c,Corporate_Job_Title_Visible__c,Corporate_Location_Visible__c,Corporate_Logo_Visible__c,Corporate_Manufactures_Country_Visible__c,Corporate_Mobile_Phone_Visible__c,Corporate_NAICS_CODES_Visible__c,Corporate_Phone_Visible__c,Corporate_Primary_Business_Category_Visi__c,Corporate_Procurement_Visible__c,Corporate_Salutation_Visible__c,Corporate_Secondary_Business_Category_Vi__c,Corporate_State_Visible__c,Corporate_Table_Room_No_Visible__c,Corporate_Website_Registration_Link_Vi__c,Corporate_Work_Address_Visible__c,Corporate_ZIP_Code_Visible__c,Country__c,CreatedById,CreatedDate,DBA__c,Distributors_Country__c,Email_Id__c,Ethnicity__c,Event__c,exceptional_keywords__c,FaxNumber_Visible__c,FaxNumber__c,First_Name__c,Geographical_Region__c,GSA_Schedule_Contract_Number__c,Id,IsDeleted,Job_Title__c,KeyWords__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Last_Name__c,Location__c,Manufatures_Country__c,MBEAny_non_WBENC_awards_received_visible__c,MBECompanyhavefacility_partneroutsideUSA__c,MBEScope_of_Work2_Visible__c,MBEScope_of_Work__c,MBE_Additional_Company_Brouchers_Visible__c,MBE_Additional_Company_videos_Visible__c,MBE_Address_1_Visible__c,MBE_Address_2_Visible__c,MBE_BBB_Number_Visible__c,MBE_Business_Description_Visible__c,MBE_Business_Duns_Number_Visible__c,MBE_Business_Established_Date_Visible__c,MBE_Business_Revenue_Visible__c,MBE_Business_Tax_ID_Visible__c,MBE_Business_Type_Visible__c,MBE_Cage_Code_Visible__c,MBE_Certificate_Processed_by_RPO_Visible__c,MBE_Certifications_Visible__c,MBE_City_Visible__c,MBE_Commodities_Visible__c,MBE_Company_Logo_Visible__c,MBE_Company_Visible__c,MBE_Country_Visible__c,MBE_DBA_Visible__c,MBE_Distributors_Country_Visible__c,MBE_Email_Visible__c,MBE_Ethnicity_Visible__c,MBE_First_Name_Visible__c,MBE_Geographical_Region_Visible__c,MBE_GSA_Schedule_Contract_Number_Visible__c,MBE_Job_Title_Visible__c,MBE_LastName_Visible__c,MBE_Manufatures_Country_Visible__c,MBE_Mobile_Phone_Visible__c,MBE_NAICS_CODES_Visible__c,MBE_Number_Of_Employees_Visible__c,MBE_Primary_Business_Category_Visible__c,MBE_Procurement_Needs_Visible__c,MBE_Products_Services_Visible__c,MBE_References2_Visible__c,MBE_References_Visible__c,MBE_Revenue_Range_Visible__c,MBE_Salutation_Visible__c,MBE_Secondary_Business_Category_Visible__c,MBE_Secondary_Email_Visible__c,MBE_Small_Business_Image_Visible__c,MBE_State_Visible__c,MBE_Title_Visible__c,MBE_Uploaded_Company_Brochures_Visible__c,MBE_Uploaded_Video_Visible__c,MBE_Website_Visible__c,MBE_Work_Address_Visibility__c,MBE_Work_Phone_Visible__c,MBE_Year_in_Business_Visible__c,MBE_Zip_Code_Visible__c,Mobile__c,NAICS_Codes__c,Name,Number_Of_Employees__c,OwnerId,Primary_Business_Category__c,Products_NOT_interested_visible__c,Products_Services__c,Reference2__c,References__c,Revenue_Range__c,Salutation__c,Scope_of_Work2__c,Scope_of_Work__c,Secondary_Business_Category__c,Secondary_Email__c,Small_Business_IMAGE__c,State__c,SystemModstamp,Title__c,Uploaded_Company_Brochures__c,Uploaded_Video__c,Website__c,Work_Address__c,Work_phone__c,Year_in_business_Visible__c,Year_in_Business__c,Zip_Code__c FROM Profile_Settings__r)
                  From Event__c e where Id =: upes.EV_id__c];
        }
        
       //  if(upes.MAtchMakingProfile__c=='MBE' ){
       // Added condition for Checking Is Match Making evnt or not and not sending empty event
            if(upes.EV_id__r.Is_MatchMaking_Event__c== TRUE ){
            GlobalUtillClass.MMEventDetails Gevents = new GlobalUtillClass.MMEventDetails(eve,upes.MAtchMakingProfile__c ); 
            alDetail.MMeventDetails.add(Gevents);
            }
         // }else if(upes.MAtchMakingProfile__c =='Corporate'){
        //   GlobalUtillClass.MMEventDetails Gevents = new GlobalUtillClass.MMEventDetails(eve,'Booth Admin'); 
         //   alDetail.MMeventDetails.add(Gevents);
        //   }
        
      /*  for(EventSchedule__c sche: eve.EventSchedule__r){
                    
             if(upes.MAtchMakingProfile__c == 'MBE'){
                 GlobalUtillClass.MMEXSchedules mmexsc = new GlobalUtillClass.MMEXSchedules(sche, sche.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, sche.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, sche.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, sche.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, sche.MM_To_UPE__r.User_id__r.Id );
                 alDetail.MMEXSchedules.add(mmexsc);
                 system.debug('mmexsc----'+mmexsc);
             }else  if(upes.MAtchMakingProfile__c == 'Corporate'){
                 GlobalUtillClass.MMEXSchedules mmexsc = new GlobalUtillClass.MMEXSchedules(sche, sche.MM_To_EAM__r.AS_id__r.AS_FirstName__c, sche.MM_To_EAM__r.AS_id__r.AS_LastName__c, sche.MM_To_EAM__r.AS_id__r.AS_Company__c, sche.MM_To_EAM__r.AS_id__r.AS_Email__c, sche.MM_To_EAM__r.AS_id__r.Id);
                 alDetail.MMEXSchedules.add(mmexsc);
                 system.debug('mmexsc----'+mmexsc);
             }
             
        }
        
        system.debug('alDetail----'+alDetail);
         system.debug('alDetail.MMEXSchedules----'+alDetail.MMEXSchedules);*/
        
     }
    // }catch(exception e){ } 
    
    
  
   
     
    
   return alDetail;
   
}


global class AllDetails{
string lastRecordId ;
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
//List<GlobalUtillClass.EventDetails> eventDetails = new List<GlobalUtillClass.EventDetails>();
List<GlobalUtillClass.MMEventDetails> MMeventDetails = new List<GlobalUtillClass.MMEventDetails>();
List<GlobalUtillClass.EventSchedule> EventSchedule = new List<GlobalUtillClass.EventSchedule>();
List<GlobalUtillClass.BoothDetails> Exhibitors = new List<GlobalUtillClass.BoothDetails>();
List<GlobalUtillClass.leads> Leads = new List<GlobalUtillClass.leads>();
List<GlobalUtillClass.MMEXSchedules> MMEXSchedules = new List<GlobalUtillClass.MMEXSchedules>();
}
  


}
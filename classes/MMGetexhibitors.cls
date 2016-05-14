@RestResource(urlMapping='/MMGetexhibitors/*')

/**
 * AUTHOR: Rajesh 
 * Email : rajeshc@globalnest.com
 * Phone : 9985445095
 * AIM   : Sends Exhibitor Search Results for Attendee
 */
global without sharing class MMGetexhibitors{

@httpPost
  
 global static AllDetails doPost(){
  
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;         
     String isMM;
     eveid =req.params.get('eveid');    
     isMM = req.params.get('isMM');
     system.debug('eveid---'+eveid);
     
         AllDetails alDetail = new AllDetails();
         List<User_Profile_Event__c> exdtls = new List<User_Profile_Event__c>();
         
          
         exdtls = [SELECT Attendee_Summary__r.Exceptional_Key_Words__c,Attendee_Summary__r.Id, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, 
         Attendee_Summary__r.AS_Email__c, Attendee_Summary__r.Company_Certifications__c, Attendee_Summary__r.AS_CellPhone__c, Attendee_Summary__r.AS_ImageUrl__c, 
         Attendee_Summary__r.Exhibitor_company_imageUrl__c,  Attendee_Summary__r.AS_PrimaryBusinessCategory1__c, 
         Attendee_Summary__r.As_SecondaryBusinessCategory1__c, 
         Attendee_Summary__r.AS_WebsiteUrl__c, Attendee_Summary__r.AS_WorkAddress1__c, 
         Attendee_Summary__r.AS_WorkAddress2__c, Attendee_Summary__r.AS_WorkCity__c, 
         Attendee_Summary__r.AS_Work_Country__c, Attendee_Summary__r.AS_Work_States__c, 
         Attendee_Summary__r.AS_WorkZip__c, Attendee_Summary__r.AS_HomeState__c, 
         Attendee_Summary__r.AS_Company__c, Attendee_Summary__r.AS_Title__c,
         Attendee_Summary__r.AS_NAICSCode_1__c, Attendee_Summary__r.AS_NAICSCode_2__c, 
         Attendee_Summary__r.AS_NAICSCode_3__c, Attendee_Summary__r.AS_NAICSCode_4__c, 
         Attendee_Summary__r.AS_NAICSCode_5__c, Attendee_Summary__r.Keywords__c,
         Attendee_Summary__r.AS_BusinessDescription__c,Attendee_Summary__r.Commodity_1__c,Attendee_Summary__r.Commodity_2__c,
         Attendee_Summary__r.Commodity_3__c,Attendee_Summary__r.Commodity_4__c,Attendee_Summary__r.Commodity_5__c,   
         BT_id__r.Table_Room_No__c, BT_id__r.BT_Location__c, User_id__r.Id,BT_id__r.MM_TableNo__c,Attendee_Summary__r.AS_WorkPhone__c
             FROM User_Profile_Event__c 
             WHERE IsMatchMakingUser__c = true  
             AND MAtchMakingProfile__c = 'Corporate' 
             AND EV_id__r.Id =: eveid  
             AND Request_for_upgrade_profile__c=false 
             AND Attendee_Summary__r.AS_FirstName__c!= NULL 
             AND Attendee_Summary__r.AS_Email__c!= NULL 
             AND Attendee_Summary__r.AS_LastName__c!= NULL];         
        
        
        if(exdtls.size()>0){
        for(User_Profile_Event__c upe :exdtls)
         {
           GlobalUtillClass.MMEXHDetails mmexdtls = new GlobalUtillClass.MMEXHDetails(upe);
           alDetail.MMEXHDetails.add(mmexdtls);
            system.debug('mmexdtls----------'+mmexdtls);
         
         } 
         }else{
           GlobalUtillClass.globalMessage mmexdtls = new GlobalUtillClass.globalMessage('No Records Found');
           alDetail.globalMessage.add(mmexdtls);
         }
        
     return alDetail;  

}

         

global class AllDetails{
List<GlobalUtillClass.globalMessage> globalMessage = new List<GlobalUtillClass.globalMessage>();
List<GlobalUtillClass.MMEXHDetails> MMEXHDetails = new List<GlobalUtillClass.MMEXHDetails>();

}
}
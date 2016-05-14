@RestResource(urlMapping='/EXSerach/*')

/**
 * AUTHOR: Rajesh 
 * Email : rajeshc@globalnest.com
 * Phone : 9985445095
 * AIM   : Sends Exhibitor Search Results for Attendee
 */

global without Sharing class EXSerach{

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
             GlobalUtillClass.UserDetails emptkey = new GlobalUtillClass.UserDetails('Please Enter keyword');
             alDetail.userProfile.add(emptkey);
             return alDetail;
            }/*else{
            mykey = '%' + keyword + '%';
            system.debug('mykey---'+mykey);
            }*/
     
         List<User_Profile_Event__c> upeulist = new List<User_Profile_Event__c>();
         upeulist = [SELECT Id, BoothAdmin_id__c, User_id__c,Attendee_Summary__r.Id FROM User_Profile_Event__c WHERE EV_id__c =: eveid AND MAtchMakingProfile__c = 'Corporate' AND IsMatchMakingUser__c = TRUE];
         if(upeulist.size()<=0){
             GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Event Not Found');
             alDetail.userProfile.add(Guser45);
             return alDetail;
            }  
         
         
         List<Id> listOfattendees = new List<Id>();
         MAP<String, String> UserDetails= new MAP<String, String>();
         
         for(User_Profile_Event__c upe :upeulist )
         {
           listOfattendees.add(upe.Attendee_Summary__r.Id);
           UserDetails.put(upe.Attendee_Summary__c ,upe.BoothAdmin_id__c);
         }  
         
         if(keyword.isNumeric() == TRUE && keyword.length() == 6){
             for(AttendeeSummary__c asr:[Select id,AS_FirstName__c, AS_LastName__c, AS_Email__c, AS_Company__c, AS_NAICSCode_1__c, AS_PrimaryBusinessCategory__c, AS_ImageUrl__c, Keywords__c from AttendeeSummary__c 
                                     where id in : listOfattendees 
                                     and (AS_NAICSCode_1__c = :keyword or AS_FirstName__c LIKE : '%'+keyword+'%' 
                                     or AS_LastName__c LIKE : '%'+keyword+'%' 
                                     or  AS_Email__c LIKE : '%'+keyword+'%' 
                                     or AS_Company__c LIKE : '%'+keyword+'%' 
                                     or AS_PrimaryBusinessCategory__c LIKE : '%'+keyword+'%'
                                     )]){
                                     
                                      //  or Keywords__c LIKE : '%'+keyword+'%' )]){
                         
                                     
                                     
             
             GlobalUtillClass.MMSearchRes srchres = new GlobalUtillClass.MMSearchRes(asr, UserDetails.get(asr.id)); 
             alDetail.MMSearchResults.add(srchres); }
             }else{
             for(AttendeeSummary__c asr:[Select id,AS_FirstName__c, AS_LastName__c, AS_Email__c, AS_Company__c, AS_NAICSCode_1__c, AS_PrimaryBusinessCategory__c, AS_ImageUrl__c, Keywords__c from AttendeeSummary__c 
                                     where id in : listOfattendees 
                                     and (AS_FirstName__c LIKE : '%'+keyword+'%' 
                                     or AS_LastName__c LIKE : '%'+keyword+'%' 
                                     or  AS_Email__c LIKE : '%'+keyword+'%' 
                                     or AS_Company__c LIKE : '%'+keyword+'%' 
                                     or AS_PrimaryBusinessCategory__c LIKE : '%'+keyword+'%'
                                      )]){
             //or Keywords__c LIKE : '%'+keyword+'%'
             GlobalUtillClass.MMSearchRes srchres = new GlobalUtillClass.MMSearchRes(asr, UserDetails.get(asr.id)); 
             alDetail.MMSearchResults.add(srchres); }
             }
         /* AS_NAICSCode_1__c = :Decimal.valueOf(keyword)]){  */
     
     
     
     return alDetail;  

}

global class AllDetails{
string lastRecordId ;
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.MMSearchRes> MMSearchResults= new List<GlobalUtillClass.MMSearchRes>();
}
}
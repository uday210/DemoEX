@RestResource(urlMapping='/KSK_EventExhibitors/*')

global without sharing class KSK_EventExhibitors{

  global static string eventId{get;set;}  
  
  @httpPost
  global static AllDetails doPost(){
     RestRequest req =Restcontext.request;
     RestResponse res =Restcontext.response;
     
     eventId = req.params.get('eveid');
     system.debug('eventId ================= '+eventId );
     AllDetails alDetail = new AllDetails();

      
     List<Booth__c> boo = new List<Booth__c>();
     boo = [Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c,
           BT_Location__c, BT_PDFLocation__c,BT_RegistrationLink__c,BT_Phone__c,EV_id__c,EV_id__r.EV_Title__c,
           (SELECT Id,Parameters__c FROM Floor_Map__r)
           from Booth__c where EV_id__c =:eventId ];
      system.debug(boo.size());     

    

    for(Booth__c booths :boo){
         for(Floor_Map__c fm:booths.Floor_Map__r){
             if(fm.Parameters__c !=null){             
             GlobalUtillClass.KSKBoothDetails Gbooths = new GlobalUtillClass.KSKBoothDetails(booths); 
             alDetail.Exhibitors.add(Gbooths);   
         }
     }
       
    }  
      
      
    
   return alDetail ; 
     }
     
     
  global class AllDetails{
     List<GlobalUtillClass.KSKBoothDetails> Exhibitors = new List<GlobalUtillClass.KSKBoothDetails>();
  }   
 }
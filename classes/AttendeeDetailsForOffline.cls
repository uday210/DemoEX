@RestResource(urlMapping='/AttendeeDetailsForOffline/*')

/**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : To send attendee
 */
 global without Sharing class AttendeeDetailsForOffline{
   
   
   @httpPost
    
   global static List<VERIFYLEAD.Leads> doPost(){
   RestRequest req = RestContext.request;
   RestResponse res = RestContext.response;
  // Blob reqbody =req.requestBody;
   List<id> attendeeBarcodeIds = new List<id>();
  string  Reqblobbody =  req.headers.get('barcodes');
  
  system.debug('3333333333 '+Reqblobbody );
 // Reqblobbody ='["a0CZ000000Iy6MrMAJ","a0CZ000000Iy6N6MAJ","a0CZ000000Iy6N7MAJ"]';
  
  Reqblobbody=Reqblobbody.remove('[');
  Reqblobbody=Reqblobbody.remove(']');
  Reqblobbody=Reqblobbody.replaceAll('"','');
   
  
  for(string str :Reqblobbody.split(',')){
  attendeeBarcodeIds.add(str);
  }
  
   /**
      JSONParser Parser = JSON.createParser(Reqblobbody);
       While(parser.nextToken()!= null){
        if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
         while(parser.nextToken() != null){
          if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
            inncls bl = (inncls)parser.readValueAs(inncls.class);
            attendeeBarcodeIds.add(bl.id);
            system.debug('333333333333 '+bl);
        }
      }
    }
   }
  **/
  system.debug('444444444444444 '+attendeeBarcodeIds);
  
  
  
  
  List<VERIFYLEAD.Leads> lidtOfattendees = new List<VERIFYLEAD.Leads>();
  
 for(Event_Attendee_Mapping__c AtSummary:[Select  AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,id,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Work_Country__c,EV_id__r.EV_Title__c,UniqNo__c from  Event_Attendee_Mapping__c where  id IN :attendeeBarcodeIds]){
    lidtOfattendees.add(new verifyLead.Leads(AtSummary.AS_id__r.AS_FirstName__c,AtSummary.AS_id__r.AS_LastName__c,AtSummary.AS_id__r.AS_Email__c,AtSummary.AS_id__r.AS_Company__c,AtSummary.AS_id__r.AS_WorkCity__c,AtSummary.AS_id__r.AS_Work_States__c,AtSummary.AS_id__r.AS_WorkPhone__c,AtSummary.AS_id__r.AS_Title__c,AtSummary.id,AtSummary.AS_id__r.AS_ImageUrl__c,AtSummary.AS_id__r.AS_Work_Country__c,AtSummary.EV_id__r.EV_Title__c,AtSummary.UniqNo__c));
   system.debug('444444444444444 '+lidtOfattendees);
   }
     
   return lidtOfattendees ;
   }
  
   
   global class inncls{
    string id;
   }
   
   
}
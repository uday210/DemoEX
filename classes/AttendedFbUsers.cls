@RestResource(urlMapping='/AttendedFbUsers/*')
 /**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : sending facabook friends attend status to user
 */
 global without sharing class AttendedFbUsers{
   global static string userid;
    global static string eventid;
    
   @HttpPost
   global static List<boothlead> doPost(){
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     userid=req.params.get('userid');
     eventid =req.params.get('eventIDForFB');
     Blob reqbody =req.requestBody;
     system.debug('11111 '+reqbody);
     string Reqblobbody = reqbody.toString();
     system.debug('22222 '+Reqblobbody);
     List<BoothLead> abcd = new List<BoothLead>();
    MAP<string,BoothLead> ab = new MAP<string,BoothLead>();

List<Id> listOfids = new List<Id>();
//string Reqblobbody='[{"id":"596207598","Name":"Mk Chakravarthy"},{"id":"596207599","Name":"Ch Phani"}]';
JSONParser Parser = JSON.createParser(Reqblobbody);
  While(parser.nextToken()!= null){
   if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
     while(parser.nextToken() != null){
      if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
         AttendedFbUsers.Boothlead bl = (AttendedFbUsers.BoothLead)parser.readValueAs(AttendedFbUsers.Boothlead.class);
         ab.put(bl.id,bl);
         system.debug('helloooooooooooo '+ab.keyset());          
     }
    }
  }
 }

      set<string> attendedUsers = new set<string>();
    for(DeviceUsage__c FBusers:[select id,User__r.FaceBookId__c from DeviceUsage__c where EV_id__r.Id=:eventid and  User__r.FaceBookId__c IN :ab.keyset()]){
    attendedUsers.add(FBusers.User__r.FaceBookId__c);
       system.debug('55555555555555555555 '+FBusers.id);   
    }
    
     system.debug('helloooooooooooo '+attendedUsers);   
     
    List<boothlead> boothleadlist = new List<boothlead>();
    
    if(attendedUsers.size()<=0){
        BoothLead bd = new BoothLead('No friends found');  
        boothleadlist.add(bd);  
        return boothleadlist;
    }
    
    
    for(string ids:attendedUsers){
     boothleadlist.add(ab.get(ids));            
    }
    
    
    
   return boothleadlist; 
    
   }
   
 global class BoothLead{
 global string id{get;set;}
 global string Name{get;set;}   
 global string message{get;set;}
 public BoothLead(string s){
 message=s;
 }
 }
   
   
   
 }
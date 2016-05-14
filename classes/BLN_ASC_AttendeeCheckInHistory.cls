@RestResource(urlMapping='/BLN_ASC_AttendeeCheckInHistory')

global class BLN_ASC_AttendeeCheckInHistory {

@HttpPost

global static list<TicketCheckInhistory> doPost() {
try{

    list<TicketCheckInhistory> res = new list<TicketCheckInhistory>();
    List <Tstatus__c> checkin = new List <Tstatus__c>();
    RestRequest req = RestContext.Request;
    String ticket_Id = req.params.get('Ticket_Id');
    
    system.debug('iiiiiiiii'+ticket_Id);
      MAP<String,GN_user__c> mapEmailWithGnusr = new MAP<String,GN_user__c>(); 
      GN_User__c tc = new GN_User__c();
      SET<id> uids = new SET<id>();
      MAP<String,GN_User__c> mapIdWithUser = new MAP<String,GN_User__c>(); 
    try{ 
     System.debug('YYYY '+ticket_Id);
     for(Tstatus__c tu : [select Owner.userName,Owner.id,id,Device_Name__c,Tstatus_name__c,LastModifiedDate,Ticket__c,ownerID from Tstatus__c where Ticket__r.id=:ticket_Id order by LastModifiedDate desc]){
         uids.add(tu.owner.id); 
      }
      for(GN_User__c tcUid :[select First_Name__c,Last_Name__c,Email__c,User__c from GN_User__c Where user__c In :uids]){
       mapIdWithUser.put(tcUid.Email__c,tcUid ); 
     }
    System.debug('JJJJJJJJJ '+mapIdWithUser);
    
      
    }catch(exception ty){}
    
    
    
    for(Tstatus__c ticketStatus :[select id,Device_Name__c,Tstatus_name__c,LastModifiedDate,Ticket__c,owner.id,owner.userName from Tstatus__c where Ticket__c=:ticket_Id order by LastModifiedDate desc]) {
     system.debug('ddddddddd'+ticketStatus);
     DateTime ts = ticketStatus.LastModifiedDate;
     string dateOutput = ts.formatGMT('yyyy-MM-dd hh:mm:ss a');  
     system.debug('Date String'+ticketStatus.owner.userName); 
     res.add(new TicketCheckInhistory(dateOutput,ticketStatus.Tstatus_name__c,ticketStatus.Ticket__c,ticketStatus.Device_Name__c,mapIdWithUser.get(ticketStatus.owner.userName)));
     system.debug('xyz');
    }
     system.debug('rrrrrrrrr'+res);
    //return [select LastModifiedDate,Ticket__c,Tstatus_name__c from Tstatus__c Where Ticket__c = :ticket_Id];
    return res;
    }
    catch(Exception e){
    e.getMessage() ;  
      return null;
    }
}
global class TicketCheckInhistory{

     public string LastModifiedDate;
     public boolean Tstatus_name;
     public id Ticket;
     public String Device {get;set;}
     public GN_User__c gnUser{get;set;}
     public  TicketCheckInhistory(string LastModifiedDate , boolean  Tstatus_name, id Ticket,String osName,GN_User__c gnu)
         {
             this.LastModifiedDate=LastModifiedDate;
             this.Tstatus_name=Tstatus_name;
             this.Ticket=Ticket;
             this.Device = osName;
             gnUser =new GN_User__c();
             this.gnUser =gnu;
         }
        
      }
}
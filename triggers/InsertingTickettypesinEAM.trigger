trigger InsertingTickettypesinEAM on Ticket_Eam__c(after insert){

 LIST<Event_Attendee_Mapping__c> eamlist=new LIST<Event_Attendee_Mapping__c>{};
 
 SET<Event_Attendee_Mapping__c> updateattendeeset = new SET<Event_Attendee_Mapping__c>();
 string ss='';
 SET<id> eamids =new SET<id>();
 LIST<Ticket_Eam__c> Ticketlist=new LIST<Ticket_Eam__c>{};
 MAP<Id,String> tickettypes = new  MAP<Id,String>();
     
 for(Ticket_Eam__c tickettype : trigger.new){
    id eamid = tickettype.Event_Attendee_Mapping__c;    
    eamids.add(eamid);
 } 

 eamlist = [select Attendee_Types__c,id,TicketTypes__c,EV_id__r.Is_MatchMaking_Event__c,IsMatchMakingAttendee__c,Boothleads_Profile__c from Event_Attendee_Mapping__c where id IN : eamids];
 
 
 SET<ID> ids1 = trigger.newmap.keyset();
 
 List<Ticket_Eam__c> Tickets = [select Event_Attendee_Mapping__r.EV_id__r.Is_MatchMaking_Event__c,TicketTypes__r.Type__c,TicketTypes__r.TT_Name__c,Event_Attendee_Mapping__r.id,Event_Attendee_Mapping__r.IsMatchMakingAttendee__c,Event_Attendee_Mapping__r.Boothleads_Profile__c,TicketTypes__r.Ticket_Category__c from Ticket_Eam__c where Event_Attendee_Mapping__r.id IN : eamids  AND ID IN : ids1];
 List<Event_Attendee_Mapping__c> updateeamlist = new List<Event_Attendee_Mapping__c>();
 List<Event_Attendee_Mapping__c> updateeamlist1 = new List<Event_Attendee_Mapping__c>();
 
 for(Event_Attendee_Mapping__c eamnew : eamlist){
    ss='';
   for(Ticket_Eam__c tics : Tickets){
      if(tics.Event_Attendee_Mapping__r.id==eamnew.id){
        ss = eamnew.TicketTypes__c;
        system.debug('OOOOOOOOOOOOOOOOOOOOOOOOOOOOO '+ss);
         if(ss!='' && ss!=null){
             if((ss.tolowercase()).contains(tics.TicketTypes__r.TT_Name__c)){ 
                
             }else{
                eamnew.TicketTypes__c+=','+tics.TicketTypes__r.TT_Name__c;
                system.debug('BBBBBBBBBBBBBBBBBBb '+eamnew);
             }
         }else{
            
            eamnew.TicketTypes__c=tics.TicketTypes__r.TT_Name__c;
             
             system.debug('GGGGGGGGGGGGGGGGgg '+eamnew);
         }
            if(eamnew.EV_id__r.Is_MatchMaking_Event__c==true){
            
               if(tics.TicketTypes__r.Type__c =='Match Leads Buyer'){
                 eamnew.Boothleads_Profile__c ='Booth Admin';
                }else if(tics.TicketTypes__r.Ticket_Category__c=='Sponsor'){
                eamnew.Boothleads_Profile__c ='SPONSOR';
                }else if(tics.TicketTypes__r.Type__c =='Match Leads Seller'){
                eamnew.Boothleads_Profile__c ='Attendee';
                }
               // if(tics.TicketTypes__r.Ticket_Category__c=='Corporate' || tics.TicketTypes__r.Ticket_Category__c=='MBE' && tics.TicketTypes__r.TT_Name__c == 'One on One Session Only'){
                if(tics.TicketTypes__r.Type__c =='Match Leads Buyer'||tics.TicketTypes__r.Type__c =='Match Leads Seller'){
                 eamnew.IsMatchMakingAttendee__c  =true;}
          }
          
           system.debug(' STRING CHECK33333333333  '+eamnew.Attendee_Types__c +'AAAAAAAAAAAAAAAA '+tics.TicketTypes__r.Ticket_Category__c);
           
             if(eamnew.Attendee_Types__c == NULL && tics.TicketTypes__r.Ticket_Category__c != NULL){
                        eamnew.Attendee_Types__c= tics.TicketTypes__r.Ticket_Category__c;
                    }else if(eamnew.Attendee_Types__c != NULL && tics.TicketTypes__r.Ticket_Category__c != NULL){
                        String duplicateCheck= eamnew.Attendee_Types__c;
                        String checkString= tics.TicketTypes__r.Ticket_Category__c;
                        system.debug(' STRING CHECK1111111  '+duplicateCheck+'    '+checkString);
                        if(duplicateCheck.contains(checkString)){
                            system.debug(' STRING CHECK2222222  '+duplicateCheck);
                        }else{
                            eamnew.Attendee_Types__c += ','+tics.TicketTypes__r.Ticket_Category__c;
                            system.debug(' STRING CHECK33333333333  '+eamnew.Attendee_Types__c);
                        }
                    }
              
       }
    }
    
    updateeamlist.add(eamnew);
  }
  system.debug('TTTTTTTTTTTTTTTTTTTTTtt '+updateeamlist);
  dataBase.update(updateeamlist,false);
  
}
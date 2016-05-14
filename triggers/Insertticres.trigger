trigger Insertticres on TicketTypes__c (after insert) {
 
 system.debug('PPPPPPPPPPPPPPPPPPPPPPPpp ' );
  string eventId =trigger.new[0].EV_id__c;
 
  Event_Registration_jun__c erj =[SELECT id,Setting_Type__c,Event__c from Event_Registration_jun__c where Event__c=:eventId  limit 1];
  system.debug('RRRRRRRRRRRRRRRRRRRRR ' );
 
 
  List<TicketTypes__c> ttypes = new List<TicketTypes__c>();
     ttypes =[SELECT id,order__c from TicketTypes__c where EV_id__c=:eventId ];
      integer i =ttypes.size();
     system.debug('FFFFFFFFFFFFFFFFFFFFFFFFF '+ i);
   
 List<TicketTypes__c> ttypes1 = new List<TicketTypes__c>();
 List<Registration_Settings__c> resList = new List<Registration_Settings__c>();
  
 List<TicketTypes__c> ttypes2 = new List<TicketTypes__c>();
 ttypes2 = [SELECT id,order__c from TicketTypes__c where  Id IN: Trigger.newMap.keySet()];
    
        for(TicketTypes__c trE:ttypes2){
         if(erj.Setting_Type__c!='Collect information below for the ticket buyer only'){
          Registration_Settings__c ere = new Registration_Settings__c();
          ere.Event__c =erj.Event__c;
          ere.EventRegistration__c = erj.id;
          ere.TicketTypes__c =trE.id;
           resList.add(ere);
         }  
           system.debug('DDDDDDDDDDDD '+ trE.order__c);
           
                if(trE.order__c==null){
               // TicketTypes__c tt = new TicketTypes__c();
               // tt  = trE;
                 if(i!=0){
                 system.debug('FFFFFFFFFFFFFFFFFFFFFFFFF '+ i);
                   trE.order__c = i;
                    i++;                     
                  }else{
                   trE.order__c = 0;
                  }
                  ttypes1.add(trE); 
               }
           
      }
  // dataBase.update(ttypes1,false);
   try{
   dataBase.insert(resList,false);
   }catch(exception e){}
}
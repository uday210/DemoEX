trigger insertIndividualTickets on Dummay__c(after insert, After Update){
    
     LIST<Individual_Ticket_Info__c> ITIList = new LIST<Individual_Ticket_Info__c>();
     System.debug('Dummy record : '+ trigger.new);
    
     SET<ID> RegIds = new SET<ID>();
     SET<ID> TicketIds = new SET<ID>();
     
     for(Dummay__c reg: trigger.new){    
          RegIds.add(reg.id);
          TicketIds.add(reg.TicketTypes__r.Id);   
     }    
     
     MAP<String,LIST<Individual_Ticket_Info__c>> ITIMap = new MAP<String,LIST<Individual_Ticket_Info__c>>();
     for(Dummay__c dm: [SELECT ID,(SELECT ID FROM Individual_Ticket_Info__r) FROM Dummay__c WHERE Id IN: RegIds]){
         ITIMap.put(dm.id,dm.Individual_Ticket_Info__r);
     }

     MAP<String,LIST<Ticket_Session_Mapping__c>> TSessionMap = new MAP<String,LIST<Ticket_Session_Mapping__c>>();
     for(TicketTypes__c tt: [SELECT ID,(SELECT ID FROM Ticket_Session_Mapping__r) FROM TicketTypes__c WHERE Id IN: TicketIds]){
          TSessionMap.put(tt.id,tt.Ticket_Session_Mapping__r);
     }
     
     system.debug(ITIMap.size()+'  IND LIST MAP '+ITIMap);

     try{      
     
        for(Dummay__c reg: trigger.new){
            if(reg.Event_Attendee_Mapping__c != NULL){
                LIST<Individual_Ticket_Info__c> IndList= new LIST<Individual_Ticket_Info__c>();
                IndList = ITIMap.get(reg.Id);
                system.debug('  IND LIST '+IndList.size());
                if(IndList.size() == 0){
                    if(reg.Item__c == NULL && reg.TicketTypes__c != NULL){
                        system.debug(' One More Step');
                        LIST<String> seatNumbers= new LIST<String>();
                        
                        if(reg.Seat_Number__c != null){
                            if(reg.Seat_Number__c.contains(','))
                                seatNumbers= reg.Seat_Number__c.split(',');
                            else
                                seatNumbers.add(reg.Seat_Number__c);   
                        }
                        
                        LIST<Ticket_Session_Mapping__c> SessionNamesList= new LIST<Ticket_Session_Mapping__c>();
                        system.debug('Session Error '+TSessionMap.get(reg.TicketTypes__c));
                        if(TSessionMap.get(reg.TicketTypes__c) != NULL){
                             SessionNamesList = TSessionMap.get(reg.TicketTypes__c);                                    
                        }
                       

                        if(reg.Tickets_Quantty__c >=1){      
                            for(integer i=1; i<= reg.Tickets_Quantty__c; i++){
                                system.debug('Looping '+i);
                                if(SessionNamesList.size() > 0){
                                    for(Ticket_Session_Mapping__c sessionMap:SessionNamesList){
                                    
                                        Individual_Ticket_Info__c InTicketInfo = new Individual_Ticket_Info__c();                                    
                                        if(seatNumbers.size() >= i)
                                            InTicketInfo.Seat__c = seatNumbers[i-1]; 
                                            if(reg.Payment_Type__c == 'Free'){
                                                InTicketInfo.Amount__c = 0;
                                            }else{
                                                InTicketInfo.Amount__c = reg.IndividualAmount__c;
                                            }
                                            InTicketInfo.Refund_Amount__c= InTicketInfo.Amount__c;
                                            InTicketInfo.Registration_Info__c = reg.id;
                                            InTicketInfo.Ticket_Session_Mapping__c= sessionMap.Id;  
                                            InTicketInfo.Is_Input__c= sessionMap.Is_Input__c;
                                            InTicketInfo.Event_Attendee_Mapping__c= reg.Event_Attendee_Mapping__c;                                                                
                                            if(i==1){
                                                InTicketInfo.Is_Primary__c= TRUE;
                                            }        
                                            ITIList.add(InTicketInfo);
                                            system.debug('##### '+InTicketInfo);
                                            system.debug('&&&&& '+ITIList.size()); 
                                    }  
                                 }else{
                                     Individual_Ticket_Info__c InTicketInfo = new Individual_Ticket_Info__c();                                    
                                        if(seatNumbers.size() >= i)
                                            InTicketInfo.Seat__c = seatNumbers[i-1]; 
                                            if(reg.Payment_Type__c == 'Free'){
                                                InTicketInfo.Amount__c = 0;
                                            }else{
                                                InTicketInfo.Amount__c = reg.IndividualAmount__c;
                                            }
                                            InTicketInfo.Refund_Amount__c= InTicketInfo.Amount__c;
                                            InTicketInfo.Registration_Info__c = reg.id;
                                            //InTicketInfo.Ticket_Session_Mapping__c= sessionMap.Id;  
                                            InTicketInfo.Is_Input__c= TRUE;
                                            InTicketInfo.Event_Attendee_Mapping__c= reg.Event_Attendee_Mapping__c;                            
                                            if(i==1){
                                                InTicketInfo.Is_Primary__c= TRUE;
                                            }        
                                            ITIList.add(InTicketInfo);
                                            system.debug('##### '+InTicketInfo);
                                            system.debug('&&&&& '+ITIList.size()); 
                                 }                 
                            }      
                        }
                    }else if(reg.Item__c != NULL && reg.TicketTypes__c == NULL){
                        if(reg.Item_Quantity__c >=1){      
                            for(integer i=1; i<= reg.Item_Quantity__c; i++){
                                system.debug('Looping '+i);
                                Individual_Ticket_Info__c InTicketInfo = new Individual_Ticket_Info__c();                                    
                                InTicketInfo.Registration_Info__c = reg.id;   
                                InTicketInfo.IsItem__c = TRUE;    
                                if(reg.Payment_Type__c == 'Free'){
                                    InTicketInfo.Amount__c = 0;
                                }else{
                                    InTicketInfo.Amount__c = reg.IndividualAmount__c;
                                }
                                InTicketInfo.Refund_Amount__c= InTicketInfo.Amount__c;
                                InTicketInfo.Is_Input__c= TRUE;
                                InTicketInfo.Event_Attendee_Mapping__c= reg.Event_Attendee_Mapping__c;                            
                                ITIList.add(InTicketInfo);  
                            }
                        }
                    }
                    
                    }
                 }
            }
        system.debug('%%%%% '+ITIList);
        Database.Insert(ITIList,False);
        system.debug('Inserted size'+ITIList.size()); 
     }catch(Exception e){}

}
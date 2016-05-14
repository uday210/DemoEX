public without sharing class tickettemplatecon {

public Dummay__c dum{get;set;}
public LIST<Dummay__c> listdum{get;set;}
public Event__c event {get;set;}
public TicketTypes__c tkts{get;set;}
public string selectedEvent {get;set;}
public Event_Attendee_Mapping__c eam{get;set;}
public  List<EventSchedule__c> schedule {get;set;}

public tickettemplatecon()
{
}

public void values(){
    schedule = new list<EventSchedule__c> ();
    selectedEvent =Apexpages.currentPage().getparameters().get('id');
    try{
        dum = new  Dummay__c();
        dum = [SELECT Event__r.id, Event__r.EV_EventLogo__c,Event__r.EV_Title__c, Payment_Type__c,Event__r.EV_StartDate__c,Event__r.StartTime__c,Event__r.EV_EndDate__c,First_Name__c,Last_Name__c,Company__c,customer_key__r.Name,createdDate,DiscountValue__c,Credit_Card_Number__c,
                    Event__r.EV_EndTime__c,Event__r.EV_HostingTimeZone__c,Event__r.EV_HostingLocation__c,Event__r.EV_HostingCountryNew__c,Ticket_Amount__c,TicketAmount__c,Tickets_Quantty__c,Total_Amount__c,Payment_Status__c,Update_with_created_date__c,Individual_Amount_After_Discount__c,
                    Event__r.EV_HostingStateNew__c,Event__r.EV_HistingAddr1__c,Event__r.AS_HostingAddr2__c,Event__r.EV_HostingZipcode__c,Event__r.AS_HostingCity__c,Email__c,TicketTypes__r.TT_Name__c,payKey__c,Registered_Date__c
               FROM Dummay__c 
               WHERE id =:selectedEvent];
        
        system.debug('     haiiiiiiiiiiiiiiiiiiiiiiiiii '+selectedEvent );
        schedule = [select id,ES_ProgramName__c,ES_Description__c,ES_StartTime__c,ES_EndTime__c,ES_Location__c,ES_EndDate__c from EventSchedule__c where EV_id__r.id =: dum.Event__r.id]; 
        
        system.debug('     haiiiiiiiiiiiiiiiiiiiiiiiiii '+schedule );
        
        system.debug(' AAAAAAAAAAAAAAAAAAAAAA 000000000000 '+dum);  
        system.debug(' AAAAAAAAAAAAAAAAAAAAAA 111111111111'+dum.Email__c);  
        system.debug(' AAAAAAAAAAAAAAAAAAAAAA 222222222222'+dum.Event__c); 
        system.debug(' AAAAAAAAAAAAAAAAAAAAAA 3333333333 '+dum.Event__r.id); 
        
        AttendeeSummary__c attsum = new AttendeeSummary__c();
        
        attsum = [select id from AttendeeSummary__c where AS_Email__c=:dum.Email__c];
        
        eam =new Event_Attendee_Mapping__c();
        eam =[select id,Attendee_Event_IDs__c,EA_AttendeeBarcode__c,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c where (EV_id__c=:dum.Event__c) and  (AS_id__c =:attsum.id) limit 1];
        system.debug(' AAAAAAAAAAAAAAAAAAAAAA '+eam );     
        
        
        if(dum.Event__r.EV_HostingStateNew__c!=null){
            Commanforstates  con = new Commanforstates ();
            dum.Event__r.EV_HostingStateNew__c=  con.mapstate(dum.Event__r.EV_HostingStateNew__c);
        }
        
        
    }
    catch(exception e){}
     
    // try{
     
     
     
    //}catch(exception e){}

}

}
public without sharing class BL_CheckInsController {
    
    public String SelectedEventId{get;set;}
    public String SelectedCheckinType{get;set;}
    public LIST<SelectOption> CheckinTypes{get;set;}
    public LIST<Individual_Ticket_Info__c> Checkins{get;set;}
    public LIST<Individual_Ticket_Info__c> CheckinsCSV{get;set;}
    public LIST<Event_Attendee_Mapping__c> AttendeesCheckedIn{get;set;}
    public LIST<LIST<Individual_Ticket_Info__c>> ListofCheckins{get;set;}
    public Integer NoofAttendees{get;set;}
    public Integer NoofAttendeecheckins{get;set;}
    public Integer CheckedinAttendees{get;set;}
    public Integer NoOfcheckins{get;set;}
    
    public BL_CheckInsController(){
        SelectedEventId = ApexPages.currentpage().getParameters().get('id');
        if(SelectedEventId == NULL || SelectedEventId == ''){
            SelectedEventId ='a00F0000008FzGeIAK';
        }
        NoofAttendees = 0;
        NoOfcheckins = 0;
        NoofAttendeecheckins = 0;
        CheckedinAttendees = 0;
        AggregateResult [] Attendees = [SELECT COUNT(AS_id__c) 
                                        FROM Event_Attendee_Mapping__c 
                                        WHERE EV_id__c=:SelectedEventId ];
       
        for(AggregateResult ar: Attendees){
           NoofAttendees = Integer.valueOf(ar.get('expr0'));
        }
        
        AggregateResult [] AttendeeCheckIns =  [SELECT count(id)
                                                FROM Dummay__c
                                                WHERE Event__c=:selectedEventId 
                                                AND customer_key__r.Isinserted__c = true
                                                AND ChekIns_Total__c>=1 
                                                GROUP BY Event_Attendee_Mapping__r.AS_id__r.AS_Email__c];
        for(AggregateResult ar: AttendeeCheckIns){
           NoofAttendeecheckins = Integer.valueOf(ar.get('expr0'));
        }                                     
                                             
        AggregateResult [] CheckInsCount =  [SELECT SUM(ChekIns_Total__c) 
                                             FROM Dummay__c
                                             WHERE Event__c=:selectedEventId 
                                             AND customer_key__r.Isinserted__c = true];
        /**
        for(AggregateResult ar: CheckInsCount){
            if(Integer.valueOf(ar.get('expr0')) > 0)
                NoOfcheckins = Integer.valueOf(ar.get('expr0'));
            else
                NoOfcheckins = 0;
        }
        **/
        
        LIST<Individual_Ticket_Info__c> iti= [SELECT Id FROM Individual_Ticket_Info__c WHERE IsCheckedIn__c =: true AND Registration_Info__r.Event__r.id =: selectedEventId];
        system.debug('*** '+iti.size());
        
        NoOfcheckins = iti.size();
        
        AttendeesCheckedIn = new LIST<Event_Attendee_Mapping__c>();
        AttendeesCheckedIn = [SELECT Id,EV_id__c,MobileCheckInTime__c,(SELECT ChekIns_Total__c FROM Registration_Info__r WHERE Event__c=:SelectedEventId AND customer_key__r.Isinserted__c = true AND ChekIns_Total__c>=1) 
                              FROM Event_Attendee_Mapping__c 
                              WHERE EV_id__c=:SelectedEventId];
        CheckedinAttendees = AttendeesCheckedIn.size();
        system.debug('%%%%% '+CheckedinAttendees);
        
        CheckinTypes = new LIST<SelectOption>();
        SelectedCheckinType = 'true';
        //CheckinTypes.add(new SelectOption('All','All'));
        CheckinTypes.add(new SelectOption('true','CheckedIn'));
        CheckinTypes.add(new SelectOption('false','Not CheckedIn'));
        CheckinList();
    }
    
    private String sortDir = 'ASC';
    private String sortExp = 'Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c';
    
    public String sortField{
        get{
            return sortExp;
        }
        set{
            if (value == sortExp)
            sortDir = (sortDir == 'ASC')? 'DESC' : 'ASC';
            else
            sortDir = 'ASC';
            sortExp = value;
        }
    }
    
    public String getSortDir(){
        if (sortField == null || sortField == '')
            return 'ASC';
        else
            return SortDir;
    }
    
    public void setSortDir(String value){  
        SortDir = value;
    }
    public void toggleSort(){
        CheckinList();
    }
    
    public PageReference CheckinList(){
        
        system.debug('@@@111 '+SelectedCheckinType);
        Checkins = new LIST<Individual_Ticket_Info__c>();
        ListofCheckins = new LIST<LIST<Individual_Ticket_Info__c>>();
        string listQuery;
        
        listQuery ='SELECT id,IsCheckedIn__c,Scanned_by__c,Seat__c,Registration_Info__c,Registration_Info__r.Event_Attendee_Mapping__r.MobileCheckInTime__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_CellPhone__c,Registration_Info__r.TicketTypes__r.TT_Name__c FROM Individual_Ticket_Info__c WHERE IsCheckedIn__c = '+SelectedCheckinType +' AND Registration_Info__r.Event__r.id = \''+SelectedEventId+ '\'AND Registration_Info__r.TicketTypes__c != Null AND Registration_Info__r.customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST LIMIT 999';
        
        try{
            for(Individual_Ticket_Info__c a: dataBase.Query(listQuery)){   
                Checkins.add(a);
                
                if(Checkins.size() == 1000){
                    ListofCheckins.add(Checkins);
                    Checkins = new List<Individual_Ticket_Info__c>();
                }
            }
            ListofCheckins.add(Checkins);
        }
        catch(exception e){}
        return null;
    }
    
    public PageReference ExportCheckinList(){
        Checkins = new LIST<Individual_Ticket_Info__c>();
        CheckinsCSV = new LIST<Individual_Ticket_Info__c>();
        ListofCheckins = new LIST<LIST<Individual_Ticket_Info__c>>();
        string listQuery;

        listQuery ='SELECT id,IsCheckedIn__c,Scanned_by__c,Seat__c,Registration_Info__c,Registration_Info__r.Event_Attendee_Mapping__r.MobileCheckInTime__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Registration_Info__r.Event_Attendee_Mapping__r.MobileCheckInTime__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_CellPhone__c,Registration_Info__r.TicketTypes__r.TT_Name__c FROM Individual_Ticket_Info__c WHERE IsCheckedIn__c = '+SelectedCheckinType +' AND Registration_Info__r.Event__r.id = \''+SelectedEventId+ '\'AND Registration_Info__r.TicketTypes__c != Null AND Registration_Info__r.customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' LIMIT 999';

        try{
            LIST<Individual_Ticket_Info__c> bn = new LIST<Individual_Ticket_Info__c>();
            for(Individual_Ticket_Info__c s: dataBase.Query(listQuery)){  
                s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c = escape(s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);
                s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c = escape(s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);
                s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c = escape(s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c);
                s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_CellPhone__c = escape(s.Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_CellPhone__c); 
                s.Registration_Info__r.TicketTypes__r.TT_Name__c = escape(s.Registration_Info__r.TicketTypes__r.TT_Name__c); 
                bn.add(s);
            }
            CheckinsCSV.addAll(bn);
        }
        catch(exception e){}
        system.debug('###111 '+CheckinsCSV);

        PageReference pg = new PageReference('/apex/BL_CheckInsCSV');
        return pg;
    }
    
    public string escape(string s){
        if(s != null && s.contains(',')){  
            s=s.replaceAll(',','');
        } 
        return s;
    }
}
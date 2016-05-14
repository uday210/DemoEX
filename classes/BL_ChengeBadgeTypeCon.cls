public without sharing class BL_ChengeBadgeTypeCon {

public Event_Attendee_Mapping__c eams{get;set;}
public string eventId{get;set;}
public List<selectOption> options{get;set;} 
public List<innerCls> inns{get;set;}
public MAP<string,Event_Attendee_Mapping__c > mapIdwithEam{get;set;}

public BL_ChengeBadgeTypeCon(){
 eventId =Apexpages.CurrentPage().getPArameters().get('id');
 firstMethod();
    
}

 public void firstMethod(){
 options = new List<selectOption>();
 Event__c event;
 inns = new List<innerCls>();
 mapIdwithEam =new MAP<string,Event_Attendee_Mapping__c >();
 
 
  if(eventid!=null && eventid != ''){
    event =[select id,Attendee_Types__c from Event__c  where id=:eventId];
    options.add(new selectOption('None','None'));
    options.add(new selectOption('Sponsor -  All Access Pass','Sponsor - All Access Pass'));
    options.add(new selectOption('Sponsor   -   RLI','Sponsor  -   RLI'));
    options.add(new selectOption('Sponsor  -  Breakfast','Sponsor   -   Breakfast'));
    options.add(new selectOption('Sponsor  -   Lunch','Sponsor  -   Lunch'));
   for(string s: (event.Attendee_Types__c).split(';')){
    options.add(new selectOption(s,s));
    }
  
  }
 
 for(Event_Attendee_Mapping__c eams:[select Attendee_Types__c,EA_AttendeeBarcode__c,EV_id__r.EV_EventLogo__c,id,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_lastName__c,AS_id__r.AS_company__c from Event_Attendee_Mapping__c where EV_id__c=:eventId]){
      inns.add(new innerCls(eams,options)); 
      mapIdwithEam.put(eams.id,eams);
    }
    
 }


   public class innerCls{
        public Event_Attendee_Mapping__c eamInn {get;set;}
        public List<selectOption> optionsInn{get;set;}
        public string selectedType{get;set;}
        
        public innerCls(Event_Attendee_Mapping__c eamInn1,List<selectOption> optionsInn1){
        this.eamInn = eamInn1;
        this.optionsInn=optionsInn1;
    }
 }

  
  public string ticketType{get;set;}
  
      public pageReference insertValues(){
        for(innerCls invalue : inns){
          if(invalue.selectedType!='None'){
              eams =mapIdwithEam.get(invalue.eamInn.id);
              ticketType =invalue.selectedType;
               system.debug('AAAAAAAAAAAAAAAAAAAAA '+ticketType );
            /*  History_Of_Badge_print__c his = new History_Of_Badge_print__c();
              his.Badge_Priented_As__c =ticketType;
              his.Event_Attendee_Mapping__c =eams.id;
              insert his;*/
            }
       }
       pageReference pf = page.BL_ChengeBadgeType_print;
       return pf;
       
   }

}
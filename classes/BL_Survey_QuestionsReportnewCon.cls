public with sharing class BL_Survey_QuestionsReportnewCon {
  
  public List<Dummay__c> innclslist{get;set;}
  
 
   public integer  surin{get;set;}
   public List<Survey_Questions__c> surveyQuestions{get;set;}
   public List<TicketTypes__c> ticketsList{get;set;}
   public  string selectedEvent {get;set;}
   public List<SelectOption> selectQuan{get;set;}
   public string selectedRange {get;set;}   
   public integer  totalDummycount{get;set;}  
   public transient List<Dummay__c> tempList{get;set;}
   public integer limitList {get;set;}
   
     public BL_Survey_QuestionsReportnewCon(){
        selectedEvent = Apexpages.currentPage().getPArameters().get('id');
        List<Event__c> eventsList = new List<Event__c>();
        eventsList  = [select id,ReportRecords__c from EVent__C where id =:selectedEvent  ];
        
       tempList =new List<Dummay__c>();
       tempList =[select Name,id,Company__c,Email__c,First_Name__c,Last_Name__c, Phone__c,customer_key__r.Name, customer_key__r.isInserted__c,customer_key__c,(select id,Answers__c,AttendeeSummary__c,customer_key__c,Event__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.order__c,Survey_Questions__r.Question__c,  Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c,  Registration_Info__c from Surveys__r),Promocode__c,TicketTypes__c,TicketTypes__r.TT_Name__c from Dummay__c where Event__c=:selectedEvent and customer_key__r.isInserted__c=true];
       selectQuan = new List<SelectOption>();
       totalDummycount=0;
       totalDummycount= tempList.size();
       limitList = 300;
         if(eventsList.size()>0){
           if(eventsList[0].ReportRecords__c>0){
              limitList =  integer.valueOf(eventsList[0].ReportRecords__c);
           }
         }
       
       integer dva = Math.round(totalDummycount/limitList);
       Integer remainder2 = math.mod(totalDummycount, limitList);
        
            if(remainder2 >0){
               dva=dva+1;
              }
              
              
       integer min = 0;
        for(integer ty=0;ty < dva ;ty++ ){
            integer max = min+limitList ; 
            selectQuan.add(new SelectOption(string.valueOf(min+' TO '+max),string.valueOf(min+' TO '+max) ));
             min =  min+limitList ;
        }
       
         selectedRange = string.valueOf(0+' TO '+limitList);
          mainmethod();
     }
   
   
   
  public pageReference mainmethod(){
     surin =0;
     ticketsList = new List<TicketTypes__c>();
     SET<id> surid = new SET<id>(); // to hold survey Question ids 
    
     
     if(selectedEvent!=null && selectedEvent!=''){
      }else{
       return null;
     }
     
     
      ticketsList  = [select id,(select id,Survey_Questions__c from Ticket_Mapswith_Survey__r) from TicketTypes__c where EV_id__c=:selectedEvent ]; // Getting all Questions map with Tickets
       for(TicketTypes__c  tc : ticketsList){
          for(Ticket_Mapswith_Survey__c sur :tc.Ticket_Mapswith_Survey__r){
            surid.add(sur.Survey_Questions__c);
         }
       }
     
  
       string[] strlist = new string[]{};  
       integer strartValue = 0;
       
       strlist  = selectedRange.split(' TO ');
         strartValue = integer.valueOf(strlist[0]);
        integer maxvalue = integer.valueOf(strlist[1]);
      system.debug('MInimum Value '+strartValue+'   Max BValue '+maxvalue);
     innclslist = new List<Dummay__c>();
     innclslist = [select Name,id,Company__c,Email__c,First_Name__c,Last_Name__c, Phone__c,customer_key__r.Name, customer_key__r.isInserted__c,customer_key__c,(select id,Answers__c,AttendeeSummary__c,customer_key__c,Event__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.order__c,Survey_Questions__r.Question__c,  Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c,  Registration_Info__c from Surveys__r),Promocode__c,TicketTypes__c,TicketTypes__r.TT_Name__c from Dummay__c where Event__c=:selectedEvent and customer_key__r.isInserted__c=true   limit :limitList  offset :strartValue   ];
    
     
    
     
    /* innclslist = new List<Dummay__c>();
     integer minList = integer.valueOf(strlist[0]);
     integer maxList = integer.valueOf(strlist[1]);
     if(maxList > totalDummycount){
         maxList = totalDummycount;
     }
     
     for(integer r=minList  ; r< maxList ; r++){
        innclslist.add(tempList[r]); 
      }
   */ 
    
     for(Dummay__c du : innclslist ){
       for(Survey__c sur :du.Surveys__r){
         if(!surid.contains(sur.Survey_Questions__c)){ // to get Questions which are deleted from tickets after registration
           surid.add(sur.Survey_Questions__c);
          }  
        }
      }
    
  
    surveyQuestions = new List<Survey_Questions__c>();
    //surveyQuestions  = new List<>();
    surveyQuestions  = [select name,id,Agreed_Not__c,Options__c,order__c,Question__c,Type__c,Waivers__c from Survey_Questions__c where id in :surid]; 
   
     return null;  
  }
  
  public pagereference export(){
    pageReference pd = page.BL_Survey_QuestionsReportnewExport;
    return pd;
  }
  
  
   
}
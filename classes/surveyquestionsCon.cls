public with sharing class surveyquestionsCon {

    public decimal listsize { get; set; }
    public MAP<id,Ticket_Mapswith_Survey__c> mapleads { get; set; }
    public string upPhani{get;set;}
    public string SelectedEventId{get;set;}
    public List<inncls> inn{get;set;}
  public surveyquestionsCon(){
  SelectedEventId =ApexPages.currentPage().getParameters().get('id');
  firstCallMEthod();

} 
    
 public void firstCallMEthod(){
     inn = new List<inncls>();  
     List<Ticket_Mapswith_Survey__c> ticketesMapSurveys = new List<Ticket_Mapswith_Survey__c>();
     ticketesMapSurveys  = [SELECT id,Survey_Questions__c,IsRequired__c,Survey_Questions__r.Question__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c,order__c,TicketTypes__r.TT_NAme__c from Ticket_Mapswith_Survey__c where TicketTypes__r.EV_id__c=:SelectedEventId  order By order__c];
     
    // Assign value to map
     mapleads = new MAP<id,Ticket_Mapswith_Survey__c>();    
     for(Ticket_Mapswith_Survey__c assign:ticketesMapSurveys  ){
     
       if(assign.Survey_Questions__r.Options__c!=null & assign.Survey_Questions__r.Options__c!=''){ 
        if(assign.Survey_Questions__r.Options__c.contains('my#')){
        assign.Survey_Questions__r.Options__c = assign.Survey_Questions__r.Options__c.replaceAll('my#',',');
        }
       }
        mapleads.put(assign.id,assign); 
     }     
         
     for(TicketTypes__c TIC:[SELECT id,TT_Name__c,order__c from TicketTypes__c where EV_id__c=:SelectedEventId ]){
       List<Ticket_Mapswith_Survey__c> ticketsForthisEvent = new  List<Ticket_Mapswith_Survey__c>();
        for(Ticket_Mapswith_Survey__c TMS:ticketesMapSurveys ){
          if(TIC.id==TMS.TicketTypes__r.id){
            ticketsForthisEvent.add(TMS); 
          }
        }
        inn.add(new Inncls(TIC,ticketsForthisEvent));
        
     }
 }
 
 
 
  
   public PageReference down() {
     upPhani = Apexpages.currentPage().getParameters().get('upPhani');
     Ticket_Mapswith_Survey__c lp = new Ticket_Mapswith_Survey__c();
     lp = mapleads.get(upPhani); 
     
      integer u =integer.valueOf(lp.order__c);
      
       system.debug('444444444444444 '+u);
     
     List<Ticket_Mapswith_Survey__c > selectedTicSurveys = new List<Ticket_Mapswith_Survey__c >();
     selectedTicSurveys  =[select id,TicketTypes__c,Survey_Questions__c,Survey_Questions__r.Question__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c,order__c,TicketTypes__r.TT_NAme__c  from Ticket_Mapswith_Survey__c  where  TicketTypes__c=:lp.TicketTypes__c order by order__c];
    
     List<Ticket_Mapswith_Survey__c> updateLeads = new List<Ticket_Mapswith_Survey__c>();
     
        if(selectedTicSurveys.size()-1 > u){
                   
            integer v =0;
            v=u+1;
            system.debug('22222222222222222222 '+v);
            
            
           Ticket_Mapswith_Survey__c sec = new Ticket_Mapswith_Survey__c();
          
          sec =selectedTicSurveys[integer.valueOf(v)];
          sec.order__c=u;
          updateLeads.add(sec); 
          
          lp.order__c=v;
         updateLeads.add(lp);
        }
       dataBase.update(updateLeads,false);
     
     firstCallMEthod();
      return null;
    }




 public PageReference up() {
     upPhani = Apexpages.currentPage().getParameters().get('upPhani');
      system.debug('EEEEEEEEEEEEEEEEEe 11111111111111'+upPhani );
      Ticket_Mapswith_Survey__c lp = new Ticket_Mapswith_Survey__c();
    
      lp = mapleads.get(upPhani); 
    system.debug('EEEEEEEEEEEEEEEEEe 22222222222222'+lp);
    List<Ticket_Mapswith_Survey__c> updateLeads = new List<Ticket_Mapswith_Survey__c>();
    system.debug('EEEEEEEEEEEEEEEEEe 3333333333333'+lp.TicketTypes__c);
      List<Ticket_Mapswith_Survey__c > selectedTicSurveys = new List<Ticket_Mapswith_Survey__c >();
     selectedTicSurveys  =[select id,TicketTypes__c,Survey_Questions__c,Survey_Questions__r.Question__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c,order__c,TicketTypes__r.TT_NAme__c  from Ticket_Mapswith_Survey__c  where  TicketTypes__c=:lp.TicketTypes__c order by order__c];
    
    
    
    
    if(lp.order__c>=1){
      Ticket_Mapswith_Survey__c sec = new Ticket_Mapswith_Survey__c();
      sec =selectedTicSurveys[integer.valueOF(lp.order__c)-1]; 
      
      sec.order__c=lp.order__c;
       updateLeads.add(sec); 
       system.debug('1111111111111111111111111111111 '+sec);
      lp.order__c=lp.order__c-1;
      updateLeads.add(lp);
        system.debug('2222222222222222 '+lp);
       
    }
    dataBase.update(updateLeads,false);
    
     firstCallMEthod();
     return null;
    }


    public PageReference DeleteRec() {
     upPhani = Apexpages.currentPage().getParameters().get('upPhani');
     Ticket_Mapswith_Survey__c lp = new Ticket_Mapswith_Survey__c();
     lp = mapleads.get(upPhani); 
     List<Ticket_Mapswith_Survey__c> updateLeads = new List<Ticket_Mapswith_Survey__c>();
     
     List<Ticket_Mapswith_Survey__c > selectedTicSurveys = new List<Ticket_Mapswith_Survey__c >();
     selectedTicSurveys  =[select id,TicketTypes__c,Survey_Questions__c,Survey_Questions__r.Question__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c,order__c,TicketTypes__r.TT_NAme__c  from Ticket_Mapswith_Survey__c  where  TicketTypes__c=:lp.TicketTypes__c order by order__c];
    
     
    
     
    /* for(integer j=integer.valueOF(lp.order__c)+1;j<selectedTicSurveys.size();j++){
          system.debug('hhhhhhhhhhh '+j);
          Ticket_Mapswith_Survey__c sec = new Ticket_Mapswith_Survey__c();
          sec =selectedTicSurveys[j]; 
          sec.order__c=j-1;
          updateLeads.add(sec); 
      }
     */
     for(Ticket_Mapswith_Survey__c tice:selectedTicSurveys  ){
       system.debug('1111111111111111111111111111 '+ tice.order__c);
        system.debug('2222222222222222222222 '+lp.order__c);
        
        if(tice.order__c > lp.order__c && tice.order__c!=0){
           system.debug('33333333333333333333333 '+ tice.order__c);
            tice.order__c=tice.order__c-1;
             updateLeads.add(tice);
               system.debug('4444444444444444444444444 '+ tice.order__c);
        }
     
    
     }
     
     
     
        dataBase.update(updateLeads,false);
     
      dataBase.delete(lp,false);
    
    
    firstCallMEthod();
        return null;
    }

  public string status{get;set;}
 public class inncls{
      public TicketTypes__c  tictype{get;set;}
      public List<Ticket_Mapswith_Survey__c> ticketesMapSurveys {get;set;}
      public string status{get;set;}
      public inncls(TicketTypes__c  ttype,List<Ticket_Mapswith_Survey__c>  Sq){
       ticketesMapSurveys  = new List<Ticket_Mapswith_Survey__c>();
       this.tictype =ttype;
       this.ticketesMapSurveys  =sq;
       for(Ticket_Mapswith_Survey__c jun:ticketesMapSurveys){
       if(jun.IsRequired__c == true){
     this.status = 'Required';
     }else{
     this.status = 'Not Required';
     }
      }
      }
 
 } 
 //==========================================================================mythily=================
  public Survey_Questions__c Squestions {get; set; }
    public LIST<SelectOption> qtypes{get; set;}
    public string selectedtype {get;set;}
    
    public LIST<SelectOption> atttypes{get; set;}
    public String[] selectedatttype {get;set;}
    public integer i{get;set;}
    public list<SelectOption> tics {get;set;}
    
    public void typesfun(){
        tics = new list<SelectOption> {};
         atttypes = new LIST<SelectOption> {};
        try{
            Event__c event = [select Attendee_Types__c from Event__c where id =: SelectedEventId];
            List<TicketTypes__c> TickTypes = [select id,TT_Name__c,Ticket_Category__c from TicketTypes__c where EV_id__r.id =: SelectedEventId];
        for(TicketTypes__c tt: TickTypes ){
            tics.add(new SelectOption(tt.id,tt.TT_Name__c+'--'+tt.Ticket_Category__c));
        
        }
        if(event.Attendee_Types__c != null || event.Attendee_Types__c != ''){
            list<string> types = event.Attendee_Types__c.split(';');
                for(string type : types ){
        
                    atttypes.add(new SelectOption(type,type));
            }
        }}catch(exception e){}
            Squestions  = new Survey_Questions__c ();
            qtypes = new LIST<SelectOption> {};
            qtypes.add(new SelectOption('Text','Text') );
            qtypes.add(new SelectOption('CheckBox','CheckBox') );
            qtypes.add(new SelectOption('Radio Button','Radio Button') );
            qtypes.add(new SelectOption('PickList','PickList') );
    }
    public void surveyquestions(){
    heading ='';
    heading = 'Add your Question';
       selectedatttype = new string []{}; 
        k= new list<innerforoptions> {};
        i=0;
        k.add(new innerforoptions());
       typesfun();
        foredit=false;
      foradd= true;
        surveybool = true;
    
    }
    public list<innerforoptions> k{get;set;}
    public void add()
    {
        i++;
        for(integer j=i;j>i-1;j--){
        k.add(new innerforoptions());
        
    }
    }
    public void remove(){
     for(integer j=i;j>=i;j--){
    k.remove(j);
    }
    i--;
    
    
    
    }
    public boolean multiplechoiceoptions {get; set;}
    
    public void optionslabel(){
        if(selectedtype == 'CheckBox' || selectedtype == 'Radio Button' || selectedtype == 'PickList'){
        multiplechoiceoptions = true;

        }
    }
    public string opt {get;set;}
    public List<Ticket_Mapswith_Survey__c> TicSurvey{get;set;}
    public Ticket_Mapswith_Survey__c stic {get;set;}
    public void savequestions(){
   try{
        opt='';
         
     Squestions.Type__c = selectedtype;        
        for(innerforoptions inncl : k){
            opt+=inncl.ss+'my#';
        }
        opt=opt.removeend('my#');
        Squestions.Options__c = opt;
        insert Squestions;
        
       AggregateResult[]  forOrdercount   = [select TicketTypes__c, COUNT(Survey_Questions__c) from Ticket_Mapswith_Survey__c where TicketTypes__r.EV_id__c =: SelectedEventId GROUP BY TicketTypes__c ];
        system.debug('              count survey   '+forOrdercount   );
        
        TicSurvey = new List<Ticket_Mapswith_Survey__c> ();
        
        system.debug('      selectedatttype      '+selectedatttype);
        for(string idst: selectedatttype){
         stic =new Ticket_Mapswith_Survey__c();
            system.debug('         string id    '+idst);
            stic.TicketTypes__c = idst;
            stic.Survey_Questions__c = Squestions.id;
             stic.Order__c = 0;
            for(AggregateResult ag:forOrdercount  ){
            system.debug('WWWWWWWWWWWWWWWW '+ag.get('TicketTypes__c'));
              system.debug('DDDDDDDDDDDDDDDDDDDD '+idst );
            if(idst == ag.get('TicketTypes__c')){
             system.debug('WWWWWWWWWWWWWWWW ');
              system.debug('WWWWWWWWWWWWWWWW '+ag.get('expr0'));
              
             if(null != ag.get('expr0')){
               stic.Order__c = integer.valueOf(ag.get('expr0'));
               }else{
                 system.debug('EEEEEEEEEEEEEEEEEEEEEE ');
                stic.Order__c = 0;
               }      
             }
            }
            TicSurvey.add(stic);
        }
        database.insert(TicSurvey,false);
        
        
        multiplechoiceoptions = false;
        surveybool = false;
       firstCallMEthod();
       }catch(exception ex){}
    }
   
    public void saveandnewquestions(){
    savequestions();
    surveyquestions();
    
    }
    public boolean surveybool {get;set;}
    public boolean surveyQuestionsbool {get;set;}
   
  //-----------------------------------------------------EDIT SURVEY-----------
  public boolean foredit{get;set;}
  public boolean foradd{get;set;}
  public string heading {get;set;}
  public List<Ticket_Mapswith_Survey__c> TMTIC {get;set;}
  
  public void editSurvey(){
  try{
      Heading = '' ;
      selectedtype ='';
      opt='';
      Heading='Edit Your Question';
       k= new list<innerforoptions> {};
        i=0;
        
      foredit=true;
      foradd= false;
      typesfun();
      Squestions  = new Survey_Questions__c();
      selectedatttype = new string[]{};
      system.debug('         edit survey          ');
      id chid = ApexPages.currentPage().getParameters().get('mycheck');
      system.debug('       id val       '+chid);
      Ticket_Mapswith_Survey__c TMSQ =[select Survey_Questions__c,Survey_Questions__r.Question__c,Survey_Questions__r.Type__c,Survey_Questions__r.Options__c,
                                            TicketTypes__r.id,TicketTypes__r.TT_Name__c from Ticket_Mapswith_Survey__c where id =: chid ];
  
       TMTIC = [select TicketTypes__r.id,TicketTypes__r.TT_Name__c from Ticket_Mapswith_Survey__c where Survey_Questions__r.id =: TMSQ.Survey_Questions__c ];
  
      Squestions = [select Question__c,Type__c,Options__c from  Survey_Questions__c where id =: TMSQ.Survey_Questions__c ];
      
       if(Squestions.Type__c != 'Text'){
        if(Squestions.Type__c =='Radio button'){
             Squestions.Type__c ='Radio Button';
             system.debug('              type      2222222222    '+Squestions.Type__c);
        }
        
      selectedtype =Squestions.Type__c;
      system.debug('              type          '+Squestions.Type__c);
     
      multiplechoiceoptions = true;
      }
      for(Ticket_Mapswith_Survey__c tim: TMTIC ){
          selectedatttype.add(tim.TicketTypes__r.id);
      }
      list<string> optlist = new  list<string>();
      if(Squestions.Options__c!=null & Squestions.Options__c!=''){
           
      optlist = Squestions.Options__c.split('my#');
      }
        
      for(string st: optlist ){
      k.add(new innerforoptions(st));
      
      }
      surveybool = true;
      }catch(exception ex){}
  }
  //----------------------------------------------------------UPDATE SURVEY------------
  public void updatesurvey(){
  try{
  delete TMTIC ;
   opt='';
        
        Squestions.Type__c = selectedtype;        
        for(innerforoptions inncl : k){
            opt+=inncl.ss+'my#';
        }
        opt=opt.removeend('my#');
        Squestions.Options__c = opt;
        
  update Squestions ;
  TicSurvey = new List<Ticket_Mapswith_Survey__c> ();
        
        system.debug('      selectedatttype      '+selectedatttype);
        for(string idst: selectedatttype){
         stic =new Ticket_Mapswith_Survey__c();
            system.debug('         string id    '+idst);
            stic.TicketTypes__c = idst;
            stic.Survey_Questions__c = Squestions.id;
            TicSurvey.add(stic);
        }
        database.insert(TicSurvey,false);
        surveybool = false;
        }catch(exception e){}
        firstCallMEthod();
  }
  
  //-------------------------------------------------------------------
    public class innerforoptions{
        public string ss{get;set;}
        public innerforoptions(){
        
        }
        public innerforoptions(string ss){
        this.ss=ss;
        }
    }
//---------------------------------------Cancel--------------------
    public void Cancel() {
    surveybool = false;
   
  
    }
    
//-------------------------------------change status in tickets maps with survey-------------------
    public id tmsid {get;set;}
    public void changestatus(){
     system.debug('--------------------------id----------------------'+ApexPages.currentPage().getParameters().get('tmjun'));
     tmsid = ApexPages.currentPage().getParameters().get('tmjun');
    system.debug('--------------------------id----------------------'+tmsid);
     Ticket_Mapswith_Survey__c tsmap  = new Ticket_Mapswith_Survey__c ();
    tsmap = [select id , IsRequired__c from Ticket_Mapswith_Survey__c where id =: tmsid];
   system.debug('------------------------------------------------------'+tsmap.IsRequired__c);
    if(tsmap.IsRequired__c == true){
    system.debug(' 000000000000000000000000000000000');
    tsmap.IsRequired__c = false;
     system.debug('----------------------1111111111111111--------------------------------'+tsmap.IsRequired__c);
    }else{
    if(tsmap.IsRequired__c == false){
    tsmap.IsRequired__c = true;
    }
    }
    update tsmap;
    firstCallMEthod();
    }
}
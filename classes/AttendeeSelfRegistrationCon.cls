public with sharing class AttendeeSelfRegistrationCon {


// DIversity Type
public pagereference eventinfo(){
     return null;
}
public pagereference eventschedule(){
     return null;
}




 
    public list<Selectoption> options{get;set;}
   public decimal naics1{get;set;}
      public decimal naics2{get;set;}
        public decimal naics3{get;set;}
          public decimal naics4{get;set;}
            public decimal naics5{get;set;}
    
    public Boolean welcomeNote{get;set;}
   
    public String FirstName{get;set;}  
    
    public String Lastname{get;set;}
    
    public boolean eventInfo{get;set;}
    
    public boolean eventSchedule{get;set;}
    
    Public string selectedvaluesfordiversity{get;set;}

 public String[] selectedTicTypes{get;set;}
 public AttendeeSummary__c AtSummary{get;set;}
 
 public boolean out_variable{get;set;}
 
 public id  attid = apexpages.currentpage().getParameters().get('id');
 
 public id Eventid = apexpages.currentpage().getParameters().get('eid');
 
  public LIST<EventSchedule__c> eventscheduleDB{get; set;}
   public String[] DiversityTypes{get;set;}
   public String[] DiversityTypesforfirstLine{get;set;}
   public String[] DiversityTypesforsecondLine{get;set;}
   public List<Selectoption> Divoptions {get;set;}
   public List<Selectoption> Divoptionsforsecondline {get;set;}
   public Event__c eventInformation{get;set;}
   public Event__c evdiv{get;set;}
   public Event_Attendee_Mapping__c eam{get;set;}
  
    
    
    
    public AttendeeSelfRegistrationCon() {
    
    Divoptions=new list<Selectoption>{};
    Divoptionsforsecondline=new list<Selectoption>{};
    eam = new Event_Attendee_Mapping__c();
     AtSummary = new AttendeeSummary__c();
     system.debug('3333333333333 '+AtSummary );
     
     
   AtSummary  = new AttendeeSummary__c();
     AtSummary  =[Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,Keywords__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode5__c, a.AS_NAICSCode4__c, a.AS_NAICSCode3__c, 
                  a.AS_NAICSCode2__c, a.AS_NAICSCode1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, 
                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,Exhibitor_company_imageUrl__c,Registration_type__c From AttendeeSummary__c a where id=:attid ];
     
   
     
     
    FirstName = AtSummary.AS_FirstName__c;
    Lastname= AtSummary.AS_LastName__c;
    system.debug('==================event id==================='+eventid);
    evdiv =[select EventDiversityValues__c from Event__c where id =: Eventid ];
     system.debug('==================event id==================='+evdiv.EventDiversityValues__c);
    String Div=evdiv.EventDiversityValues__c;
       string[] DiversityTypes1=Div.split(';');
       integer i=0;
         for(String Diversty : DiversityTypes1 ){
         if(math.MOD(i,2)==0){
        Divoptions.add(new SelectOption(Diversty ,Diversty ));
        }else{
         Divoptionsforsecondline.add(new SelectOption(Diversty ,Diversty ));
        }      
    i++;
    }try{
     eam=[select id,DiversityType__c,TicketTypes__c,Attendee_Types__c from Event_Attendee_Mapping__c where AS_id__c=:attid  AND EV_id__c =:Eventid];
     if(eam.Attendee_Types__c != null)
         eam.Attendee_Types__c=eam.Attendee_Types__c.removeend(',');
            
     system.debug('===========11111=============='+eam.DiversityType__c);
     DiversityTypesforfirstline=new string[]{};
     DiversityTypesforsecondline=new string[]{};
     if(eam.DiversityType__c != null){
      system.debug('===========2222222=============='+eam.DiversityType__c);
    string diversity=eam.DiversityType__c;
    list<string> seldivs=diversity.split(';');
   system.debug('===========33333333=============='+seldivs);
    for(string dd:seldivs){
    
    DiversityTypesforfirstline.add(dd);
    system.debug('===========4444444444=============='+DiversityTypesforfirstline);
    DiversityTypesforsecondline.add(dd);
    system.debug('===========4444444444=============='+DiversityTypesforsecondline);
    }
    }
    options = new List<SelectOption>();
      string tickets=eam.TicketTypes__c;
        list<string> seldtics=tickets.split(',');
        for(string Tic:seldtics){
        options.add(new SelectOption(Tic,Tic));
        }
     string  TTT='';
             TTT=eam.TicketTypes__c;
    list<string> regticket=TTT.split(',');
    selectedTicTypes=new String[]{};
    for(string reg:regticket){
    selectedTicTypes.add(reg);
    }
    }catch(exception e){}
 eventInformation = [Select id,EV_Description__c,EV_EndDate__c,EV_EndTime__c,EV_EventLogo__c,EV_HistingAddr1__c,EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountry__c,
                        EV_HostingFax__c,EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingState__c,EV_HostingTimeZone__c,
                       EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,EV_Title__c, EV_WebsiteURL__c from  Event__c where id =:Eventid];
    
    
    
    welcomeNote = true;
    
    out_variable = false;
    
    eventInfo = false;
   
    eventSchedule = false;
    
    
    System.debug('@@@@@AtSummary'+AtSummary );
    
   eventscheduleDB =[SELECT ES_StartDate__c,ES_StartTime__c,id,ES_Description__c, ES_EndTime__c, ES_Location__c, ES_Presenter__c,ES_ProgramName__c FROM EventSchedule__c WHERE EV_id__c =: Eventid ORDER BY ES_StartTime__c,ES_StartDate__c ];
    
    
     System.debug('@@@@@eventscheduleDB'+eventscheduleDB);
    naics1 =AtSummary.AS_NAICSCode1__c;
     naics2 =AtSummary.AS_NAICSCode2__c;
      naics3 =AtSummary.AS_NAICSCode3__c;
       naics4 =AtSummary.AS_NAICSCode4__c;
        naics5 =AtSummary.AS_NAICSCode5__c;

    }

   
  public pagereference submit(){
   AtSummary.AS_NAICSCode1__c=naics1 ;
     AtSummary.AS_NAICSCode2__c=naics2;
     AtSummary.AS_NAICSCode3__c=naics3;
     AtSummary.AS_NAICSCode4__c=naics4;
     AtSummary.AS_NAICSCode5__c=naics5;
  
  update AtSummary;
  
  eam .DiversityType__c='';
           if(DiversityTypesforfirstline.size() != 0){
           for(string dtypes:DiversityTypesforfirstline){
           eam.DiversityType__c+=dtypes+';';
           }
           }
           if(DiversityTypesforsecondline.size() != 0){
           for(string dtypes:DiversityTypesforsecondline){
           eam.DiversityType__c+=dtypes+';';
           }
           }
            update eam ;
     try {
     update AtSummary;
     }catch(exception e){}
    
    out_variable = true;
    
    
  return null;
  
  }


public pagereference cancel(){


 out_variable = false;

//pagereference pf = new pagereference('http://www.boothleads.force.com');

//pf.setRedirect(true);

return null;


}


public pagereference Check(){


pagereference pf = new pagereference('https://c.na10.visual.force.com/apex/AttendeeSelfRegistration?id='+attid);

pf.setRedirect(true);

return pf;




return null;
}


public pagereference eventDetails(){

eventInfo = true; 

return null;

}


public pagereference EventClose(){

 eventInfo = false; 

return null;

}


public pagereference eventscheduleDetails(){

eventSchedule  = true;

return null;

}


public pagereference EventClose2(){

 eventSchedule = false; 

return null;

}

public pagereference UpdateProfile(){

welcomeNote = false;
return null;

}

// sates and Countries

public string SelectedCountry{get;set;}

public String SelectedState{get;set;}




public string SelectedCountry1{get;set;}

public String SelectedState1{get;set;}




public string SelectedCountry2{get;set;}

public String SelectedState2{get;set;}



     
     
}
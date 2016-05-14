public without sharing class BL_Registration_SettingsCon {

    public PageReference saveSession() {
    update event;
     EnableScanFeature();
        return null;
    }


     public String SelectedRegSetting{get;set;}
     public List<Registration_Settings__c> resSettings{get;set;}
     public List<inncls> Inn{get;set;}
     public List<inncls> Inn2{get;set;}
     public string firstAssign{get;set;}
     public string eventId{get;set;}
     public Event_Registration_jun__c ERJ {get;set;}
     public Event__c event{get;set;}
     
     
     
      public BL_Registration_SettingsCon(){
     //  SelectedRegSetting ='Collect information below for each attendee';
       eventId =Apexpages.CurrentPage().getParameters().get('Id');
      
         firstMethod();
        EnableScanFeature();
      }
      
      
      public void EnableScanFeature(){
       event = new Event__c();
       event =[SELECT id,Enable_Scan_To_ATT__c,Type_Of_registration_allow__c,Enable_Scan_To_BA__c,Session_Time__c,Registration_Front_End_Color__c,Registration_Back_End_Color__c from Event__c where Id =:eventId ];      
       
      }
      
      
      
      
      public void firstMethod(){
      ERJ = new Event_Registration_jun__c();
        ERJ = [Select Setting_Type__c,Event__c From Event_Registration_jun__c where Event__r.id=:eventId limit 1];
       SelectedRegSetting = ERJ.Setting_Type__c;
        
        firstAssign = ERJ.Setting_Type__c;
        Inn = new List<inncls>();
        Inn2 = new List<inncls>();             
        
        resSettings = new List<Registration_Settings__c>();
        resSettings =  [SELECT TicketTypes__r.TT_Name__c,Is_Company_Include__c,Is_Company_required__c,Is_Designation_Include__c,Is_Designation_required__c,Is_Email_Include_c__c,
                      Is_Email_Required_c__c,Is_FirstName_Include__c,Is_FirstName_Required__c,Is_Homeaddress_Include__c,Is_Homeaddress_required__c,
                      Is_LastName_include__c,Is_LastName_Required__c,Is_Mobile_Include__c,Is_Mobile_required__c,Is_Shipadd_Include__c,Is_Shipadd_required__c,
                      Is_Workaddress_Include__c,Is_Workaddress_required__c,Is_WorkPhone_Include__c,Is_workphone_required__c,LastActivityDate,LastModifiedById,
                      Is_Wesite_include__c,Is_Wesite_Required__c,Name,TicketTypes__c,TicketTypes__r.Ticket_Category__c,Is_NAICS_Include__c,Is_NAICS_Required__c,
                      Is_Company_Description_Include__c,Is_Company_Description_Required__c, Is_Keywords_Required__c,Is_Keywords_Include__c
                        FROM Registration_Settings__c where EventRegistration__r.Event__r.id=:eventId];
       
        MAP<id,TicketTypes__c> mapsvales = new MAP<id,TicketTypes__c>([SELECT id,TT_Name__c,Ticket_Category__c from TicketTypes__c where EV_id__c=:eventId ]);
        
        
        SET<string> catGory = new Set<string>();
        
            for(Registration_Settings__c resIterate:resSettings ){
              catGory.add(resIterate.TicketTypes__r.Ticket_Category__c);
              Inn.add(new inncls(resIterate,mapsvales.get(resIterate.TicketTypes__c)));
        }
        
      
      OuterInn = new List<innForDisplayType>();
      
      if(firstAssign !='Collect information below for the ticket buyer only'){
       for(string tc:catGory){
       List<inncls> OuterInnLocal = new  List<inncls>();
        for(inncls inv:Inn){
           if(tc==inv.resInn.TicketTypes__r.Ticket_Category__c){
                  OuterInnLocal.add(inv);    
           
           }
        }
        OuterInn.add(new innForDisplayType( tc,OuterInnLocal)) ;
     }
      
    }else{
      OuterInn.add(new innForDisplayType( '',Inn)) ;
     }
   
     Inn2.addAll(Inn);
   }  
      
      public List<innForDisplayType> OuterInn{get;set;}
      public class innForDisplayType{
       public List<inncls> innvalues {get;set;}
       public string TicketCategoryvalue{get;set;}
       
       public innForDisplayType(string h,List<inncls> inINN){
         innvalues = new List<inncls>();
         innvalues=inINN;
         TicketCategoryvalue = h;
       }
      
      }
      
      
      
      
      
      public Void OnchnageAction(){
        /* resSettings = new List<Registration_Settings__c>();
              resSettings =[SELECT Is_Company_Include__c,Is_Company_required__c,Is_Designation_Include__c,Is_Designation_required__c,Is_Email_Include_c__c,
                      Is_Email_Required_c__c,Is_FirstName_Include__c,Is_FirstName_Required__c,Is_Homeaddress_Include__c,Is_Homeaddress_required__c,
                      Is_LastName_include__c,Is_LastName_Required__c,Is_Mobile_Include__c,Is_Mobile_required__c,Is_Shipadd_Include__c,Is_Shipadd_required__c,
                      Is_Workaddress_Include__c,Is_Workaddress_required__c,Is_WorkPhone_Include__c,Is_workphone_required__c,LastActivityDate,LastModifiedById,
                      LastModifiedDate,LastReferencedDate,LastViewedDate,Name,SystemModstamp,TicketTypes__c FROM Registration_Settings__c where EventRegistration__r.Event__r.id=:Apexpages.CurrentPage().getParameters().get('Id')];
          */
          
          if(SelectedRegSetting == firstAssign ){
            Inn = new List<inncls>();
            inn.addAll(Inn2);
            OuterInn = new List<innForDisplayType>();
            OuterInn.add(new innForDisplayType('',Inn));
          }else{
              OuterInn = new List<innForDisplayType>();
              Inn = new List<inncls>();
             if(SelectedRegSetting == 'Collect information below for the ticket buyer only'){
               Registration_Settings__c Prset = new Registration_Settings__c();
               
               Prset.Is_FirstName_Include__c=TRUE;
               Prset.Is_FirstName_Required__c=TRUE;
               Prset.Is_LastName_include__c=TRUE;
               Prset.Is_LastName_Required__c=TRUE;
               prset.Is_Email_Include_c__c=TRUE;
               Prset.Is_Email_Required_c__c=TRUE;
               Inn.add(new inncls(Prset ,''));
               OuterInn.add(new innForDisplayType('',Inn));
               
             }else{
             Inn = new List<inncls>();
              OuterInn = new List<innForDisplayType>();
               for(TicketTypes__c ticgr:[SELECT id,TT_Name__c from TicketTypes__c where EV_id__c=:eventId ]){
                  Registration_Settings__c Prset = new Registration_Settings__c();
                   Prset.Is_FirstName_Include__c=TRUE;
               Prset.Is_FirstName_Required__c=TRUE;
               Prset.Is_LastName_include__c=TRUE;
               Prset.Is_LastName_Required__c=TRUE;
               prset.Is_Email_Include_c__c=TRUE;
               Prset.Is_Email_Required_c__c=TRUE;
                 Inn.add(new inncls(Prset ,ticgr));
             
             
             }
              OuterInn.add(new innForDisplayType('',Inn));
            }
         }
      } 
              
              
              
      
      public class inncls{
       public Registration_Settings__c resInn{get;set;}
       public TicketTypes__c tic {get;set;}
       public string Nameinn{get;set;}
            public inncls(Registration_Settings__c resInnCon,TicketTypes__c ticcon ){
              resInn = new Registration_Settings__c();
              tic =new TicketTypes__c();
              this.resInn=resInnCon;
               this.tic   =ticcon ;
            }
            
             public inncls(Registration_Settings__c resInnCon,string ss ){
                  this.resInn=resInnCon;
                  this.Nameinn=ss;
            }
            
      
      }
      
      
      
   public void Save(){
   List<Registration_Settings__c> forInsert = new List<Registration_Settings__c>();
   
    if(SelectedRegSetting == firstAssign ){
       
       for(innForDisplayType Ingf : OuterInn){ 
        for(inncls inc:ingf.innvalues){
           forInsert.add(inc.resInn); 
        }
       } 
    dataBase.update(forInsert,false);
     firstMethod();
    }else{
      dataBase.delete(resSettings,false);
       ERJ.Setting_Type__c =SelectedRegSetting ;
       dataBase.update(ERJ);
    
    
      for(innForDisplayType Ingf : OuterInn){ 
        for(inncls inc:ingf.innvalues){
       try{
        inc.resInn.TicketTypes__c=inc.tic.id;
        }catch(exception ev){}
        inc.resInn.EventRegistration__c = ERJ.id;
         forInsert.add(inc.resInn); 
        }
      }  
       dataBase.insert(forInsert,false);
        firstMethod();
     }
  }  
  
  public void saveScan(){
  update event;
    EnableScanFeature();
  }
  
   
   public void savecolors()
   {
    update event;
   }
   
 }
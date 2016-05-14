public without sharing class BL_surveyReportcon {
 
 public String selectedEvent{get;set;} 
 public List<MbeDetails> mbeReport{get;set;}
 public String mbeList{get;set;}
 public String corpList{get;set;}
 public string eventId;
  public List<MbeDetails> MbeListReport{get;set;}
  public List<MbeDetails> corpListreport{get;set;}
  public string attendeealias{get;set;}
  public string exhibitoralias{get;set;}
   public Event__c eventDetails{get; set;}
   public list<Tags__c> tagslist {get; set ;}
   public BL_surveyReportCon(){
       //List<Answer__c>  us = new List<Answer__c>();
       attendeealias ='';
      exhibitoralias ='';
  Cookie k = ApexPages.currentPage().getCookies().get('counter');
            try{ 
             eventId  = k.getValue();
           }catch(exception es ){
             eventId = ApexPages.currentPage().getParameters().get('id');
           }
           
           tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventId ];
           for(Tags__c tt: tagslist ){
               if(tt.Default_Name__c == 'Attendee'){
                  attendeealias = tt.Alias_Name__c;
               }else if(tt.Default_Name__c == 'Exhibitor'){
                  exhibitoralias = tt.Alias_Name__c;
               }
          }
          
           eventDetails=[select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, AS_HostingAddr2__c,
                          EV_StartDate__c, EV_EndDate__c,EV_HostingStateNew__c, EV_HostingState__c,Is_Webank_event__c from Event__c WHERE ID =: eventId ];
       selectedEvent=eventId ;
        for(User_Profile_Event__c upe :[select id,MAtchMakingProfile__c,User_id__r.username,EV_id__c,Attendee_Summary__r.FullName__c,Attendee_Summary__r.AS_Email__c from User_Profile_Event__c where EV_id__c =:selectedEvent]){
             if(upe.MAtchMakingProfile__c=='Corporate'){
                
                corpList+=upe.User_id__r.username.tolowercase();
            }else{
                mbeList+=upe.User_id__r.username.tolowercase();  
            }
        }
       //us = [SELECT id, Ans__c,Ans_By__c,Option__c, Question__c,Surveyor__c from Answer__c where Question__r.Events__c=:selectedEvent ];
       mbeReport = new List<MbeDetails>();
       MbeListReport = new List<MbeDetails>();
       corpListreport = new List<MbeDetails>();
       
       SET<String> mbeEmails = new SET<String>(); 
       MAP<string,LIST<Answer__c>> mapMbeWithans =  new MAP<string,LIST<Answer__c>>();
       for(Answer__c ans : [SELECT LastModifiedDate,Ans_By__r.As_id__r.AS_FirstName__c,Ans_By__r.As_id__r.AS_LastName__c, Option__r.Name,id, Ans__c,Ans_By__c,Ans_By__r.As_id__r.AS_Email__c,Option__c, Question__c, Question__r.Name,Question__r.Type__c,Surveyor__c,Surveyor__r.As_id__r.AS_Email__c,Question__r.Events__r.EV_HostingTimeZone__c from Answer__c where Question__r.Events__c=:selectedEvent and Surveyor__c!=null and Ans_By__c!=null]){
         LIST<Answer__c> ansList = new List<Answer__c>();
          if(mbeEmails.contains(ans.Ans_By__r.As_id__r.AS_Email__c.tolowercase())){
             if(null !=  mapMbeWithans.get(ans.Ans_By__r.As_id__r.AS_Email__c)){
                ansList = mapMbeWithans.get(ans.Ans_By__r.As_id__r.AS_Email__c);
                ansList.add(ans);
                mbeEmails.add(ans.Surveyor__r.As_id__r.AS_Email__c);
             }
           }else{
              ansList.add(ans);
              mbeEmails.add(ans.Ans_By__r.As_id__r.AS_Email__c.tolowercase());
              mbeEmails.add(ans.Surveyor__r.As_id__r.AS_Email__c);
           }
            mapMbeWithans.put(ans.Ans_By__r.As_id__r.AS_Email__c.tolowercase(),ansList);
        }
         
        MAP<String,Event_Attendee_Mapping__c> mapEmailWithEam = new MAP<String,Event_Attendee_Mapping__c>();
        for(Event_Attendee_Mapping__c eam : [Select As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,id,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c from Event_Attendee_Mapping__c  where AS_Id__r.AS_Email__c in :mbeEmails]){
             mapEmailWithEam.put(eam.AS_id__r.AS_Email__c,eam);
        } 
         
         
       for(String mbeEmail : mapMbeWithans.keySet()){
          SET<String> corpoEms = new SET<String>();
          MAP<String,List<Answer__c>> copEmailWithAns = new MAP<String,List<Answer__c>>();
          
          
            for(Answer__c anForCorporates :mapMbeWithans.get(mbeEmail)){
             LIST<Answer__c> ansListCorp = new List<Answer__c>();
              if(corpoEms.contains(anForCorporates.Surveyor__r.As_id__r.AS_Email__c)){
                  ansListCorp= copEmailWithAns.get(anForCorporates.Surveyor__r.As_id__r.AS_Email__c);
                  ansListCorp.add(anForCorporates); 
              }else{
                 ansListCorp.add(anForCorporates); 
                 corpoEms.add(anForCorporates.Surveyor__r.As_id__r.AS_Email__c);
             }
             copEmailWithAns.put(anForCorporates.Surveyor__r.As_id__r.AS_Email__c,ansListCorp); 
             System.debug('PPPPPPPPPPPPPPPP '+anForCorporates.Surveyor__r.As_id__r.AS_Email__c+'BBBBBBBBB  '+ansListCorp.size()); 
          }
           mbeReport.add(new MbeDetails(mapEmailWithEam.get(mbeEmail), copEmailWithAns,mapEmailWithEam)); 
       }
       
       for( MbeDetails emdtILA :mbeReport){
          if(mbeList.contains(emdtILA.mbeProfile.As_id__r.AS_Email__c)){
              MbeListReport.add(emdtILA);
 
          }else{
            corpListreport.add(emdtILA);
          }
       }
       
   }
   
    public class MbeDetails{
       public Event_Attendee_Mapping__c mbeProfile{get;set;}  
       public List<CorpDetails> ansListMbe{get;set;}
         public MbeDetails(Event_Attendee_Mapping__c mbeEam ,MAP<String,List<Answer__c>> CorpInfo,MAP<String,Event_Attendee_Mapping__c> mapEmailWithEam){
             mbeProfile = new Event_Attendee_Mapping__c();
             ansListMbe = new  List<CorpDetails>(); 
             if(mbeEam != null){
                mbeProfile = mbeEam;
             }
             if(null != CorpInfo ){
                for(String cp :CorpInfo.keySet()){
                   ansListMbe.add(new CorpDetails(mapEmailWithEam.get(cp),CorpInfo.get(cp)));
                }
             }  
              
         }
    }
    
    public class CorpDetails{
       public Event_Attendee_Mapping__c corpProfile{get;set;}  
       public List<Answer__c> ansListCorp{get;set;}
          public CorpDetails( Event_Attendee_Mapping__c corpInn, List<Answer__c> ansinn){
             corpProfile= new Event_Attendee_Mapping__c();
             ansListCorp = new List<Answer__c>();
              corpProfile=corpInn;
              ansListCorp =  ansinn;
         }
       
    }
    
    
 }
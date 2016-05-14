@RestResource(urlMapping='/SurveyQue/*')
/*
 * AUTHOR: Phani     
 * Email : phani@globalnest.com
  */

  global with sharing class SurveyQue{
  @HttpPost
   global static QuestionsInn doGet(){
       RestRequest req = RestContext.request;
       
        String eveid = req.params.get('EventId');
        String loginuserEmail = req.params.get('LoginId');
        String answeredUserEmail = req.params.get('SelectedId');

       QuestionsInn qInn = new QuestionsInn();
       qInn.questions = new List<MMQuestion__c>();
       qInn.optWithQuestions= new List<Qaj__c>();
       qInn.anwers= new List<Answer__c>();
       String userProfile ='';
        for(User_Profile_Event__c upe : [SELECT id,MAtchMakingProfile__c From User_Profile_Event__c where User_id__r.userName=:loginuserEmail and EV_id__c=:eveId and IsMatchMakingUser__c=true]){
              userProfile = upe.MAtchMakingProfile__c;
        }    
    system.debug('yyyyyy'+userProfile);
          if(userProfile!=''){
              // qInn.questions = [select id,Name,Order_No__c,Whom__c,Type__c,(select id,Name from Options__r),IsInclude__c,IsRequired__c from MMQuestion__c where Events__c=:eveId and Whom__c=:userProfile];
              qInn.questions = [select IsConditional__c,id,Name,Order_No__c,Whom__c,Type__c,(select id,Name,order__c from Options__r),IsInclude__c,IsRequired__c from MMQuestion__c where Events__c=:eveId and (Whom__c=:userProfile OR (Whom__c=:userProfile AND IsConditional__c=true) OR Whom__c='All')];
               List<id> qIds = new List<id>();  
                for(MMQuestion__c Qc :qInn.questions){
                    qIds.add(Qc.Id);
                }
               qInn.optWithQuestions=[select id,Name,Option__c,Question__c,Option__r.Question__c from Qaj__c where Question__r.id In :qIds];
               qInn.anwers= [SELECT id,Ans__c,Ans_By__c,Option__c,Question__c,Surveyor__c,Option__r.Name from Answer__c where Ans_By__r.As_id__r.AS_Email__c=:loginuserEmail And Surveyor__r.As_id__r.AS_Email__c=:answeredUserEmail];
          }
           return qInn ;
      }
    
     
     global class QuestionsInn{
        public List<MMQuestion__c> questions{get;set;}
        public List<Qaj__c> optWithQuestions{get;set;}
        public List<Answer__c>  anwers{get;set;}
           
     }
  
     
   }
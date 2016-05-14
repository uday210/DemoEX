public with sharing class MM_Surevycon {

 public String displayAttendee { get; set; }
 public List<Answer__c> lisOfAnsToInsert{get;set;}
 public MAP<id,MMQuestion__c> mapOptWithQue{get;set;}
 public MAP<id,List<Answer__c>> mapQueWithAns{get;set;}
 public List<QueQithOpt> queInn{get;set;}
 public  List<Answer__c> ansList{get;set;}
 public MAP<id,List<Answer__c>> MAPQidWithAids {get;set;}


      public Event__c Event {get;set;}
      public string Eventid;
      
      public string StrCorp ;
      public boolean AddButton{get;set;}
      public boolean display {get;set;}
      public MMQuestion__c ques{get;set;}
      public string selectedtype {get;set;}
      public String userProfile{get;set;}
      public String loginuserEmail {get;set;}
      public String SurveyerId{get;set;}
      public String attendeeid{get;set;} 
      public List<MMQuestion__c>  eventSurveyQuestions{get;set;}

     

      public MM_Surevycon(){
           // firstMethod(); 
      }
    
  
  public void firstMethod(String eventId,String loginEmail){
         this.Eventid =eventId;
         loginuserEmail = loginEmail;
         eventSurveyQuestions = new List<MMQuestion__c>();
         mapOptWithQue= new MAP<id,MMQuestion__c>();
         Map<id,MMQuestion__c>  mapQuesQithId = new Map<id,MMQuestion__c>();
        
         for(User_Profile_Event__c upe : [SELECT id,MAtchMakingProfile__c From User_Profile_Event__c where User_id__r.userName=:loginuserEmail and EV_id__c=:eventId  and IsMatchMakingUser__c=true]){
             userProfile = upe.MAtchMakingProfile__c;
         } 
         // getting questions To Map question id With Question obj 
            eventSurveyQuestions  =  [select id,Name,Order_No__c,Whom__c,IsConditional__c,Type__c,(select id,Name from Options__r order by Order__c) from MMQuestion__c where Events__c=:eventId and (whom__c=:userProfile OR whom__c='All') order by Order_No__c asc ];
            for(MMQuestion__c que : eventSurveyQuestions){
              mapQuesQithId.put(que.id,que);
           }
         
           List<Event_Attendee_Mapping__c> surEx =[SELECT id  from Event_Attendee_Mapping__c where AS_Id__r.AS_Email__c=:loginuserEmail And  Ev_id__c=:eventId];
            if(surEx.size()>0){
               SurveyerId =surEx[0].id;
           }
           
           
           
           
       // Iterating for Getting answer and its Questions 
       for(Qaj__c Qaj : [SELECT id,Option__c,Question__c from Qaj__c where Option__c != null AND Question__r.Events__c=:eventId and (Question__r.whom__c=:userProfile OR Question__r.whom__c='All') order by Question__r.Order_No__c]){
          mapOptWithQue.put(Qaj.Option__c,mapQuesQithId.get(Qaj.Question__c));
      } 
      //surveyQuetionsMethod();
             
  }
  
  
   public List<QueQithOpt> surveyQuetionsMethod(string ansEmail){
        List<Event_Attendee_Mapping__c> ansEx =[SELECT id  from Event_Attendee_Mapping__c where AS_Id__r.AS_Email__c=:ansEmail And  Ev_id__c=:eventId];
          String attId =''; 
           if(ansEx.size()>0){
               attId=ansEx[0].id;
           } else{
              return null;
           } 
            
         queInn =new List<QueQithOpt>();
         attendeeid = attId;
         MAPQidWithAids =new MAP<id,List<Answer__c>>();
        // attendeeid = ApexPages.currentPage().getParameters().get('eamId');
         // Getting questions and its  answers provided By login user 
         ansList = new List<Answer__c>();
         ansList =[select id,Ans__c,Ans_By__c,Option__c,Question__c,Surveyor__c from Answer__c where Surveyor__c =:attId and  Ans_By__c=:SurveyerId and Question__r.Events__c=:eventId order by Question__r.Order_No__c asc ];
       // getting questions To Map question id With Question obj  
       system.debug('mmmmmm'+ansList);
         for(MMQuestion__c que : eventSurveyQuestions){
           List<Answer__c> localInn = new List<Answer__c>();
           for(Answer__c ans :ansList ){
             if(ans.Question__c == que.id){
                localInn.add(ans);  
             }
           } 
          MAPQidWithAids.put(que.id,localInn);
      }
      
      
      for(MMQuestion__c que : eventSurveyQuestions){
           if(que.IsConditional__c!=true){    
              queInn.add(new QueQithOpt(que,mapOptWithQue,'',MAPQidWithAids)); 
           }
        }
     return queInn;    
   }
  
  
  
  
  
   public PageReference Save(LIst<QueQithOpt> queInn) {
      lisOfAnsToInsert = new List<Answer__c>();
      for(QueQithOpt qInn : queInn){//Insering Parent Questions
      
       
         
              for(QueQithOpt qinnIn : qInn.queListinnInn){ // Inserting Subquestions
                if(qInn.question.Type__c=='Radio Buttons'){
                   System.debug('BBBBBBBB '+mapOptWithQue.get(qInn.selectedradioOpt) +' MMMMMMM  '+qInn.selectedradioOpt);
                     if(null != mapOptWithQue.get(qInn.selectedradioOpt)){
                         AndObject(qinnIn);
                     }
                   System.debug('Radioooooooooooooo '+qinnIn);
                 }else{
                    AndObject(qinnIn);
                    System.debug('Radioooooooooooooo 22222222222 '+qinnIn); 
                }
            }
        System.debug('Radioooooooooooooo 333333333 '+qInn); 
         AndObject(qInn);
      }
      if(lisOfAnsToInsert.size()>0){
         DataBase.saveResult[] sRes =  DataBase.Insert(lisOfAnsToInsert,false);
         System.debug('Insert Result    '+sRes);
         DataBase.delete(ansList,false);
      }
     
        return null;
    }


      public Void AndObject(QueQithOpt QQO){
            Answer__c ansFinal = new Answer__c();
            ansFinal.Surveyor__c =attendeeid;
            ansFinal.Ans_By__c = SurveyerId;
            
            System.debug('Survey Questions '+QQO.ansText);
            if(QQO.question.Type__c=='Text'){
              ansFinal.Ans__c=QQO.ansText;
            }else if(QQO.question.Type__c=='Radio Buttons'){
              ansFinal.Option__c=QQO.selectedradioOpt;
            }else if(QQO.question.Type__c=='PickList'){
              ansFinal.Option__c =QQO.selectedpick;
            }else if(QQO.question.Type__c=='CheckBoxs'){
                for(id ansInn :QQO.selectedOptions){
                  Answer__c ansFinal1 = new Answer__c(); 
                  ansFinal1.Option__c =ansInn ;
                  ansFinal1.Surveyor__c =attendeeid;
                 ansFinal1.Ans_By__c = SurveyerId;
           
                  ansFinal1.Question__c = QQO.question.id;
                  system.debug('FFFFFFFFFFFFFFFFff '+ansFinal1.Option__c);
                  system.debug('XXXXXXXXXXXXx  '+ansFinal1);
                  if(ansFinal1.Option__c!=null){
                     lisOfAnsToInsert.add(ansFinal1);
                     system.debug('GGGGGGGGGGG  '+ansFinal1.Option__c);
                  }
                  
               }  
          }
       ansFinal.Question__c = QQO.question.id;
      if(ansFinal.Option__c!=null || ansFinal.Ans__c!=null){  
        lisOfAnsToInsert.add(ansFinal);  
     }
 }

  
  
   public class QueQithOpt{
        public List<selectOption> options{get;set;}  
        public MMQuestion__c question{get;set;}
       // Selected values Variables
        public String selectedradioOpt{get;set;}
        public String selectedpick{get;set;}
        public String ansText{get;set;}
         public List<id> selectedOptions{get;set;}
        // Selected values Variables End
        public List<QueQithOpt> queListinnInn{get;set;}
        public string Oid{get;set;}
        public MAP<id,List<Answer__c>> mapAnsInn{get;set;}
        
            public QueQithOpt(MMQuestion__c que,MAP<id,MMQuestion__c> qMap,string rid,MAP<id,List<Answer__c>> mapansIds){
               options = new List<selectOption>();
               
               queListinnInn = new List<QueQithOpt>();
               question = new MMQuestion__c();
               // Variables Inn 
               selectedOptions = new List<id>();

               question =que;
               Oid = rid;
               mapAnsInn = new MAP<id,List<Answer__c>>();
                 mapAnsInn=mapansIds;
                if(mapansIds.size()>0){
                     if(null !=mapansIds.get(que.id)){
                       if((mapansIds.get(que.id)).size()>0){
                        if(que.Type__c=='Text'){
                            ansText =mapansIds.get(que.id)[0].Ans__c;
                          }else if(que.Type__c=='Radio Buttons'){
                            selectedradioOpt = mapansIds.get(que.id)[0].Option__c;
                          }else if(que.Type__c=='PickList'){
                             selectedpick = mapansIds.get(que.id)[0].Option__c;
                          }else if(que.Type__c=='CheckBoxs'){
                             for(Answer__c ansInn :mapansIds.get(que.id) ){
                               selectedOptions.add(ansInn.Option__c);
                             }  
                          }
                         }  
                     }
                }
                 if(que.Type__c!='Text'){
                   
                   if(question.Type__c=='PickList'){
                        options.add(new SelectOption('','None'));
                      }
                    for(Option__c opt : que.Options__r){
                      options.add(new SelectOption(opt.id,opt.Name));
                        if(question.Type__c=='Radio Buttons' || question.Type__c=='PickList'){
                            if(null != qMap.get(opt.id)){
                               queListinnInn.add(new QueQithOpt(qMap.get(opt.id),qMap,opt.id,mapAnsInn));
                            }
                        }
                    }
                  }
                system.debug('====queListinnInn===='+queListinnInn); 
               } 
            
        }
   
       
}
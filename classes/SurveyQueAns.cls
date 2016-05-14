@RestResource(urlMapping='/SurveyQueAns/*')
/*
 * AUTHOR: Phani     
 * Email : phani@globalnest.com
  */
global with sharing class SurveyQueAns{
  @HttpPost
    global static string  doGet(){
       RestRequest req = RestContext.request;
        Blob reqbody =req.requestBody;
        System.debug('QQQQQQQQQ  '+reqbody ); 
        
       String loginuserEmail = req.params.get('LoginId');
       String answeredUserEmail = req.params.get('SelectedId');
       
        String eveid = req.params.get('EventId');
          System.debug('ZZZZZZZZZZZZz  '+answeredUserEmail +'  '+loginuserEmail +'   '+eveid ); 

        string Reqblobbody = reqbody.toString();
        List<Inncls> innsList = new List<Inncls>();
       System.debug('CCCCCCCCCCCCCC  '+Reqblobbody ); 

          JSONParser Parser = JSON.createParser(Reqblobbody);
          While(parser.nextToken()!= null){
              if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
               while(parser.nextToken() != null){
                  if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
                    SurveyQueAns.Inncls bl = (SurveyQueAns.Inncls)parser.readValueAs(SurveyQueAns.Inncls.class);
                    System.debug('PPPPPPPPPPPPPPPp '+bl); 
                    innsList.add(bl); 
                  }
               }
             }
           }
           
        // Getting questions and its  answers provided By login user 
        List<Answer__c> ansList = new List<Answer__c>();
        ansList =[select id,Ans__c,Ans_By__c,Option__c,Question__c,Surveyor__c from Answer__c where (Surveyor__r.AS_Id__r.AS_Email__c=:answeredUserEmail AND Ans_By__r.AS_Id__r.AS_Email__c=: loginuserEmail)];
        Database.delete(ansList,false);
        //Getting Event Mapping ids to Fill surveyer ans answerBy
        List<Event_Attendee_Mapping__c> surEx =[SELECT id  from Event_Attendee_Mapping__c where AS_Id__r.AS_Email__c=:loginuserEmail And  Ev_id__c=:eveid];
        List<Event_Attendee_Mapping__c> surAtt =[SELECT id  from Event_Attendee_Mapping__c where AS_Id__r.AS_Email__c=:answeredUserEmail And  Ev_id__c=:eveid];
         if(surEx.size()<=0 || surAtt.size()<=0){
          System.debug('Failed'); 
           return 'Failed';        
         }

        List<Answer__c> ansListForInsert = new List<Answer__c>();
        for(Inncls inns :innsList ){
             Answer__c ans = new Answer__c();
             ans.Question__c = inns.qid;
           try{   
             ans.Ans_By__c  =surEx[0].id;
             ans.Surveyor__c = surAtt[0].id;
            }catch(exception er){} 
             if(inns.textStr!=null && inns.textStr!=''){
               ans.Ans__c =  inns.textStr;
             }else if(inns.radioStr!=null && inns.radioStr!=''){
                ans.Option__c = inns.radioStr;
             }else if(inns.picStr!=null && inns.picStr!=''){
                ans.Option__c = inns.picStr;
             }else if(inns.chkStr!=null && inns.chkStr!=''){
                for(string s :inns.chkStr.split(',')){
                     Answer__c ans1 = new Answer__c();
                      ans1.Option__c = s;
                      ans1.Question__c = inns.qid;
                      try{   
                       ans1.Surveyor__c =surAtt[0].id;
                       ans1.Ans_By__c =surEx[0] .id;
                      }catch(exception er){} 
            
                      ansListForInsert.add(ans1);
                }
            }
             ansListForInsert.add(ans);  
        }
       if(ansListForInsert.size()>0){
          DataBase.insert(ansListForInsert,false);
       } 
        System.debug('Success');
      return 'Success';
    }
    global class Inncls{
     public string qid{get;set;}
     public string textStr{get;set;}
     public string radioStr{get;set;}
     public string chkStr{get;set;}
     public string picStr{get;set;}   
   }  
    

 }
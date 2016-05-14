//Modifications done by Thirupathi Pattipaka 
public with sharing class BLN_Attendees_BAL {

 public BLN_Ticket_DAO tcDAo{get;set;}
 public List<inncls> inn{get;set;}
 
 //Method to get all the cancelled tickets related order 
  public List<inncls> getAllTickets(string uid,string eventId){
        tcDAo = new BLN_Ticket_DAO();
        inn= new List<inncls>();
        string status ='Cancelled';
      //  string ststus2 = 'Completed';
       string ststus_a = 'Abandoned';
       string ststus_n = 'Not Paid';
        string ststus3 = 'N - No Badge';
        string temp = ' where event__c = \''+eventId+'\' '+' and  Ticket_Status__c != \''+status+'\''+' and order__c!=null and tkt_profile__r.BLN_GN_User__c!=null and order_item__c != null';
        
          temp+=' and  order__r.Order_Status__c != \''+status+'\'';
           temp+=' and  order__r.Order_Status__c != \''+ststus_a+'\'';
            temp+=' and  order__r.Order_Status__c != \''+ststus_n+'\'';
          //temp+=' and  (Item_Type__r.Badgable__c != \''+ststus3 +'\' OR Item_Pool__r.Badgable__c != \''+ststus3+'\')';
         // temp+=' and  order__r.Transaction_Status__c= \''+ststus2+'\''+'order by order__c';
           temp+=' order by order__c';
    // order by order__c
    System.debug('DDDDD:::'+tcDao.userOrderAndTickets(temp));
        for(Ticket__c tc : tcDao.userOrderAndTickets(temp)){
        
            inn.add(new inncls(tc));
         }
         return inn;
     }

   public class inncls{
     public boolean selectCheckBox{get;set;}
     public Ticket__c ticket{get;set;}  
     public inncls(ticket__c t){
        this.ticket=t;     
     }
   }
   
   //Method to modify survey answers given at registration level
   public LIst<surveyQuestions> surveysListToinsert {get;set;}
   public String modifySurveyAnswers(string ticketId,string eventid,BLN_MyticketsCon.surveyCls buyerInfo,string oldvalref ){
        String orderStatus='Success';
        surveysListToinsert = new List<surveyQuestions>();
        if(ticketId!=null || ticketId!=''){           
           surveysListToinsert.add(new surveyQuestions(ticketId,eventid,buyerInfo.UserAnswer,oldvalref ));                 
        } 
      
        if(surveysListToinsert.size()>0){
            System.debug('Survey '+surveysListToinsert);
            surveyAnswersUpsertion(surveysListToinsert);           
        }
        return orderStatus; 
     }
     
     // For inserting Survey Questions 
    public class surveyQuestions{   
        public string ticket{get;set;}
        public string eventid{get;set;}   
        public List<BLN_MyticketsCon.UserAnswerInnerClass> listinn{get;set;}
        public string oldval{get;set;} 
        public surveyQuestions(string ticketinn,string eventid,List<BLN_MyticketsCon.UserAnswerInnerClass> inn,string oldvalInn ){          
          this.ticket  = ticketinn;     
          this.eventid = eventid;
          this.listinn =inn;
          this.oldval=oldvalInn ;
        }         
    }
    
    //method to upserting survey answers
    public void surveyAnswersUpsertion(LIst<surveyQuestions> surveysListToinsertTemp){
        BLN_SurveyQuestions_BAL SQBal = new BLN_SurveyQuestions_BAL();         
        BLN_UserAnswers_DAO usa=new BLN_UserAnswers_DAO();
        for(surveyQuestions sur : surveysListToinsertTemp){               
            System.debug('Survey Questions Size   '+sur.ticket);
            System.debug('Survey Questions Item   '+sur.eventid);
            System.debug('Survey Questions Level   '+sur.listinn);
            
            for(BLN_MyticketsCon.UserAnswerInnerClass UAnswer : sur.listinn){
                System.debug('Survey Records '+UAnswer);
                Id ItemQuestionId;
                id tcis ;
                Id usransId;
                Set<id> chbxId=new set<id>();
                tcis  = sur.ticket;
                ItemQuestionId  = UAnswer.itq.id;
                usransId=UAnswer.uans.Id;
                chbxId.addAll(UAnswer.setchbxid); 
                
                string oldvalAns='';
                oldvalAns=sur.oldval;
                 
                if(UAnswer.itq.question__r.Answer_Type__c=='Checkboxes' && UAnswer.SelectedAnswerCheck.size()>0){                    
                    BLN_StatusMessage UAMsg = SQBal.upsertCheckboxSurveyUserAnswer(UAnswer.SelectedAnswerCheck,ItemQuestionId,tcis,chbxId,oldvalAns);
                }else if(UAnswer.itq.question__r.Answer_Type__c!='Checkboxes' && UAnswer.itq.question__r.Answer_Type__c!='Text' && UAnswer.itq.question__r.Answer_Type__c!='Paragraph text'){
                    if(UAnswer.SelectedAnswer!=Null){
                    BLN_StatusMessage UAMsg = SQBal.upsertSurveyUserAnswer(UAnswer.SelectedAnswer,ItemQuestionId,tcis,usransId,oldvalAns); 
                    }else{
                    BLN_StatusMessage UAMsg1 = SQBal.upsertSurveyUserAnswer('',ItemQuestionId,tcis,usransId,oldvalAns); 
                    }
                }else if((UAnswer.itq.question__r.Answer_Type__c=='Text' || UAnswer.itq.question__r.Answer_Type__c=='Paragraph text') && UAnswer.SelectedAnswer!=''){
                    BLN_StatusMessage UAMsg = SQBal.upsertSurveyUserAnswerTxtPara(UAnswer.SelectedAnswer,ItemQuestionId,tcis,usransId,oldvalAns);     
                }else if((UAnswer.itq.question__r.Answer_Type__c=='Text' || UAnswer.itq.question__r.Answer_Type__c=='Paragraph text') && UAnswer.SelectedAnswer==''){
                    usa.deleteSurveyUserAnswerTxtPara(UAnswer.SelectedAnswer,ItemQuestionId,tcis,usransId);     
                }
                
                //deleting saved checkbox answers incase of not checked any checkbox
                if(UAnswer.SelectedAnswerCheck.size()==0 && UAnswer.itq.question__r.Answer_Type__c=='Checkboxes'){
                    //deleting saved answers if all checkbox are checked
                     list<user_answer__c> delList=[select id,name from user_answer__c where id in : chbxId];
                     database.delete(delList,false);
                }
            } 
        }
    }
   
}
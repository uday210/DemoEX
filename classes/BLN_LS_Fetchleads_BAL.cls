global with sharing class BLN_LS_Fetchleads_BAL {
    public BLN_LS_Fetchleads_BAL() {
        
    }

global List<wrap_userbasedlist> getSurveyAns(List<Lead_Scan__c> leadlisttemp, String loginUserId,String eventId){
    
     /***********************************************************************/
     GN_User__c logingnusr=new GN_User__c ();
     logingnusr  =[select id,User__c from GN_User__c where id=:loginUserId  limit 1];
    //list<Lead_Scan__c> leadlist = new list<Lead_Scan__c>();
   // leadlist.addALL(myleads.leadsList);
     set<id> sid = new set<id>();
      FOR(Lead_Scan__c  LSL: leadlisttemp) {
        sid.add(LSL.BLN_TKT_profile__c);
        }
    list<User_Answer__c> userANSAll = new list<User_Answer__c>();
    userANSAll = [select id , Item_Question__c , UAnswer_Text__c , ticket__r.TKT_profile__r.id from User_Answer__c where ticket__r.TKT_profile__c IN :sid];
    MAP<id,List<User_Answer__c>> mapuidWithSq = new MAP<id,List<User_Answer__c>>();
    for(User_Answer__c uns : userANSAll){
      List<User_Answer__c> unsWs = new List<User_Answer__c>();
      if(mapuidWithSq.keySet().contains(uns.ticket__r.TKT_profile__r.id)){
          unsWs = mapuidWithSq.get(uns.ticket__r.TKT_profile__r.id);  
        }
       unsWs.add(uns);
       mapuidWithSq.put(uns.ticket__r.TKT_profile__r.id,unsWs);
    }

        list<Question__c> questions=new list<Question__c>();
        questions = [select Event__c,Question_Text__c,(select id,Question__c,Question_Level__c from Item_Question__r),Question_Order__c,Answer_Type__c,Name from Question__c where ownerid =:logingnusr.User__c  and Event__c=:eventId ];
        map<id,Item_Question__c>  map_itemquestions =new map<id,Item_Question__c>();
        list<Item_Question__c>  lst_itemquestions=new list<Item_Question__c>();
        Map<id,Question__c>  questionMap = new Map<id,Question__c>();
        for(Question__c qs:questions){
        lst_itemquestions.add(qs.Item_Question__r);
        map_itemquestions.put(qs.Item_Question__r[0].id,qs.Item_Question__r[0]);
        questionMap.put(qs.id,qs);
        }
        system.debug('$$$$$$$$$'+map_itemquestions);
        
        
        list<wrap_userbasedlist>  userDetaillist =new list<wrap_userbasedlist>();
        for(id gnuid:sid){ 
        list<User_Answer__c> userANS = new list<User_Answer__c>(); 
        list<wrapcls>  userAlldata =new list<wrapcls>();
        system.debug('$$gnuid'+gnuid);
      if(null!=mapuidWithSq.get(gnuid)){
          userANS =  mapuidWithSq.get(gnuid); 
      }      
        if(userANS.size()>0){
        for(User_Answer__c uans:userANS ){
        if(map_itemquestions.get(uans.Item_Question__c) !=null){
           Item_Question__c itq=new Item_Question__c();     
             itq =   map_itemquestions.get(uans.Item_Question__c);
         Question__c Questiondetails=new Question__c(); 
            Questiondetails =   questionMap.get(itq.Question__c);
         system.debug('***Questiondetails'+Questiondetails); 
          userAlldata.add(new wrapcls(Questiondetails,map_itemquestions.get(uans.Item_Question__c),uans));
          }
          }
          
        userDetaillist.add(new wrap_userbasedlist(gnuid,userAlldata));
        }
      }
   return userDetaillist;
}


/*global class Leadslist{
      public BLN_ResponseMsg msg=new BLN_ResponseMsg();
      public List<Lead_Scan__c> leadsList{get;set;}
      public list<wrap_userbasedlist> user_Q_nd_A {get;set;}
      public String LastModifiedDate{get;set;}

   }*/

global class wrap_userbasedlist{
   public string Scaneeid{get;set;}
   public list<wrapcls> UserQndANS{get;set;}
   public wrap_userbasedlist(string Scid,list<wrapcls> usQANS){
   Scaneeid = Scid;
   UserQndANS =usQANS;
   }
   }


  global class wrapcls{
    public string    question_Id {get;set;}
    public string    question_Text {get;set;}
    public Decimal    question_Order {get;set;}
    public string    question_Level {get;set;}
    public string    event_Id {get;set;}
    public string    answer_Id  {get;set;}
    public string    answer_Text {get;set;}
    public string    item_Question_Id  {get;set;}
    public string    scannie_Id   {get;set;}
            public wrapcls(Question__c qus,Item_Question__c itQs,User_Answer__c userA){
            
                   Item_Question__c     itemquestion_Q =new Item_Question__c ();
                   User_Answer__c   useranswer_A = new User_Answer__c ();
                   Question__c    QuestionDetails =new  Question__c();
                        itemquestion_Q  = itQs;
                        useranswer_A  = userA;
                        QuestionDetails = qus;
                        
                        question_Id      =   QuestionDetails.id ;
                        question_Text    =   QuestionDetails.Question_Text__c ;
                        question_Order   =   QuestionDetails.Question_Order__c;
                        question_Level   =   itemquestion_Q.Question_Level__c;
                        event_Id         =   QuestionDetails.Event__c ;
                        answer_Id        =   useranswer_A.id;
                        answer_Text      =   useranswer_A.UAnswer_Text__c;
                        item_Question_Id =   itemquestion_Q.id;
                        scannie_Id       =   useranswer_A.ticket__r.TKT_profile__c;
                 
            }
     }  
}
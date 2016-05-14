@RestResource(urlMapping='/BLN_LS_UpdateLead/*')
 global class BLN_LS_UpdateLead{
   @HttpPost
   global Static maincontainer doPost(){ 
     RestRequest req = RestContext.Request; 
     String Reqblobbody;
     Blob reqbody =req.requestBody;   
     Reqblobbody = reqbody.toString();
     System.debug('HHHHHHHHHHH '+Reqblobbody);
     //List<Lead_Scan__c> lsScan = (List<Lead_Scan__c>) JSON.deserialize(Reqblobbody, List<Lead_Scan__c>.class);
     /**********************************************/
     mainclass lead_scan_nd_leadqalifier=new mainclass();
     lead_scan_nd_leadqalifier = (mainclass) JSON.deserialize(Reqblobbody, mainclass.class);
   //  system.debug('$$lead_scan_nd_leadqalifier'+lead_scan_nd_leadqalifier);
    // system.debug('$$lsscan '+lead_scan_nd_leadqalifier.LeadScan);
   //  system.debug('$$leadqualifer'+lead_scan_nd_leadqalifier.Lead_Qualifiers);
    /***********************************************/
     maincontainer mnCnt = new maincontainer();
     LIST<container> cntList = new LIST<container>();
     set<id> leadIdSet=new set<id>();
     set<id> delLeadIds=new set<id>();
     for(Lead_Scan__c lk  : lead_scan_nd_leadqalifier.LeadScan){
           // container cnt = new container();
          leadIdSet.add(lk.id);
          if(lk.Lead_Status__c =='Deleted'){
              delLeadIds.add(lk.BLN_TKT_profile__c);
          }
          if(lk.followup_date__c!=null){
           //lk.followup_date__c =lk.followup_date__c;
              BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
              String myDate = lk.followup_date__c.formatGMT('MM/dd/yyyy hh:mm a');
              //lk.followup_date__c =timezonecl.getDateBasedOnEventTimeZone(myDate,lk.Event__c);
              lk.followup_date__c =timezonecl.getDateBasedOnEventTimeZone(myDate,'GMT');
          }else{
          lk.followup_date__c =null;
          }
          //System.debug(' Country '+lk.BLN_Country__r.Name +' lk.BLN_State__r   '+lk.BLN_State__r.Name);
          if(lk.BLN_Country__r.Name== '' || lk.BLN_Country__r.Name==null){
          lk.BLN_Country__c = null;
          }
          
          if(lk.BLN_State__r.Name== '' || lk.BLN_State__r.Name==null){
          lk.BLN_State__c = null;
          }
          
          string leadimgstr = lk.user_pic__c;
          if(leadimgstr.length() >0){
              List<folder> folderList =new List<folder>();
             folderList = [select id from folder where Name =: 'Shared Documents'];
             document mydoc = new document();
             mydoc.body = EncodingUtil.base64Decode(leadimgstr);
             mydoc.folderid = folderList[0].id;
             mydoc.ispublic = true;
             mydoc.Name = lk.First_Name__c+lk.Last_Name__c+'.png';
             mydoc.contentType='image/png';
             insert mydoc;
             lk.user_pic__c = mydoc.id;
             
              /*string orgid = UserInfo.getOrganizationId();  
              String siteurl=Label.SiteURL;
              cnt.leadpicString=  siteurl+'/servlet/servlet.ImageServer?id='+lk.User_Pic__c+'&oid='+orgid;*/
              
          }
          /*cnt.leadID=lk.Id;
          cnt.LastModifiedDate = system.now();
       cntList.add(cnt);*/
      }
      
  
     Database.UpsertResult[] upres= Database.upsert(lead_scan_nd_leadqalifier.LeadScan,false);
      
     BLN_LeadScan_DAO lsDAO=new BLN_LeadScan_DAO();
     LIST<lead_scan__c> lslist=new LIST<lead_scan__c>();
     lslist = lsDAO.leadRecords(leadIdSet);
     
     
     
     for(lead_scan__c ls:lslist){
         container cnt = new container();
         string orgid = UserInfo.getOrganizationId();  
         String siteurl=Label.SiteURL;
         cnt.leadpicString=  siteurl+'/servlet/servlet.ImageServer?id='+ls.User_Pic__c+'&oid='+orgid;
         cnt.leadID=ls.Id;
         cnt.LastModifiedDate = ls.LastModifiedDate;
         cnt.leadFollowupDate=ls.followup_date__c;
         cntList.add(cnt);
     }
      
      
      System.debug('OOOOOOO:::::::::::::  '+upres);
      /***********************************************************/
      
     // list<Question__c> question_list=new list<Question__c>();
     // list<Item_Question__c> item_q_list = new list<Item_Question__c>();
     // list<User_Answer__c>  user_ans_list =new list<User_Answer__c>();
      list<leadqalifier_res>  l_qualif_res =new list<leadqalifier_res>();
      if(lead_scan_nd_leadqalifier.Lead_Qualifiers.size()>0){
              For(cls_leadqualifier l_Qual:lead_scan_nd_leadqalifier.Lead_Qualifiers){
              if(l_Qual.question_Id !=null && l_Qual.question_Id !='' && l_Qual.itemQuetion_Id !=null && l_Qual.itemQuetion_Id !='' ){
                       
                          if(l_Qual.answerId !=null && l_Qual.answerId !=''  /*&& l_Qual.scanneAns!=null && l_Qual.scanneAns != ''*/){
                          
                              User_Answer__c userGiveAnswer =new User_Answer__c();
                              //userGiveAnswer =[select BLN_Answer__c,Item_Question__c,UAnswer_Text__c,User__c from User_Answer__c where id=:l_Qual.answerId limit 1];
                              userGiveAnswer =[select BLN_Answer__c,Item_Question__c,UAnswer_Text__c,Ticket__r.tkt_profile__c from User_Answer__c where id=:l_Qual.answerId limit 1];
                              userGiveAnswer.UAnswer_Text__c = l_Qual.scanneAns;
                              Database.SaveResult udateAnswer = Database.Update(userGiveAnswer, false);
                              if(l_Qual.questionOrder =='' || l_Qual.questionOrder == null){
                                l_Qual.questionOrder = '1';
                                }
                                if(udateAnswer.isSuccess()){
                              l_qualif_res.add(new leadqalifier_res(userGiveAnswer,l_Qual.question_Id,integer.valueof(l_Qual.questionOrder),l_Qual.questionText,userGiveAnswer.Ticket__r.tkt_profile__c));
                                    }
                          }
                          else if(l_Qual.questionOrder !=null && l_Qual.questionOrder !='' && (l_Qual.answerId ==null || l_Qual.answerId =='' )){
                            Decimal order_of_quest= Decimal.valueof(l_Qual.questionOrder);
                 
                            //User_Answer__c user_eq_ans=new User_Answer__c(Item_Question__c =l_Qual.itemQuetion_Id  ,UAnswer_Text__c =l_Qual.scanneAns ,User__c = l_Qual.scanneeId  );
                            ticket__c tic =[select tkt_profile__c from ticket__c where tkt_profile__c =:l_Qual.scanneeId limit 1];
                            User_Answer__c user_eq_ans=new User_Answer__c(Item_Question__c =l_Qual.itemQuetion_Id  ,UAnswer_Text__c =l_Qual.scanneAns,Ticket__c= tic.id);
                            Database.SaveResult user_sq = Database.insert(user_eq_ans, False);
                            //system.debug('%%%%'+user_sq );
                            //system.debug('$$$$$'+user_eq_ans);
                            User_Answer__c user_eq_ans1=[select BLN_Answer__c,Item_Question__c,UAnswer_Text__c,Ticket__r.tkt_profile__c from User_Answer__c where id=:user_eq_ans.Id limit 1];
                            l_qualif_res.add(new leadqalifier_res(user_eq_ans,l_Qual.question_Id,order_of_quest,l_Qual.questionText,user_eq_ans1.Ticket__r.tkt_profile__c));
                              }
              }else{
                        if(l_Qual.eventId !=null && l_Qual.eventId !='' && l_Qual.questionText !=null && l_Qual.questionText !='' && l_Qual.scanneeId != null && l_Qual.scanneeId != '' && l_Qual.scannerId != '' && l_Qual.scannerId != null && l_Qual.questionOrder !='' && l_Qual.questionOrder !=null){
                              Decimal order_question= Decimal.valueof(l_Qual.questionOrder);
                              Question__c question_lq=new Question__c(Event__c=l_Qual.eventId,Question_Order__c =order_question,Question_Text__c = l_Qual.questionText,OwnerId = l_Qual.scannerId  );
                              Database.SaveResult question_s = Database.insert(question_lq, False);
                             // question_list.add(question_lq);
                              Item_Question__c item_q=new Item_Question__c(Event__c=l_Qual.eventId,Question__c =question_lq.id,Question_Level__c =l_Qual.questionLevel);
                            //  item_q_list.add(item_q);
                              Database.SaveResult item_s = Database.insert(item_q, False);
                              //User_Answer__c user_ans=new User_Answer__c(Item_Question__c =item_q.id ,UAnswer_Text__c =l_Qual.scanneAns ,User__c = l_Qual.scanneeId  );
                              ticket__c tic =[select tkt_profile__c from ticket__c where tkt_profile__c =:l_Qual.scanneeId limit 1];
                              User_Answer__c user_ans=new User_Answer__c(Item_Question__c =item_q.id ,UAnswer_Text__c =l_Qual.scanneAns,Ticket__c= tic.id);
                              Database.SaveResult user_s = Database.insert(user_ans, False);
                            //  user_ans_list.add(user_ans);
                            
                            system.debug('questionText'+l_Qual.questionText);
                            system.debug('Question_Text__c'+question_lq.Question_Text__c);
                            User_Answer__c user_ans1=[select BLN_Answer__c,Item_Question__c,UAnswer_Text__c,Ticket__r.tkt_profile__c from User_Answer__c where id=:user_ans.Id limit 1];
                              l_qualif_res.add(new leadqalifier_res(user_ans,question_lq.id,question_lq.Question_Order__c,question_lq.Question_Text__c,user_ans1.Ticket__r.tkt_profile__c));
                         system.debug('##@@'+l_qualif_res);
                         }
                  } 
              }
      }
      
      if(delLeadIds.size()>0){
         LIST<User_Answer__c> uAns=[select id from User_Answer__c where Ticket__r.tkt_profile__c IN :delLeadIds and Item_Question__r.Question_Level__c ='Lead Retrieval'];// and Item_Question__r.Question__r.OwnerId =
         DataBase.DeleteResult[] saveres = dataBase.delete(uAns,false);
     }
      
      /***********************************************************/
     // system.debug('&^$$l_qualif_res'+l_qualif_res);
      BLN_ResponseMsg msg=new BLN_ResponseMsg();
      msg.ldvalueAssign('Message','You have successfully updated data !',TRUE); 
      
      mnCnt.respMsg=msg;
      mnCnt.leadImageUrls=cntList;
      mnCnt.Lead_Qualifiers_List =l_qualif_res;
      return mnCnt;
   }

  public class leadscan{
    public String fielsName {get;set;}
    public String fieldValue{get;set;}
   }
   
   global class maincontainer{
      public BLN_ResponseMsg respMsg{get;set;}
      public LIST<container> leadImageUrls{get ; set ;}
      public list<leadqalifier_res> Lead_Qualifiers_List{get;set;}
       public maincontainer(){} 
  }
  global class container{
      public string leadID{get;set;}
      public string leadpicString{get;set;}
      public dateTime LastModifiedDate{get;set;}
      public dateTime leadFollowupDate{get;set;}
  
  }
  /*******************************************/
    global class mainclass{
        public list<Lead_Scan__c> LeadScan;
        public list<cls_leadqualifier> Lead_Qualifiers;
    }
    global class cls_leadqualifier {
            public String eventId;  
            public String questionText; 
            public String scannerId;   
            public String questionOrder;  
            public String questionLevel;   
            public String scanneeId;    
            public String scanneAns;
            public String question_Id;
            public String itemQuetion_Id;  
            Public string answerId;
           
        }
     global class leadqalifier_res{
     
      public string Questionid{get;set;}
      public integer Questingordernumber{get;set;}
      public string QuestionText{get;set;}
      public User_Answer__c User_answer{get;set;}
      public string Scaneeid{get;set;}
     public leadqalifier_res(User_Answer__c usrans,string qusid,Decimal qorderno,string questionText_t,string Scaneeid1){
     integer q_ordn;
     if(qorderno !=null){
      q_ordn =integer.valueof(qorderno);
        }
       User_answer = new User_Answer__c();
       User_answer =  usrans;
       Questionid = qusid;
       Questingordernumber = q_ordn;
       QuestionText = questionText_t;
       Scaneeid = Scaneeid1;
     }
       } 
  
  /*****************************************/

}
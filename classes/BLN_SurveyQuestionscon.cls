Public without sharing class  BLN_SurveyQuestionscon {

    public String parentansid { get; set; }
 
  /***********************************************************************************************
    *   Controller Name         : BLN_SurveyQuestionscon 
    *   Date                    : 30/06/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for Creating Survey Questions.
    **************************************************************************************************/
    

    public List<Question__c> questionslist{get;set;}
    public Question__c questionrecord{get;set;}
    public List<BLN_Answer__c> answerslist{get;set;}
    public BLN_Answer__c answerrecord{get;set;}
    public Item_Question__c Itemquerecord{get;set;}
    public List<Item_Question__c> Itemquelist{get;set;}
    public MAP<string,BLN_Item__c> ItemMAP{get;set;}
    public MAP<string,List<Item_Pool__c>> ItemPoolMAP{get;set;}
    public MAP<ID,Question__c> QuestionMAP{get;set;}
    Public MAP<string,List<User_Answer__c>> useranswersMAP{get;set;}
    public List<BLN_Answer__c> deletedansonedit{get;set;}
    public Item_Question__c itemQuestionForEventlevel {get;set;}
    public boolean isPackage{get;set;}
    
   
   
    Public LIST<BLN_Item__c> itemslist {get;set;}
    Public LIST<Item_Pool__c> itemPoolList {get;set;}
    Public MAP<String,Item_Question__c> ItemQuestionDupMAP{get;set;}
    Public MAP<STRING,List<Item_Question__C>> itmqueansMap {get;set;}
    Public MAP<String,BLN_Answer__c> AnswerDupMAP{get;set;}
    Public List<SelectOption> itemnames{get;set;}
    Public List<SelectOption> itempoolnames{get;set;}
    Public string selectedeventid{get;set;}
    Public Set<String> failuremessageset {get;set;}
    public Boolean isMove {get;set;}
    
    public Boolean createquestionbool{get;set;}
    public Boolean multiplechoiceoptions {get; set;}
    public Boolean displaytablebool{get;set;}
    public Boolean errormessagebool{get;set;}
    public Boolean editbool{get;set;}
    public Boolean itemdisplaybool{get;set;}
    
    Public String CheckTicketsforedit{get;set;}
    Public String CheckreqTicketsforedit{get;set;}
    Public String CheckvisTicketsforedit{get;set;}
    Public String selectedquelevl{get;set;}
    
    public List<SelectOption> minscale{get;set;}
    public List<SelectOption> maxscale{get;set;}
    public string selctdminscale{get;set;}
    public string selctdmaxscale{get;set;}
    
    public MAP<Decimal,BLN_Answer__c> answerMAP{get;set;}
    public Decimal Uniqueno{get;set;}
    public string selectedtype {get;set;}
    public Set<String> dupselectedtype {get;set;}
    Public BLN_Event__c eventslist {get;set;}
    public BLN_UtillDisplayLinks mysurveyque {get;set;}

    public List<SelectOption> getAnsList() {
            System.debug('LLLLLL::::'+selectedquelevl);
            
            Set<id> levelIds=new Set<Id>();
            Set<id> elevelIds=new Set<Id>();
            for(Item_Question__c iqt : [Select id,name,question_level__c,question__r.id from item_question__c where Question__r.Event__c=:selectedeventid and Question__r.Answer_Type__c='Single Selection']){
                if(iqt.question_level__c=='Ticket Level'){
                    levelIds.add(iqt.question__r.id);    
                }else if(iqt.question_level__c=='Event Level'){
                    elevelIds.add(iqt.question__r.id);   
                }
            }
        
            List<SelectOption> options = new List<SelectOption>();
            List<BLN_Answer__c> anslist=new List<BLN_Answer__c>();
            anslist=[select id,name,Answer_Text__c,BLN_Question__c,BLN_Question__r.id,BLN_Question__r.Event__c,BLN_Question__r.Question_Text__c,BLN_Question__r.Answer_Type__c from BLN_Answer__c where BLN_Question__r.Event__c=:selectedeventid and BLN_Question__r.Answer_Type__c='Single Selection'];
            options.add(new SelectOption('','--None--'));
            for(BLN_Answer__c ans:anslist){
                if(selectedquelevl=='Ticket Level' && levelIds.contains(ans.BLN_Question__r.id)){
                    options.add(new SelectOption(ans.id,ans.Answer_Text__c+'(Question: '+ans.BLN_Question__r.Question_Text__c+')'));
                }else if(selectedquelevl=='Event Level' && elevelIds.contains(ans.BLN_Question__r.id)){
           options.add(new SelectOption(ans.id,ans.Answer_Text__c+'(Question: '+ans.BLN_Question__r.Question_Text__c+')'));
                }
           }
            return options;
        }
    public void displayPermissions(){
try{

   
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){
     selectedeventid = k.getValue();
     }
     
     
     try{
     eventslist  = geteventdetails();
     }catch(exception e){}
   
    SYSTEM.DEBUG(selectedeventid +'  EVENTID:  ' + eventslist);
         
         mysurveyque = new BLN_UtillDisplayLinks();
         mysurveyque.issurveyPage='active';
         mysurveyque.isTicketsPageExpand='expand';
         mysurveyque.tablabel='Survey Questions';
         try{
         mysurveyque.eventName = eventslist.Name;
         }catch(exception e){}
         mysurveyque.EventId= selectedeventid;
         mysurveyque.userPermissions(userInfo.getUserId(),selectedeventid);
         system.debug('  MY SURVEY QUESTIONS '+mysurveyque);
         }catch(exception ex){}
    }
   
   
   //Constructor
    public BLN_SurveyQuestionscon(){
    try{
   Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){
     selectedeventid = k.getValue();
     }
    itemObj=new BLN_Item__c();
    isPackage=false;
    //Id myId =System.currentPageReference().getParameters().get('recordId');
    isMove=false;
    itemQuestionForEventlevel  = new Item_Question__c(); 
    questionslist = new List<Question__c>();
    questionrecord = new Question__c();
    answerslist = new List<BLN_Answer__c>();
    answerrecord = new BLN_Answer__c();
    deletedansonedit= new List<BLN_Answer__c>();
    useranswersMAP = new MAP<string,List<User_Answer__c>> ();
    ItemMAP = new MAP<string,BLN_Item__c> ();
    ItemPoolMAP = new MAP<string,List<Item_Pool__c>> ();
    itemslist = new LIST<BLN_Item__c>();
    itemPoolList=new LIST<Item_Pool__c>();
    Itemquerecord = new Item_Question__c();
    Itemquelist = new List<Item_Question__c>();
    QuestionMAP = new MAP<ID,Question__c>();
    ItemQuestionDupMAP = new MAP<String,Item_Question__c>();
    AnswerDupMAP = new MAP<String,BLN_Answer__c> ();
    itmqueansMap = new MAP<String,LIST<Item_Question__c>>();
   
    createquestionbool = FALSE;
    multiplechoiceoptions = FALSE;
    displaytablebool = TRUE;
    errormessagebool = FALSE;
    editbool= FALSE;
    itemdisplaybool= TRUE;
    
    
    CheckTicketsforedit = '!@#$%^&';
    CheckreqTicketsforedit= '!@#$%^&';
    CheckvisTicketsforedit= '!@#$%^&';
    
    selectedtype = '';
    selectedquelevl= 'Ticket Level';
    Uniqueno = 0;
    answerMAP = new MAP<Decimal,BLN_Answer__c>();
    dupselectedtype = new  Set<String>(); 
    failuremessageset = new  Set<String>(); 
      
     minscale = new List<SelectOption>();
     minscale.add(new Selectoption('0', '0'));       
     minscale.add(new Selectoption('1', '1'));  
     
     maxscale = new List<SelectOption>();
     maxscale.add(new Selectoption('2', '2')); 
     maxscale.add(new Selectoption('3', '3')); 
     maxscale.add(new Selectoption('4', '4')); 
     maxscale.add(new Selectoption('5', '5')); 
     maxscale.add(new Selectoption('6', '6'));   
     maxscale.add(new Selectoption('7', '7')); 
     maxscale.add(new Selectoption('8', '8')); 
     maxscale.add(new Selectoption('9', '9')); 
     maxscale.add(new Selectoption('10', '10')); 
     
     system.debug('  SELECTED EVENT ID '+selectedeventid);
     // try{
     eventslist= new BLN_Event__c();
     eventslist= geteventdetails();
     //}catch(exception e){}
     
     //try{
     getquestionslist();
     //}catch(exception e){}
     }catch(exception ex){}
    }
 
  // -------------------------- This method is to Retrieve Event Details.--------------------------
      
       Public BLN_Event__c geteventdetails(){
         BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
         RETURN eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }
 
  
  
  //-------------- This method is to retrieve QuestionsList for the event------------.
     Public void getquestionslist(){
     
            questionslist = new List<Question__c>();     
          BLN_SurveyQuestions_BAL blnquestionsbal = New BLN_SurveyQuestions_BAL();
          questionslist = blnquestionsbal.questionslist(selectedeventid,questionslist);
          System.debug('QQQQQQQQ:'+questionslist );
          
        Itemquelist = new List<Item_Question__c>();
        itmqueansMap= new MAP<STRING,List<Item_Question__C>>();
        //BLN_SurveyQuestions_BAL blnitmquestionsbal = New BLN_SurveyQuestions_BAL();
        Itemquelist = blnquestionsbal.itemquestionslist(selectedeventid,Itemquelist);
        System.debug('IIIIIIII:'+Itemquelist);
        

        
           for(Item_Question__C que : Itemquelist ){
            string code = que.Question__r.Id;
            
           if(itmqueansMap.ContainsKey(code)){
               
                LIST<Item_Question__C> listnew = new LIST<Item_Question__C>();
                      listnew = itmqueansMap.get(code);
                      itmqueansMap.remove(code);
                       listnew.add(que);
                      itmqueansMap.Put(que.Question__r.Id,listnew);
           }
           
           else{
                      LIST<Item_Question__C>  listnew1 = new LIST<Item_Question__C> ();
                      listnew1.add(que);
                      itmqueansMap.Put(que.Question__r.Id,listnew1);
             }
           
           }
        
         
        system.debug('questionslist questionslist : ' + questionslist );
            for(Question__c que : questionslist){
               QuestionMAP.PUT(que.ID,que);
               
            }
            
           
            displaytablebool = TRUE;
            createquestionbool = FALSE;
            multiplechoiceoptions = FALSE; 
     }
     
     
     
     
     
   //-------------- End of retrieving QuestionsList for the event------------.   
     
    
    
    // ----------------------------This method is To retrieve all the items for the selected event.--------------------------
    public List<Item_Pool__c> poolsList{get;set;}
    public List<BLN_Item__c> itemTempList{get;set;}
    public MAP<string,List<Item_Pool__c>> ItemListMAP {get; set;}
    public SET<String> poolset {get;set;}
    public BLN_Item__c itemObj{get;set;}
    public List<List<Item_Pool__c>> ItemPoolListTemp{get; set;}
    public string mapchecker {get;set;}
    
    Public void getitems(){
    mapchecker  ='';
        BLN_PromoCode_BAL blnItembal = New BLN_PromoCode_BAL();
        itemslist = blnItembal.itemslist(selectedeventid);
        itemPoolList=blnItembal.itemPoollist(selectedeventid);
        System.Debug('ItemMap.values:' + itemslist);
        if(Itemslist.size()>0){
            itemTempList=new List<BLN_Item__c>(); 
            itemnames  = new List<SelectOption>();
            ItemMAP = new MAP<string,BLN_Item__c> ();
            ItemPoolListTemp=new List<List<Item_Pool__c>>();
            itemnames.add(new SelectOption('a089000000Mg123456','Select All' ));  
            if(itemPoolList.size()>0){
                itempoolnames=new List<SelectOption>();
                ItemPoolMAP = new MAP<string,List<Item_Pool__c>> ();
                ItemListMAP = new MAP<string,List<Item_Pool__c>> ();
                poolset =new SET<String>();
                system.debug(itemPoolList.size()+'  ITEM POOLSSS '+itemPoolList);
                for(Item_Pool__c itmpl : itemPoolList){
                    //if(itmpl.Package_Flag__c!='P - Package item pool' && itmpl.Addon_Parent__r.Item_type__r.name=='Package'){
                    System.debug('FFFFFFFF:'+itmpl.Package_Flag__c);
                    System.debug('PPPPPPPPP:'+itmpl.Addon_Parent__r.Item_type__r.name);
                    poolsList=new List<Item_Pool__c>();
                    poolsList=itmpl.Item_Pools__r;
                    System.debug('ooooooooo:'+poolsList);
                    if(itmpl.Package_Flag__c!='P - Package item pool' && itmpl.Addon_Parent__r.Item_type__r.name=='Package'){
                        itempoolnames.add(new SelectOption(itmpl.id,itmpl.Item_Pool_Name__c)); 
                    }
                    System.debug('NNNNNNNNN:'+itempoolnames);
                    if(poolsList.size() >0){ 
                        ItemPoolMAP.Put(itmpl.Id,poolsList);
                        mapchecker+=itmpl.Id+',';  
                        poolset=ItemPoolMAP.keySet();
                        ItemPoolListTemp=ItemPoolMAP.values();
                        }
                    //}
                
                }
                system.debug(ItemPoolMAP.size()+'   ITEMS MAPPPPPPPPP  '+ItemPoolMAP);
            }   
            mapchecker= '';
            for(BLN_Item__c items : Itemslist){
                
                if(items.item_name__c != null){
                    itemnames.add(new SelectOption(items.id,items.item_name__c ));
                    itemTempList=items.Items__r;
                    system.debug('  IF EXISTS '+ItemPoolMAP.containsKey(items.Item_Pool__c));
                    if(ItemPoolMAP.containsKey(items.Item_Pool__c)){
                        mapchecker +=items.Id;
                        ItemListMAP.put(items.Id, ItemPoolMAP.get(items.Item_Pool__c));
                    }
                    system.debug(ItemListMAP.size()+'  FINAL MAPPPPP  '+ItemListMAP);
                }
                ItemMAP.Put(items.id,items);
            } 
        
        }
        System.Debug('ItemMap.values:' + ItemMap);
        System.debug(ItemListMAP.size()+'  ITEM LISTSSSSSSS '+ItemListMAP);
    }
    
    // ----------------------------End of retrieving all the items for the selected event.--------------------------
    
    //show the ticket level and tickets based on the  parent question
    public PageReference showticketbasedonanswer()
    {
      try{
     System.debug('parentansid '+parentansid);
     BLN_Answer__c ans=[select id,name,BLN_Question__c from BLN_Answer__c where id=:parentansid];
     boolean flag=false;
     for(Item_Question__c itq:[select id,name,Question__c,Item__c,Item__r.item_name__c ,Question_Level__c from Item_Question__c where Question__c=:ans.BLN_Question__c])
     {
        if(itq.Question_Level__c=='Ticket Level')
        {
          if(flag==false)
          {
           itemnames=new List<SelectOption>();
           itemnames.add(new SelectOption('a089000000Mg123456','Select All' ));
           itemdisplaybool = TRUE;
           selectedquelevl= itq.Question_Level__c;
           flag=true;
          }
         itemnames.add(new SelectOption(itq.Item__c,itq.Item__r.item_name__c));
        }
        else
        {
          itemdisplaybool = FALSE;
          selectedquelevl= itq.Question_Level__c;
          break;
        }
     }
     }catch(Exception e){getitems();}
     return null;
    }
    
    //
    
    
    // ----------------------------This method is to get AnswerTypes options.--------------------------
    
    
    
    public List<SelectOption> getquetyps()
    {
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult = Question__c.Answer_Type__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          //if(f.getValue()!=null)
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
    
    // ----------------------------End Of getting AnswerTypes options.--------------------------
      
  
  
  public List<SelectOption> getquestionlevel()
    {
      List<SelectOption> questionoptions = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult = Item_Question__c.Question_Level__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          if(f.getValue()!='Lead Retrieval')
          questionoptions.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return questionoptions;
    }
  
  
    // method to save the reordered rows of survey questions
    public void myControllerMethod(){
        Id myId =System.currentPageReference().getParameters().get('recordId');
    }
    
     //Page Refreshing after save
    /*public PageReference saveRefreshAction(){
        String itemidTemp= Apexpages.Currentpage().getparameters().get('chkArray');
        PageReference page1 = new Pagereference('/apex/BLN_SurveyQuestions');
        page1.setRedirect(true);
        getquestionslist();
        return page1;
        
    } */
    //Method to cancel the question and refreshing page after cancel
    Public void cancelmethod(){
        createquestionbool = FALSE;
        displaytablebool = TRUE;
        editbool= FALSE;
        getquestionslist();
        
        //Refreshing page after cancel
        //PageReference page2 = new Pagereference('/apex/BLN_SurveyQuestions');//?core.apexpages.devmode.url=1
        //page2.setRedirect(true);
        //return page2 ;
    } 
   
      
  // ------------------------- This Method Is to Add A Question.-------------------------
  
    
    Public Void Addquestion(){
  
        selctdminscale = '1';
        selctdmaxscale = '5';
         
        try{
            getitems();
            getquestionlevel();
        }catch(Exception e){}
        
        CheckTicketsforedit = '!@#$%^&';
        CheckreqTicketsforedit  = '!@#$%^&';
         CheckvisTicketsforedit= '!@#$%^&';
        selectedtype = '';
        itemQuestionForEventlevel  = new Item_Question__c();
        
        questionslist = new List<Question__c>();
        questionrecord = new Question__c();
        answerslist = new List<BLN_Answer__c>();
        answerrecord = new BLN_Answer__c();
        answerMAP = new MAP<Decimal,BLN_Answer__c>();
        Itemquelist = new List<Item_Question__c>();
        dupselectedtype = new  Set<String>(); 
        ItemQuestionDupMAP = new MAP<String,Item_Question__c>();
        AnswerDupMAP = new MAP<String,BLN_Answer__c> ();
        deletedansonedit= new List<BLN_Answer__c>();
        
        questionrecord.Event__c = selectedeventid;
        questionrecord.Question_Order__c = QuestionMAP.size()+1;
        questionslist.add(questionrecord);
        selectedquelevl= 'Ticket Level'; 
        
        createquestionbool = TRUE;
        editbool = FALSE;
        itemdisplaybool = TRUE;
        displaytablebool = FALSE;
        System.debug('oooooooooooooooooooooo1:'+questionrecord.Question_Order__c);
        //getItemPools();
    
    }
    
    //Method to get all the tickets related to specific package:
    

  // ------------------------- End Of Adding A Question.-------------------------

//---------------------------------------Method  To add multiple Option based on answer type.****************************************------------------
    Public Void optionslabel(){
        String  del = apexpages.currentpage().getparameters().get('dupanschk');  
        if(selectedtype  == 'Scale'){
            selctdminscale = '1';
            selctdmaxscale = '5'; 
            dupselectedtype = new  Set<String>(); 
            answerslist.clear();
            uniqueNo = 0;
            multiplechoiceoptions = TRUE;
        }else if(selectedtype  == 'Single Selection' || selectedtype  == 'Checkboxes' || selectedtype  == 'Choose from a list'){
            dupselectedtype.clear();
            dupselectedtype.add(selectedtype);
            if(dupselectedtype.size()==1){
                answerrecord = new BLN_Answer__c(); 
                answerMAP.PUT(uniqueNo,answerrecord); 
                uniqueNo++;       
                answerslist.add(answerrecord);           
                multiplechoiceoptions= TRUE;                
            }else{
                dupselectedtype = new  Set<String>();
            }
        }else{
            uniqueNo = 0;
            answerslist.clear();  
            dupselectedtype = new  Set<String>(); 
            answerMAP = new MAP<Decimal,BLN_Answer__c>();
            multiplechoiceoptions = FALSE;
        } 
    }
    
    //Method to Adding Options
    public void addOptionsOnchange(){
        answerslist= new List<BLN_Answer__c>();
        optionslabel();   
    }
    
    
    //--------------------------------------End of Method  To add multiple Option based on answer type.------------------
    
    
    
    Public Void deleteoptionline(){
      
       String  del = apexpages.currentpage().getparameters().get('deletedid');
      
           System.debug('=================del del del : ' + del ); 
       
     
        BLN_SurveyQuestions_BAL blndelansoptionbal = New BLN_SurveyQuestions_BAL();
        answerMAP= blndelansoptionbal.deleteanswerline(del,answerMAP);
    
         answerslist= NEW LIST<BLN_Answer__c>();

      
          System.debug('answerMAP:' + answerMAP);
          Decimal Count = 0;
        
        for(BLN_Answer__c amap :  answerMAP.values()){
    
            answerslist.add(answerMAP.get(Count));
            Count++;
       }
          

         uniqueNo = answerslist.size();

          if(answerMAP.size() == 0){
                uniqueNo= -1;  
          }
      
    }
    
    //Method to save questions
    public String requiredid {get;set;}
     Public void savequestion(){
     
      String itemid= Apexpages.Currentpage().getparameters().get('chkArray'); 
      requiredid = Apexpages.Currentpage().getparameters().get('chkreqArray');
      System.debug('#######1'+requiredid );
      String visibleitemid = Apexpages.Currentpage().getparameters().get('chkvisArray');
       
       SYSTEM.DEBUG('CheckedTicketids' + itemid); 
       SYSTEM.DEBUG('CheckedReqTicketids' + requiredid );
        SYSTEM.DEBUG('WWWWWWWWWWWWWW  ' + visibleitemid);
        
       
        failuremessageset = new set<String>(); 
        
      SYSTEM.DEBUG('deletedansoneditdeletedansoneditdeletedansonedit  AnswerDupMAP '  + deletedansonedit);   
        
  
    
     BLN_SurveyQuestions_BAL blnansbal = New BLN_SurveyQuestions_BAL();
      answerslist = blnansbal.answeroptions(selectedtype,selctdminscale,selctdmaxscale,editbool,answerslist,AnswerDupMAP);
      System.debug('FFFFFF2:'+answerslist );
     
     
       if(editbool == TRUE){
        system.debug('AnswerDupMAPonEDit AnswerDupMAPonEDit: ' + AnswerDupMAP);
            BLN_SurveyQuestions_BAL blndelansopbal = New BLN_SurveyQuestions_BAL();
            failuremessageset = blndelansopbal.deleteansmethod(selectedtype,answerslist,AnswerDupMAP,deletedansonedit) ;
        
        }
        
     if(failuremessageset.size()==0){
      
      if(selectedquelevl == 'Ticket Level'){

     BLN_SurveyQuestions_BAL blnitemquebal = New BLN_SurveyQuestions_BAL();
     Itemquelist = blnitemquebal.itemquestions(itemid,requiredid,visibleitemid,editbool,Itemquelist,ItemQuestionDupMAP); 
        
       if(editbool == TRUE){
        
            BLN_SurveyQuestions_BAL blndelitemquebal = New BLN_SurveyQuestions_BAL();
            failuremessageset = blndelitemquebal.deletemethod(Itemquelist,ItemQuestionDupMAP) ;
        
        }
        
        if(failuremessageset.size() == 0){ 
      system.debug('1111111111dfdds ' + Itemquelist);
       
       questionslist[0].Answer_Type__c = selectedtype; 
       if(parentansid!='')  
       questionslist[0].BLN_Parent_Answer__c = parentansid; 
       //questionslist[0].Question_Order__c = 1;
       
       BLN_SurveyQuestions_BAL blnsavequebal = New BLN_SurveyQuestions_BAL();
       failuremessageset = blnsavequebal.upsertquestiosave(questionslist,answerslist,Itemquelist);
      
      if(failuremessageset.size()==0){
        Itemquelist = new List<Item_Question__C>();   
         getitems();
         System.Debug('ItemMap.values:' + ItemMap);
          for(BLN_Item__c  itm: ItemMap.values()){
                 Integer iqeorder = 1; 
                 System.Debug('itm.Item_Question__r' + itm.Item_Question__r);
                /*if(poolsList.size() >0) {
                    for(Item_Pool__c  ipool: ItemListMAP.get(itm.Item_Pool__c)){
                        iqeorder = 1; 
                        System.Debug('ipool.Item_Question__r' + ipool.Item_Question__r);
                    }
                }*/
               for(Item_Question__c iqe :itm.Item_Question__r){
               System.Debug('iqe iqe iqe :' + iqe );
                  iqe.IQ_Order__c=iqeorder;
                  Itemquelist.add(iqe);
                  iqeorder++;
               }  
                 
          }
          
          
        System.Debug('Itemquelist:' + Itemquelist);
         Database.Upsert(Itemquelist,false);
   
        
        
        
        
        
         if(failuremessageset.size()==0)
          {
            createquestionbool = FALSE;
            displaytablebool = TRUE;
            errormessagebool = FALSE;
            editbool= FALSE;
            getquestionslist(); 
          }
          
          else{
          errormessagebool = TRUE;
         }
       }   
        else{
          errormessagebool = TRUE;
         }
      }  
    }  
    
    
    else{
           
           system.debug('Itemquelist   wwww '+Itemquelist );
              
           if(editbool == TRUE){
           
            Itemquelist = new List<Item_Question__c>();
            BLN_SurveyQuestions_BAL blndelitemquebal = New BLN_SurveyQuestions_BAL();
            failuremessageset = blndelitemquebal.deletemethod(Itemquelist,ItemQuestionDupMAP) ;
           } 
            
          if(failuremessageset.size()==0)
          {
            Itemquerecord = new Item_Question__c();
            Itemquelist = new List<Item_Question__C>();
              Itemquerecord.Question_Level__c = selectedquelevl;
              Itemquerecord.Question__c = questionslist[0].id;
              Itemquerecord.Event__c = selectedeventid;
              Itemquerecord.isRequired__c= itemQuestionForEventlevel.isRequired__c;
               Itemquerecord.Visibility__c = itemQuestionForEventlevel.Visibility__c ;
              Itemquelist.add(Itemquerecord );        
              questionslist[0].Answer_Type__c = selectedtype;
              if(parentansid!='')  
              questionslist[0].BLN_Parent_Answer__c = parentansid; 
               BLN_SurveyQuestions_BAL blnsavequebal = New BLN_SurveyQuestions_BAL();
               failuremessageset = blnsavequebal.upsertquestiosave(questionslist,answerslist,Itemquelist);
               
                if(failuremessageset.size()==0)
          {
            createquestionbool = FALSE;
            displaytablebool = TRUE;
            errormessagebool = FALSE;
            editbool= FALSE;
            getquestionslist(); 
          }
          
          else{
          errormessagebool = TRUE;
         }
               
               
          }
          
         else{
          errormessagebool = TRUE;
         }
            
    }
    
    
    
    }
    
    
       else{
          errormessagebool = TRUE;
         } 
            
         //redirecting to same page after creating question event/ticket level
        //PageReference page2 = new Pagereference('/apex/BLN_SurveyQuestions');//?core.apexpages.devmode.url=1
        //page2.setRedirect(true);
        //return page2;
        
            
  }  
    
    public string Editpoolvalues{get;set;}
    public string Editpoolreqvalues{get;set;}
    public string Editpoolvisiblevalues{get;set;}
    
   Public Void editquestion(){
         Editpoolvalues = '';
         Editpoolreqvalues ='';
         Editpoolvisiblevalues ='';
         
         questionslist = new List<Question__c>();    
          QuestionMAP = new MAP<ID,Question__c>();
       BLN_SurveyQuestions_BAL blnquestionsbal = New BLN_SurveyQuestions_BAL();
        questionslist = blnquestionsbal.questionslist(selectedeventid,questionslist);

         for(Question__c que : questionslist){
               QuestionMAP.PUT(que.ID,que);
           }
      
      itemQuestionForEventlevel = new Item_Question__c();
      
       createquestionbool = TRUE;
       displaytablebool = FALSE;
        editbool= TRUE;
      
      
      
       questionslist = new List<Question__c>();
       questionrecord = new Question__c();
       answerslist= NEW LIST<BLN_Answer__c>();
       answerMAP=  new MAP<Decimal,BLN_Answer__c> ();
       AnswerDupMAP = new MAP<String,BLN_Answer__c> ();
       ItemQuestionDupMAP = new MAP<String,Item_Question__c>();
       Itemquelist = new LIST<Item_Question__c>();
       deletedansonedit  = new List<BLN_Answer__c>  ();
       selectedtype = '';
       getitems();
         
      
       String editquid = Apexpages.Currentpage().getparameters().get('editquid');
       SYSTEM.DEBUG('21324233 ' + editquid );
       questionrecord = QuestionMAP.get(editquid);
       //if(questionrecord.Answer_Type__c!=Null)
       selectedtype = questionrecord.Answer_Type__c;
       parentansid = questionrecord.BLN_Parent_Answer__c;
       SYSTEM.DEBUG('21324233questionrecord  ' + questionrecord);
        uniqueNo = 0;
        dupselectedtype = new Set<String>();
        dupselectedtype.add(selectedtype);
        Integer size = questionrecord.BLN_Answers__r.size();
        
        if(size>0){
        
        for(BLN_Answer__c answerrecord : questionrecord.BLN_Answers__r){
             AnswerDupMAP.PUT(answerrecord.Answer_Text__c,answerrecord ); 
         }
        
        }
        system.debug('AnswerDupMAPonEDit: ' + AnswerDupMAP);
        
        
        if(selectedtype == 'Scale'){
          multiplechoiceoptions = TRUE;
          
           selctdminscale = questionrecord.BLN_Answers__r[0].Answer_Text__c;
            selctdmaxscale = questionrecord.BLN_Answers__r[size-1].Answer_Text__c;
        }  
         
        else if(selectedtype  == 'Single Selection' || selectedtype  == 'Checkboxes' || selectedtype  == 'Choose from a list'  ){
        
                for(BLN_Answer__c answerrecord : questionrecord.BLN_Answers__r){
                
                    answerMAP.PUT(uniqueNo,answerrecord); 
                    uniqueNo++;       
                    answerslist.add(answerrecord); 
                }
                System.debug('FFFFFF1:'+answerslist);
                
            multiplechoiceoptions = TRUE;
                
        }
      else{
      
          multiplechoiceoptions = FALSE;
      
      } 
      
               // Itemquerecord.Question_Level__c = selectedquelevl;
      
      CheckTicketsforedit = '!@#$%^&';
      CheckreqTicketsforedit  = '!@#$%^&';
      CheckvisTicketsforedit = '!@#$%^&';
     
      list<Item_Question__c> editItemquerecord = new  List<Item_Question__c>();
      editItemquerecord = questionrecord.Item_Question__r;
      system.debug('editItemquerecord :' + editItemquerecord ); 
      selectedquelevl = '';
       selectedquelevl =editItemquerecord[0].Question_Level__c ;
            
              for(Item_Question__c iprecord : editItemquerecord )
               {
                if(iprecord.Question_Level__c == 'Ticket Level')
                {
                  
                 // for pools 
                  if(iprecord.Item_Pool__c!=null ){ 
                    Editpoolvalues += iprecord.Item_Pool__c+ '!@#$%^&'; 
                     ItemQuestionDupMAP.Put(iprecord.Item_Pool__c,iprecord);
                  if(iprecord.isRequired__c == TRUE)
                  { 
                      
                      Editpoolreqvalues+= iprecord.Item_Pool__c+ '!@#$%^&';
                  }
                   if(iprecord.Visibility__c == TRUE)
                  { 
                      Editpoolvisiblevalues+= iprecord.Item_Pool__c+ '!@#$%^&';
                  }
               }  
                   
                if(iprecord.Item__c!=null ){ 
                  CheckTicketsforedit += iprecord.Item__C + '!@#$%^&';
                  ItemQuestionDupMAP.Put(iprecord.Item__C,iprecord); 
                  
                  if(iprecord.isRequired__c == TRUE)
                  { 
                      CheckreqTicketsforedit += iprecord.Item__C + '!@#$%^&';
                  }
                   if(iprecord.Visibility__c == TRUE)
                  { 
                      CheckvisTicketsforedit += iprecord.Item__C + '!@#$%^&';
                  }
                }
                
                  itemdisplaybool = TRUE;
                  
                }   
                Else{
                  itemdisplaybool = FALSE;
                   ItemQuestionDupMAP.Put(iprecord.Event__C,iprecord); 
                   itemQuestionForEventlevel = iprecord;
                        
                  }
               }
      
      
      questionslist.add(questionrecord);
      

       useranswersMAP = new MAP<string,List<User_Answer__c>> ();
       
     if(itmqueansMap.get(editquid).size()>0){
      for(Item_Question__c iq : itmqueansMap.get(editquid)){
           
            LIST<User_Answer__c> listnew = new LIST<User_Answer__c>();
           
           for(User_Answer__c ui : iq.User_Answers__r){
           
                   listnew.add(ui); 
           }

            useranswersMAP.PUT(iq.item__c,listnew);
            
             
          }
      }     
  
     
     System.debug('useranswersMAP:' + useranswersMAP);
   
   }
   
   Public Void updateanswerslist(){
   answerslist= NEW LIST<BLN_Answer__c>();
   answerMAP = new MAP<Decimal,BLN_Answer__c>();
   uniqueno=0;
   String answeroptorder= Apexpages.Currentpage().getparameters().get('answeroptorder');
    SYSTEM.DEBUG('answeroptorder:answeroptorder' + answeroptorder);
    List<string> ansorder = new list<string>();
    ansorder = answeroptorder.split('-');
      SYSTEM.DEBUG('ansorder :ansorder ' + ansorder );

    for(string ans : ansorder){
          answerrecord = new BLN_Answer__c();
           answerrecord.Answer_Text__c = ans.replace('*&^%$','-');
                    answerMAP.PUT(uniqueNo,answerrecord);
                    uniqueNo++;
                    answerslist.add(answerrecord);
     }
     System.debug('DDDDDDDD::'+answerslist);
   }
    //method for updating row order in drag and drop case
    public String answeroptorder2{get;set;}{answeroptorder2='';}
    Public void updateanswerslist2(){
        isMove=true;
        System.debug('MMMMMMMMMMMMMMMM'+isMove);
        answeroptorder2= Apexpages.Currentpage().getparameters().get('answeroptorder2');
        System.debug('@@@@@@'+answeroptorder2);
        string[] splitted = answeroptorder2.split(' ');
        List<Question__c> srvqu=new List<Question__c>();
        //List<Question__c> srvqu1=new List<Question__c>();
        for(integer i=0;i<splitted.size();i++)
        {
             string[] ordersplit = splitted[i].split(',');

             Question__c q=new Question__c(id=ordersplit[0],Question_Order__c=Integer.valueOf(ordersplit[1]));
             srvqu.add(q);
             
        }
        update srvqu;
    }
    
  Public Void itemdisplay(){
           
      system.debug('11111221312' + selectedquelevl);
      if(selectedquelevl== 'Ticket Level'){
          itemdisplaybool = TRUE;
      }
      else{
          itemdisplaybool = FALSE;
      }
  } 
  
  public Integer queanscount;
  Public Void delquestion(){ 
        
        createquestionbool = FALSE;
        displaytablebool = TRUE;
        editbool= FALSE;
        
         Itemquelist = new LIST<Item_Question__c>();
         answerslist= NEW LIST<BLN_Answer__c>();
         
         String delquid = Apexpages.Currentpage().getparameters().get('delquid');
         queanscount= Integer.valueof(Apexpages.Currentpage().getparameters().get('queanscount'));
         questionrecord = QuestionMAP.get(delquid);
         
        
         questionslist = new list<Question__C>();
         questionslist.add(questionrecord);
         
         if(queanscount == 0){
          
          BLN_SurveyQuestions_BAL blndelquebal = New BLN_SurveyQuestions_BAL();
          failuremessageset = blndelquebal.deletemethod(questionslist);
          
          if(failuremessageset.size() == 0){
             
                  getquestionslist();
                  Integer queorder = 1;
                 for(Question__c qu : questionslist ){
                 
                     qu.Question_Order__c = queorder ;
                     queorder++;
                 
                 } 
              BLN_SurveyQuestions_BAL blnsavequebal = New BLN_SurveyQuestions_BAL();
              failuremessageset = blnsavequebal.upsertquestiosave(questionslist,answerslist,Itemquelist);
              if(failuremessageset.size() != 0){
                    errormessagebool = TRUE;
              }
              
          }
          else{
          
           errormessagebool = TRUE;
          }
          
        }
      else{
      
      getquestionslist();
      }   
         
          
         
    
   } 
   
   /*
   
   // Inner class for selecting package ticket for respective survey question usig checkbox
    public class inncls{
        public boolean selecetdValueInn {get;set;}
        public BLN_Item__c iteminn{get;set;}
        public SEt<string> strName {get;set;}
        public List<Item_pool__c> itemPoolsInn{get;set;}
        public item_pool__c itpool{get;set;}
        
        public inncls(BLN_Item__c it,List<Item_Question__c> iqList, List<Item_pool__c> pool){
            iteminn = new BLN_Item__c();
            itemPoolsInn = new  List<Item_pool__c>();
            this.itemPoolsInn  = pool;
            iteminn = it;
        }   
        
        public inncls(Item_pool__c it,List<Item_Question__c> iqList1){
            itpool = new item_pool__c();
            itpool =it;
        }

    } 
    
    
   //Put these above
   public MAP<id,List<Item_Question__c>> mapPoolWithIQset {get;set;}
   public MAP<id,item_pool__c> mapItempoolWithId {get;set;}
   public List<inncls> innclsListPool {get;set;}
   
   public MAP<id,List<Item_pool__c>> mapIdwithPools{get;set;}
   
    
    //Method to get all item pools related to package
   public List<inncls> getItemPools(){
      List<id> listOfpools = new List<id>();
      List<Item_Pool__c> aggPools = new List<Item_Pool__c >();
      mapPoolWithIQset = new MAP<id,List<Item_Question__c>>();
      mapItempoolWithId = new MAP<id,item_pool__c>();
      innclsListPool = new List<inncls>();
      List<Item_Question__c> agg = new List<Item_Question__c>();
        
     try{
      for(Id idsOfitem :mapIdwithPools.keySet() ){
        if(mapIdwithPools.get(idsOfitem)!=null){
           aggPools.addAll(mapIdwithPools.get(idsOfitem));
        }
      }
    
      for(Item_Pool__c itp :aggPools){
        listOfpools.add(itp.id);
      }
   
       agg = [select id,Event__c,Item__c,isRequired__c,Item_Pool__c,IQ_Order__c,Question__c,Question_Level__c,Visibility__c,item_pool__r.Package_Flag__c from Item_Question__c where (item_pool__c In :listOfpools) and event__c=:selectedeventid order by IQ_Order__c ASC];
          
          for(item_pool__c itp :aggPools){
           List<Item_Question__c> aggTemp = new List<Item_Question__c>();
           for(Item_Question__c iq :agg ){
             if(iq.item_pool__c  == itp.id){
               aggTemp.add(iq); 
             }
           }
           innclsListPool.add(new inncls(itp,aggTemp)); 
           mapPoolWithIQset.put(itp.id,aggTemp); 
           mapItempoolWithId.put(itp.id,itp);
         }
         
         return innclsListPool;
       } catch(exception rt){
         return null;
       }
    }
   */
}
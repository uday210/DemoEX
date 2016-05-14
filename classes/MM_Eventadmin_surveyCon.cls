public without sharing class MM_Eventadmin_surveyCon{

    

    public List<Option__c> liOfOptions { get; set; }
    public boolean isOptionsShow { get; set; }
    public boolean addSurveyQuetionbool{get;set;}
    public String eventId{get;set;}
    public List<Inncls> inn{get;set;}
    public MMQuestion__c pQuestion{get;set;}
    public boolean isConditionalQue{get;set;} 
    public MAP<id,List<Option__c>> mapQueWithOpts{get;set;}
    public MAP<id,MMQuestion__c> mapQueIdWithQue{get;set;}
    public MAP<id,Qaj__c> mapqajIdWithQue{get;set;}
    public List<Option__c> optionsDelete{get;set;}
    public boolean SetisEditbool{get;set; }
    public String selectedType{get;set; }
    public List<SelectOption> options{get;set;} 
    public String selectedOptionValue{get;set;}
    public Qaj__c qaj {get;set;}
    public string attendeealias {get ; set ;}
    public string exhibitoralias {get ; set ;}
    public list<Tags__c> tagslist {get; set ;}
   
    public MM_Eventadmin_surveyCon(){
          attendeealias ='';
      exhibitoralias ='';
           //eventId = ApexPages.currentPage().getParameters().get('id');
           tagslist  = new List<Tags__c>();
            Cookie k = ApexPages.currentPage().getCookies().get('counter');
            try{ 
             eventId  = k.getValue();
           }catch(exception es ){
             eventId = ApexPages.currentPage().getParameters().get('id');
           }
         isConditionalQue = false;
         
          tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventId ];
           for(Tags__c tt: tagslist ){
               if(tt.Default_Name__c == 'Attendee'){
                  attendeealias = tt.Alias_Name__c;
               }else if(tt.Default_Name__c == 'Exhibitor'){
                  exhibitoralias = tt.Alias_Name__c;
               }
          }
         
         
         
         firstMethod();
    }
      
      
    // In This method we are fetching all Questions and subQuestions   
    public void firstMethod(){
    try{
        MAP<id,List<Qaj__c>> mapoptIdWithQaj = new MAP<id,List<Qaj__c>>();
        mapQueWithOpts = new MAP<id,List<Option__c>>();
        mapQueIdWithQue = new MAP<id,MMQuestion__c>();
        inn = new List<Inncls>();
        mapqajIdWithQue = new MAP<id,Qaj__c> ();
        for(Option__c opt :[SELECT id,order__c,Question__c,(SELECT id,Question__c,Option__c,Question__r.Name,option__r.Name,Question__r.Type__c,Question__r.Whom__c from Qajs__r) from Option__c where Question__r.Events__c=:eventId]){
           mapoptIdWithQaj.put(opt.id,opt.Qajs__r);
           for(Qaj__c Q :opt.Qajs__r){
              mapqajIdWithQue.put(Q.id,Q); 
           }
        }

        for(MMQuestion__c que2 : [select id,Name,Order_No__c,Whom__c,Type__c,IsConditional__c,(select id,Name from Options__r) from MMQuestion__c where Events__c=:eventId order by Order_No__c]){
           List<Qaj__c> Qjs = new List<Qaj__c>();
           mapQueWithOpts.put(que2.id,que2.Options__r);
           mapQueIdWithQue.put(que2.id,que2);
          
           for(Option__c qj : que2.Options__r){
             if(null != mapoptIdWithQaj.get(qj.id)){
                Qjs.addAll(mapoptIdWithQaj.get(qj.id));
             }
           }
        if(que2.IsConditional__c){   
          
         } else{
            inn.add(new Inncls(que2,Qjs)); 
         }
        }
        system.debug('@check'+inn.size());
        }
     catch(exception ex){}   
    } 
    
    
    
    
   public List<Option__c> forDelete{get;set;}
   // For addign Parent survey Question     
    public PageReference addSurveyQuetion() {
    try{
      addSurveyQuetionbool =true;
      isConditionalQue = false;
      pQuestion = new MMQuestion__c();
      liOfOptions = new List<Option__c>();
      forDelete =new List<Option__c>();
       optionsDelete = new List<Option__c>();
       SetisEditbool =false;
        mapQtypeWithOpt = new MAP<string,List<Option__c>>();
       Qaj = new Qaj__c();
      
      }
      catch(exception ex){}
      return null;
    }


   
   public MAP<string,List<Option__c>> mapQtypeWithOpt{get;set;}
    // Handiling Options
    public PageReference addOptions() {
    try{
           optionsDelete = new List<Option__c>();
           optionsDelete.addAll(liOfOptions);
              
          if(pQuestion.type__c!='Text'){
              liOfOptions = new List<Option__c>();
                if(Qaj.id==null){
                     Qaj = new Qaj__c();
               }
              Option__c op = new Option__c();
              liOfOptions.add(op); 
              isOptionsShow = true;
           }else{
                liOfOptions = new List<Option__c>();
                if(Qaj.id==null){
                    Qaj = new Qaj__c();
                 }
                isOptionsShow = false;
            }
         
         if(null != mapQtypeWithOpt.get(pQuestion.Type__c)){
            liOfOptions = new List<Option__c>();
            liOfOptions.addAll(mapQtypeWithOpt.get(pQuestion.Type__c));
            isOptionsShow = true;
         }
         
     
      }
      catch(exception ex){}
       return null;
    }

   // "+" Button action 
    public void AddOpt(){
       Option__c op = new Option__c();
       liOfOptions.add(op); 
    }

   
    // "-" Button Action
    public PageReference deleteOpt() {
    try{
       integer co  = 0;
       System.debug('PPPPPPPPPPp '+Apexpages.currentPage().getParameters().get('count'));
        co = integer.valueOf(Apexpages.currentPage().getParameters().get('count'));
           if(co!=null){
             if(liOfOptions[co-1].id!=null){
                 forDelete.add(liOfOptions[co-1]); 
              }
             liOfOptions.remove(co-1);
              
           }
       
    }
catch(exception ex){}
 return null;
}

    public PageReference Cancel() {
    try{
      addSurveyQuetionbool =false;
        
        }
        catch(exception ex){}
        return null;
    }


   
   // Saving surevy Questions
    public PageReference saveQuestion() {
    try{
        pQuestion.Events__c=eventId;
        DataBase.upsertresult savres = DataBase.upsert(pQuestion,false);
         if(savres.isSuccess()){
            id qid = savres.getId();
             for(Option__c pio : liOfOptions){
                pio.Question__c = qid ;
              }
           DataBase.upsert(liOfOptions,false); 
            if(isConditionalQue){
              //if(pQuestion.type__c!='Text'){
                qaj.Question__c = qid ;
                qaj.Option__c =selectedOptionValue; 
                DataBase.upsert(qaj,false);
              }
            //} 
         }   
        if(forDelete.size()>0){
           DataBase.delete(forDelete,false);
        } 
         
        System.debug('AAAAAAAAAAAA '+selectedType +'    '+optionsDelete);
          if(pQuestion.type__c != selectedType){
           List<option__c> oopt = new List<option__c>();
            for(Option__c oi : optionsDelete){
             if(oi.id!=null){
               oopt.add(oi);
              }
            }
           if(oopt.size()>0){ 
             Database.delete(optionsDelete,false); 
          }
         }
        
        addSurveyQuetionbool =false;
       
        firstMethod();  
       
       }
       catch(exception ex){}
       return null;
    }

   // Deleting parent survey question
    public PageReference deletePQuestion() {
    try{
         string parentid = ApexPages.currentPage().getParameters().get('pidvalue');
           System.debug('PPPPPPPPPPPPP '+parentid );
          if(null != mapQueIdWithQue.get(parentid)){
             System.debug('PPPPPPPPPPPPP '+mapQueIdWithQue.get(parentid));
             DataBase.delete(mapQueIdWithQue.get(parentid),false);
          }
         firstMethod();  
        
        }
        catch(exception ex){}
        return null;
    }

   // Editing survey question
    public PageReference EditPQuestion() {
    try{
         string parentid = ApexPages.currentPage().getParameters().get('pidvalue');  
         forDelete = new List<Option__c>();
         pQuestion = new MMQuestion__c();
         liOfOptions = new List<Option__c>();
         mapQtypeWithOpt = new MAP<string,List<Option__c>>();
         optionsDelete = new List<Option__c>();
           
         pQuestion = mapQueIdWithQue.get(parentid);
         selectedType = mapQueIdWithQue.get(parentid).Type__c; 
         
         System.debug('QQQQQQQ '+pQuestion.Options__r);
           if(pQuestion.Options__r.size()>0 ){ 
              isOptionsShow = true;
               liOfOptions.addAll(pQuestion.Options__r);
               mapQtypeWithOpt.put(selectedType,pQuestion.Options__r); 
          }
          
        
         addSurveyQuetionbool =true; 
          
       
    }
    
    catch(exception ex){}
     return null;
    }
    
    
    //-- ------------------------------------------------------------ Sub Questions Actions ----------------------------
    
    //------------------------------------------- Add Conditional Question -------------------------------
     
      // Adding Sub question
       public void addCondition(){
       try{
           options = new List<SelectOption>();
           pQuestion = new MMQuestion__c();
           mapQtypeWithOpt = new  MAP<string,List<Option__c>>();
           optionsDelete = new List<Option__c>();
           
           string parentid = ApexPages.currentPage().getParameters().get('pidvalue');
              if(null != mapQueWithOpts.get(parentid)){
                 selectedOptionValue = mapQueWithOpts.get(parentid)[0].id;
                  pQuestion.whom__c =mapQueIdWithQue.get(parentid).whom__c;
              }
          for(Option__c optsValues : mapQueWithOpts.get(parentid)){
            options.add(new SelectOption(optsValues.id,optsValues.Name));
          }
           isConditionalQue = true;
           addSurveyQuetionbool =true;
           
           qaj = new Qaj__c();
          // pQuestion.whom__c = 'Conditional';
           pQuestion.IsConditional__c = true;
           liOfOptions = new List<Option__c>();
           forDelete = new List<Option__c>();
       }
       catch(exception ex){}
       }


       public void EditSQuestion(){
       try{
           options = new List<SelectOption>();
           liOfOptions = new List<Option__c>();
           forDelete = new List<Option__c>();
           mapQtypeWithOpt = new  MAP<string,List<Option__c>>();
           optionsDelete = new List<Option__c>();
           
           qaj = new Qaj__c();  
            String parentid = ApexPages.currentPage().getParameters().get('pidvalue'); 
            String qajId= ApexPages.currentPage().getParameters().get('sq');
             pQuestion = new MMQuestion__c(); 
              for(Option__c optsValues : mapQueWithOpts.get(parentid)){
                 options.add(new SelectOption(optsValues.id,optsValues.Name));
             }
            
              if(null != mapqajIdWithQue.get(qajId)){
                 selectedOptionValue = mapqajIdWithQue.get(qajId).Option__r.id; 
                 qaj  =  mapqajIdWithQue.get(qajId);
              }
              
              if(null!= mapQueWithOpts.get(mapqajIdWithQue.get(qajId).Question__c)){
                   pQuestion = mapQueIdWithQue.get(mapqajIdWithQue.get(qajId).Question__c); 
                   pQuestion.whom__c =mapQueIdWithQue.get(parentid).whom__c;
                   selectedType = mapQueIdWithQue.get(parentid).Type__c;
              }
              
              if(pQuestion.Options__r.size()>0 ){ 
                 isOptionsShow = true;
                 liOfOptions.addAll(pQuestion.Options__r);
                 mapQtypeWithOpt.put(selectedType,pQuestion.Options__r); 
             }
              
             isConditionalQue = true;
             addSurveyQuetionbool =true;
             
          }
          catch(exception ex){}    
      }




   public void deleteSQuestion(){
   try{
         string subQue = ApexPages.currentPage().getParameters().get('sq');  
          if(null != mapQueIdWithQue.get(subQue)){
             DataBase.delete(mapQueIdWithQue.get(subQue),false);
          }
         firstMethod();  
         }
         catch(exception ex){}
   }

    
    Public pagereference updateanswerslist2(){
    
            String  answeroptorderTemp= Apexpages.Currentpage().getparameters().get('answeroptorder2');
            
            System.debug('@@@@@@'+answeroptorderTemp);
            string[] splitted = answeroptorderTemp.split(' ');
            system.debug('=======splitted======'+splitted);
            map<id,MMQuestion__c > mapSurQues = new map<id,MMQuestion__c >();
            //List<Question__c> srvqu1=new List<Question__c>();
            for(integer i=0;i<splitted.size();i++)
            {   
                 string[] ordersplit = splitted[i].split(',');
                    system.debug('=====ordersplit===='+ordersplit[0]);
                 if(ordersplit[0]!=null && ordersplit[0]!=''){
                 MMQuestion__c  q= new MMQuestion__c (id=ordersplit[0],Order_No__c=Integer.valueOf(ordersplit[1]));
                 
                 mapSurQues.put(q.id,q);
            }
            try{                
                update mapSurQues.values();
            }
            catch(exception ex){}
            }
           firstMethod();
            pagereference pg= new pagereference('/apex/MM_Eventadmin_survey');      
     pg.setRedirect(true);  
     return pg; 
           
        }
            public class Inncls{
        public MMQuestion__c que{get;set;}
        public List<Qaj__c> subQuestions{get;set;}
        public Inncls(MMQuestion__c queIn,List<Qaj__c> subQuestions1){
           this.que = new MMQuestion__c();
           this.subQuestions =new List<Qaj__c>();
           if(queIn!=null){
           this.que=queIn; 
           }
           if(subQuestions1.size()>0){
             this.subQuestions =  subQuestions1;
           }
        }
    }

}
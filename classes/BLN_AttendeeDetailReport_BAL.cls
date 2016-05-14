/***********************************************************************************************
*   Controller Name : BLN_AttendeeDetailReport_BAL
*   Date            : 10/31/2014
*   Author          : Manasa Gandham
*   Purpose         : This class is to display the Attendee Details Report
*   Change History  : 10/31/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*    10/31/2014              Manasa Gandham                 To Create Page
*  
**************************************************************************************************/

public class  BLN_AttendeeDetailReport_BAL{

    public BLN_AttendeeDetailReport_BAL(){ } 
    public BLN_Item_Question_DAO itemQuestionDAOClass{get;set;}
    public BLN_Ticket_DAO ticketsDAOClass{get; set;}
    public BLN_Company_DAO companyDiversityDAOClass{get; set;}
    public BLN_UserAnswers_DAO userAnswersDAOClass{get; set;}
    public BLN_Company_Naicscodes_DAO companyNaicCodeClass{get; set;}
    public BLN_Reg_Settings_DAO regSetDao{get;set;}
    public integer maxQuestion{get;set;}
    public integer maxQuestionItem{get;set;}
    public integer maxQuestionItemPool{get;set;}
    
    public SET<Id> tid{get;set;}
    public SET<Id> itemIds{get;set;}
    public SET<Id> itemPoolIds{get;set;}
    public SET<Id> tktprofileId{get;set;}
    public SET<Id> tktpId{get;set;}
        
    public LIST<AttendeeDetailInner> ticketsListForEvent(LIST<Ticket__c> ticksList1,String EventId, Date FromDate, Date ToDate, String SearchString){
        
        ticketsDAOClass= new BLN_Ticket_DAO();
        companyDiversityDAOClass= new BLN_Company_DAO();
        userAnswersDAOClass= new BLN_UserAnswers_DAO();
        companyNaicCodeClass=new BLN_Company_Naicscodes_DAO();
        itemQuestionDAOClass =new BLN_Item_Question_DAO ();
        
        LIST<Ticket__c> ticksList= new LIST<Ticket__c>();
        ticksList= ticksList1;//ticketsDAOClass.ticketsListForEvent(EventId, FromDate, ToDate);
        
        tid= new SET<Id>();
        itemIds= new SET<Id>();
        itemPoolIds= new SET<Id>();
        tktprofileId= new SET<Id>();
        tktpId=new SET<ID>();
           
        MAP<id, LIST<Company_Diversity__c>> diversityListMAP= new MAP<id, LIST<Company_Diversity__c>>();
        
        for(Ticket__c tic: ticksList){
            tid.add(tic.id); 
            itemIds.add(tic.item__c);
            //if(tic.parent_id__c!=null && tic.item_type__r.name=='Package'){            
                itemPoolIds.add(tic.item_pool__c);
            //}
            tktprofileId.add(tic.tkt_profile__c);
            tktpId.add(tic.tkt_profile__c);
        }
        SET<id> bothIds=new set<id>();
        bothIds.addAll(itemIds);
        bothIds.addAll(itemPoolIds);
        
        //process to get saved naics codes
        MAP<id, List<Company_Naicscodes__c>> CompanyNaicCodeMAP= new MAP<id, List<Company_Naicscodes__c>>();
        LIST<Company_Naicscodes__c> CompanyNaicCodeList= new LIST<Company_Naicscodes__c>();
        CompanyNaicCodeList= companyNaicCodeClass.companyNAICSWithTKTPro(tktprofileId);
        System.debug('NNNCNCNC:'+CompanyNaicCodeList);       
        for(Company_Naicscodes__c  compNC : CompanyNaicCodeList){
            LIST<Company_Naicscodes__c> naicsList= new LIST<Company_Naicscodes__c>();
            if(CompanyNaicCodeMAP.containsKey(compNC.BLN_TKT_profile__c)){
                naicsList= CompanyNaicCodeMAP.get(compNC.BLN_TKT_profile__c);
                naicsList.add(compNC);
                CompanyNaicCodeMAP.put(compNC.BLN_TKT_profile__c, naicsList);
            }else{
                naicsList.add(compNC);
                CompanyNaicCodeMAP.put(compNC.BLN_TKT_profile__c, naicsList);
            }
        } 
        
        //reg setting foreach indivdual ticket
        regSetDao=new BLN_Reg_Settings_DAO();
        MAP<String, List<Reg_Setting__c>> rgsetMap= new MAP<String, List<Reg_Setting__c>> ();  
        LIST<Reg_Setting__c> rgsetlist= new LIST<Reg_Setting__c>();
        try{
        rgsetlist= regSetDao.bookedRegSettingList(bothIds,EventId);
        }catch(exception e){}
        system.debug('ERGRGRR:'+rgsetlist);
        for(Reg_Setting__c rg : rgsetlist){
            LIST<Reg_Setting__c> rgtemplist1= new LIST<Reg_Setting__c>();
            if(rgsetMap.containsKey(rg.item__c)){
                rgtemplist1= rgsetMap.get(rg.item__c);
                rgtemplist1.add(rg);
                rgsetMap.put(rg.item__c, rgtemplist1);
            }else{
                rgtemplist1.add(rg);
                rgsetMap.put(rg.item__c, rgtemplist1);
            }
            
            LIST<Reg_Setting__c> rgtemplist2= new LIST<Reg_Setting__c>();
            if(rgsetMap.containsKey(rg.item_pool__c)){
                rgtemplist2= rgsetMap.get(rg.item_pool__c);
                rgtemplist2.add(rg);
                rgsetMap.put(rg.item_pool__c, rgtemplist2);
            }else{
                rgtemplist2.add(rg);
                rgsetMap.put(rg.item_pool__c, rgtemplist2);
            }
        } 
        
        //Getting Diversity
        LIST<Company_Diversity__c> companyDiversityList= new LIST<Company_Diversity__c>();        
        companyDiversityList= companyDiversityDAOClass.diversityOntktprofile(tktpId);
        
        for(Company_Diversity__c div  : companyDiversityList){
            LIST<Company_Diversity__c> DivList= new LIST<Company_Diversity__c>();
            if(diversityListMAP.containsKey(div.BLN_TKT_profile__c)){
                DivList= diversityListMAP.get(div.BLN_TKT_profile__c);
                DivList.add(div);
                diversityListMAP.put(div.BLN_TKT_profile__c, DivList);
            }else{
                DivList.add(div);
                diversityListMAP.put(div.BLN_TKT_profile__c, DivList);
            }
        }
        
        //Getting only survey questions for respective ticket with/without user answers
        //item level questions
        /*MAP<Id, LIST<item_question__c>> itemQuestionsMAP= new MAP<Id, LIST<item_question__c>>();
        LIST<item_question__c> itemQuestionsList= new LIST<item_question__c>();
        itemQuestionsList= itemQuestionDAOClass.itemQuestionsForTickets(itemIds, EventId);
        
        for(item_question__c iq : itemQuestionsList){
            LIST<item_question__c> itmQueList= new LIST<item_question__c>();
            if(itemQuestionsMAP.containsKey(iq.Item__c)){
                itmQueList= itemQuestionsMAP.get(iq.Item__c);
                itmQueList.add(iq);
                itemQuestionsMAP.put(iq.Item__c, itmQueList);
            }else{
                itmQueList.add(iq);
                itemQuestionsMAP.put(iq.Item__c, itmQueList);
            }
        }
        
        //itempool survey questions
        MAP<Id, LIST<item_question__c>> itemQuestionsMAPPool= new MAP<Id, LIST<item_question__c>>();
        LIST<item_question__c> itemQuestionsListPool= new LIST<item_question__c>();
        itemQuestionsListPool= itemQuestionDAOClass.itemQuestionsForTickets(itemPoolIds, EventId);
        
        for(item_question__c q : itemQuestionsListPool){
             LIST<item_question__c> itmQueListpool= new LIST<item_question__c>();
            if(itemQuestionsMAPPool.containsKey(q.Item_pool__c)){
                itmQueListpool= itemQuestionsMAPPool.get(q.Item_pool__c);
                itmQueListpool.add(q);
                itemQuestionsMAPPool.put(q.Item_pool__c, itmQueListpool);
            }else{
                itmQueListpool.add(q);
                itemQuestionsMAPPool.put(q.Item_pool__c, itmQueListpool);
            }       
        } 
        
        //item level user answers
        MAP<Id, LIST<User_Answer__c>> userAnswersMAP= new MAP<Id, LIST<User_Answer__c>>();
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= userAnswersDAOClass.userAnswersForTickets(tid, itemIds, EventId);
        
        for(User_Answer__c ans : userAnswersList){
            LIST<User_Answer__c> userAnsList= new LIST<User_Answer__c>();
            if(userAnswersMAP.containsKey(ans.Item_Question__r.Item__c)){
                userAnsList= userAnswersMAP.get(ans.Item_Question__r.Item__c);
                userAnsList.add(ans);
                userAnswersMAP.put(ans.Item_Question__r.Item__c, userAnsList);
            }else{
                userAnsList.add(ans);
                userAnswersMAP.put(ans.Item_Question__r.Item__c, userAnsList);
            }
        }        
        
        //considering itempool user answers also
        MAP<Id, LIST<User_Answer__c>> userAnswersMAPPool= new MAP<Id, LIST<User_Answer__c>>();
        LIST<User_Answer__c> userAnswersListPool= new LIST<User_Answer__c>();
        userAnswersListPool= userAnswersDAOClass.userAnswersForTickets(tid, itemPoolIds, EventId);
        
        for(User_Answer__c ans: userAnswersListPool){
            //if(ans.UAnswer_Text__c!=Null){
                 LIST<User_Answer__c> userAnsListpool= new LIST<User_Answer__c>();
                if(userAnswersMAPPool.containsKey(ans.Item_Question__r.Item_pool__c)){
                    userAnsListpool= userAnswersMAPPool.get(ans.Item_Question__r.Item_pool__c);
                    userAnsListpool.add(ans);
                    userAnswersMAPPool.put(ans.Item_Question__r.Item_pool__c, userAnsListpool);
                }else{
                    userAnsListpool.add(ans);
                    userAnswersMAPPool.put(ans.Item_Question__r.Item_pool__c, userAnsListpool);
                }
            //}           
            } 
        
        maxQuestionItem=0;
        maxQuestionItemPool=0;*/
        LIST<LIST<AttendeeDetailInner>> AttendeeDetailInnerListOfList= new LIST<LIST<AttendeeDetailInner>>();        
        LIST<AttendeeDetailInner> AttendeeDetailInnerList999= new LIST<AttendeeDetailInner>();
        for(Ticket__c tic: ticksList){
            
           /* LIST<item_question__c> itmQueParentList= new LIST<item_question__c>(); 
            LIST<User_Answer__c> userAnsParentList= new LIST<User_Answer__c>();
            
            //item level survey questins
            LIST<item_question__c> itemQueList= new LIST<item_question__c>();
            LIST<item_question__c> iqList= new LIST<item_question__c>();  
            if(itemQuestionsMAP.get(tic.item__c) != NULL){ 
                itemQueList= itemQuestionsMAP.get(tic.item__c);         
                for(item_question__c q : itemQueList){
                    if(tic.item__c== q.item__c){
                        iqList.add(q);
                    }
                }
            }
            
            //item pool level survey questions
            LIST<item_question__c> itemPoolQueList= new LIST<item_question__c>();
            LIST<item_question__c> qListPool= new LIST<item_question__c>();  
            if(itemQuestionsMAPPool.get(tic.item_pool__c) != NULL && tic.parent_id__c!=null){ 
                itemPoolQueList= itemQuestionsMAPPool.get(tic.item_pool__c);         
                for(item_question__c q: itemPoolQueList){
                    if(tic.item_pool__c== q.item_pool__c){
                        qListPool.add(q);
                    }
                }
            }
            
             
            //item level user answers
            LIST<User_Answer__c> itemAnsList= new LIST<User_Answer__c>();
            LIST<User_Answer__c> userAnsList= new LIST<User_Answer__c>();  
            if(userAnswersMAP.get(tic.item__c) != NULL){ 
                itemAnsList= userAnswersMAP.get(tic.item__c);         
                for(User_Answer__c ans: itemAnsList){
                    if(tic.id== ans.ticket__r.id){
                        userAnsList.add(ans);
                    }
                }
            }
            
            //item pool level user answers
            LIST<User_Answer__c> itemPoolAnsList= new LIST<User_Answer__c>();
            LIST<User_Answer__c> userAnsListPool= new LIST<User_Answer__c>();  
            if(userAnswersMAPPool.get(tic.item_pool__c) != NULL && tic.parent_id__c!=null){ 
                itemPoolAnsList= userAnswersMAPPool.get(tic.item_pool__c);         
                for(User_Answer__c ans: itemPoolAnsList){
                    if(tic.id== ans.ticket__r.id){
                        userAnsListPool.add(ans);
                    }
                }
            }
            
            //item questions             
            if(iqList.size()>0)
                itmQueParentList.addAll(iqList);  
            
            if(qListPool.size()>0 )
                itmQueParentList.addAll(qListPool); 
            
            
            //user answers              
            if(userAnsList.size()>0)
                userAnsParentList.addAll(userAnsList);  
            
            if(userAnsListPool.size()>0 )
                userAnsParentList.addAll(userAnsListPool);
                
            //getting max no. of survey questions for each ticket
            if(maxQuestionItem < iqList.size()){
                maxQuestionItem =iqList.size();
            }else{
                maxQuestionItem=maxQuestionItem;
            }
            
            System.debug('xxxxxx'+maxQuestionItem);
            
            if(maxQuestionItemPool < qListPool.size()){
                maxQuestionItemPool=qListPool.size();
            }else{
                maxQuestionItemPool=maxQuestionItemPool;
            }
            System.debug('yyyyyy'+maxQuestionItemPool);*/
           
            AttendeeDetailInnerList999.add(new AttendeeDetailInner(tic, diversityListMAP.get(tic.TKT_Profile__c),new LIST<item_question__c>(),new LIST<User_Answer__c>(),CompanyNaicCodeMAP.get(tic.TKT_Profile__c), rgsetMap.get(tic.item__c),rgsetMap.get(tic.item_pool__c)));
            
        }
        
          /*  if(AttendeeDetailInnerList999.size() == 999){
                AttendeeDetailInnerListOfList.add(AttendeeDetailInnerList999);
                AttendeeDetailInnerList999= new LIST<AttendeeDetailInner>();
            }
        
        if(AttendeeDetailInnerList999.size() != NULL){
                AttendeeDetailInnerListOfList.add(AttendeeDetailInnerList999);
                AttendeeDetailInnerList999= new LIST<AttendeeDetailInner>();
            }
        
        return AttendeeDetailInnerListOfList;*/
        return AttendeeDetailInnerList999;
        }
        
        public Class AttendeeDetailInner{
            public LIST<item_question__c> itmQue{get;set;}
            public LIST<User_Answer__c> uans{get;set;}
            public Ticket__c ticketData{get; set;}
            public LIST<Company_Diversity__c> companyDiversityData{get; set;}
            public List<Company_Naicscodes__c> companyNaicsCode {get; set;}
            public LIST<Reg_Setting__c> regSetData{get; set;}
            public LIST<Reg_Setting__c> regSetDataPool{get; set;}
            public String createdon{get;set;}
            
            public AttendeeDetailInner(Ticket__c ticketData, LIST<Company_Diversity__c> companyDiversityData,LIST<item_question__c> itmQue, LIST<User_Answer__c> uans, List<Company_Naicscodes__c>  companyNaicsCode, LIST<Reg_Setting__c> regSetData,LIST<Reg_Setting__c> regSetDataPool){
                
                this.ticketData= ticketData;
                this.companyDiversityData= companyDiversityData;
                this.itmQue= itmQue;
                this.uans= uans;
                this.companyNaicsCode= companyNaicsCode;
                this.regSetData= regSetData;
                this.regSetDataPool= regSetDataPool;
                BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                tz.tZone=ticketData.Event__r.Time_Zone__c;
                tz.format='MM/dd/yyyy hh:mm a';
                tz.dateTimeValue=ticketData.Order__r.CreatedDate;
                this.createdon=tz.getTimeZoneValue();
            }
        }
}
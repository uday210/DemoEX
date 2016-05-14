public with sharing class BLN_LeadRetrieval_BAL {
   
     public Lead_Scan__c insertLead(Ticket__c tct,String loginId,String EventId,String CompId , Datetime stime){
      List<Company_Ext__c> compExt = new  List<Company_Ext__c>();
        BLN_Leadscan_DAO lsDao = new BLN_Leadscan_DAO();
       Lead_Scan__c lscan = new Lead_Scan__c();
       //if(tct.Tkt_profile__r.BLN_Company__c!=null)
          //  compExt = [SELECT BLN_Business_Country__r.Long_Name__c,BLN_Business_State__r.Long_Name__c,BLN_Business_Country__c,BLN_Business_State__c,Blog_URL__c,Business_Address1__c,Business_Address2__c,Business_City__c,Business_Zipcode__c,Company__c,CreatedById,CreatedDate,Duns_Number__c,Established_Date__c,Id,Keywords__c,Name,Number_Of_Employees__c,Primary_Business_Category__c,Primary_NAICS_Code__c,Revenue__c,Secondary_Business_Category__c,Secondary_NAICS_Code__c,Tax_Id__c,Work_Phone__c FROM Company_Ext__c where Company__c =:tct.Tkt_profile__r.BLN_Company__c];
       // if(compExt.size()>0){
           lscan.City__c  = tct.Tkt_profile__r.Work_Address__r.City__c;
           /*Lscan.Country__c =   compExt[0].BLN_Business_Country__r.Long_Name__c;
           Lscan.State__c =compExt[0].BLN_Business_State__r.Long_Name__c;
           system.debug('compExt[0].BLN_Business_State__r.Long_Name__c'+compExt[0].BLN_Business_State__r.Long_Name__c);*/
           Lscan.BLN_Country__c =   tct.Tkt_profile__r.Work_Address__r.Country__c;
           lscan.BLN_State__c =tct.Tkt_profile__r.Work_Address__r.State__c;
           lscan.Street1__c =tct.Tkt_profile__r.Work_Address__r.Address1__c;
           lscan.Street2__c =tct.Tkt_profile__r.Work_Address__r.Address2__c;
           lscan.Work_Phone__c  = tct.Tkt_profile__r.Work_Phone__c; 
           lscan.Zip__c =tct.Tkt_profile__r.Work_Address__r.Zipcode__c;
        //}

        lscan.Cell_Phone__c =tct.Tkt_profile__r.Mobile__c;   
        lscan.Lead_Email__c=tct.Tkt_profile__r.Email__c;
        lscan.BLN_TKT_profile__c=tct.Tkt_profile__c;
        if(EventId!=null && EventId!='')
        lscan.Event__c = EventId;
        if(tct.Tkt_profile__r.TKT_Company__c!=null)
        lscan.Company__c  = tct.Tkt_profile__r.TKT_Company__c;
        lscan.First_Name__c = tct.Tkt_profile__r.First_Name__c;
        lscan.Last_Name__c =tct.Tkt_profile__r.Last_Name__c;
        //lscan.Followup_date__c = null;
        lscan.Prefix__c = tct.Tkt_profile__r.Prefix__c;
        lscan.Home_Phone__c = tct.Tkt_profile__r.Home_Phone__c;
        lscan.LeadSource__c = 'Boothleads';
        //lscan.Notes__c = 
        //lscan.Rating__c
        if(CompId!=null && CompId!='')
        lscan.Scanner_Company__c = CompId;
        if(loginId!=null && loginId!='')
        lscan.Scanner_User__c = loginId;
        if(stime!=null){
          //BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
          //String myDate = stime.formatGMT('MM/dd/yyyy hh:mm a');        
          //lscan.Scan_Time__c = timezonecl.getDateBasedOnEventTimeZone(myDate,EventId);
          
        lscan.Scan_Time__c =  stime;
        }

        lscan.Suffix__c =tct.Tkt_profile__r.Suffix__c;
        lscan.User_pic__c = tct.Tkt_profile__r.User_pic__c;
        
        if(tct.Tkt_profile__r.TKT_Job_Title__c != null & tct.Tkt_profile__r.TKT_Job_Title__c != '')
        lscan.Title__c= tct.Tkt_profile__r.TKT_Job_Title__c;
        
        DataBase.saveResult saveres = DataBase.insert(lscan,false);
        if(saveres.IsSuccess()){
          return lsDao.leadsValue(saveres.getId())[0];
        }else{
          return null;
        }
   }
/*************************************************************/
    public DataBase.saveResult[] insertLead(list<Ticket__c> tct,String loginId,String EventId ,string compId ,list<Datetime> stime){
    system.debug('-------------ticket list-------'+tct.size());
      List<Company_Ext__c> compExt = new  List<Company_Ext__c>();
      BLN_Leadscan_DAO lsDao = new BLN_Leadscan_DAO();
      list<Lead_Scan__c> lscan = new list<Lead_Scan__c>(); 
      integer i=0;           
      for(Ticket__c t:tct)
      {
       
        Lead_Scan__c ce = new Lead_Scan__c();
        ce.City__c = t.Tkt_profile__r.Work_Address__r.City__c;
        ce.BLN_Country__c = t.Tkt_profile__r.Work_Address__r.Country__c;
        ce.BLN_State__c = t.Tkt_profile__r.Work_Address__r.State__c;
        ce.Street1__c = t.Tkt_profile__r.Work_Address__r.Address1__c;
        ce.Street2__c =t.Tkt_profile__r.Work_Address__r.Address2__c; 
        ce.Work_Phone__c  = t.Tkt_profile__r.Work_Phone__c;   
        ce.Zip__c = t.Tkt_profile__r.Work_Address__r.Zipcode__c; 
        ce.Cell_Phone__c = t.Tkt_profile__r.Mobile__c;   
        ce.Lead_Email__c = tct[i].Tkt_profile__r.Email__c;
        ce.BLN_TKT_profile__c = t.Tkt_profile__c;
        ce.LeadSource__c = 'Boothleads';
        if(EventId!=null && EventId!='')
            ce.Event__c = EventId;
        if(t.Tkt_profile__r.TKT_Company__c!=null)    
            ce.Company__c  = t.Tkt_profile__r.TKT_Company__c;
            
        ce.First_Name__c = t.Tkt_profile__r.First_Name__c;
        ce.Last_Name__c =t.Tkt_profile__r.Last_Name__c;
        ce.Prefix__c = t.Tkt_profile__r.Prefix__c;
        ce.Home_Phone__c = t.Tkt_profile__r.Home_Phone__c;   
        
        if(CompId!=null && CompId!='')
            ce.Scanner_Company__c = CompId;
        if(loginId!=null && loginId!='')
            ce.Scanner_User__c = loginId;
        if(stime.size()>0)
        {         
            ce.Scan_Time__c =  stime[i];
        }
        ce.Suffix__c =t.Tkt_profile__r.Suffix__c;
        ce.User_pic__c = t.Tkt_profile__r.User_pic__c;
        ce.Lead_Status__c = 'Active';
        if(t.Tkt_profile__r.TKT_Job_Title__c != null & t.Tkt_profile__r.TKT_Job_Title__c != '')
            ce.Title__c= t.Tkt_profile__r.TKT_Job_Title__c;
       
        lscan.add(ce); 
        i++;       
   }
   system.debug('@@@lscan'+lscan);
   DataBase.saveResult[] saveres = DataBase.insert(lscan,false);    
   system.debug('----------save result-------------'+saveres ); 
   return saveres;
   /*********************************************************/
}  
 public boolean deleteLead(String lid){
    BLN_Leadscan_DAO lsDao = new BLN_Leadscan_DAO();
    List<Lead_Scan__c> leads = new List<Lead_Scan__c>();
    leads =lsDao.leadsValue(lid); 
      if(leads.size()>0){
        leads[0].Lead_Status__c = 'Deleted';   
        Database.saveResult dsaveres =  lsDao.UpdateLead(leads[0]);
         if(dsaveres.IsSuccess())
          return true;        
         else
          return false;  
      }else{
         return false;
      }
  }
  
   public transient BLN_LeadScan_DAO lsDAO{get; set;}
    public transient list<Lead_Scan__c> leadlist{get;set;}
    public BLN_Item_Question_DAO iqDAO{get;set;}
    public transient LIST<Item_Question__c> qlist{get;set;}
    public MAP<ID,Lead_Scan__c> showleadMap{get;set;}
    public transient list<leaddetails> leaddetailscls{get;set;}
    public transient BLN_Company_Ext_DAO compExtDAO1{get;set;}
    public transient list<BLN_LeadRetrieval_BAL.qaclass> qacls1{get;set;}
    public transient set<string> ti{get;set;}
    public list<Item_Question__c> qlst{get;set;}
    public Lead_Scan__c showlead{get;set;}
    public list<qaclass> qacls{get;set;}
    public transient List<String> listOfintegers1{get;set;}
    public BLN_Company_Ext_DAO compExtDAO{get;set;}
    public transient LIST<Company_Ext__c> compext {get;set;}
    public BLN_Device_Usage_DAO deviceusage{get;set;}
    public Device_Usage__c devicelist{get;set;}
    public set<string> mailid{get;set;}
    public transient BLN_RegistrationSettings_BAL regbal{get;set;}  
    public transient list<Reg_Setting__c> regset{get;set;} 
    public String checkUnion{get;set;}
    public transient list<Reg_Setting__c> reg{get;set;}
    public LIST<Lead_Scan__c> leadeditlist{get;set;}
    public map<Question__c,User_Answer__c> editqaMap{get;set;}
    public list<editqaclass> editqacls{get;set;}
    public transient document mydoc{get;set;}
    public Lead_Scan__c delLead{get;set;}
    public BLN_LeadScan_DAO lsDAOforEdit{get; set;}
   //method to get lead details
   public void maintableVals(string selectedeventid,LIST<Lead_Scan__c> leadlist){
         
        iqDAO = new BLN_Item_Question_DAO();
        qlist = iqDAO.questionsforLeads(selectedeventid);
        leaddetailscls = new LIST<leaddetails>();
        ti=new set<string>();
        set<id> compid=new set<id>();
        
        /*for(Lead_Scan__c l:leadlist){
            //compid.add(l.Scanee_User__r.Default_Company_ID__c);
            compid.add(l.BLN_TKT_profile__r.BLN_Company__c);
        }
        compExtDAO1 =new BLN_Company_Ext_DAO();
            LIST<Company_Ext__c> compext3 = new LIST<Company_Ext__c>();
            compext3  = compExtDAO1.companyExtsForCompanyIds(compid);
            
            map<id,Company_Ext__c> compmap =new map<id,Company_Ext__c>();
            for(Company_Ext__c c:compext3){
                compmap.put(c.Company__c,c);
            } */
        for(Lead_Scan__c l:leadlist)
        {
        //ti.add(l.Scanee_User__r.Email__c);
        ti.add(l.BLN_TKT_profile__r.Email__c);
        
        qacls1= new list<BLN_LeadRetrieval_BAL.qaclass>();
             for(Item_Question__c q:qlist){
                        if(q.Question__r.owner.Email==l.Scanner_User__r.Email__c)
                            for(User_Answer__c u:q.User_Answers__r){
                                if(u.ticket__r.TKT_profile__c==l.BLN_TKT_profile__c){
                                    //qaMap.put(q.Question__r.Question_Text__c,u.UAnswer_Text__c);
                                    qacls1.add(new BLN_LeadRetrieval_BAL.qaclass(q.Question__r.Question_Text__c,u.UAnswer_Text__c));
                                }
                             }
              }
            Company_Ext__c compext4 = new Company_Ext__c();
            List<String> listOfintegers = new  List<String>();
            integer i =50;
            integer ratingvalue=  integer.valueOf(l.Rating__c);
            string strofimageurl1 ;
            for (Integer z = 1; z <= 5; z++) { 
                strofimageurl1 ='/resource/'; 
                strofimageurl1  += (z <= ratingvalue) ? '1436438740000/yellowstar' : '1436439431000/whitestar'; 
                listOfintegers.add(strofimageurl1);
            }
             string stime='';       
                 if(l.scan_time__c != null){        
                     BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();        
                     tz.tZone=l.Event__r.Time_Zone__c;      
                     tz.format='MM/dd/yyyy hh:mm a';        
                     tz.dateTimeValue=l.scan_time__c;       
                     stime=tz.getTimeZoneValue();       
                 }else{     
                     stime=null;        
                 }      
                        
             string fdt='';
             if(l.followup_date__c != null){           
             fdt=l.followup_date__c.formatGMT('MM/dd/YYYY hh:mm a');  
             }
                        
            leaddetailscls.add(new leaddetails(l,qacls1,compext4,listOfintegers,stime,fdt));      
        } 
        leadlist = new LIST<lead_scan__c>();
   }
   //method for view lead details
   public void showleaddetails(string showLeadID,string selectedeventid) {
        qlst =new list<Item_Question__c>();
                lsDAO = new BLN_LeadScan_DAO();
                showlead = lsDAO.getLeadScan(selectedeventid,' AND id =\''+showLeadID+'\'')[0];
                qacls= new list<qaclass>();
                list<Item_Question__c> qlist = new list<Item_Question__c>();
                iqDAO = new BLN_Item_Question_DAO();
                qlist = iqDAO.questionsforLeads(selectedeventid);
                for(Item_Question__c q:qlist){
                    if(q.Question__r.owner.Email==showlead.Scanner_User__r.Email__c)
                        for(User_Answer__c u:q.User_Answers__r){
                            
                            if(u.ticket__r.TKT_profile__c==showlead.BLN_TKT_profile__c){
                                qacls.add(new BLN_LeadRetrieval_BAL.qaclass(q.Question__r.Question_Text__c,u.UAnswer_Text__c));
                            }
                        }
                }
                listOfintegers1 = new  List<String>();
                integer i =50;
                integer ratingvalue=0;
                if(showlead.Rating__c!=null){
                ratingvalue=  integer.valueOf(showlead.Rating__c);
                }
                string strofimageurl1 ;
                for (Integer z = 1; z <= 5; z++) { 
                strofimageurl1 ='/resource/'; 
                strofimageurl1  += (z <= ratingvalue) ? '1436438740000/yellowstar' : '1436439431000/whitestar'; 
                listOfintegers1.add(strofimageurl1);
 
                }

       try{
            compExtDAO =new BLN_Company_Ext_DAO();
            compext = new LIST<Company_Ext__c>();
            set<ID> cid= new set<ID>();
            //if(showlead.Scanee_User__r.Default_Company_ID__c != null){
            //cid.add(showlead.Scanee_User__r.Default_Company_ID__c);
            if(showlead.BLN_TKT_profile__r.BLN_Company__c != null){
            cid.add(showlead.BLN_TKT_profile__r.BLN_Company__c);
                if(cid.size()>0)
            compext  = compExtDAO.companyExtsForCompanyIds(cid);
            }
            

        deviceusage= new BLN_Device_Usage_DAO();
        LIST<Device_Usage__c> devicelisttemp =  deviceusage.getDeviceUsage(selectedeventid);
        for(Device_Usage__c du:devicelisttemp){
            //if(du.User__c == showlead.Scanee_User__c ){
            if(du.BLN_TKT_profile__c== showlead.BLN_TKT_profile__c){
            devicelist = du;
            }
        }
        }catch(exception e){}
        mailid=new set<string>();
        //mailid.add(showlead.Scanee_User__r.Email__c);
        mailid.add(showlead.BLN_TKT_profile__r.Email__c);
   }
   //method to get Registration settings
   public void getreg(set<string> em,string selectedeventid){
        //LIST<ticket__c>  tlist =[SELECT id,Item__r.id from ticket__c where Client_GN_User__r.Email__c=:em AND event__c =:selectedEventid];  
        LIST<ticket__c>  tlist =[SELECT id,Item__r.id from ticket__c where TKT_profile__r.Email__c=:em AND event__c =:selectedEventid];  
        set<id> ticID=new set<id>();
         for(ticket__c t:tlist){
             ticID.add(t.item__r.ID);
         }
        regbal=new BLN_RegistrationSettings_BAL();
        MAP<ID,List<Reg_Setting__c>> regmap=regbal.getTicketSettings(ticID,selectedeventid);
        reg=new list<Reg_Setting__c>();
        checkUnion='';
        for(id i:ticID){
            reg=regmap.get(i);
            for(Reg_Setting__c rgs : reg){
                if(rgs.Included__c==true){
                    checkUnion+=rgs.Label_Name__c+',';    
                }
            }
        }
   }
   //method to edit lead
   public void editLeadMethod(string selectedeventid,string showEditLeadID){
               lsDAOforEdit = new BLN_LeadScan_DAO();
               string condition=' AND id=\'' + showEditLeadID + '\'';
               leadeditlist = lsDAOforEdit.getLeadScan(selectedeventid,condition);
                    editqaMap = new map<Question__c,User_Answer__c>();
                    editqacls= new list<BLN_LeadRetrieval_BAL.editqaclass>();
                list<Item_Question__c> qlist = new list<Item_Question__c>();
                iqDAO = new BLN_Item_Question_DAO();
                qlist = iqDAO.questionsforLeads(selectedeventid);
                for(Item_Question__c q:qlist){
                    if(q.Question__r.owner.Email==leadeditlist[0].Scanner_User__r.Email__c){
                        for(User_Answer__c u:q.User_Answers__r){
                            //if(u.User__c==leadeditlist[0].Scanee_User__c){
                            if(u.ticket__r.TKT_profile__c==leadeditlist[0].BLN_TKT_profile__c){
                                editqacls.add(new BLN_LeadRetrieval_BAL.editqaclass(q.Question__r,u));
                            }
                         }
                     }
                }
   }
   //method to save edited lead
  // public void savemethod(integer selectedRating,string selectedCountry,string selectedState,Blob leadPic,String leadImageName){
   //public void savemethod(integer selectedRating,Blob leadPic,String leadImageName){
   public void savemethod(integer selectedRating,Blob leadPic,String leadImageName,string selectedeventid,string followupdate,boolean isdelete){
       if (leadPic != NULL && (leadImageName != '' || leadImageName != NULL)) {
          if (leadPic.size() != null) {  
             mydoc = new document();
             mydoc.body = leadPic;
             mydoc.folderid = UserInfo.getUserId();
             mydoc.ispublic = true;
             mydoc.Name = leadImageName;
             insert mydoc;
             leadeditlist[0].User_Pic__c = mydoc.id;
          }
            else if(isdelete == true){
          leadeditlist[0].User_Pic__c = null;
       }  
       }
         else if(isdelete == true){
          leadeditlist[0].User_Pic__c = null;
       }  
       
        if(followupdate!=null && followupdate != ''){
        system.debug('followupdate'+followupdate);
        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();                  
        //leadeditlist[0].followup_date__c= timezonecl.getDateBasedOnEventTimeZone(followupdate,selectedeventid); 
        leadeditlist[0].followup_date__c= timezonecl.getDateBasedOnEventTimeZone(followupdate,'GMT'); 
        }
       
        leadeditlist[0].rating__c=selectedRating ;
        //leadeditlist[0].country__c=selectedCountry;
        //leadeditlist[0].state__c=selectedState;
        update leadeditlist[0];
        
        for(editqaclass e:editqacls){
            Question__c qu=new Question__c();
            qu =e.q1;
            update qu;
            User_Answer__c us=new User_Answer__c();
            us=e.u1;
            update us;
       }
   } 
   public class qaclass{
        public string que{get;set;}
        public string ans{get;set;}
        public qaclass(string qu,string an){
            que=qu;
            ans=an;
        }
    }
    public class editqaclass{
        public Question__c q1{get;set;}
        public User_Answer__c u1{get;set;}
        public editqaclass(Question__c q,User_Answer__c u){
            q1=q;
            u1=u;
        }
    }
    public class leaddetails{
        public Lead_Scan__c ls{get;set;}
        public LIST<qaclass> qc{get;set;}
        public Company_Ext__c compext1{get;set;}
        public List<String> loi{get;set;} 
        public string scantime{get;set;}
        public string fdate{get;set;}
        public leaddetails(Lead_Scan__c ls1,LIST<qaclass> qc1,Company_Ext__c compext2,List<String> loi1,string scantime1,string fdate1){
            ls=ls1;
            qc=qc1;
            compext1=compext2;
            loi=loi1;
            scantime=scantime1;
            fdate=fdate1;
        }
   }
}
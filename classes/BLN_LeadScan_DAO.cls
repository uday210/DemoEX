public with sharing class BLN_LeadScan_DAO {
    
    //Getting Leads for an Event
   public List<Lead_Scan__c> getLeadScan(String eventId,string condition){
        List<string> scannerID =new List<string>();
        scannerID.add(UserInfo.getUserId());
        SET<string> grpsIDs = new SET<string>();
        BLN_UCRole_DAO ucroledao = new BLN_UCRole_DAO();
        // By Phani
         for(UC_Role__c ucr : ucroledao.getUcroles(eventId)){
            grpsIDs.add(ucr.BLN_Group__c);
         }
         for(UC_Role__c ucr : ucroledao.getUcroles(eventId,grpsIDs)){
           scannerID.add(ucr.GN_User__r.User__c );
         }
        
        //BLN_Event__c eve=[select Organizer_Email__c,owner.email from BLN_Event__c  where id =:eventId];
        string querystring ='';
        
        /*if(eve.Organizer_Email__c==UserInfo.getUserEmail()||eve.owner.email==UserInfo.getUserEmail()){
        //querystring='SELECT First_Name__c,Lead_Email__c,title__c,Scanee_User__r.Default_Company_ID__c,Scanee_User__r.Age__c,Scanee_User__r.Prefix__c,Scanee_User__r.Suffix__c,Scanee_User__r.DOB__c,Scanee_User__r.Gender__c,Scanee_User__r.Address1__c,Scanee_User__r.Address2__c,Scanee_User__r.City__c,Scanee_User__r.State__r.Long_Name__c,Scanee_User__r.Country__r.Long_Name__c,Scanee_User__r.Zip_Code__c,Last_Name__c,Name,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,state__c,country__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,Scanee_User__r.User_Pic__c,Scanee_User__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Scanee_User__r.Email__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \''+eventId +'\' '+condition;
            querystring = 'SELECT First_Name__c,BLN_TKT_profile__r.Home_Address__r.Country__r.Long_Name__c,BLN_TKT_profile__r.Home_Address__r.State__r.Long_Name__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.Duns_Number__c,BLN_TKT_profile__r.Tax_Id__c,BLN_TKT_profile__r.Revenue__c,BLN_TKT_profile__r.Number_Of_Employees__c,BLN_TKT_profile__r.Primary_Business_Category__c,BLN_TKT_profile__r.Secondary_Business_Category__c,BLN_TKT_profile__r.Established_Date__c,BLN_TKT_profile__r.BLN_Company__c,Lead_Email__c,title__c,BLN_TKT_profile__r.Age__c,BLN_TKT_profile__r.Prefix__c,BLN_TKT_profile__r.Suffix__c,BLN_TKT_profile__r.DOB__c,BLN_TKT_profile__r.Gender__c,BLN_TKT_profile__r.Home_Address__r.Address1__c,BLN_TKT_profile__r.Home_Address__r.Address2__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.ZipCode__c,Last_Name__c,Name,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,BLN_TKT_profile__r.Email__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + eventId + '\' ' + condition;
        }else{*/
            querystring = 'SELECT LastModifiedDate,Event__r.Time_Zone__c,BLN_Country__r.Name,First_Name__c,BLN_TKT_profile__r.Home_Address__r.Country__r.Long_Name__c,BLN_TKT_profile__r.Home_Address__r.State__r.Long_Name__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.Duns_Number__c,BLN_TKT_profile__r.Tax_Id__c,BLN_TKT_profile__r.Revenue__c,BLN_TKT_profile__r.Number_Of_Employees__c,BLN_TKT_profile__r.Primary_Business_Category__c,BLN_TKT_profile__r.Secondary_Business_Category__c,BLN_TKT_profile__r.Established_Date__c,BLN_TKT_profile__r.BLN_Company__c,Lead_Email__c,title__c,BLN_TKT_profile__r.Age__c,BLN_TKT_profile__r.Prefix__c,BLN_TKT_profile__r.Suffix__c,BLN_TKT_profile__r.DOB__c,BLN_TKT_profile__r.Gender__c,BLN_TKT_profile__r.Home_Address__r.Address1__c,BLN_TKT_profile__r.Home_Address__r.Address2__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.ZipCode__c,Last_Name__c,Name,Scanner_User__r.User__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Name,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,BLN_TKT_profile__r.Email__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + eventId + '\' AND Scanner_User__r.User__c IN :scannerID ' + condition;//BLN_TKT_profile__r.Home_Address__r.Country__r.Long_Name__c,BLN_TKT_profile__r.Home_Address__r.State__r.Long_Name__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.Duns_Number__c,BLN_TKT_profile__r.Tax_Id__c,BLN_TKT_profile__r.Revenue__c,BLN_TKT_profile__r.Number_Of_Employees__c,BLN_TKT_profile__r.Primary_Business_Category__c,BLN_TKT_profile__r.Secondary_Business_Category__c,BLN_TKT_profile__r.Established_Date__c,BLN_TKT_profile__r.BLN_Company__c,BLN_TKT_profile__r.DOB__c,BLN_TKT_profile__r.Gender__c,BLN_TKT_profile__r.Home_Address__r.Address1__c,BLN_TKT_profile__r.Home_Address__r.Address2__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.ZipCode__c,BLN_TKT_profile__r.Age__c,BLN_TKT_profile__r.Prefix__c,BLN_TKT_profile__r.Suffix__c,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.Name,BLN_TKT_profile__r.Email__c,
       // }
        system.debug('leadlist'+querystring);
        List<Lead_Scan__c> leads = database.query(querystring);
        
     
     if(leads.size() > 0){
          return leads;
     }else{
         return new LIST<Lead_Scan__c>();
     }
   
     }
    
    public List<Lead_Scan__c> getLeadScan_dashboard(String eventId,string condition){
        string scannerID =UserInfo.getUserId();
        List<Lead_Scan__c> leads = new List<Lead_Scan__c>();
        BLN_Event__c eve=[select Organizer_Email__c,owner.email from BLN_Event__c  where id =:eventId];
        string querystring ='';
        
        if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.OwnerId==UserInfo.getuserid()){
            querystring = 'SELECT First_Name__c,BLN_TKT_profile__r.Home_Address__r.Country__r.Long_Name__c,BLN_TKT_profile__r.Home_Address__r.State__r.Long_Name__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.Duns_Number__c,BLN_TKT_profile__r.Tax_Id__c,BLN_TKT_profile__r.Revenue__c,BLN_TKT_profile__r.Number_Of_Employees__c,BLN_TKT_profile__r.Primary_Business_Category__c,BLN_TKT_profile__r.Secondary_Business_Category__c,BLN_TKT_profile__r.Established_Date__c,BLN_TKT_profile__r.BLN_Company__c,Lead_Email__c,title__c,BLN_TKT_profile__r.Age__c,BLN_TKT_profile__r.Prefix__c,BLN_TKT_profile__r.Suffix__c,BLN_TKT_profile__r.DOB__c,BLN_TKT_profile__r.Gender__c,BLN_TKT_profile__r.Home_Address__r.Address1__c,BLN_TKT_profile__r.Home_Address__r.Address2__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.ZipCode__c,Last_Name__c,Name,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.Name,Scanner_User__r.User__c,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,BLN_TKT_profile__r.Email__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + eventId + '\' ' + condition;
           leads = database.query(querystring);
        }else{
           leads = getLeadScan(eventId,condition); // This will pull all leads of this users in same group
           // querystring = 'SELECT First_Name__c,BLN_TKT_profile__r.Home_Address__r.Country__r.Long_Name__c,BLN_TKT_profile__r.Home_Address__r.State__r.Long_Name__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.Duns_Number__c,BLN_TKT_profile__r.Tax_Id__c,BLN_TKT_profile__r.Revenue__c,BLN_TKT_profile__r.Number_Of_Employees__c,BLN_TKT_profile__r.Primary_Business_Category__c,BLN_TKT_profile__r.Secondary_Business_Category__c,BLN_TKT_profile__r.Established_Date__c,BLN_TKT_profile__r.BLN_Company__c,Lead_Email__c,title__c,BLN_TKT_profile__r.Age__c,BLN_TKT_profile__r.Prefix__c,BLN_TKT_profile__r.Suffix__c,BLN_TKT_profile__r.DOB__c,BLN_TKT_profile__r.Gender__c,BLN_TKT_profile__r.Home_Address__r.Address1__c,BLN_TKT_profile__r.Home_Address__r.Address2__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.ZipCode__c,Last_Name__c,Name,Scanner_User__r.User__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,BLN_TKT_profile__r.Email__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + eventId + '\' AND Scanner_User__r.User__c=\'' + scannerID + '\'' + condition;
        }
        system.debug('leadlist'+querystring);
     
     if(leads.size() > 0){
          return leads;
     }else{
         return new LIST<Lead_Scan__c>();
     }
   
     }
    
    public List<Lead_Scan__c> Leadexistchk(String EventId , id tktprof,id loginUserId) {
           List<Lead_Scan__c>  lscan =new List<Lead_Scan__c>();
      // lscan = [SELECT id from Lead_Scan__c where Event__c=:EventId and Scanner_User__c=:loginUserId and Scanee_User__c=:gnu and Lead_Status__c!='Deleted'];
       lscan = [SELECT id from Lead_Scan__c where Event__c=:EventId and Scanner_User__c=:loginUserId and BLN_TKT_profile__c=:tktprof and Lead_Status__c!='Deleted'];
           return lscan;   
        }
      public List<Lead_Scan__c> getLeads(String userId,String EventId,String compId){
        /*                    List<UC_Role__c> ucroleList = new List<UC_Role__c>();
                                boolean isBoothpersonnel =false;
                                if(compId!=null &&  compId!=''){
                                  for(UC_Role__c uc : [select id,RoleId__r.Name from UC_Role__c where GN_User__c=:userId and Company__c=:compId]){
                                    if(uc.RoleId__r.Name != 'Company Admin' && uc.RoleId__r.Name!='Exhibitor'){
                                      isBoothpersonnel =true;
                                      break;
                                     }
                                  }
                                }
                                
          List<UC_Role__c> ucroleList = new List<UC_Role__c>();
         SET<string> grpsIDs = new SET<string>();
         List<string> scannerID =new List<string>();
         BLN_UCRole_DAO ucroledao = new BLN_UCRole_DAO();
         for(UC_Role__c ucr : ucroledao.getUcroles(eventId)){
            grpsIDs.add(ucr.BLN_Group__c);
         }
          for(UC_Role__c ucr : ucroledao.getUcroles(eventId,grpsIDs)){
           scannerID.add(ucr.GN_User__r.User__c );
         } leads =  [SELECT Title__c,Lead_Status__c , BLN_TKT_profile__r.Email__c,BLN_State__r.Name,BLN_State__r.Short_Name__c,BLN_Country__r.Name,BLN_Country__r.Short_Name__c, BLN_TKT_profile__c, Lead_Email__c, user_pic__c, Cell_Phone__c, City__c, BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c, Company__c, CreatedById, CreatedDate, Event__c, First_Name__c, Home_Phone__c, Id, IsDeleted, Rating__c, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Last_Name__c, Name, OwnerId, Prefix__c, Scanner_Company__c, Scanner_User__c, Scan_Time__c, Street1__c, Street2__c, Suffix__c, SystemModstamp, notes__c, Work_Phone__c, followup_date__c FROM Lead_Scan__c where Event__c = :EventId and Scanner_User__c = :userId  order by id limit 50]; //Scanee_User__r.Email__c,Scanee_User__c,
      
*/
                                List<Lead_Scan__c> leads = new List<Lead_Scan__c>();
          leads = getLeadScan(EventId,' order by id limit 500');
        return leads;
    }

 public List<Lead_Scan__c> getLeads(String userId, String EventId, String compId,String lastLeadId, DateTime lmDate ) {
        List<UC_Role__c> ucroleList = new List<UC_Role__c>();
         SET<string> grpsIDs = new SET<string>();
         List<string> scannerID =new List<string>();
         BLN_UCRole_DAO ucroledao = new BLN_UCRole_DAO();
         for(UC_Role__c ucr : ucroledao.getUcroles(eventId)){
            grpsIDs.add(ucr.BLN_Group__c);
         }
         scannerID.add(userId); 
          for(UC_Role__c ucr : ucroledao.getUcroles(eventId,grpsIDs)){
           scannerID.add(ucr.GN_User__c );
         }
          System.debug(' scannerID '+scannerID +' lastLeadId '+lastLeadId + ' LastModifiedDate '+lmDate +' EventId '+EventId);
       
        List<Lead_Scan__c> leads = new List<Lead_Scan__c>();
         leads =  [SELECT Title__c,Lead_Status__c , BLN_TKT_profile__r.Email__c, BLN_TKT_profile__c,BLN_State__r.Short_Name__c,BLN_Country__r.Name,BLN_Country__r.Short_Name__c, Lead_Email__c, user_pic__c, Cell_Phone__c, City__c, BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Name,BLN_State__r.Long_Name__c, Company__c, CreatedById, CreatedDate, Event__c, First_Name__c, Home_Phone__c, Id, IsDeleted, Rating__c, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Last_Name__c, Name, OwnerId, Prefix__c, Scanner_Company__c, Scanner_User__c, Scan_Time__c, Street1__c, Street2__c, Suffix__c, SystemModstamp, notes__c, Work_Phone__c, followup_date__c FROM Lead_Scan__c where Event__c = :EventId and Scanner_User__c IN :scannerID and (id >= :lastLeadId OR (id < :lastLeadId AND LastModifiedDate > :lmDate)) order by id limit 500]; //Scanee_User__r.Email__c,Scanee_User__c,
           

       /* boolean isBoothpersonnel = false;
        if (compId != null &&  compId != '') {
            for (UC_Role__c uc : [select id, RoleId__r.Name from UC_Role__c where GN_User__c = :userId and Company__c = :compId]) {
                if (uc.RoleId__r.Name != 'Company Admin' && uc.RoleId__r.Name != 'Exhibitor') {
                    isBoothpersonnel = true;
                    break;
                }
            }
        }
        List<Lead_Scan__c> leads = new List<Lead_Scan__c>();
       
        if (isBoothpersonnel) {
            leads =  [SELECT Title__c,Lead_Status__c , BLN_TKT_profile__r.Email__c, BLN_TKT_profile__c,BLN_State__r.Short_Name__c,BLN_Country__r.Name,BLN_State__r.Name,BLN_Country__r.Short_Name__c, Lead_Email__c, user_pic__c, Cell_Phone__c, City__c, BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c, Company__c, CreatedById, CreatedDate, Event__c, First_Name__c, Home_Phone__c, Id, IsDeleted, Rating__c, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Last_Name__c, Name, OwnerId, Prefix__c, Scanner_Company__c, Scanner_User__c, Scan_Time__c, Street1__c, Street2__c, Suffix__c, SystemModstamp, notes__c, Work_Phone__c, followup_date__c FROM Lead_Scan__c where Event__c = :EventId and Scanner_User__c = :userId and (id > :lastLeadId OR (id < :lastLeadId AND LastModifiedDate > :lmDate)) order by id limit 50]; //Scanee_User__r.Email__c,Scanee_User__c,
         }else{
          System.debug('PPPPPPPPPPPP '+lmDate);
          leads =  [SELECT Title__c, Lead_Status__c ,BLN_TKT_profile__r.Email__c, BLN_TKT_profile__c, Lead_Email__c, user_pic__c,BLN_Country__r.Name,BLN_State__r.Name,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c, Cell_Phone__c, City__c, BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c, Company__c, CreatedById, CreatedDate, Event__c, First_Name__c, Home_Phone__c, Id, IsDeleted, Rating__c, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Last_Name__c, Name, OwnerId, Prefix__c, Scanner_Company__c, Scanner_User__c, Scan_Time__c, Street1__c, Street2__c, Suffix__c, SystemModstamp, notes__c, Work_Phone__c, followup_date__c FROM Lead_Scan__c where Event__c = :EventId and Scanner_User__c = :userId and (id > :lastLeadId OR (id < :lastLeadId AND LastModifiedDate > :lmDate)) order by id limit 50]; //Scanner_Company__c = :compId //Scanee_User__r.Email__c,Scanee_User__c,
          for(Lead_Scan__c ls :leads ){
             System.debug('QQQQQQQQQQQQQQ '+ls.lastmodifiedDate+' Created date '+ls.createdDate);
          }
         }*/
         
            return leads;
                                  }
                                
     public List<Lead_Scan__c> leadsValue(String lid){
                                    List<Lead_Scan__c> leadList = new List<Lead_Scan__c>(); 
        leadList = [select Title__c, Lead_Status__c ,BLN_State__r.Name,BLN_Country__r.Name,BLN_TKT_profile__r.Email__c, BLN_TKT_profile__c, BLN_State__r.Short_Name__c,Lead_Email__c,BLN_Country__r.Short_Name__c, user_pic__c, Cell_Phone__c, City__c, BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,notes__c,  Rating__c, CreatedById, CreatedDate, Event__c, First_Name__c, Home_Phone__c, Id, Last_Name__c, Name, Prefix__c, LastModifiedDate, Company__c, Scanner_Company__c, Scanner_User__c, Scan_Time__c, Street1__c, Street2__c, Suffix__c, SystemModstamp, Work_Phone__c FROM Lead_Scan__c where id = :lid]; //Scanee_User__r.Email__c,Scanee_User__c,
                                    return leadList;
                                  }
                                  public Database.saveResult UpdateLead(Lead_Scan__c ls){
                                    Database.saveResult dsaveres =  Database.update(ls,false);
            return dsaveres;
           }
        
   public List<Lead_Scan__c> leadRecords(set<id> lids){
    List<Lead_Scan__c> leadList = new List<Lead_Scan__c>(); 
    leadList = [select BLN_State__r.Name,BLN_Country__r.Name,followup_date__c,Title__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__c,BLN_State__r.Short_Name__c,Lead_Email__c,BLN_Country__r.Short_Name__c,user_pic__c,Cell_Phone__c,City__c,notes__c,Rating__c,CreatedById,CreatedDate,Event__c,First_Name__c,Home_Phone__c,Id,Last_Name__c,Name,Prefix__c,LastModifiedDate,Company__c,Scanner_Company__c,Scanner_User__c,Scan_Time__c,Street1__c,Street2__c,Suffix__c,SystemModstamp,Work_Phone__c,BLN_State__c,BLN_Country__c,Lead_Status__c FROM Lead_Scan__c where id in :lids]; //Scanee_User__r.Email__c,Scanee_User__c,
    return leadList;
  }
  public list<Lead_scan__c> allleads(string evenid,string loginUserId){
  
  list<Lead_scan__c> listeadsall=[SELECT First_Name__c,BLN_TKT_profile__r.Home_Address__r.Country__r.Long_Name__c,BLN_TKT_profile__r.Home_Address__r.State__r.Long_Name__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.Duns_Number__c,BLN_TKT_profile__r.Tax_Id__c,BLN_TKT_profile__r.Revenue__c,BLN_TKT_profile__r.Number_Of_Employees__c,BLN_TKT_profile__r.Primary_Business_Category__c,BLN_TKT_profile__r.Secondary_Business_Category__c,BLN_TKT_profile__r.Established_Date__c,BLN_TKT_profile__r.BLN_Company__c,Lead_Email__c,title__c,BLN_TKT_profile__r.Age__c,BLN_TKT_profile__r.Prefix__c,BLN_TKT_profile__r.Suffix__c,BLN_TKT_profile__r.DOB__c,BLN_TKT_profile__r.Gender__c,BLN_TKT_profile__r.Home_Address__r.Address1__c,BLN_TKT_profile__r.Home_Address__r.Address2__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.ZipCode__c,Last_Name__c,Name,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,BLN_TKT_profile__r.Email__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE Event__c=:evenid AND Scanner_User__c=:loginUserId AND Lead_Status__c!='Deleted'];
  
  return listeadsall;
  
  }


        }
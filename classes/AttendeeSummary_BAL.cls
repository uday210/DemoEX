public with sharing class AttendeeSummary_BAL {
    public Void  AssignValToGnu(List<AttendeeSummary__c> attSun) {
       System.debug('DDDDDDDDDD '+attSun);
      SET<String> exitingAttList = new SET<String>();
      BLN_Gnuser_DAO gnuDao = new BLN_Gnuser_DAO();
      SET<String> userNames = new SET<String>();
      BLN_User_DAO userDao = new BLN_User_DAO();
      MAP<String,id> usrUnWithId = new MAP<String,id>();
      MAP<String, Company__c> companyMap = new MAP<String, Company__c>();
      map<String, BLN_Address__c> homeAddressMap = new map<String, BLN_Address__c>();
      List<Company_Ext__c> companyExtList = new List<Company_Ext__c>();

       for (AttendeeSummary__c att : attSun) {
            if (att.AS_Email__c != null && att.AS_Email__c != '' && !userNames.contains(att.AS_Email__c)) {
                userNames.add(att.AS_Email__c);
                 BLN_Address__c Hadd = New BLN_Address__c();   
                  Hadd.Address1__c = att.AS_HomeAddress1__c;
                  Hadd.Address2__c= att.AS_HomeAddress2__c;
                  Hadd.City__c = att.AS_HomeCity__c;
                  Hadd.Zipcode__c = att.AS_HomeZip__c;
                  homeAddressMap.put(att.AS_Email__c,Hadd);
                  Company__c comp = new Company__c();
                  comp.Description__c = att.AS_BusinessDescription__c;
                  comp.Company_Logo__c =att.Exhibitor_company_imageUrl__c;
                  comp.Website_URL__c = att.AS_WebsiteUrl__c;
                 if(att.AS_Company__c!=null && att.AS_Company__c!=''){
                   comp.Name =  att.AS_Company__c;
                 }else{
                   comp.Name = att.AS_FirstName__c+att.AS_LastName__c;
                 }
                 companyMap.put(att.AS_Email__c,comp);  
            }
        }   
      if(homeAddressMap.size()>0)   
        Database.insert(homeAddressMap.values(),false);
      if(companyMap.size()>0)  
        Database.insert(companyMap.values(),false);

         exitingAttList = gnuDao.getGnuserList(userNames); // Getting Existing Gn users
         for(user u :userDao.checkUsersWExists(userNames)){  // Getting existing users
            usrUnWithId.put(u.userName,u.id);
         }
        // =============== Gn user Insertion Started =============================
        SET<String> reMoveDuplicate = new SET<String>();
        List<Gn_user__c> gnUList = new List<Gn_user__c>();
        List<UC_Role__c> ucRoleList = new List<UC_Role__c>();
        BLN_Quick_Registration_BAL QrDao = new BLN_Quick_Registration_BAL();
        MAP<String, id> maproleWithId = new MAP<String, id>();
        BLN_Role_DAO  roledao = new BLN_Role_DAO();
        // Getting available roles for UC role Obj
        for (Role__c r : roledao.userRole()) {
            maproleWithId.put(r.Name, r.id);
        }

        for(AttendeeSummary__c attFinal : attSun){
           if(attFinal.AS_Email__c != null && attFinal.AS_Email__c != '' && !reMoveDuplicate.contains(attFinal.AS_Email__c)) {
              reMoveDuplicate.add(attFinal.AS_Email__c);
               Gn_user__c gnuseFrIns = new Gn_user__c();
               gnuseFrIns.First_Name__c =attFinal.AS_FirstName__c; 
               gnuseFrIns.Last_Name__c =attFinal.AS_LastName__c;
               gnuseFrIns.Email__c = attFinal.AS_Email__c;
               gnuseFrIns.Age__c =attFinal.AS_Age__c;
               gnuseFrIns.DOB__c =attFinal.AS_BirthDate__c;
               gnuseFrIns.Gender__c =attFinal.AS_Gender__c;  
               if(homeAddressMap.keyset().contains(attFinal.AS_Email__c))
               gnuseFrIns.Home_Address__c =homeAddressMap.get(attFinal.AS_Email__c).id; 
               gnuseFrIns.Mobile__c =attFinal.AS_CellPhone__c;
               gnuseFrIns.Prefix__c =attFinal.As_prefixNew__c; 
               gnuseFrIns.Suffix__c =attFinal.As_SuffixNew__c; 
               gnuseFrIns.User_Pic__c =attFinal.AS_ImageUrl__c;
             
              if(null!=usrUnWithId.get(attFinal.AS_Email__c)) 
               gnuseFrIns.User__c =usrUnWithId.get(attFinal.AS_Email__c);

              if(companyMap.keyset().contains(attFinal.AS_Email__c)){
                String companyId = companyMap.get(attFinal.AS_Email__c).id;
                gnuseFrIns.Default_Company_ID__c = companyId;
                Company_Ext__c comex = new Company_Ext__c(); 
                comex.Company__c = companyId;
                companyExtList.add(comPanyExt(attFinal,comex));
                 Boolean isPersonal =false;
                 if(attFinal.AS_Company__c!=null && attFinal.AS_Company__c!='')
                    isPersonal =true;
                  ucRoleList.add(QrDao.inserUcroleNew(companyId,  gnuseFrIns.User__c, isPersonal, maproleWithId.get('Company Admin')));
               
              } 
              gnUList.add(gnuseFrIns);
               
            }
         }
        If(companyExtList.size()>0)
         Database.insert(companyExtList,false);
        If(gnUList.size()>0){
         DataBase.saveResult[] saveRes = Database.insert(gnUList,false);
           System.debug(' Gnusers  '+saveRes );        
        }
        If(ucRoleList.size()>0)
         Database.insert(ucRoleList,false);
       }

  
  public  Company_Ext__c comPanyExt(AttendeeSummary__c attS,Company_Ext__c comext){
        comext.Blog_URL__c = attS.AS_BlogUrl__c;
        comext.Established_Date__c = attS.AS_BusinessEstablishedDate__c;
        comext.Duns_Number__c = attS.AS_BusinessDunsNumber__c;
        comext.Keywords__c = attS.Keywords__c;
        comext.Number_Of_Employees__c =  attS.AS_NumberOfEmployees__c;
        comext.Primary_Business_Category__c = attS.AS_PrimaryBusinessCategory1__c;
        comext.Revenue__c = attS.AS_BusinessRevenue__c;
        comext.Secondary_Business_Category__c = attS.As_SecondaryBusinessCategory1__c;
        comext.Tax_Id__c = attS.AS_BusinessTaxId__c;
        comext.Work_Phone__c = attS.AS_WorkPhone__c;
        comext.Business_Address1__c = attS.AS_HomeAddress1__c;
        comext.Business_Address1__c= attS.AS_HomeAddress2__c;
        comext.Business_City__c = attS.AS_HomeCity__c;
        comext.Business_Zipcode__c = attS.AS_HomeZip__c;
        return comext;

  }
   

}
public with sharing class BLN_GNUser_BAL {
    public GN_User__c upsertGNUser(string companyName){
        GN_User__c gu = new GN_User__c();
        gu.Email__c = userinfo.getUserName();
        gu.First_Name__c =  userinfo.getFirstName();
        gu.Last_Name__c = userinfo.getLastName();
        gu.User__c = userinfo.getUserId();
        return gu;
    }
    
  public void inserTingAtt(List<Tkt_profile__c> tkts) {
   try{ 
    SET<String> emails = new Set<String>();
    List<String> ids = new List<String>();
    BLN_TKTProfile_DAO tktDao = new BLN_TKTProfile_DAO();
    AttendeeSummary_Dao attDao = new AttendeeSummary_Dao();
    for (Tkt_profile__c tc : tkts ) {
      ids.add(tc.id);
      emails.add(tc.Email__c);
   }
    MAP<String, AttendeeSummary__c> attSum = new MAP<String, AttendeeSummary__c>();
    for (AttendeeSummary__c ats : attDao.allFieldsAtt(emails)) {
      attSum.put(ats.AS_Email__c, ats);
    }
    SET<String> removeDup = new SET<String>();
    for (Tkt_profile__c tProfiles  : tktDao.getTktpFormTkt(ids)) {
      if (attSum.keySet().contains(tProfiles.Email__c.tolowercase()) ) {
        AttendeeSummary__c ainn = new AttendeeSummary__c();
        ainn = attValues(attSum.get(tProfiles.Email__c),tProfiles);
        attSum.put(tProfiles.Email__c.tolowercase(),ainn);
      }else{
         AttendeeSummary__c ainn1 = new AttendeeSummary__c();
         ainn1 = attValues(ainn1, tProfiles);
         attSum.put(tProfiles.Email__c.tolowercase(),ainn1);
       }
     }
      System.debug('AttendeeSummary Valuessssssss  '+attSum);
      Database.UpsertResult[] upRes = Database.upsert(attSum.values(), false);
      System.debug('AttendeeSummary result '+upres);
      //only exclude this part when call from batch apex in import attendees
       if(!system.isBatch()){
       updateuser1(emails);
       }
     }catch(exception er){}
   }
    
  public AttendeeSummary__c attValues(AttendeeSummary__c att, Tkt_profile__c tktObj) {
    att.AS_FirstName__c  = tktObj.First_Name__c;
    att.AS_LastName__c = tktObj.Last_Name__c;
    att.AS_Email__c = tktObj.Email__c;
    att.As_prefixNew__c = tktObj.Prefix__c;
    att.As_SuffixNew__c = tktObj.Suffix__c;
    att.Youtube_Link__c = tktObj.Video__c;
    att.AS_CellPhone__c = tktObj.Mobile__c;
    att.AS_HomePhone__c = tktObj.Home_Phone__c;
    att.AS_Title__c = tktObj.TKT_Job_Title__c;
    att.AS_Gender__c = tktObj.Gender__c;
    att.AS_BirthDate__c = tktObj.DOB__c;
    att.AS_BlogUrl__c = tktObj.Blog_URL__c;
    att.Biography__c = tktObj.Biography__c;
    att.AS_Age__c = tktObj.Age__c;
    att.AS_ImageUrl__c = tktObj.User_Pic__c;
    att.Exceptional_Key_Words__c = tktObj.Exceptional_Keywords__c;
    if(tktobj.Revenue__c != 0){
    att.AS_BusinessRevenue__c=tktobj.Revenue__c;}
    //Work information
    att.AS_Company__c = tktObj.TKT_Company__c;
    att.AS_WebsiteUrl__c =  tktObj.Company_Website_URL__c;
    att.AS_BusinessEstablishedDate__c = tktObj.Established_Date__c;
    att.AS_BusinessDunsNumber__c = tktObj.Duns_Number__c;
    att.Keywords__c = tktObj.Keywords__c;
    if(tktObj.Number_Of_Employees__c != 0){
    att.AS_NumberOfEmployees__c   =  tktObj.Number_Of_Employees__c;
    }
    att.AS_PrimaryBusinessCategory1__c = tktObj.Primary_Business_Category__c;
    att.AS_BusinessDescription__c = tktObj.Company_Description__c;
    //att.Revenue_Range__c = tktObj.Revenue__c;
    att.As_SecondaryBusinessCategory1__c = tktObj.Secondary_Business_Category__c;
    att.AS_BusinessTaxId__c = tktObj.Tax_Id__c;
    att.AS_WorkPhone__c = tktObj.Work_Phone__c;
    // Home address Fields
    att.AS_HomeAddress1__c = tktObj.Home_Address__r.Address1__c;
    att.AS_HomeAddress2__c = tktObj.Home_Address__r.Address2__c;
    att.AS_HomeCity__c = tktObj.Home_Address__r.City__c;
    att.AS_HomeCountry__c = tktObj.Home_Address__r.Country__r.Long_Name__c;
    att.As_Home_State__c = tktObj.Home_Address__r.State__r.Long_Name__c;
    att.AS_HomeZip__c = tktObj.Home_Address__r.Zipcode__c;
    // Work address fields
    att.AS_WorkAddress1__c = tktObj.Work_Address__r.Address1__c;
    att.AS_WorkAddress2__c = tktObj.Work_Address__r.Address2__c;
    att.AS_WorkCity__c = tktObj.Work_Address__r.City__c;
    att.AS_Work_Country__c = tktObj.Work_Address__r.Country__r.Long_Name__c;
    att.AS_Work_States__c = tktObj.Work_Address__r.State__r.Long_Name__c;
    att.AS_WorkZip__c = tktObj.Work_Address__r.Zipcode__c;
    //Shipping address fields
    att.AS_ShippingAddress1__c = tktObj.Shipping_Address__r.Address1__c;
    att.AS_ShippingAddress2__c = tktObj.Shipping_Address__r.Address2__c;
    att.AS_ShippingCity__c = tktObj.Shipping_Address__r.City__c;
    att.AS_ShippingCountry__c = tktObj.Shipping_Address__r.Country__r.Long_Name__c;
    att.As_Shipping_States__c = tktObj.Shipping_Address__r.State__r.Long_Name__c;
    att.AS_shippingzip__c = tktObj.Shipping_Address__r.Zipcode__c;
    integer comFields =0;
    integer naicsFields =0;
    //integer comFields =0;
    for(BLN_Company_Commoditie__c cc : tktObj.BLN_Company_Commodities__r){
      comFields++;
      String commoField = 'Commodity_'+String.valueOf(comFields)+'__c';
      if(comFields<=9)
      att.put(commoField,cc.BLN_Commodities__r.Description__c);
    }
   

    for(Company_Naicscodes__c cn : tktObj.BLN_Company_Naicscodes__r){
      naicsFields++;
      if(naicsFields<=5){
        String naicsField = 'AS_NAICSCode_'+String.valueOf(naicsFields)+'__c';
        att.put(naicsField,cn.BLN_NAICS_Code__r.Description__c+', '+cn.BLN_NAICS_Code__r.Name);
      }else{ 
        String naicsField = 'AS_NAICSCode'+String.valueOf(naicsFields)+'__c';
      if(naicsFields<=9)
       att.put(naicsField,cn.BLN_NAICS_Code__r.Description__c+', '+cn.BLN_NAICS_Code__r.Name);
    } 
  }
  
   return att;
  }

  @future
  public static void updateuser1(SET<String> emails){
     // Tkt_profile__c tktObjn = [Select id,TKT_Company__c,Email__c,First_Name__c,Last_Name__c,Company_Website_URL__c from Tkt_profile__c Where id =: TID];
    MAP<string,User> Us = new MAP<string,User>();
    for(User u :[select id,CompanyName,FirstName,Lastname,Company_website__c,userName from User Where Username IN :emails]){
       Us.put(u.userName,u);
    }
    List<user> users =new List<user>();
    for(AttendeeSummary__c tktObjn : [SELECT id,AS_FirstName__c,AS_LastName__c,AS_WebsiteUrl__c,AS_Company__c,AS_Email__c from AttendeeSummary__c where AS_Email__c in :emails]){  
      if(null!=Us.get(tktObjn.AS_Email__c)){
          user temPusr = new user();
          temPusr =Us.get(tktObjn.AS_Email__c);
          temPusr.CompanyName = tktObjn.AS_Company__c;
          temPusr.FirstName= tktObjn.AS_FirstName__c;
          temPusr.Lastname= tktObjn.AS_LastName__c;
          temPusr.Company_website__c = tktObjn.AS_WebsiteUrl__c;
          users.add(temPusr);
       }
     }
    if(users.size()>0) 
    database.update(users,false);  
  }
  
}
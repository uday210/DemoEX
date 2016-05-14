/******************************************************
*   Author                  : Mythily Nagandla
*   Date                    : 14/12/2014 
*   Purpose                 : This is Web Service class for Update Profile.
********************************************************/
@RestResource(urlMapping='/BLN_ASC_UpdateProfile/*')
global class BLN_ASC_UpdateProfile{
global static maincontainer  Mc {get;set;}
//global static BLN_Profile_BAL procon{get ; set ;}
@HttpPost  
  global static maincontainer  doPost(){ //Post Mthod
  
   RestRequest req = RestContext.Request;
    string Fname = req.params.get('Firstname');
     string Lname = req.params.get('Lastname');
      string Cname= req.params.get('Companyname');
      string Comid = req.params.get('DefaultcompanyId');
       string Email = req.params.get('Email');
        string Mobile = req.params.get('Mobile');
        string city = req.params.get('City');
        string State= req.params.get('State');
        string Country= req.params.get('Country');
        string Uid= req.params.get('Userid');
        string Title= req.params.get('Title');
        System.debug('YYYYYYYYYY '+Email +Lname  + Fname +Cname + Comid +Uid );
    String companyid = '';
        Mc = new maincontainer();
        String siteurl=Label.SiteURL;
    BLN_Company_DAO comdao = new BLN_Company_DAO();
        BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
        Company__c comp = new Company__c();
    Company_Ext__c cmpnyExt = new Company_Ext__c();
    GN_User__c  GNUID = gndao.gettinggnuser(uid);
    UC_Role__c ucr = new UC_Role__c();
    // Existing Company  updating company Details
    if (Comid != null && Comid != '') { // Checking wether it is a new company or existing Company
        comp.id = Comid;
        comp.Name = Cname;
          companyid = comdao.updateCompany(comp);
      ucr = gndao.gettingUserRoleData(GNUID.Id);
      try {
        cmpnyExt = gndao.gettingCmpnyExtData(companyid);
      } catch (exception e) {
        cmpnyExt.Company__c = companyid;
      }
    } else { // Inserting new company
     if(Cname!=null && Cname!=''){ 
      comp.Name = Cname;
      Database.SaveResult dSa = Database.insert(comp, false);
      System.debug('Company Status ' + dSa);
      if (dSa.isSuccess()) {
        companyid=dSa.getId();
        cmpnyExt.Company__c = dSa.getId();
        ucr.Company__c = companyid;
        ucr.GN_User__c = GNUID.Id;
        ucr.User_Type__c ='Business';
        ucr.RoleId__c = [select id from Role__c where Name = 'Company Admin' limit 1].Id;
      }
     }
    }
       
  if(cmpnyExt.Company__c!=null){ 
    if(State!=null && State!='')
     try{cmpnyExt.BLN_Business_State__c=[select id,name from State__c where name=:State].id;}catch(Exception e){cmpnyExt.BLN_Business_State__c = State;}
    if(Country!=null && Country!='')
    try{cmpnyExt.BLN_Business_Country__c=[select id,name from Country__c where name=:Country].id;}catch(Exception e){cmpnyExt.BLN_Business_Country__c = Country;}
    cmpnyExt.Business_City__c = city;
    //cmpnyExt.Company__c = ucr.Company__r.Id;
    DataBase.UpsertResult extUrs = DataBase.upsert(cmpnyExt, false);
    System.debug('Company Extention Status ' + extUrs);
   }
    // Insertind user Image
          String jSONRequestBody=req.requestBody.tostring();
    System.debug('jSONRequestBody '+jSONRequestBody);
    BLN_Profile_BAL procon = new BLN_Profile_BAL();
    if(jSONRequestBody!=null & jSONRequestBody!=''){
      procon.UserImage  = EncodingUtil.base64Decode(jSONRequestBody);
      procon.UserImageName  = GNUID.id + '.png';
    }
    // Updating gn user with its company and updated values
         GNUID.First_Name__c = Fname ; 
         GNUID.Last_Name__c  = Lname ;
         GNUID.Mobile__c = Mobile;
         if(companyid !='')
         GNUID.Default_Company_ID__c = companyid;
          procon.updateGNUSER(GNUID);
    //Updating user company role object
   if(Cname!=null && Cname!=''){ 
         ucr.Title__c = Title;
     Database.UpsertResult ures = Database.upsert(ucr, false);
     System.debug('UC Role Status ' + ucr);
          }
          
    GN_User__c gn = gndao.gettinggnuser(uid);
     Mc.Profile = gn;
     if(gn.User_Pic__c!='' && gn.User_Pic__c!=null)
       Mc.profileimage=siteurl + '/servlet/servlet.ImageServer?id=' + gn.User_Pic__c + '&oid=' + UserInfo.getOrganizationId(); 
       Mc.defaultcompanyId =gn.Default_Company_ID__c; 
       Mc.designation =Title;
         try{
    Company_Ext__c ext = [select id,BLN_Business_State__r.Name,BLN_Business_Country__r.Name,BLN_Business_State__r.Long_Name__c,BLN_Business_Country__r.Long_Name__c,Business_City__c from Company_Ext__c where Company__c=:gn.Default_Company_ID__c];  
     Mc.profilestate = ext.BLN_Business_State__r.Name;
     Mc.profilecountry =ext.BLN_Business_Country__r.Name;
     Mc.profileCity =ext.Business_City__c;
     } catch(exception rt){}
      System.debug('MCCCCCCCCCCCC '+Mc);
         return Mc;
    }
  

  global class maincontainer{
  
  public GN_User__c Profile {get ; set ;}
  public string profileimage {get ; set ;}
  public string profilestate {get ; set ;}
  public string profilecountry {get ; set ;}
    public string profileCity {get;set;}
    public string designation{get;set;} 
    public String defaultcompanyId {get; set;}
  public maincontainer(){} 
  
  
  }






}
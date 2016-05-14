/***********************************************************************************************
*   Controller Name : BLN_Profilecon 
*   Author          : Mythily Nagandla
*   Purpose         : This class is used for maintaining the EventAdmin(GNUser) Profile
*   Change History  : 04/12/2016(By Purna)
*      
**************************************************************************************************/
global without sharing class BLN_Profilecon {

    public User Udetails {get ; set ;}
    public string selectedcompany {get ; set ;}
    public Company__c compdetails{get ; set ;}
    public List<Company__c> compdetails1{get ; set ;}
    public GN_User__c GNUSER {get ; set ;}
    public LIST<Company_Ext__c> comext {get ; set ;}
    public string vidos{get;set;}
    public string UserImageName {get ; set ;}
    public string Name {get ; set ;}
    public string naics1 {get ; set ;}
    public string naics2 {get ; set ;}
    public string UdetailsCompanyname {get ; set ;}//Created to store company name of user if his existed company name is his firstname and last name
    public blob UserImage {get ; set ;}
    public blob companyImage {get ; set ;}
    public document mydoc {get ; set ;}
    public LIST<Country__c> country {get ; set ;}
    public LIST<SelectOption> countryOptions {get ; set ;}
    public LIST<SelectOption> NaicsList { get ; set ;}//To collect all naics codes from naics object 
    public LIST<LIST<SelectOption>> NaicsListOfList { get ; set ;}//To collect all naics codes from naics object 
    public LIST<SelectOption> stateOptions{get; set;}
    public LIST<SelectOption> HomestateOptions{get ; set ;}
    public LIST<SelectOption> BillstateOptions{get ; set ;}
    public string selectedCountry {get ; set ;}
    public List<BLN_Address__c> billingadd {get ; set ;}
    public BLN_Address__c  billingadd1 {get ; set ;}
    public BLN_Address__c  billingadd2 {get ; set ;}
    public string billingaddId {get ; set ;}
    
    public String naicsCodesString{get; set;}
    public List<NAICS_Code__c> naicscodeslist {get ; set ;}
    public List<Company_Naicscodes__c > compnaicscodeslist{get ; set ;}
    public LIST<LIST<NAICS_Code__c>> listOfnaicscodes{get; set;}
    
    public List<selectoption> selopt {get ; set ;}
    public List<selectoption> seloptcurrent {get ; set ;}
    public string Currentcompany {get ; set ;}
    public string uid {get ; set ;}
    public Company_Ext__c  comextnew {get;set;}
    public boolean detailsbool {get ; set ;}
    public boolean saveRecordStatus {get;set;}
    public Role__c rol{get;set;}
    public BLN_UtillDisplayLinks  myticket { get; set; }
    public BLN_Address__c Homeadd {get; set;}
    
   
    /**********************************new variables added *****************************************/
    public string CurrentcompanyForExt {get ; set ;}           //To store ids companiesextension of the selected comapny
    public List<Company_Diversity__c> compDiveList{get ; set ;}//To collect all diversities from diversities object based on the selected comapny
    public List<BLN_Company_Commoditie__c> compCommList{get ; set ;}//To collect all commodities from diversities object based on the selected comapny  
    
    public String checkNAICSforEdit{get; set;}      //To collect all naics codes from naics object 
    public String checkDiversforEdit{get; set;}     //To collect all diversities from diversities object
    public String chkCCmforEdit {get; set;}         //To collect all Commodities from Commodities object 
    
    public BLN_CompNaics_DAO compNaicsDao {get; set;}   //Instance for NAICS DAO class and will be used to access required modules from NAICS DAO  
    public BLN_CompDiversity_DAO compDivsDao {get; set;}//Instance for Diversities DAO class and will be used to access required modules from Diversities DAO  
    public BLN_CompCommodity_DAO compComDao {get; set;} //Instance for Commodities DAO class and will be used to access required modules from Commodities DAO  
        
    public List<BLN_Commodities__c> CommoditiesList{get;set;}//To collect all Commodities from Commodities object 
    public List<Diversity__c> diversityList{get;set;} //To collect all diversities from diversities object
     
    public String compDelId {get;set;}       //To store ids of the companies which are going to delete
    public Integer companyListSize {get ; set ;}//To store the count of all the companies for event admin
    public String selcompid {get;set;}        //To store ids of the companies which are currently selected
    public String selCompName {get;set;}      //To store names of the companies which are currently selected
    
    public String newcompany{get;set;}        //To store names of the new companies which are currently added to event admin
    public integer currenttabindex{get;set;}  //To store index of the tab which is currently selected 
    public String ifrmlinkstring{get;set;}    //To store string of iframe links 
    
    public list<compinncls> NewComp{get;set;}    //To store company for which is using in addcompany popup  
    public String resultIframeLinkstring{get;set;}//To store string of iframe links 
    
    public transient String imageData {get;set;}  //To store user profile pic   
    public transient String comimageData {get;set;}//To store company logo information 
    public  Boolean IsUploadProfilePic {get;set;}  //To store boolean value and to check whether user profile pic is there or not
    public Boolean IsUploadComLogo {get;set;}      //To store boolean value and to check whether user company logo is there or not
    public Company__c Currentuserptypecompany {get ; set ;}  //To store the event admins 'p' type(Personal) company  
    public string ptypeexists{get;set;}               //To store the event admins 'p' type(Personal) company  
    public Company__c compnme{get;set;}               //To store new company for the event admins and will be assined to create ucrole..
 
    public String SelectedEvent{get; set;}   //To store currently selected event information and used in implementation of country states
    public  Boolean isBlankTypeCompany{get;set;}// To check whether the selected company is Blanktype(none) or not 
 
  
    /********CONSTRUCTOR*******************************/
    
    public BLN_Profilecon(){
    
        saveRecordStatus  =false;
     IsUploadProfilePic = false;
     IsUploadComLogo = false;
     detailsbool = true;
   myticket = new BLN_UtillDisplayLinks();
 myticket.tablabel='Manage Profile';
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if (k != null) {
         selectedEvent = k.getValue();
     }

     detailsToget();

        }
   

/********Module for getting details of GNUSER,Company,CompanyExtension *******************************/

        public void detailsToget(){
        UdetailsCompanyname = '' ;
        Currentcompany = '' ;
        selectedcompany = '';
        uid = Userinfo.getuserid();    
        Udetails = new User();
         rol= new Role__c( );
         rol=[select id,name from Role__c where name='Company Admin'];
         system.debug('rol======='+rol);
        GNUSER = new GN_User__c();
        Homeadd = new BLN_Address__c();
        billingadd1 = new BLN_Address__c();
        compdetails = new Company__c ();
        comextnew  = new Company_Ext__c  ();
        compdetails1 = new List<Company__c> ();
        selopt = new LIST<selectoption>();
        seloptcurrent =  new LIST<selectoption>();
        comext = new LIST<Company_Ext__c>();       
        billingaddId = '';
        
      //**********************Getting GNUser Details********* 
      
        BLN_Profile_BAL profilebal = new BLN_Profile_BAL();
        GNUSER = profilebal.userdetails(uid);
                          
        BLN_Address_DAO Badd1 = new BLN_Address_DAO();
        If(GNUSER.Home_Address__c != null ){
            
        string did = GNUSER.Home_Address__r.id;
        Homeadd = Badd1.getAddress(did);
        }
       
      //**********************Getting GNUser Companies Details********* 
       
        compdetails1 = profilebal.compniesdetails(GNUSER.id);

    //**********************Adding all companies of event admin to the company list *********   
    
        selopt.add(new selectoption('none','none'));
        if(compdetails1.size() != 0  ){
            companyListSize = compdetails1.size();
           
            for(Company__c comp : compdetails1 ){
                selopt.add(new selectoption(comp.id,comp.name));
                seloptcurrent.add(new selectoption(comp.id,comp.name));
                system.debug(':::::::::::::::::comp::::::'+selopt);
               
                if(GNUSER.Default_Company_ID__r.id == comp.id){
                    Currentcompany = comp.id; 
                    selectedcompany = comp.id;
                    
                    Company__c co= new Company__c();
                    if([select Id from Company__c where SystemModstamp > :Datetime.now().addMinutes(-5) order by LastModifiedDate desc limit 1].size()!=0){
                             co = [select Id from Company__c where SystemModstamp > :Datetime.now().addMinutes(-5) order by LastModifiedDate desc limit 1];
                             for (Company__c comp1: compdetails1) {
                                     if(co.id==comp1.id){  
                                         selectedcompany = co.id; 
                }
            }
                    }
                    
                       
                    //selectedcompany = compdetails1.get(companyListSize-1).id;                 
                }
            }
        } else {

            companyListSize = compdetails1.size();           

        }
      
       //**********************Creating "P" type company for event admin when the company list is empty*********
         if (compdetails1.size() == 0) {
                    
           // detailsbool = false;
           selectedcompany='none';
            BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
            BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
             ptypeexists=BLNuserSignupbal.checkPersonalAccount(GNUSER.Email__c);
             if(ptypeexists!='' || ptypeexists!=null){
                  if(ptypecomp.checkPersonalAccount(GNUSER.Email__c)!=null ){
                       Currentuserptypecompany=ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);
                       GNUSER.Default_Company_ID__c =Currentuserptypecompany.id;
                       Currentcompany=Currentuserptypecompany.id;    
                }
                   
                   
            }
        }
            
        

        /****************Getting NAICS codes,Diversities,Commodities information************************/

        listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
        listOfnaicscodes = BLN_NaicsCodes_Dao.getNaicscodes();

        diversityList = new List < Diversity__c > ();
        diversityList = BLN_Diversity_DAO.getDiversities();

        commoditiesList = new List < BLN_Commodities__c > ();
        commoditiesList = BLN_CompCommodity_DAO.getCommodities();

                
        
        
        if(selectedcompany != null && selectedcompany != ''){
           cpmdetails();
        }else{
          compdetails = new Company__c ();
           ucrole = new UC_Role__c();
        }
        
        /********Getting company extention and billing address information************************/

        comext = new list < Company_Ext__c > ();
        if (selectedcompany != Null && selectedcompany != '') {
            BLN_Company_Ext_DAO comextDAO = new BLN_Company_Ext_DAO();
            comext = comextDAO.companyExtsForCompanyId(selectedcompany);
        }
        if (comext.size() > 0) {

            comextnew = comext[0];
        }


        If(comextnew.Billing_Address__c != null) {
     BLN_Address_DAO Badd2 = new BLN_Address_DAO();
     string did2 = comextnew.Billing_Address__r.id;
     billingadd1 = Badd2.getAddress(did2);
     }
         
         //**********************Getting Country and States details*********
     try {
         countryOptions = new LIST < SelectOption > ();
         BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
             countryOptions = bcd.countryStatesforprofile();
         } catch (exception e) {}
         try {

         stateOptions = new LIST <SelectOption>();
             BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
         stateOptions = bcd.statesBasedOnCountry(countryOptions);

     } catch (exception e) {}
    }
    
  
  /************************Module for getting company and companyextention details*************************************/
    public UC_Role__c ucrole {get;set;}
    public void cpmdetails(){
        
       /* if (selectedcompany != 'none') {
            detailsbool = true;
        } else {
            detailsbool =  false;
        }
      */
      if (selectedcompany == 'none' || selectedcompany == '') {
            isBlankTypeCompany=true;
            BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
            BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
            if (ptypecomp.checkPersonalAccount(GNUSER.Email__c) != null && ptypecomp.checkPersonalAccount(GNUSER.Email__c) != '') {
                    Currentuserptypecompany=ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);
                    selectedcompany=Currentuserptypecompany.id;
            }
                
        }else{
                isBlankTypeCompany=false;

        }
       //**********************Getting Company Extension details*********
       
        comextnew  = new Company_Ext__c  ();
        comext = new List < Company_Ext__c > ();
        compdetails = new Company__c ();
        if (selectedcompany != Null && selectedcompany != '') {
            BLN_Company_Ext_DAO comextDAO = new BLN_Company_Ext_DAO();
            comext = comextDAO.companyExtsForCompanyId(selectedcompany);
            
        }
        if(comext.size() > 0){
            comextnew  =comext[0]; 
        }        
            
        If(comextnew.Billing_Address__c != null) {
            BLN_Address_DAO Badd2 = new BLN_Address_DAO();
            string did3 = comextnew.Billing_Address__r.id;
            billingadd1 = Badd2.getAddress(did3);
        }


       //**********************Getting NAICS Codes details*********
      
        compNaicsDao = new BLN_CompNaics_DAO();
        compnaicscodeslist = compNaicsDao.getCompGNUserNaics(selectedcompany, GNUSER.id);

        if (compnaicscodeslist.size() > 0) {
           
            checkNAICSforEdit = '';
            for (Company_Naicscodes__c s: compnaicscodeslist) {

                checkNAICSforEdit = checkNAICSforEdit + s.BLN_NAICS_Code__c;

            }
            
        }


          //**********************Getting Diversities details*********

        compDivsDao = new BLN_CompDiversity_DAO();
        compDiveList = compDivsDao.getComGNUserDivs(selectedcompany, GNUSER.id);

        if (compDiveList.size() > 0) {

            
            checkDiversforEdit = '';
            for (Company_Diversity__c s: compDiveList) {

                checkDiversforEdit = checkDiversforEdit + s.Diversity__c;

            }
            
            } 
            
          //**********************Getting Company Commodities details*********
            
        compComDao = new BLN_CompCommodity_DAO();
        compCommList = compComDao.getCompGNUserComs(selectedcompany, GNUSER.id);

        if (compCommList.size() > 0) {
            
            chkCCmforEdit = '';
            for (BLN_Company_Commoditie__c s: compCommList) {
                
                chkCCmforEdit = chkCCmforEdit + s.BLN_Commodities__c;

        }
            
        }      
        
          //**********************Getting UC_Role details*********
          
        try{
            if(selectedcompany != null && selectedcompany != ''){
                compdetails = [select  ID, NAME,Website_URL__c,Description__c, Company_Logo__c from Company__c where id =: selectedcompany];
                
                selCompName = compdetails.name;
                ucrole = new UC_Role__c();

                ucrole  = [select  ID,Title__c from UC_Role__c where Company__c  =: selectedcompany and GN_User__c = :GNUSER.id]; 
            }else{
                compdetails = new Company__c();
                ucrole = new UC_Role__c();
            }
           
        }catch(exception ex){
            
        }
        
        
    }
    
    
    /********Module to add new Company (Active) for Event Admin *******************************/

    public void addCompany() {

        comext = new LIST < Company_Ext__c > ();
        compdetails = new Company__c();
        if(ApexPages.currentPage().getParameters().get('newcmpany') != '') {
            newcompany= ApexPages.currentPage().getParameters().get('newcmpany');
            
            compdetails.Name = newcompany;
            selectedcompany=newcompany;
        }
        else {            
            newcompany= NULL;
        }
       
        
        billingadd1 = new BLN_Address__c();
        comextnew = new Company_Ext__c();
        
        /********NAICS codes,Diversities and Commodities information*******************************/
        
        checkNAICSforEdit = '';
        checkDiversforEdit = '';
        chkCCmforEdit = '';
       
        listOfnaicscodes = new LIST < LIST < NAICS_Code__c >> ();
        listOfnaicscodes = BLN_NaicsCodes_Dao.getNaicscodes();

        diversityList = new List < Diversity__c > ();
        diversityList = BLN_Diversity_DAO.getDiversities();
    
        commoditiesList = new List < BLN_Commodities__c > ();
        commoditiesList = BLN_CompCommodity_DAO.getCommodities();
    
        /********Creating "B" type company and UC_Role for event admin *******************************/
      
        BLN_Company_DAO comdaoObj= new BLN_Company_DAO();
        String compid=BLN_User_SignUP_BAL.createBtypeCompanyAndUcrole(compdetails,GNUSER.id);
        Company__c newcompdetails= [SELECT Id FROM Company__c WHERE id =: compid LIMIT 1];
        comextnew.Company__c = newcompdetails.id;
        database.upsert(comextnew);        
        
      /********Making the firstly added company as a default company for event admin *******************************/
        
      if (companyListSize == 0 && compdetails.id != null) {
          GNUSER.Default_Company_ID__c = compdetails.id;
          Currentcompany = compdetails.id;
          BLN_Profile_BAL profilebal = new BLN_Profile_BAL();
          GN_User__c GNU = profilebal.updateGNUSER(GNUSER);
      }else{
              
              selectedcompany= compdetails.id;
      }
      //return null;
    }



    /********This method is to delete Company (making InActive) for Event Admin*******************************/

    public void delCompany() {

    compDelId = '';
    Savepoint sp = Database.setSavepoint();
    if(ApexPages.currentPage().getParameters().get('companyid') != '') {
        compDelId = ApexPages.currentPage().getParameters().get('companyid');
          }
    else {
        compDelId = NULL;
          }
              
    BLN_Company_DAO CompanyDAOobj = new BLN_Company_DAO();
    CompanyDAOobj.deleteCompany(compDelId);

    if (companyListSize == 1) {

        BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
        BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
        ptypeexists = BLNuserSignupbal.checkPersonalAccount(GNUSER.Email__c);

        if (ptypeexists == '') {

            String gnid = GNUSER.id;
            BLN_User_SignUP_BAL.createPtypeCompanyAndUcrole(gnid, GNUSER.First_Name__c, GNUSER.Last_Name__c);

        }        
        if (ptypecomp.checkPersonalAccount(GNUSER.Email__c) != null) {
            Currentuserptypecompany = ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);
            GNUSER.Default_Company_ID__c = Currentuserptypecompany.id;
    }
    
        BLN_Profile_BAL profilebal = new BLN_Profile_BAL();
        GN_User__c GNU = profilebal.updateGNUSER(GNUSER);

        }   
    }
    
    public String comextid { get;set; } //To store the id information of new company which is added    
        
    /********Module for the Tab Rendering isuue******************************************/

     public PageReference redirectToCurrentTab() {
        
         IF(ApexPages.currentPage().getParameters().get('currindex') != '') {
            currenttabindex=integer.valueOf(ApexPages.currentPage().getParameters().get('currindex'));
            if(currenttabindex!=0 && currenttabindex!=null){
                PageReference profPage= new PageReference('/BLN_Profile?id='+currenttabindex);
                profPage.setRedirect(true);
                return profPage;
        }else{
            
                    currenttabindex= 0;
                    PageReference profPage= new PageReference('/BLN_Profile?id='+currenttabindex);
                    profPage.setRedirect(true);
                    return profPage;
            }
        }
         return null; 
     
     }
     
   
    
    
    /**************Module  for updating gnuser,company and companyextension details ******************************/
    
    public string companyImageName{get;set;}
    public void updatedetails() {

   /* if (selectedcompany != 'none') {
            detailsbool = true;
        } else {
            detailsbool = false;
        }
      */  
      
                
       
    List < folder > folderList = new List < folder > ();
    folderList = [select id from folder where Name = : 'Shared Documents'];
    try {

        if (IsUploadProfilePic) {
            if (imageData != '') {

                document mydoc = new document();
                mydoc.body = EncodingUtil.base64Decode(imageData);
                mydoc.folderid = folderList[0].id;
                mydoc.IsPublic = True;
                mydoc.Name = 'attlogo.png';
                mydoc.contentType = 'image/png';
                DataBase.saveResult docSaveResult;
                docSaveResult = DataBase.insert(mydoc, false);

                if (docSaveResult.isSuccess()) {
                    GNUSER.User_Pic__c = docSaveResult.getId();
        }   

            } else {
                GNUSER.User_Pic__c = null;
    }
    }
        if (IsUploadComLogo) {
            if (comimageData != '') {

                document mydoc = new document();
                mydoc.body = EncodingUtil.base64Decode(comimageData);
                mydoc.folderid = folderList[0].id;
                mydoc.IsPublic = True;
                mydoc.Name = 'attlogo.png';
                mydoc.contentType = 'image/png';
                DataBase.saveResult docSaveResult;
                docSaveResult = DataBase.insert(mydoc, false);
    
                if (docSaveResult.isSuccess()) {
                    compdetails.Company_Logo__c = docSaveResult.getId();
    }
        
            } else {
                compdetails.Company_Logo__c = null;
        }   
    }
    } catch (exception er) {}
      
    BLN_Address_DAO ado = new BLN_Address_DAO();
    if (Currentcompany != null) {
        
        GNUSER.Default_Company_ID__c = Currentcompany;
                } else {
                    
        GNUSER.Default_Company_ID__c = Currentuserptypecompany.id;

                }
    BLN_Profile_BAL profilebal = new BLN_Profile_BAL();
    GN_User__c GNU = profilebal.updateGNUSER(GNUSER);
    if (GNUSER.Home_Address__r != null) {
        update Homeadd;

    } else {

        string addid = ado.insertadd(Homeadd.Address1__c, Homeadd.Address2__c, Homeadd.City__c, Homeadd.Country__c, Homeadd.State__c, Homeadd.PoBox__c, Homeadd.ZipCode__c);
        system.debug('Homeaddidaaaaaaaaaaaaaaaaaa' + addid);
        GNUSER.Home_Address__c = addid;
        Update GNUSER;

                
            }
    BLN_Company_DAO compObj = new BLN_Company_DAO();

    If(comextnew.Billing_Address__c != null && compdetails.id != null) {

        BLN_Address_DAO adoAddres = new BLN_Address_DAO();
        string blnAddresId = adoAddres.insertadd(billingadd1.Address1__c, billingadd1.Address2__c, billingadd1.City__c, billingadd1.Country__c, billingadd1.State__c, billingadd1.PoBox__c, billingadd1.ZipCode__c);
        comextnew.Billing_Address__c = blnAddresId;
        comextid = compObj.insertcompdetails(compdetails.id, comextnew);

    } else {
            
        BLN_Address_DAO adoAddres = new BLN_Address_DAO();
        string blnAddresId = adoAddres.insertadd(billingadd1.Address1__c, billingadd1.Address2__c, billingadd1.City__c, billingadd1.Country__c, billingadd1.State__c, billingadd1.PoBox__c, billingadd1.ZipCode__c);
        comextnew.Billing_Address__c = blnAddresId;
        
        }
        
    compNaicsDao = new BLN_CompNaics_DAO();
    compDivsDao = new BLN_CompDiversity_DAO();
    compComDao = new BLN_CompCommodity_DAO();
        
    if (naicsCodesString != '' && naicsCodesString != null) {
        compNaicsDao.NaicsHandle(selectedcompany, GNUSER.id, naicsCodesString);
    }
            if(naicsCodesString != NULL){
                checkNAICSforEdit= '';
        // checkNAICSforEdit= '$$$$';
                LIST<String> naicsCodes= new LIST<String>(naicsCodesString.split('-'));
        for (String naics: naicsCodes) {
            checkNAICSforEdit += naics;


        }
                }


    if (diversitiesTypesString != '' && diversitiesTypesString != null) {
        compDivsDao.DiversityHandle(selectedcompany, GNUSER.id, diversitiesTypesString);
                }
    if (diversitiesTypesString != NULL) {
        checkDiversforEdit = '';
        LIST < String > driversTypes = new LIST < String > (diversitiesTypesString.split('-'));
        for (String driver: driversTypes) {
            checkDiversforEdit += driver;

                
            }
        }
       

    if (commoditiesTypesString != '' && commoditiesTypesString != null) {
        compComDao.CommoditiesHandle(selectedcompany, GNUSER.id, commoditiesTypesString);
    }
    if (commoditiesTypesString != NULL) {
        chkCCmforEdit = '';
        LIST < String > commTypes = new LIST < String > (commoditiesTypesString.split('-'));
        for (String comms: commTypes) {
            chkCCmforEdit += comms;


        }
       }
    database.update(ucrole, false);
    if (selectedcompany == 'none' || selectedcompany == '') {
            
            BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
            BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
            if (ptypecomp.checkPersonalAccount(GNUSER.Email__c) != null && ptypecomp.checkPersonalAccount(GNUSER.Email__c) != '') {
                    Currentuserptypecompany=ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);
                    selectedcompany=Currentuserptypecompany.id;
            }else{
            
                    String gnid = GNUSER.id;
                    BLN_User_SignUP_BAL.createPtypeCompanyAndUcrole(gnid, GNUSER.First_Name__c, GNUSER.Last_Name__c);        
                //BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
                //BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
                if (ptypecomp.checkPersonalAccount(GNUSER.Email__c) != null && ptypecomp.checkPersonalAccount(GNUSER.Email__c) != '') {
                    Currentuserptypecompany = ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);                   
                    Currentuserptypecompany.Company_Logo__c = compdetails.Company_Logo__c;
                        Currentuserptypecompany.Website_URL__c = compdetails.Website_URL__c;
                        database.upsert(Currentuserptypecompany);
                        comextnew.Company__c = Currentuserptypecompany.id;
                        database.upsert(comextnew);
                         selectedcompany=Currentuserptypecompany.id;
                    }
             
            }
                
        }
     //database.upsert(compdetails);
     System.debug('selectedcompany&&&&&&&&&&&');
     if (selectedcompany != 'none' && selectedcompany != '') {
             database.upsert(compdetails);
             System.debug('IN if selectedcompany '+selectedcompany);
             System.debug('compimage'+compdetails.Company_Logo__c);
             System.debug('compimage'+compdetails.id);
            if (compdetails.id != null) {
    comextnew.Company__c = compdetails.id;
    database.upsert(comextnew); 
            }
    detailsToget();
        } else {
             System.debug('IN else selectedcompany '+selectedcompany);
            BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
            BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
            ptypeexists = BLNuserSignupbal.checkPersonalAccount(GNUSER.Email__c);
            if (ptypeexists != '' || ptypeexists != null) {
                if (ptypecomp.checkPersonalAccount(GNUSER.Email__c) != null && ptypecomp.checkPersonalAccount(GNUSER.Email__c) != '') {
                    Currentuserptypecompany = ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);
                    //  GNUSER.Default_Company_ID__c =Currentuserptypecompany.id;
                    //Currentcompany=Currentuserptypecompany.id;
                    if (Currentuserptypecompany.id != null) {
        
                        Currentuserptypecompany.Company_Logo__c = compdetails.Company_Logo__c;
                        Currentuserptypecompany.Website_URL__c = compdetails.Website_URL__c;
                        database.upsert(Currentuserptypecompany);
                        comextnew.Company__c = Currentuserptypecompany.id;
                        database.upsert(comextnew);
       }
       
                }


            } else {
 
                String gnid = GNUSER.id;
                BLN_User_SignUP_BAL.createPtypeCompanyAndUcrole(gnid, GNUSER.First_Name__c, GNUSER.Last_Name__c);

                //BLN_Company_DAO ptypecomp = new BLN_Company_DAO();
                //BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
                if (ptypecomp.checkPersonalAccount(GNUSER.Email__c) != null) {
                    Currentuserptypecompany = ptypecomp.queryPersonalCompanyId(GNUSER.Email__c);
                    Currentuserptypecompany.Company_Logo__c = compdetails.Company_Logo__c;
                    Currentuserptypecompany.Website_URL__c = compdetails.Website_URL__c;
                    database.upsert(Currentuserptypecompany);
                    comextnew.Company__c = Currentuserptypecompany.id;
                    database.upsert(comextnew);
        
             } 
        }
        }
      
 }




  /******** Module to cancel the most recent changes And will goback to user events ******************************/
    public pagereference cancel() {
        pagereference pf = new pagereference('/apex/BLN_Userevents');
        return pf;

}

    
     /******** Module for inline saving of default company ******************************/
    public string currentcompnyid{get;set;}
    public void defaultCompanyInlineSave() {

    IF(ApexPages.currentPage().getParameters().get('inlineCurrentcompany') != '') {
        currentcompnyid = ApexPages.currentPage().getParameters().get('inlineCurrentcompany');
}
    system.debug('currentcompnyid &&&&:' + currentcompnyid);
    if (currentcompnyid != null) {

        GNUSER.Default_Company_ID__c = currentcompnyid;
        Currentcompany=currentcompnyid;
}
    BLN_Profile_BAL profilebal = new BLN_Profile_BAL();
    GN_User__c GNU = profilebal.updateGNUSER(GNUSER);
    system.debug('GNuser update&&&&:' + GNU);
    //detailsToget();

}
    
  public void sampledefaultCompanyInlineSave(){ }   
    
        
    /********Receiving Naics codes ,Diversities and Commodities information******************************/
    
    public pagereference sendNaicsCodes(){
        
    naicsCodesString = '';
        IF(ApexPages.currentPage().getParameters().get('naicsCodes') != ''){
            naicsCodesString=ApexPages.currentPage().getParameters().get('naicsCodes');
    }
    ELSE {
            naicsCodesString= NULL;
            
        }

    return null;
}
   
    public String diversitiesTypesString {get;set;}
    public pagereference sendDiversities() {

     IF(ApexPages.currentPage().getParameters().get('diversities') != '') {
         diversitiesTypesString = ApexPages.currentPage().getParameters().get('diversities');
     }
     ELSE {
         diversitiesTypesString = NULL;

     }
     return null;
 }            
        
   public String commoditiesTypesString {get;set;}
   public pagereference sendCommodities() {

     IF(ApexPages.currentPage().getParameters().get('Commodities') != '') {
         commoditiesTypesString = ApexPages.currentPage().getParameters().get('Commodities');
     }
     ELSE {
         commoditiesTypesString = NULL;

     }
        return null;
    }
    
    
     /********wrapper class for add company popup***********************/ 
     
     global class compinncls{
        public id compid{get;set;}
        public string compname{get;set;}        
        public compinncls(id cid,string cname){
        this.compid = cid;
        this.compname = cname;        
    }
}
    
    
}
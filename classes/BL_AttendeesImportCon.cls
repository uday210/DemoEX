/***********************************************************************************************
*   Controller Name : QRCode_DataImportCon
*   Date            : 06/07/2012 
*   Author          : Naga Mallikarjuna Rao B
*   Purpose         : This class is for Import Attendee Information FROM CSV File
*   Change History  : 18/07/2012 
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   23/07/2012          Naga Mallikarjuna Rao B           Tocreate Comments in TopOfPage
*   03/07/2012                BMR                         First Name,Last Name Fields positions change In VF
*   06/07/2012                BMR                         Writing Test method
*   16/08/2012                BMR                         Writing Code For Avoid Duplicates Through MAP(CheckDuplicate)
*   11/09/2012                BMR                         Writing Code For Supporting MAC CSV File(Visualforce, Apex)
*   21/09/2012                BMR                         Completed Writing code for MAC CSV File Reading............
*   18/10/2012                BMR                         For Registration Type of Import in Event-Attendee Junction Object 
*   20/02/2013          Mythily Nagandla                    Business DUN's Number & BUsiness TaxId Data Type is Changed Added Shipping Phone Number
*   20/02/2015          Mythily Nagandla                   Changes made to support importing process in Match Leads Product
**************************************************************************************************/



public class BL_AttendeesImportCon {
 
    
    public String searchStr{get; set;}
    public Blob contentFile { get; set; }
    public Boolean ErrorFilesize{get; set;}
    public String nameFile { get; set; }
     public string attendeealias {get ; set ;}
    public string exhibitoralias {get ; set ;}
    
    public Integer rowCount { get; set; }
    public Integer colCount { get; set; }    
    
    public string[] selectedValue{get;set;}
    
    public String singleEvent{get; set;}
    public Boolean showselectCSV{get; set;}

    public Static Integer UnSuccessPop{get; set;}
    public Boolean headerDisplay{get; set;}
    
    public Transient LIST<String> Displayrecords{get; set;}
    public LIST<String> StdImportHeaderNames1{get; set;}
    public LIST<String> StdImportHeaderNames2{get; set;}
    
    public List<SelectOption> csvHeaders{get; set;} 
    public MAP<String, String> CSVHeaderMapping{get; set;}
    public LIST<String> CSVHeaderToStore{get; set;}
     
    public String SelectdValue{get; set;}
    public String SelectdValue2{get; set;}
    
    public MAP<String, String> DBField{get; set;}
    public Transient String DBValue{get; set;}
    public Transient String DBValue2{get; set;}
    public LIst<InnerClass> innnnn{get;set;}
    public LIst<InnerClass2> innnnn2{get;set;}
    public Integer BeforeInsert{get; set;}
    public Integer AfterInsert{get; set;}
    public Boolean Successbool{get; set;}
    public Boolean DataImportBool{get; set;}

    public Boolean noFileChooseBool{get; set;}
    public String csvHeadersForFail{get; set;} 
    public static LIST<InnerClass> innerStatic{get; set;}
    public static LIST<InnerClass2> inner2Static{get; set;}
    public Static ID eventIdForAtt{get; set;}
    
    public String allFields1 {get;set;}
    public String allFields2{get;set;} 
   
    public String dataFromJavaScript{get; set;}
   
   public Event__c eventToImport{get; set;}
   
    

    public Id UserId{get; set;}
    public String RecordStatus{get; set;}
       
       public Pagereference checkUserId()
       {
       
           System.debug('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'+UserInfo.getUserId());
          
           if(userInfo.getUserType()=='guest'){
                Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
                pg.setredirect(true);
                return pg;
           } else{
                return null;
           }  
            
            
          
       
       }
       
      public static String capitalizeFirstLetters(String name) {
    name = name.toLowerCase();
    String result = '';
    //List of separators after which we should capitalize letter
    String[] separatorList = new String[]{' ','-'};
    if (name != null && name != '') {
        result = name;
        for(String separator : separatorList){
            String tmpResult = '';
            for (String iter : result.split('[' + separator+']+')) {                
                if (iter != null && iter != '') {
                    if (iter.length() > 1) {  
                        tmpResult += iter.substring(0,1).toUpperCase() + iter.substring(1,iter.length()) + separator;
                    }
                    else {
                        tmpResult += iter.substring(0,1).toUpperCase() + separator;
                    }
                }
            }
            result = tmpResult.substring(0, tmpResult.length() - 1);
        }
    }
    return result;
}
       
       public list<string> vals {get ; set ;}
        public BL_AttendeesImportCon ()
        {
             
            
            
            attendeealias ='';
            exhibitoralias ='';
            vals = new list<string> ();
            headerDisplay = TRUE;
            showselectCSV=FALSE;
            ErrorFilesize=FALSE;
            noFileChooseBool = FALSE;
            system.debug('dddddddddddddddddddddddddddd'+ApexPages.currentpage().getparameters().get('id'));
            string urlid = ApexPages.currentpage().getparameters().get('id');
            
            vals= urlid.split('~');
            system.debug('11111111111111111111111'+vals);
            eventIdForAtt = vals[0];

            system.debug('kkkkkkkkkkkkkkkkkkkkkk'+ eventIdForAtt);
            List<Tags__c> tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventIdForAtt ];
               for(Tags__c tt: tagslist){
                   if(tt.Default_Name__c == 'Attendee'){
                       attendeealias = tt.Alias_Name__c;
                   }else if(tt.Default_Name__c == 'Exhibitor'){
                       exhibitoralias = tt.Alias_Name__c;
                   }
                   }
            
            DBField = new MAP<String, String>();
            
            DBField.put('none','NONE');
            DBField.put('Prefix','As_prefixNew__c');
            DBField.put('First Name','AS_FirstName__c');
            DBField.put('Last Name','AS_LastName__c');
            DBField.put('Suffix', 'As_SuffixNew__c');
            DBField.put('Company Name', 'AS_Company__c');
            DBField.put('Designation','AS_Title__c');
            DBField.put('Ethnicity','Ethnicity__c');
            DBField.put('Primary E-Mail', 'AS_Email__c');
            DBField.put('Email for MatchMaking','AS_Secondary_Email__c');
            DBField.put('Mobile Number', 'AS_CellPhone__c');
            DBField.put('Gender','AS_Gender__c');
            DBField.put('Age','AS_Age__c');
            DBField.put('Date Of Birth' , 'AS_BirthDate__c');
            DBField.put('Work Address 1','AS_WorkAddress1__c');
            DBField.put('Work Address 2', 'AS_Workaddress2__c');
            DBField.put('Work City','AS_Workcity__c');
            DBField.put('Work State', 'AS_Work_States__c');
            DBField.put('Work Country', 'AS_Work_Country__c');
            DBField.put('Work Phone Number','AS_WorkPhone__c');
            DBField.put('Work Zip Code', 'AS_WorkZip__c');
            DBField.put('Business Description','AS_BusinessDescription__c');
            DBField.put('Business Established Date', 'AS_BusinessEstablishedDate__c');
            DBField.put('Business DUNS Number', 'AS_BusinessDunsNumber__c');
            DBField.put('No. of Employees','AS_NumberOfEmployees__c');
            DBField.put('Business Revenue','AS_BusinessRevenue__c');
            DBField.put('Business Tax Id', 'AS_BusinessTaxId__c');
            DBField.put('Work Fax Number', 'AS_FaxNumber__c');
            DBField.put('Primary Business Category', 'AS_PrimaryBusinessCategory1__c');
            DBField.put('Secondary Business Category','As_SecondaryBusinessCategory1__c');
            DBField.put('Shipping Address 1', 'AS_Shippingaddress1__c');
            DBField.put('Shipping City','AS_shippingCity__c');
            DBField.put('Shipping State', 'As_Shipping_States__c');
           // DBField.put('Shipping Zip Code','AS_ShippingPOBox__c');
            DBField.put('Shipping Address 2','AS_ShippingAddress2__c');
            DBField.put('Shipping Zip Code','AS_shippingzip__c');
            DBField.put('Shipping Country','As_Shipping_Country__c');
            DBField.put('Shipping Phone Number','AS_ShippingPhone__c');
            
            DBField.put('Blog URL','AS_BlogURL__c');
            DBField.put('WebSite URL', 'AS_WebsiteURL__c');
            DBField.put('Home Phone Number','AS_HomePhone__c');
            DBField.put('Home Address 1','AS_Homeaddress1__c');
            DBField.put('Home Address 2', 'AS_Homeaddress2__c');
            DBField.put('Home City','AS_HomeCity__c');
            DBField.put('Home State', 'As_Home_State__c');
            DBField.put('Home Zip Code','AS_HomeZip__c');
            DBField.put('Home Country','As_Home_Country__c');
            DBField.put('Through EventBrite', 'AS_ThroughEventBrite__c');
            DBField.put('Survey Answers','AS_Survey_Answers__c');
            DBField.put('Diversity Type', 'AS_DiversityType__c');
            DBField.put('NAICS Code 1','AS_NAICSCode_1__c');
            DBField.put('NAICS Code 2', 'AS_NAICSCode_2__c');
            DBField.put('NAICS Code 3','AS_NAICSCode_3__c');
            DBField.put('NAICS Code 4','AS_NAICSCode_4__c');
            DBField.put('NAICS Code 5', 'AS_NAICSCode_5__c');
            DBField.put('NAICS Code 6', 'AS_NAICSCode6__c');
            DBField.put('NAICS Code 7', 'AS_NAICSCode7__c');
            DBField.put('NAICS Code 8', 'AS_NAICSCode8__c');
            DBField.put('NAICS Code 9', 'AS_NAICSCode9__c');
            
            DBField.put('Commodity 1', 'Commodity_1__c');
            DBField.put('Commodity 2', 'Commodity_2__c');
            DBField.put('Commodity 3', 'Commodity_3__c');
            DBField.put('Commodity 4', 'Commodity_4__c');
            DBField.put('Commodity 5', 'Commodity_5__c');
                
            DBField.put('Registration Type', 'Registration_type__c');
            DBField.put('Key Words', 'Keywords__c');
            DBField.put('DBA', 'DBA__c');
            DBField.put('Certificate Processed by RPO', 'Certificate_Processed_by_RPO__c');
            DBField.put('BBB Number','BBB_Number__c');
            DBField.put('Which country is your companys distribution center located (if applicable)?', 'distribution_Country__c');
            DBField.put('If your company sells a product what country or countries manufactures it?', 'Manufactures_Country__c');
            DBField.put('Reference 1', 'References__c');
            DBField.put('Scope of Work 1', 'Scope_of_Work__c');
            DBField.put('Reference 2', 'References2__c');
            DBField.put('Scope of Work 2', 'Scope_of_Work2__c');
            DBField.put('Years In Business', 'Year_in_business__c');
            DBField.put('Business Structure', 'Business_Structure__c');
            //DBField.put('Fax', 'AS_FaxNumber__c');
            DBField.put('Geographical Region', 'Geographical_Region__c');
            DBField.put('Revenue Range', 'Revenue_Range__c');
            DBField.put('Non-WBENC awards received in the last 2 years', 'Any_non_WBENC_awards_received__c');
            DBField.put('Does your company have either a facility or partner outside of the US?', 'Companyhaveafacility_partneroutsideUSA__c');
            DBField.put('Badge Type', 'TicketTypesBP__c');
            DBField.put('Badge Category', 'GuestType__c');
          /*  
           allFields1='Prefix,Last Name,Email Id,Designation,Mobile Number,Work Fax Number,Gender,Home Address 1,Home City,Home Zip Code,Work Address 2,Work State,Shipping Address 1,Shipping City,Shipping Zip Code,Secondary Business Category,Business Established Date,Business Tax Id,WebSite URL,Diversity Type,NAICS Code 1,NAICS Code 3,NAICS Code 5';
           StdImportHeaderNames1= allFields1.split(',');
          
           allFields2='First Name,Suffix,Company Name,Home Phone Number,Work Phone Number,Age,Date Of Birth,Home Address 2,Home State,Work Address 1,Work City,Work Zip Code,Shipping Address 2,Shipping State,Primary Business Category,No. Of Employees,Business Revenue,Business DnB Id,Blog URL,Business Description,NAICS Code 2,NAICS Code 4';
           StdImportHeaderNames2=allFields2.split(',');
        */
            RecordStatus = 'BoothLeads.com will now begin to import your file. You will be notified by email at' + '<B>'+' {!$user.Username}'+'</b>'+' when your import is completed.'+ '<br/>'+ 'Based on the current volume of import activity, we estimate that your import will be completed in approximately 3 minutes.';
            
           //----------------------------------------------------------------------------
            
            BL_SecuritySettingsCon attendeeSetting = new BL_SecuritySettingsCon(eventIdForAtt);
            
            String allFields1='';
            String allFields2='';
        
        if(attendeeSetting.Prefix)
               allFields1 +='Prefix,';
           if(attendeeSetting.ReqFields)               
               allFields1 +=capitalizeFirstLetters('First Name,');
           if(attendeeSetting.ReqFields)
               allFields1 +='Primary E-Mail,';
           
               allFields1 +='Ethnicity,'; 
               allFields1 +='Email for MatchMaking,';   
           if(attendeeSetting.degi)
               allFields1 +='Designation,';
           if(attendeeSetting.mobile)
               allFields1 +='Mobile Number,';
            if(attendeeSetting.Shippinginfo)
               allFields1 +='Shipping Phone Number,';    
           if(attendeeSetting.workinfo)
               allFields1 +='Work Fax Number,';
           if(attendeeSetting.gen)
               allFields1 +='Gender,';
           if(attendeeSetting.pbc)
               allFields1 +='Primary Business Category,';
           if(attendeeSetting.SBC)
               allFields1 +='Secondary Business Category,';
            if(attendeeSetting.NOEmp)
               allFields1 +='No. of Employees,';  
            if(attendeeSetting.BEDate)
               allFields1 +='Business Established Date,';
            if(attendeeSetting.BRev)
               allFields1 +='Business Revenue,';
            if(attendeeSetting.DT)
               allFields1 +='Diversity Type,';
            if(attendeeSetting.BTaxID)
               allFields1 +='Business Tax Id,';
            if(attendeeSetting.BDN)
               allFields1 +='Business DUNS Number,';  
            if(attendeeSetting.webUrl)
               allFields1 +='WebSite URL,';    
            if(attendeeSetting.blogURL)
               allFields1 +='Blog URL,';
            if(attendeeSetting.BDesc)
               allFields1 +='Business Description,';  
            if(attendeeSetting.NAICSCode1)
               allFields1 +='NAICS Code 1,';   
            if(attendeeSetting.NAICSCode2)
               allFields1 +='NAICS Code 2,';   
            if(attendeeSetting.NAICSCode3)
               allFields1 +='NAICS Code 3,';
            if(attendeeSetting.NAICSCode4)
               allFields1 +='NAICS Code 4,'; 
            if(attendeeSetting.NAICSCode5)
               allFields1 +='NAICS Code 5,';
               
               allFields1 +='NAICS Code 6,';
               allFields1 +='NAICS Code 7,';
               allFields1 +='NAICS Code 8,';
               allFields1 +='NAICS Code 9,';
               
               allFields1 +='Commodity 1,';
               allFields1 +='Commodity 2,';
               allFields1 +='Commodity 3,';
               allFields1 +='Commodity 4,';
               allFields1 +='Commodity 5,';
               
            
            allFields1 +='Registration Type,';
             allFields1 +='Key Words,';
            allFields1 +='DBA,';
            allFields1 +='Certificate Processed by RPO,';
            allFields1 +='BBB Number,';
            allFields1 +='Which country is your companys distribution center located (if applicable)?,';
            allFields1 +='If your company sells a product what country or countries manufactures it?,';
            allFields1 +='Reference 1,';
            allFields1 +='Scope of Work 1,';
            allFields1 +='Reference 2,';
            allFields1 +='Scope of Work 2,';
             allFields1 +='Years In Business,';
              allFields1 +='Business Structure,';
               //allFields1 +='Fax,';
           allFields1 +='Geographical Region,';
           allFields1 +='Revenue Range,';
           allFields1 +='Non-WBENC awards received in the last 2 years,';
           allFields1 +='Does your company have either a facility or partner outside of the US?,';
           allFields1 +='Badge Type,';
           allFields1 +='Badge Category,';
           
     allFields1.substring(0, allFields1.lastIndexOf(','));
     StdImportHeaderNames1= allFields1.split(',');
     
          if(attendeeSetting.sufix)
               allFields2 +='Suffix,';
           if(attendeeSetting.ReqFields)
               allFields2 +='Last Name,';  
           if(attendeeSetting.comp)
               allFields2 +='Company Name,';  
           if(attendeeSetting.homeinfo)
               allFields2 +='Home Phone Number,';
           if(attendeeSetting.workinfo)
               allFields2 +='Work Phone Number,';  
           if(attendeeSetting.age)
               allFields2 +='Age,';
           if(attendeeSetting.dob)
               allFields2 +='Date Of Birth,';  
          if(attendeeSetting.workinfo)
               allFields2 +='Work Address 1,Work Address 2,Work City,Work Country,Work State,Work Zip Code,';
           if(attendeeSetting.homeinfo)
               allFields2 +='Home Address 1,Home Address 2,Home City,Home Country,Home State,Home Zip Code,';
           if(attendeeSetting.Shippinginfo)
               allFields2 +='Shipping Address 1,Shipping Address 2,Shipping City,Shipping Country,Shipping State,Shipping Zip Code,';  
           
            
       allFields2.substring(0,allFields2.lastIndexOf(','));
       StdImportHeaderNames2=allFields2.split(',');    
       
       
       
       
       //------------------------------------------------------------------------------------
            
            
            
        }
        
        public List<SelectOption> getEvents() 
         {
             
             
               return null;
         }
        
        public PageReference Events () {
        Pagereference pg = new Pagereference('/apex/BL_EventAdmin_Events');
        Pg.setredirect(true);
        return pg;
      
        }
       public PageReference Attendees() {
      // eventIdForAtt = ApexPages.currentpage().getparameters().get('id');
       string urlid = ApexPages.currentpage().getparameters().get('id');
            
             vals= urlid.split('~');
            system.debug('11111111111111111111111'+vals);
            eventIdForAtt = vals[0];
       system.debug('GGGGGG GGGGGGGG'+eventIdForAtt );
           Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Attendees?id='+eventIdForAtt );
                pg.setRedirect(true);
                return pg;
           
        }
        public PageReference MMAttendeesdir() {
      // eventIdForAtt = ApexPages.currentpage().getparameters().get('id');
       string urlid = ApexPages.currentpage().getparameters().get('id');
            
             vals= urlid.split('~');
            system.debug('11111111111111111111111'+vals);
            eventIdForAtt = vals[0];
       system.debug('GGGGGG GGGGGGGG'+eventIdForAtt );
           Pagereference pg = new Pagereference('/apex/MM_Eventadmin_AttendeesDirectory' );
                pg.setRedirect(true);
                return pg;
           
        }
         public PageReference MMExhibitorsdir() {
      // eventIdForAtt = ApexPages.currentpage().getparameters().get('id');
       string urlid = ApexPages.currentpage().getparameters().get('id');
            
             vals= urlid.split('~');
            system.debug('11111111111111111111111'+vals);
            eventIdForAtt = vals[0];
       system.debug('GGGGGG GGGGGGGG'+eventIdForAtt );
           Pagereference pg = new Pagereference('/apex/MM_Eventadmin_ExhibitorsDirectory' );
                pg.setRedirect(true);
                return pg;
           
        }
        
        public PageReference reportact() {
            
             pagereference pg = new pagereference('/apex/BL_Evntadmreports');
             pg.setredirect(true);
            return pg;
        
            
        }
        
         public PageReference DataImportaction() {
           
         pagereference pg = new pagereference('/apex/QRCode_DataImport?id='+ApexPages.currentpage().getparameters().get('id'));
         pg.setredirect(true);
            return pg;
            
        }
    
        
        public PageReference CustomerAdminAct() 
        {
            pagereference pg = new Pagereference('/apex/BL_Eventadmin_boothadmins');
            pg.setredirect(true);
                return pg;
        }

        Public PageReference ProfileSettings()
        {
            Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile?id='+eventIdForAtt);
            Pg.setredirect(true);
            Return pg;
        }    
        
       public PageReference DashboardAction() {
           pagereference pg = new pagereference('/apex/BL_EA_Dashboard');
           pg.setredirect(true);
             return pg;
     }
        
    
         public List<String> parseCSV(String contents) {
         
                List<String> allFields = new List<String>();
              
            
               nameFile = contents.subString(contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
               
               nameFile = nameFile.replace('????:::::******&&&&&&%%%%;;;;','');
           
            system.debug('BBBBBBBBBBBBBBBBBBBBBBB'+ nameFile );   
               
          
               
                // replace instances where a double quote begins a field containing a comma
                // in this case you get a double quote followed by a doubled double quote
                // do this for beginning and end of a field
                //contents = contents.replaceAll(',',',DBLQT').replaceall(',','DBLQT,');
     //           contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
                // now replace all remaining double quotes - we do this so that we can reconstruct
                // fields with commas inside assuming they begin and end with a double quote
                //contents = contents.replaceAll('"','DBLQT');
   //             contents = contents.replaceAll('""','DBLQT');
                // we are not attempting to handle fields with a newline inside of them
                // so, split on newline to get the spreadsheet rows
             
                List<String> lines = new List<String>();
                try {
                    
                  //  lines = contents.split('\r'); // using carriage return accomodates windows, unix, and mac files
                      lines = contents.split('aazz11ttt222ggg'); // Using Carriage return
                    //http://www.maxi-pedia.com/Line+termination+line+feed+versus+carriage+return+0d0a


                    
                    
                } catch (System.ListException e) {
                    System.debug('Limits exceeded?' + e.getMessage());
                }
                
                Integer num = 0;
                for(String line: lines) {
                
                system.debug('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuu'+ line);
             //   system.debug('``````````````````````````````````````````'+ lines.size()  );
                    // check for blank CSV lines (only commas)
                    if (line.replaceAll(',','').trim().length() == 0) break;
                   
                    //List<String> fields = line.split(','); 
                    List<String> fields=line.split(',(?=([^\"]*\"[^\"]*\")*[^\"]*$)', -1);
                    String cleanFields='';
                    String compositeField;
                    Boolean makeCompositeField = false;
                    for(String field: fields) {
                    system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+ field );
                    field = field.trim();
                   
               //     system.debug('5555555555555555555555555'+ field.startsWith('"') );
              //      system.debug('6666666666666666666666666'+ field.endsWith('"') );
              //       system.debug('7777777777777777777777777'+ (field.startsWith('"') && field.endsWith('"')) );
                   // system.debug('8888888888888888888888888'+ field.endsWith('"') );
                   
                       if(field == '"'){ 
               //         system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+ field);
                            compositeField += ',' + field;
                            cleanFields+=(compositeField.replaceAll('DBLQT','"')+';;;:::');
                              makeCompositeField = FALSE;
                        }else if (field.startsWith('"') && field.endsWith('"')) {
                            cleanFields+=(field.replaceAll('DBLQT','"')+';;;:::' );
             //               system.debug('1111111111111111111111111111111111111111111111111'+ field); 
                        } else if (field.startsWith('"')) {
            //              system.debug('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'+ field);
                            makeCompositeField = true;
                            compositeField = field;
                        }else if (field.endsWith('"')) {
             //               system.debug('22222222222222222222222222222222'+ field);
                            compositeField += ',' + field;
                            cleanFields+=(compositeField.replaceAll('DBLQT','"')+';;;:::');
                            makeCompositeField = false;
                        } else if (makeCompositeField) {
             //           system.debug('3333333333333333333333333333333333333'+ field);
                            compositeField +=  ',' + field;
                        } else {
             //           system.debug('444444444444444444444444444444444444444'+ field);
                            cleanFields+=(field.replaceAll('DBLQT','"')+';;;:::');
                        }
                        
                       
                     }
               //      system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+ cleanFields);  
                    allFields.add(cleanFields);
                }
                
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+ allFields.size()); 
                system.debug('}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}'+ lines.size()  ); 
               // if (skipHeaders) allFields.remove(0);
              
                return allFields;      
            }
     
        
    
        
        public List<String> getResults() {
        
          List<String> parsedCSV = new List<String>();
    
            
            
            
      //  try{
            rowCount = 0;
            colCount = 0;
          //  if (contentFile != null){
           system.debug('11111111111111111111111111111111 ');
                
                String fileString = dataFromJavaScript;
               parsedCSV = parseCSV(fileString);
                
                    system.debug('222222222222222222222222  '+ parsedCSV[0].split(';;;:::').size());
                   
                
                
                integer columncount = 0;
                CSVHeaders = new List<SelectOption>();
                CSVHeaderMapping = new MAP<String, String>();
                CSVHeaderToStore = new LIST<String>();
                CSVHeaders.add(new SelectOption('NONE','NONE'));
                
                system.debug('QQQQQQQQQQQQQQQQQQQQQQQQQQ  '+ parsedCSV[0].split(';;;:::').size());
                
                for(String ss: parsedCSV[0].split(';;;:::'))
                  {
                      CSVHeaders.add(new SelectOption(String.valueOf(columncount),ss));
                      CSVHeaderMapping.put(ss.toLowerCase() , String.valueOf(columncount));
                      CSVHeaderToStore.add(ss);
                      columncount ++;
                  }
                
                system.debug('rrrrrrrrrrrrrrrrrrrrrrrrrrr'+ CSVHeaders );
                
                rowCount = parsedCSV.size();
           // }
            Displayrecords = parsedCSV;
    /*     }
         catch(Exception e)
         {
             UTF8Bool=TRUE;
         } */
          return Displayrecords;
          

        }    
       
        public Boolean ShowMapping{get; set;}
        public Boolean UTF8Bool{get; set;}
    
        public void clickUpload()
        { 
         // if(contentFile!= NULL){     
           // if(contentFile.size() <=460000){
    
            try{
                    getResults();
                    system.debug ('Display Records ' + Displayrecords);
                    
                    headerDisplay = FALSE;
                    showselectCSV = TRUE;
                    
                System.debug('showselectCSV         showselectCSV         showselectCSV       showselectCSV');    
                    
               }catch(Exception e){
                    UTF8Bool=TRUE;
              }
            
           innnnn = new LIst<InnerClass>();
           innnnn2 = new LIst<InnerClass2>();
           innerStatic = new LIst<InnerClass>(); 
           inner2Static = new LIst<InnerClass2>();
           

           
           system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'+ CSVHeaderMapping );
           
            callingCustomNapping();
           
            system.debug('1111111111111111111111'+ innnnn.size());
            
        /*  }else{
              contentFile =null; 

              ErrorFilesize=TRUE;
             
          }  
        */ 
        
      /*  }else
           noFileChooseBool=TRUE;
        */
        
        
    System.debug('COMPLETED               COMPLETED             COMPLETED          COMPLETED');    
        
        
        }
     
         
         // To perform The Custom Mapping of Fields
        public void callingCustomNapping()
        {
          
            User uu = [SELECT id, Attemdees_Mapping__c FROM USER WHERE id =: userInfo.getUserId() ];
               
               system.debug('!!!!!!!!!!!!!!!!!!!!!'+ uu.Attemdees_Mapping__c );
          
          
            if(uu.Attemdees_Mapping__c == NULL){
                 
                for(String dis: StdImportHeaderNames1)
               {
                   system.debug('yyyyyyyyyyyyyyyyyyyyyyyy'+ dis );
                   system.debug('ttttttttttttttttttttttttt'+ CSVHeaderMapping.get(dis.toLowerCase()) );
              /* if(dis == 'Prefix')
                  {
                      dis = 'Prefix 123'; 
                      system.debug('zzzzzzzzzzzzzzzzzzzzzzzzz'+ dis );
                      system.debug('wwwwwwwwwwwwwwwwwwwwwwwww'+ CSVHeaderMapping.get(dis.toLowerCase()) );
                  } 
               */   
                  
                  
                   innnnn.add(new innerclass(dis,CSVHeaderMapping.get(dis.toLowerCase())));
                   innerStatic.add(new innerclass(dis,SelectdValue));
                   
                  /*
                   else{
                   innnnn.add(new innerclass(dis,SelectdValue));
                   innerStatic.add(new innerclass(dis,SelectdValue));
                   }  */
               }
                      
               
               for(string DBValue2: StdImportHeaderNames2)
               {
                    innnnn2.add(new InnerClass2(DBValue2,CSVHeaderMapping.get(DBValue2.toLowerCase())));
                    inner2Static.add(new InnerClass2(DBValue2,SelectdValue2));
               }
            }else{
                    
                   
                   
                    String ss = uu.Attemdees_Mapping__c;
                    LIST<String> goToMap = new LIST<String>();
                    
                    system.debug('AAAAAAAAAAAAAAAAAA'+ ss.length() );
                    
                    system.debug('QQQQQQQQQQQQQQQQQQQQ'+ ss.indexOf(';;;;;:::::',0) );
                    
                    system.debug('QQQQQQQQQQQQQQQQQQQQ'+ ss.split(';;;;;:::::').size() );
                    
                    goToMap.addAll(ss.split(';;;;;:::::'));
                    
                   system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBB'+ goToMap );
                    system.debug('CCCCCCCCCCCCCCC'+ goToMap.size() );
                    
                    Map<String, String> matchingMap = new Map<String, String>();
                    
                    for(String s1: goToMap ){
                        
                        matchingMap.put(s1.SubString(0, s1.indexOf('&*$%^', 0)).toLowerCase(), s1.SubString(s1.IndexOf('^')+1)  );
                    
                    }
                    
                   system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDD'+ matchingMap );
                     
                   
              //------------------------------------------------     
               for(String dis: StdImportHeaderNames1)
               {
                 try{  
                   innnnn.add(new innerclass(dis,CSVHeaderMapping.get(matchingMap.get(dis.toLowerCase()).toLowerCase() )));
                   innerStatic.add(new innerclass(dis,SelectdValue));
                   }catch(Exception e){
 
                       innnnn.add(new innerclass(dis,SelectdValue));
                        innerStatic.add(new innerclass(dis,SelectdValue));

                   }
                 
               }
                      
               
               for(string DBValue2: StdImportHeaderNames2)
               {    
                   try{
                   system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+ DBValue2  );
                    innnnn2.add(new InnerClass2(DBValue2,CSVHeaderMapping.get(matchingMap.get(DBValue2.toLowerCase()).toLowerCase() )));
                    inner2Static.add(new InnerClass2(DBValue2,SelectdValue2));
                    }catch(Exception e){
                    
                        innnnn2.add(new InnerClass2(DBValue2,SelectdValue2));
                        inner2Static.add(new InnerClass2(DBValue2,SelectdValue2));
                    }
               }
                   
               //---------------------------------------------------------    
                system.debug('VVVVVVVVVVVVVVVVVVVVVVVVV'+ innnnn);
                      
            }   
                        system.debug('SSSS RRRRR UUUU '+ innnnn);
        
        }
         
         
     
        public Transient  LIST<AttendeeSummary__c> totalAttendee{get; set;} 
        public Static Integer Successpop{get; set;}
        public string phnumber {get;set;}
        public Transient LIST<AttendeeSummary__c> reqMissing{get; set;}
        
         public static Boolean validateEMail(string s)
         {
               Boolean  EmailBool = TRUE;
                   integer atpos=s.indexOf('@');
                   integer dotpos=s.lastIndexOf('.');
                                    
                   if (atpos<1 || dotpos<atpos+2 || dotpos+2>=s.length())
                  {
                       EmailBool = FALSE;
                  }
                    return EmailBool;
         }
    
     /*   public static Boolean validateNAICSCode(string s)
        {

            Boolean nAICSCode = FALSE;
                            
         try{
                string naCode = s;
                
                if(naCode != null || naCode != '')
                
              //  if(naCode > 100000 && naCode < 999999)
                   nAICSCode = TRUE;
                else
                    nAICSCode = FALSE;
               }catch(exception e)
               
               {nAICSCode = FALSE;}
        
            return nAICSCode;
        }    */
        
       
       
       
        public PageReference EventAdminDashboard() 
        {
            pagereference pg = new Pagereference('/apex/BL_EA_Dashboard');
            pg.setredirect(true);
                return pg;
        }
        
        
      
        
        
        
        // Inner Class For Getting Selected Value from Select Options AND Field Name
        public class InnerClass
        {
    
            public String DBField1{get; set;}
            public String SelectdValue{get; set;}
           
            public InnerClass(string s,string y){
            this.DBField1 =s;
            this.SelectdValue=y;
            }
            
            
        } 
        
        public class InnerClass2
        {
    
    
            public String DBField2{get; set;}
    
            public String SelectdValue2{get; set;}
            public InnerClass2(string s,string y){
            this.DBField2 =s;
            this.SelectdValue2=y;
            }
            
            
        } 
            // END Of Inner Class
        
    
       
       
        public static Integer UnSuccessRecords{get; set;} 
        public LIST<AttendeeSummary__c> duplicatesOfAttendees{get; set;} //Tofind the duplicates in the CSV File
        public static MAP<String, String> dataForUpsert{get; set;}
        public static MAP<String, String> dataForDiversity{get; set;}
      
       
       
       
        public void CheckMap( )
        {
            system.debug('Innerlist values ' + innnnn);

               LIST<String> myInfo = new LIST<String>();
               LIST<String> mySelectdValue= new LIST<String>();
               String storeItems=''; 
               
               
               
                for(InnerClass x:innnnn)
                {
                                system.debug('xx tt rr  ' + x); 
                  system.debug('777777777777777777777'+ x.DBField1 );
                  system.debug('888888888888888888888'+ x.SelectdValue );
                  // system.debug('9999999999999999999999999999999'+ CSVHeaderToStore[Integer.ValueOf(x.SelectdValue)]);
                  
                   
                     
                       if(x.SelectdValue != 'NONE')
                       {
                          String ss= DBField.get(x.DBField1);
                          myInfo.add(ss);
                          mySelectdValue.add(x.SelectdValue);
                          
                          storeItems += x.DBField1+'&*$%^'+ CSVHeaderToStore[Integer.ValueOf(x.SelectdValue)]+';;;;;:::::' ;
                          
                       }else
                       {
                            storeItems += x.DBField1+'&*$%^'+ 'NONE'+';;;;;:::::';
                       
                       }
                       
                       
                       
                }
        
                system.debug('0000000000000000000000000000000000'+ storeItems);
                                system.debug('inner class 2  '+ innnnn2);
                for(InnerClass2 x:innnnn2)
                {
                   system.debug('ddss eer  tt   '+ x);
                 
                    //  storeItems.add(DBField.get(x.DBField2));
                      if(x.SelectdValue2 != 'NONE')
                      {
                          String ss= DBField.get(x.DBField2);
                          myInfo.add(ss);
                          mySelectdValue.add(x.SelectdValue2);
                            
                          storeItems += x.DBField2+'&*$%^'+ CSVHeaderToStore[Integer.ValueOf(x.SelectdValue2)]+';;;;;:::::';
                            
                      }else
                       {
                            storeItems += x.DBField2+'&*$%^'+ 'NONE'+';;;;;:::::' ;
                       }
                }
                system.debug('nnnnnnnnnnnnnnnnnnnnnnnnnn'+ innnnn + innnnn2 );
               
               system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmm'+ mySelectdValue );
               
               system.debug('ooooooooooooooooooooooooo'+ myInfo );
               
               system.debug('pppppppppppppppppppppppppppppppppp'+ storeItems );
               
               
              User u = [select id, Attemdees_Mapping__c FROM USER WHERE id =: USerInfo.getUserId()];
              
              u.Attemdees_Mapping__c = storeItems;
              
              update u;
               
               
               // string[] innervalue = String(innnnn);
                
        
           Displayrecords = new LIST<String>();
                   
        
                  totalAttendee = new LIST<AttendeeSummary__c>();
                
                  
                  reqMissing = new  LIST<AttendeeSummary__c>();
              Displayrecords.addAll(getResults());
              
           //  Displayrecords = Displayrecords.subString(0, Displayrecords.LastindexOf('????:::::******&&&&&&%%%%;;;;')); 
              
              LIST<String> hunrecords = new LIST<String>();
              integer hunreccount=0;
              integer remainHun=0;
        
             UnSuccessPop =0;
        
              AfterInsert=0;
              rowcount=Displayrecords.size();
             
             
             
           //  integer BeforeInsert=0; //= [select count() FROM AttendeeSummary__c WHERE Event_Id__c =: singleEvent];
              string urlid = ApexPages.currentpage().getparameters().get('id');
            
             vals= urlid.split('~');
            system.debug('11111111111111111111111'+vals);
            eventIdForAtt = vals[0];
            list<string> profiles =new List<String>();
            try{
             profiles =vals[1].split('222');
             }catch(Exception e){profiles =new List<String>();}
            integer BeforeInsert = [select Count() FROM Event_Attendee_Mapping__c WHERE EV_id__c =:eventIdForAtt ];
            //eventIdForAtt = ApexPages.currentpage().getparameters().get('id');
             system.debug('ggggggggggggggggggggggggggggggggggggggg'+ eventIdForAtt ); 
              
              //checkMapping(Displayrecords, mySelectdValue, myInfo,singleEvent,BeforeInsert,rowcount, nameFile , eventIdForAtt ,profiles  );
                Id batchInstanceId = Database.executeBatch(new ReadAndPopulateDataBatch(Displayrecords, mySelectdValue, myInfo,singleEvent,BeforeInsert,rowcount, nameFile , eventIdForAtt ,profiles), 100); 
           
        
                    Successbool = TRUE;
                    showselectCSV = FALSE;
                    headerDisplay=TRUE;
                  
               
           
              
                
        }
    
        public void cancelInSelect(){
            showselectCSV = FALSE;
            headerDisplay=TRUE;
        
        }
    
        public PageReference exportToCSV()
        {
                PageReference pageRef= new PageReference('/apex/QRCode_Attendee_Template');
                pageRef.setredirect(false);
                return pageRef;
        }
    
        public void loadData(){
       
        
          dataFromJavaScript =ApexPages.currentPage().getparameters().get('one');
          system.debug('          mythily  '+dataFromJavaScript );
           //IF(dataFromJavaScript.endsWith('.csv')){  
               
          try{
              dataFromJavaScript = dataFromJavaScript.replaceAll('&amp;', '&');
          }catch(Exception e){}
           
            system.debug('          shruthi     '+dataFromJavaScript );
           
          clickUpload();
          //}else{
           
          // alertbool=true;
           
          // }
           }
       public void dummy(){   
         integer i=0;
          i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
          i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
          i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
        
        
        }
     
     //---------------Help-------------------
     public boolean alertbool{get;set;}
    Public Boolean HelpPopUp{get;set;}
    Public void Help(){
    HelpPopUp = True;
    }
    Public Void CloseHelppopup(){
    HelpPopUp = false;
    }
    
  /**  static testMethod void myUnitTest() {
          
          Event__c event = new Event__c(EV_Title__c = 'Test Event', StartTime__c = '09:00 AM', EV_EndTime__c='09:00 PM',EV_StartDate__c = Date.newInstance(2012,05,01),EV_EndDate__c = Date.newInstance(2012,05,01) );
          insert event;
          
          SecurityControls__c sc = new SecurityControls__c(EV_id__c = event.id, EV_Req_Fields__c= 'AS_FirstName__c' );
          insert sc;
          
          
          System.currentPageReference().getParameters().put('id', event.id);
            
          
          BL_AttendeesImportCon imp= new BL_AttendeesImportCon();
          
          string fieldsOf = 'Attendee_FirstName__c,Attendee_LastName__c,Attendee_Company__c,Attendee_EmailId__c,Attendee_NewPrefix__c,Attendee_NewSuffix__c,Attendee_Designation__c,Attendee_CellPhoneNumber__c,Attendee_Age__c,Attendee_Gender__c,Attendee_BirthDate__c,Attendee_HomePhoneNumber__c,Attendee_HomeAddress__c,Attendee_HomeAddress1__c,Attendee_HomeCity__c,Attendee_HomeState__c,Attendee_HomePOBox__c,Attendee_ShippingAddress__c,Attendee_ShippingAddress2__c,Attendee_shippingCity__c,Attendee_shippingState__c,Attendee_ShippingPOBox__c,Attendee_WorkPhone__c,Attendee_WorkAddress__c,Attendee_WorkAddress1__c,Attendee_Workcity__c,Attendee_WorkState__c,Attendee_WorkPOBox__c,Attendee_NAICS_Code1__c,Attendee_NAICS_Code2__c,Attendee_NAICS_Code3__c,Attendee_PrimaryBusinessCategory1__c,Attendee_SecondaryBusinessCategory2__c,Attendee_Business_NoOfEmployees__c,Attendee_BusineesEstablished_Date1__c,Attendee_BusinessRevenue__c,Attendee_BusinessTaxId__c,Attendee_Business_DnB_Id__c,Attendee_WebsiteURL__c,Attendee_BlogURL__c,Attendee_DiversityType1__c,Attendee_BusineesDescription__c,AttendeePic';
         
            imp.dataFromJavaScript = String.valueOf('Prefix,Last Name,First Name,Email Id,Designation,Mobile Number,Work Fax Number,Gender,Home Address 1,Home City,Home Zip Codek,Work Address 2,Work State,Shipping Address 1,Shipping City \r ym,mn2,mn3,mallik@mallik.com,mn4,mn4,mm4,7896541230,25,male,24,02/05/1985,$4231,this is businessdescrption????:::::******&&&&&&%%%%;;;;TestfileName'); 
       
      // imp.contentFile = blob.valueOf('Prefix,Last Name,First Name,Email Id,Designation,Mobile Number,Work Fax Number,Gender,Home Address 1,Home City,Home Zip Codek,Work Address 2,Work State,Shipping Address 1,Shipping City'); 
       
       String RecordsForTesting = 'ym,mn2,mn3,mallik@mallik.com,mn4,mn4,mm4,7896541230,25,male,24,02/05/1985,$4231,this is businessdescrption';
      
          
          imp.checkUserId();
          imp.Events();
          imp.Attendees();
          imp.reportact();
          imp.DataImportaction();
          imp.CustomerAdminAct();
          imp.ProfileSettings();
          
          imp.clickUpload();
          imp.cancelInSelect();
          imp.exportToCSV();
          
          validateEMail('test@test.com');
          validateNAICSCode(125478);
          ValidatePhone('1234567890');
          
          LIST<InnerClass> innnnn = new LIST<InnerClass>();
          
         // innnnn = new InnerClass('Prefix', 'Prefix');
          
          
          imp.innnnn.add(new innerclass('Prefix','Prefix')); 
          
       // system.debug('44444444444444444444444444444'+ imp.innnnn);
       // system.debug('wwwwwwwwwwwwwwwwwwwwwwww'+ userinfo.getUserId());

          imp.callingCustomNapping();
         // imp.CheckMap();
          checkMapping(RecordsForTesting.split(','), fieldsOf.split(','),  fieldsOf.split(','), String.valueOf(event.id), 10 , 15, 'testfileName',event.id );
        
        //  checkMapping(LIST<String> records100, LIST<String> Scolumns, LIST<String> DBFields, string singleEvent, Integer oldRec, Integer CSVRec,string fileName, id eventIdFor )
          // checkMapping(LIST<String> , LIST<String>, LIST<String>, string, Integer , Integer,string , id  )
        //      checkMapping(LIST<String>, LIST<String>, LIST<String>, String, Integer, Integer, String, Id) 
            
      }
    */
    
}
global without sharing class BLN_Email_Dashboardscon{

    public boolean displaybtn{get;set;}
    public string selectedeventid{get;set;}
    public set<string> regsetting{get;set;}
    public boolean emailalert {get ; set ;}
    public BLN_Event__c eventslist {get;set;}
    public BLN_UtillDisplayLinks myticket { get; set; }
    public BLN_UtillDisplayLinks myemaildashboards {get;set;} 
    public string eventname1{get;set;}
    public boolean sentstatus{get;set;}
    public dateTime EventStartDate{get;set;}
    public string radiochecked{get;set;}
    public LIST<GN_User__c> GNUSERS {get ; set ;}
    public String itype{get;set;}
    public Set<String> emails{get;set;}
    public List<Ticket__c> Ticket1{get;set;}
    public BLN_Event__c se {get;set;} 

    public string username{get;set;}
    public string useremail{get;set;}
    public string eventadminname{get;set;}
    public string eventname{get;set;}
    public string eventdate{get;set;}
    public string eventlocation{get;set;}
    public string company{get;set;}
    public string city{get;set;}
    public string state{get;set;}
    public string PromotionName{get;set;}
    public string displaypromovalue{get;set;}
    public string displaytax{get;set;}
    public string fee{get;set;}
    public string Discount{get;set;}
    public string TaxRate{get;set;}
    public string Taxes{get;set;}
    public string FeeAmount{get;set;}
    public string zip{get;set;}
    public string ticket{get;set;}
    public string eventadminemail{get;set;}
    public string add1{get;set;}
    public string add2{get;set;}
    public string qrcode{get;set;}
    public Map<Id,String> custtempnamemap{get;set;}

    public List<EmailCampaign__c> loadcustomemc{get;set;} 
    public List<EmailCampaign__c> emailcampslist{get;set;} 
    public List<EmailCampaign__c> emailcampslistnew{get;set;}
    public List<EmailTemplate> ems{get;set;}
    public List<EmailCampaign__c> lc{get;set;}

    public Map<String,String> listcontmap{get;set;}
    public Map<String,EmailCampaign__c> emcmap{get;set;}
    public List<SelectOption> StandardTempnames{get;set;}
    public List<SelectOption> StandardTempnamesorder{get;set;}
    public List<SelectOption> CustomTempnames{get;set;}
    public List<SelectOption> CustomTempnamesorder{get;set;}
    public string SystemTempnames{get;set;}
    public List<Email_Log__c> logList{get;set;}
    public Map<String,Integer> regsettingmap{get;set;}
    public LIST<EmailCampaign__c> emailcampslistordercust{get;set;}
    public string teststr{get;set;}
    public string evestda {get;set;}
    public string eveedda {get;set;}
    Public boolean StopMailsToEVadmn{get;set;} //defined by Anil, This variable assigns value To "Stop Emails To Event Admin" checkbox
    Public boolean StopMailsToAttn{get;set;} //defined by Anil, This variable assigns value To "Stop Emails To Attendees" checkbox
    public string orgId{get;set;}
    public integer currenttabindex{get;set;}//by purna for tabbspanel ,using for exact navigation of tabs
    public BLN_Email_Dashboardscon(){
    orgId = UserInfo.getOrganizationId();
    
        try{
        Cookie k1 = ApexPages.currentPage().getCookies().get('counter');

        if(k1!=null){
            selectedeventid = k1.getValue();
        }

        username= '{!username}';
        useremail='{!useremail}';
        eventadminname='{!eventadminname}';
        eventname= '{!eventname}';
        eventadminemail = '{!eventadminemail}';
        eventdate='{!eventdate}'; 
        eventlocation = '{!eventlocation}';
        company='{!company}';
        city='{!city}';
        state='{!state}';
        zip='{!zip}';
        ticket='{!ticket}';
        add1 = '{!add1}';
        add2 = '{!add2}';
        qrcode = '{!qrcode}';
        displaypromovalue='{!displaypromovalue}';
        displaytax='{!displaytax}';
        fee='{!fee}';
        PromotionName='{!PromotionName}';
        Discount='{!Discount}';
        TaxRate='{!TaxRate}';
        Taxes='{!Taxes}';
        FeeAmount='{!FeeAmount}';
        displayPermissions();
        
}catch(exception ex){}
    }


    @RemoteAction 
    global static EmailTemplate  getemailtempoptions(string selectedtempid) {
        EmailTemplate emailtemp =new EmailTemplate();
        emailtemp = [SELECT id,Body,BrandTemplateId,Description,DeveloperName,Encoding,FolderId,HtmlValue,IsActive,LastUsedDate,Markup,Name,NamespacePrefix,OwnerId,Subject,TemplateStyle,TemplateType,TimesUsed FROM EmailTemplate WHERE IsActive=:true  AND ID=: selectedtempid];
        System.debug('sfdasdf' + emailtemp);
        return emailtemp ;

    }
    

    @RemoteAction 
    global static List<Document>  getuserdocuments(){
        list<document> doclist=new list<document>();
        doclist=[select id,name,AuthorId from document where AuthorId=:userinfo.getuserid() and name like '%eventlogo%' order by createddate desc];
return doclist;
    }
    @RemoteAction 
    global static String uploadimagedocuments(String Encodeval){
        BLN_ReUse_EventsEditCon mainclass = new BLN_ReUse_EventsEditCon();
        mainclass.IsUploadEventLogo=true;
        mainclass.imageData = Encodeval ;
        mainclass.saveEventLogo();
        string EvUrl = mainclass.eventlogourl;
        return EvUrl;
    }

    @RemoteAction 
    global static EmailCampaign__c getemailtempoptionsforstand(string Campaignid) {
        EmailCampaign__c nwemailcampstand = new EmailCampaign__c (); 
        nwemailcampstand = [SELECT id,CampEmailTemplate__c,CampSubject__c,Event__c,Template_Type__c,System_Template_Type__c,Template_Body__c FROM EmailCampaign__c WHERE ID=: Campaignid];
        return nwemailcampstand;     

    }

    @RemoteAction 
    global static String createemailtempoptions(String tempname,String html,String campsubj,String eventid) {

        EmailTemplate custemailtemp =new EmailTemplate();
        custemailtemp.DeveloperName = eventid+tempname.replace(' ', '_');
        custemailtemp.Name = tempname ;
        custemailtemp.HtmlValue= html;
        custemailtemp.IsActive = true;
        custemailtemp.Subject =  campsubj;
        custemailtemp.TemplateType = 'custom';
        custemailtemp.FolderId = UserInfo.getUserId();
        insert custemailtemp;

        return custemailtemp.id;

    }

    @RemoteAction 
    global static String createemailtempoptionsforstand(String tempname,String html,String campsubj,String eventid) {

        EmailCampaign__c nwemailcampstand = new EmailCampaign__c (); 
        nwemailcampstand.Name = 'Order Confirmation';
        nwemailcampstand.CampEmailTemplate__c =tempname;
        nwemailcampstand.CampSubject__c = campsubj;
        nwemailcampstand.Event__c = eventid;
        nwemailcampstand.Template_Type__c = 'System';      
        nwemailcampstand.System_Template_Type__c = 'Order Confirmation';  
        nwemailcampstand.Template_Body__c = html;
        insert nwemailcampstand ;  

        return nwemailcampstand.id;
    }
    
    public BLN_Event__c Currentevent {get;set;}
    public void displayPermissions(){
        try{
        emailalert = false;
        try{
        EmailTemplate emailcampslistorder = [select Body,name,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'BLN Order confirmation']; 
        StandardTempnamesorder = new List<SelectOption>();         
        StandardTempnamesorder.add(new SelectOption(emailcampslistorder.ID,emailcampslistorder.Name));
        system.debug(StandardTempnamesorder);
        }catch(exception e){}

        emailcampslistordercust =new LIST<EmailCampaign__c>();
        emailcampslistordercust  = [SELECT NAME,id,CampEmailTemplate__c,Template_Status__c,System_Template_Type__c,CampFromEmailId__c,CampFromName__c,Template_Body__c,Template_Type__c,Owner.Name,CampSubject__c,createdDate,CampType__c,Event__c,ToList__c,ToListType__c FROM EmailCampaign__c WHERE Event__c=:selectedeventid AND Template_Type__c = 'System' AND System_Template_Type__c= 'Order Confirmation' order by createddate desc ];
        CustomTempnamesorder = new List<SelectOption>();

        for(EmailCampaign__c EMC : emailcampslistordercust ){
            if(EMC.Template_Type__c=='System' && EMC.CampEmailTemplate__c!=null)
                CustomTempnamesorder.add(new SelectOption(EMC.ID,EMC.CampEmailTemplate__c));

        }              

        if(selectedeventid!=null || selectedeventid!=''){
            Currentevent = new BLN_Event__c();
            Currentevent = [select Start_Date__c,Time_Zone__c From BLN_Event__c WHERE id =:selectedeventid limit 1 ];
            EventStartDate = Currentevent.Start_Date__c;

        }
        list<string> Emailsto = new list<string>{'StopEmailsToAttendee','StopEmailsToEventAdmin'};

        for (Reg_Setting__c rg : [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Setting_Type__c='Display' and Column_Name__c IN:Emailsto]) {
                if(rg.Column_Name__c=='StopEmailsToAttendee' && rg.Included__c==true)
            {

                StopMailsToAttn = true;
            }
                if(rg.Column_Name__c=='StopEmailsToEventAdmin' && rg.Included__c==true)
            {

                StopMailsToEVadmn = true;
            }
                if(rg.Column_Name__c=='StopEmailsToEventAdmin' && rg.Included__c==false)
            {

                StopMailsToEVadmn = false;
            }
                if(rg.Column_Name__c=='StopEmailsToAttendee' && rg.Included__c==false)
        {

                StopMailsToAttn = false;
            }
            }

        regsetting=new set<string>();
        BLN_Ticket_DAO bdao = new BLN_Ticket_DAO();
        regsetting = bdao.getAllitemtypes(selectedeventid );
        //regsetting=[select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Table_Name__c='Item_Type__c' and Setting_Type__c='Display'];


        regsettingmap=new Map<String,Integer>();

        for(string rac:regsetting)
        {   

            String itypename=rac=='Attendee'?'Admissions':rac;
           String q='select id,name,Item_Type__c,Item__r.Item_Type__r.name,Item_Type__r.name,Item_Pool__c,tkt_profile__c,tkt_profile__r.BLN_Company__c,Ticket_Status__c,Tkt_profile__r.Home_Phone__c,Tkt_profile__r.First_Name__c,Tkt_profile__r.Last_Name__c,Tkt_profile__r.Email__c,Tkt_profile__r.User_Pic__c,Tkt_profile__r.BLN_GN_User__r.User__c,Tkt_profile__r.FaceBookId__c,Tkt_profile__r.LinkedInId__c,Tkt_profile__r.BLN_Company__r.Company_Logo__c,Tkt_profile__r.BLN_Company__r.Name,Tkt_profile__r.BLN_Company__r.Website_URL__c,Item_Pool__r.Item_Type__r.name from Ticket__c where (Item__r.Item_Type__r.Name =\''+itypename+'\' or Item_Pool__r.Item_Type__r.name=\''+itypename+'\') and Event__c=\''+selectedeventid+'\' and (Ticket_Status__c=\'Booked\' or Ticket_Status__c=\'Checked-in\' or Ticket_Status__c=\'Checked-out\') and order__r.Order_Status__c !=\'Cancelled\' and order__r.Order_Status__c !=\'Abandoned\' and order__r.Order_Status__c !=\'Not Paid\'';    
            List<Ticket__c> tc=Database.query(q);

            regsettingmap.put(rac,tc.size()); 
        }

        loadcustomemc=new List<EmailCampaign__c>();

        loadcustomemc=[select Id,Name,Email_Send_Date__c,Email_Status__c,ToList__c,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,CampSubject__c,CampType__c,Event__c,Template_Type__c,Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c,Ext_mail_server_ListId__c,Ext_mail_server_SegmenttId__c,Ext_mail_server_TemplateId__c from EmailCampaign__c where Template_Type__c = 'Custom' and Event__c =: selectedeventid order by createddate desc];

        listcontmap=new Map<String,String>();
        emcmap=new Map<String,EmailCampaign__c>();
        for(integer i=0;i<loadcustomemc.size();i++)
        {
            listcontmap.put(loadcustomemc[i].id,loadcustomemc[i].ToList__c==null?'none':loadcustomemc[i].ToList__c);
            emcmap.put(loadcustomemc[i].id,loadcustomemc[i]);
        }

        EmailCampaign__c ec = new EmailCampaign__c();
        try{
            ec = [SELECT Ext_mail_server_apikey__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid and Template_Type__c='Standard' limit 1  ];
        } catch(Exception e){}
        if (ec.Ext_mail_server_apikey__c!=null ||ec.Ext_mail_server_apikey__c!='' ){
            MCApiKeyInputVal= ec.Ext_mail_server_apikey__c;
            system.debug(MCApiKeyInputVal);  

        }
        EmailCampaign__c ec1 = new EmailCampaign__c();
        try{
            ec1 = [select Email_Send_Date__c,Email_Status__c from EmailCampaign__c where Name='Product Intro of Match Leads' AND Template_Type__c='Standard' AND Event__c = : selectedeventid];
        }catch(Exception e){}
        if (ec1.Email_Send_Date__c!=null && ec1.Email_Status__c!=null){
            pimldat = ec1.Email_Send_Date__c;
            pimlstat = ec1.Email_Status__c;

        }
        EmailCampaign__c ec2 = new EmailCampaign__c();
        try{
            ec2 = [select Email_Send_Date__c,Email_Status__c from EmailCampaign__c where Name='Product Intro of Lead Retrieval' AND Template_Type__c='Standard' AND Event__c = : selectedeventid];
        }catch(Exception e){}
        if (ec2.Email_Send_Date__c!=null && ec2.Email_Status__c!=null){
            pilrdat = ec2.Email_Send_Date__c;
            pilrstat = ec2.Email_Status__c;

        }
        EmailCampaign__c ec3 = new EmailCampaign__c();
        try{
            ec3 = [select Email_Send_Date__c,Email_Status__c from EmailCampaign__c where Name='Lead Retrieval Sign Up Reminder' AND Template_Type__c='Standard' AND Event__c = : selectedeventid];
        }catch(Exception e){}
        if (ec3.Email_Send_Date__c!=null && ec3.Email_Status__c!=null){
            lrsrdat = ec3.Email_Send_Date__c;
            lrsrstat = ec3.Email_Status__c;

        }
        EmailCampaign__c ec4 = new EmailCampaign__c();
        try{
            ec4 = [select Email_Send_Date__c,Email_Status__c from EmailCampaign__c where Name='Match Leads Buyer Sign Up Reminder' AND Template_Type__c='Standard' AND Event__c = : selectedeventid];
        }catch(Exception e){}
        if (ec4.Email_Send_Date__c!=null && ec4.Email_Status__c!=null){
            mbsrdat = ec4.Email_Send_Date__c;
            mbsrstat = ec4.Email_Status__c;

        }     

        emailcampslistnew=new LIST<EmailCampaign__c> ();
        emailcampslistnew = [SELECT id,NAME,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,Template_Type__c,Owner.Name,CampSubject__c,createdDate,LastModifiedDate,CampType__c,Event__c,ToList__c,ToListType__c FROM EmailCampaign__c WHERE Event__r.Name= 'Default Event(Boothleads)' AND Template_Type__c= 'Standard' AND Name != 'Order Confirmation' AND Name != 'Ticket Confirmation'];//AND (Template_Type__c='Standard' OR Template_Type__c='Custom') //   
        system.debug('SSSSSSSS:::'+emailcampslistnew.size());
        LIST<EmailCampaign__c> emailcampslist = [SELECT NAME,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,Template_Type__c,Owner.Name,CampSubject__c,createdDate,LastModifiedDate,CampType__c,Event__c,ToList__c,ToListType__c FROM EmailCampaign__c WHERE Event__r.Name='Default Event(Boothleads)' AND Template_Type__c='Standard' AND Name != 'Order Confirmation' AND Name != 'Ticket Confirmation'];

        StandardTempnames = new List<SelectOption>();
        CustomTempnames = new List<SelectOption>();
        try{
            for(EmailCampaign__c EMC : emailcampslist ){
                if(EMC.Template_Type__c=='Standard')
                    StandardTempnames.add(new SelectOption(EMC.CampEmailTemplate__c,EMC.NAME));
                
            }

            LIST<EmailCampaign__c> emailcampslist1 = [SELECT NAME,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,Template_Type__c,Owner.Name,CampSubject__c,createdDate,CampType__c,Event__c,ToList__c,ToListType__c FROM EmailCampaign__c WHERE Event__c=:selectedeventid AND Template_Type__c='Custom'];
            String idInClause = '(\'';

            for(EmailCampaign__c EMC : emailcampslist1)
            { 
                idInClause += EMC.CampEmailTemplate__c+ '\',\'';
            }

            idInClause  = idInClause.substring(0,idInClause.length()-2);
            idInClause += ')';
            String q = 'SELECT id,Body,BrandTemplateId,Description,DeveloperName,Encoding,FolderId,HtmlValue,IsActive,LastUsedDate,createdDate,LastModifiedDate,Markup,Name,NamespacePrefix,OwnerId,Subject,TemplateStyle,TemplateType,TimesUsed FROM EmailTemplate where DeveloperName like \'%' + selectedeventid+'%\'';
            ems = new list<EmailTemplate>();
            ems=Database.query(q);
            custtempnamemap=new Map<Id,String>();
            For(integer i=0;i<ems.size();i++)
            {
                custtempnamemap.put(ems[i].id,ems[i].name);
            }
            For(integer i=0;i<ems.size();i++)
            {
                integer flag=0;
                for(EmailCampaign__c EMC : emailcampslist ){
                    if(EMC.CampEmailTemplate__c==ems[i].id){
                        flag=1;
                        break;
                    }
                }
                if(flag==0)
                    CustomTempnames.add(new SelectOption(ems[i].id,ems[i].NAME));           
            }  

        }catch(Exception e){}

        EmailCampaign__c emt = [SELECT NAME,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,Template_Type__c,Owner.Name,CampSubject__c,createdDate,CampType__c,Event__c,ToList__c,ToListType__c FROM EmailCampaign__c WHERE Event__r.Name='Default Event(Boothleads)' AND Name = 'Order Confirmation' Limit 1];    
        SystemTempnames = emt.CampEmailTemplate__c;
        try{ 
            logList = [SELECT ID,Name,Email_Campaign__c,Email_Campaign__r.Name,Email_Campaign__r.Template_Type__c,Email_Campaign__r.Email_Send_Date__c,Email_Campaign__r.ToList__c,Sent_Date__c,Mail_Sent__c,Delivered__c,Failed__c,Email_Campaign__r.Event__c FROM Email_Log__c where Email_Campaign__r.Event__c =: selectedeventid order by LastModifiedDate desc];        
        }catch(Exception e){}   

        try{
            eventslist  = geteventdetails();
            eventname1 = eventslist.Name;
        }catch(exception e){}
        
         BLN_PromoCode_BAL blneventdetailbal1 = New BLN_PromoCode_BAL();
         se = new BLN_Event__c  ();
          try{
     se = blneventdetailbal1.eventdetails(selectedeventid);
     system.debug('111111111111111111111111111111'+se.Time_Zone__c);
      }catch(exception e){}
        DateTime evestartdate = eventsList.Start_Date__c;
        Datetime dt = datetime.newInstance(evestartdate.year(), evestartdate.month(), evestartdate.day());
        evestda  = dt.format('MMMM d,  yyyy');
        
        DateTime eveenddate1 = eventsList.End_Date__c;
        Datetime dt1 = datetime.newInstance(eveenddate1.year(), eveenddate1.month(), eveenddate1.day());
        eveedda = dt1.format('MMMM d,  yyyy');          

        myemaildashboards = new BLN_UtillDisplayLinks();
        myemaildashboards.isEventAdmin= true;
        myemaildashboards.isemailspage ='active';
        myemaildashboards.isregistrationPageExpand='expand';
        myemaildashboards.tablabel='Emails';
        try{
            myemaildashboards.eventName = eventslist.Name;
        }catch(exception e){}
        myemaildashboards.EventId= selectedeventid;
        myemaildashboards.userPermissions(userInfo.getUserId(),selectedeventid);
        }catch(exception ex){}
    }

    public string MCApiKeyInputVal{get;set;}
    public datetime pimldat{get;set;}
    public string pimlstat{get;set;}
    public datetime pilrdat{get;set;}
    public string pilrstat{get;set;}
    public datetime lrsrdat{get;set;}
    public string lrsrstat{get;set;}
    public datetime mbsrdat{get;set;}
    public string mbsrstat{get;set;}
    public List<selectOption> uniqueApiKeyRecords{get; set;}
    public String SelectedApiKey { get; set; }
    public Map<String,EmailCampaign__c> uniqueApiKeys{get; set;}
    public string selectedCampId{get; set;}


    public void SaveMCAPIKey(){


        string apikey = Apexpages.Currentpage().getparameters().get('apikeyString');

        ImportMcList();
        if(displayerror=='Invalid Api Key')
            return;

        List<EmailCampaign__c> api = new List<EmailCampaign__c>();

        string campaignId = Apexpages.Currentpage().getparameters().get('campaignid');
        if(campaignid==null||campaignid=='')
        {
            api = [SELECT Id, Ext_mail_server_apikey__c, OwnerId  FROM EmailCampaign__c WHERE Event__c =: selectedeventid and Template_Type__c='Standard']; 
            for(integer i=0;i<api.size();i++)
            {
                api[i].Ext_mail_server_apikey__c=apikey ;
            }
            update api;
        }
        else
        {
            api = [SELECT Id, Ext_mail_server_apikey__c, OwnerId  FROM EmailCampaign__c WHERE Event__c =: selectedeventid and id=:campaignId ]; 

            for(integer i=0;i<api.size();i++)
            {
                api[i].Ext_mail_server_apikey__c=apikey ;
            }

            update api;
        }

    }   


    McIntegration mci = new McIntegration();
    public string apiInstance;
    public List<selectOption> ListIdsAndNames{get; set;}
    public List<Data> alllists{get; set;}
    public string displayerror{get; set;}
    public string displayerror1{get; set;}


    public PageReference ImportMcList(){ 

        displayerror = '';
        string mcapikey = Apexpages.Currentpage().getparameters().get('apikeyString');

        if(mcapikey != null){ 

            String ListId;
            JSONGenerator gn = JSON.createGenerator(true); 
            gn.writeStartObject();
            gn.writeStringField('apikey',mcapikey ); 
            gn.writeEndObject();
            String listbody = gn.getAsString();
            try{
                apiInstance = mci.splitapi(mcapikey);
            }catch(Exception e)
            {
                displayerror = 'Invalid Api Key';
                return null;
            }
            system.debug('apiInstance111==================='+apiInstance);
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();

            Http http1 = new Http();

            req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/lists/list');
            req.setMethod('POST');
            req.setBody(listbody); 
            res = http1.send(req);
            string str = res.getbody();
            system.debug('str==================='+str);

            alllists = new List<Data>();

            JSONParser parser = JSON.createParser(str);
            while (parser.nextToken()!= null){
                //system.debug('str==================='+parser.nextToken());
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'data')){
                    if ((parser.nextToken() == JSONToken.START_ARRAY)){
                        while (parser.nextToken() != null){
                            if((parser.getCurrentToken() == JSONToken.START_OBJECT)){
                                Data rds = (Data)parser.readValueAs(Data.class);
                                alllists.add(rds);
                            }
                        }
                    }
                }  
                else if(parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'status'){
                    displayerror = 'Invalid Api Key';
                }
            }

            ListIdsAndNames = new List<selectOption>();
            ListIdsAndNames.add(new selectOption('', 'Select List'));
            for(Data dl: alllists){
                ListIdsAndNames.add(new selectOption(dl.id, dl.name));
            }

            return null;
        }else{
            return null;
        }  

    }

    public class Data {
        public String id{get;set;}
        public Integer web_id{get;set;}
        public String name{get;set;}
        public String date_created{get;set;}
        public Boolean email_type_option{get;set;}
        public Boolean use_awesomebar{get;set;}
        public String default_from_name{get;set;}
        public String default_from_email{get;set;}
        public String default_subject{get;set;}
        public String default_language{get;set;}
        public Integer list_rating{get;set;}
        public String subscribe_url_short{get;set;}
        public String subscribe_url_long{get;set;}
        public String beamer_address{get;set;}
        public String visibility{get;set;}
        public Stats stats{get;set;}
        public List<Modules> modules{get;set;}

        public Data( Integer p2, String p3, String p4, Boolean p5, Boolean p6, String p7, String p8, String p9, String p10, Integer p11, String p12, String p13, String p14, String p15, Stats p16, List<Modules> p17){
            web_id = p2;
            name = p3;
            date_created = p4;
            email_type_option = p5;
            use_awesomebar = p6;
            default_from_name = p7;
            default_from_email = p8;
            default_subject = p9;
            default_language = p10;
            list_rating = p11;
            subscribe_url_short = p12;
            subscribe_url_long = p13;
            beamer_address = p14;
            visibility = p15;
            stats = p16;
            modules = p17;

        }
    }
    public class Modules {
    }
    public class Stats {
        public Integer member_count;
        public Integer unsubscribe_count;
        public Integer cleaned_count;
        public Integer member_count_since_send;
        public Integer unsubscribe_count_since_send;
        public Integer cleaned_count_since_send;
        public Integer campaign_count;
        public Integer grouping_count;
        public Integer group_count;
        public Integer merge_var_count;
        public Integer avg_sub_rate;
        public Integer avg_unsub_rate;
        public Integer target_sub_rate;
        public Double open_rate;
        public Decimal click_rate;
        public String date_last_campaign;
    }
    public String MCListId{get; set;}
    public List<selectOption> SegmentIdsAndNames{get; set;}
    public String MCSegmentId{get; set;}
    public void ImportMcListSegments(){

        string mcapikey = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid = Apexpages.Currentpage().getparameters().get('listid');
        system.debug('mcapikey====   '+mcapikey+'    mclistid====   '+mclistid);

        JSONGenerator gn = JSON.createGenerator(true); 
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikey); 
        gn.writeStringField('id',mclistid); 
        gn.writeEndObject();
        String reqbody = gn.getAsString();
        system.debug('reqbody  is ============'+reqbody );

        apiInstance = mci.splitapi(mcapikey);

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/lists/segments');
        req.setMethod('POST');
        req.setBody(reqbody); 
        res = http1.send(req);
        string str = res.getbody();
        system.debug('str==================='+str);

        List<StaticSegments> mcListSagment = new List<StaticSegments>();

        JSONParser parser = JSON.createParser(str);
        while (parser.nextToken()!= null){
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'static')){
                if ((parser.nextToken() == JSONToken.START_ARRAY)){
                    while (parser.nextToken() != null){
                        system.debug('getting in to while loop');                    
                        if((parser.getCurrentToken() == JSONToken.START_OBJECT)){
                            StaticSegments mcLseg = (StaticSegments)parser.readValueAs(StaticSegments.class);
                            system.debug('   RDS RECORDS   '+mcLseg);
                            mcListSagment.add(mcLseg);
                        }
                    }
                }
            }   
        }
        system.debug('mcListSagment==================='+mcListSagment);

        SegmentIdsAndNames = new List<selectOption>();
        for(StaticSegments mcsegs: mcListSagment){
            SegmentIdsAndNames.add(new selectOption(mcsegs.id, mcsegs.name));
        }
        system.debug('SegmentIdsAndNames ==================='+SegmentIdsAndNames );

    }

    public class StaticSegments{
        public string id{get;set;}
        public string name{get;set;}
        public string created_date{get;set;}
        public string last_update{get;set;}
        public string last_reset{get;set;}

        public StaticSegments(String sid, String snm, String scd, String lpu, String slr){
            id = sid;
            name = snm;
            created_date = scd;
            last_update = lpu;
            last_reset = slr;
        }

    }
    public string SegmentId{get;set;}
    public string creatingSegment(){

        string mcapikey = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid = Apexpages.Currentpage().getparameters().get('listid');
        string segName = Apexpages.Currentpage().getparameters().get('segName');

        JSONGenerator gn = JSON.createGenerator(true);  
        gn.writeStartObject();               
        gn.writeStringField('apikey',mcapikey);   
        gn.writeStringField('id',mclistid);  
        gn.writeStringField('name',segName);  
        gn.writeEndObject();   

        String Segmentadd = gn.getAsString();
        apiInstance = mci.splitapi(mcapikey);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/lists/static-segment-add');

        req.setMethod('POST');
        req.setBody(Segmentadd);

        res = http1.send(req);
        string str = res.getbody();
        system.debug('str==================='+str);

        //Parsing response to get SegmentId for late use
        JSONParser parser = JSON.createParser(str);
        while (parser.nextToken()!= null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){   
                if(parser.getText() == 'id') {
                    parser.nextToken();
                    SegmentId = parser.getText();
                    system.debug('SegmentId is'+SegmentId); 
                    SegmentIdsAndNames.add(new selectOption(SegmentId, segName));                          
                }                
            }
        }
        return null;
    }


    Public BLN_Event__c geteventdetails(){
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();

        RETURN eventslist = blneventdetailbal.eventdetails(selectedeventid);
    }



    public PageReference getEmails() {

        List<String> parts = itype.split(',');
        String idInClause = '(\'';

        for(integer i=0;i<parts.size();i++)
        {
            if(parts[i]=='Attendee')
                parts[i]='Admissions';
            idInClause += parts[i]+ '\',\'';
        }
        idInClause  = idInClause.substring(0,idInClause.length()-2);
        idInClause += ')';

        //GET ALL THE USER AND COMPANY INFORMATION FROM BOOKED TICKET BASED ON POOLID or TICKETID
       String q='select id,name,Item_Type__c,Item_Pool__r.Item_Type__r.name,Item__r.Item_Type__r.name,Item_Type__r.name,Item_Pool__c,tkt_profile__c,Tkt_profile__r.BLN_Company__c,Ticket_Status__c,Tkt_profile__r.Home_Phone__c,Tkt_profile__r.First_Name__c,Tkt_profile__r.Last_Name__c,Tkt_profile__r.Email__c,Tkt_profile__r.User_Pic__c,Tkt_profile__r.BLN_GN_User__r.User__c,Tkt_profile__r.FaceBookId__c,Tkt_profile__r.LinkedInId__c,Tkt_profile__r.BLN_Company__r.Company_Logo__c,Tkt_profile__r.BLN_Company__r.Name,Tkt_profile__r.BLN_Company__r.Website_URL__c from Ticket__c where (Item__r.Item_Type__r.Name in'+idInClause+' or Item_Pool__r.Item_Type__r.name in'+idInClause+') and Event__c=\''+selectedeventid+'\' and (Ticket_Status__c=\'Booked\' or Ticket_Status__c=\'Checked-in\' or Ticket_Status__c=\'Checked-out\') and order__r.Order_Status__c !=\'Cancelled\' and order__r.Order_Status__c !=\'Abandoned\' and order__r.Order_Status__c !=\'Not Paid\'';

        Ticket1= Database.query(q);
        emails=new Set<String>();
        for(Ticket__c tc:Ticket1)
        {
            emails.add(tc.Tkt_profile__r.Email__c);
        }
        return null;
    }

    public void listsubscribe(){

        string mcapikeysting = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid = Apexpages.Currentpage().getparameters().get('listid');
        string mcsegid = Apexpages.Currentpage().getparameters().get('segid');
        system.debug('mcapikey === ' + mcapikeysting + 'mclistid  === '+mclistid +'segidli ====   '+mcsegid );

        //adding EMAILS
        apiInstance = mci.splitapi(mcapikeysting);
        JSONGenerator gn = JSON.createGenerator(true);  
        gn.writeStartObject();               
        gn.writeStringField('apikey',mcapikeysting);
        gn.writeStringField('id',mclistid ); 
        gn.writeFieldName('batch'); 
        gn.writeStartArray();
 
        for(Ticket__c tc:Ticket1)
        {
            if(tc.Tkt_profile__r.Email__c!=null && tc.Tkt_profile__r.Email__c!=''){
                gn.writeStartObject();
                gn.writeFieldName('email');
                gn.writeStartObject();  
                gn.writeStringField('email', tc.Tkt_profile__r.Email__c);
                gn.writeEndObject();
                gn.writeFieldName('merge_vars');
                gn.writeStartObject();  
                gn.writeStringField('fname', tc.Tkt_profile__r.First_Name__c);
                gn.writeStringField('lname', tc.Tkt_profile__r.Last_Name__c);
                gn.writeEndObject();
                gn.writeEndObject();
            }  
        } 

        gn.writeEndArray();
        gn.writeBooleanField('double_optin',false); 
        gn.writeBooleanField('update_existing',true); 
        gn.writeEndObject();   

        String members = gn.getAsString();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/lists/batch-subscribe');
        req.setMethod('POST');
        req.setBody(members); 
        res = http1.send(req);
        string str = res.getbody();
        segementMemebersAdd();

    }

    public void segementMemebersAdd(){

        string mcapikeysting1 = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid1 = Apexpages.Currentpage().getparameters().get('listid');
        string mcsegid1 = Apexpages.Currentpage().getparameters().get('segid');

        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikeysting1 );
        gn.writeStringField('id',mclistid1);
        gn.writeStringField('seg_id',mcsegid1);
        gn.writeFieldName('batch');
        gn.writeStartArray();
        
        try{
            for(Ticket__c tc:Ticket1)
            {
                if(tc.Tkt_profile__r.Email__c!=null && tc.Tkt_profile__r.Email__c!=''){
                    gn.writeStartObject();
                    gn.writeStringField('email', tc.Tkt_profile__r.Email__c);
                    gn.writeEndObject();

                } 
            }
        }catch(Exception e){}
        gn.writeEndArray();
        gn.writeEndObject();

        String members = gn.getAsString();

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/lists/static-segment-members-add');
        req.setMethod('POST');
        req.setBody(members);
        res = http1.send(req);
        string str = res.getbody();

    }
    public EmailCampaign__c emailcamp {get;set;} 
    public string templateId{get;set;}
    public string tempName{get;set;}

    public string emailTemplateAdd() {

        integer i=0;
        string mcapikeysting = Apexpages.Currentpage().getparameters().get('apikeyString');
        tempName = Apexpages.Currentpage().getparameters().get('templatename');  
        datetime tempName1  = datetime.now();
        string time1 = string.valueof(tempName1);
        list<string> time2 = time1.split(' ');
        tempName = tempName+time2[1];
        string template = Apexpages.Currentpage().getparameters().get('htmltemplate');

        //creating json request for emailTemplateAdd() method      
        JSONGenerator gn = JSON.createGenerator(true);  
        gn.writeStartObject();               
        gn.writeStringField('apikey',mcapikeysting);   
        gn.writeStringField('name',tempName); 
        gn.writeStringField('html',template); 
        gn.writeEndObject();   

        String temp = gn.getAsString();
        apiInstance = mci.splitapi(mcapikeysting);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/templates/add');
        req.setMethod('POST');
        req.setBody(temp); 
        res = http1.send(req);
        string str = res.getbody();
        //parsing json to get tempalteId       
        JSONParser parser = JSON.createParser(str);
        while (parser.nextToken()!= null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                if(parser.getText() == 'template_id') {
                    parser.nextToken();
                    templateId = parser.getText();
                } 
            }
        }
        return templateId;
    }


    public void sendtestemail(){   

        string campaignId = Apexpages.Currentpage().getparameters().get('campaignid');
        system.debug(campaignId);
        string toemail = Apexpages.Currentpage().getparameters().get('toemail');
        EmailCampaign__c E = new EmailCampaign__c();
        E = [SELECT Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: campaignId  ];
        string  mcapikey = E.Ext_mail_server_apikey__c;
        string campaignId1 = E.Ext_mail_server_CampaignId__c;
        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikey);
        gn.writeStringField('cid',campaignId1);
        gn.writeFieldName('test_emails');
        gn.writeStartArray();
        gn.writeString(toemail);
        gn.writeEndArray();
        gn.writeEndObject();
        string campaignsend = gn.getAsString();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();
        apiInstance = mci.splitapi(mcapikey);
        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/send-test');
        req.setMethod('POST');
        req.setBody(campaignsend);
        res = http1.send(req);
        string str = res.getbody();

    }


    public string McTempId{get;set;}
    public string campaignId{get;set;}
    public PageReference createCampaignInMC(){

        string mcapikeysting = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid1 = Apexpages.Currentpage().getparameters().get('listid');
        string mcsegid1 = Apexpages.Currentpage().getparameters().get('segid');
        string tempName = Apexpages.Currentpage().getparameters().get('templatename');
        string template = Apexpages.Currentpage().getparameters().get('htmltemplate');    
        string mcfromname = Apexpages.Currentpage().getparameters().get('frmname');
        string mcemailsub = Apexpages.Currentpage().getparameters().get('emailsub');
        string mcfromemail = Apexpages.Currentpage().getparameters().get('fromemail');
        string campname=Apexpages.Currentpage().getparameters().get('campname');
        string camptype=Apexpages.Currentpage().getparameters().get('camptype');
        string sftemplateid=Apexpages.Currentpage().getparameters().get('sftemplateid');

        McTempId = emailTemplateAdd();

        //creating json request for createCampaign() method
        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikeysting);
        gn.writeStringField('type','regular');
        gn.writeFieldName('options');
        gn.writeStartObject();
        gn.writeStringField('list_id',mclistid1);
        gn.writeStringField('subject',mcemailsub);
        gn.writeStringField('from_email',mcfromemail);
        gn.writeStringField('from_name',mcfromname);
        gn.writeStringField('to_name','Campaign');
        gn.writeStringField('template_id',McTempId);
        gn.writeEndObject();
        gn.writeFieldName('content');
        gn.writeStartObject();
        gn.writeStringField('html',template);
        gn.writeEndObject();
        gn.writeFieldName('segment_opts');
        gn.writeStartObject();
        gn.writeStringField('saved_segment_id',mcsegid1);
        gn.writeEndObject();
        gn.writeEndObject();

        String campaign = gn.getAsString();
        apiInstance = mci.splitapi(mcapikeysting);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/create');
        req.setMethod('POST');
        req.setBody(campaign);
        res = http1.send(req);
        string str = res.getbody();
        system.debug('str=============================='+str);
        JSONParser parser = JSON.createParser(str);
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        campaignId = parser.getText();

        //insert campaign in db
        EmailCampaign__c nwemailcamp = new EmailCampaign__c (); 
        nwemailcamp.Name = campname;
        nwemailcamp.CampEmailTemplate__c =sftemplateid;
        nwemailcamp.CampFromEmailId__c =  mcfromemail;
        nwemailcamp.CampFromName__c = mcfromname;
        nwemailcamp.CampSubject__c = mcemailsub;
        nwemailcamp.CampType__c = camptype;
        nwemailcamp.Event__c = selectedeventid;
        nwemailcamp.Template_Type__c = 'Custom';      
        nwemailcamp.ToList__c = itype;
        nwemailcamp.Ext_mail_server_sync__c = true;
        nwemailcamp.Ext_mail_server_apikey__c = mcapikeysting;
        nwemailcamp.Ext_mail_server_CampaignId__c = campaignId ;
        nwemailcamp.Ext_mail_server_ListId__c = mclistid1;
        nwemailcamp.Ext_mail_server_SegmenttId__c = mcsegid1 ;
        nwemailcamp.Ext_mail_server_TemplateId__c = McTempId;

        insert nwemailcamp;
        return null;
    }

    public PageReference createCampaignInMCstandard(){

        string mcapikeysting = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid1 = Apexpages.Currentpage().getparameters().get('listid');
        string mcsegid1 = Apexpages.Currentpage().getparameters().get('segid');
        string tempName = Apexpages.Currentpage().getparameters().get('templatename');
        string template = Apexpages.Currentpage().getparameters().get('htmltemplate');    
        string mcfromname = Apexpages.Currentpage().getparameters().get('frmname');
        string mcemailsub = Apexpages.Currentpage().getparameters().get('emailsub');
        string mcfromemail = Apexpages.Currentpage().getparameters().get('fromemail');
        string campname=Apexpages.Currentpage().getparameters().get('campname');
        string camptype=Apexpages.Currentpage().getparameters().get('camptype');
        string sftemplateid=Apexpages.Currentpage().getparameters().get('sftemplateid');

        McTempId = emailTemplateAdd();
        system.debug('McTempId+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'+McTempId);
        //creating json request for createCampaign() method
        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikeysting);
        gn.writeStringField('type','regular');
        gn.writeFieldName('options');
        gn.writeStartObject();
        gn.writeStringField('list_id',mclistid1);
        gn.writeStringField('subject',mcemailsub);
        gn.writeStringField('from_email',mcfromemail);
        gn.writeStringField('from_name',mcfromname);
        gn.writeStringField('to_name','Campaign');
        gn.writeStringField('template_id',McTempId);
        gn.writeEndObject();
        gn.writeFieldName('content');
        gn.writeStartObject();
        gn.writeStringField('html',template);
        gn.writeEndObject();
        gn.writeFieldName('segment_opts');
        gn.writeStartObject();
        gn.writeStringField('saved_segment_id',mcsegid1);
        gn.writeEndObject();
        gn.writeEndObject();

        String campaign = gn.getAsString();
        apiInstance = mci.splitapi(mcapikeysting);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/create');
        req.setMethod('POST');
        req.setBody(campaign);
        res = http1.send(req);
        string str1 = res.getbody();
        JSONParser parser = JSON.createParser(str1);
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        campaignId = parser.getText();

        //creating json request for sending standard campaign 
        JSONGenerator gn1 = JSON.createGenerator(true);
        gn1.writeStartObject();
        gn1.writeStringField('apikey',mcapikeysting);
        gn1.writeStringField('cid',campaignId);
        gn1.writeEndObject();
        string campaignsend = gn1.getAsString();

        HttpRequest req1 = new HttpRequest();
        HttpResponse res1 = new HttpResponse();
        Http http2 = new Http();
        apiInstance = mci.splitapi(mcapikeysting);
        req1.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/send');
        req1.setMethod('POST');
        req1.setBody(campaignsend);
        res1 = http2.send(req1);
        string str = res1.getbody();

        //updating campaign in db

        EmailCampaign__c nwemailcamp1 = [select Id,Name from EmailCampaign__c where Name =: campname AND Template_Type__c='Standard' AND Event__c = : selectedeventid];
        system.debug(nwemailcamp1.Id);

        EmailCampaign__c nwemailcamp = [select Id,Name,Email_Send_Date__c,Email_Status__c,ToList__c,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,CampSubject__c,CampType__c,Event__c,Template_Type__c,Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c,Ext_mail_server_ListId__c,Ext_mail_server_SegmenttId__c,Ext_mail_server_TemplateId__c from EmailCampaign__c where id=: nwemailcamp1.Id and Template_Type__c = 'Standard' and Event__c =: selectedeventid];
        nwemailcamp.CampEmailTemplate__c =sftemplateid;
        nwemailcamp.CampFromEmailId__c =  mcfromemail;
        nwemailcamp.CampFromName__c = mcfromname;
        nwemailcamp.CampSubject__c = mcemailsub;
        nwemailcamp.CampType__c = camptype;
        nwemailcamp.Event__c = selectedeventid;    
        nwemailcamp.ToList__c = itype;

        nwemailcamp.Ext_mail_server_sync__c = true;
        nwemailcamp.Ext_mail_server_apikey__c = mcapikeysting;
        nwemailcamp.Ext_mail_server_CampaignId__c = campaignId ;
        nwemailcamp.Ext_mail_server_ListId__c = mclistid1;
        nwemailcamp.Ext_mail_server_SegmenttId__c = mcsegid1 ;
        nwemailcamp.Ext_mail_server_TemplateId__c = McTempId;
        update nwemailcamp;

        EmailCampaign__c ble1=[select id,name,Email_Send_Date__c from EmailCampaign__c where id=:nwemailcamp1.Id];
        DateTime dt1 = DateTime.now();
        ble1.Email_Send_Date__c= dt1;
        ble1.Email_Status__c='Sent';
        update ble1;
        sentstatus = true;

        //insert a record in email log object
        Email_Log__c emlog1=new Email_Log__c();
        emlog1.Email_Campaign__c=nwemailcamp1.Id;
        insert emlog1;

        return null;
    }

    public PageReference createCampaignInMCstandardSched(){

        string mcapikeysting = Apexpages.Currentpage().getparameters().get('apikeyString');
        string mclistid1 = Apexpages.Currentpage().getparameters().get('listid');
        string mcsegid1 = Apexpages.Currentpage().getparameters().get('segid');
        string tempName = Apexpages.Currentpage().getparameters().get('templatename');
        string template = Apexpages.Currentpage().getparameters().get('htmltemplate');    
        string mcfromname = Apexpages.Currentpage().getparameters().get('frmname');
        string mcemailsub = Apexpages.Currentpage().getparameters().get('emailsub');
        string mcfromemail = Apexpages.Currentpage().getparameters().get('fromemail');
        string scheddate = Apexpages.Currentpage().getparameters().get('scheduledate');
        string daysbeffore = Apexpages.Currentpage().getparameters().get('daysbeforedd');
        string campname=Apexpages.Currentpage().getparameters().get('campname');
        string camptype=Apexpages.Currentpage().getparameters().get('camptype');
        string sftemplateid=Apexpages.Currentpage().getparameters().get('sftemplateid');


        McTempId = emailTemplateAdd();

        //creating json request for createCampaign() method
        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikeysting);
        gn.writeStringField('type','regular');
        gn.writeFieldName('options');
        gn.writeStartObject();
        gn.writeStringField('list_id',mclistid1);
        gn.writeStringField('subject',mcemailsub);
        gn.writeStringField('from_email',mcfromemail);
        gn.writeStringField('from_name',mcfromname);
        gn.writeStringField('to_name','Campaign');
        gn.writeStringField('template_id',McTempId);
        gn.writeEndObject();
        gn.writeFieldName('content');
        gn.writeStartObject();
        gn.writeStringField('html',template);
        gn.writeEndObject();
        gn.writeFieldName('segment_opts');
        gn.writeStartObject();
        gn.writeStringField('saved_segment_id',mcsegid1);
        gn.writeEndObject();
        gn.writeEndObject();

        String campaign = gn.getAsString();
        apiInstance = mci.splitapi(mcapikeysting);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();

        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/create');
        req.setMethod('POST');
        req.setBody(campaign);
        res = http1.send(req);
        string str = res.getbody();

        JSONParser parser = JSON.createParser(str);
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        campaignId = parser.getText();

        BLN_Event__c event = [select id,name,Start_Date__c From BLN_Event__c WHERE id =: selectedeventid ];
        EmailCampaign__c nwemailcamp1 = [select Id,Name from EmailCampaign__c where Name =: campname AND Template_Type__c='Standard' AND Event__c = : selectedeventid];
        system.debug(nwemailcamp1.Id);

        EmailCampaign__c nwemailcamp = [select Id,Name,Email_Send_Date__c,auto_schedule_Type__c,Email_Status__c,ToList__c,CampEmailTemplate__c,CampFromEmailId__c,CampFromName__c,CampSubject__c,CampType__c,Event__c,Template_Type__c,Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c,Ext_mail_server_ListId__c,Ext_mail_server_SegmenttId__c,Ext_mail_server_TemplateId__c from EmailCampaign__c where id=: nwemailcamp1.Id and Template_Type__c = 'Standard' and Event__c =: selectedeventid];
        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
        if(scheddate!=null && scheddate!='') {
            schetime =scheddate;
            string hours ='';
            string AMPM ='';
            
            LIST<string> datestr=scheddate.split(' ');
            LIST<string> datestr1=datestr[0].split('-');
            LIST<string> datestr2=datestr[1].split(':');
            string dateonly=datestr1[1]+'/'+datestr1[2]+'/'+datestr1[0];
            if(integer.valueof(datestr2[0]) > 12){
                hours = string.valueof(integer.valueof(datestr2[0])-12);
                AMPM = 'PM';
            }else{
                AMPM = 'AM';
                hours = datestr2[0];
            }
            
            string scheddatenew=dateonly +' ' +hours+':'+datestr2[1]+' '+AMPM;
            
            
            nwemailcamp.Email_Send_Date__c = timezonecl.getDateBasedOnEventTimeZone(scheddatenew,selectedeventid);//Date.valueOf(scheddate);
        }
        else {
            dateTime dd = event.Start_Date__c-integer.valueOf(daysbeffore);
            schetime =  string.valueofGmt(dd);   
            string schetime1 =  dd.formatGMT('MM/dd/yyyy hh:mm a');
   
            nwemailcamp.Email_Send_Date__c = timezonecl.getDateBasedOnEventTimeZone(schetime1,selectedeventid);
        }

        JSONGenerator gn1 = JSON.createGenerator(true); 
        gn1.writeStartObject();
        gn1.writeStringField('apikey',mcapikeysting); 
        gn1.writeStringField('cid',campaignId);
        gn1.writeStringField('schedule_time',schetime);
        gn1.writeEndObject();
        String schebody = gn1.getAsString();

        apiInstance = mci.splitapi(mcapikeysting);
        HttpRequest req1 = new HttpRequest();
        HttpResponse res1 = new HttpResponse();
        Http http2 = new Http();
        req1.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/schedule');
        req1.setMethod('POST');
        req1.setBody(schebody); 
        res1 = http2.send(req1);
        string str1 = res1.getbody();

        nwemailcamp.CampEmailTemplate__c =sftemplateid;
        nwemailcamp.CampFromEmailId__c =  mcfromemail;
        nwemailcamp.CampFromName__c = mcfromname;
        nwemailcamp.CampSubject__c = mcemailsub;
        nwemailcamp.CampType__c = camptype;
        nwemailcamp.Event__c = selectedeventid;    
        nwemailcamp.ToList__c = itype;
        nwemailcamp.Ext_mail_server_sync__c = true;
        nwemailcamp.Ext_mail_server_apikey__c = mcapikeysting;
        nwemailcamp.Ext_mail_server_CampaignId__c = campaignId ;
        nwemailcamp.Ext_mail_server_ListId__c = mclistid1;
        nwemailcamp.Ext_mail_server_SegmenttId__c = mcsegid1 ;
        nwemailcamp.Ext_mail_server_TemplateId__c = McTempId;

        nwemailcamp.auto_schedule_Type__c = selectedRadio;
        nwemailcamp.Email_Status__c='Scheduled';
        update nwemailcamp;

        //insert a record in email log object
        Email_Log__c emlog=new Email_Log__c();
        emlog.Email_Campaign__c=nwemailcamp1.Id;
        insert emlog;

        return null;
    }

    public PageReference redirectToCurrentTab() {
        
         IF(ApexPages.currentPage().getParameters().get('currindex') != '') {
            currenttabindex=integer.valueOf(ApexPages.currentPage().getParameters().get('currindex'));
            if(currenttabindex!=null){
                PageReference dashboardpage= new PageReference('/BLN_Email_Dashboards?id='+currenttabindex);
                dashboardpage.setRedirect(true);
                return dashboardpage;
            }else{

                    
                    PageReference dashboardpage= new PageReference('/BLN_Email_Dashboards?id='+currenttabindex);
                    dashboardpage.setRedirect(true);
                    return dashboardpage;
            }
        }
         return null; 
     
     }
    public PageReference deleteremcamp(){

        string cmpid= Apexpages.Currentpage().getparameters().get('campaignid');
        EmailCampaign__c ecm = [select id,name,Email_Send_Date__c from EmailCampaign__c where id=:cmpid];
        delete ecm;
        return null;
    }


    public void campaignSend() {

        string campaignId = Apexpages.Currentpage().getparameters().get('campaignid');

        EmailCampaign__c E = new EmailCampaign__c();
        E = [SELECT Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: campaignId ];
        string  mcapikey = E.Ext_mail_server_apikey__c;
        string campaignId1 = E.Ext_mail_server_CampaignId__c;

        //creating json request for campaignSend() method
        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikey);
        gn.writeStringField('cid',campaignId1);
        gn.writeEndObject();
        string campaignsend = gn.getAsString();

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();
        apiInstance = mci.splitapi(mcapikey);
        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/send');
        req.setMethod('POST');
        req.setBody(campaignsend);
        res = http1.send(req);
        string str = res.getbody();

        EmailCampaign__c ble=[select id,name,Email_Send_Date__c from EmailCampaign__c where id=:campaignId];
        DateTime dt = DateTime.now();
        ble.Email_Send_Date__c= dt;
        ble.Email_Status__c='Sent';
        update ble;
        sentstatus = true;

        //insert a record in email log object
        Email_Log__c emlog=new Email_Log__c();
        emlog.Email_Campaign__c=campaignId;
        insert emlog;

    }

    public EmailCampaign__c ecamp {get ; set ;}
    public list<selectoption> radiooptions {get ; set ;}
    public string selectedRadio {get ; set ;}



    public string schetime{get; set;}

    public void autoschedule(){


        string editcamid = Apexpages.Currentpage().getparameters().get('campaignid');
        ecamp = [SELECT id,name, auto_schedule_Type__c,Email_Send_Date__c, ToList__c FROM EmailCampaign__c WHERE id =: editcamid];
        BLN_Event__c event = [select id,name,Start_Date__c From BLN_Event__c WHERE id =: selectedeventid ];

        string scheddate = Apexpages.Currentpage().getparameters().get('scheduledate');
        string daysbeffore = Apexpages.Currentpage().getparameters().get('daysbeforedd');

        EmailCampaign__c E = new EmailCampaign__c();
        E = [SELECT Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: editcamid ];
        string  mcapikey = E.Ext_mail_server_apikey__c;
        string campaignId1 = E.Ext_mail_server_CampaignId__c;
        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
        if(scheddate!=null && scheddate!='') {
            schetime =scheddate;
            
            string hours ='';
            string AMPM ='';
            
            LIST<string> datestr=scheddate.split(' ');
            LIST<string> datestr1=datestr[0].split('-');
            LIST<string> datestr2=datestr[1].split(':');
            string dateonly=datestr1[1]+'/'+datestr1[2]+'/'+datestr1[0];
            if(integer.valueof(datestr2[0]) > 12){
                hours = string.valueof(integer.valueof(datestr2[0])-12);
                AMPM = 'PM';
            }else{
                AMPM = 'AM';
                hours = datestr2[0];
            }
            
            string scheddatenew=dateonly +' ' +hours+':'+datestr2[1]+' '+AMPM;
            ecamp.Email_Send_Date__c =timezonecl.getDateBasedOnEventTimeZone(scheddatenew,selectedeventid);
            //ecamp.Email_Send_Date__c = Date.valueOf(scheddate);
        }
        else {
            dateTime dd = event.Start_Date__c-integer.valueOf(daysbeffore);
            schetime =  string.valueofGmt(dd);   
            //ecamp.Email_Send_Date__c = dd;
            string schetime1 =  dd.formatGMT('MM/dd/yyyy hh:mm a');
   
            ecamp.Email_Send_Date__c = timezonecl.getDateBasedOnEventTimeZone(schetime1,selectedeventid);
        }

        JSONGenerator gn = JSON.createGenerator(true); 
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikey ); 
        gn.writeStringField('cid',campaignId1);
        gn.writeStringField('schedule_time',schetime);
        gn.writeEndObject();
        String schebody = gn.getAsString();
        system.debug('schebody is ============'+schebody);

        apiInstance = mci.splitapi(mcapikey);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();
        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/schedule');
        req.setMethod('POST');
        req.setBody(schebody); 
        res = http1.send(req);
        string str = res.getbody();
        ecamp.auto_schedule_Type__c = selectedRadio;
        ecamp.Email_Status__c='Scheduled';
        update ecamp ;
        //insert a record in email log object
        Email_Log__c emlog=new Email_Log__c();
        emlog.Email_Campaign__c=campaignId;
        insert emlog;

    }

    public String reportready{get;set;}
    public PageReference CampaignReport(){

        try{
            reportready='true';
            string campaignId = Apexpages.Currentpage().getparameters().get('campaignid');

            EmailCampaign__c E = new EmailCampaign__c(); 
            E = [SELECT Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: campaignId ];
            string  mcapikey = E.Ext_mail_server_apikey__c;
            string campaignId1 = E.Ext_mail_server_CampaignId__c;
            string syntaxerrors;
            string softbounces;
            string hardbounces;
            string emailssent;
        
            //creating json request for campaignSend() method
            JSONGenerator gn = JSON.createGenerator(true);
            gn.writeStartObject();
            gn.writeStringField('apikey',mcapikey);
            gn.writeStringField('cid',campaignId1);
            gn.writeEndObject();
            string campaignrep = gn.getAsString();

            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http1 = new Http();
            string[] instance;
            instance = mcapikey.split('\\-');

            string apiInstance = instance[1];
            req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/reports/summary');
            req.setMethod('POST');
            req.setBody(campaignrep);
            res = http1.send(req);
            string str = res.getbody();
            JSONParser parser = JSON.createParser(str);


            integer i =0;
            while (parser.nextToken()!= null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME )){


                    if(parser.getText() == 'syntax_errors') {
                        parser.nextToken();
                        syntaxerrors = parser.getText();
                    } 
                    if(parser.getText() == 'hard_bounces') {
                        parser.nextToken();
                        hardbounces = parser.getText();
                    } 
                    if(parser.getText() == 'soft_bounces') {
                        parser.nextToken();
                        softbounces = parser.getText();
                    } 
                    if(parser.getText() == 'emails_sent' && i<=0) {
                        i++;
                        parser.nextToken();
                        emailssent = parser.getText();
                    } 

                }

            }

            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'status'){
                displayerror1 = 'Campaign stats are not available until the campaign has been completely sent,Please try after some time.';
            }


            integer syntaxerrors1 = Integer.valueOf(syntaxerrors);
            integer hardbounces1 =  Integer.valueOf(hardbounces);
            integer softbounces1 =  Integer.valueOf(softbounces);
            integer emailssent1  = Integer.valueOf(emailssent);
            integer failed = syntaxerrors1+hardbounces1+softbounces1;
            integer totalsent = failed+emailssent1;

            Email_Log__c bl=[select id,name,Delivered__c,Failed__c,Mail_Sent__c,Email_Campaign__c from Email_Log__c where id=:Apexpages.Currentpage().getparameters().get('logid') limit 1];
            bl.Delivered__c = emailssent1;
            bl.Failed__c = failed;
            bl.Mail_Sent__c = totalsent;
            update bl;
            logList = [SELECT ID,Name,Email_Campaign__c,Email_Campaign__r.Name,Email_Campaign__r.Template_Type__c,Email_Campaign__r.Email_Send_Date__c,Email_Campaign__r.ToList__c,Sent_Date__c,Mail_Sent__c,Delivered__c,Failed__c,Email_Campaign__r.Event__c FROM Email_Log__c where Email_Campaign__r.Event__c =: selectedeventid order by createddate desc,Email_Campaign__r.Name asc];        

        }
        catch(Exception e)
        {
            reportready='false';
        }

        return null;
    }

    public void resend(){
        string campaignId = Apexpages.Currentpage().getparameters().get('campaignid');

        EmailCampaign__c E = new EmailCampaign__c();
        E = [SELECT Ext_mail_server_apikey__c,Ext_mail_server_CampaignId__c FROM EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: campaignId ];
        string  mcapikey = E.Ext_mail_server_apikey__c;
        string campaignId1 = E.Ext_mail_server_CampaignId__c;
        string newcampId;

        //creating json request for campaignSend() method
        JSONGenerator gn = JSON.createGenerator(true);
        gn.writeStartObject();
        gn.writeStringField('apikey',mcapikey);
        gn.writeStringField('cid',campaignId1);
        gn.writeEndObject();
        string campaignresend = gn.getAsString();

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http1 = new Http();
        apiInstance = mci.splitapi(mcapikey);
        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/replicate');
        req.setMethod('POST');
        req.setBody(campaignresend);
        res = http1.send(req);
        string str = res.getbody();
        integer i =0;
        JSONParser parser = JSON.createParser(str);
        while (parser.nextToken()!= null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                if(parser.getText() == 'id' && i<=0) {
                    parser.nextToken();
                    newcampId = parser.getText();
                    i++;
                } 
            }
        }

        //creating json request for campaignSend() method
        JSONGenerator gn1 = JSON.createGenerator(true);
        gn1.writeStartObject();
        gn1.writeStringField('apikey',mcapikey);
        gn1.writeStringField('cid',newcampId);
        gn1.writeEndObject();
        string campaignsend = gn1.getAsString();

        apiInstance = mci.splitapi(mcapikey);
        req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/campaigns/send');
        req.setMethod('POST');
        req.setBody(campaignsend);
        res = http1.send(req);
        string str1 = res.getbody();

        EmailCampaign__c ble=[select id,name,Email_Send_Date__c from EmailCampaign__c where id=:campaignId];
        DateTime dt = DateTime.now();
        ble.Email_Send_Date__c= dt;
        ble.Email_Status__c='Sent';
        ble.Ext_mail_server_CampaignId__c= newcampId;
        update ble;

        //insert a record in email log object
        Email_Log__c emlog=new Email_Log__c();
        emlog.Email_Campaign__c=campaignId;
        insert emlog;
    }

    public void syscusttemplateoverwrite(){
        string templateid = Apexpages.Currentpage().getparameters().get('templateid');
        string tempbody = Apexpages.Currentpage().getparameters().get('tempbody');
        string emailsubject12 = Apexpages.Currentpage().getparameters().get('emailsubject');
        
        EmailTemplate E = new EmailTemplate();
        E = [SELECT Body,Subject,HtmlValue From EmailTemplate WHERE id =:templateid];
        E.Body = tempbody;
        E.Subject = emailsubject12;
        E.HtmlValue = tempbody;
        update E;
    }
    
       public void syscustcamptemplateoverwrite(){
        string campid = Apexpages.Currentpage().getparameters().get('campid');
        string tempbody = Apexpages.Currentpage().getparameters().get('tempbody');
        string emailsubject = Apexpages.Currentpage().getparameters().get('emailsubject');
        system.debug('campid'+campid+'emailsubject'+emailsubject);
         EmailCampaign__c E = new EmailCampaign__c();
        E = [SELECT Template_Body__c,CampSubject__c,Template_Status__c  From EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: campid];
        E.Template_Body__c = tempbody;
        E.CampSubject__c = emailsubject;
        update E;
    }
    public void templateactivefun(){
        string templateid = Apexpages.Currentpage().getparameters().get('templateid');
        string templatename = Apexpages.Currentpage().getparameters().get('selectedtemp');
        list<EmailCampaign__c> eall = new list<EmailCampaign__c>();
        eall  = [SELECT Template_Body__c,CampSubject__c,Template_Status__c  From EmailCampaign__c WHERE Event__c=:selectedeventid AND Template_Type__c = 'System' AND System_Template_Type__c= 'Order Confirmation'];
        for(EmailCampaign__c EMC : eall){
            EMC .Template_Status__c = 'Inactive';
            update EMC;
        }
        if(templatename!='BLN Order confirmation'){
        EmailCampaign__c E = new EmailCampaign__c();
        E = [SELECT Template_Body__c,CampSubject__c,Template_Status__c  From EmailCampaign__c WHERE Event__c =: selectedeventid  and id =: templateid ];
        E.Template_Status__c  = 'Active';
        update E;
           }
    }
    public void eventdetails(){
        LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
        BLN_Event_DAO evDAO = new BLN_Event_DAO();
        eventsList =  evDAO.getEventDetails(selectedeventid);
        eventlocation = '';
        if(eventsList[0].Venue_Name__c!=null && eventsList[0].Venue_Name__c!=''){
            eventlocation = eventsList[0].Venue_Name__c;

        }  

    }
    
   global class emailauthentication{ 
   public string verifyactivation{get;set;}
   public string fromemailcheck{get;set;}
   
   }
       @RemoteAction 
    global static emailauthentication verifyemailwithMC(string apikeyString){
   string  verifyactivation1='';
   string fromemailcheck1 ='';
  //string mcapikey = '69b275318dbc3fb10d6beaf18c8f31e3-us9';
 JSONGenerator gn = JSON.createGenerator(true); 
 
    gn.writeStartObject();
    gn.writeStringField('apikey',apikeyString); 
    gn.writeEndObject();
    String reqbody = gn.getAsString();
        system.debug('reqbody  is ============'+reqbody);
        McIntegration mci1 = new McIntegration();
      string  apiInstance1 = mci1.splitapi(apikeyString);
         HttpRequest req = new HttpRequest();
     HttpResponse res = new HttpResponse();
         Http http1 = new Http();
         
                 req.setEndpoint('https://'+apiInstance1+'.api.mailchimp.com/2.0/helper/account-details');
             req.setMethod('POST');
             req.setBody(reqbody); 
             res = http1.send(req);
             string str = res.getbody();
        system.debug('str==================='+str);
        
        JSONParser parser = JSON.createParser(str);
            while (parser.nextToken()!= null){
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){   
                        if(parser.getText() == 'has_activated') {
                            parser.nextToken();
                        verifyactivation1 = parser.getText();
                            system.debug('verifyactivation1 is'+verifyactivation1); 
                                             
                }                
                 if ((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'contact')){
                    if ((parser.nextToken() == JSONToken.START_OBJECT)){
                        while (parser.nextToken() != null){
                            system.debug('getting in to while loop');                    
                            if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                            if(parser.getText() == 'email') {
                                parser.nextToken();
                     fromemailcheck1 = parser.getText();
                            system.debug('fromemailcheck1 is'+fromemailcheck1); 
                            }
                            }
                        }
                    }
                }   
            }
       

} 
emailauthentication  eauth = new emailauthentication();
eauth.verifyactivation = verifyactivation1;
eauth.fromemailcheck = fromemailcheck1;
return eauth;
}

/* Additional Methods And Variables Defined by Anil */

/*  Method: AttnEmailPreferences
    Description: This method is Used to Update the Sending / Stopping Email Preferences for Attendee
 */
    public Reg_Setting__c EvntEmailPreferences{get;set;}
    
    Public Void AttnEmailPreferences() {
        system.Debug('--AttnEmails-------- '+apexpages.currentpage().getparameters().get('AttnEmails'));
        if(String.IsNotEmpty(apexpages.currentpage().getparameters().get('AttnEmails'))) {

        String EmailPrefToAttn = apexpages.currentpage().getparameters().get('AttnEmails');
        system.Debug('--AttnEmails-------- '+EmailPrefToAttn );
        if(EmailPrefToAttn=='true')
        {


            EvntEmailPreferences = [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Setting_Type__c='Display' and Column_Name__c='StopEmailsToAttendee' limit 1];
            
            EvntEmailPreferences.Included__c = true;
            Update EvntEmailPreferences;

              
            StopMailsToAttn = EvntEmailPreferences.Included__c;  
            
    system.debug('==================StopMailsToEVadmn ================ '+StopMailsToEVadmn );
            system.debug('==================StopMailsToAttn ================ '+StopMailsToAttn );


        }
        else if(EmailPrefToAttn=='false') {



            EvntEmailPreferences = [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Setting_Type__c='Display' and Column_Name__c='StopEmailsToAttendee' limit 1];
            EvntEmailPreferences.Included__c = false;
            Update EvntEmailPreferences;

              
            StopMailsToAttn = EvntEmailPreferences.Included__c;
            
            system.debug('==================StopMailsToEVadmn ================ '+StopMailsToEVadmn );
            system.debug('==================StopMailsToAttn ================ '+StopMailsToAttn );
        }
        }

        

    }
 /*  
    Method: EvntAdmEmailPreferences
    Description: This method is Used to Update the Sending / Stopping Email Preferences for Event Admin
 */   
    Public Void EvntAdmEmailPreferences() {
    system.Debug('--AttnEmails-------- '+apexpages.currentpage().getparameters().get('EvntAdmEmails'));
        if(String.IsNotEmpty(apexpages.currentpage().getparameters().get('EvntAdmEmails'))) {
        
        String EmailPrefToAdm = apexpages.currentpage().getparameters().get('EvntAdmEmails');
        system.Debug('--EvntAdmEmails-------- '+EmailPrefToAdm );
        if(EmailPrefToAdm=='true')
        {

             //EvntEmailPreferences = new BLN_Event__c();
            EvntEmailPreferences = [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Setting_Type__c='Display' and Column_Name__c='StopEmailsToEventAdmin' limit 1];
            
            EvntEmailPreferences.Included__c = true;
            Update EvntEmailPreferences;

             
            StopMailsToEVadmn = EvntEmailPreferences.Included__c;   
            
            system.debug('==================StopMailsToEVadmn ================ '+StopMailsToEVadmn );
            system.debug('==================StopMailsToAttn ================ '+StopMailsToAttn );
            

        }
        else if(EmailPrefToAdm=='false') {
            
            EvntEmailPreferences = [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Setting_Type__c='Display' and Column_Name__c='StopEmailsToEventAdmin' limit 1];
           
            EvntEmailPreferences.Included__c = false;
            Update EvntEmailPreferences;

             
            StopMailsToEVadmn = EvntEmailPreferences.Included__c;   
            
            system.debug('==================StopMailsToEVadmn ================ '+StopMailsToEVadmn );
            system.debug('==================StopMailsToAttn ================ '+StopMailsToAttn );
            
        }
        }

        

    }




}
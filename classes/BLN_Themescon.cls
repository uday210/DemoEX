global class BLN_Themescon {
public string selectedevent{get;set;}
public  Registration_Template__c csscode{get;set;}
public List<Registration_Template__c> AllRg {get;set;}
public String evename {get;set;}
public BLN_Event__c ee{get;set;}
public LIST<Reg_Setting__c> DisplaySettings {get; set;}
public LIST<Selectoption> listThemes{get; set;}
public BLN_DisplaySettings_BAL DisplaySettingsBAL = new BLN_DisplaySettings_BAL();
public GN_User__c GNUSRSDETAILS {get ; set ;}
public BLN_Template__c templatehtmlnew{get;set;}
BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO();
public List<SelectOption> itemoptions{get;set;}
public String firstitemid {get;set;}
public String firstitemName {get;set;}
public String selecteditemid{get;set;}
 public dateTime EventDaysRemainingDT {get; set;} // To Calculate Event Days Remaining
 public BLN_Event__c registrationEvent {get; set;} // To fetch event details
  BLN_Quick_Registration_BAL3 QuickRegBAL = new BLN_Quick_Registration_BAL3();

//public BLN_RegistrationnewCon regcon {get ; set ;}
public BLN_Themescon(){
 Cookie k = ApexPages.currentPage().getCookies().get('counter');
       
         if(k!=null){
     selectedevent = k.getValue();
     }
    // selectedevent='a1918000000TUoi';
     system.debug('selectedevent======'+selectedevent);
     registrationEvent = QuickRegBAL.getEventDetails(selectedevent);
     EventDaysRemainingDT = registrationEvent.End_Date__c;
     ee=[SELECT Registration_Template__r.id,BLN_Country__r.Currency__r.Name, BLN_Country__r.Currency__r.Currency_Symbol__c, BLN_Country__r.Short_Name__c, organizer_id__c, owner.Name, owner.userName, Event_Ticket_Options__c, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c, Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c, Start_Date__c, End_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, Registration_Template__c, Description__c, Country__c, City__c, CreatedBy.Name, BLN_State__c, BLN_State__r.Long_Name__c, BLN_State__r.Short_Name__c, BLN_State__r.Country__c, BLN_State__r.Country__r.Long_Name__c, BLN_State__r.Country__r.Short_Name__c, Show_Terms_Checkbox__c, Tax_Rate__c, Accept_Tax_Rate__c, Terms_Conditions__c, Accept_Terms_Conditions__c, Accept_Refund_Policy__c, Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c, Event_Blog_URL__c, (SELECT Registration_Type__c, Pay_Gateway__r.use_host_page__c, Pay_Gateway__r.PGateway_Type__r.Name, Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c, Pay_Gateway__r.PG_Email_Id__c, Pay_Gateway__r.PG_Pass_Secret__c, Pay_Gateway__r.PG_Signature__c, Pay_Gateway__r.PG_User_Key__c FROM Event_Pay_Gateway__r), organizer_id__r.owner.id FROM BLN_Event__c WHERE id = :selectedevent];

     //= [select id,Name,Registration_Template__r.id from BLN_Event__c  where id=:selectedevent ];
      System.debug('uuuuuuuuuuuuuu '+ee.Registration_Template__r.id);
     evename= ee.Name;
     try{
    
     csscode=[select id,BLN_Events__c,Styles__c from Registration_Template__c where id=:ee.Registration_Template__r.id];
     }
     catch(exception e){}


 listThemes= new LIST<Selectoption>();
                 
DisplaySettings = new LIST<Reg_Setting__c>();
DisplaySettings = DisplaySettingsBAL.getregsettingslist(ee.id);
GNUSRSDETAILS = new GN_User__c();
//regcon= new BLN_RegistrationnewCon();
        GNUSRSDETAILS = GNDAO.existingGnuser(ee.Organizer_Email__c); 
        
        List<BLN_Item__c> blitemlist=[select id,name,item_name__c,Ordering__c from BLN_Item__c where event__c=:selectedevent ];
 itemoptions=new List<SelectOption>();
    itemoptions.add(new SelectOption('','--None--'));
     SET<Id> ItemsSet = new SET<Id>();
    for(BLN_Item__c blitem:blitemlist)
    {
    itemoptions.add(new SelectOption(blitem.id,blitem.item_name__c));
    ItemsSet.add(blitem.id);
    
        if(blitem.Ordering__c ==1){
            firstitemid  =blitem.id;
            firstitemName =blitem.item_name__c ;
            }
    }
    //Geting the event level survey questions
    LIST<Item_Question__c> EventQuestions=new List<Item_Question__c>();
     BLN_SurveyQuestions_DAO surveyDao = new BLN_SurveyQuestions_DAO();
     BLN_SurveyQuestions_DAO.getQueIdWithQue(RegistrationEvent.id);
     EventQuestions = surveyDao.getEveQuestions(selectedevent);
     LIST<SelectOption> Answers;
     UserAnswer=new List<BLN_RegistrationnewCon3.UserAnswerInnerClass>();
    //System.debug('Event Level Questions' + EventQuestions);
    for (Item_Question__c  q1 : EventQuestions) {
      Question__c q = new Question__c();
      q = BLN_SurveyQuestions_DAO.mapQidWitQue.get(q1.Question__c);
      Boolean isRequired;
      Answers = new LIST<SelectOption>();
      //System.debug('UUUUUUUUUUU ' + q.Answer_Type__c);
      if (q.Answer_Type__c == 'Choose from a list' || q.Answer_Type__c == 'Single Selection' || q.Answer_Type__c == 'Checkboxes' || q.Answer_Type__c == 'Scale') {
        for (BLN_Answer__c a : q.BLN_Answers__r) {
          Answers.add(new SelectOption(a.id, a.Answer_Text__c));
        }
        //System.debug('GGGGGGG KKKKKKKKK  ' + Answers);
      }
      for (Item_Question__c iq : q.Item_Question__r) {
        if (iq.isRequired__c == TRUE) {
          isRequired = TRUE;
        }
      }
      UserAnswer.add(new BLN_RegistrationnewCon3.UserAnswerInnerClass(q, q.BLN_Answers__r, Answers, isRequired, q1));
      //System.debug('lllllllllllll' + buyerTicketInn.UserAnswer);
    }
    
}
public LIST<BLN_RegistrationnewCon3.UserAnswerInnerClass> UserAnswer {get; set;}

@RemoteAction
    global static List<BLN_Item__c>  getitems(String eveid){
    List<BLN_Item__c> blitemlist=[select id,name,item_name__c, Ordering__c  from BLN_Item__c where event__c=:eveid and Ticket_Settings__c= 'Collect info from All Attendees' ORDER by    Ordering__c ASC];
    return blitemlist;
 
    }
    @RemoteAction
    global static List<Item_Pool__c >  getitempool(String eveid){
    List<Item_Pool__c > blitempoollist=[select id,name,Item_Pool_Name__c from Item_Pool__c where event__c=:eveid and Ticket_Settings__c= 'Collect info from All Attendees'];
    return blitempoollist;
 
    }
public BLN_Template_Child__c att{get;set;}
public String html{get;set;}

/*@RemoteAction
    global static BLN_Template_Child__c  getatttemplate(){
    BLN_Template_Child__c att=new BLN_Template_Child__c ();
    att=[select id,name,HTML__c,BLN_Template__c from BLN_Template_Child__c where BLN_Template__r.bln_events__r.name='Default Event(Boothleads)' and BLN_Template__r.Template_Name__c='AttendeeTemplate' and BLN_Template__r.BLN_Reg_Main_Template__r.theme_name__c='Eventdex_Template_1' limit 1];
     
    return att;
 
    }*/

@RemoteAction
    global static List<Reg_Setting__c> getregsettings(String eventId,String ticIds){
    List<Reg_Setting__c> regSettingsover = [select Group_Label__c,id,Defaullt_Label__c,Column_Name__c,Event__c,Included__c,Update_Access__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c  from Reg_Setting__c where (item__c =:ticIds or Item_Pool__c=:ticIds) and event__c=:eventId  order by Group_Order__c,order__c ASC];
   BLN_Reg_Settings_DAO regDao=new BLN_Reg_Settings_DAO();
   List<Reg_Setting__c> regSettings =regDao.setsResDefaultEvent('Regular');
                for(Reg_Setting__c reg:regSettingsover)
                 {
                 for(integer i=0;i<regSettings.size();i++)
                 {
                   if(reg.Defaullt_Label__c==regSettings[i].Defaullt_Label__c)
                   {
                     regSettings[i]=reg;
                   }
                 } 
                }
       List<Reg_Setting__c> regs=new List<Reg_Setting__c>();
     for(integer i=0;i<regSettings.size();i++)
                 {
                   if(regSettings[i].included__c==true)
                   regs.add(regSettings[i]);
                 }     
    return regs;
 
    }
    
    @RemoteAction
    global static List<Reg_Setting__c> getbuyerregsettings(String eventId){
     BLN_Reg_Settings_DAO regDao=new BLN_Reg_Settings_DAO();
    List<Reg_Setting__c> regSettingsover = regDao.setsResevent('Buyer',eventId);
  
   List<Reg_Setting__c> regSettings =regDao.setsResDefaultEvent('Buyer');
                for(Reg_Setting__c reg:regSettingsover)
                 {
                 for(integer i=0;i<regSettings.size();i++)
                 {
                   if(reg.Defaullt_Label__c==regSettings[i].Defaullt_Label__c)
                   {
                     regSettings[i]=reg;
                   }
                 } 
                }
       List<Reg_Setting__c> regs=new List<Reg_Setting__c>();
     for(integer i=0;i<regSettings.size();i++)
                 {
                   if(regSettings[i].included__c==true)
                   regs.add(regSettings[i]);
                 }     
    return regs;
 
    }
    
    
    public PageReference loadmapping()
    {
String tname = Apexpages.currentPage().getParameters().get('tempname');
system.debug('tname==='+tname); 
     att=new BLN_Template_Child__c ();
    try {
    att=[select id,name,HTML__c,BLN_Template__c from BLN_Template_Child__c where BLN_Template__r.bln_events__r.name='Default Event(Boothleads)' and BLN_Template__r.Template_Name__c='AttendeeTemplate' and BLN_Template__r.BLN_Reg_Main_Template__r.theme_name__c=:tname limit 1];
     html=att.html__c;
     } catch (exception ee){
 BLN_Template__c    att1=[select id,name,HTML__c,BLN_Events__r.name from BLN_Template__c where BLN_Events__r.name='Default Event(Boothleads)' and Template_Name__c='AttendeeTemplate' and BLN_Reg_Main_Template__c=''limit 1]; 
      html=att1.html__c;
     }
    
    
    return null;
    }
    
    
public void csssave(){
//csscode=[select id,BLN_Events__c,Styles__c from Registration_Template__c where BLN_Events__c=:selectedevent limit 1];
string custcsscode = apexpages.currentpage().getparameters().get('cuscss');
string themename = apexpages.currentpage().getparameters().get('themename');
//csscode= new Reg_page_save__c();
system.debug('custcsscode======'+custcsscode);
Registration_Template__c Rg = new Registration_Template__c ();
Rg.Name='Eventdex Default Template';
Rg.Theme_Name__c = themename;
Rg.Styles__c = custcsscode;
Rg.BLN_Events__c= selectedevent;
Rg.Template_Image_URL__c='123';

insert Rg;
}


@RemoteAction
    public static Integer getThemes(String thname,String Eveid) {
  
    Integer statusflag=0;
    
    system.debug('tempid============'+thname);
     system.debug('eventid is ========='+Eveid);
       List< Registration_Template__c> Rg = [SELECT id,Name,Theme_Name__c FROM Registration_Template__c WHERE Theme_Name__c =:thname and BLN_Events__c=:Eveid];
        if(Rg.size()>0){
        statusflag =1;
        }
        else{
        statusflag=0;
        }
        System.debug('Status flag is '+statusflag);
        return statusflag;
    }
//@RemoteAction
//public static List< Registration_Template__c> getAllThemes(String Eid){

//List< Registration_Template__c> AllRg = [SELECT id,Name,Styles__c FROM Registration_Template__c WHERE  BLN_Events__c=:Eid];

//return AllRg;

//}

@RemoteAction
    public static String savesRegTempl(String regtemp,String eventid) {
    
    System.debug('vvvvvv '+regtemp);
    System.debug('aaaaa '+eventid);
    BLN_Event__c ble=new BLN_Event__c(id=eventid,Registration_Template__c=regtemp);
    upsert ble;
  
    
    return 'success';
   }
   
   @RemoteAction
    public static Registration_Template__c  getThemewithid(String thid) {
    
    Registration_Template__c singleTheme= [SELECT id,Name,Styles__c,Theme_Name__c FROM Registration_Template__c WHERE  id=:thid];

    
    return singleTheme;
   }

//update theme css

@RemoteAction
    public static string updatetheme(String tname,String tcss,String tid) {
    
    Registration_Template__c updateSingleTheme= new  Registration_Template__c(id=tid,Name='Eventdex Default Template',Theme_Name__c=tname,Styles__c =tcss);

    update updateSingleTheme;
    return 'success';
   }
   
   //update Theme name
   @RemoteAction
    public static string updatethemename(String tname,String tid) {
    
    Registration_Template__c updateSingleTheme= new  Registration_Template__c(id=tid,Name='Eventdex Default Template',Theme_Name__c=tname);

    update updateSingleTheme;
    return 'success';
   }


//end of update theme

//delete individual theme 
@RemoteAction
    public static Integer deleteindividualtheam(String themeid,String Eveid) {
    
    Integer statusflag=0;
    
   BLN_Event__c ee= [select id,Registration_Template__r.id from BLN_Event__c  where id=:Eveid];
     
     if(ee.Registration_Template__r.id == themeid){
     
     statusflag=0;
     }
     else{
     
     //delete the theme
      Registration_Template__c Rg = [SELECT id,Name FROM Registration_Template__c WHERE id=:themeid and BLN_Events__c=:Eveid];
       delete Rg;
     statusflag=1;

     }
     
        return statusflag;
    }
@RemoteAction
    public static Integer duplicatetheme(String tname,String tcss,String tid,String eventid){
    Integer statusflag=0;
    
     
       List< Registration_Template__c> Rg = [SELECT id,Name,Theme_Name__c FROM Registration_Template__c WHERE Theme_Name__c =:tname and BLN_Events__c=:eventid];
        if(Rg.size()>0){
        statusflag =1;
        }
        else{
        statusflag=0;
        }
        
        
        if(statusflag ==0){
        System.debug('RRRRRRR');
        Registration_Template__c newrg = new Registration_Template__c(Name='Eventdex Default Template',Theme_Name__c=tname ,Styles__c =tcss,Template_Image_URL__c='123',BLN_Events__c=eventid);//Rg.Template_Image_URL__c='123';
        
        insert newrg;
        }
        return statusflag;
    
    
    
    
    return statusflag;
    
    }
    
      @RemoteAction
    public static set<String> alltemplatenames(String Eid){
    
    List<Registration_Template__c> allnames= [select name from Registration_Template__c where BLN_Events__c=:Eid];
    set<String> allname= new set<String>();
    for(Registration_Template__c rrr:allnames){
    
    allname.add(rrr.Name);
    }
    return  allname;
    
    }
    //get all standard themes
    @RemoteAction
    public static list<Registration_Template__c> allstandardthemes(){
    
    List<Registration_Template__c> Allsthemes = [select name,Styles__c,Theme_Name__c,BLN_Events__r.Name from Registration_Template__c where BLN_Events__r.Name='Default Event(Boothleads)'];
    
    return Allsthemes;
    }
    
@RemoteAction
public static Map<String,List<Registration_Template__c>> getAllThemes(String Eid){
set<String> allname= new set<String>();
list<String> alllist = new list<String>();
List<Registration_Template__c> AllRg = [SELECT id,Name,Styles__c,Theme_Name__c FROM Registration_Template__c WHERE  BLN_Events__c=:Eid];

 BLN_Event__c ee= [select id,Registration_Template__r.id from BLN_Event__c  where id=:Eid];
  
    for(Registration_Template__c rrr:AllRg){
    
    allname.add(rrr.Name);
    }
    alllist = new list<String>();
    alllist.addAll(allname);
   
 
 // System.debug('222222 '+ee.Registration_Template__r.id);
list<subwrapper> finallist= new list<subwrapper>();
//Map<String,list<subwrapper>> flist = new Map<String,list<subwrapper>>();
Map<String,List<Registration_Template__c>> flist = new Map<String,List<Registration_Template__c>>();

for(Integer i=0;i<alllist.size();i++){
List<Registration_Template__c> abc= [SELECT id,Name,Styles__c,Theme_Name__c FROM Registration_Template__c WHERE  BLN_Events__c=:Eid AND Name =:alllist[i]];


for(Registration_Template__c a:abc)
{
//System.debug('111111111111 '+ee.Registration_Template__r.id);
finallist.add(new subwrapper(a,ee.Registration_Template__r.id));
} 

//flist.put(alllist[i],finallist);
flist.put(alllist[i],abc);
}

//return finallist;
//list<aggregateResult> = [SELECT BLN_Events__c e,Name n,Theme_Name__c tname FROM Registration_Template__c WHERE BLN_Events__c=:Eid GROUP BY bln_events__c,name,Theme_Name__c ]
return flist;

}


    public class subwrapper{
   
    public Registration_Template__c rr;
    public String active;
   
    public subwrapper(Registration_Template__c rr,String Eveid){
  
  
   this.rr=rr;
   if(Eveid==rr.id){
   this.active='[Published]';
   }
   else{
   this.active='';
   }
    } 
  
    
    }
 //BLN_Template__c
 
 @RemoteAction
 public static list<BLN_Template__c> getTemplateHtml(string eventIdasParameter){
 System.debug('HIiiiii===> '+eventIdasParameter);//Default Event(Boothleads)
 
 list<BLN_Template__c> templatehtml = [select name,Template_Name__c,HTML__c,BLN_Events__r.Name from BLN_Template__c Where BLN_Events__r.Name='Default Event(Boothleads)' AND BLN_Reg_Main_Template__c=null];
 
 return templatehtml;
 }
 @RemoteAction 
 
 public static String saveRegtemplateHtml(String eventid,String Html,list<String> selectedwidgets,String Templatename,String selectedwidgetshtml,String pagetype,String themeid){
 
 System.debug('=========>');
 System.debug(selectedwidgetshtml);
 
 
 
 
 map<String,BLN_Template__c> widgetsmap = new map<String,BLN_Template__c>();
 List<BLN_Template__c> allwidgets = [select id,name,Template_Name__c,HTML__c,BLN_Events__r.name From BLN_Template__c where BLN_Events__r.Name='Default Event(Boothleads)'];
 
 
 BLN_Reg_Main_Template__c template = new BLN_Reg_Main_Template__c();
 template.Data__c=Html;
 template.BLN_Events__c=eventid;
 //template.Name=Templatename;
 template.structure_type__c=pagetype;
 template.Theme_Name__c = Templatename;
 template.BLN_Registration_Template_del__c   = themeid;
 insert template;
 
  List<BLN_Template__c> widgetsforthisevent  = new List<BLN_Template__c>();
  JSONParser parser = JSON.createParser(selectedwidgetshtml);
    while (parser.nextToken() != null) { 
     if (parser.getCurrentToken() == JSONToken.START_ARRAY) {       
       while (parser.nextToken() != null) {
          if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            Jsonparsercls le = (Jsonparsercls)parser.readValueAs(Jsonparsercls.class);
            
            System.debug(le.id);
            System.debug(le.HTML);
         BLN_Template__c individualwidget = new BLN_Template__c();
 
         individualwidget.HTML__c =le.HTML;
         individualwidget.BLN_Events__c = eventid;
         individualwidget.Template_Name__c=le.id;
         individualwidget.BLN_Reg_Main_Template__c = template.id;
         individualwidget.Order__c=le.order;
         widgetsforthisevent.add(individualwidget);
            
           
          }
       }
      }
    }

 

 
 insert widgetsforthisevent;
 
 
 return 'success';
 } 
 @RemoteAction 
 public static String saveRegtemplateTicketHtml(String eventid,String Templatename,String selectedwidgetshtml,String pagetype){

 BLN_Template__c att=[select id,name,HTML__c from BLN_Template__c where bln_events__c=:eventid and Template_Name__c='AttendeeTemplate' and BLN_Reg_Main_Template__r.theme_name__c=:Templatename limit 1];
 JSONParser parser = JSON.createParser(selectedwidgetshtml);
 List<BLN_Template_Child__c> widgetsforthisevent  = new List<BLN_Template_Child__c>();
    while (parser.nextToken() != null) { 
     if (parser.getCurrentToken() == JSONToken.START_ARRAY) {       
       while (parser.nextToken() != null) {
          if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            Jsonparsercls le = (Jsonparsercls)parser.readValueAs(Jsonparsercls.class);
            BLN_Template_Child__c individualwidget = new BLN_Template_Child__c();
 
         individualwidget.HTML__c =le.HTML;
         try{
         
         BLN_Item__c it=new BLN_Item__c();
         it.id=le.id;
         individualwidget.BLN_Item__c=le.id;
         }
         catch(Exception e){
         //if it is a poolid when lineitem settings
         individualwidget.BLN_Item_Pool__c=le.id;
         }
         individualwidget.BLN_Template__c= att.id;
          widgetsforthisevent.add(individualwidget);
            
           
          }
       }
      }
    }
            
 try{
 insert widgetsforthisevent;
 }catch(Exception e){return String.valueOf(e);}
 return 'success'; 
}


//new code by Uday to update item level html

 @RemoteAction 
 public static String updateRegtemplateTicketHtml(String itemid,String AttendeetemplateId,String selectedwidgetshtml,String tickettype){
 
 list<BLN_Template_Child__c> childtoupdate = new list<BLN_Template_Child__c>();
 if(tickettype == 'item'){
 childtoupdate = [select   BLN_Item__r.Item_Pool__r.name,BLN_Item__r.item_type__r.Name,id,name,BLN_Item__c,BLN_Template__c from BLN_Template_Child__c where BLN_Item__c=:itemid and BLN_Template__c=:AttendeetemplateId];

 
 }else if(tickettype == 'itempool'){
childtoupdate = [select id,name,BLN_Item__c,BLN_Template__c from BLN_Template_Child__c where BLN_Item_Pool__c=:itemid and BLN_Template__c=:AttendeetemplateId];
 
 }
 JSONParser parser = JSON.createParser(selectedwidgetshtml);
 List<BLN_Template_Child__c> widgetsforthisevent  = new List<BLN_Template_Child__c>();
    while (parser.nextToken() != null) { 
     if (parser.getCurrentToken() == JSONToken.START_ARRAY) {       
       while (parser.nextToken() != null) {
          if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            Jsonparsercls le = (Jsonparsercls)parser.readValueAs(Jsonparsercls.class);
            BLN_Template_Child__c individualwidget = new BLN_Template_Child__c();
 
         individualwidget.HTML__c =le.HTML;
         if(tickettype == 'item'){
         individualwidget.BLN_Item__c=le.id;
         }else if(tickettype == 'itempool'){
          individualwidget.BLN_Item_Pool__c=le.id;
          
          }
         individualwidget.BLN_Template__c= AttendeetemplateId;
         if(childtoupdate.size()>0)
         individualwidget.id=childtoupdate[0].id;
          widgetsforthisevent.add(individualwidget);
            
           
          }
       }
      }
    }
            
 
 upsert widgetsforthisevent;
 return 'success'; 
}




 
 public void templateportion(){
 
 // templatehtmlnew = new BLN_Template__c();
 //templatehtmlnew = [select name,HTML__c from BLN_Template__c Where BLN_Events__c=:selectedevent limit 1];
 System.debug('uday 123 123 123'+templatehtmlnew );
 //return templatehtml;
 }
 
 
  public class Jsonparsercls{  
  public String id{get;set;}
  public String HTML{get;set;}
  public Integer order{get;set;} 
 }
 
 
  @RemoteAction
 public static list<BLN_Reg_Main_Template__c > getAllTemplates(string eventIdasParameter){
 
list<BLN_Reg_Main_Template__c>  templates =[select id,name,Data__c,InUse__c,Theme_Name__c,BLN_Registration_Template_del__c,BLN_Registration_Template_del__r.Theme_Name__c  from BLN_Reg_Main_Template__c where BLN_Events__c=:eventIdasParameter AND structure_type__c='Welcome Page'];

 return templates;
 }
 
 
 
  @RemoteAction
 public static list<BLN_Reg_Main_Template__c > getAllStandardTemplates(){
 
list<BLN_Reg_Main_Template__c>  templates =[select id,name,Theme_Name__c,Data__c,BLN_Events__r.Name from BLN_Reg_Main_Template__c where BLN_Events__r.Name=:'Default Event(Boothleads)' AND structure_type__c='Welcome Page'];

 return templates;
 }
 
   @RemoteAction
 public static list<BLN_Reg_Main_Template__c > getAllStandardTemplatessecondpage(){
 
list<BLN_Reg_Main_Template__c>  templates =[select id,name,Theme_Name__c,Data__c,BLN_Events__r.Name from BLN_Reg_Main_Template__c where  structure_type__c='Registration Page'];

 return templates;
 }
 
 
 
 
  @RemoteAction
 public static list<BLN_Template__c> getWidgetsForTemplate(string Templateid){
 
list<BLN_Template__c>  widgets=[select id,Template_Name__c,HTML__c from BLN_Template__c where BLN_Reg_Main_Template__c=:Templateid];

 return widgets;
 }
  @RemoteAction
 public static list<BLN_Template__c> getWidgetsForSecondTemplate(string Thename){
 
list<BLN_Template__c>  widgets=[select id,Template_Name__c,HTML__c,BLN_Events__r.Name,BLN_Reg_Main_Template__r.Theme_Name__c,BLN_Reg_Main_Template__r.structure_type__c from BLN_Template__c where BLN_Reg_Main_Template__r.Theme_Name__c=:Thename AND   BLN_Reg_Main_Template__r.structure_type__c='Registration Page' ];

 return widgets;
 }
 
 
  @RemoteAction
 public static String publishTemplate(string Templateid,String eventid,String tempname){
 
list<BLN_Reg_Main_Template__c>  Alltemplate=[select id,Theme_Name__c,structure_type__c,InUse__c from BLN_Reg_Main_Template__c where BLN_Events__c=:eventid];
list<BLN_Reg_Main_Template__c>  Alltemplatesmodified = new list<BLN_Reg_Main_Template__c>();
for(Integer i=0;i<Alltemplate.size();i++){
BLN_Reg_Main_Template__c indtemp = new BLN_Reg_Main_Template__c();

if(Templateid != Alltemplate[i].id && Alltemplate[i].Theme_Name__c!=tempname )// && (Alltemplate[i].structure_type__c !='Welcome Page'|| Alltemplate[i].structure_type__c != 'Registration Page')
{
indtemp.id=Alltemplate[i].id;
indtemp.InUse__c =false;
}
else if(Templateid == Alltemplate[i].id)
{
indtemp.id=Alltemplate[i].id;
indtemp.InUse__c =true;
}
else if(Alltemplate[i].Theme_Name__c==tempname && Alltemplate[i].structure_type__c == 'Registration Page'){
indtemp.id=Alltemplate[i].id;
indtemp.InUse__c =true;

}

Alltemplatesmodified.add(indtemp);

}

update Alltemplatesmodified;


 return 'success';
 }
 
 @RemoteAction
 
 public static String copystandardwidgets(String Templateid,String eventid,String Html,String Templatename,String strtype){
 BLN_Reg_Main_Template__c template = new BLN_Reg_Main_Template__c();
 template.Data__c=Html;
 template.structure_type__c=strtype; 
 template.BLN_Events__c=eventid;
 //template.Name=Templatename;
 template.Theme_Name__c = Templatename;
insert template;

list<BLN_Template__c>  widgets=[select id,Template_Name__c,HTML__c from BLN_Template__c where BLN_Reg_Main_Template__c=:Templateid];
list<BLN_Template__c>  thiseventwidgets =new list<BLN_Template__c>(); 
        for(Integer i=0;i<widgets.size();i++)
            {
            BLN_Template__c bb = new BLN_Template__c();
             bb.HTML__c =widgets[i].HTML__c;
         bb.BLN_Events__c = eventid;
         bb.Template_Name__c=widgets[i].Template_Name__c;
         bb.BLN_Reg_Main_Template__c = template.id;
         thiseventwidgets.add(bb);

            }
            insert thiseventwidgets;
            
            
 return 'success';
 } 
 
 
 @RemoteAction
 
 public static string UpdateRegtemplateHtml(String evid,String gridhtml,String allwidgets,String gridid,String themeid)
 {
List<id> widids= new list<id>();
List<BLN_Template__c > delwidids = new list<BLN_Template__c >();
String idsstring ;
list<BLN_Template__c>  widgets=[select id,Template_Name__c,HTML__c from BLN_Template__c where BLN_Reg_Main_Template__c=:gridid];

 
 BLN_Reg_Main_Template__c template = new BLN_Reg_Main_Template__c();
 template.id=gridid;
 template.Data__c=gridhtml;
 template.BLN_Registration_Template_del__c   = themeid;
 
 update template;

 
 List<BLN_Template__c> widgetsforthisevent  = new List<BLN_Template__c>();
  JSONParser parser = JSON.createParser(allwidgets);
    while (parser.nextToken() != null) { 
     if (parser.getCurrentToken() == JSONToken.START_ARRAY) {       
       while (parser.nextToken() != null) {
          if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            JsonparserclsNew le = (JsonparserclsNew)parser.readValueAs(JsonparserclsNew.class);
            
          BLN_Template__c individualwidget = new BLN_Template__c();
         if(le.ActualId !='newwidget'){
         individualwidget.id= le.ActualId;
         }
         individualwidget.HTML__c =le.HTML;
         individualwidget.BLN_Events__c = evid;
         individualwidget.Template_Name__c=le.id;
         individualwidget.BLN_Reg_Main_Template__c = template.id;
         individualwidget.Order__c=le.order;
         widgetsforthisevent.add(individualwidget);
            
           idsstring+= le.ActualId+',';
          }
       }
      }
    }
for(BLN_Template__c btc:widgets)
{
if(!idsstring.contains(btc.id)){
delwidids.add(btc);
}
}
if(delwidids.size() != null){

System.debug('=>=>=> '+delwidids);

 delete delwidids;
 }
 
 
 upsert widgetsforthisevent;
 
 return 'success';
 }
 
 
 
 
  public class JsonparserclsNew{  
  public String id{get;set;}
  public String HTML{get;set;}
  public Integer order{get;set;} 
  public String ActualId{get;set;}
 }
 
 //method to save default child recods for Attendee template if there is no mapping is done
 @RemoteAction
 
 public static string saveDefaultTicketHtml(String eventid,String standardtemplatename,String presentTemplatename){
 
 List<String> itempoolids = new list<String>();
// BLN_Template__c ActualHtml=[select id ,HTML__c,name,Template_Name__c,BLN_Reg_Main_Template__r.Theme_Name__c from BLN_Template__c  where BLN_Reg_Main_Template__r.Theme_Name__c=:presentTemplatename and     BLN_Events__c=:eventid  and  Template_Name__c='AttendeeTemplate' limit 1 ];
 
 BLN_Template__c sinAttendeetemplate =[select id ,HTML__c,name,Template_Name__c,BLN_Reg_Main_Template__r.Theme_Name__c from BLN_Template__c  where BLN_Reg_Main_Template__r.Theme_Name__c=:presentTemplatename and     BLN_Events__c=:eventid  and  Template_Name__c='AttendeeTemplate' limit 1 ];
  
   
 List<BLN_Item__c> blitemlist=[select  Item_Pool__r.name,item_type__r.Name,id,name,item_name__c from BLN_Item__c where event__c=:eventid];
    for(BLN_Item__c bi:blitemlist){
        if(bi.item_type__r.Name=='Package')
        itempoolids.add(bi.Item_Pool__r.name);
    }
 //save only html for line items in a package 
 List<Item_Pool__c > blitempoollist=[select id,name,Item_Pool_Name__c,Item_Type__r.name,Addon_Parent__r.name from Item_Pool__c where event__c=:eventid and Addon_Parent__r.name in:itempoolids  ];
 
 BLN_Template_Child__c  att=[select id,name,HTML__c,BLN_Template__c from BLN_Template_Child__c where BLN_Template__r.bln_events__r.name='Default Event(Boothleads)' and BLN_Template__r.Template_Name__c='AttendeeTemplate' and BLN_Template__r.BLN_Reg_Main_Template__r.theme_name__c=:standardtemplatename limit 1];
      sinAttendeetemplate.HTML__c =att.HTML__c;

list<BLN_Template_Child__c> newchildlist = new list<BLN_Template_Child__c>();
    if(blitemlist.size()>0){
    for(BLN_Item__c blitem :blitemlist){
    BLN_Template_Child__c newchild = new BLN_Template_Child__c();
    newchild.HTML__c = att.HTML__c;
    newchild.BLN_Template__c = sinAttendeetemplate.id;
    newchild.BLN_Item__c =blitem.id; 
    newchildlist.add(newchild);
    }
    }
    else{
    BLN_Template_Child__c newchild = new BLN_Template_Child__c();
    newchild.HTML__c = att.HTML__c;
    newchild.BLN_Template__c = sinAttendeetemplate.id;
    newchildlist.add(newchild);
    
    }
    
    //logic to save html for item pools
    if(blitempoollist.size()>0){
    for(Item_Pool__c  blitempool :blitempoollist){
    BLN_Template_Child__c newchild = new BLN_Template_Child__c();
    newchild.HTML__c = att.HTML__c;
    newchild.BLN_Template__c = sinAttendeetemplate.id;
    newchild.BLN_Item_Pool__c=blitempool.id; 
    newchildlist.add(newchild);
    }
    }
    upsert sinAttendeetemplate;
    insert newchildlist;
 
 return 'success';
 }
 @RemoteAction
 //load item level html based on selected attendee template 
 
 public static list<BLN_Template_Child__c> loaditemlevelhtml(String attendeetemplateid){
 
 return [select id,name,HTML__c,BLN_Template__c,BLN_Item__c,BLN_Item_Pool__c from BLN_Template_Child__c where BLN_Template__c=:attendeetemplateid];


 }
 
 
 @RemoteAction
 
 public static BLN_Template__c loaddefaulthtml(){
 
 
 return [select id,HTML__c,BLN_Events__r.name,Template_Name__c,BLN_Reg_Main_Template__c  from BLN_Template__c where BLN_Events__r.name = 'Default Event(Boothleads)' and Template_Name__c = 'AttendeeTemplate' and  BLN_Reg_Main_Template__c ='' limit 1];
 
 }
}
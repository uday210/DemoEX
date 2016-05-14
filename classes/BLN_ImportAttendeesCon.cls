global class BLN_ImportAttendeesCon {
   public String selecteditem{get;set;}
   public List<SelectOption> items{get;set;}
public BLN_UtillDisplayLinks myticket { get; set; }
public Transient  MAP<id,set<string>> ticket_reg_settings;
public Transient   set<id> ItemsSet;

public string selectedeventid{get;set;}
public Transient    set<string> allfields_of_selectopt;
Public Transient     DateTime Todaydate;
public map<string,string> reqfieldsandlabels{get;set;}
public Transient MAP<id, LIST<Reg_Setting__c>> RegSettingsMap;
public  LIST<SelectOption> countryOptions{get;set;}
public  LIST<State__c>   statelist{get;set;}
public string selectedcountry{get;set;}
   public BLN_ImportAttendeesCon()
   {
         ecslist=new List<ExceptionCountryState>();
         Todaydate = DateTime.Now();
         selectedeventid = ApexPages.currentpage().getParameters().get('id');
         BLN_event__c eve=[select id,Name from BLN_event__c where id=:selectedeventid];
         myticket = new BLN_UtillDisplayLinks();
         myticket.isAttendeesPage='active';
         myticket.tablabel='Import Attendees';
         myticket.eventName = eve.Name;
         myticket.EventId= selectedeventid;
         myticket.userPermissions(userInfo.getUserId(),selectedeventid);       
  items=new List<SelectOption>();
  
   for(BLN_Item__c blitem:[select id,item_name__c,sale_end__c,sale_start__c from BLN_Item__c where Event__c=:selectedeventid AND sale_end__c >=Today AND sale_start__c <=Today  And Item_Type__r.Name != 'Package'])
   {
         items.add(new SelectOption(blitem.id,blitem.item_name__c)); 
   }
   
   gridrows=new List<header>();
   allFields = new List<List<String>>();
   try{getcoutries();}catch(Exception e){}
   }
   @TestVisible private boolean workadd{get;set;}
   @TestVisible private boolean homeadd{get;set;}
   public PageReference Import()
    {
      
     
    List<attachment> att =[select id,parentid,name,body  from attachment where parentid =:selectedeventid  and name=:csvFileName];
    String csvAsString = '';
    try{
    csvAsString = att[0].body.toString();
    }
    catch(exception ex){
    string emessge='The file is in ANSI encoding format.'+' '+'To change excel ANSI encoding to UTF-8 '+', '+'open the .csv file in notepad then select File > Save As.'+' '+'Now at the bottom you will see encoding it set to ANSI change it to UTF-8'+' '+'and save the file as new file and then your done';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
    try{
    allFields=parseCSV(csvAsString,false);
    }
    catch(exception ex){
    string emessge='Please reduce the number of columns and try again';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
    boolean emailexist=false,fnameexist=false,lnameexist=false;
    workadd=false;
    homeadd=false;
    
    for(header e:gridrows)
    {
      if(e.field=='Email__c')
      emailexist=true;
      if(e.field=='First_Name__c')
      fnameexist=true;
      if(e.field=='Last_Name__c')
      lnameexist=true;
      if(e.field=='WorkAddress1__c'||e.field=='WorkAddress2__c'||e.field=='WorkCity__c'||e.field=='WorkCountry__c'||e.field=='WorkState__c'||e.field=='WorkZip_Code__c')
      workadd=true;
      if(e.field=='HomeAddress1__c'||e.field=='HomeAddress2__c'||e.field=='HomeCity__c'||e.field=='HomeCountry__c'||e.field=='HomeState__c'||e.field=='HomeZip_Code__c')
      homeadd=true;
    }
    
    
    /*if(it.sale_end__c<Todaydate)
    {
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'You Cannot Import the Expired Tickets');
    ApexPages.addMessage(myMsg); 
    return null;
    }
    system.debug('CurrentDate' + Todaydate);
        system.debug('SaleStartDate' + it.sale_start__c);
     if(it.sale_start__c>Todaydate)
    {
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'You Cannot Import these Tickets Since the Tickets are not yet Live');
    ApexPages.addMessage(myMsg); 
    return null;
    }*/
    //redirect to state country map screen if not matches
    Set<String> ecexist=new Set<String>();
   for(BLN_ExceptionCountryState__c ec:[select id,name,InputCountry__c,InputState__c,BLN_Events__c from BLN_ExceptionCountryState__c where BLN_Events__c=:selectedeventid])
   {
   if(ec.InputCountry__c!=null&&ec.InputState__c!=null)
   ecexist.add(ec.InputCountry__c.touppercase()+ec.InputState__c.touppercase());
   else if(ec.InputCountry__c!=null)
   ecexist.add(ec.InputCountry__c.touppercase());
   else if(ec.InputState__c!=null)
   ecexist.add(ec.InputState__c.touppercase());
   }
     Map<String,Map<String,Id>> shortstatesparent=new Map<String,Map<String,Id>>();
     Map<String,Map<String,Id>> longstatesparent=new Map<String,Map<String,Id>>();
    for(State__c state:[SELECT Id, Long_Name__c,Short_Name__c,Country__c  FROM State__c])
    { 
      //storing short states based on countries
      if(shortstatesparent.containskey(state.country__c))
      {
      try{
      Map<String,Id> onlystates=new Map<String,Id>();
      onlystates=shortstatesparent.get(state.country__c);
      onlystates.put(state.Short_Name__c.touppercase(),state.id);
      shortstatesparent.put(state.country__c,onlystates); }catch(Exception e){}
      }
      else{
      try{Map<String,Id> onlystates=new Map<String,Id>();
      onlystates.put(state.Short_Name__c.touppercase(),state.id);
      shortstatesparent.put(state.country__c,onlystates);}catch(Exception e){}
      }
      
      //storing long states based on countries
      if(longstatesparent.containskey(state.country__c))
      {
      try{
      Map<String,Id> onlystates=new Map<String,Id>();
      onlystates=longstatesparent.get(state.country__c);
      onlystates.put(state.Long_Name__c.touppercase(),state.id);
      longstatesparent.put(state.country__c,onlystates); }catch(Exception e){}
      }
      else{
      try{Map<String,Id> onlystates=new Map<String,Id>();
      onlystates.put(state.Long_Name__c.touppercase(),state.id);
      longstatesparent.put(state.country__c,onlystates);}catch(Exception e){}
      }
      
    }
    Map<String,Id> country=new Map<String,Id>();
    
   for(Country__c c:[SELECT Id, Long_Name__c,Short_Name__c  FROM Country__c])
    {
    try{
      country.put(c.Long_Name__c.touppercase(),c.id);
      country.put(c.Short_Name__c.touppercase(),c.id);
       } catch(exception e){}
    }
    ecslist=new List<ExceptionCountryState>();
    Set<String> countrystatemap=new Set<String>();
    for(integer i=1;i<allFields.size();i++)
      {
      String workcountry='',workstate='',homecountry='',homestate='';
      List<String> eachrowrecord=allFields[i];
      for(integer j=0;j<gridrows.size();j++)
           {
              if(gridrows[j].field!='')
              {
                 //for work
                 if(gridrows[j].field=='WorkCountry__c'){
                 if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                 if(!country.containskey(eachrowrecord[j].touppercase().trim()))
                 {
                   workcountry='~~'+eachrowrecord[j].touppercase().trim();
                 }
                 else
                 workcountry=eachrowrecord[j].touppercase().trim();
                 }
                 }
                 
                 if(gridrows[j].field=='WorkState__c'){
                 if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                 workstate=eachrowrecord[j].touppercase().trim();
                 }
                 }
                 
                 //for home
                 if(gridrows[j].field=='HomeCountry__c'){
                 if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                 if(!country.containskey(eachrowrecord[j].touppercase().trim()))
                 {
                   homecountry='~~'+eachrowrecord[j].touppercase().trim();
                 }
                 else
                 homecountry=eachrowrecord[j].touppercase().trim();
                 }
                 }
                 
                 if(gridrows[j].field=='HomeState__c'){
                 if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                 homestate=eachrowrecord[j].touppercase().trim();
                 }
                 }
                 
                 
              }
            } 
            //logic to find workstate belongs to right country or not
            if(workstate!=''&&workcountry!=''&&!workcountry.startswith('~~'))
            {
                String cid=country.get(workcountry);
                Map<String,Id> alllongstates=new Map<String,Id>();
                alllongstates=longstatesparent.get(cid);
                try{
                if(!alllongstates.containskey(workstate))
                {
                  Map<String,Id> allshortstates=new Map<String,Id>();
                  allshortstates=shortstatesparent.get(cid);
                  try{
                   if(!allshortstates.containskey(workstate))
                   { 
                      workstate='~~'+workstate;
                   }
                   }catch(Exception e){workstate='~~'+workstate;}
                   }
                   }catch(Exception e){workstate='~~'+workstate;}
                
            }
            //
            if(!countrystatemap.contains(workcountry+workstate)){
            if(workcountry!=''&&workcountry.startsWith('~~'))  //when country and it is not correct
            {
              ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry=workcountry.substring(2);
                  if(workstate!=''&&!workstate.startsWith('~~'))
                  ec.InputState=workstate;
                  else if(workstate==''){
                   ec.InputState='';
                   ec.outputstatenotneeded=true;
                   }
                  if(!ecexist.contains(ec.InputCountry+ec.InputState))
                  ecslist.add(ec); 
            }
            else if(workcountry!=''&&!workcountry.startsWith('~~')&&workstate!=''&&workstate.startsWith('~~'))  //when country and states,states is not correct
            {
              ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry=workcountry;
                  ec.InputState=workstate.substring(2);
                  if(!ecexist.contains(ec.InputCountry+ec.InputState))
                  ecslist.add(ec); 
            }
            else if(workcountry==''&&workstate!='') //when only state then it is not correct
            {
              ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry='';
                  ec.InputState=workstate;
                  if(!ecexist.contains(ec.InputCountry+ec.InputState))
                  ecslist.add(ec); 
            }
           
            
          countrystatemap.add(workcountry+workstate);  
          }
          //logic to find state belongs to right country or not
            if(homestate!=''&&homecountry!=''&&!homecountry.startswith('~~'))
            {
                String cid=country.get(workcountry);
                Map<String,Id> alllongstates=new Map<String,Id>();
                alllongstates=longstatesparent.get(cid);
                try{
                if(!alllongstates.containskey(homestate))
                {
                  Map<String,Id> allshortstates=new Map<String,Id>();
                  allshortstates=shortstatesparent.get(cid);
                  try{
                   if(!allshortstates.containskey(homestate))
                   { 
                      homestate='~~'+homestate;
                   }
                   }catch(Exception e){homestate='~~'+homestate;}
                   }
                   }catch(Exception e){homestate='~~'+homestate;}
            }
            //  
          if(!countrystatemap.contains(homecountry+homestate)){
            if(homecountry!=''&&homecountry.startsWith('~~'))  //when country and it is not correct
            {
              ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry=homecountry.substring(2);
                  if(homestate!=''&&!homestate.startsWith('~~'))
                  ec.InputState=homestate;
                  else if(homestate==''){
                   ec.InputState='';
                   ec.outputstatenotneeded=true;
                   }
                  if(!ecexist.contains(ec.InputCountry+ec.InputState))
                  ecslist.add(ec); 
            }
            else if(homecountry!=''&&!homecountry.startsWith('~~')&&homestate!=''&&homestate.startsWith('~~'))  //when country and states,states is not correct
            {
              ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry=homecountry;
                  ec.InputState=homestate.substring(2);
                  if(!ecexist.contains(ec.InputCountry+ec.InputState))
                  ecslist.add(ec); 
            }
            else if(homecountry==''&&homestate!='') //when only state then it is not correct
            {
              ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry='';
                  ec.InputState=homestate;
                  if(!ecexist.contains(ec.InputCountry+ec.InputState))
                  ecslist.add(ec); 
            }
            
          countrystatemap.add(homecountry+homestate);  
          }  
            
     }       
    //
    if(lnameexist!=true||fnameexist!=true||emailexist!=true)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'First Name ,Last Name,Email are mandatory to map for Import.');
    ApexPages.addMessage(myMsg); 
    return null;
    }
    if(ecslist.size()>0)
    {
    return null;
    }
    else
    {
    allFields.remove(0);
      //create the external gateway automatically if not exist
    try{
                Event_Pay_Gateway__c  EGateway=BLN_EventPayGateway_DAO.getEventPayGateWay(ApexPages.currentpage().getParameters().get('id'),'External Pay Gateway','Onsite');
                }catch(Exception e){
                BLN_Event__c  eves = new BLN_Event__c ();
                BLN_Event_DAO evDao = new BLN_Event_DAO();
                eves = evDao.getEventDetails(ApexPages.currentpage().getParameters().get('id'))[0];
                PGateway_Type__c  Gtype = new PGateway_Type__c();
                try {
                    Gtype = [select id from PGateway_Type__c where Name = 'External Pay Gateway' ];
                } catch (exception e1) {}
                if (null != Gtype ) {
                    Pay_Gateway__c pgGate = new Pay_Gateway__c();
                    pgGate.Company__c = eves.organizer_id__c;
                    pgGate.PGateway_Type__c = Gtype.id;
                    DataBase.SaveResult svRest = Database.insert(pgGate, false);
                    if (svRest.Issuccess()) {
                        Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c();
                        epg.Registration_Type__c  = 'Onsite';
                        epg.Events__c = ApexPages.currentpage().getParameters().get('id');
                        epg.Pay_Gateway__c = svRest.getId();
                        Database.SaveResult Sv = Database.insert(epg, false);
                        }
                        }
                        }
                        
                        try{
     //Work Adress settings include
     if(workadd==true){
    List<Reg_Setting__c> regsettings=[select id,name,Setting_Type__c,Defaullt_Label__c,Event__c,Item__c,Included__c,Order__c,Group_Order__c from Reg_Setting__c where Event__c=:selectedeventid and Setting_Type__c='Regular' and Defaullt_Label__c='Work Address' and Item__c=:selecteditem limit 1];
    if(regsettings.size()>0)
     {
        regsettings[0].Included__c=true;
        update regsettings;
     }
     else
     {
        Reg_Setting__c newreg=new Reg_Setting__c();
        newreg.Event__c=selectedeventid;
        newreg.Item__c=selecteditem ;
        newreg.Setting_Type__c='Regular';
        newreg.Defaullt_Label__c='Work Address';
        newreg.Order__c=1;
        newreg.Group_Order__c=2;
        newreg.Table_Name__c='Company_Ext__c';
        newreg.Column_Name__c='Work Address';
        newreg.Label_Name__c='Work Address';
        newreg.Update_Access__c=true;
        newreg.Included__c=true;
        newreg.Group_Name__c='Address Information';
        insert newreg;
     }
     }
     //Home Adress settings include
     if(homeadd==true){
    List<Reg_Setting__c> regsettings1=[select id,name,Setting_Type__c,Defaullt_Label__c,Event__c,Item__c,Included__c,Order__c,Group_Order__c from Reg_Setting__c where Event__c=:selectedeventid and Setting_Type__c='Regular' and Defaullt_Label__c='Home Address' and Item__c=:selecteditem limit 1];
    if(regsettings1.size()>0)
     {
        regsettings1[0].Included__c=true;
        update regsettings1;
     }
     else
     {
        Reg_Setting__c newreg=new Reg_Setting__c();
        newreg.Event__c=selectedeventid;
        newreg.Item__c=selecteditem ;
        newreg.Setting_Type__c='Regular';
        newreg.Defaullt_Label__c='Home Address';
        newreg.Order__c=1;
        newreg.Group_Order__c=4;
        newreg.Table_Name__c='User_Ext__c';
        newreg.Column_Name__c='Home Address';
        newreg.Label_Name__c='Home Address';
        newreg.Update_Access__c=true;
        newreg.Included__c=true;
        newreg.Group_Name__c='Address Information';
        insert newreg;
     } 
     } 
    //
    }catch(Exception e){}
    //
    try{
    delete att;
    }catch(Exception e){}
    
    Id batchInstanceId = Database.executeBatch(new BLN_BatchImportAttendee(allFields, gridrows,selecteditem,csvFileName), 5);
    PageReference pg=new PageReference('/apex/BLN_Attendees');
    pg.setRedirect(true);
    return pg;
    }
    
      
    }
    
    
    
    public PageReference callFinalImport()
    {
    
    //insert into exception country states table
    List<BLN_ExceptionCountryState__c> excslist=new List<BLN_ExceptionCountryState__c>();
    for(ExceptionCountryState ec:ecslist)
    {
      BLN_ExceptionCountryState__c e;
     if(ec.OutputState!=null&&ec.OutputState!='')
     e=new BLN_ExceptionCountryState__c(BLN_Events__c=selectedeventid,InputCountry__c=ec.InputCountry,InputState__c=ec.InputState,OutputCountry__c=ec.OutputCountry,OutputState__c=ec.OutputState);
     else
     e=new BLN_ExceptionCountryState__c(BLN_Events__c=selectedeventid,InputCountry__c=ec.InputCountry,InputState__c=ec.InputState,OutputCountry__c=ec.OutputCountry);
     
     excslist.add(e);
    }
    insert excslist;
    
    //
    List<attachment> att =[select id,parentid,name,body  from attachment where parentid =:selectedeventid  and name=:csvFileName];
    String csvAsString = '';
    try{
    csvAsString = att[0].body.toString();
    }
    catch(exception ex){
    string emessge='The file is in ANSI encoding format.'+' '+'To change excel ANSI encoding to UTF-8 '+', '+'open the .csv file in notepad then select File > Save As.'+' '+'Now at the bottom you will see encoding it set to ANSI change it to UTF-8'+' '+'and save the file as new file and then your done';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
    try{
    allFields=parseCSV(csvAsString,false);
    }
   catch(exception ex){
    string emessge='Please reduce the number of columns and try again';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
    allFields.remove(0);
      //create the external gateway automatically if not exist
    try{
                Event_Pay_Gateway__c  EGateway=BLN_EventPayGateway_DAO.getEventPayGateWay(ApexPages.currentpage().getParameters().get('id'),'External Pay Gateway','Onsite');
                }catch(Exception e){
                BLN_Event__c  eves = new BLN_Event__c ();
                BLN_Event_DAO evDao = new BLN_Event_DAO();
                eves = evDao.getEventDetails(ApexPages.currentpage().getParameters().get('id'))[0];
                PGateway_Type__c  Gtype = new PGateway_Type__c();
                try {
                    Gtype = [select id from PGateway_Type__c where Name = 'External Pay Gateway' ];
                } catch (exception e1) {}
                if (null != Gtype ) {
                    Pay_Gateway__c pgGate = new Pay_Gateway__c();
                    pgGate.Company__c = eves.organizer_id__c;
                    pgGate.PGateway_Type__c = Gtype.id;
                    DataBase.SaveResult svRest = Database.insert(pgGate, false);
                    if (svRest.Issuccess()) {
                        Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c();
                        epg.Registration_Type__c  = 'Onsite';
                        epg.Events__c = ApexPages.currentpage().getParameters().get('id');
                        epg.Pay_Gateway__c = svRest.getId();
                        Database.SaveResult Sv = Database.insert(epg, false);
                        }
                        }
                        }
                        
                        try{
     //Work Adress settings include
     if(workadd==true){
    List<Reg_Setting__c> regsettings=[select id,name,Setting_Type__c,Defaullt_Label__c,Event__c,Item__c,Included__c,Order__c,Group_Order__c from Reg_Setting__c where Event__c=:selectedeventid and Setting_Type__c='Regular' and Defaullt_Label__c='Work Address' and Item__c=:selecteditem limit 1];
    if(regsettings.size()>0)
     {
        regsettings[0].Included__c=true;
        update regsettings;
     }
     else
     {
        Reg_Setting__c newreg=new Reg_Setting__c();
        newreg.Event__c=selectedeventid;
        newreg.Item__c=selecteditem ;
        newreg.Setting_Type__c='Regular';
        newreg.Defaullt_Label__c='Work Address';
        newreg.Order__c=1;
        newreg.Group_Order__c=2;
        newreg.Table_Name__c='Company_Ext__c';
        newreg.Column_Name__c='Work Address';
        newreg.Label_Name__c='Work Address';
        newreg.Update_Access__c=true;
        newreg.Group_Name__c='Address Information';
        insert newreg;
     }
     }
     //Home Adress settings include
     if(homeadd==true){
    List<Reg_Setting__c> regsettings1=[select id,name,Setting_Type__c,Defaullt_Label__c,Event__c,Item__c,Included__c,Order__c,Group_Order__c from Reg_Setting__c where Event__c=:selectedeventid and Setting_Type__c='Regular' and Defaullt_Label__c='Home Address' and Item__c=:selecteditem limit 1];
    if(regsettings1.size()>0)
     {
        regsettings1[0].Included__c=true;
        update regsettings1;
     }
     else
     {
        Reg_Setting__c newreg=new Reg_Setting__c();
        newreg.Event__c=selectedeventid;
        newreg.Item__c=selecteditem ;
        newreg.Setting_Type__c='Regular';
        newreg.Defaullt_Label__c='Home Address';
        newreg.Order__c=1;
        newreg.Group_Order__c=4;
        newreg.Table_Name__c='User_Ext__c';
        newreg.Column_Name__c='Home Address';
        newreg.Label_Name__c='Home Address';
        newreg.Update_Access__c=true;
        newreg.Group_Name__c='Address Information';
        insert newreg;
     } 
     } 
    //
    }catch(Exception e){}
    //
    try{
    delete att;
    }catch(Exception e){}
    
    Id batchInstanceId = Database.executeBatch(new BLN_BatchImportAttendee(allFields, gridrows,selecteditem,csvFileName), 5);
    PageReference pg=new PageReference('/apex/BLN_Attendees');
    pg.setRedirect(true);
    return pg;
    }

/*public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }*/   
    
   public class header
   {
     public String csvheader{get;set;}
     public String field{get;set;}
     
   }
    public class ExceptionCountryState
   {
     public String InputCountry{get;set;}
     public String InputState{get;set;}
     public String OutputCountry{get;set;}
     public String OutputState{get;set;}
     public boolean outputstatenotneeded{get;set;}
     
   }
   public List<ExceptionCountryState> ecslist{get;set;}
   public List<header> gridrows{get;set;}
   public List<SelectOption> fieldsoptions{get;set;}
   public transient List<List<String>> allFields;
   public PageReference importCSVFile() {
   if(csvFileBody==null)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a File.');
    ApexPages.addMessage(myMsg);
    return null;
    }
    String csvAsString = '';
    try{
    csvAsString = csvFileBody.toString();//blobToString( csvFileBody,'ISO-8859-1');
    List<attachment> att =[select id,parentid,name,body  from attachment where parentid =:selectedeventid];
    delete att;
    Attachment a = new Attachment(parentId = selectedeventid , name=csvFileName, body =csvFileBody);
         insert a;
    }
    catch(exception ex){
    string emessge='The file is in ANSI encoding format.'+' '+'To change excel ANSI encoding to UTF-8 '+', '+'open the .csv file in notepad then select File > Save As.'+' '+'Now at the bottom you will see encoding it set to ANSI change it to UTF-8'+' '+'and save the file as new file and then your done';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
    
    csvFileBody=null;
    try{
    allFields=parseCSV(csvAsString,false);
    }
   catch(exception ex){
    string emessge='';
    try{
    if(columnsize!=null&&columnsize!='')
    emessge='Looks like '+csvFileName+' has more than '+columnsize+' columns. You can open the file in notepad and you see the actual columns. Please fix and load the file again.';
    else
    emessge='Please reduce the number of columns and try again';
    }catch(Exception e){emessge='Please reduce the number of columns and try again';}
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
     
    }
    
    System.debug('allFields '+allFields);
     
    List<String> headerrow=new List<String>();
    gridrows=new List<header>();
    
    fieldsoptions=new List<SelectOption>();
    fieldsoptions.add(new SelectOption('','--None--'));
    fieldsoptions.add(new SelectOption('Prefix__c','Prefix'));
    fieldsoptions.add(new SelectOption('First_Name__c','First_Name'));
    fieldsoptions.add(new SelectOption('Last_Name__c','Last_Name'));
    fieldsoptions.add(new SelectOption('TKT_Company__c','Company'));
    fieldsoptions.add(new SelectOption('Email__c','Email'));
    fieldsoptions.add(new SelectOption('WorkAddress1__c','WorkAddress1'));
    fieldsoptions.add(new SelectOption('WorkAddress2__c','WorkAddress2'));
    fieldsoptions.add(new SelectOption('HomeAddress1__c','HomeAddress1'));
    fieldsoptions.add(new SelectOption('HomeAddress2__c','HomeAddress2'));
    fieldsoptions.add(new SelectOption('Age__c','Age'));
    fieldsoptions.add(new SelectOption('Biography__c','Biography'));
    fieldsoptions.add(new SelectOption('WorkCity__c','WorkCity'));
    fieldsoptions.add(new SelectOption('WorkCountry__c','WorkCountry'));
    fieldsoptions.add(new SelectOption('HomeCity__c','HomeCity'));
    fieldsoptions.add(new SelectOption('HomeCountry__c','HomeCountry'));
    fieldsoptions.add(new SelectOption('DOB__c','DOB'));
    fieldsoptions.add(new SelectOption('Blogger__c','Blogger'));
    fieldsoptions.add(new SelectOption('FaceBookId__c','FaceBookId'));
    fieldsoptions.add(new SelectOption('Gender__c','Gender'));
    fieldsoptions.add(new SelectOption('LinkedInId__c','LinkedInId'));
    fieldsoptions.add(new SelectOption('Mobile__c','Mobile'));
    fieldsoptions.add(new SelectOption('Work_Phone__c','Work_Phone'));
    fieldsoptions.add(new SelectOption('WorkState__c','WorkState'));
    fieldsoptions.add(new SelectOption('HomeState__c','HomeState'));
    fieldsoptions.add(new SelectOption('TwitterId__c','TwitterId'));
    fieldsoptions.add(new SelectOption('WorkZip_Code__c','WorkZip_Code'));
    fieldsoptions.add(new SelectOption('HomeZip_Code__c','HomeZip_Code'));
    fieldsoptions.add(new SelectOption('TKT_Job_Title__c','Designation'));
    fieldsoptions.add(new SelectOption('Home_Phone__c','Home Phone'));
    fieldsoptions.add(new SelectOption('NAICS_Code__c','NAICS Code'));
    fieldsoptions.add(new SelectOption('Diversity__c','Diversity'));
    fieldsoptions.add(new SelectOption('Commodities__c','Commodities'));
    fieldsoptions.add(new SelectOption('Badge_Label__c','Badge Label'));
    fieldsoptions.add(new SelectOption('Tag_No__c','Seat No'));
    fieldsoptions.add(new SelectOption('Tag_Name__c','Tag'));
    fieldsoptions.add(new SelectOption('Custom_Barcode__c','Custom Barcode'));
    
    
    allfields_of_selectopt = new set<string>();
    reqfieldsandlabels = new MAP<string,string>();
    for(String s:allfields[0])
    {
      if(s.trim()!=''){
     header gr=new header();
     gr.csvheader=s;
     For(SelectOption so : fieldsoptions)
     {
     allfields_of_selectopt.add(so.getvalue());
     reqfieldsandlabels.put(so.getvalue(),so.getlabel());
       if(gr.csvheader.contains(so.getlabel()))
       {
         gr.field=so.getvalue();
         break;
       }
     }
     gridrows.add(gr);
     }
    }
   
        return null;
    }
    
    
    
    

public Blob csvFileBody{get;set;}
public string csvFileName{get;set;}
public String[] csvFileLines{get;set;}
public static transient String columnsize{get;set;}

public static List<List<String>> parseCSV(String contents,Boolean skipHeaders) {
    List<List<String>> allFields = new List<List<String>>();

    // replace instances where a double quote begins a field containing a comma
    // in this case you get a double quote followed by a doubled double quote
    // do this for beginning and end of a field
    //contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
    // now replace all remaining double quotes - we do this so that we can reconstruct
    // fields with commas inside assuming they begin and end with a double quote
    //contents = contents.replaceAll('""','DBLQT');
    // we are not attempting to handle fields with a newline inside of them
    // so, split on newline to get the spreadsheet rows
    List<String> lines = new List<String>();
    /*try {
        //lines = contents.split('\n');
       } catch (System.ListException e) {
        System.debug('Limits exceeded?' + e.getMessage());
        
        }*/
        Utility_RowIterator r = New Utility_RowIterator(contents,'\r\n');
    Integer num = 0;
    while(r.hasNext()) {
    String line=r.next();
    line= line.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
    line= line.replaceAll('""','DBLQT');
        // check for blank CSV lines (only commas)
        if (line.replaceAll(',','').trim().length() == 0) break;
       List<String> fields =new List<String>(); 
     try{
        fields = line.split(',(?=([^\"]*\"[^\"]*\")*[^\"]*$)', -1); 
        }catch(Exception e){
        throw new BLN_ReUse_EventsEditCon.applicationException();}
        
        if(fields.size()>50){
        columnsize=String.valueOf(fields.size());
        throw new BLN_ReUse_EventsEditCon.applicationException();
        }
        
        List<String> cleanFields = new List<String>();
        String compositeField;
        Boolean makeCompositeField = false;
        
        for(String field: fields) {
        field = field.trim();
            if (field.startsWith('"') && field.endsWith('"')) {
                field= field.substring(1, field.length() - 1);
                cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                makeCompositeField = true;
                compositeField = field;
                
            } else if (field.endsWith('"')) {
                compositeField += ',' + field;
                cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                makeCompositeField = false;
            } else if (makeCompositeField) {
                compositeField +=  ',' + field;
            } else {
                cleanFields.add(field.replaceAll('DBLQT','"'));
            }
        }
        
        allFields.add(cleanFields);
    }
    if (skipHeaders) allFields.remove(0);
    return allFields;       
}
public void getcoutries(){
  countryOptions= new LIST<SelectOption>();
     BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
     system.debug('$$$$$$$'+selectedeventid);
     
     countryOptions = bcd.countryStatesforprofile();
     if(countryOptions.size()>0){
     countryOptions.remove(0); 
      string usaid= BLN_CountryState_DAO.getusacountryid(selectedeventid);
      if(usaid!=null){
      selectedcountry  = usaid;
      }else{
      selectedcountry  = countryOptions[0].getValue();
      }
     statelist = new LIST<State__c> ();  
     statelist = BLN_CountryState_DAO.statesBasedOnCountry(selectedcountry); 
     }
}
public void getstates(){
 selectedcountry = Apexpages.currentPage().getParameters().get('countryid');
 statelist = new LIST<State__c> ();  
     statelist = BLN_CountryState_DAO.statesBasedOnCountry(selectedcountry); 
}
public PageReference exportToCSV()
        {
                PageReference pageRef= new PageReference('/apex/BLN_AttendeeImportTemplate');
                pageRef.setredirect(false);
                return pageRef;
        }
        
@RemoteAction        
public static string  validatemd(string selecteditem_t,string selected_eventid,List<header> gridrows_t,string csvFile_Name,list<header> req_fieldsandlabelslst,list<string> allfields_of_select_optlst){
system.debug('bk@@@@@@@@@@@@@@@@@@@@@@@@');
system.debug('@selecteditem_t'+selecteditem_t);
system.debug('#selected_eventid'+selected_eventid);
system.debug('@selectgridrows_teditem_t'+gridrows_t);
system.debug('#csvFile_Name'+csvFile_Name);
map<string,string> req_fieldsandlabels=new map<string,string>();
Set<String> allfields_of_select_opt= new Set<String>(allfields_of_select_optlst);
if(req_fieldsandlabelslst.size()>0){
    for(header ses:req_fieldsandlabelslst){
       req_fieldsandlabels.put(ses.csvheader,ses.field);
    }
}
if(gridrows_t.size()==0)
     {
   
    return 'Please select a File and click next.';
     }

if(gridrows_t.size()>0)
     {
      
      set<string> settings_string = new set<string>();
    map<id,set<string>>  ticket_reg_settings_t =new map<id,set<string>>();
   MAP<id, LIST<Reg_Setting__c>>   RegSettingsMap_t = new MAP<id, LIST<Reg_Setting__c>>();
   set<id>   ItemsSet_t = new set<id>();
      ItemsSet_t.add(selecteditem_t);
      BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
      RegSettingsMap_t = RegSettingsBAL.regsettings(ItemsSet_t , selected_eventid);
        for(id rgsettid:RegSettingsMap_t.keySet()){
         set<string>   reg_settings_req =new set<string>();
              for(Reg_Setting__c rgset:RegSettingsMap_t.get(rgsettid)){
                if(rgset.Required__c==true){
                reg_settings_req.add(rgset.Column_Name__c);
                }
              }
           ticket_reg_settings_t.put(rgsettid,reg_settings_req);
        }
        system.debug('@@@@@@@@@'+ticket_reg_settings_t);
       if(ticket_reg_settings_t.size()>0){
       settings_string  =  ticket_reg_settings_t.get(selecteditem_t);
       set<string> gridrowsset=new set<string>();
             string errstring='';
         if(settings_string.contains('Work Address')){
         settings_string.add('WorkCity__c');
         settings_string.add('WorkState__c');
         settings_string.add('WorkAddress1__c');
         settings_string.add('WorkAddress2__c');
         settings_string.add('WorkCountry__c');
         settings_string.add('WorkZip_Code__c');
         }
         if(settings_string.contains('Home Address')){
         settings_string.add('HomeAddress1__c');
         settings_string.add('HomeAddress2__c');
         settings_string.add('HomeCity__c');
         settings_string.add('HomeCountry__c');
         settings_string.add('HomeState__c');
         settings_string.add('HomeZip_Code__c');
         }
         for(header e:gridrows_t)
         {
         gridrowsset.add(e.field);
              
         }
         for(string st:settings_string ){
         if(allfields_of_select_opt.contains(st)){
            system.debug('%%%%%%%%@@@len'+errstring.length());
           if(errstring.length()>70 && (!errstring.contains('\n'))){
                      errstring  = '\n'+errstring;
                }
         errstring =req_fieldsandlabels.get(st)+','+errstring ;
         }
         }
         system.debug('settings_string%%%11'+settings_string);
         system.debug('allfields_of_select_opt$$$$$$'+allfields_of_select_opt);
         system.debug('gridrowsset%%%%%%'+gridrowsset);
         for(string st:settings_string ){
         if(allfields_of_select_opt.contains(st)){
         if(!gridrowsset.contains(st)){
                   
                   return 'Required Fields are Not Mapped'+' '+errstring ;
                 }
             }
         }
      }
     }
    List<attachment> att_t =[select id,parentid,name,body  from attachment where parentid =:selected_eventid and name=:csvFile_Name];
    String csvAsString_t ='';
    try{
    csvAsString_t = att_t[0].body.toString();
    }
    catch(exception ex){
    string emessge='The file is in ANSI encoding format.'+' '+'To change excel ANSI encoding to UTF-8 '+', '+'open the .csv file in notepad then select File > Save As.'+' '+'Now at the bottom you will see encoding it set to ANSI change it to UTF-8'+' '+'and save the file as new file and then your done';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
 List<List<String>> allFields_t=new List<List<String>>();
 try{
   allFields_t=parseCSV(csvAsString_t,false);
   }
   catch(exception ex){
   
    string emessge='Please reduce the number of columns and try again';
   
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,emessge);//ex.GetMessage()
    ApexPages.addMessage(myMsg);
    return null;
    }
    if(allFields_t.size()==1)
    {
       return 'Please enter atleast one record in the file';
    }
    BLN_Item__c it_t=[select id,item_name__c,Available_Tickets__c,sale_end__c,sale_start__c from BLN_Item__c where id=:selecteditem_t];
    if(allFields_t.size()-1>it_t.Available_Tickets__c)
    {
        return 'Available tickets are only '+it_t.Available_Tickets__c+'. Please increase your ticket count.';
    }
 return '';
}
 @RemoteAction
  Global  static List<SObject> statesBasedOnCountry(String country) {
    //eventCurrency =  Currencies;
    return [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__r.Long_Name__c,Country__r.Short_Name__c, Country__c FROM State__c WHERE Country__c = : country];
  }
  public static string getusacountryid(string EventId){
  list<BLN_Event_Countries_Include__c> evecountryusa=new list<BLN_Event_Countries_Include__c>();
   evecountryusa = [SELECT ID, NAME, BLN_Country__r.Short_Name__c, BLN_Country__r.Long_Name__c, BLN_Country__r.Order__c,BLN_Event__c FROM BLN_Event_Countries_Include__c where BLN_Event__c=:EventId AND BLN_Country__r.Long_Name__c=:'United States Of America' ORDER BY BLN_Country__r.Order__c LIMIT 1];
   if(evecountryusa.size()>0){
   return evecountryusa[0].BLN_Country__c;
   }else{
   return null;
   }
  }
}
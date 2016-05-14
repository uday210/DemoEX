public with sharing class Attendee_Details_PrintCon {

    public String selectedtemplate { get; set; }
     public Commanforstates comstates{get;set;}

    public PageReference settemplate() {
     String btstyleid= Apexpages.currentpage().getparameters().get('btstyleid');
     try
     {
      Cookie selectedBadge = new Cookie('selectedBadge',btstyleid,null,-1,false); 
      ApexPages.currentPage().setCookies(new Cookie[]{selectedBadge });               
      selectedtemplate = btstyleid;           
     }catch(Exception e){}
        return null;
    }


     private static boolean run = true;
      public static boolean runOnce(){
    if(run){
     run=false;
     return true;
    }else{
        return run;
    }
    }
    
    public PageReference back() {
    return null;
    }
    
    public boolean logo{get;set;}
    public string selectedattendeetypes {get;set;}
    public list<SelectOption > Attoptions {get;set;}
    public boolean search{get;set;}
    public list<list<Event_Attendee_Mapping__c>> eamemaillist {get;set;}
     public String EventName{get;set;}
    
    public pagereference refresh()
    {
    
    system.debug('jjjjjjjjjjjjjjjjjjjjjjjjjjj');
    pagereference pg=new pagereference('/apex/Attendee_Details_Print?id='+EventId);
    
    return pg;
    }
    
    public Attendee_Details_PrintCon()
    {
       comstates = new Commanforstates();
        filllist();    
    
    }
    
    
    //fill list
    public void filllist()
    {
       selectedattendeetypes ='';
    AttendeeInf= true;
    search=true;
    EventId= Apexpages.currentPage().getParameters().get('Id');
    if(Apexpages.currentPage().getParameters().get('EventId')!=null&&Apexpages.currentPage().getParameters().get('EventId')!='')
    EventId= Apexpages.currentPage().getParameters().get('EventId');
    eamemaillist = new List<list<Event_Attendee_Mapping__c>> ();
    list<Event_Attendee_Mapping__c>  email999 = new List<Event_Attendee_Mapping__c> ();
    list<Event_Attendee_Mapping__c> eamemaillist1 =[select GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Company__c,AS_id__r.AS_LastName__c from Event_Attendee_Mapping__c where  EV_id__r.id =: EventId];
    if(eamemaillist1.size() != 0){
    for(Event_Attendee_Mapping__c eamemail: eamemaillist1){
    email999.add(eamemail);
    if(email999.size() > 999){
    eamemaillist.add(email999);
    email999 = new List<Event_Attendee_Mapping__c> ();
    }
    }
    if(email999.size()!= 0 ){
    eamemaillist.add(email999);
    }
    
    }
    
    
    
    
    //'a0EO0000002p2V2';
    // 
    try{
    
    Attendee =[select id,GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,EV_id__r.Attendee_Types__c,AS_id__r.AS_Company__c ,AS_id__r.AS_LastName__c ,AS_id__r.AS_FirstName__c,AS_id__r.AS_Email__c,EA_AttendeeBarcode__c,UniqNo__c,EA_isBadgePrinted__c,EV_id__r.EV_StartDate__c ,EV_id__r.EV_Title__c,EV_id__r.EV_EventLogo__c,TicketTypes__c,Attendee_Types__c
    from Event_Attendee_Mapping__c where EV_id__c=: EventId limit 1];
    EventName=Attendee.EV_id__r.EV_Title__c;
    }catch(exception e){}
    
    getPrinterList();
    
    }
    
    
    
    public void getPrinterList()
    {
      try{
    bdstyleslist = new  LIST<selectoption> ();
    List<BadgeTemplate_Styles__c> Bdstyles=new List<BadgeTemplate_Styles__c> ();
    if(ApexPages.currentPage().getParameters().get('EventId')!=null&&ApexPages.currentPage().getParameters().get('EventId')!='')
    Bdstyles = [select id,Name,badge_type__c,Module__c,Event__c from BadgeTemplate_Styles__c where Event__c =:ApexPages.currentPage().getParameters().get('EventId') and Module__c like '%Quick Registration%' order by lastmodifieddate desc];
    else if(EventId!=null&&EventId!='')
    Bdstyles = [select id,Name,badge_type__c,Module__c,Event__c from BadgeTemplate_Styles__c where Event__c =:EventId and Module__c like '%Quick Registration%' order by lastmodifieddate desc];
    for(BadgeTemplate_Styles__c BTS : Bdstyles ){
    bdstyleslist.add(new selectoption(BTS.Id,BTS.Name));
    }
    Cookie selectedBadge= ApexPages.currentPage().getCookies().get('selectedBadge');
                       if (selectedBadge== null) {
                            selectedBadge= new Cookie('selectedBadge',Bdstyles[0].id,null,-1,false);
                            ApexPages.currentPage().setCookies(new Cookie[]{selectedBadge}); 
                        }
                        else
                        {
                        selectedtemplate = selectedBadge.getValue();
                        try{
                        if(ApexPages.currentPage().getParameters().get('EventId')!=null&&ApexPages.currentPage().getParameters().get('EventId')!='')
                       BadgeTemplate_Styles__c checkBdstyles=[select id,Name,badge_type__c,Module__c,Event__c from BadgeTemplate_Styles__c where id=:selectedtemplate and Event__c =:ApexPages.currentPage().getParameters().get('EventId')];
                        else if(EventId!=null&&EventId!='')
                        checkBdstyles=[select id,Name,badge_type__c,Module__c,Event__c from BadgeTemplate_Styles__c where id=:selectedtemplate and Event__c =:EventId];
                        }catch(Exception e)
                        {
                          //if template got deleted or not found for that event
                          selectedBadge= new Cookie('selectedBadge',Bdstyles[0].id,null,-1,false);
                            ApexPages.currentPage().setCookies(new Cookie[]{selectedBadge}); 
                            selectedtemplate = selectedBadge.getValue(); 
                        }
                        }
    
    }catch(Exception e){}
    }
    public LIST<selectoption> bdstyleslist{get;set;}
    
    public String EventId{get; set;}
    public String AttendeeEmail{get; set;}
    public Event_Attendee_Mapping__c Attendee {get; set;}
    public boolean AttendeeError{get;set;}
    public boolean AttendeeInf{get;set;}
    
    public pagereference  cancel(){
    show=false;
    AttendeeEmail='';
    return null;
    }
    
    public list<Ticket_Eam__c> ticatt {get;set;}
    public boolean show{get;set;}
    public Registration_Settings__c qicksettings {get;set;}
    public boolean noatt{get;set;}
    
    
    public pagereference CheckAttendee(){
    AttendeeEmail = Apexpages.currentpage().getparameters().get('choose');
    system.debug('chhhhhhhhhhhhhhhhhhh'+AttendeeEmail);
    att=new AttendeeSummary__c();
    Attendee = new Event_Attendee_Mapping__c ();
    try{
    foratttypes();
    Attendee =[select id,GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,Attendee_Types__c,EV_id__r.Attendee_Types__c,EV_id__r.EV_Title__c,EV_id__r.EV_EventLogo__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c,AS_id__r.id,
    AS_id__r.AS_HomePhone__c,AS_id__r.AS_CellPhone__c,EA_AttendeeBarcode__c,UniqNo__c ,TicketTypes__c,EA_isBadgePrinted__c,AS_id__r.AS_Title__c ,
    AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_State__c,AS_id__r.As_Home_Country__c,
    AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c
    from Event_Attendee_Mapping__c where (AS_id__r.AS_Email__c  =: AttendeeEmail.toLowerCase().trim()) AND (EV_id__c=:EventId) limit 1];
    
    ticatt = [select id,TicketTypes__r.Ticket_Category__c from Ticket_Eam__c where Event_Attendee_Mapping__r.id =: Attendee.id];
    // qicksettings  = new Registration_Settings__c ();
    /**qicksettings  = [SELECT TicketTypes__r.TT_Name__c,Is_Company_Include__c,Is_Company_required__c,Is_Designation_Include__c,Is_Designation_required__c,Is_Email_Include_c__c,
    Is_Email_Required_c__c,Is_FirstName_Include__c,Is_FirstName_Required__c,Is_Homeaddress_Include__c,Is_Homeaddress_required__c,
    Is_LastName_include__c,Is_LastName_Required__c,Is_Mobile_Include__c,Is_Mobile_required__c,Is_Shipadd_Include__c,Is_Shipadd_required__c,
    Is_Workaddress_Include__c,Is_Workaddress_required__c,Is_WorkPhone_Include__c,Is_workphone_required__c,LastActivityDate,LastModifiedById,
    Is_Wesite_include__c,Is_Wesite_Required__c,Name,TicketTypes__c,TicketTypes__r.Ticket_Category__c FROM Registration_Settings__c where Event__r.id=:EventId];
    */
    att=[select AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,AS_WorkPhone__c,
    
    AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,As_Home_State__c,As_Home_Country__c,
    AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c,AS_Email__c
    
    
    from AttendeeSummary__c where id =: attendee.AS_id__r.id];
    AttendeeError= false;
    AttendeeInf= false;
    system.debug('sssssssssssssssssssssss'+attendee.Attendee_Types__c);
    system.debug('====================T/F before=================='+attendee.EA_isBadgePrinted__c);
    
    if(Attendee.EA_isBadgePrinted__c == false){
    
    system.debug('====================T/F after =================='+attendee.EA_isBadgePrinted__c);
    
      show=false;
      noatt=false;
      return null;  

  
 
    }else{
    system.debug('====================T/F after =================='+attendee.EA_isBadgePrinted__c);
      show=true;
      noatt=false;
      return null;
    }
    
    }catch(Exception E)
    {
    noatt=true;
          show=false;
    //pagereference pg=new pagereference('/apex/quicksave_and_print?id='+EventId+';'+AttendeeEmail);
     // return pg;
    
    return null;
    
    }
    
    
    }
    public   Event_Attendee_Mapping__c Attendeetypes {get; set;}
    public void foratttypes(){
        try{
        Attoptions =new list<SelectOption >{};
        system.debug('               mallik       '+EventId);
        Event__c atttypes =new Event__c();
            if(EventId != null)
            atttypes =[select Attendee_Types__c from Event__c where id =: EventId];
                    
        string Type= atttypes.Attendee_Types__c;
        LIST<String> Notypes = new LIST<String>();
            if(Type != null)
            Notypes =Type.split(';');    
            
        for(String attentype:NoTypes){
            Attoptions.add(new selectoption(attentype,attentype));
        }
        Attendeetypes = new Event_Attendee_Mapping__c();
        Attendeetypes = [select Attendee_Types__c,GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,Badge_Color__c,Display_Badge_Label__c,Boothleads_Profile__c from Event_Attendee_Mapping__c  where (AS_id__r.AS_Email__c =:AttendeeEmail.toLowerCase().trim()) AND (EV_id__c=:EventId) ];
        system.debug('=============type Guest =================='+Attendeetypes.GuestType__c);
        ticatt  = new list<Ticket_Eam__c> {};
        ticatt = [select id,TicketTypes__r.Ticket_Category__c from Ticket_Eam__c where Event_Attendee_Mapping__r.id =: Attendeetypes.id];
        system.debug('            types     '+Attendeetypes.Attendee_Types__c);
        set<string> se = new set<string>{};
            
            if (Attendeetypes.Attendee_Types__c != null) {
                string attendeetype =  Attendeetypes .Attendee_Types__c;
                list < string > seltypes = attendeetype.split(';');
                    for (string dd: seltypes) {
                        dd=dd.trim();
                        selectedattendeetypes = dd;
                    
                }    
        system.debug('            types     '+selectedattendeetypes);
        }
        
        }catch(exception e){}
    }
    
    public pagereference printagain(){
    foratttypes();  
    //pagereference pg=new pagereference('/apex/Attendee_Details_Print?id=a00Z000000HYSu9IAH');  
    //pg.setRedirect(false);     
    //return pg; 
   return null;
    }
    
    
    public void getattdata()
    {
    Attendee =[select id,EV_id__r.Attendee_Types__c,EV_id__r.EV_StartDate__c,GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,Attendee_Types__c,EV_id__r.EV_Title__c,EV_id__r.EV_EventLogo__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c,AS_id__r.id,
    AS_id__r.AS_HomePhone__c,AS_id__r.AS_CellPhone__c,EA_AttendeeBarcode__c,UniqNo__c ,TicketTypes__c,EA_isBadgePrinted__c,AS_id__r.AS_Title__c  from Event_Attendee_Mapping__c where (AS_id__r.AS_Email__c =:ApexPages.currentPage().getParameters().get('AttendeeEmail')) AND (EV_id__c=:ApexPages.currentPage().getParameters().get('EventId')) limit 1];
    
     att=[select AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,AS_WorkPhone__c,
    
    AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,As_Home_State__c,As_Home_Country__c,
    AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c,AS_Email__c
    
    
    from AttendeeSummary__c where id =: attendee.AS_id__r.id];
Attoptions =new list<SelectOption >{};
        system.debug('               mallik       '+EventId);
        Event__c atttypes =new Event__c();
            if(ApexPages.currentPage().getParameters().get('EventId')!= null)
            atttypes =[select Attendee_Types__c from Event__c where id =: ApexPages.currentPage().getParameters().get('EventId')];
                    
        string Type= atttypes.Attendee_Types__c;
        LIST<String> Notypes = new LIST<String>();
            if(Type != null)
            Notypes =Type.split(';');    
            
        for(String attentype:NoTypes){
            Attoptions.add(new selectoption(attentype,attentype));
        }
    Attendeetypes = new Event_Attendee_Mapping__c();
        Attendeetypes = [select Attendee_Types__c,GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,Badge_Color__c,Display_Badge_Label__c,Boothleads_Profile__c from Event_Attendee_Mapping__c  where (AS_id__r.AS_Email__c =:ApexPages.currentPage().getParameters().get('AttendeeEmail').toLowerCase().trim()) AND (EV_id__c=:ApexPages.currentPage().getParameters().get('EventId')) limit 1];
          if (Attendeetypes.Attendee_Types__c != null) {
                string attendeetype =  Attendeetypes .Attendee_Types__c;
                list < string > seltypes = attendeetype.split(';');
                    for (string dd: seltypes) {
                        dd=dd.trim();
                        selectedattendeetypes = dd;
                    
                }    
        system.debug('            types     '+selectedattendeetypes);
        } 
        
       //Arindam Badge code
       try{
        btstyle=[select BadgeName__c,Badge_Type__c,Module__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c where id=:selectedtemplate limit 1];
  
      //Arindam code
      //Parse Badge Name
    String badgename=btstyle.BadgeName__c;
    parseBadge(badgename.substring(0,badgename.length()-1));
    elems=new List<Style>(); 
    //Parse Elements
     if(btstyle.FirstRowElement__c!=null&&btstyle.FirstRowElement__c != '')
    parseElement(btstyle.FirstRowElement__c);
     if(btstyle.SecondElement__c!=null&&btstyle.SecondElement__c != '')
    parseElement(btstyle.SecondElement__c);
     if(btstyle.ThirdElement__c!=null&&btstyle.ThirdElement__c != '')
    parseElement(btstyle.ThirdElement__c);
     if(btstyle.FourthElement__c!=null&&btstyle.FourthElement__c != '')
    parseElement(btstyle.FourthElement__c);
    if(btstyle.FifthElement__c!=null&&btstyle.FifthElement__c != '')
    parseElement(btstyle.FifthElement__c );
    if(btstyle.SixthElement__c!=null&&btstyle.SixthElement__c != '')
    parseElement(btstyle.SixthElement__c);
    if(btstyle.SeventhElement__c!=null&&btstyle.SeventhElement__c != '')
    parseElement(btstyle.SeventhElement__c);
    if(btstyle.EightthElement__c!=null&&btstyle.EightthElement__c != '')
    parseElement(btstyle.EightthElement__c);
    if(btstyle.ninthelement__c!=null&&btstyle.ninthelement__c != '')
    parseElement(btstyle.ninthelement__c);
      //end 
      }catch(Exception e){}  
        
    }
    
    
    
    public AttendeeSummary__c att{get;set;}
    public string compaare {get;set;}
    public string type {get;set;}
    public  set<string> se {get;set;}
    public String error{get;set;}
    public PageReference PrintAttendee()
    {
        error='';
        type ='';
        try{
        update att;
        Attendee.EA_isBadgePrinted__c = true;
        update attendee;
        //update badge color,label and visiblity
        update Attendeetypes;
        }catch(DmlException  e)
        {
          error=e.getDMLMessage(0);
          if(error.indexOf('duplicate value found')!=-1)
          error='Duplicate Email';
        }
        catch(Exception  e)
        {
          error=e.getMessage();
        }
        
        filllist();
          return null;
        
     }  
     
     
     //Arindam Badge Style Code
      public BadgeTemplate_Styles__c btstyle{get;set;}
   public Badge bg{get;set;}
   public List<Style> elems{get;set;}
    public void parseBadge(String bdg)
   {

     // Parse entire JSON response.
    JSONParser parser = JSON.createParser(bdg);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    bg= (Badge)parser.readValueAs(Badge.class);
                  
                

                }
            }
        }
    }
    
   }
   
   public void parseElement(String elem)
   {
     
    // Parse entire JSON response.
    JSONParser parser = JSON.createParser(elem);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    Style st= (Style)parser.readValueAs(Style.class);
                  elems.add(st);

                }
            }
        }
    }
      
   }
   
  
  
  
  
  public class Style{
  public String id{get;set;}
  public String height{get;set;}
  public String width{get;set;}
  public String positionTop{get;set;}
  public String positionLeft{get;set;}
  public String marginTop{get;set;}
  public String marginRight{get;set;}
  public String marginBottom{get;set;}
  public String marginLeft{get;set;}
  public String paddingTop{get;set;}
  public String paddingRight{get;set;} 
  public String paddingBottom{get;set;} 
  public String paddingLeft{get;set;} 
  public String textAlign{get;set;} 
  public String fontSize{get;set;} 
  public String fontFamily{get;set;} 
  public String textTransform{get;set;} 
  public String contentText{get;set;}   
  public String backgroundColor{get;set;}
  public String opacity{get;set;}
  public String textColor{get;set;}  
  public String qrUrlResult{get;set;}
  public String urlResult{get;set;}
    public Style(String id,String height,String width,String positionTop,String positionLeft,String marginTop,String marginRight,
    String marginBottom,String marginLeft,String paddingTop,String paddingRight,String paddingBottom,String paddingLeft,
    String textAlign,String fontSize,String fontFamily,String textTransform,String contentText,
    String backgroundColor,String opacity,String textColor,String qrUrlResult,String urlResult){
        id=this.id;
        height=this.height;
        width=this.width;
        positionTop=this.positionTop;
        positionLeft=this.positionLeft;
        marginTop=this.marginTop;
        marginRight=this.marginRight;
        marginBottom=this.marginBottom;
        marginLeft=this.marginLeft;
        paddingTop=this.paddingTop;
        paddingRight=this.paddingRight; 
        paddingBottom=this.paddingBottom; 
        paddingLeft=this.paddingLeft; 
        textAlign=this.textAlign; 
        fontSize=this.fontSize; 
        fontFamily=this.fontFamily;
        textTransform=this.textTransform; 
        contentText=this.contentText; 
        backgroundColor=this.backgroundColor;
        opacity=this.opacity;
        textColor=this.textColor;  
        qrUrlResult=this.qrUrlResult;
        urlResult=this.urlResult;
    }
}


public class Badge{
public String width{get;set;}
public String height{get;set;}
public String backgroundColor{get;set;}

public Badge(String width,String height,String backgroundColor)
{
  this.width=width;
  this.height=height;
  this.backgroundColor=backgroundColor;
  
}
}
//end of code 
    
    }
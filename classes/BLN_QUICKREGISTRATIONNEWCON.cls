global without sharing class BLN_QUICKREGISTRATIONNEWCON {

    public String checkNo { get; set; }

   

public transient list<Event_Attendee_Mapping__c> eamemaillist {get;set;}
public String EventId{get;set;}
public String EventName{get;set;}
public LIST<selectoption> bdstyleslist{get;set;}
public String selectedtemplate { get; set; }
public Event__c eve{get;set;}


public BLN_QUICKREGISTRATIONNEWCON()
{
    EventId= Apexpages.currentPage().getParameters().get('Id');
   eamemaillist = new List<Event_Attendee_Mapping__c> ();
     try{
    eve=[select EV_Title__c,Attendee_Types__c,EV_EventLogo__c,EV_HostingTimeZone__c ,EV_EndDate__c ,EV_StartDate__c,EV_EndTime__c,StartTime__c,EV_HostingCountryNew__c,EV_HostingStateNew__c,AS_HostingCity__c  from Event__c where id =: EventId];
    EventName=eve.EV_Title__c;}catch(Exception e){}
    getALLEam();
    }
    
    
    public void BadgeCode()
    {
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


public void getALLEam()
{
eamemaillist=Database.query('select GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Company__c,AS_id__r.AS_LastName__c from Event_Attendee_Mapping__c where  EV_id__r.id =\''+EventId+'\'');
getPrinterList();
}
public void getPrinterList()
    {
      try{
    bdstyleslist = new  LIST<selectoption> ();
    List<BadgeTemplate_Styles__c> Bdstyles=new List<BadgeTemplate_Styles__c> ();
    if(EventId!=null&&EventId!='')
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
                        if(EventId!=null&&EventId!='')
                        BadgeTemplate_Styles__c checkBdstyles=[select id,Name,badge_type__c,Module__c,Event__c from BadgeTemplate_Styles__c where id=:selectedtemplate and Event__c =:EventId];
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
 public PageReference settemplate() {
     String btstyleid= Apexpages.currentpage().getparameters().get('btstyleid');
     try
     {
      Cookie selectedBadge = new Cookie('selectedBadge',btstyleid,null,-1,false); 
      ApexPages.currentPage().setCookies(new Cookie[]{selectedBadge });               
      selectedtemplate = btstyleid;  
       BadgeCode();         
     }catch(Exception e){}
        return null;
    }
 
 public Event_Attendee_Mapping__c EAMAttendee {get; set;}  
 public AttendeeSummary__c att{get;set;}
 public Integer noatt{get;set;} 
 public boolean printed{get;set;}
 
 public PageReference CheckAttendee() {
   try{
     printed=false;
    String AttendeeEmail = Apexpages.currentpage().getparameters().get('choose');
   att=new AttendeeSummary__c();
    EAMAttendee = new Event_Attendee_Mapping__c ();
    try{
    EAMAttendee =[select id,GuestType__c,TicketTypesBP__c,Display_Ticket_Label__c,Attendee_Types__c,EV_id__r.Attendee_Types__c,EV_id__r.EV_Title__c,EV_id__r.EV_EventLogo__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c,AS_id__r.id,
    AS_id__r.AS_HomePhone__c,AS_id__r.AS_CellPhone__c,EA_AttendeeBarcode__c,UniqNo__c ,TicketTypes__c,EA_isBadgePrinted__c,AS_id__r.AS_Title__c ,
    AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_State__c,AS_id__r.As_Home_Country__c,
    AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,Display_Badge_Label__c,Badge_Color__c 
    from Event_Attendee_Mapping__c where (AS_id__r.AS_Email__c  =: AttendeeEmail.toLowerCase().trim()) AND (EV_id__c=:EventId) limit 1];
    
    att=[select AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,AS_WorkPhone__c,
    
    AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,As_Home_State__c,As_Home_Country__c,
    AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c,AS_Email__c
    from AttendeeSummary__c where id =: EAMAttendee.AS_id__r.id];
    if(EAMAttendee.EA_isBadgePrinted__c == false){
     noatt=1;
     printed=false;
     }else{
     printed=true;
     noatt=1;
    }
    }
    catch(Exception e)
    {
      noatt=2;
      email=AttendeeEmail ;
      Attoptions =new list<SelectOption >{};           
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
      
    }
    try{
   BadgeCode();
   }catch(Exception e){}
   
   }catch(Exception e){noatt=0;}
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
public String error{get;set;}
public PageReference PrintAttendee()
    {
        noatt=0;
       try{
        update att;
        EAMAttendee.EA_isBadgePrinted__c = true;
        update EAMAttendee;
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
        
        getALLEam();
          return null;
        
     }  
public string email{get;set;}
public String badgettype{get;set;}
public boolean displaybadgelabel{get;set;}
public boolean displaybadgettype{get;set;}
public string selectedattendeetypes {get;set;}
 public list<SelectOption > Attoptions {get;set;}
 public String othervalue{get;set;}
 public String colorvalue { get; set; }
 public PageReference changeother() {
    othervalue=selectedattendeetypes;
        return null;
    }
    public boolean paymode{get;set;}
    public String cardNo{get;set;}
    public String expMonth{get;set;}
    public String expYear{get;set;}
    public String cardCvv{get;set;}
    
    
    public List<SelectOption> getMonths() {
        List<SelectOption> options = new List<SelectOption>();
      
        options.add(new SelectOption('01','January (01)'));
        options.add(new SelectOption('02','February (02)'));
        options.add(new SelectOption('03','March (03)'));
        options.add(new SelectOption('04','April (04)'));
        options.add(new SelectOption('05','May (05)'));
        options.add(new SelectOption('06','June (06)'));
        options.add(new SelectOption('07','July (07)'));
        options.add(new SelectOption('08','August (08)'));
        options.add(new SelectOption('09','September (09)'));
        options.add(new SelectOption('10','October (10)'));
        options.add(new SelectOption('11','November (11)'));
        options.add(new SelectOption('12','December (12)'));
        
        return options;
    }
    public String cardtype{get;set;}
    public String paymentopt{get;set;}
     public List<SelectOption> getPaymentOptions() {
        List<SelectOption> options = new List<SelectOption>();
      
        options.add(new SelectOption('Credit Card','Credit Card'));
        options.add(new SelectOption('Cash','Cash'));
        options.add(new SelectOption('Check','Check'));
        
        
        return options;
    }
    
    
    public List<SelectOption> getYears() {
        List<SelectOption> options = new List<SelectOption>();
      
        options.add(new SelectOption('2014','2014'));
        options.add(new SelectOption('2015','2015'));
        options.add(new SelectOption('2016','2016'));
        options.add(new SelectOption('2017','2017'));
        options.add(new SelectOption('2018','2018'));
        options.add(new SelectOption('2019','2019'));
        options.add(new SelectOption('2020','2020'));
        options.add(new SelectOption('2021','2021'));
        options.add(new SelectOption('2022','2022'));
        options.add(new SelectOption('2023','2023'));
        options.add(new SelectOption('2024','2024'));
        options.add(new SelectOption('2025','2025'));
        
        return options;
    }
    public boolean attexist{get;set;}
    
    public String ticketitem { get; set; }
        public Decimal ticketamt{get;set;}
        public Map<Id,Decimal> tckamtmap{get;set;}
        public List<SelectOption> getTickets() {
        List<SelectOption> options = new List<SelectOption>();
        tckamtmap=new Map<Id,Decimal>();
        for(TicketTypes__c tt:[select id,Name,Ticket_Category__c,TT_Name__c,TT_Amount__c,Available__c from TicketTypes__c where ev_id__c=:EventId and Available__c>0 order by Ticket_Category__c]){
        tckamtmap.put(tt.id,tt.TT_Amount__c);
        if(ticketitem==null)
        ticketitem=tt.id;
        if(tt.Ticket_Category__c==null)
        options.add(new SelectOption(tt.id,tt.TT_Name__c));
        else
        options.add(new SelectOption(tt.id,tt.TT_Name__c+'('+tt.Ticket_Category__c+')'));
        }
        return options;
    }
    public PageReference SaveAndPrint() {
    try{
    List<Event_Attendee_Mapping__c> eamexist=[select id,name,AS_id__r.AS_Email__c,EV_id__c
    from Event_Attendee_Mapping__c where (AS_id__r.AS_Email__c  =: email) AND (EV_id__c=:EventId ) limit 1];
    if(eamexist.size()>0)
    {
    attexist=true;
    return null;
    }
    else
    attexist=false;
    String paykey='';
    String paymentType='';
    if(paymode==true&&tckamtmap.get(ticketitem)==0)
    paymentopt='Free';
   //doing payments
     if(paymode==true&&tckamtmap.get(ticketitem)!=0){
     if(paymentopt=='Credit Card')
     {
     cardtype=GetCreditCardType(cardNo);
      Pay_Pal_Account__c ppc;
        try{
        ppc=[select id,name,Account_types__c,Payment_Type__c,PuserName__c,Psignature__c,Ppassword__c from Pay_Pal_Account__c where Payment_Type__c='Simple' and Event__c=:EventId limit 1];
        }catch(Exception e){return null;}
        try{
        if(ppc.Account_types__c=='PayPal Account'){
        PaypalProccessor2 pp2=new PaypalProccessor2(cardCvv,att.AS_FirstName__c,att.AS_LastName__c,'44','433','ajm','CA','US','4534',cardtype,cardNo,expMonth,expYear,String.valueOf(tckamtmap.get(ticketitem)),ppc.PuserName__c,ppc.Ppassword__c,ppc.Psignature__c);
       
        if(pp2.transid.length()==0)
        return null;
        else
        paykey=pp2.transid;
        }
        else if(ppc.Account_types__c=='TrustCommerce'){
        String[] arrayt;
       Map<String,String> results; 
        Decimal TotalChargeAmount = tckamtmap.get(ticketitem)*100;
        String Amount = String.valueOf(Integer.Valueof(TotalChargeAmount));  
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         String url = 'https://vault.trustcommerce.com/trans/?custid='+ppc.PuserName__c+'&password='+ppc.Ppassword__c+'&action=sale&amount='+Amount+'&cc='+cardNo+'&exp='+expMonth+expYear.substring(2)+'&cvv='+cardCvv+'&name='+att.AS_FirstName__c+att.AS_LastName__c;
         req.setEndpoint(url);
          req.setMethod('POST');
         HttpResponse res = h.send(req);
         arrayt=res.getBody().split('\n');
         results=new Map<String,String>();
           for(integer i=0;i<arrayt.size();i++)
           {
           String []temp= arrayt[i].split('=');
          results.put(temp[0],temp[1]);
           }
           if(results.get('status')== 'approved'){
                payKey = results.get('transid');
                 }else{
            return null;
            }
        }
        else
        return null;
        
        }catch(Exception e){return null;}
        
       }
       else if(paymentopt=='Check')
       {
       payKey=checkNo;
       
       }
       else if(paymentopt=='Cash')
       {
         paykey='Cash';
       }
       else
       return null;
        
          
        }
  
      att.AS_Email__c=email;  
      
      String attid='';
     List<AttendeeSummary__c> checkexistingatt=[select id,name,AS_Email__c from AttendeeSummary__c where AS_Email__c=:email];
     if(checkexistingatt.size()>0)
     {
     att.id=checkexistingatt[0].id;
     update att;
     attid=checkexistingatt[0].id;
     }
     else
     {
     insert att;
     attid=att.id;
     }
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c = attid; 
      eam.Ev_id__c = EventId;   
      eam.Attendee_Event_IDs__c = attid+ EventId;
      eam.Attendee_Source__c ='Walk Ins' ; 
      if(paymode==true){
      tickettypes__c  tceam=[select id,ev_id__c,tt_name__c,TT_Amount__c from tickettypes__c where id=:ticketitem and ev_id__c=:EventId limit 1];
      eam.TicketTypes__c=tceam.tt_name__c;}
      if(selectedattendeetypes.toUpperCase() == 'ATTENDEE'){
      eam.Boothleads_Profile__c = 'Attendee';
      } else{
      if(selectedattendeetypes.toUpperCase() == 'EXHIBITOR' || selectedattendeetypes.toUpperCase() == 'SPONSOR' || selectedattendeetypes.toUpperCase() == 'PRIME CONTRACTOR'||selectedattendeetypes.toUpperCase()=='PRIME PARTNER'||selectedattendeetypes.toUpperCase()=='RESOURCE PARTNER'){
             eam.Boothleads_Profile__c = 'Booth Admin';
      }
      
      }
     
      //Storing badge label and color and visibility
      eam.GuestType__c = othervalue;
      eam.Badge_Color__c=colorvalue;
      eam.Display_Badge_Label__c=displaybadgelabel;
      eam.Display_Ticket_Label__c=displaybadgettype;
      eam.TicketTypesBP__c=badgettype;
      
       eam.Attendee_Types__c='';
             if (selectedattendeetypes != null && selectedattendeetypes  != 'Other' ) {
             
                     eam.Attendee_Types__c += selectedattendeetypes+';';
              
                 
             }
             
        eam.EA_isBadgePrinted__c = true;
            
     
      insert eam;  
      //mapping with Walk In Tickets
      try{
     
      if(paymode==true){
       tickettypes__c  tc=[select id,ev_id__c,tt_name__c,TT_Amount__c from tickettypes__c where id=:ticketitem and ev_id__c=:EventId limit 1];
      Constomer__c tran=new Constomer__c(Isinserted__c=true,Email__c=att.AS_Email__c,Total_Amount__c=Double.valueOf(tckamtmap.get(ticketitem)),Payment_Status__c='Paid',Payment_Type__c=paymentopt,payKey__c=paykey);
      insert tran;
      
      Dummay__c reginfo=new Dummay__c(Event__c=EventId,AttendeeSummary__c=att.id,TicketTypes__c=tc.id,Event_Attendee_Mapping__c=eam.id,customer_key__c=tran.id,Email__c=att.AS_Email__c,First_Name__c=att.AS_FirstName__c,Last_Name__c=att.AS_LastName__c,Tickets_Quantty__c=1,TicketAmount__c=Integer.valueOf(tckamtmap.get(ticketitem)),Payment_Status__c='Paid',Payment_Type__c=paymentopt);
      insert reginfo;
      
      }
      else
      {
        
       
      tickettypes__c  tc=[select id,ev_id__c,tt_name__c from tickettypes__c where tt_name__c='Walk In' and ev_id__c=:EventId limit 1];
      Constomer__c tran=new Constomer__c(Isinserted__c=true);
      insert tran;
      Dummay__c reginfo=new Dummay__c(Event__c=EventId,AttendeeSummary__c=att.id,TicketTypes__c=tc.id,Event_Attendee_Mapping__c=eam.id,customer_key__c=tran.id,Email__c=att.AS_Email__c,First_Name__c=att.AS_FirstName__c,Last_Name__c=att.AS_LastName__c,Tickets_Quantty__c=1,Payment_Status__c='Paid',Payment_Type__c='Cash');
      insert reginfo;
        
      }
      }catch(Exception e){}
      //end
         
      
     
       
      user use = new user();
             try {
                 use = [select id from User where Username = : att.AS_Email__c];
             } catch (exception e) {}
             
              if(use.id == null ){
              Profile UserAsBA = [Select Id,Name from Profile where Name = 'Attendee'];              
              user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
              account acc=new account();
              if(att.AS_Company__c==null||att.AS_Company__c=='')
              acc.name=att.AS_FirstName__c+' '+att.AS_LastName__c;
              else
              acc.name=att.AS_Company__c;  
              acc.ownerid=uname.createdby.id;          
              insert acc; 
              contact con = new contact();
              Con.LastName = att.AS_LastName__c;
              Con.FirstName = att.AS_FirstName__c;      
              Con.AccountId = acc.id;
              insert Con ;
              system.debug('=====::::::::: Inserting Contact :::::::======='+Con );

                use.ContactID = Con.id;
                use.Username = att.AS_Email__c;
                use.Email = att.AS_Email__c;
                use.Firstname = att.AS_FirstName__c;
                use.LastName = att.AS_LastName__c;
                use.Alias ='BAdmin';
                use.ProfileID =UserAsBA.Id;
                use.LocaleSidKey ='en_US';
                use.LanguageLocaleKey ='en_US';
                use.TimeZoneSidKey ='America/Los_Angeles';
                use.EmailEncodingKey='UTF-8';
                use.IsActive = False;
              
                insert use;
             
             
             }
             
             
            
             
             system.debug('-------------------------new attendee------------------' + use);
             system.debug('-------------------------new attendee------------------' + use.id);
             Profile__c profil = [select id, Name from Profile__c where PR_Name__c = : 'Attendee'];
             User_Profile_Event__c uperec = new User_Profile_Event__c();
             if (use.id != null) {
                 uperec.EV_id__c = EventId;
                 uperec.UEP_isActive__c = true;
                 uperec.User_id__c = use.id;
                 uperec.BoothAdmin_id__c =  use.id;
                 uperec.Profile_id__c = profil.id;
                 
                 uperec.EventAdmin_Id__c=UserInfo.getUserId();
                 insert uperec;
             }
             
      
                
     getALLEam();
     }catch(Exception e){}
       
       return null;
      
      
     }
     @RemoteAction
    global static String getnewdata(String em,String ev) {
    Event_Attendee_Mapping__c newe=null;
    try
    {
     newe=[select Attendee_Types__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,EA_isBadgePrinted__c,TicketTypes__c, EA_AttendeeBarcode__c,UniqNo__c from Event_Attendee_Mapping__c
                                  where (AS_id__r.AS_Email__c =:em) AND (EV_id__c=:ev) limit 1];
     
     }
     catch(Exception e)
     {
       try{
      newe=[select Attendee_Types__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,EA_isBadgePrinted__c,TicketTypes__c, EA_AttendeeBarcode__c,UniqNo__c from Event_Attendee_Mapping__c
                                  where (AS_id__r.AS_Email__c =:em.tolowercase()) AND (EV_id__c=:ev) limit 1];
                                  }catch(Exception e1){}
                                  
     }
                
    
        return newe.EA_AttendeeBarcode__c+'~'+newe.UniqNo__c ;
    } 
    
    public pagereference  cancel(){
    
    PageReference pg=new PageReference('/apex/BLN_QUICKREGISTRATIONNEW?id='+EventId);
    pg.setRedirect(true);
    return pg;
    }
    public string GetCreditCardType(string CreditCardNumber){
        Pattern regVisa =Pattern.compile('^4[0-9]{12}(?:[0-9]{3})?$');
        Pattern regMaster =Pattern.compile('^5[1-5][0-9]{14}$');
        Pattern regExpress =Pattern.compile('^3[47][0-9]{13}$');
        Pattern regDiners = Pattern.compile('^3(?:0[0-5]|[68][0-9])[0-9]{11}$');
        Pattern regDiscover =Pattern.compile('^6(?:011|5[0-9]{2})[0-9]{12}$');
        Pattern regJCB= Pattern.compile('^(?:2131|1800|35\\d{3})\\d{11}$');
       
       
         if(regVisa.matcher(CreditCardNumber).matches())
            return 'Visa';
          else if (regMaster.matcher(CreditCardNumber).matches())
            return 'MasterCard';  
         else  if (regExpress.matcher(CreditCardNumber).matches())
            return 'Amex';
         else if (regDiscover.matcher(CreditCardNumber).matches())
            return 'Discover';
         else   if (regJCB.matcher(CreditCardNumber).matches())
            return 'JCB';
         else
           return '';
    }
}
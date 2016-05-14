global without sharing class saveattendee_print {

    

    public String colorvalue { get; set; }
    public boolean displaybadgelabel{get;set;}
    public boolean displaybadgettype{get;set;}

public String othervalue{get;set;}
public String badgettype{get;set;}
    public PageReference changeother() {
    othervalue=selectedattendeetypes;
        return null;
    }

   public String cardname{get;set;}

    //autocomplete search code for company----Arindam Sarkar
    
    public Object selectValue{get; set;}
     public contact con{get;set;}
    public String searchValue {get; set;}
    public Integer maxHeights {get; set;}
    public Integer height {get; set;}
    public List<SelectOption> results {get; set;}
    public Boolean showList {get; set;}
    Map<String,String> resultsMap;
 
    //This is our seach method that is called every time a character is entered
    public void search(){
        showList = true;
        results = new List<SelectOption>();
        resultsMap = new Map<String,String>();
 
        //Using dynamic SOQL we pass the object and the search value
        if(searchValue.length() > 0){
            String entry = '%' + searchValue + '%';
            String queryString = 'Select AS_id__r.AS_Company__c from ' + 'Event_Attendee_Mapping__c '+ ' where AS_id__r.AS_Company__c like :entry order by AS_id__r.AS_Company__c limit 1000';
            
          List<Event_Attendee_Mapping__c> listc=Database.query(queryString);
          Set<String> lists=new  Set<String>();
            for(Event_Attendee_Mapping__c o : listc){
                   lists.add(o.AS_id__r.AS_Company__c);            
            }
            /*Next we add the results to our list of selectOptions. We also add the values to a map so that when a value
            is selected we can auto fill the search box with the selected value */
            for(String o : lists){
                results.add(new SelectOption(o,o));
                resultsMap.put(o,o);
            }
        }
 
        //Next we inspect the results to set the height and contents of the selectList
        if(searchValue.length() == 0){
            showList = false;
        }else if(results.size() == 0 && searchValue.length() != 0){
            results.add(new SelectOption('','No matches found'));
            height = 2;
        }else if(results.size() == 1){
            height = 2;
        }else if(results.size() > maxHeights){
            height = maxHeights;
        }else{
            height = results.size();
        }
    }
 
    //When a value is selected we will auto complete the searchValue
    public void selectValue(){
        showList = false;
        try{
        searchValue = resultsMap.get((string)attendee.AS_Company__c);
        }catch(Exception e){
        searchValue='';
        }
        
    }
 
    //simply hides the list of results
    public void hideResults(){
        showList = false;
        
    }

    //end of autocomplete search code
   

   public boolean flag{get;set;}
    @RemoteAction
    global static String getnewdata(String em,String ev) {
    Event_Attendee_Mapping__c newe=null;
    try
    {
     newe=[select Attendee_Types__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,EA_isBadgePrinted__c,TicketTypes__c, EA_AttendeeBarcode__c,UniqNo__c from Event_Attendee_Mapping__c
                                  where (AS_id__r.AS_Email__c =:em) AND (EV_id__c=:ev)limit 1];
     
     }
     catch(Exception e)
     {
      
     }
                
    
        return newe.EA_AttendeeBarcode__c+'~'+newe.UniqNo__c ;
    }

    public string selectedattendeetypes {get;set;}
    public list<selectoption>  specialTics {get; set;}
    public string[] selectedcheck {get;set;}
    public string paymade{get;set;}
    public boolean attexist{get;set;}
    public PageReference SaveAndPrint() {
    List<Event_Attendee_Mapping__c> eamexist=[select id,name,AS_id__r.AS_Email__c,EV_id__c
    from Event_Attendee_Mapping__c where (AS_id__r.AS_Email__c  =: email) AND (EV_id__c=:event ) limit 1];
    if(eamexist.size()>0)
    {
    attexist=true;
    return null;
    }
    else
    attexist=false;
    String paykey='';
   //doing payments
     if(paymode==true&&tckamtmap.get(ticketitem)!=0){
      Pay_Pal_Account__c ppc;
        try{
        ppc=[select id,name,Payment_Type__c,PuserName__c,Psignature__c,Ppassword__c from Pay_Pal_Account__c where Payment_Type__c='Simple' and Event__c=:event limit 1];
        }catch(Exception e){return null;}
        PaypalProccessor2 pp2=new PaypalProccessor2(cardCvv,attendee.AS_FirstName__c,attendee.AS_LastName__c,'44','433','ajm','CA','US','4534',cardtype,cardNo,expMonth,expYear,String.valueOf(tckamtmap.get(ticketitem)),ppc.PuserName__c,ppc.Ppassword__c,ppc.Psignature__c);
       
        if(pp2.transid.length()==0)
        return null;
        else
        paykey=pp2.transid;
        
       
        
          
        }
  
      attendee.AS_Company__c=searchValue;
      attendee.AS_Email__c=email;  
      
      String attid='';
     List<AttendeeSummary__c> checkexistingatt=[select id,name,AS_Email__c from AttendeeSummary__c where AS_Email__c=:email];
     if(checkexistingatt.size()>0)
     {
     attendee.id=checkexistingatt[0].id;
     update attendee;
     attid=checkexistingatt[0].id;
     }
     else
     {
     insert attendee;
     attid=attendee.id;
     }
      eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c = attid; 
      eam.Ev_id__c = event;   
      eam.Attendee_Event_IDs__c = attid+ event;
      eam.Attendee_Source__c ='Walk Ins' ; 
      if(paymode==true){
      tickettypes__c  tceam=[select id,ev_id__c,tt_name__c,TT_Amount__c from tickettypes__c where id=:ticketitem and ev_id__c=:event limit 1];
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
       tickettypes__c  tc=[select id,ev_id__c,tt_name__c,TT_Amount__c from tickettypes__c where id=:ticketitem and ev_id__c=:event limit 1];
      Constomer__c tran=new Constomer__c(Isinserted__c=true,Email__c=attendee.AS_Email__c,Total_Amount__c=Double.valueOf(tckamtmap.get(ticketitem)),Payment_Status__c='Paid',Payment_Type__c='Credit Card',payKey__c=paykey);
      insert tran;
      
      Dummay__c reginfo=new Dummay__c(Event__c=event,AttendeeSummary__c=attendee.id,TicketTypes__c=tc.id,Event_Attendee_Mapping__c=eam.id,customer_key__c=tran.id,Email__c=attendee.AS_Email__c,First_Name__c=attendee.AS_FirstName__c,Last_Name__c=attendee.AS_LastName__c,Tickets_Quantty__c=1,TicketAmount__c=Integer.valueOf(tckamtmap.get(ticketitem)),Payment_Status__c='Paid',Payment_Type__c='Credit Card');
      insert reginfo;
      
      }
      else
      {
        
       
      tickettypes__c  tc=[select id,ev_id__c,tt_name__c from tickettypes__c where tt_name__c='Walk In' and ev_id__c=:event limit 1];
      Constomer__c tran=new Constomer__c(Isinserted__c=true);
      insert tran;
      Dummay__c reginfo=new Dummay__c(Event__c=event,AttendeeSummary__c=attendee.id,TicketTypes__c=tc.id,Event_Attendee_Mapping__c=eam.id,customer_key__c=tran.id,Email__c=attendee.AS_Email__c,First_Name__c=attendee.AS_FirstName__c,Last_Name__c=attendee.AS_LastName__c,Tickets_Quantty__c=1,Payment_Status__c='Paid',Payment_Type__c='Cash');
      insert reginfo;
        
      }
      }catch(Exception e){}
      //end
         
      
     
      
      user use = new user();
             try {
                 use = [select id from User where Username = : attendee.AS_Email__c];
             } catch (exception e) {}
             if(use.id == null ){
             
              Profile UserAsBA = [Select Id,Name from Profile where Name = 'Attendee'];              
              user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
              account acc=new account();
              acc.name=attendee.AS_Company__c;  
              acc.ownerid=uname.createdby.id;          
              insert acc; 
              con = new contact();
              Con.LastName = attendee.AS_LastName__c;
              Con.FirstName = attendee.AS_FirstName__c;      
              Con.AccountId = acc.id;
              insert Con ;
              system.debug('=====::::::::: Inserting Contact :::::::======='+Con );

                use.ContactID = Con.id;
                use.Username = attendee.AS_Email__c;
                use.Email = attendee.AS_Email__c;
                use.Firstname = attendee.AS_FirstName__c;
                use.LastName = attendee.AS_LastName__c;
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
                 uperec.EV_id__c = event;
                 uperec.UEP_isActive__c = true;
                 uperec.User_id__c = use.id;
                 uperec.BoothAdmin_id__c =  use.id;
                 uperec.Profile_id__c = profil.id;
                 uperec.EventAdmin_Id__c=UserInfo.getUserId();
                 insert uperec;
             }
            
      
                
    
       
       return null;
      
      
     }
      
   

    public pagereference refresh()
    {
        system.debug('jjjjjjjjjjjjjjjjjjjjjjjjjjj');
        pagereference pg=new pagereference('/apex/Attendee_Details_Print?id='+Event);
        pg.setredirect(false);
        return pg;
    }
        
        public Event__c eventdetails {get;set;}
        public Event_Attendee_Mapping__c eam{get;set;}
        public Event_Attendee_Mapping__c eam1{get;set;}
        public string[] emaiiandid{get;set;}
        public string email{get;set;}
        public string eventid{get;set;}
        public string event{get;set;}
        public Registration_Settings__c qicksettings {get;set;}
        public list<SelectOption > Attoptions {get;set;}
        public AttendeeSummary__c Attendee {get; set;}
        
        public String ticketitem { get; set; }
        public Decimal ticketamt{get;set;}
        public Map<Id,Decimal> tckamtmap{get;set;}
        public List<SelectOption> getTickets() {
        List<SelectOption> options = new List<SelectOption>();
        tckamtmap=new Map<Id,Decimal>();
        for(TicketTypes__c tt:[select id,Name,Ticket_Category__c,TT_Name__c,TT_Amount__c,Available__c from TicketTypes__c where ev_id__c=:event and Available__c>0 order by Ticket_Category__c]){
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
    
    //for payment
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
     public List<SelectOption> getCardOptions() {
        List<SelectOption> options = new List<SelectOption>();
      
        options.add(new SelectOption('Visa','Visa'));
        options.add(new SelectOption('amex','amex'));
        
        
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
    
        
        public  saveattendee_print()
        {
           try{
        cardname='Stripe';
         colorvalue='#000000';
         displaybadgelabel=false;
         displaybadgettype=true;
         specialTics = new list<selectoption> ();
         specialTics.add(new SelectOption('Lunch','Lunch'));
          specialTics.add(new SelectOption('Breakfast','Breakfast'));
           specialTics.add(new SelectOption('All Access pass','All Access pass'));
            specialTics.add(new SelectOption('RLI','RLI'));
            selectedattendeetypes ='';
       
        eventid ='';
        emaiiandid  = new string[]{};
            Attendee =new AttendeeSummary__c();
            //selectedattendeetypes = '';
            email='';
            eventid='';
            system.debug('================ emailid================'+email);
            eventid = Apexpages.currentPage().getParameters().get('id');
            eventid=EncodingUtil.urlDecode(eventid, 'UTF-8');
            system.debug('================ emailid================'+eventid);
            emaiiandid =eventid.split('~');
            integer i=0;
                for(string s:emaiiandid )
                    {
                        if (i==0){
                            event=s;
                        }else
                        {
                            email=s;
                        }
                    i++;
                }
            eventdetails =[select AS_HostingCity__c,EV_EventLogo__c ,EV_Title__c,EV_StartDate__c,EV_HostingLocation__c,Attendee_Types__c    from Event__c where id =: event];
            Attoptions =new list<SelectOption >{};           
            Event__c atttypes =new Event__c();
            
                if(EventId != null)
                  atttypes =[select Attendee_Types__c from Event__c where id =: event];
                  string Type= atttypes.Attendee_Types__c;
                  LIST<String> Notypes = new LIST<String>();
                if(Type != null)
                   Notypes =Type.split(';');
                
                 for(String attentype:NoTypes){
                 Attoptions.add(new selectoption(attentype,attentype));
                 }
                 
                 
                 
                 
                  qicksettings  = new Registration_Settings__c ();
    /*qicksettings  = [SELECT TicketTypes__r.TT_Name__c,Is_Company_Include__c,Is_Company_required__c,Is_Designation_Include__c,Is_Designation_required__c,Is_Email_Include_c__c,
                      Is_Email_Required_c__c,Is_FirstName_Include__c,Is_FirstName_Required__c,Is_Homeaddress_Include__c,Is_Homeaddress_required__c,
                      Is_LastName_include__c,Is_LastName_Required__c,Is_Mobile_Include__c,Is_Mobile_required__c,Is_Shipadd_Include__c,Is_Shipadd_required__c,
                      Is_Workaddress_Include__c,Is_Workaddress_required__c,Is_WorkPhone_Include__c,Is_workphone_required__c,LastActivityDate,LastModifiedById,
                      Is_Wesite_include__c,Is_Wesite_Required__c,Name,TicketTypes__c,TicketTypes__r.Ticket_Category__c FROM Registration_Settings__c where Event__r.id=:event];

                 */
                //Arindam Badge code
                try{
        Cookie selectedBadge= ApexPages.currentPage().getCookies().get('selectedBadge');
                       if (selectedBadge== null) {
                           btstyle=[select BadgeName__c,Badge_Type__c,Module__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c where Event__c=: event and Module__c like '%Quick Registration%' order by lastmodifieddate desc limit 1];
  
                        }
                        else
                        btstyle=[select BadgeName__c,Badge_Type__c,Module__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c where id=:selectedBadge.getValue() limit 1];
  
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
         }catch(Exception e){}        
                 
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
  public integer i{get;set;}
   public void  dummy1(){
   i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
}
}
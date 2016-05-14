public with sharing class DupliacetsprintCon {

    public set<string> emailsset {get ; set ;}
    public list<Dummay__c> dummyys {get ; set ;}
    public list<Dummay__c> displayrecords {get ; set ;}
    public set<string> dumid {get; set;}
    public list<Dummay__c> listofrecs {get;set;}    
    public list<Dummay__c> dummyysdisp  {get; set;}    
    public list<innercl> dummyinn {get; set;}
    public List<Dummay__c> leftvalues {get;set;}
    public List<Dummay__c> rightvalues {get;set;}
    public String eventprintid{get;set;}
    
    
    public DupliacetsprintCon() {
    
    dummyinn = new list<innercl> ();
    dummyys  = new list<Dummay__c> ();
    leftvalues = new List<Dummay__c> ();
    rightvalues = new List<Dummay__c> ();
    displayrecords = new list<Dummay__c> ();
    emailsset = new set<string> ();
    dumid = new set<string>();
    listofrecs = new list<Dummay__c> ();
    
    string eveid = Apexpages.Currentpage().getparameters().get('eventid');
    eventprintid=eveid;
    dummyys  = [select id,Email__c,Company__c,Event__c,Event_Attendee_Mapping__r.EA_AttendeeBarcode__c,Event_Attendee_Mapping__r.TicketTypesBP__c,Event_Attendee_Mapping__r.AS_id__r.AS_Title__c,Event__r.EV_EventLogo__c, First_Name__c,Last_Name__c,TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c,Event_Attendee_Mapping__r.GuestType__c from Dummay__c where Event__r.id =: eveid AND customer_key__r.Isinserted__c = true];
        for(Dummay__c dd : dummyys  ){
            if(emailsset.contains(dd.Email__c)){
                displayrecords.add(dd);
                system.debug('mmmmmmmmmmmmmm'+displayrecords);
            }else{
                 emailsset.add(dd.Email__c);
            }
        }
        set<string> dupl = new set<string> ();
        string removedu = '';
       for(Dummay__c dup: displayrecords){
       removedu = '';
       removedu = dup.Email__c;
       if(dupl.add(removedu)){
           dumid.add(dup.Email__c);}
       }
       
        dummyysdisp  = [select id,Email__c,Company__c,Event__r.EV_EventLogo__c,Event__c,Event_Attendee_Mapping__r.TicketTypesBP__c,Event_Attendee_Mapping__r.AS_id__r.AS_Title__c,Event_Attendee_Mapping__r.EA_AttendeeBarcode__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c,Event_Attendee_Mapping__r.GuestType__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, First_Name__c,Last_Name__c,TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c from Dummay__c where Event__r.id =: eveid AND Email__c IN : dumid AND customer_key__r.Isinserted__c = true ORDER BY Company__c];
        
        dupl = new set<string> ();
        for(Dummay__c du:dummyysdisp  ){
        removedu = '';
        string eamval = du.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c;
        removedu = du.Email__c;
        //if(eamval  != removedu ){
       // if(dupl.add(removedu)){
        dummyinn.add(new innercl(du)); }
        //}
       // }
        
        
        
      //default for avery
      bdstyleslist = new  LIST<selectoption> ();
    Bdstyles = new List<BadgeTemplate_Styles__c> ();
     Bdstyles = [select id,Name,badge_type__c from BadgeTemplate_Styles__c where Event__r.id =: eventprintid and badge_type__c='Zebra' and Module__c like '%Attendee Registration%' ];
    for(BadgeTemplate_Styles__c BTS : Bdstyles ){
    bdstyleslist.add(new selectoption(BTS.Name,BTS.Name));
   
    }
    //end
        
        
        
        }
    public pagereference Print(){
    dummyysdisp.clear();    
    for(innercl inn : dummyinn){
        if(inn.selected == true){
            dummyysdisp.add(inn.dummy);
            system.debug('-----------------------left------------'+dummyysdisp);
        }
    }    
    integer i = 0;
        for(Dummay__c dmy : dummyysdisp){
            if (math.mod(i, 2) == 0) {
            leftvalues.add(dmy);
            system.debug('-----------------------left------------'+leftvalues);
            }else{
            rightvalues.add(dmy);
            }
        i++;
    }
    //commented
    
    
    //Code for Avery5395
     btstyle=[select BadgeName__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c,badge_type__c,Module__c  from BadgeTemplate_Styles__c where name=:selectedbdtemname and Event__c=:eventprintid order by createddate desc limit 1 ];
  
     
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
    //
    if(elems.size()==0)
    return null;
    // pagereference pg= page.badgesfromRegistrationinfo;  
    if(selectedprinter=='Avery_6'){
      pagereference pg = page.Qrcode_printbadge_5392labelduplicate;
          pg.setredirect(false);
         return pg;}
         if(selectedprinter=='Avery_8'){
      pagereference pg = page.AveryAdhesiveDuplicate;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Zebra'){
      pagereference pg = page.qrcode_Zebralabelduplicate;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Brother'){
      pagereference pg = page.qrcode_Brotherlabelduplicate;
          pg.setredirect(false);
         return pg;}
         else
         return null;
    }


    public class innercl{
    
    public Dummay__c dummy {get; set ;}
    public boolean selected {get; set;}
        public innercl(Dummay__c dd){
            dummy  = dd;
            selected = false;
    
        }
    
    }


//template style code
//Arindam code for print
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
 public PageReference findtemplate() {
     bdstyleslist = new  LIST<selectoption> ();
     if(selectedprinter =='Avery_6')
     Bdstyles = [select id,Name,badge_type__c,Module__c from BadgeTemplate_Styles__c where Event__r.id =: eventprintid and badge_type__c='Zebra' and Module__c like '%Attendee Registration%' ];
     else if(selectedprinter =='Avery_8')
     Bdstyles = [select id,Name,badge_type__c,Module__c from BadgeTemplate_Styles__c where Event__r.id =: eventprintid and badge_type__c='Avery' and Module__c like '%Attendee Registration%' ];
       
     else
     Bdstyles = [select id,Name,badge_type__c,Module__c from BadgeTemplate_Styles__c where Event__r.id =: eventprintid and badge_type__c=:selectedprinter and Module__c like '%Attendee Registration%'];
    for(BadgeTemplate_Styles__c BTS : Bdstyles ){
    bdstyleslist.add(new selectoption(BTS.Name,BTS.Name));
    }
        return null;
    }


    public List < selectoption > getPrinterlist() {
      List < selectoption > Option = new List < selectoption > ();
     Option.add(new selectoption('Avery_6', 'Avery_6'));
      Option.add(new selectoption('Avery_8', 'Avery_8'));
     Option.add(new selectoption('Zebra', 'Zebra'));
     Option.add(new selectoption('Brother', 'Brother'));
    
     return option;
    }


    public String selectedprinter { get; set; }
    public LIST<selectoption> bdstyleslist {get ; set ;}
 public string selectedbdtemname {get;set;}
  public List<BadgeTemplate_Styles__c> Bdstyles {get ; set ;}



public pagereference exportduplicates()
{
pageReference pf = new Pagereference('/apex/BL_Duplicatebadges_Export');
     return pf;

}

}
public class BL_SendBadgeController
{
 public List<Style> elems;
 public List<Style> getElems() {
 eamap=new Event_Attendee_Mapping__c();
     
    string eventQuery ='select EV_id__r.EV_Title__c,EV_id__r.EV_HostingTimeZone__c ,EV_id__r.EV_EndDate__c ,EV_id__r.EV_StartDate__c,EV_id__r.EV_EndTime__c,EV_id__r.StartTime__c,EV_id__r.EV_HostingCountryNew__c,EV_id__r.EV_HostingStateNew__c,EV_id__r.AS_HostingCity__c,EV_id__c,EV_id__r.EV_EventLogo__c,UniqNo__c,CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,GuestType__c,BadgeQty__c,TicketTypes__c,TicketTypesBP__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_HomeCity__c,AS_id__r.AS_ShippingCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_State__c,AS_id__r.AS_shippingState__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id=\''+eamid+'\'  limit 1';
         
        
        try{
         eamap=dataBase.Query(eventQuery );
         //eamap.EA_isBadgePrinted__c = true;
         //update eamap;
         }catch(exception e){}
    
     
   btstyle=[select BadgeName__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c where Event__c=:eamap.EV_id__c order by lastmodifieddate desc limit 1];
  
     
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
return elems;
 }
public Event_Attendee_Mapping__c eamap;
public Event_Attendee_Mapping__c getEamap() {
   eamap=new Event_Attendee_Mapping__c();
     
    string eventQuery ='select EV_id__r.EV_Title__c,EV_id__r.EV_HostingTimeZone__c ,EV_id__r.EV_EndDate__c ,EV_id__r.EV_StartDate__c,EV_id__r.EV_EndTime__c,EV_id__r.StartTime__c,EV_id__r.EV_HostingCountryNew__c,EV_id__r.EV_HostingStateNew__c,EV_id__r.AS_HostingCity__c,EV_id__c,EV_id__r.EV_EventLogo__c,UniqNo__c,CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,GuestType__c,BadgeQty__c,TicketTypes__c,TicketTypesBP__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_HomeCity__c,AS_id__r.AS_ShippingCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_State__c,AS_id__r.AS_shippingState__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id=\''+eamid+'\'  limit 1';
         
        
        try{
         eamap=dataBase.Query(eventQuery );
         //eamap.EA_isBadgePrinted__c = true;
         //update eamap;
         }catch(exception e){}
    return eamap;
    }
public String eamid{get;set;}
   public BL_SendBadgeController()
   {
    
    
   }
   
  
   //-----------------------------------------------------------------------------------GENERATE PDF FOR BADGES--------------
 public BadgeTemplate_Styles__c tempnames {get; set;}
 
 
 //Arindam code for print
 public BadgeTemplate_Styles__c btstyle{get;set;}
   public Badge bg{get;set;}
  
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
                  System.debug('BBBBBBBBBB '+st);
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
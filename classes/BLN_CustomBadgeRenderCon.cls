global class BLN_CustomBadgeRenderCon {

public static list<Ticket__c> BadgeAlltkt{get;set;}
Public  Static list<Id> BadgeAllids = new list<Id>();
public static List<Ticket__c> printtickets{get;set;}
 public string selectedEvent {get ; set ;}
 public static string selectedEvent1 {get ; set ;}
public static List<Ticket__c> Alltkt{get; set;}
  Public static  list<String> Allids = new list<String>();
  public BLN_Event__c ee{get;set;}


public BLN_CustomBadgeRenderCon() {

 cookie k = ApexPages.currentPage().getcookies().get('counter');
         if(k!=null){
          selectedEvent = k.getValue();
          selectedEvent1 = k.getValue();
ee=[SELECT Name, Logo_URL__c FROM BLN_Event__c WHERE id = :selectedEvent ];
          
 
}else
{

selectedEvent = Apexpages.currentPage().getParameters().get('id');
}
}

public static PageReference genpdf(String eventid,List<String> selected_ticlist,String allpages) {
System.debug('genpdf genpdf '+eventid);
String q= '';

    List<Badge__c> updatebadgelabel=new List<Badge__c>();
    
 String idInClause = '(\'';
 String idInUpdateBadgeStatus='(\'';
 BLN_Quick_Registration_BAL qb=new BLN_Quick_Registration_BAL();
 Map<String,String> ticketbadgemap=new Map<String,String>();
 if(allpages=='false'){
 q='Select tkt_profile__r.TKT_Job_Title__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c,Item_type__r.name,Item_pool__r.Item_Pool_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name From Ticket__c t where id in:selected_ticlist';
 }
 else{
 //Alltkt=[Select id from Ticket__c where Event__c =:eventid AND Ticket_Status__c='Booked' ];
 try{
 Alltkt=[Select id from Ticket__c where Event__c =:eventid and Ticket_Status__c !='Abandoned' and Ticket_Status__c !='Cancelled' and Ticket_Status__c != 'Available' and Ticket_Status__c != 'Reserved' and Ticket_Status__c != 'Deleted' and (Item_Type__r.Badgable__c != 'N - No Badge' OR Item_Pool__r.Badgable__c != 'N - No Badge' ) ];
         
         
         
          for(Ticket__c t:Alltkt){
         
          Allids.add(t.id);
          
          }
 
 if(selected_ticlist.size()!=0){
                    for(Integer i=0;i<Allids.size();i++){
                    
                    for(Integer k=0;k<selected_ticlist.size();k++){
                    if(Allids[i]==selected_ticlist[k]){
                    Allids.remove(i);
                    }
                    
                    }
         


}
}}catch(Exception e){}
 
 
 q='Select tkt_profile__r.TKT_Job_Title__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c,Item_type__r.name,Item_pool__r.Item_Pool_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name From Ticket__c t where id in:Allids';
 
 
 }
 printtickets=Database.query(q); 
 //System.debug('badges are '+printtickets);
 for(Ticket__c tc:printtickets)
          {
                    System.debug(tc.badges__r.size()+' badge values are '+tc.Badge_ID__c);
               if(tc.badges__r.size()==0&&tc.Badge_ID__c==null){
                   System.debug('if bran '+tc.badge_label__c);
                   ticketbadgemap.put(tc.id,tc.badge_label__c);
                   }
                   else
                   idInUpdateBadgeStatus+=tc.Badge_ID__c+ '\',\'';
                    }
   //   System.debug('tkt map is '+ticketbadgemap);
      qb.generateBadgeMultiple(ticketbadgemap);
    
         if(null != idInUpdateBadgeStatus && idInUpdateBadgeStatus!='(\''){
          idInUpdateBadgeStatus= idInUpdateBadgeStatus.substring(0,idInUpdateBadgeStatus.length()-2);
         idInUpdateBadgeStatus+= ')';
         System.debug('1231223 '+idInUpdateBadgeStatus);
         if(null != idInUpdateBadgeStatus){
         q = 'Select id,name,Print_status__c From Badge__c where id in ' + idInUpdateBadgeStatus;
        updatebadgelabel=Database.query(q);
        }
        for(integer p=0;p<updatebadgelabel.size();p++)
        updatebadgelabel[p].Print_status__c='Printed';
        upsert updatebadgelabel;
         }
      
   
         return null;
  
    
 }
        
        
         public static String getAttendeeData(String Evid,List<String> selrec,String allpages) {
  //printingbadge();
  String queryString='';
if(allpages=='true'){
System.debug('hhhhhhhhhhhhhhhhh '+selrec.size());
try{
//Alltkt=[Select id from Ticket__c where Event__c =:Evid AND Ticket_Status__c='Booked' ];
 Alltkt=[Select id from Ticket__c where Event__c =:Evid  and Ticket_Status__c !='Abandoned' and Ticket_Status__c !='Cancelled' and Ticket_Status__c != 'Available' and Ticket_Status__c != 'Reserved' and Ticket_Status__c != 'Deleted' and (Item_Type__r.Badgable__c != 'N - No Badge' OR Item_Pool__r.Badgable__c != 'N - No Badge' ) ];

                 
          for(Ticket__c t:Alltkt){
         
          Allids.add(t.id);
          
          }
  if(selrec.size()!=0){
                    for(Integer i=0;i<Allids.size();i++){
                    
                    for(Integer k=0;k<selrec.size();k++){
                    if(Allids[i]==selrec[k]){
                    Allids.remove(i);
                    }
                    }
}
}
}catch(Exception e){}
              queryString='Select tkt_profile__r.TKT_Job_Title__c, Scan_Id__c,tkt_profile__r.TKT_Company__c,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Status__c, Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,tkt_profile__r.BLN_Company__r.Name,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,tkt_profile__r.Mobile__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name From Ticket__c t  where event__c = :Evid  and id in : Allids';

  }
  
  else{
  
              queryString='Select tkt_profile__r.TKT_Job_Title__c, Scan_Id__c,tkt_profile__r.TKT_Company__c,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Status__c, Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,tkt_profile__r.BLN_Company__r.Name,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,tkt_profile__r.Mobile__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name From Ticket__c t  where event__c = :Evid  and id in : selrec ';
  
  }
    
             String dataTableJson;
       dataTableJson =JSON.serialize(Database.query(queryString)) ;
      
      return '{"attendees":'+dataTableJson+'}';
     
    }
    
    @RemoteAction
    public static RenderData getRenderData(String EvId,String styleId,String SelectedList,String allpages) {
    //   System.debug('UUUUUU####### :: '+styleId);
      System.debug('####### :: '+SelectedList);
        
        List<String> selected_ticlistTemp44= SelectedList.split(',');
        System.debug('####### :: '+selected_ticlistTemp44);
         genpdf(EvId,selected_ticlistTemp44,allpages);
        BLN_CustomBagdeConNew.BadgeWithLayers style = BLN_CustomBagdeConNew.getStyle(styleId);
        
        Decimal width; Decimal height; String paperSize;
        JSONParser parser = JSON.createParser(style.badge.Data__c);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'canvasWidth' || parser.getText() == 'canvasHeight')) {
                if (parser.getText() == 'canvasWidth') {
                    parser.nextToken();
                    try {
                        width = parser.getDecimalValue();
                    } catch (Exception e) {
                        width = Decimal.valueOf(parser.getText());
                    }
                } else {
                    parser.nextToken();
                    try {
                        height = parser.getDecimalValue();
                    } catch (Exception e) {
                        height = Decimal.valueOf(parser.getText());
                    }
                }
            } else if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'paperSize')) {
                parser.nextToken();
                paperSize = parser.getText();
            }
        }
        LayoutData layoutData = getLayoutDataForSize(width, height,paperSize);
        System.debug('i am at return data');
        return new RenderData(
            getAttendeeData(EvId,selected_ticlistTemp44,allpages),
            layoutData,
            style
        );
    }
    
    @RemoteAction
    public static String openPDF(String html) {
        BLN_Badge_PDF__c pdf = new BLN_Badge_PDF__c();
        pdf.Data__c = html;
        insert pdf;
        
        return '/apex/BLN_BadgeTool_PDF?pdf=' + pdf.Id;
    }
    
    public class LayoutData {
        public Integer perPage { get; set; }
        public Integer perRow { get; set; }
        public Decimal topMargin { get; set; }
        public Decimal bottomMargin { get; set; }
        public Decimal leftMargin { get; set; }
        public Decimal rightMargin { get; set; }
        public Decimal horizontalSpacing { get; set; }
        public Decimal verticalSpacing { get; set; }
        public Decimal pageWidth { get; set; }
        public Decimal pageHeight { get; set; }
        
        public LayoutData (
            Integer perPage,
            Integer perRow,
            Decimal topMargin,
            Decimal bottomMargin,
            Decimal leftMargin,
            Decimal rightMargin,
            Decimal horizontalSpacing,
            Decimal verticalSpacing,
            Decimal pageWidth,
            Decimal pageHeight
        ) {
            this.perPage = perPage;
            this.perRow = perRow;
            this.topMargin = topMargin;
            this.bottomMargin = bottomMargin;
            this.leftMargin = leftMargin;
            this.rightMargin = rightMargin;
            this.horizontalSpacing = horizontalSpacing;
            this.verticalSpacing = verticalSpacing;
            this.pageWidth = pageWidth;
            this.pageHeight = pageHeight;
        }
    }
    
    public class RenderData {
        public String attendeeData { get; set; }
        public LayoutData layoutData { get; set; }
        public BLN_CustomBagdeConNew.BadgeWithLayers style { get; set; }
        
        public RenderData(String attendeeData, LayoutData layoutData, BLN_CustomBagdeConNew.BadgeWithLayers style) {
            this.attendeeData = attendeeData;
            this.layoutData = layoutData;
            this.style = style;
        }
    }
    
    public static LayoutData getLayoutDataForSize(Decimal width, Decimal height,String papersize) {
    //Avery
        if (width == 4 && height == 3 && papersize=='8.5\" x 11\"') {
            return new LayoutData(
                6, 2,
                1, 1, 0.25, 0.25,
                0, 0,
                8.5, 11
            );
        }
        //A4 printing
        else if (width == 8.5 && height == 11) {
            return new LayoutData(
                1, 1,
                1, 1, 0.25, 0.25,
                0, 0,
                8.5, 11
            );
        }
       //Brother DK1234
        else if (width == 3.4 && height == 2.3) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.4,2.3
            );
        
        }
         //Brother DK1202
        else if (width == 3.9 && height == 2.4) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.9, 2.4
            );
        
        }//
         else if (width == 3.5 && height == 2.25) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.5, 2.25
            );
        
        }//Brother DKN 5224
          else if (width == 3.4 && height == 2.1) {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                3.4, 2.1
            );
        
        }
        //zebra printer
        else {
            return new LayoutData(
                1, 1,
                0, 0, 0, 0,
                0, 0,
                4,3
            );
        }
    }
}
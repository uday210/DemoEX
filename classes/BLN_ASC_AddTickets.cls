@RestResource(urlMapping='/BLN_ASC_AddTickets/*')
/******************************************************
*   Author                  : Mythily Nagandla
*   Date                    :  
*   Purpose                 : This is Web Service class for Add Ticket.
*   Static Values           : NO Static values are Used.


********************************************************/



global class BLN_ASC_AddTickets{
//global static BLN_EventsConTest Tikcon {get ; set ;}
global static maincontainer  Mc {get ; set ;}
@HttpPost  
  global static maincontainer  doPost(){  
        String siteurl=Label.SiteURL;
        RestRequest req = RestContext.Request;
         
         
          string eventjsonInput = req.requestBody.tostring();
          system.debug('EVENT JSON PARSER VALUES222222222  '+eventjsonInput );
          ticketinfo eveinfo;
           JSONParser parser = JSON.createParser(eventjsonInput);
            system.debug('EVENT JSON PARSER VALUES222222222  '+parser );
        while (parser.nextToken() != null) {
        
                    eveinfo= (ticketinfo)parser.readValueAs(ticketinfo.class);
                       system.debug('EVENT JSON PARSER VALUES3333333333  '+eveinfo);

       } 
       BLN_ticketfeesettings_BAL saveticopt = new BLN_ticketfeesettings_BAL();
       if(eveInfo.Image!=null&&eveInfo.Image!='')
          {
       Blob jSONRequestBody = EncodingUtil.base64Decode(eveinfo.Image);
         
        string Encodeval =  EncodingUtil.base64Encode(jSONRequestBody);
        
        BLN_ReUse_EventsEditCon mainclass = new BLN_ReUse_EventsEditCon();
        mainclass.imageData = Encodeval ;
        mainclass.saveEventLogo();
        string EvUrl = mainclass.eventlogourl;
        eveinfo.tcketlogo =  EvUrl;
        }
        //BLN_EventsConTest mainclass = new BLN_EventsConTest();
        //mainclass.imageData = Encodeval ;
        //mainclass.saveEventLogo();
        //string EvUrl = mainclass.eventlogourl;
        //eveinfo.tcketlogo =  EvUrl;
        //eveinfo.trowid = EvUrl;
        String serialized = '['+JSON.serialize(eveinfo)+']';
         system.debug('Json after serialize'+serialized );
        // String jSONRequestBody1=eveinfo.tostring();
         
         
          
         //system.debug('aaaaaaaaaaaaaaaaaaa'+jSONRequestBody);
         String Eventid =req.params.get('Event_id'); 
         String currentdate =req.params.get('Start_date');
         String Enddate =req.params.get('End_date');
         string ticopt = req.params.get('ticketopt');
         string feeopt = req.params.get('feeopt');
         string totalticketcount='0';
         try{
         totalticketcount= req.params.get('totalticketcount');
         }catch(Exception e){}
         Mc = new maincontainer();  
         //BLN_EventsConTest Tikcon = new BLN_EventsConTest();
         //BLN_EventsEditCon getticks = new BLN_EventsEditCon();
         
         BLN_ReUse_EventsEditCon.savesTicketInfo(serialized,Eventid,currentdate,Enddate,totalticketcount);
         //BLN_ReUse_EventsEditCon.savesPaymentOption(' ',Eventid,' ',' ',' ',ticopt,feeopt,'');
        /* List<Item_Pool__c> poolids= BLN_EventsEditCon.getSavedTickets(Eventid);
         system.debug('adddddddddddddddd'+poolids);
          string orgid = UserInfo.getOrganizationId();
         for(Item_Pool__c pl : poolids){
          string plid = pl.id;
          List<BLN_Item__c> items = BLN_EventsEditCon.getItemsBasedOnPool(plid);
          
          
          List<BLN_Item__c> items1 = saveticopt.savetickchange(items,feeopt,ticopt);
          
          Mc.Itempool = pl;
          
          for(BLN_Item__c it :items1 ){
          string sdate = it.sale_start__c.format('yyyy-MM-dd hh:mm a');
          string edate = it.sale_end__c.format('yyyy-MM-dd hh:mm a');
          
         // Mc.add(new maincontainer(it,sdate,edate));
          Mc.Items = it;
          Mc.ImageUrl = siteurl+'/servlet/servlet.ImageServer?id='+ it.image_url__c+'&oid='+orgid;
          Mc.Startdate = sdate;
          Mc.Enddate = edate;
          }
          
          //Mc.Items= items;
         }*/
         
        string orgid = UserInfo.getOrganizationId();
         BLN_ItemPool_DAO pooldao=new BLN_ItemPool_DAO();
         Item_Pool__c poolid= pooldao.getItempool('where Event__c=\''+Eventid+'\' and Addon_Parent__c=null order by createddate desc limit 1');
          
             MC.Itempool =poolid ;
             MC.items = BLN_ReUse_EventsEditCon.getItemsBasedOnPool(poolid.id);
            List<BLN_Item__c> items1 =  saveticopt.savetickchange(MC.items,feeopt,ticopt);
             MC.ItemsWithDate=BLN_ReUse_EventsEditCon.getnewItemsBasedOnPool(poolid.id,Eventid);
             for(BLN_Item__c it: MC.items){
             Mc.ImageUrl = it.image_url__c;
             }
             Mc.siteurl=siteurl+'/servlet/servlet.ImageServer?oid='+orgid+'&id=';
        
         
         return Mc;
         
        
         }
         
   global class maincontainer{
         public Item_Pool__c Itempool {get ; set ;}
         public List<BLN_Item__c> Items {get ; set ;}
         public List<BLN_ReUse_EventsEditCon.Item> ItemsWithDate {get ; set ;}
         public string ImageUrl {get ; set ;}
         public string Startdate {get ; set ;}
         public string Enddate {get ; set ;}
         public String siteurl{get;set;}
         public maincontainer(){
         
         }
         
    }
     
       global class ticketinfo {
    public String tname{get;set;}
    public String tpaytype{get;set;}
    public String tqty{get;set;}
    public String tprice{get;set;}
    public String tvisib{get;set;}
    public String tdesc{get;set;}
    public String tcketlogo{get;set;}
    public String tbdglabel{get;set;}
    public String tbadgable{get;set;}
    public String trowid{get;set;}
    public List<grouptickets> grouptickets{get;set;}
    public String ticketcount{get;set;}
    public List<tags> tags{get;set;}
    public List<subpackagegroup> subpackagegroup{get;set;}
    public String ispackage{get;set;}
    public String itemtype{get;set;}
    public String Image {get ; set ;}
    public string Url {get ; set ;}
     public String taxrateflag{get;set;}
    public String tebudprcflag{get;set;}  
    public String poolid{get;set;}
   
    
    public ticketinfo(String tname,String tpaytype,String tqty,String tprice,String tvisib,String tdesc,String tcketlogo,String tbdglabel,String tbadgable,String trowid,List<grouptickets> grouptickets,String ticketcount,List<tags> tags ,List<subpackagegroup> subpackagegroup,String ispackage,String itemtype,string Image,string Url,String taxrateflag,String tebudprcflag) {
    this.tname=tname;
    this.tpaytype=tpaytype;
    this.tqty=tqty;
    this.tprice=tprice;
    this.tvisib=tvisib;
    this.tdesc=tdesc;
    this.tcketlogo=tcketlogo;
    this.tbdglabel=tbdglabel;
    this.tbadgable=tbadgable;
    this.trowid=trowid;
    this.grouptickets=grouptickets;
    this.ticketcount=ticketcount;
    this.tags=tags;
    this.subpackagegroup=subpackagegroup;
    this.ispackage=ispackage;
    this.itemtype=itemtype;
    this.Image = Image;
    this.Url = Url;
    this.taxrateflag=taxrateflag;
    this.tebudprcflag=tebudprcflag;
    }
}
    
    global class subpackagegroup {
    public String pkgitemname{get;set;}
    public String pkgitemqty{get;set;}
    public String ttype{get;set;}
    public String badgelabel{get;set;}
    public String badgable{get;set;}
    public String addonid{get;set;}
    public List<tags> tags{get;set;}
        
    
    public subpackagegroup(String pkgitemname,String pkgitemqty,String ttype,String badgelabel,String badgable,List<tags> tags) {
    this.pkgitemname=pkgitemname;
    this.pkgitemqty=pkgitemqty;
    this.ttype=ttype;
    this.badgelabel=badgelabel;
     this.badgable=badgable;
     this.tags=tags;
    }
} 
global class grouptickets {
    public String tname{get;set;}
    public String sdate{get;set;}
    public String edate{get;set;}
    public String qty{get;set;}
    public String minqty{get;set;}
    public String maxqty{get;set;}
    public String tprice{get;set;}
      public String itemid{get;set;}   
    
    public grouptickets(String tname,String sdate,String edate,String qty,String minqty,String maxqty,String tprice) {
    this.tname=tname;
    this.sdate=sdate;
    this.edate=edate;
    this.qty=qty;
    this.minqty=minqty;
    this.maxqty=maxqty;
    this.tprice=tprice;
    }
}  
global class tags {
    public String tagname{get;set;}
    
    public tags(String tagname) {
    this.tagname=tagname;
    }
}

  
         
 }
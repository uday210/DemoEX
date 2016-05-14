global class BLN_AttendeesController {

public set<id> checkid{get;set;}
   

     public PageReference assignRole() {
    System.debug('roleName '+roleName);
        BLNUtility blutil=new BLNUtility();
        BLN_UCRole_DAO createUcRole= new  BLN_UCRole_DAO();
        if(selected_ticlistTemp44.size()!=0)  { 
        for(Ticket__c tc:[select id,name,tkt_Profile__r.BLN_GN_User__c,tkt_Profile__r.BLN_Company__c from Ticket__c where id in:selected_ticlistTemp44])
        {
          Ucrole = new UC_Role__c();
         Ucrole.GN_User__c = tc.tkt_Profile__r.BLN_GN_User__c ;
         Ucrole.Event__c = selectedEvent ;
         Ucrole.Company__c = tc.tkt_Profile__r.BLN_Company__c;
         BLN_StatusMessage statusUCRole = createUcRole.insertUCRole(Ucrole,roleName);  
         }       
                
                        
                }
        
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return pg;
    }
        @RemoteAction
        public static boolean getCheckTypeOfExport(string evntid){
        boolean showbulkbtn = false;
            
        
        system.debug('---Event Id--- '+evntid);
        string ststus3 = 'N - No Badge';

        string temp = 'select COUNT() from Ticket__c where event__c = \''+evntid+'\' '+' and  Ticket_Status__c != \''+'Cancelled'+'\''+' and  Ticket_Status__c != \''+'Available'+'\''+' and  Ticket_Status__c != \''+'Reserved'+'\''+' and  Ticket_Status__c != \''+'Deleted'+'\''+' and  Ticket_Status__c != \''+'Abandoned'+'\'';

        temp+=' and   Item_Pool__r.Badgable__c != \''+ststus3+'\' Limit 1001';
        system.debug('--Query String-- '+temp);
        Integer totalattendee = Database.countQuery(temp);

        system.debug('--Total Tkts-- '+totalattendee);


        if(totalattendee>1000){

        showbulkbtn = true;
        }

        
        return showbulkbtn;
        }


    public String roleName { get; set; }
     public List<selectOption> getSroles() {
    LIST<SelectOption> roleOptions= new LIST<SelectOption>();
     
        for(Role__c c: [SELECT ID, NAME,Role_Type__c FROM Role__c where Role_Type__c='EventStaff' or Role_Type__c='BoothLeads' or Role_Type__c='ScanAttendee']){
            roleOptions.add(new SelectOption(c.ID, c.Name));
        }
         
       return roleOptions;
    }
    

    //Counting no.of exhibitors
    public integer totalAttendees{get;set;}
    
    //Counting no.of exhibitors
    public integer totalExhibitors{get;set;}
    
    //Counting no.of Sponsors
    public integer totalSponsors{get;set;}

    //Counting no.of Speakers
    public integer totalSpeakers{get;set;}

    //Storing total badges printed
    public integer totalBadgePrint{get;set;}
    
    //Storing total checkedIn attendees
    public integer totalCheckIns{get;set;}
    
    public String tagName { get; set; }
    class TicketMerge
    {
      String ticketid{get;set;}
      boolean merged{get;set;}
    }
    
    public list<string> selected_ticlistTemp{get;set;}
    class Ticket
    {
      public String TicketId{get;set;}
      public boolean used{get;set;}
    }
//Method for merge Item
      public PageReference MergeItemSaves() {
      string itemstrings=Apexpages.currentPage().getParameters().get('allitemid');
        List<String> allitemids=new  list<string>();
        allitemids= itemstrings.split(','); 
        Map<String,List<Ticket>> parentmap=new Map<String,List<Ticket>>();
      String parentitemid=Apexpages.currentPage().getParameters().get('parentitemid');  
      List<Ticket__c> parentlist=[select id,name,Ticket_Status__c,Item__c,tkt_profile__r.Email__c from Ticket__c where Ticket_Status__c !='Cancelled' and  Ticket_Status__c !='Available' and  Ticket_Status__c !='Reserved' and  Ticket_Status__c !='Deleted' and  Ticket_Status__c !='Abandoned' and Item__c=:parentitemid];
      for(Ticket__c parent:parentlist)
      {
        if(parentmap.containskey(parent.tkt_profile__r.Email__c))
        {
         List<Ticket> temp=new List<Ticket>();
         temp=parentmap.get(parent.tkt_profile__r.Email__c);
          Ticket tc=new Ticket();
          tc.TicketId=parent.id;
          tc.used=false;
          temp.add(tc);
          parentmap.put(parent.tkt_profile__r.Email__c,temp);
        }
        else
        {
       Ticket tc=new Ticket();
       tc.TicketId=parent.id;
       tc.used=false;
       List<Ticket> temp=new List<Ticket>();
       temp.add(tc);
       parentmap.put(parent.tkt_profile__r.Email__c,temp);
        }
       
      }
      
      Map<String,List<Ticket__c>> childmap=new Map<String,List<Ticket__c>>();
      List<Ticket__c> childlist=[select id,name,Ticket_Status__c,Item__c,tkt_profile__r.Email__c,badgeparentid__c from Ticket__c where Ticket_Status__c !='Cancelled' and  Ticket_Status__c !='Available' and  Ticket_Status__c !='Reserved' and  Ticket_Status__c !='Deleted' and  Ticket_Status__c !='Abandoned' and Item__c in:allitemids];
      for(Ticket__c tc:childlist)
      {
       if(childmap.containskey(tc.Item__c))
        {
         List<Ticket__c> temp=new List<Ticket__c>();
         temp=childmap.get(tc.Item__c);
          temp.add(tc);
          childmap.put(tc.Item__c,temp);
        }
        else
        {
       
       List<Ticket__c> temp=new List<Ticket__c>();
       temp.add(tc);
       childmap.put(tc.Item__c,temp);
        }
       
      }
      List<Ticket__c> savetickets=new List<Ticket__c>();
      for(String it:childmap.keyset())
      {
          Map<String,List<Ticket>> tempparentmap=new Map<String,List<Ticket>>();
          tempparentmap=parentmap;
         for(Ticket__c tc:childmap.get(it))
         {
            if(tempparentmap.get(tc.tkt_profile__r.Email__c)!=null){
            List<Ticket> tclist=tempparentmap.get(tc.tkt_profile__r.Email__c);
            integer flag=0;
            for(integer i=0;i<tclist.size();i++)
            {
              if(tclist[i].used==false){
              tc.badgeparentid__c=tclist[i].TicketId;
              savetickets.add(tc);
              tclist[i].used=true;
              flag=1;
              
              break;
              
              }
                           
            }
            if(flag==0)//when all are mapped then extra added to last parent
            {
             tc.badgeparentid__c=tclist[tclist.size()-1].TicketId;
             savetickets.add(tc);
             }
            tempparentmap.put(tc.tkt_profile__r.Email__c,tclist);
            } 
            
         }
      }
      
      update savetickets;
      
      
      
      
        return null;
    }

    //Method for getting selected ticket ids for merge
  public PageReference selected_ticlist() {
        string ticlist1=Apexpages.currentPage().getParameters().get('ticketid_list');
        selected_ticlistTemp=new  list<string>();
        system.debug('ticlist               :' +ticlist1);
        
        selected_ticlistTemp= ticlist1.split(','); 
        system.debug('selected_ticlistTemp     :'+selected_ticlistTemp);
        
        return null;
    }
    public pageReference assigningTagOptions(){return null;}
    
    //Method for assigning tags through badge options
 /*   public PageReference assignTag() {
        BLNUtility blutil=new BLNUtility();
        for(List<BLN_Attendees_BAL.inncls> tclist:ListOfListAttendees)  {
            for(BLN_Attendees_BAL.inncls tc:tclist) {
                if(tc.selectCheckBox==true)  { 
                    blutil.AssignTags(tc.ticket.Id,tagName,selectedEvent,'Ticket__c');    
                }
            }
        }   
        
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return pg;
    }*/
    public List<string> selected_ticlistTemp44{get;set;}
    
    public PageReference assignTagActionFunction(){
        string ticlist44=Apexpages.currentPage().getParameters().get('ticketid_list44');
        selected_ticlistTemp44=new  list<string>();
        system.debug('ticlist44 :' +ticlist44);
        
        selected_ticlistTemp44= ticlist44.split(',');
        return null;
    }
    

    /* Defined By Anil, 
     Method:     AssignRoleToAttendee
     Description: To Update the UC Role Object Roleid__c field every time when assigned a role 
     */
    public void AssignRoleToAttendee(){

    //string id = apexpages.currentpage.getparameters.get();
      string rlnme=Apexpages.currentPage().getParameters().get('selectedroll');
      system.debug('-------------Rolename ID from Page-----'+rlnme);
      system.debug('-------------Tickets List Here---'+selected_ticlistTemp44);
      try {

        Id ucroleId = ID.valueOf(rlnme);
        system.debug('----------------Role Id from Page---'+ucroleId);
      Map<id,Ticket__c > tktmp = new map<id,Ticket__c >([Select id,Order__r.BLN_TKT_profile__c From Ticket__c where id IN:selected_ticlistTemp44]);
      system.debug('------------------Retrieved Tickets---'+tktmp.values());
      list<Id>tktpr = new list<Id>();
      for(Ticket__c tk:tktmp.values()){
        tktpr.add(tk.Order__r.BLN_TKT_profile__c);
      }
      system.debug('----------------Associated tkt profiles-for tickets--'+tktpr);
      
      Map<id,TKT_profile__c > tktprof = new Map<id,TKT_profile__c >([Select id,BLN_GN_User__c From TKT_profile__c  where id IN:tktpr]);
       //tktprof = ;
      system.debug('----------------AssociatedGN User For TKT Profiles---'+tktprof.values());
      list<id> idlst = new list<id>();
      for(TKT_profile__c tkp :tktprof.values() ){

        
        idlst.add(tkp.BLN_GN_User__c);
      }


      System.debug('-----------------------------GN User List Here---'+idlst);
      list<UC_Role__c> Ucr = [select id,GN_User__c,RoleId__c from UC_Role__c where GN_User__c IN:idlst ];
      list<UC_Role__c> UcrUpdate = new list<UC_Role__c>();
      for(UC_Role__c uc:Ucr){

        uc.RoleId__c =ucroleId;
        UcrUpdate.add(uc);
      }
      update UcrUpdate;
      for(UC_Role__c uc:UcrUpdate){
        System.debug('-------------------------Updated GN Users---Id--'+uc.id+'--UC role Id--'+uc.RoleId__c);
      }
      
      }
      catch(exception excp){

        system.debug('------------Type of Exception-----'+excp.getTypeName());
        system.debug('------------Line number of Exception-----'+excp.getLineNumber());
        system.debug('------------Cause of Exception-----'+excp.getCause());
        system.debug('------------Msg abt Exception-----'+excp.getMessage());
        
        
      }
      
      
    }
     public PageReference assignTag() {
     if(Apexpages.currentPage().getParameters().get('tagarray')!=null&&Apexpages.currentPage().getParameters().get('tagarray')!=''){
        BLNUtility blutil=new BLNUtility();
        
         for(integer i=0;i<selected_ticlistTemp44.size();i++) {
                        if(selected_ticlistTemp44[i] != null || selected_ticlistTemp44[i] != ''){
                        String []tagarray=Apexpages.currentPage().getParameters().get('tagarray').split(',');
                        for(integer k=0;k<tagarray.size();k++)
                            blutil.AssignTags(selected_ticlistTemp44[i],tagarray[k],selectedEvent,'Ticket__c');
                        }
                    }
                
        }
        //PageReference pg= new Pagereference('/apex/BLN_Attendees');
        //pg.setRedirect(true);
        return null;
    }
    
    //Company name based on uc role
    public string pCompName{get;set;}

    public PageReference CloseGuests() {
     // displyAddGuest = false;
        return null;
    }

        //Modified by Thirupathi Pattipaka
      public PageReference createBadgeLabel() {
       string new_bl1 = Apexpages.currentPage().getParameters().get('bl1');
           string tID1 = Apexpages.currentPage().getParameters().get('rowID1');
           //system.debug('new_bNo1:'+new_bNo1+'       tID1:'+tID1);       
           Ticket__c tkt1= [select id,name,Badge_Label__c,Tag_No__c from Ticket__c WHERE Name = :tID1 ];
           tkt1.Badge_Label__c= new_bl1 ;
           update tkt1;
           return null;
    }
    
    //Updating seat Number for respective ticket
    public PageReference createSeatNumber() {
        string new_sn1 = Apexpages.currentPage().getParameters().get('sn1');
           string tID2 = Apexpages.currentPage().getParameters().get('rowID2');
           system.debug('       tID2:'+tID2);       
           Ticket__c tkt2= [select id,name,Badge_Label__c,Tag_No__c from Ticket__c WHERE Name = :tID2 ];
           tkt2.Tag_No__c = new_sn1;
           update tkt2;
           return null;
    }
    
    //Updating badge status for respective ticket
    public PageReference changeBadgeStatus() {
        string new_bs1 = Apexpages.currentPage().getParameters().get('bs1');
        System.debug('BBBBBSSSSS:'+new_bs1);
           string tID3 = Apexpages.currentPage().getParameters().get('rowID3');
           //system.debug('new_bNo1:'+new_bNo1+'       tID1:'+tID1);       
           Ticket__c tkt3= [select id,name,Badge_Label__c,Badge_ID__c,Tag_No__c from Ticket__c WHERE Name = :tID3 ];
           if(new_bs1=='Not Printed'){
               tkt3.Badge_ID__c=null;    
           }
           
           update tkt3;
           return null;
    }
    
   /* @RemoteAction
    global static boolean changeBadgeStatus(String new_bs1,String tID3) {
        Ticket__c tkt3= [select id,name,Badge_Label__c,Badge_ID__c,Tag_No__c,Event__c from Ticket__c WHERE Name = :tID3 ];           
           boolean errobool = false;
           if(new_bs1=='Not Printed'  && tkt3.Badge_ID__c!=null){
               //tkt3.Badge_ID__r.print_status__c='Not Printed';     
               Badge__c  bdg=[select id,name,print_status__c from Badge__c where id= : tkt3.Badge_ID__c];
                    bdg.print_status__c='Not Printed'; 
                    update bdg;
           }else{
               
               /*Badge__c bdg=new badge__c();
               try{
               bdg=[select id,name from Badge__c where ticket_id__r.id= : tkt3.id order by lastmodifieddate desc limit 1];
               }catch(exception e){}
               if(bdg.id!=null){
               tkt3.Badge_ID__c=bdg.id;
               }else{
                   errobool = true;
               }*/
                /*   if(tkt3.Badge_ID__c!=null){
                   Badge__c  bdg=[select id,name,print_status__c from Badge__c where id= : tkt3.Badge_ID__c];
                    bdg.print_status__c='Printed'; 
                    update bdg;
                   }else{
                    errobool = true;
               }
           }
           //update tkt3.Badge_ID__r;
           update tkt3;
           return errobool; 
    }*/


  
    public BLN_UtillDisplayLinks   myticket { get; set; }
    public string selectedEvent {get ; set ;}
         public  List<String> selected_ticlistTemp11{get;set;}
              //   public string selectedbdtemname {get;set;}
    
    
    public integer z{get;set;} 
    public BLN_Event__c   se{get;set;}
    public BLN_Mytickets_BAL blnMyticketsBal {get;set;}
    
    // checking status history
    public List<Tstatus__c> checkinHistoryList{get;set;}
    
    public  LIst<List<BLN_Attendees_BAL.inncls>>  ListOfListAttendees{get;set;}
    
     public void displayPermissions(){
     //process of showing company name based on uc role
        //BLN_MyticketsCon myTicBal=new BLN_MyticketsCon();
        //pCompName=myTicBal.pcompanies;
        try{
      cookie k = ApexPages.currentPage().getcookies().get('counter');
          if(k!=null){
            selectedEvent =k.getValue();
           
          }
         
     system.debug('WWWWWWWWWWWWWWWWWWWWW '+selectedEvent );
      myticket = new BLN_UtillDisplayLinks();    
     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     se = new BLN_Event__c  ();
      try{
      se = blneventdetailbal.eventdetails(selectedEvent );
      myticket.EventName=se.Name;
     }catch(exception e){}
          
      
         myticket.isAttendeesPage='active';
         myticket.tablabel='Attendees';
         myticket.isEventAdmin =true;
         myticket.EventId = selectedEvent ;
         myticket.isAttendeesPageExpand ='expand';
         myticket.userPermissions(userInfo.getUserId(),selectedEvent);
    }
         catch(exception ex){}
    }
    
     @Readonly
    @RemoteAction
     public static BLN_RegDashBoardInfo attendeeStats(String eventid){
         //Statistics
          BLN_RegDashBoardInfo stats=new BLN_RegDashBoardInfo(eventid);
          
          return stats;
    }
     
    public String selectedAttendeeType{get; set;} //for filter criteria
     public LIST<SelectOption> attendeeTypes{get; set;}
    public List<Ticket__c> Alltkt{get; set;}
    public static List<Ticket__c> BadgeAlltkt{get; set;}
    Public  list<Id> Allids = new list<Id>();
    Public  Static list<Id> BadgeAllids = new list<Id>();
    public string unheckedids{get;set;}
    public list<Item_Type__c> TTypeList{get;set;}
    public List<ticket__c> TList{get;set;}
    public MAp<string,string> displaySettingsAttMap{get;set;} 
    public BLN_AttendeesController(){
    
     try{
         cookie k = ApexPages.currentPage().getcookies().get('counter');
         if(k!=null){
          selectedEvent = k.getValue();
          
          
          }
            attendeesList =new list<ticket__c>();
          //Label Names from Display Settings
          BLN_TicketTypeLabelCon label=new BLN_TicketTypeLabelCon();
          RegList=new List<Reg_Setting__c>();
          RegList=label.ticketTypeLabelNames(selectedEvent);
          displaySettingsAttMap=new Map<string,string>(); 
          displaySettingsAttMap=label.displaySettingLabels(selectedEvent);
          system.debug('VVVVVVV::'+label.displaySettingLabels(selectedEvent));
          
         /*
          set<id> itmSet=new set<id>();
          TList=new List<ticket__c>();
          TList=[select id,name,item_pool__r.item_type__r.name,item_pool__r.item_type__c,item_pool__r.item_pool_name__c,item_pool__c from Ticket__c where event__c= : selectedEvent and Ticket_Status__c='Booked'];
            for(ticket__c t :TList){
                itmSet.add(t.item_pool__r.item_type__c);
            } 
            TTypeList=new List<Item_Type__c>();
            TTypeList = [select id,name from Item_Type__c where id in : itmSet];
          
          */
        
          //selectedEvent  = 'a0sc00000030kAi';
           system.debug('WWWWWWWWWWWWWWWWWWWWW 22222222222222222'+selectedEvent );
          if(selectedEvent !=null && selectedEvent !=''){ 
              mainMethod();
          }
          //assigningbadgelabel();
      
     
      
      //Filter criteria
      attendeeTypes= new LIST<SelectOption>();
        attendeeTypes.add(new SelectOption('All Attendees', 'All Attendees'));
        attendeeTypes.add(new SelectOption('Buyers Only', 'Buyers Only'));
      selectedAttendeeType= 'All Attendees';
      
      //default for avery
      bdstyleslist = new  LIST<selectoption> ();
    Bdstyles = new List<BLN_Badge_Style__c> ();
  
    Bdstyles = [select id,Name,Data__c,Description__c from BLN_Badge_Style__c where Event__c=: selectedEvent ];

    for(BLN_Badge_Style__c BTS : Bdstyles ){
 bdstyleslist.add(new selectoption(BTS.Name,BTS.Description__c));


    System.debug('bbbbbbbbbbbbb:'+bdstyleslist);
    }
    //end
    
    
        
       }catch(exception ex){}
    }
     
     public Map<Id,String> tagsmap{get;set;}
     public Map<Id,String> tickettagsmap{get;set;}
     public SET<Id> statusId{get;set;}
     public Map<Id,List<Reg_Setting__c>> regListMap{get;set;}
     public List<Reg_Setting__c> rgList {get; set;}
     public List<Reg_Setting__c> rgListTemp {get; set;}
     public String mapchecker{get;set;}
     public BLN_Attendees_BAL attBal{get;set;}
     
     //Common method to use for all reports displaying columns based on attendee settings
     public List<Reg_Setting__c> attendeeSettingList {get;set;}
     public List<Reg_Setting__c> attSetSetUpForReports(){
         return attendeeSettingList;
     }
     
     //method to use in attendee report 
     public List<Reg_Setting__c> regForReport(){
         return rgListTemp;
     }
      
     public void mainMethod(){
         //Counting all attendees
         totalAttendees=0;
         LIST<BLN_Attendees_BAL.inncls> attendeesList=new LIST<BLN_Attendees_BAL.inncls>();
     
         //Calculating Exhibitos
         totalExhibitors=0;
         LIST<BLN_Attendees_BAL.inncls> exhibitorsList=new LIST<BLN_Attendees_BAL.inncls>();
         
         //Calculating Sponsors
         totalSponsors=0;
         LIST<BLN_Attendees_BAL.inncls> SponsorsList=new LIST<BLN_Attendees_BAL.inncls>();
         
         //Calculating speakers
         totalSpeakers=0;
         LIST<BLN_Attendees_BAL.inncls> SpeakersList=new LIST<BLN_Attendees_BAL.inncls>();
         
         //Calculating no. of badges printed
         totalBadgePrint=0;
         LIST<BLN_Attendees_BAL.inncls> badgeList=new LIST<BLN_Attendees_BAL.inncls>();
         
         //Calculating no. of checkIns
         totalCheckIns=0;
         LIST<BLN_Attendees_BAL.inncls> checkInList=new LIST<BLN_Attendees_BAL.inncls>();
                  
         tagsmap=new Map<Id,String>();
         tickettagsmap=new Map<Id,String>();
         BLN_Gnuser_DAO guDAO = new BLN_Gnuser_DAO();
         
         attBal = new BLN_Attendees_BAL();
       
         BLN_OrderItem_DAO orderItemDao = new BLN_OrderItem_DAO();
         BLN_Order_DAO ordDao = new BLN_Order_DAO();
         
         BLN_Ticket_DAO tcDao=new BLN_Ticket_DAO();
         
         //get all tags
         for(Hash_Tag__c itptj:[select id,name,RowId__c,Tag_Text__c,Event__c,Table_Name__c from Hash_Tag__c where Event__c=:selectedEvent and Table_Name__c='Item_Pool__c'])
         {
            if(tagsmap.containsKey(itptj.RowId__c)){
            String text=tagsmap.get(itptj.RowId__c);
            if(text!=itptj.Tag_Text__c)
            tagsmap.put(itptj.RowId__c,text+' '+itptj.Tag_Text__c);
            }
            else
            tagsmap.put(itptj.RowId__c,itptj.Tag_Text__c);
         }
         //
         //get all tickets tag map
         for(Hash_Tag__c itptj:[select id,name,RowId__c,Tag_Text__c,Event__c,Table_Name__c from Hash_Tag__c where Event__c=:selectedEvent and Table_Name__c='Ticket__c'])
         {
            if(tickettagsmap.containsKey(itptj.RowId__c)){
            String text=tickettagsmap.get(itptj.RowId__c);
            tickettagsmap.put(itptj.RowId__c,text+' '+itptj.Tag_Text__c);
            }
            else
            tickettagsmap.put(itptj.RowId__c,itptj.Tag_Text__c);
         }
        
        
        //for reg seetings for selected event
        BLN_Displaysettings_BAL   blnregsetbal = NEW BLN_Displaysettings_BAL  ();
        
        rgList= new List<Reg_Setting__c>();    
        rgList= blnregsetbal.getregsettingslist(selectedEvent);
        
        List<Reg_Setting__c> attSetUpDataList =new List<Reg_Setting__c>();
        attSetUpDataList= blnregsetbal.attendeeSetUpList(selectedEvent);
        
        regListMap=new Map<Id,List<Reg_Setting__c>>();
        mapchecker='';
       
         
         
      }    
           
    
    
  
    
    //Arindam code for print
 //public BLN_BadgeTemplate_Styles__c btstyle{get;set;}
   public BLN_Badge_Style__c btstyle{get;set;}
   public List<BLN_Badge_Layer__c> bdLayers{get;set;}
   public Badge bg{get;set;}
   public List<Style> elems{get;set;}
    public void parseBadge(String bdg)
   {
     system.debug('uuuuunnnnnnn '+bdg);
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
      system.debug('nnnnnniiiiiiii '+elem);
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

//Code to print the badge for selected attendees
public Bln_Event__c evlogo{get;set;}
//public List<Ticket__c> printtickets{get;set;}
public static List<Ticket__c> printtickets{get;set;}
//public List<String> selected_ticlistTemp11{get;set;}
public pageReference printingbadge(){
    string ticlist11=Apexpages.currentPage().getParameters().get('ticketid_list11');
    string allpages=Apexpages.currentPage().getParameters().get('allpages');
    selected_ticlistTemp11=new  list<string>();
 //   selected_ticlistTemp11= ticlist11.split(',');
        
    return Null;
}

public PageReference updateExistingBadgenotprinted() {
    string ticlist11=Apexpages.currentPage().getParameters().get('ticketid_list11');
    string allpages=Apexpages.currentPage().getParameters().get('allpages');
    selected_ticlistTemp11=new  list<string>();
    selected_ticlistTemp11= ticlist11.split(',');
    List<String> allidlist = new List<String>();
String q='';
allidlist=Allids;
    List<Badge__c> updatebadgelabel=new List<Badge__c>();
 String idInUpdateBadgeStatus='(\'';
 BLn_Quick_Registration_BAL qb=new BLn_Quick_Registration_BAL();
 System.debug('allpages value is '+allpages);
    if(allpages=='false'){
  
 q='Select Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,Ticket__r.tkt_profile__r.First_Name__c,Ticket__r.tkt_profile__r.Last_Name__c,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name  From Ticket__c t where id in:selected_ticlistTemp11';
}
else{
 AllTktIds();
 modifyids(ticlist11);
/*all pages badge status option*****/
    
q='Select Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,Ticket__r.tkt_profile__r.First_Name__c,Ticket__r.tkt_profile__r.Last_Name__c,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name  From Ticket__c t where id in:Allids';
         
         /*all pages badge status option end*****/

}
 for(Ticket__c tc:Database.query(q))
          {
     System.debug('Badge id is....'+tc.Badge_ID__c);
     if(tc.Badge_ID__c!=null)
                   idInUpdateBadgeStatus+=tc.Badge_ID__c+ '\',\'';
                    }
     
         if(idInUpdateBadgeStatus!='(\''){
          idInUpdateBadgeStatus= idInUpdateBadgeStatus.substring(0,idInUpdateBadgeStatus.length()-2);
         idInUpdateBadgeStatus+= ')';
         q = 'Select id,name,Print_status__c From Badge__c where id in ' + idInUpdateBadgeStatus;
        updatebadgelabel=Database.query(q);
        for(integer p=0;p<updatebadgelabel.size();p++)
        updatebadgelabel[p].Print_status__c='Not Printed';
        update updatebadgelabel;
         }
         
         
         
       return null;  
         }

public static PageReference genpdf(List<String> selected_ticlist) {
   // System.debug('TMP111::'+selected_ticlistTemp11);
   // System.debug('TMP222::'+selected_ticlistTemp11.size());
    List<Badge__c> updatebadgelabel=new List<Badge__c>();
    
 String idInClause = '(\'';
 String idInUpdateBadgeStatus='(\'';
 BLn_Quick_Registration_BAL qb=new BLn_Quick_Registration_BAL();
 Map<String,String> ticketbadgemap=new Map<String,String>();
 //String q='Select Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,Ticket__r.First_Name__c,Ticket__r.Last_Name__c,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c,Item_type__r.name,Item_pool__r.Item_Pool_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name From Ticket__c t where id in:selected_ticlist';
 String q='Select Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c,Item_type__r.name,Item_pool__r.Item_Pool_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name From Ticket__c t where id in:selected_ticlist';
 
 //String q='Select Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,TKT_Job_Title__c,First_Name__c,order_item__r.Item_Quantity__c,Order__r.Client_GN_User__r.Mobile__c,Order__r.Client_GN_User__c,Order__r.Client_GN_User__r.Email__c,Order__r.Client_GN_User__r.First_Name__c,Order__r.Client_GN_User__r.Last_Name__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,Ticket__r.First_Name__c,Ticket__r.Last_Name__c,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,Last_Name__c,Company__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c,Item_type__r.name,Item_pool__r.Item_Pool_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Client_Company__r.Name,Name,Item_Type__r.Name ,Client_GN_User__c,Client_GN_User__r.phone__c,Client_GN_User__r.user__r.id,Client_GN_User__r.user__r.MobilePhone,Client_GN_User__r.First_Name__c,Client_GN_User__r.Last_Name__c,Client_GN_User__r.Email__c,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name,Client_GN_User__r.User_Pic__c,Client_GN_User__r.Mobile__c  From Ticket__c t where id in:selected_ticlistTemp11';
 
 printtickets=Database.query(q); 
 for(Ticket__c tc:printtickets)
          {
                   if(tc.badges__r.size()==0&&tc.Badge_ID__c==null)
                   ticketbadgemap.put(tc.id,tc.badge_label__c);
                   else
                   idInUpdateBadgeStatus+=tc.Badge_ID__c+ '\',\'';
                    }
      /*for(List<BLN_Attendees_BAL.inncls> tclist:ListOfListAttendees)
      {
          for(BLN_Attendees_BAL.inncls tc:tclist)
          {
               for(integer i=0;i<selected_ticlistTemp11.size();i++)
               {
              if(selected_ticlistTemp11[i]==tc.ticket.Name)
              {
                   if(tc.ticket.badges__r.size()==0&&tc.ticket.Badge_ID__c==null)
                   ticketbadgemap.put(tc.ticket.id,tc.ticket.badge_label__c);
                   else
                   idInUpdateBadgeStatus+=tc.ticket.Badge_ID__c+ '\',\'';
                   //qb.generateBadge(tc.ticket.badge_label__c,tc.ticket.id,'');
                   
                   
                   idInClause += tc.ticket.Id+ '\',\'';
                  
              }
              }
          }
      }*/
      qb.generateBadgeMultiple(ticketbadgemap);
     //if no attendees selected 
     //if(idInClause.length()<4)
     //return null;
     
      
      
      //idInClause  = idInClause.substring(0,idInClause.length()-2);
         //idInClause += ')';
         if(idInUpdateBadgeStatus!='(\''){
          idInUpdateBadgeStatus= idInUpdateBadgeStatus.substring(0,idInUpdateBadgeStatus.length()-2);
         idInUpdateBadgeStatus+= ')';
         q = 'Select id,name,Print_status__c From Badge__c where id in ' + idInUpdateBadgeStatus;
        updatebadgelabel=Database.query(q);
        for(integer p=0;p<updatebadgelabel.size();p++)
        updatebadgelabel[p].Print_status__c='Printed';
        upsert updatebadgelabel;
         }
         
        //String q = 'Select First_Name__c,Last_Name__c,Company__c,order__r.id,item__r.item_Name__c,(select id,name,item__r.item_Name__c,Item_type__r.name,Item_pool__r.Item_Pool_Name__c from badgeparentids__r),Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,Client_Company__r.Name,Name,Item_Type__r.Name ,Client_GN_User__c,Client_GN_User__r.user__r.MobilePhone,Client_GN_User__r.First_Name__c,Client_GN_User__r.City__c,Client_GN_User__r.Last_Name__c,Client_GN_User__r.Email__c,Order_Item__c,event__c,Parent_ID__c   From Ticket__c where id in ' + idInClause+' and badgeparentid__c=null';
        //printtickets=Database.query(q); 
        
       
 // btstyle=[select BadgeName__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BLN_BadgeTemplate_Styles__c where Event__c=:selectedEvent and name=:selectedbdtemname  limit 1];
  
//   evlogo=[select id,name,logo_url__c from Bln_Event__c where id=:selectedEvent];  
      //Arindam code
      //Parse Badge Name
    //if(btstyle.BadgeName__c!=null){    
//        String badgename=btstyle.BadgeName__c;
  //      parseBadge(badgename.substring(0,badgename.length()-1));
    //}else{}
    
    //elems=new List<Style>(); 
    //Parse Elements
    /* if(btstyle.FirstRowElement__c!=null&&btstyle.FirstRowElement__c != '')
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
     
      
      if(selectedprinter=='Avery_6'){
     pagereference pg = page.BLN_averylabel;
          pg.setredirect(false);
         return pg;}
          if(selectedprinter=='Avery_8'){
      pagereference pg = page.BLN_AveryAdhesive;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Zebra'){
      pagereference pg = page.BLN_zebralabel;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Brother'){
      pagereference pg = page.BLN_brotherlabel;
          pg.setredirect(false);
         return pg;}
         else
         */
         return null;
  
    
 }

  public List<BLN_Badge_Style__c> Bdstyles {get ; set ;}
 public LIST<selectoption> bdstyleslist {get ; set ;}
 public string selectedbdtemname {get;set;}
public PageReference findtemplate() {
     bdstyleslist = new  LIST<selectoption> ();
     if(selectedprinter =='Avery_6')
    // Bdstyles = [select id,Name,badge_type__c,Module__c from BLN_BadgeTemplate_Styles__c where Event__r.id =: selectedEvent and badge_type__c='Zebra' and Module__c like '%Attendee Registration%' ];
     //else if(selectedprinter =='Avery_8')
    // Bdstyles = [select id,Name,badge_type__c,Module__c from BLN_BadgeTemplate_Styles__c where Event__r.id =: selectedEvent and badge_type__c='Avery' and Module__c like '%Attendee Registration%' ];
       
    // else
   //  Bdstyles = [select id,Name,badge_type__c,Module__c from BLN_BadgeTemplate_Styles__c where Event__r.id =: selectedEvent and badge_type__c=:selectedprinter and Module__c like '%Attendee Registration%'];
    for(BLN_Badge_Style__c BTS : Bdstyles ){
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
    
    
    //Ticket to merge with options
    
    public String selectedtickets{get;set;}
    public String selectedmergebadgelabel{get;set;}
    public List < selectoption > mergeticketlist{get;set;}
    public list<string> selected_ticNameTemp1{get;set;}
   public class MergeTicket
    {
       public String TicketId{get;set;}
       public String TicketName{get;set;}
       public String AttendeeName{get;set;}
       }
       public transient Map<String,List<MergeTicket>> order{get;set;}
     public transient Map<String,List<Map<String,List<MergeTicket>>>> emailorder{get;set;}    
    
   //method to get the ticket id and tickets to merge badges
     public pagereference getTicketToMergeList() {
        List<String> emails=Apexpages.currentPage().getParameters().get('email_list').split(',');
        System.debug('emails '+emails);
         String idInClause = '(\'';
         for(integer i=0;i<emails.size();i++)
         idInClause += emails[i]+ '\',\'';
         if(idInClause.length()<4)
     return null;
     idInClause  = idInClause.substring(0,idInClause.length()-2);
         idInClause += ')';
         //Get all the emails
         String queryString='';
          string ststus3 = '';
        string temp = '';
       queryString='select id,name,tkt_Profile__r.Email__c from Ticket__c where id in '+idInClause;
        
         List<Ticket__c> tclist=Database.query(queryString);
         Set<String> emailset=new Set<String>();
         for(integer i=0;i<tclist.size();i++)
         {
           emailset.add(tclist[i].tkt_Profile__r.Email__c);
         }
         
         
         idInClause = '(\'';
         for(String email:emailset)
         idInClause += email+ '\',\'';
         if(idInClause.length()<4)
     return null;
     idInClause  = idInClause.substring(0,idInClause.length()-2);
         idInClause += ')';
          BLN_Ticket_DAO tcDAo = new BLN_Ticket_DAO();
         string status ='Cancelled';
      string ststus_a = 'Abandoned';
       string ststus_n = 'Not Paid';
        ststus3 = 'N - No Badge';
        temp = ' where event__c = \''+selectedEvent+'\' '+' and  Ticket_Status__c != \''+status+'\''+' and order__c!=null and order_item__c != null and Item_Pool__r.Item_Type__r.name!=\'Package\' and tkt_Profile__r.Email__c in '+ idInClause;
        
          temp+=' and  order__r.Order_Status__c != \''+status+'\'';
           temp+=' and  order__r.Order_Status__c != \''+ststus_a+'\'';
            temp+=' and  order__r.Order_Status__c != \''+ststus_n+'\'';
         temp+=' order by order__c';
         
         if(emailset.size()!=0) {
        order=new Map<String,List<MergeTicket>>();
         emailorder=new Map<String,List<Map<String,List<MergeTicket>>>>();
            for(Ticket__c tc : tcDao.userOrderAndTickets(temp)){
             MergeTicket mg=new MergeTicket();
            mg.TicketId=tc.Id;
            mg.TicketName=tc.Item_Pool__r.Item_Pool_Name__c;
            mg.AttendeeName=tc.tkt_Profile__r.First_Name__c+' '+tc.tkt_Profile__r.Last_Name__c;
            if(!order.containsKey(tc.tkt_Profile__r.Email__c+','+tc.order__r.Name)){
            List<MergeTicket> mglist=new List<MergeTicket>();
             mglist.add(mg);
            order.put(tc.tkt_Profile__r.Email__c+','+tc.order__r.Name,mglist);
            }
            else
            {
              List<MergeTicket> mgtemp=order.get(tc.tkt_Profile__r.Email__c+','+tc.order__r.Name);
              mgtemp.add(mg);
              order.put(tc.tkt_Profile__r.Email__c+','+tc.order__r.Name,mgtemp);
            }
            
           
         }
         
         for(String email:order.keyset())
         {
            String[] split=email.split(',');
            if(emailorder.containskey(split[0]))
            {
             List<Map<String,List<MergeTicket>>> ordlist=new List<Map<String,List<MergeTicket>>>();
             ordlist=emailorder.get(split[0]);
             Map<String,List<MergeTicket>> ordmap=new Map<String,List<MergeTicket>>();
             ordmap.put(email,order.get(email));
            ordlist.add(ordmap);
            emailorder.put(split[0],ordlist);
            }
            else
            {
            List<Map<String,List<MergeTicket>>> ordlist=new List<Map<String,List<MergeTicket>>>();
           Map<String,List<MergeTicket>> ordmap=new Map<String,List<MergeTicket>>();
             ordmap.put(email,order.get(email));
            ordlist.add(ordmap);
            emailorder.put(split[0],ordlist);
            }
         }
         
         System.debug(' ariorder '+order);
         }
         
         
         System.debug(' emailorder '+emailorder);
          
        return null;
    } 
    
    
    //merge badge
    public PageReference mergeBadge() {
         
        String parentticket=Apexpages.currentPage().getParameters().get('parentticket');
        List<String> restoftheticket=Apexpages.currentPage().getParameters().get('restoftheticket').split(',');
        System.debug('parentticket'+parentticket);
        System.debug('restoftheticket'+restoftheticket);
        
         
        String q = 'select id,name,cancel_time__c,Badge_Label__c from Badge__c where ticket_id__c in :restoftheticket and cancel_time__c=null and Exp_time__c=null';
        List<Badge__c> badges=Database.query(q);
        For(integer i=0;i<badges.size();i++)
        {
          badges[i].cancel_time__c=System.now();           
        } 
        update badges;
         //update parent badge badgeparent id null if it is there
        q = 'select id,name,badgeparentid__c,Badge_Label__c,Badge_ID__c from Ticket__c where id=\''+parentticket+'\'';        
         List<Ticket__c> tcktsparent=Database.query(q); 
         for(integer i=0;i<tcktsparent.size();i++)
                 {
                   tcktsparent[i].badgeparentid__c=null;
                 }
                 update tcktsparent;
                
                              
        
        //Create badge for the First Ticket and associate all other tickets with that badge
         q = 'select id,name,Badge_Label__c,Badge_ID__c from Ticket__c where id in :restoftheticket and id!=\''+parentticket+'\'';        
         List<Ticket__c> tckts=Database.query(q);        
                    Badge__c bg=new Badge__c();
                    //bg.badge_label__c=tckts[0].badge_label__c;
                    bg.ticket_id__c=parentticket;
                    BLN_Badge_DAO bdgdao=new BLN_Badge_DAO();
                   
        BLN_StatusMessage bdgMsg =  bdgdao.insertbadge(bg);
         BLN_Quick_Registration_BAL qb=new BLN_Quick_Registration_BAL();
                 String successId=qb.generateBadge(tckts[0].badge_label__c,parentticket,'Merge');
           
              if(bdgMsg .successBool){
          
                 String badgeid=bdgMsg.successId;
                 for(integer i=0;i<tckts.size();i++)
                 {
                   tckts[i].badgeparentid__c=parentticket;
                 }
                 update tckts;
                              
              }
              
              return null;
    }
    
    //method to get all required values of selected check boxes for unmergin
    public List<string> selected_ticlistTemp22{get;set;}
    public List<selectoption> unmergelist{get;set;}
    public PageReference getMergeList() {
        /*unmergelist= new List < selectoption > ();
        string ticlist22=Apexpages.currentPage().getParameters().get('ticketid_list22');
        System.debug('UUUUUUMMMM:'+ticlist22);
        selected_ticlistTemp22=new  list<string>();
        selected_ticlistTemp22= ticlist22.split(',');
        System.debug('TPTP1111:'+selected_ticlistTemp22.size());
        
         if(selected_ticlistTemp22.size()!=0) {
             System.debug('TPTP00000:'+selected_ticlistTemp22.size());
             for(integer i=0;i<selected_ticlistTemp22.size();i++) {
                 if(selected_ticlistTemp22[i] != null || selected_ticlistTemp22[i] != '')
                     unmergelist.add(new selectoption(selected_ticlistTemp22[i],selected_ticlistTemp22[i]));
                 system.debug('mergeticketlist      :'+unmergelist);
             }
         }*/
         unmergelist= new List < selectoption > ();
         /*for(List<BLN_Attendees_BAL.inncls> tclist:ListOfListAttendees)
      {
          for(BLN_Attendees_BAL.inncls tc:tclist)
          {
              if(tc.ticket.badgeparentid__c==null&&tc.ticket.badgeparentids__r.size()!=0)
              { 
               unmergelist.add(new selectoption(tc.ticket.Id,tc.ticket.Name));
               
           }}}*/
           
        
        return null;
    }
    
     public String selectedunmergetickets { get; set; }
     
     
    public PageReference cancelBadge() {
     
         
        String q = 'select id,name,cancel_time__c,Badge_Label__c from Badge__c where ticket_id__c =\'' + selectedunmergetickets +'\' and cancel_time__c=null and Exp_time__c=null';
        List<Badge__c> badges=Database.query(q);
       
        
        For(integer i=0;i<badges.size();i++)
        {
          badges[i].cancel_time__c=System.now();           
        } 
                update badges;
        
        BLN_Quick_Registration_BAL qb=new BLN_Quick_Registration_BAL();
        
        List<Ticket__c> nullbadgeparentid=new List<Ticket__c>();
        
        for(Ticket__c tc:[Select id,name,(select id,name,badgeparentid__c,Badge_Label__c,item__r.item_Name__c from badgeparentids__r),Badge_Label__c,Badge_ID__c from Ticket__c where id=:selectedunmergetickets])
        {
        qb.generateBadge(tc.Badge_Label__c,tc.id,'');
           
           for(integer i=0;i<tc.badgeparentids__r.size();i++)
           {
               qb.generateBadge(tc.badgeparentids__r[i].Badge_Label__c,tc.badgeparentids__r[i].id,'');
              
               nullbadgeparentid.add(new Ticket__c(id=tc.badgeparentids__r[i].id,badgeparentid__c=null));
               
           }
        
        }
        
        update nullbadgeparentid;
        
       return null;
    }
    
   
    public List<selectoption> packagelist{get;set;}
    public String selectedpackagetickets { get; set; }
    public List<string> selected_ticlistTemp33 {get;set;}
     public PageReference getPackageList() {
         packagelist= new List< selectoption > ();
        packagelist.add(new selectoption('','None'));
          for(BLN_Item__c bli:[select id,Event__c,name,item_name__c,Item_Type__r.name,Available_Tickets__c from BLN_Item__c where Event__c=:selectedEvent and Item_Type__r.name='Package'])
          {
              packagelist.add(new selectoption(bli.id,bli.item_Name__c));
          }
          
           
           return null;
    }
    public List<BLN_Item__c> mergeitlist{get;set;}
    public PageReference getItemList() {
         mergeitlist= new List<BLN_Item__c> ();
        for(bln_item__c bli:[select id,Event__c,name,item_name__c,Item_Type__r.name,Available_Tickets__c,item_count__c from BLN_Item__c where Event__c=:selectedEvent and Item_Type__r.name!='Package'])
        {
          if(bli.Available_Tickets__c!=bli.item_count__c)
          mergeitlist.add(bli);
        }
          return null;
    }
    public transient List<Ticket__c> packagelistcontent{get;set;}
     public PageReference getPackageListContent() {
     packagelistcontent=new List<Ticket__c>();
     if(selectedpackagetickets!=null&&selectedpackagetickets!='')
     packagelistcontent=[select id,name,Item_Pool__c,Parent_ID__c,Item__c,Ticket_Status__c,tkt_Profile__r.First_Name__c,tkt_Profile__r.Last_Name__c from Ticket__c where Item__c=:selectedpackagetickets and Parent_ID__c=null and Ticket_Status__c='Booked'];
     return null;
    }
    
  
    public PageReference splitpackage() {
           /* BLN_Quick_Registration_BAL qb=new BLN_Quick_Registration_BAL();
            
    LIST<string> ticketidandpoolid= selectedpackagetickets.split(';');
    String ticketid=ticketidandpoolid[0];
    String poolid=ticketidandpoolid[1];
    System.debug('Split package'+ticketidandpoolid[0]+' '+ticketidandpoolid[1]);
    //Get all the admission tickets
    List<Ticket__c> admticket=[select id,name,Badge_Label__c,Item_Pool__c,Item_Pool__r.Item_type__r.name,Parent_ID__c from Ticket__c where Parent_ID__c=:ticketidandpoolid[0] and Item_Pool__r.Item_type__r.name='Admissions'];
    //Generate badges for admission tickets
    for(integer i=0;i<admticket.size();i++)
           {
               qb.generateBadge(admticket[i].Badge_Label__c,admticket[i].id,'');
               }
               
     //Get all the line items pool except admission
    List<Item_Pool__c> otherpool=[select id,name,Addon_Parent__c,Item_Count__c,Item_type__r.name from Item_Pool__c where Addon_Parent__c=:ticketidandpoolid[1] and Item_type__r.name!='Admissions'];
    for(integer i=0;i<otherpool.size();i++)
           {
                //get addontickets for that pool
                List<Ticket__c> child=[select id,name,badgeparentid__c,Parent_ID__c,Item_Pool__c from Ticket__c where Parent_ID__c=:ticketidandpoolid[0] and Item_Pool__c=:otherpool[i].id];
                Integer j=0;
                for(;j<child.size();j++)
                {
                    if(j==admticket.size())
                    break;
                   child[j].badgeparentid__c=admticket[j].id;
                   
                }
                for(Integer rem=j;rem<child.size();rem++)
                {
                   child[rem].badgeparentid__c=admticket[admticket.size()-1].id;
                }
                  update child;
               
               }*/
               System.debug('pbs '+pbs);
               
     //Generate badges for admission tickets
     BLN_Quick_Registration_BAL qb=new BLN_Quick_Registration_BAL();
     List<Ticket__c> child=new List<Ticket__c>();
     Map<String,String> ticketbadgemap=new Map<String,String>();
    for(integer i=0;i<pbs.size();i++)
           {
               ticketbadgemap.put(pbs[i].TicketId,pbs[i].TicketBadgelabel);
                for(integer j=0;j<pbs[i].LineItemsId.size();j++)
                {
                child.add(new Ticket__c(id=pbs[i].LineItemsId[j],badgeparentid__c=pbs[i].TicketId));
                }
            }
    qb.generateBadgeMultiple(ticketbadgemap);
    update child;

        return null;
    }

public class packagebreak
{
  public String Ticket{get;set;}
  public String TicketId{get;set;}
  public String TicketBadgelabel{get;set;}
  public String TicketGnuserName{get;set;}
   public List<String> LineItems{get;set;}
   public List<String> LineItemsId{get;set;}
   
} 
 public List<packagebreak> pbs{get;set;}
 public String ticketpoolid{get;set;}
 public LIST<SelectOption> splitoption{get;set;}
 public PageReference previewpackage()
 {
 splitoption=new List<selectoption>();
 BLN_Quick_Registration_BAL qb=new BLN_Quick_Registration_BAL();
 pbs=new List<packagebreak>();
     try{       
    LIST<string> ticketidandpoolid= ticketpoolid.split(';');
    String ticketid=ticketidandpoolid[0];
    String poolid=ticketidandpoolid[1];
   
    //Get all the admission tickets
    List<Ticket__c> admticket=[select id,name,item__r.item_Name__c,Item_Pool__r.Item_Pool_Name__c,tkt_Profile__r.First_Name__c,tkt_Profile__r.Last_Name__c,Badge_Label__c,Item_Pool__c,Item_Pool__r.Item_type__r.name,Parent_ID__c from Ticket__c where Parent_ID__c=:ticketidandpoolid[0] and Item_Pool__r.Item_type__r.name='Admissions'];
   for(integer i=0;i<admticket.size();i++)
           {
              packagebreak p=new packagebreak();
              p.Ticket=admticket[i].Item_Pool__r.Item_Pool_Name__c;
              p.TicketId=admticket[i].id;
              p.TicketBadgelabel=admticket[i].Badge_Label__c;
              p.TicketGnuserName=admticket[i].tkt_Profile__r.First_Name__c+' '+admticket[i].tkt_Profile__r.Last_Name__c;
              p.LineItems=new List<String>();
              p.LineItemsId=new List<String>();
               pbs.add(p);
               }
               
     //Get all the line items pool except admission
    List<Item_Pool__c> otherpool=[select id,name,Addon_Parent__c,Item_Count__c,Item_type__r.name from Item_Pool__c where Addon_Parent__c=:ticketidandpoolid[1] and Item_type__r.name!='Admissions'];
    
    for(integer i=0;i<otherpool.size();i++)
           {
                //get addontickets for that pool
                List<Ticket__c> child=[select id,name,badgeparentid__c,Parent_ID__c,Item_Pool__c,Item_Pool__r.Item_Pool_Name__c from Ticket__c where Parent_ID__c=:ticketidandpoolid[0] and Item_Pool__c=:otherpool[i].id];
                Integer j=0;
                for(;j<child.size();j++)
                {
                    if(j==admticket.size())
                    break;
                   child[j].badgeparentid__c=admticket[j].id;
                  
                   pbs[j].LineItems.add(child[j].Item_Pool__r.Item_Pool_Name__c);
                   pbs[j].LineItemsId.add(child[j].Id);
                  splitoption.add(new Selectoption(String.valueOf(child[j].id),child[j].Item_Pool__r.Item_Pool_Name__c+'--'+String.valueOf(child[j].name)));
                   
                }
                for(Integer rem=j;rem<child.size();rem++)
                {
                   child[rem].badgeparentid__c=admticket[admticket.size()-1].id;
                   pbs[admticket.size()-1].LineItems.add(child[rem].Item_Pool__r.Item_Pool_Name__c);
                   pbs[admticket.size()-1].LineItemsId.add(child[rem].id);
                   splitoption.add(new Selectoption(String.valueOf(child[rem].id),child[rem].Item_Pool__r.Item_Pool_Name__c+'--'+String.valueOf(child[j].name)));
                }
                
               
               }
    
    System.debug('pbs '+pbs);
    }catch(Exception e){}
    return null;
   }
   
   // ----------------------------------------- Actions on order details popup --------------------------------------   
  //public Ticket__c addGuest{get;set;}
  //public boolean displyAddGuest{get;set;} 
  public string companyName {get;set;}
  //public GN_User__c gnUser{get;set;}
  //public Company__c comp {get;set;}
  public Company_Ext__c compext {get;set;}
  public MAP<id,List<Reg_Setting__c>> settingsForbuyerMAp{get;set;}
  public  List<Reg_Setting__c> settingsForbuyer{get;set;} //To display buyer settings
  public UC_Role__c ucrole{get;set;}
   public List<surveyCls> ticketLevelQuestions {get;set;}
  public  List<surveyCls> eventLevelQuestions {get;set;}
  
  
    // disply edit guest  pop up
  
  
  public class surveyCls{
    public Item_Question__c question{get;set;}
    public List<user_Answer__c> answers{get;set;}
    public surveyCls(Item_Question__c question1,List<user_Answer__c> answers1){
        question = new Item_Question__c();
        answers = new List<user_Answer__c>(); 
        if(question1!=null){
        this.question =question1;
        }
        if(answers1.size()>0){
        this.answers = answers1;
        }
    }
  }
  
    public void closeGuest(){
    //displyAddGuest= false;
     
    }
    
  
   
        
        
    //Method to assinging Bagde Labes
    
    public SET<Id> tickedRows{get;set;}
    public PageReference assigningbadgelabel(){
        tickedRows=new SET<Id>();
        string badgename1 = Apexpages.Currentpage().getparameters().get('assignBadgeTemp');
      
        
        List<Ticket__c> selTickList = new List<ticket__c>();
        selTickList =[select id, name, Badge_Label__c from Ticket__c where Id IN :tickedRows];
        
        for(Ticket__c tcTemp : selTickList){
            tcTemp.Badge_Label__c=badgename1 ;
            update tcTemp;
        }
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return pg;
    }
    
    //Method to assigning new seat numbers from Badge Options
    public pageReference assigningSeatNumber(){
        tickedRows=new SET<Id>();
        string seatNo1 = Apexpages.Currentpage().getparameters().get('seatIDAssign');
        
       
        
        List<Ticket__c> selTickList = new List<ticket__c>();
        selTickList =[select id, name,Tag_No__c, Badge_Label__c from Ticket__c where Id IN :tickedRows];
        
        for(Ticket__c tcTemp : selTickList){
            tcTemp.Tag_No__c=seatNo1 ;
            update tcTemp;
        }
        
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return null;
    }
    
     //Method to converting printing status of attendees
    public pageReference convertBadgeState(){
        tickedRows=new SET<Id>();
        string printIDAssign= Apexpages.Currentpage().getparameters().get('printIDAssign');
        
       
        
        List<Ticket__c> selTickList = new List<ticket__c>();
        selTickList =[select id, name,Tag_No__c,Badge_ID__c, Badge_Label__c from Ticket__c where Id IN :tickedRows];
        
        for(Ticket__c tcTemp : selTickList){
            if(printIDAssign=='Not Printed'){
                tcTemp.Badge_ID__c=null;
            }            
            update tcTemp;
        }
        
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return pg;
    }
    
    //Method to merge badge label
    public PageReference update_mergelabels() {
        string newbadge1 = Apexpages.currentPage().getParameters().get('newbadge');
       string ticketid11 = Apexpages.currentPage().getParameters().get('ticketid1');
       //system.debug('newbooth1:'+newbooth1+'       ticketid1:'+ticketid11);       
       Ticket__c tktBL = [SELECT Name,Badge_Label__c FROM Ticket__c WHERE Name = :ticketid11];
       tktBL.Badge_Label__c = newbadge1 ;
       update tktBL;
        
        //New refined code 
        /*
        //cancel badge
          String idInClause = '(\'';
         for(List<BLN_Attendees_BAL.inncls> tclist:ListOfListAttendees)  {
          for(BLN_Attendees_BAL.inncls tc:tclist)
          {
              if(tc.selectCheckBox==true)
              { 
               idInClause += tc.ticket.Id+ '\',\'';
           }}}
         idInClause  = idInClause.substring(0,idInClause.length()-2);
         idInClause += ')';
         
        String q = 'select id,name,cancel_time__c,Badge_Label__c from Badge__c where ticket_id__c in ' + idInClause +' and cancel_time__c=null and Exp_time__c=null';
        List<Badge__c> badges=Database.query(q);
        For(integer i=0;i<badges.size();i++)
        {
          badges[i].cancel_time__c=System.now();           
        } 
        update badges;
        
        //Create badge for the First Ticket and associate all other tickets with that badge
         q = 'select id,name,Badge_Label__c,Badge_ID__c from Ticket__c where id in ' + idInClause+' and id!=\''+selectedtickets+'\'';        
         List<Ticket__c> tckts=Database.query(q);        
                    Badge__c bg=new Badge__c();
                    //bg.badge_label__c=tckts[0].badge_label__c;
                    bg.ticket_id__c=selectedtickets;
                    BLN_Badge_DAO bdgdao=new BLN_Badge_DAO();
                   
                BLN_StatusMessage bdgMsg =  bdgdao.insertbadge(bg);
           
              if(bdgMsg .successBool){
          
                 String badgeid=bdgMsg.successId;
                 for(integer i=0;i<tckts.size();i++)
                 {
                   tckts[i].badgeparentid__c=selectedtickets;
                 }
                 update tckts;
                              
              }
        */
        
        
        return null;
    }
    
    //Method to assign badge labels refined code
    public PageReference update_badgelabels() {
        string newbadge1 = Apexpages.currentPage().getParameters().get('newbadge');
       string ticketid11 = Apexpages.currentPage().getParameters().get('ticketid1');
       String allpages = Apexpages.currentPage().getParameters().get('allpages');
      String unckedlist = Apexpages.currentPage().getParameters().get('unckedlist');
       selected_ticlistTemp44=new  list<string>();
        selected_ticlistTemp44= ticketid11.split(',');

      List<Ticket__c> tcklist=new List<Ticket__c>();
       //system.debug('newbooth1:'+newbooth1+'       ticketid1:'+ticketid11);     
        if(allpages=='false'){
        for(integer i=0;i<selected_ticlistTemp44.size();i++) {
                        if(selected_ticlistTemp44[i] != null || selected_ticlistTemp44[i] != ''){
                            Ticket__c newtc=new Ticket__c(id=selected_ticlistTemp44[i],Badge_Label__c=newbadge1 );
                            tcklist.add(newtc);
                        }
                    }  
       }else{
        
        AllTktIds();
       modifyids(unckedlist);
                   
        for(integer i=0;i<Allids.size();i++) {
                           
                    if(Allids[i] != null || Allids[i] != ''){
                            Ticket__c newtc=new Ticket__c(id=Allids[i],Badge_Label__c=newbadge1 );
                            tcklist.add(newtc);
                        }
                    }
       
       
       }
       update tcklist;
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return pg;
    }
    
    //Method to assign seat No.
    public PageReference update_seatNos() {
        
        string new_seat2 = Apexpages.currentPage().getParameters().get('newseat');
       string tID1 = Apexpages.currentPage().getParameters().get('ticketid');
       String allpages = Apexpages.currentPage().getParameters().get('allpages');
      String unckedlist = Apexpages.currentPage().getParameters().get('unckedlist');
      
       
       selected_ticlistTemp44=new  list<string>();
        selected_ticlistTemp44= tID1.split(',');
        List<Ticket__c> tcklist=new List<Ticket__c>();
       //system.debug('newbooth1:'+newbooth1+'       ticketid1:'+ticketid11);     
 if(allpages=='false'){      
      for(integer i=0;i<selected_ticlistTemp44.size();i++) {
                        if(selected_ticlistTemp44[i] != null || selected_ticlistTemp44[i] != ''){
                            Ticket__c newtc=new Ticket__c(id=selected_ticlistTemp44[i],Tag_No__c=new_seat2 );
                            tcklist.add(newtc);
                        }
                    }  
                    
                    }else{
       AllTktIds();
       modifyids(unckedlist);
      
                   
        for(integer i=0;i<Allids.size();i++) {
                           
                    if(Allids[i] != null || Allids[i] != ''){
                            Ticket__c newtc=new Ticket__c(id=Allids[i],Tag_No__c=new_seat2 );
                            tcklist.add(newtc);
                        }
                    }
       
       
       }
       
       update tcklist;
        PageReference pg= new Pagereference('/apex/BLN_Attendees');
        pg.setRedirect(true);
        return pg;
       
    }
    
    @RemoteAction
    global static List<filterclass> getTicketTypesForFilter(String eventid){
        
        List<filterclass>  TTFilterList=new List<filterclass>();
        List<ticket__c>  TList=new List<ticket__c>();
         TList=[select id,name,item_pool__r.item_type__r.name,item_pool__r.item_type__c,item_pool__r.item_pool_name__c,item_pool__c from Ticket__c where event__c= : eventid and Ticket_Status__c='Booked' AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')];
            
            set<id> dupticid=new set<id>();
            set<id> itmSet=new set<id>();
            string itmpool=''; 
            for(ticket__c t :TList){
                if(!itmpool.contains(t.item_pool__c)){
                    itmpool+=t.item_pool__c;
                    dupticid.add(t.id);
                    itmSet.add(t.item_pool__c);
                }
                
            } 
            
            List<ticket__c>  TListTemp=new List<ticket__c>();
            TListTemp=[select id,name,item_pool__r.item_type__r.name,item_pool__r.item_type__c,item_pool__r.item_pool_name__c,item_pool__c from Ticket__c where id in : dupticid];
            
            List<item_pool__c> TTypeList=new List<item_pool__c>();
            string poolstring='';
            for(item_pool__c ip : [select id,name,item_type__r.name from item_pool__c where id in : itmSet]){
                if(poolstring.contains(ip.item_type__r.name)==false){
                    poolstring=poolstring+ip.item_type__r.name;
                    TTypeList.add(ip);
                }
            }
            
            TTFilterList.add(new filterclass(TListTemp,TTypeList));
        return TTFilterList;
    }
    
    global class filterclass{
        global list<ticket__c> ticketNameFilterList{get;set;}
        global list<item_pool__c> ticketTypeFilterList{get;set;}
        global filterclass(list<ticket__c> ticketNameFilterList1,list<item_pool__c> ticketTypeFilterList1){
            this.ticketNameFilterList=ticketNameFilterList1;
            this.ticketTypeFilterList=ticketTypeFilterList1;
        }
    }
    
    @RemoteAction
    global static Set<String> getFilterTags(String eventid) {
    Set<String> s=new Set<String>();
    List<Hash_Tag__c> htagbl = [SELECT id,Name,Tag_Text__c,Table_Name__c,Event__c FROM Hash_Tag__c WHERE Event__c =:eventid and Table_Name__c!=null];       
    for(Hash_Tag__c htag:htagbl)
    {
    s.add(htag.Tag_Text__c);
    }
       return s;
    }
    @RemoteAction
    global static Integer getNotprintedcount(String ticketids) {
   list<string> selected_tic=new  list<string>();
    selected_tic= ticketids.split(',');
     List<Ticket__c> tktBL = [SELECT Name,Badge_Label__c,Badge_ID__c,Badge_ID__r.Print_status__c,Tag_No__c FROM Ticket__c WHERE id in:selected_tic and (Badge_ID__c=null or Badge_ID__r.Print_status__c='Not Printed')];       
       if(tktBL.size()>0)
       return 1;
       else 
       return 0;
    }
    /*new code*/
    @RemoteAction
    global static Integer getBadgecreatedornot(String ticketids) {
   list<string> selected_tic=new  list<string>();
    selected_tic= ticketids.split(',');
     List<Ticket__c> tktBL = [SELECT Name,Badge_Label__c,Badge_ID__c,Badge_ID__r.Print_status__c,Tag_No__c FROM Ticket__c WHERE id in:selected_tic and (Badge_ID__c=null )];       
       if(tktBL.size()>0)
       return 1;
       else 
       return 0;
    }
    
    
    //Method to change badge state
    /*public PageReference update_bstates() {
        
        string new_stat2 = Apexpages.currentPage().getParameters().get('newbstate');
       string tID2 = Apexpages.currentPage().getParameters().get('ticketid');
             
       Ticket__c tktBL = [SELECT Name,Badge_Label__c,Tag_No__c,Badge_ID__c FROM Ticket__c WHERE Name = :tID2 ];
       if(new_stat2 =='Not Printed'){
           tktBL.Badge_ID__c = Null ;
       }       
       update tktBL;
        return null;
    }*/
    
   /* global class TickettoPrint
    {
     public boolean errobool1{get;set;}
     public String ticIDfailed{get;set;}
    } 
    
    @RemoteAction
    global static TickettoPrint update_bstates(String newbstate,String ticketid) {
        list<string> tID2= ticketid.split(',');
        LIST<Ticket__c> tkt3= [SELECT Name,Badge_ID__r.print_status__c,Badge_Label__c,Tag_No__c,Badge_ID__c FROM Ticket__c WHERE Name = :tID2 ];           
           boolean errobool1 = false;
           string ticIDfailed='';
           list<ID> npID=new LIST<ID>();
           list<ID> pID=new LIST<ID>();
           TickettoPrint tprint=new TickettoPrint();
           for(ticket__c t:tkt3){
               if(newbstate=='Not Printed' && t.Badge_ID__c!=null){
                   t.Badge_ID__r.print_status__c='Not Printed'; 
                     npID.add(t.Badge_ID__c);
               }else{
                   if(t.Badge_ID__c!=null){
                    t.Badge_ID__r.print_status__c='Printed'; 
                    pID.add(t.Badge_ID__c);
                   }else{
                    tprint.errobool1 = true;
                    tprint.ticIDfailed=tprint.ticIDfailed+','+t.name;
    }
               }
           }
           if(npID.size()>0){
           Badge__c  bdg=[select id,name,print_status__c from Badge__c where id= : npID];
                    bdg.print_status__c='Not Printed'; 
                    update bdg;
           }else if(pID.size()>0){
           Badge__c  bdg=[select id,name,print_status__c from Badge__c where id= : pID];
                    bdg.print_status__c='Printed'; 
                    update bdg;
           }
           update tkt3;
    return tprint; 
    }*/
   public List<Reg_Setting__c> RegList{get;set;}
//Pagination Logic
public string dataTableJson {get;set;}//store the records as JSON
 ///using StandardSetController to avoid offset 2000 issue////
    public ApexPages.StandardSetController setCon {get;set;}
    public list<ticket__c> attendeesList{get;set;}
public void processData(){
 system.debug('RRRRRGGGGG:::'+RegList);
         string ststus3 = 'N - No Badge';
        string temp = ' where event__c = \''+SelectedEvent+'\' '+' and  Ticket_Status__c != \''+'Cancelled'+'\''+' and  Ticket_Status__c != \''+'Available'+'\''+' and  Ticket_Status__c != \''+'Reserved'+'\''+' and  Ticket_Status__c != \''+'Deleted'+'\''+' and  Ticket_Status__c != \''+'Abandoned'+'\'';
             //temp+=' and  (Item_Type__r.Badgable__c != \''+ststus3 +'\' OR Item_Pool__r.Badgable__c != \''+ststus3+'\')';//Commented for only badgable ticket
             temp+=' and   Item_Pool__r.Badgable__c != \''+ststus3+'\'';
              BLN_Event__c se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        
        try{
           se = blneventdetailbal.eventdetails(selectedEvent );
           
            }catch(Exception e){}
            if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
      List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:SelectedEvent and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          String idInClause = '(\'';
          for(BLN_Scanusr_item__c s:sc)
          idInClause += s.BLN_Item_Pool__c + '\',\'';
          idInClause  = idInClause.substring(0,idInClause.length()-2);
          idInClause += ')';
          temp = ' where event__c = \''+SelectedEvent+'\' '+' and  Ticket_Status__c != \''+'Cancelled'+'\''+' and  Ticket_Status__c != \''+'Available'+'\''+' and  Ticket_Status__c != \''+'Reserved'+'\''+' and  Ticket_Status__c != \''+'Deleted'+'\''+' and  Ticket_Status__c != \''+'Abandoned'+'\'';
             temp+='and Item_Pool__r.Item_Type__r.name!=\'Package\' and Item_Pool__c in'+idInClause ;
              
        }  
        }     
      String queryString= 'Select Event__r.Time_Zone__c,Order__r.createddate,tkt_profile__r.TKT_Job_Title__c,Custom_Barcode__c, tkt_profile__r.TKT_Company__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,Order__r.BLN_TKT_profile__c,Order__r.BLN_TKT_profile__r.Email__c,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,tkt_profile__r.BLN_Company__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,tkt_profile__r.BLN_Company__r.Name,Name,Item_Type__r.Name ,tkt_profile__c,tkt_profile__r.Mobile__c,tkt_profile__r.BLN_GN_User__r.First_Name__c,tkt_profile__r.BLN_GN_User__r.Last_Name__c,tkt_profile__r.Email__c,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name,tkt_profile__r.BLN_GN_User__r.User_Pic__c  From Ticket__c t '+ temp;
     
        
           
    String searchKey = ApexPages.currentPage().getParameters().get('search[value]');
        
                 //check the search box value

                if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
                        System.debug('!!!!!! Serach key is '+searchKey);
                        //System.debug(searchKey.split(' '));
                        
                         String[] tokens = searchKey.split(' ');
                                   
                                if(tokens.size()==2){
                                queryString+='and ((tkt_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and tkt_profile__r.Last_Name__c  like \'%'+tokens[1]+'%\') ';                      
                                queryString+='or (Order__r.BLN_TKT_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and Order__r.BLN_TKT_profile__r.Last_Name__c like \'%'+tokens[1]+'%\') '; 
                                }
                                else{
                                queryString+='and (tkt_profile__r.First_Name__c   like \'%'+searchKey+'%\' or tkt_profile__r.Last_Name__c  like \'%'+searchKey+'%\' ';
                                queryString+='or Order__r.BLN_TKT_profile__r.First_Name__c  like \'%'+searchKey+'%\' or Order__r.BLN_TKT_profile__r.Last_Name__c  like \'%'+searchKey+'%\' ';
                                }
                                    
                        //  string s=First_Name__c+''+Last_Name__c;
                        queryString += '  or tkt_profile__r.Email__c  like \'%'+searchKey+'%\' or tkt_profile__r.TKT_Company__c  like \'%'+searchKey+'%\' or tkt_profile__r.TKT_Job_Title__c  like \'%'+searchKey+'%\' or order__r.Name  like \'%'+searchKey+'%\' or tkt_profile__r.Mobile__c like \'%'+searchKey+'%\' or Tag_No__c like \'%'+searchKey+'%\' or Badge_ID__r.Print_status__c like \'%'+searchKey+'%\' or Custom_Barcode__c like \'%'+searchKey+'%\' or Name like \'%'+searchKey+'%\' ) ';  //append to base Query String  Badge_ID__r.Print_status__c
            
                } 
            
                /**Capture the values of Column Filters**/
                
                    String fil1 =    ApexPages.currentPage().getParameters().get('columns[6][search][value]');
                    String fil2 =    ApexPages.currentPage().getParameters().get('columns[7][search][value]');
                    String fil3 =    ApexPages.currentPage().getParameters().get('columns[8][search][value]');
                    String fil4 =    ApexPages.currentPage().getParameters().get('columns[12][search][value]');
                    String fil5 =    ApexPages.currentPage().getParameters().get('columns[13][search][value]');
                    String fil6 =    ApexPages.currentPage().getParameters().get('columns[15][search][value]');
                    
                    
                    if(fil1!=''){
               
                        String tok = fil1.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                    String tok3 = tok2.replace('\\','');
                    list<String> tok4 = tok3.split(';');
                    queryString += ' and (';
                    
                        for(integer i=1;i<tok4.size();i++){
                            string ttype=displaySettingsAttMap.get(tok4[i]); 
                            if(ttype=='Attendee')
                            ttype='Admissions';
                            
                            queryString += ' Item_Pool__r.item_type__r.name like \'%'+ttype+'%\' ';  //append to base Query  
                    queryString+=' or ';
                    }
                        string ttypeTemp=displaySettingsAttMap.get(tok4[tok4.size()-1]); 
                        if(ttypeTemp=='Attendee')
                        ttypeTemp='Admissions';
                            
                        queryString+=' Item_Pool__r.item_type__r.name like \'%'+ttypeTemp+'%\' )'; 
                    }
                    if(fil2!=''){
                
                    String tok = fil2.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                    String tok3 = tok2.replace('\\','');
                    list<String> tok4 = tok3.split(';');
                    queryString += ' and (';
                    
                        for(integer i=1;i<tok4.size();i++){
                    System.debug(']]]]]'+tok4.get(i));
                    
                    queryString += ' Item_Pool__r.Item_Pool_Name__c  like \'%'+tok4[i]+'%\' ';  //append to base Query
                    
                    queryString+=' or ';
                    }
                    queryString+='Item_Pool__r.Item_Pool_Name__c like \'%'+tok4[tok4.size()-1]+'%\' )';
                    
                    /*********/
                    }
                    if(fil3!=''){
                    /*******/
            
                    String tok = fil3.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                    String tok3 = tok2.replace('\\','');
                    list<String> tok4 = tok3.split(';');
                    queryString += ' and (';
                    
                        for(integer i=1;i<tok4.size();i++){
                    System.debug(']]]]]'+tok4.get(i));
                    
                    queryString += ' Badge_Label__c  like \'%'+tok4[i]+'%\' ';  //append to base Query
                    
                    queryString+=' or ';
                    }
                    queryString+='Badge_Label__c like \'%'+tok4[tok4.size()-1]+'%\' )';
                 
                    }
                    if(fil4!=''){
                    System.debug('$$$$$$$ : '+fil4);
                    
                    //    fil4= fil4.substring(2,fil4.length()-2);
                    //queryString += ' and (Tag_No__c  like \'%'+fil4+'%\' ) ';  //append to base Query 
                        /*******/
                    String tok = fil4.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                            tok2=tok2.replace('\\ ',' ');
                    //System.debug('{}{}{}{}: '+tok2);
                    list<String> tok3 = tok2.split(';');
                    //list<>            tok3 = tok3.replace('\\ ',' ');
                    queryString += ' and (';
                for(integer i=1;i<tok3.size();i++){
                    System.debug('$$$ ]]]]]'+tok3.size());
                    System.debug('$$$$ ]]]]'+tok3[i]);
                   // queryString += ' Badge_ID__r.Print_status__c   =:'+'+tok3[i];  
                    queryString += ' Badge_ID__r.Print_status__c   like \''+tok3[i]+'%\' ';  
                    //append to base Query
                    
                    queryString+=' or ';
                    }
                   // queryString+='Badge_ID__r.Print_status__c =:'+ tok3[tok3.size()-1]+ ')';
                    queryString+='Badge_ID__r.Print_status__c  like \''+tok3[tok3.size()-1]+'%\' )';
                    
                    /*********/
                    
                    }
                    /****insert field names if you want to use these filters***/
if(fil5!=''){
                        String tok = fil5.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                            tok2=tok2.replace('\\ ',' ');
                    list<String> tok3 = tok2.split(';');
                     queryString += ' and (Tstatus_Id__c!=null and (';
                    
                     for(integer i=1;i<tok3.size();i++){
                   
                   if(tok3[i]=='Checked In')
                   queryString += 'Tstatus_Id__r.Tstatus_name__c=true or '; 
                   else
                   queryString += 'Tstatus_Id__r.Tstatus_name__c=false or '; 
                    //append to base Query
                    
                    //queryString+=' or ';
                    }
                    if(tok3[tok3.size()-1]=='Checked In')
                    queryString+='  Tstatus_Id__r.Tstatus_name__c=true))';
                    else
                    queryString+='   Tstatus_Id__r.Tstatus_name__c=false))';
        
                    }
                    if(fil6!=''){
                        String tok = fil6.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                            tok2=tok2.replace('\\ ',' ');
                    list<String> tok3 = tok2.split(';');
                    List<String> ids=new List<String>();
                    List<String> poolids=new List<String>();
                     for(integer i=1;i<tok3.size();i++){
                   for(String key:tickettagsmap.keySet()){ 
                    if(tickettagsmap.get(key).contains(tok3[i]))
                    ids.add(key);
                    }
                    for(String key:tagsmap.keySet()){ 
                    if(tagsmap.get(key).contains(tok3[i]))
                    poolids.add(key);
                    }
                    }
                    
                    if(ids.size()>0&&poolids.size()>0)
                    queryString += ' and (id in:ids or item_pool__c in:poolids) ';
                    else if(ids.size()>0)
                     queryString += ' and id in:ids ';
                     else if(poolids.size()>0)
                     queryString += ' and item_pool__c in:poolids ';
        
                    }
                    
   

                
                List<String>ColName = New List<String>();
                            ColName.add('');//1 column
                            ColName.add('tkt_profile__r.First_Name__c');//2 column
                            ColName.add('tkt_profile__r.Email__c');//3 column
                            ColName.add('');
                            ColName.add('tkt_profile__r.TKT_Company__c');//4 column
                            ColName.add('tkt_profile__r.TKT_Job_Title__c');
                          ColName.add('');
                          ColName.add('');
                          ColName.add('');
                            ColName.add('Badge_Label__c');
                            ColName.add('');
                            ColName.add('Tag_No__c');//11 column
                            ColName.add('');//12
                            ColName.add('');//13
                            ColName.add('');//14
                            ColName.add('');//15
                            ColName.add('Order__r.createddate');//16
                            ColName.add('Order__r.Name');//17
                            ColName.add('Name');//18
                            
            
            
            
                    integer i = 0;
                    integer v ;
                    
                    String str;
            
                    String col = ApexPages.currentPage().getParameters().get('order[0][column]');//Column to which ordering should be applied 
                    System.debug('sorting order is  '+col);
                    String sortord = ApexPages.currentPage().getParameters().get('order[0][dir]');//Get The direction of Sorting ASC or DESC
                    
               
            /****check user sorting on any column on not *****/
            /****use First Column as default sorting column*****/
            
                    if(col!=null){
                        //System.debug('^^^^^^^ : '+col);
                        //We get column number as String convert it in to int and get element from Above ColName List With Index V
                        v=integer.valueof(col);
                
                        //str going to hold the filed name of the Sorting column
                    
                        str=ColName.get(v);
            
                        queryString += ' order by ' + str ;
                        }else{
                            str='Order__r.createddate';
                            //System.debug('^^^^^ : Not entered');
                            queryString += ' order by ' + str ;
                            }
            
            
                /*******Take Default Sorting Order as 'desc'***/
                        if(sortord==null){
                                sortord='desc';
                        }
            
            
            /****Append Sorting order to The Query String***/
                    
                    queryString+= ' '+sortord; 
    
    
            //final query
            System.debug('====>query '+queryString );
      
            //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);

            //intialize standard controller with query(use standard set controller to avoid offset issue)

            // setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            attendeesList=new list<ticket__c>();
            attendeesList =Database.query(queryString);
            setCon = new ApexPages.StandardSetController(attendeesList);
        Integer noOfRecords= setCon.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon.setPageSize(size);
            
        
            //set pagenumber
            setCon.setPageNumber((start/size)+1);
            System.debug((start/size)+1);
      
            //List<sobject> contactList = setCon.getRecords();
           List<Ticket__c> RecList = setCon.getRecords(); 
            
       List<SubWrapper> contactList1 = new List<SubWrapper>();
       
       // create a sub wrapper
       for(Ticket__c ac : RecList){
           String label='';
            label=ac.Item_Pool__r.Item_Type__r.Name;
       
            for(reg_setting__c rr : RegList){
                if(label=='Admissions' && rr.column_Name__c=='Attendee'){
                    label=rr.Label_Name__c;
                }
       
                if(label=='Exhibitor' && rr.column_Name__c=='Exhibitor'){
                    label=rr.Label_Name__c;
                }
       
                if(label=='Sponsor' && rr.column_Name__c=='Sponsor'){
                    label=rr.Label_Name__c;
       }
       
                if(label=='Speaker' && rr.column_Name__c=='Speaker'){
                    label=rr.Label_Name__c;
                }
            }
        Id val=ac.id;
         contactList1.add(new SubWrapper(ac, val,label));
       }
           
            //create wrapper
            
            DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,contactList1);
            dataTableJson = JSON.serialize(datawrap);
            //  System.debug(dataTableJson );
            
    
         
    }
/***********************sub wrapper****/
// inner class
public class SubWrapper{

  public Id DT_RowId{ get; set; }
  public Ticket__c item { get; set;}
  public String labelReName{get;set;}
   public String createdon{get;set;}

  public SubWrapper(Ticket__c item, Id counter,String labelReName1) {
    this.item = item;
    this.DT_RowId= counter;
     this.labelReName=labelReName1;
    try{
    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=item.Event__r.Time_Zone__c;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=item.Order__r.createddate;
    this.createdon=tz.getTimeZoneValue();}
    catch(Exception e){}
  }

}

    
    
    
        public class DataTableWrapper
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<SubWrapper> data;
            public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<SubWrapper> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data = data;
              
            }
         
        }
        
        
             

       /*****new method for select all****/
       
       public pageReference modifyids(String unckedlist){

            String tok1 = unckedlist.replace('\"','');
            String tok2 = tok1.replace(']','');
            String tok3 = tok2.replace('[','');
            System.debug('HIiiiiiiiiiiii '+unckedlist);
            list<String> tok4 = tok3.split(',');
                   
                    /***new logic*/
                    
                    
                    if(unckedlist.length()>2){
                    for(Integer k=0;k<tok4.size();k++){
                    for(Integer i=0;i<Allids.size();i++){
                    if(Allids[i]==tok4[k]){
                    Allids.remove(i);
                    }
                    }
                    
                    
                    }
                  
                    }
                    
                    
                    
                    
                    
                    
return null;
}
        
public void AllTktIds(){
         try{
          Alltkt=[Select id from Ticket__c where Event__c =:selectedEvent and Ticket_Status__c !='Abandoned' and Ticket_Status__c !='Cancelled' and Ticket_Status__c != 'Available' and Ticket_Status__c != 'Reserved' and Ticket_Status__c != 'Deleted' and (Item_Type__r.Badgable__c != 'N - No Badge' OR Item_Pool__r.Badgable__c != 'N - No Badge' ) ];
        
          for(Ticket__c t:Alltkt){
          //system.debug(t.id);
          Allids.add(t.id);
          }
          }catch(Exception e){}

}   

    public pageReference  userSelectAttendeesToExport(){
        pageReference pg = new PageReference ('/apex/BLN_AttendeesExport'); 
        pg.setRedirect(true); 
        System.debug('%%%%%'+apexpages.currentpage().getparameters().get('search'));
        pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
        pg.getParameters().put('arrVar',apexpages.currentpage().getparameters().get('arrVar'));
        pg.getParameters().put('ttypefilter',apexpages.currentpage().getparameters().get('ttypefilter'));
        pg.getParameters().put('tnamefilter',apexpages.currentpage().getparameters().get('tnamefilter'));
        pg.getParameters().put('blabelfilter',apexpages.currentpage().getparameters().get('blabelfilter'));
        pg.getParameters().put('bstatusfilter',apexpages.currentpage().getparameters().get('bstatusfilter'));
        pg.getParameters().put('cstatusfilter',apexpages.currentpage().getparameters().get('cstatusfilter'));
        pg.getParameters().put('allpages',apexpages.currentpage().getparameters().get('allpages'));
        
        return pg; 
    }
    
    public transient list<ticket__c> attendeeList{get;set;}
    public String SelectedIds{get;set;}
    public pageReference exportSelectedTicketBatch(){  
        string ststus3 = 'N - No Badge';
        string temp = ' where event__c = \''+SelectedEvent+'\' '+' and  Ticket_Status__c != \''+'Cancelled'+'\''+' and  Ticket_Status__c != \''+'Available'+'\''+' and  Ticket_Status__c != \''+'Reserved'+'\''+' and  Ticket_Status__c != \''+'Deleted'+'\''+' and  Ticket_Status__c != \''+'Abandoned'+'\'';
        //temp+=' and  (Item_Type__r.Badgable__c != \''+ststus3 +'\' OR Item_Pool__r.Badgable__c != \''+ststus3+'\')';//Commented for only badgable ticket
        temp+=' and   Item_Pool__r.Badgable__c != \''+ststus3+'\'';
        String queryString= 'Select Event__r.Time_Zone__c,Order__r.createddate,tkt_profile__r.TKT_Job_Title__c,Custom_Barcode__c, tkt_profile__r.TKT_Company__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.Item_Quantity__c,Order__r.BLN_TKT_profile__c,Order__r.BLN_TKT_profile__r.Email__c,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,LastModifiedDate,Owner.Name,Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,tkt_profile__r.BLN_Company__c,item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),order__r.Name,tkt_profile__r.BLN_Company__r.Name,Name,Item_Type__r.Name ,tkt_profile__c,tkt_profile__r.Mobile__c,tkt_profile__r.BLN_GN_User__r.First_Name__c,tkt_profile__r.BLN_GN_User__r.Last_Name__c,tkt_profile__r.Email__c,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name,tkt_profile__r.BLN_GN_User__r.User_Pic__c  From Ticket__c t '+ temp;
        String allpagesprint = queryString;
        
        
        String searchKey = ApexPages.currentPage().getParameters().get('search');
        System.debug('!!!!!! Serach key is222 '+searchKey);
        //check the search box value
        
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
        System.debug('!!!!!! Serach key is '+searchKey);
        //System.debug(searchKey.split(' '));
        
        String[] tokens = searchKey.split(' ');
        
        if(tokens.size()==2){
            queryString+='and ((tkt_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and tkt_profile__r.Last_Name__c  like \'%'+tokens[1]+'%\') ';                      
            queryString+='or (Order__r.BLN_TKT_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and Order__r.BLN_TKT_profile__r.Last_Name__c like \'%'+tokens[1]+'%\') '; 
        }
        else{
            queryString+='and (tkt_profile__r.First_Name__c   like \'%'+searchKey+'%\' or tkt_profile__r.Last_Name__c  like \'%'+searchKey+'%\' ';
            queryString+='or Order__r.BLN_TKT_profile__r.First_Name__c  like \'%'+searchKey+'%\' or Order__r.BLN_TKT_profile__r.Last_Name__c  like \'%'+searchKey+'%\' ';
        }
        
        //  string s=First_Name__c+''+Last_Name__c;
        queryString += '  or tkt_profile__r.Email__c  like \'%'+searchKey+'%\' or tkt_profile__r.TKT_Company__c  like \'%'+searchKey+'%\' or tkt_profile__r.TKT_Job_Title__c  like \'%'+searchKey+'%\' or order__r.Name  like \'%'+searchKey+'%\' or tkt_profile__r.Mobile__c like \'%'+searchKey+'%\' or Tag_No__c like \'%'+searchKey+'%\' or Badge_ID__r.Print_status__c like \'%'+searchKey+'%\' or Name like \'%'+searchKey+'%\') ';  //append to base Query String  Badge_ID__r.Print_status__c

        }
       
        String selIds= ApexPages.currentPage().getParameters().get('arrVar');
        
        String allpagesvalue= ApexPages.currentPage().getParameters().get('allpages');
        system.debug('arrrr::'+selIds);
       
        if(selIds!=null && selIds!= ''){
        List<String> allIds = selIds.split(','); 
        checkid=new set<id>();
        
        for(integer i=0;i<allIds.size();i++){
            checkid.add(allIds[i]);    
        }
        system.debug('----Check Id ---Size-- '+checkid.size());
        
        
        
        }
        
        //All filters data
        String filter1= ApexPages.currentPage().getParameters().get('ttypefilter');
        if(filter1!=null && filter1!=''){
            queryString += ' and ('; 
                    
            List<String> fltrlist1= filter1.split(','); 
            for(integer i=0;i<fltrlist1.size();i++){
                string ttype=displaySettingsAttMap.get(fltrlist1[i]); 
                if(ttype=='Attendee')
                ttype='Admissions';
                
                queryString += ' Item_Pool__r.item_type__r.name like \'%'+ttype+'%\' ';
                queryString+=' or ';          
            }
            string ttypeTemp=displaySettingsAttMap.get(fltrlist1[fltrlist1.size()-1]); 
            if(ttypeTemp=='Attendee')
            ttypeTemp='Admissions';
                
            queryString+=' Item_Pool__r.item_type__r.name like \'%'+ttypeTemp+'%\' )';
        }
        
        String filter2= ApexPages.currentPage().getParameters().get('tnamefilter');
        if(filter2!=null && filter2!=''){
            queryString += ' and ('; 
                    
            List<String> fltrlist2= filter2.split(','); 
            for(integer i=0;i<fltrlist2.size();i++){ 
                queryString += ' Item_Pool__r.Item_Pool_Name__c like \'%'+fltrlist2[i]+'%\' ';
                queryString+=' or ';          
            } 
            queryString+=' Item_Pool__r.Item_Pool_Name__c like \'%'+fltrlist2[fltrlist2.size()-1]+'%\' )';
        }
        
        String filter3= ApexPages.currentPage().getParameters().get('blabelfilter');
        if(filter3!=null && filter3!=''){
            queryString += ' and ('; 
                    
            List<String> fltrlist3= filter3.split(','); 
            for(integer i=0;i<fltrlist3.size();i++){ 
                queryString += ' Badge_Label__c like \'%'+fltrlist3[i]+'%\' ';
                queryString+=' or ';          
            } 
            queryString+=' Badge_Label__c like \'%'+fltrlist3[fltrlist3.size()-1]+'%\' )';
        }
        
        String filter4= ApexPages.currentPage().getParameters().get('bstatusfilter');
        if(filter4!=null && filter4!=''){
            queryString += ' and ('; 
                    
            List<String> fltrlist4= filter4.split(','); 
            for(integer i=0;i<fltrlist4.size();i++){ 
                queryString += ' Badge_ID__r.Print_status__c like \'%'+fltrlist4[i]+'%\' ';
                queryString+=' or ';          
            } 
            queryString+=' Badge_ID__r.Print_status__c like \'%'+fltrlist4[fltrlist4.size()-1]+'%\' )';
        }
        
        String filter5= ApexPages.currentPage().getParameters().get('cstatusfilter');
        if(filter5!=null && filter5!=''){
            queryString += ' and ('; 
                    
            List<String> fltrlist5= filter5.split(','); 
            for(integer i=0;i<fltrlist5.size();i++){ 
                    if(fltrlist5[i]=='Checked In')
                    queryString += ' Tstatus_Id__r.Tstatus_name__c=true or '; 
                   else
                   queryString += ' Tstatus_Id__r.Tstatus_name__c=false or ';         
            } 
                    if(fltrlist5[fltrlist5.size()-1]=='Checked In')
                    queryString+='  Tstatus_Id__r.Tstatus_name__c=true)';
                    else
                    queryString+='   Tstatus_Id__r.Tstatus_name__c=false)';
        }
        
        /* Query string for Batch Method */
        string batchquerystring = queryString;
        
        system.debug('--Query String to batch----without id in :----checkId-- '+batchquerystring);
        system.debug('----checkid----Size--- '+checkid.size());
            if(checkid.isEmpty()==false){
            queryString += '  and id in : checkid';  

            }
        
        attendeeList=new list<ticket__c>(); 

        
        /* If Only Selected a few records And Total Export CheckBox(allpagesvalue) is false */
        if(allpagesvalue != 'true' && checkid.size()>0 ){
         /* Normal Export */
        attendeeList=database.query(queryString );
        /* If Selected records Are More than 1000 */
                if(attendeeList.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportAttendeesBatch (batchquerystring,RegList,tagsmap,tickettagsmap,checkid), 1000);
            
            
        }
        
       return null;
        }
            else if(allpagesvalue == 'true'){
            system.debug('---batchquerystring----Within the allapges true--- '+batchquerystring);
            system.debug('--allpagesvalue---@nil--- '+allpagesvalue);
                /* Normal Export */
                attendeeList=database.query(batchquerystring);
       
                /* Undergoes Bulk Export */
                if(attendeeList.size()>1000){ //allpagesprint  batchquerystring  
                    Id batchInstanceId = Database.executeBatch(new BLN_ExportAttendeesBatch (batchquerystring,RegList,tagsmap,tickettagsmap), 1000);
        }
system.debug('-----attendeeList----In Bulk---'+attendeeList.size());

        
               return null;
                
        }
        else {
            return null;
        } 
    }
}
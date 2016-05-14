public without sharing class BLN_EventstaffCon {

    
    public BLN_UtillDisplayLinks Eventstaff{get;set;}
     Public string selectedeventid{get;set;} 
    Public BLN_Event__c eventslist {get;set;}
    public boolean Displaystaff {get ; set ;}
    public boolean Addstaffbool {get ; set ;}
    public User Us {get ; set ;}
    public Company__c Companyrec {get ; set ;}
    public String selectedRole {get ; set ;}
    public String selectedItem {get ; set ;}
    public LIST<UC_Role__c> StaffToDisp {get ; set ;}
    public LIST<selectoption> roles {get ; set ;}
    public boolean foradd {get ; set ;}
    public boolean foredit {get ; set ;}
    public LIST<selectOption> availabletics {get ; set ;}
    
    
    
     public void displayPermissions(){

     Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){
     selectedeventid = k.getValue();
     }
   
     try{
     eventslist  = geteventdetails();
     }catch(exception e){}
   
    SYSTEM.DEBUG('EVENTID:' + selectedeventid );
         
         Eventstaff = new BLN_UtillDisplayLinks();
         Eventstaff .isEventstaffPage ='active';
         Eventstaff .isEventsettingsExpand ='expand';
         Eventstaff .tablabel='Event Staff';
         try{
         Eventstaff .eventName = eventslist.Name;
         }catch(exception e){}
         Eventstaff .EventId= selectedeventid;
         Eventstaff .userPermissions(userInfo.getUserId(),selectedeventid);
            // selectedeventid = 'a0sc0000001p8Xp' ;
    }
    
    //------CONSTRUCTOR--------
    public BLN_EventstaffCon(){
        availabletics = new LIST<selectOption> ();
        StaffToDisp  = new LIST<UC_Role__c> ();
        Displaystaff = TRUE;
        Addstaffbool =FALSE;
       
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
          if(k!=null){
          selectedeventid = k.getValue();
          }
    try{
     eventslist  = geteventdetails();
     }catch(exception e){}
     
        displayPermissions();
         
         selectedrole = '';
         roles = new LIST<selectoption> ();
         roles.add(new selectoption('Full Admin','Full Admin'));
         roles.add(new selectoption('Registration User','Registration User'));
         roles.add(new selectoption('Onsite Staff','Onsite Staff'));
         geteventstaff();
         
    }
    public void geteventstaff(){
     
     //Eventstaff = new BLN_UtillDisplayLinks();
     Addstaffbool = FALSE;
     Displaystaff = TRUE;
    Eventstaff.EventId= selectedeventid;
         Eventstaff.userPermissions(userInfo.getUserId(),selectedeventid);
        
          BLN_CreateEventstaff_BAL getstaff = new BLN_CreateEventstaff_BAL ();
          StaffToDisp = getstaff.eventstaff(selectedeventid);
          system.debug(StaffToDisp.size()+' STAFF TO DISPLAY '+StaffToDisp);
    }
    Public BLN_Event__c geteventdetails(){
         BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
         RETURN eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }
     //To Open new div which askes to fill staff details
     public LIST<BLN_Item__c> itemList {get ; set ;}
     public LIST<selectoption> Itemsoptions {get ; set ;}
     Public void AddStaff(){
         foradd = TRUE;
         Itemsoptions = new LIST<selectoption> ();
         BLN_Item_DAO itendao = new BLN_Item_DAO();
         LIST<BLN_Item__c> Items = itendao.getEventItems(selectedeventid);
         for(BLN_Item__c Item: Items ){
        if(Item.Item_Type__r.Name == 'Admissions' ){
         
         Itemsoptions.add(new selectoption(Item.id,Item.item_name__c));
         }
         }
         
         
         Displaystaff = FALSE;
         Addstaffbool = TRUE;
         Us = new User ();
         companyrec = new Company__c ();
     }
      //For saving the staff into User
     public void saveStaff(){
         //selecteditem='a1Dc0000001it87';
         list<BLN_Item__c> selectedItemList =  new LIST<BLN_Item__c> ();
         system.debug('  SELECTED ITEM '+selecteditem);
         BLN_Item__c selecteditems = [SELECT id,event__c,item_name__c  from BLN_Item__c WHERE id =: selecteditem];
         selectedItemList.add(selecteditems);
         system.debug('  BEFORE '+Companyrec.Name);
         if(Companyrec.Name == NULL || Companyrec.Name == ''){
             Companyrec.Name= Us.FirstName+Us.LastName;
         }
         system.debug('  AFTER '+Companyrec.Name);
         BLN_CreateEventstaff_BAL Createstaff = new BLN_CreateEventstaff_BAL ();
         User Unew = Createstaff.creatingUser(Us,companyrec);
         String GNID = Createstaff.creategnuser(Unew);
         
         Company__c Companyrecnew = Createstaff.companyinsert(companyrec);    
         system.debug('ggggggggggggggggggggggggggggggggggggggggggggggggggggg'+Companyrecnew.id);
         
         UC_Role__c UCRolerec = Createstaff.UcerRole(Unew,GNID ,selectedRole,Companyrecnew,selectedeventid);
          system.debug('UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'+UCRolerec);
          BLN_Quick_Registration_BAL ticketsavailability = new BLN_Quick_Registration_BAL ();
          availabletics = ticketsavailability.getAvailableTickets(selectedItemList);
          
          List<string> ticids= new List<string> ();
          ticids.add(availabletics[1].getValue());
          system.debug('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT'+availabletics.size() +'ssssssssss'+availabletics);
         //(String userid,String comId,List<String> ticketIds,String eventId,Integer totamount)
        // BLN_StatusMessage  statusmessages = ticketsavailability.updateTicket(Unew.id,Companyrecnew.id,ticids,selectedeventid,0);
         
         
          geteventstaff();
          
     }
     
   public void cancel(){
       Displaystaff = TRUE;
       Addstaffbool = FALSE;
   }
   public void editstaff(){
   ID UCID = ApexPages.Currentpage().getparameters().get('UCID');
   //ID UCID1=UCID(ID);
   BLN_CreateEventstaff_BAL editstaff = new BLN_CreateEventstaff_BAL ();
   UC_Role__c UCREC = editstaff.editUC(UCID);
   selectedRole = UCREC.RoleId__r.Name;
   system.debug('jjjjjjjjjjjjjjjjjjjjjjjjjjj'+selectedRole );
   US=editstaff.editUser(UCREC.GN_User__r.User__c);
   companyrec = editstaff.editcomp(UCREC.Company__c);
    Displaystaff = FALSE;
         Addstaffbool = TRUE;
         foradd = FALSE;
         foredit = TRUE;
         
   }
}
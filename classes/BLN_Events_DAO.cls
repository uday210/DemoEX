public with sharing class BLN_Events_DAO {
    
    
    //Getting EventDetails By Id
    public BLN_Event__c getEventDetails(String eventId){
        BLN_Event__c eventdetails= [SELECT BLN_Country__r.Currency__r.Name,Event_Ticket_Options__c,is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Service_Fee__c,Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c, 
                                        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  Registration_Template__c,
                                         Description__c,Country__c, City__c ,CreatedBy.Name ,BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,
                                        BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,Show_Terms_Checkbox__c,
                                        Tax_Rate__c,Accept_Tax_Rate__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,owner.userName 
                                    FROM BLN_Event__c 
                                    WHERE ID =: eventId];
        return eventdetails;
    }
    
     public list<BLN_Event__c> getBuyerEventDetails(LIST<id> ids){
     
       list<BLN_Event__c> eventdetailslist = new  list<BLN_Event__c>();
         eventdetailslist = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                         Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                         Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                   FROM BLN_Event__c WHERE id IN : ids And Event_Status__c != 'Deleted' ];
        return eventdetailslist;
    }
    
    
    public LIST<Database.UpsertResult> createEvent(LIST<BLN_Event__c> events){
        
          
        LIST<Database.UpsertResult> dbr = DataBase.upsert(events , false);
        
        system.debug('EVENTS CREATIONNNNNNNNNNnnnnnnn  111111111111111  '+ dbr);
        
        
        return dbr;
        
    }
    public list<BLN_Event__c> gettingAllEvents(id uid){
    /*system.debug('-------------dao2222222222'+uid);
    list<UC_Role__c> ucroles = [select id,Event__c,Company__c,Company__r.name,RoleId__c from UC_Role__c
                                        WHERE GN_User__r.User__c =: uid];
      system.debug('-------------dao2222222222'+ucroles);                                   
    list<id> eveids = new list<id> ();
    
     for(UC_Role__c USR : UCRoles){
        eveids.add(USR.Company__c);
        
        }
        
      list<BLN_Event__c> events = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById,LastModifiedDate, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  
                                         Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,organizer_id__r.owner.id 
                                   FROM BLN_Event__c 
                                   WHERE organizer_id__r.id IN: eveids and Event_Status__c!='Deleted'];
       system.debug('-------------dao2222222222'+events);*/
       User u=[select id,name,username from user where id=:uid];
        list<BLN_Event__c> events = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById,LastModifiedDate, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  
                                         Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,organizer_id__r.owner.id 
                                   FROM BLN_Event__c 
                                   WHERE (OwnerId=:uid or Organizer_Email__c=:u.username) and Event_Status__c!='Deleted'];
     
       
     
       
       
    return events ;
    }
    
   public list<BLN_Event__c> listofUserEvents(id uid, string eventname,string eventlocation,string srtdate, string enddate){ 
    
    System.debug('uuuuu:'+uid);
    System.debug('eeeeee:'+eventname);
    System.debug('lllllll:'+eventlocation); 
     System.debug('sssssddd:'+srtdate);
    System.debug('eeedddd:'+enddate);
    string evnt = '%'+eventname+'%';
    string local = '%'+eventlocation+'%';
     
    BLN_timeConToEvzoneCon t1=new BLN_timeConToEvzoneCon();
    
    list<BLN_Event__c> events=new list<BLN_Event__c>();    
    try{
    User u=[select id,name,username from user where id=:uid];
 
        date fdt;  
    if(srtdate!=null&&srtdate!=''&&srtdate!='Start Date'){ 
            fdt=date.parse(srtdate);
        System.debug('DDD111:'+fdt);
    }
    
        date ldt;
    if(enddate!=null&&enddate!=''&&enddate!='End Date'){
            ldt=date.parse(enddate);
            System.debug('DDD2222:'+ldt);
    } 
    
    if(srtdate!=null && srtdate!='' && srtdate!='Start Date' && enddate!=null && enddate!='' && enddate!='End Date'){
          events = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById,LastModifiedDate, IsDeleted, Id, 
        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  
        Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,organizer_id__r.owner.id 
        FROM BLN_Event__c 
        WHERE  (OwnerId=:uid or Organizer_Email__c=:u.username) and Event_Status__c!='Deleted' and (name like: evnt AND Venue_Name__c like: local AND DAY_ONLY(start_date__c) >= : fdt AND DAY_ONLY(end_date__c) <= : ldt) ];
     
    }else if(srtdate!=null && srtdate!='' && srtdate!='Start Date' && (enddate==null || enddate=='' || enddate=='End Date')){
          events = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById,LastModifiedDate, IsDeleted, Id, 
        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  
        Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,organizer_id__r.owner.id 
        FROM BLN_Event__c 
        WHERE  (OwnerId=:uid or Organizer_Email__c=:u.username) and Event_Status__c!='Deleted' and (name like: evnt AND Venue_Name__c like: local AND DAY_ONLY(start_date__c) >= : fdt) ];
     
    }else if((srtdate==null || srtdate=='' || srtdate=='Start Date') && enddate!=null && enddate!='' && enddate!='End Date'){
          events = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById,LastModifiedDate, IsDeleted, Id, 
        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  
        Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,organizer_id__r.owner.id 
        FROM BLN_Event__c 
        WHERE  (OwnerId=:uid or Organizer_Email__c=:u.username) and Event_Status__c!='Deleted' and (name like: evnt AND Venue_Name__c like: local AND DAY_ONLY(end_date__c) <= : ldt) ];
     
    }else if((srtdate==null || srtdate=='' || srtdate=='Start Date') && (enddate==null || enddate=='' || enddate=='End Date')){
          events = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
        Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById,LastModifiedDate, IsDeleted, Id, 
        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c,  
        Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,organizer_id__r.owner.id 
        FROM BLN_Event__c 
        WHERE  (OwnerId=:uid or Organizer_Email__c=:u.username) and Event_Status__c!='Deleted' and (name like: evnt AND Venue_Name__c like: local ) ];
     
    }
       
     }catch(exception e){}  
     return events ;
    
    }
    
    
    public list<UC_Role__c> TogetRoleofanEvent(id UID){
    list<UC_Role__c> ucroles = [select id,Event__r.id,Company__c,Company__r.name,RoleId__r.Name,RoleId__c,GN_User__r.Email__c from UC_Role__c
                                        WHERE GN_User__r.User__c =: uid];
      system.debug('-------------dao2222222222'+ucroles); 
      return ucroles ;
    
    }
    
   public LIST<Database.UpsertResult> updateBadge(String EventID,String badgename){
        
        List<BLN_BadgeTemplate_Styles__c> bstyle=new List<BLN_BadgeTemplate_Styles__c>();
        
        bstyle=[select id,name,Mobile_Default_Badge__c,BadgeName__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BLN_BadgeTemplate_Styles__c where Badge_Type__c='Brother' and Event__c=:EventID and Module__c like '%Scan Attendee%' ];
        
        for(integer i=0;i<bstyle.size();i++)
        {
           if(bstyle[i].name==badgename)
           bstyle[i].Mobile_Default_Badge__c=true;
           else
           bstyle[i].Mobile_Default_Badge__c=false;
        }
       
       LIST<Database.UpsertResult> dbr = DataBase.upsert(bstyle, false);
       return dbr;
        
        
    } 
    

    /***********new method for mobile default badge selection********/


           public LIST<Database.UpsertResult> updateBadgeNew(String EventID,String badgeid){
        
        List<BLN_Badge_Style__c> bstyle=new List<BLN_Badge_Style__c>();
        
        bstyle=[select id,name,Mobile_Default_Badge__c from BLN_Badge_Style__c where Printer__c='Brother' and Event__c=:EventID and Module__c like '%Scan Attendee%' ];
        
        for(integer i=0;i<bstyle.size();i++)
        {
           if(bstyle[i].id==badgeid)
           bstyle[i].Mobile_Default_Badge__c=true;
           else
           bstyle[i].Mobile_Default_Badge__c=false;
        }
       
       LIST<Database.UpsertResult> dbr = DataBase.upsert(bstyle, false);
       return dbr;
        
        
    } 
    
    public LIST<Database.UpsertResult> updateSalesTax(String EventID,Decimal taxrate,Boolean isTaxApplicable){
        
        List<BLN_Event__c> eve=new List<BLN_Event__c>();
        
        eve=[select id,name,Tax_Rate__c from BLN_Event__c where id=:EventID];
        
        for(integer i=0;i<eve.size();i++)
        {
           eve[i].Tax_Rate__c=taxrate;
           eve[i].Accept_Tax_Rate__c=isTaxApplicable;

        }
       
       LIST<Database.UpsertResult> dbr = DataBase.upsert(eve, false);
       return dbr;
        
        
    } 
    
    
    
     public boolean updatepgemail(String EventID,String pgemailid){
        BLN_Event__c eve=[select id,name,organizer_id__c,Tax_Rate__c from BLN_Event__c where id=:EventID];
        PGateway_Type__c pgt;
        Pay_Gateway__c pg=new Pay_Gateway__c();
       Event_Pay_Gateway__c epg=new Event_Pay_Gateway__c();
       pgt=[select id,name from PGateway_Type__c where name='PayPal'];
       pg.PGateway_Type__c=pgt.id;
       pg.PG_Email_Id__c=pgemailid;
       pg.PP_Payment_Type__c='Chained';
       pg.PP_Fee_Payer__c='EACHRECEIVER';
       pg.Company__c=eve.organizer_id__c ;
       insert pg;
      try{
      //if try to add pgemail again from service
      Event_Pay_Gateway__c depg=[select Pay_Gateway__c,Events__c,Pay_Gateway__r.PGateway_Type__r.Name from Event_Pay_Gateway__c where Events__c=:EventID and Pay_Gateway__r.PGateway_Type__r.Name='PayPal'];
      delete depg;
      }catch(Exception e)
      {}
      epg.Pay_Gateway__c=pg.id;
      epg.Events__c=eventID;
      insert epg;
      return true;
        
    }
   public BLN_Event__c getEventtimezone(String eventId){
    BLN_Event__c eve=[select id,name,Time_Zone__c  from BLN_Event__c where id=:EventId];
    return eve;
    }

}
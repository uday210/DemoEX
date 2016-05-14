global class BLN_EventSuccesscon{

public BLN_UtillDisplayLinks myticket{get;set;}
    
    public string selectedEventId{get;set;}   
    public BLN_Event__c se{get;set;}  
    public GN_User__c gnuserinfo{get;set;}
    public string LoginUserId{get;set;} 
    public string fullUrl{get;set;}     
    public string eventid{get;set;}
    public string SelectedEvent {get;set;}
    public boolean IsLeadTabAvailable {get ; set ;}
    public String RegistrationLink{get;set;} // To Display Registration Link
    public boolean shortUrlPannelBooledit{get;set;}
    public boolean shortUrlPannelBoolshow{get;set;}
    public string shorturlkey{get;set;}
    public BLN_EventSuccesscon(){
    try{
   
      fullUrl =  Site.getBaseUrl();
        // Clear cookie on pageload
       eventid =  ApexPages.currentPage().getParameters().get('id');
        RegistrationLink =Site.getBaseUrl()+ '/BLN_Registration_Eventdex?id='+eventid;
        system.debug('eventid======================================='+eventid);
           Cookie counter = ApexPages.currentPage().getCookies().get('counter');
            if (counter == null) {
               counter = new Cookie('counter', '',null,-1,false);
             }
            else{
               counter = new Cookie('counter','',null,-1,false);
               system.debug('@@@@@@@@@@@@@@@@@@ ');
            }
         ApexPages.currentPage().setCookies(new Cookie[]{counter});    
        
    }catch(Exception e){}
    
        try{
        LoginUserId = Userinfo.getUserId();
        system.debug('@@@LoginUserId'+[select First_Name__c, Last_Name__c from GN_User__c WHERE User__r.id=: LoginUserId]);
       gnuserinfo= [select First_Name__c, Last_Name__c from GN_User__c WHERE User__r.id=: LoginUserId];
       }catch(exception ex){}
       
        se = new BLN_Event__c();
        se = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                         Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                         Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                   FROM BLN_Event__c WHERE id =: eventid ];
      try{
        BLN_Reg_Settings_DAO regstdao = new BLN_Reg_Settings_DAO();
        Reg_Setting__c reglinksettings = new Reg_Setting__c();
        reglinksettings = regstdao.getrestrationlinksettings(eventid);
        if(reglinksettings !=null){
         //system.debug('##############'+String.isEmpty(reglinksettings.Table_Name__c));
            if(String.isEmpty(reglinksettings.Label_Name__c)){
              shortUrlPannelBooledit= true;
              shortUrlPannelBoolshow =false;
           //   system.debug('##############'+shortUrlPannelBooledit);
             }else{
              shortUrlPannelBooledit= false;
              shortUrlPannelBoolshow  = true;
              //shorurl = 'http://eventdex.com/'+se.urlshortkey__c;
              shorurl = 'http://www.eventdex.com/'+reglinksettings.Label_Name__c;
              shorturlkey = reglinksettings.Label_Name__c;
             } 
             } 
             }catch(Exception e){}                             
       
    }
    
  public BLN_Ticket_DAO ticDAO{get;set;}
  
public pagereference manageEvent(){
        SelectedEvent = ApexPages.CurrentPage().getParameters().get('id');
            system.debug('  EVNT NAME  '+SelectedEvent );
            Cookie counter = ApexPages.currentPage().getCookies().get('counter');
            if (counter == null) {
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
            else{
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
    
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            Pagereference Pg;
            BLN_Event__c eve=[select id,name,Organizer_Email__c,owner.email from BLN_Event__c where id=:SelectedEvent];
            
            ticDAO= new BLN_Ticket_DAO();
                LIST<ticket__c> ticTemp=new list<ticket__c>(); 
                string s1='Lead Retrieval';
                string temp=' WHERE event__r.id = \''+SelectedEvent+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\''+' AND tkt_profile__r.bln_gn_user__r.User__c = '+'\''+LoginUserId+'\'';
                ticTemp = ticDAO.userOrderAndTickets(temp);
                if(ticTemp.size()>0){
                    IsLeadTabAvailable = true;
                }
            
            if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.owner.email==UserInfo.getuserid()){
         Pg = new Pagereference('/apex/BLN_Dashboard'); 
         } else if(IsLeadTabAvailable == true){
         Pg = new Pagereference('/apex/BLN_Dashboard'); 
         } else{
         Pg = new Pagereference('/apex/BLN_Mytickets');                
         }              
         return Pg ;
    
    }
    
          
public string shorurl{get;set;}
//public string fldrname{get;set;}
          
@RemoteAction
public static boolean getshorturl(string fldrname,id selectedEvent,string RegistrationLink ){
date evstartdt;
date evenddt;
string shorurl;
string event_name;
//string fldrname = Apexpages.currentPage().getParameters().get('urlkey');
 //system.debug('$$$$$$$$$$$$$$$$$'+fldrname);
 webservicetesthittophpfoldercheck foldcheck =new webservicetesthittophpfoldercheck();
 boolean fldcheckbool = Boolean.valueOf(foldcheck.webhitfoldercheck(fldrname));
 // 
 if(fldcheckbool == false){
//evstartdt = Date.today();
//evenddt = evstartdt.addDays(10);
 BLN_PromoCode_BAL blneventdetail_bal = New BLN_PromoCode_BAL();
BLN_Event__c  evedet = new BLN_Event__c  ();
        try{
            evedet = blneventdetail_bal.eventdetails(selectedEvent);
            
        }catch(exception e){}
   evstartdt = date.valueof(evedet.End_Date__c);
   evenddt = date.valueof(evedet.Start_Date__c);
   evenddt = evenddt.addDays(1);
  event_name = evedet.Name;
webservicetesthittophp wstest = new webservicetesthittophp();
    if(!String.isEmpty(RegistrationLink) && !String.isEmpty(fldrname) && (evstartdt != null) && (evenddt !=null)){
          system.debug('$$$$$$$$$$$$$$$$$$$$$'+selectedEvent);
        shorurl = wstest.webhitphp(RegistrationLink,fldrname,event_name,evstartdt,evenddt,selectedEvent);
       
       if(shorurl  != null){
        BLN_Reg_Settings_DAO regstdaoupd = new BLN_Reg_Settings_DAO();
        Reg_Setting__c reglinksettingsupd = new Reg_Setting__c();
        
        reglinksettingsupd = regstdaoupd.getrestrationlinksettings(selectedEvent);
        if(reglinksettingsupd !=null){
      reglinksettingsupd.Label_Name__c = fldrname;
       update reglinksettingsupd;
       }
      // shortUrlPannelBooledit= false;
      // shortUrlPannelBoolshow  = true;
       
    }
    
    }
   /* string redirecturl = ApexPages.currentPage().getHeaders().get('Referer');
     system.debug('$$$$$$$$$$$$$$$$$$'+redirecturl);
     PageReference pageRef = new PageReference(redirecturl);
        pageRef.setRedirect(true);
        return pageRef;*/
       // return fldcheckbool;
        }else if(fldcheckbool == true){
        
         //return fldcheckbool;
        }
        return fldcheckbool;
 }
 public void editshorturl(){
system.debug('%%%%%%%%%%%%%%%%%%%%');
shortUrlPannelBooledit= true;
shortUrlPannelBoolshow  = false;
}
}
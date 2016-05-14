global with sharing class BLN_RegistrationLinks {
/***************************************************************************************************************************************************************************************************
*   Author                  : Mahesh Sakunala
*   Date                    : 10/07/2014 
*   Purpose                 : This class is for Registration Links.
*   Last Modified           : Mahesh Sakunala - 16/07/2014
*****************************************************************************************************************************************************************************************************/

    public BLN_UtillDisplayLinks RegistrationLinks{get;set;} // For Util Class
    public Id selectedEvent{get;set;} // To Fetch Event Id
    public String RegistrationLink{get;set;} // To Display Registration Link
    public BLN_Event__c EventDetails{get; set;} // To fetch event details
    public string iframes{get;set;}
    public string priviframes{get;set;}
    public string alliframes{get;set;}
    public List<String> reg{get;set;}
    public Boolean publictickets{get;set;}
    public Boolean privatetickets{get;set;}
    public Boolean alltickets{get;set;}
    public map<string,string> frame{get;set;}
    public map<string,string> privframe{get;set;}
    public map<string,string> allframe{get;set;}
    public boolean shortUrlPannelBooledit{get;set;}
    public boolean shortUrlPannelBoolshow{get;set;}
    public string shorturlkey{get;set;}
// ----------------------------------------------------------------------------------- Constructor Start ---------------------------------------------------------------------------------------------------    
   public static boolean isTest =false;
   
    public BLN_RegistrationLinks(){
        try{
         Cookie k ;
        if(!isTest){ 
         k = ApexPages.currentPage().getCookies().get('counter');
                 if(k!=null){ 
             selectedEvent = k.getValue();
             system.debug('  SELECTED EVENT  '+selectedEvent );
         }
       } else{
         selectedEvent  =ApexPages.currentPage().getParameters().get('id'); 
       }
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        BLN_Event__c  se = new BLN_Event__c  ();
        try{
            se = blneventdetailbal.eventdetails(selectedEvent);
        }catch(exception e){}
        try{
        BLN_Reg_Settings_DAO regstdao = new BLN_Reg_Settings_DAO();
        Reg_Setting__c reglinksettings = new Reg_Setting__c();
        reglinksettings = regstdao.getrestrationlinksettings(selectedEvent);
        if(reglinksettings !=null){
         //system.debug('##############'+String.isEmpty(reglinksettings.Label_Name__c));
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
         //system.debug('##############@@@@');
         RegistrationLinks = new BLN_UtillDisplayLinks();
         RegistrationLinks.isregistrationPage='active';
         RegistrationLinks.isregistrationPageExpand='expand';
         RegistrationLinks.tablabel='Registration Links';
         RegistrationLinks.eventId=selectedEvent;
         RegistrationLinks.eventName=se.Name;
         RegistrationLinks.userPermissions(userInfo.getUserId(),selectedEvent);
         
         
         frame = new map<string,string>();
         privframe = new map<string,string>();
         allframe = new map<string,string>();
         BLN_Quick_Registration_BAL QuickRegBAL = new BLN_Quick_Registration_BAL();
         if(selectedEvent != NULL){
             // Getting Event Details from Event DAO
            EventDetails = QuickRegBAL.getEventDetails(selectedEvent);  
             system.debug('  1111111111111111  '+selectedEvent );
            RegistrationLink =Site.getBaseUrl()+ '/BLN_Registration_Eventdex?id='+selectedEvent;
            String onlyticketlink=Site.getBaseUrl()+ '/BLN_Registration_OnlyTickets?id='+selectedEvent;
            iframes = ' <iframe width="560" height="315"  src="'+onlyticketlink+'"></iframe>';
            priviframes = ' <iframe width="560" height="315"  src="'+onlyticketlink+'&Visib=Private"></iframe>';
            alliframes = ' <iframe width="560" height="315"  src="'+onlyticketlink+'&Visib=Public~Private"></iframe>';
         }
          reg=new List<String>();
         for(AggregateResult ar: [SELECT Table_Name__c,Included__c FROM Reg_Setting__c WHERE Setting_Type__c=:'Registration Tab' and Included__c=true AND  Event__c =: selectedEvent group by Table_Name__c,Included__c]){
   
   reg.add((String)ar.get('Table_Name__c'));
   }
        
        String onlyticketlink=Site.getBaseUrl()+ '/BLN_Registration_OnlyTickets?id='+selectedEvent;       
        for(String re:reg){
              
              frame.put(re,' <iframe width="560" height="315"  src="'+onlyticketlink+'&tab='+re+'"></iframe>');
              privframe.put(re,' <iframe width="560" height="315"  src="'+onlyticketlink+'&tab='+re+'&Visib=Private"></iframe>');
              allframe.put(re,' <iframe width="560" height="315"  src="'+onlyticketlink+'&tab='+re+'&Visib=Public~Private"></iframe>');
              
          }
       

       List<BLN_Item__c> blepub=[select id,name,Event__c,Visibility__c from BLN_Item__c where Visibility__c='Public' and Event__c=: selectedEvent];
       if(blepub.size()>0)
       publictickets=true;
       else
       publictickets=false;
       List<BLN_Item__c> blepriv=[select id,name,Event__c,Visibility__c from BLN_Item__c where Visibility__c='Private' and Event__c=: selectedEvent];
       if(blepriv.size()>0)
       privatetickets=true;
       else
       privatetickets=false;
       
       if(privatetickets==true||publictickets==true)
       alltickets=true;
       else
       alltickets=false;
          }catch(exception ex){}
          
          
          List<BLN_Item__c> paiditemlist=[select id,name,Event__c,Visibility__c,price__c,Payment__c from BLN_Item__c where Event__c=: selectedEvent and Payment__c!='Free' limit 1];
          List<Event_Pay_Gateway__c> epgonlinelist=[select id,name,Registration_Type__c,Events__c from Event_Pay_Gateway__c where Registration_Type__c='Online' and Events__c=:selectedEvent limit 1];
          if(paiditemlist.size()!=0&&epgonlinelist.size()==0)
          onlinepayment=true;
          
    }
    public boolean onlinepayment{get;set;}
// ------------------------------------------------------------------------------------ Constructor End ----------------------------------------------------------------------------------------------------
//------------------------------------------url short method ------------------------------------------------------------------------------------>
          
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


public PageReference refreshpage(){
string redirecturl = ApexPages.currentPage().getHeaders().get('Referer');
     system.debug('$$$$$$$$$$$$$$$$$$'+redirecturl);
     PageReference pageRef = new PageReference(redirecturl);
        pageRef.setRedirect(true);
        return pageRef;
}
//------------------------------------------url short end method --------------------------------------------------------------------------------->
}
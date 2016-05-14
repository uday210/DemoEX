public without sharing class Boothadmin_Scan_trackingCon {

    public PageReference export() {
     PageReference pageRef= new PageReference('/apex/BL_ExportscannedBoothadminsToCsv');
        pageRef.setredirect(false);
        return pageRef;
    
        
    }


 public List<BoothVisitSummary__c> BvsList{get;set;}
 public boolean displayPopUpForAddBooth{get;set;}
 
    public PageReference displayScannedAttendees() {
    system.debug('CCCCCCCCCCCCCCC '+Apexpages.CurrentPage().getParameters().get('myName'));
    BvsList =new List<BoothVisitSummary__c>();
    BvsList =[SELECT id,BVS_FirstName__c,BVS_Email__c,BVS_Company__c, BVS_LastName__c,ScanTime__c,BVS_Title__c,BVS_PhoneNumber__c,EA_AttendeeBarcode__r.TicketTypesBP__c,EA_AttendeeBarcode__r.GuestType__c,EA_AttendeeBarcode__r.TicketTypes__c,EA_AttendeeBarcode__r.UniqNo__c,EA_AttendeeBarcode__r.Attendee_Types__c from BoothVisitSummary__c where User_id__r.id=:Apexpages.CurrentPage().getParameters().get('myName') and EA_AttendeeBarcode__r.EV_id__c=:d];
   system.debug('DDDDDDDDDDDD '+BvsList );
    displayPopUpForAddBooth  =true;
        return null;
    }

 public void close(){
 displayPopUpForAddBooth  =false;
 }



public integer androidUsers{get;set;}
public integer IphoneUsers{get;set;}
public integer blackBerryUsers{get;set;}
public integer windowsusers{get;set;}
public integer totalscans{get;set;}


public id d{get;set;}

public Boothadmin_Scan_trackingCon(){
 d =APexpages.currentPage().getParameters().get('event');
showBoothadmin();
}


public void showBoothadmin(){


inn = new List<inncls>();
MAP<Id,string> mapIos = new  MAP<Id,string>();
List<DeviceUsage__c> iphone = new List<DeviceUsage__c>();
List<DeviceUsage__c> android = new List<DeviceUsage__c>();
List<DeviceUsage__c> BlackBerry= new List<DeviceUsage__c>();
List<DeviceUsage__c> windows= new List<DeviceUsage__c>();

List<BoothVisitSummary__c> bvslist=new List<BoothVisitSummary__c>();
bvslist=[select id from BoothVisitSummary__c where Temp__c=:d];
totalscans=bvslist.size();


for(DeviceUsage__c Du:[select User__c,User__r.id,OsVersion__c from DeviceUsage__c where EV_id__r.id=:d]){
 mapIos.put(Du.User__r.id,du.OsVersion__c); 
 
  if(Du.OsVersion__c=='Android'){
    android.add(du);
   }else if(Du.OsVersion__c=='iOS'){
     iphone.add(du);
    }else if(Du.OsVersion__c=='Windows'){
    windows.add(du);
    }
    else if(Du.OsVersion__c=='BlackBerry'){
     BlackBerry.add(du);
    }
    
    
  
}

androidUsers =android.size();
IphoneUsers =iphone.size();
blackBerryUsers =BlackBerry.size();
windowsusers =windows.size();


set<id> setOfBvs = new set<id>();
for(User_Event_BVS__c lusres:[select BVS_id__r.id,BVS_id__c from User_Event_BVS__c where EV_id__r.Id=:d]){
    setOfBvs.add(lusres.BVS_id__r.id);
    
}
 integer i=0;

 

  for(sObject listOfobj:[select count(id) re,User_id__r.FirstName f,User_id__r.LastName l,User_id__r.userName un,User_id__r.id c,User_id__c from BoothVisitSummary__c where EA_AttendeeBarcode__c!=null and EA_AttendeeBarcode__r.EV_id__c=:d  group BY User_id__c,User_id__r.FirstName,User_id__r.LastName,User_id__r.id,User_id__r.userName order by count(id) DESC]){ 
  string lName =(string)listOfobj.get('l');
  string fName =(string)listOfobj.get('f');
  string Uname=(string)listOfobj.get('un');
  integer coun=(integer)listOfobj.get('re');
  Id df =(Id)listOfobj.get('c');
  string iosver = mapIos.get(df);
  inn.add(new inncls(lName,fName,coun, ++i,iosVer,df,Uname));
  
 }

}



public List<inncls> inn{get;set;}
public class inncls{
public string lastName{get;set;}
public string firstName{get;set;}
public string userName{get;set;}
public integer numberOfscans{get;set;}
public integer sNo{get;set;}
public string OSVersion{get;set;}
public id userId{get;set;}

public inncls(string s,string w,integer co,integer bhy,string ver,id use,string unameval){
    lastName=s;
    sNo =bhy;
    OSVersion = ver;
    firstName=w;
    userName =unameval;
  numberOfscans=co;
  userid=use;
    }


}

public PageReference exportscans()
{
PageReference pageRef= new PageReference('/apex/Exportscandetails');
        pageRef.setredirect(false);
        return pageRef;
}


}
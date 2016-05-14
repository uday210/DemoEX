@RestResource(urlMapping='/SynchLeads3/*')

global without sharing class SynchLeads3 {

@httpPost
global static void doPost(){
    
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  
  Blob reqbody =req.requestBody;
  //string Reqblobbody = reqbody.toString();
    
   string blackberry= req.params.get('BlackBerry');
    system.debug('55555555555 '+blackberry);
    string  Reqblobbody ;
    
   if(blackberry!=null & blackberry!=''){
     Reqblobbody = req.headers.get('LeadData');
    system.debug('9999999999999 '+Reqblobbody);
    }else{
    Reqblobbody = reqbody.toString();
     system.debug('3333333333344444444444'+Reqblobbody  );
    }
   
  
  
  
  MAP<string,string> emailWithImage = new MAP<string,string>();
  List<GlobalUtillClass.leads> listOfleads = new List<GlobalUtillClass.leads>();    
      JSONParser Parser = JSON.createParser(Reqblobbody);
       While(parser.nextToken()!= null){
        if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
         while(parser.nextToken() != null){
          if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
            GlobalUtillClass.leads bl = (GlobalUtillClass.leads)parser.readValueAs(GlobalUtillClass.leads.class);
            emailWithImage.put(bl.Email,bl.ImageUrl);
            listOfleads.add(bl);
            system.debug('333333333333 '+bl);
        }
      }
    }
   }
   
   
   
   
   
   List<BoothVisitSummary__c> BsList = new List<BoothVisitSummary__c>();
   List<document> docsList = new List<document>(); 
   Id filderId;
  List<document> docs =[Select d.Name, d.FolderId, d.Body From Document d where folder.Name='shared documents'limit 1];
   if(docs.size()>0){
    filderId=docs[0].FolderId;
   }
   
   List<string> lisOfmreords = new List<string>();
   List<string> lisOfmreords123 = new List<string>();
   
   List<string> docNames= new List<string>();
   
   for(GlobalUtillClass.leads bal2:listOfleads){
    BoothVisitSummary__c Bs = new BoothVisitSummary__c();
     Bs.User_id__c =  bal2.UserId;
     Bs.EA_AttendeeBarcode__c = bal2.Barcodeid;
     Bs.BVS_Title__c =  bal2.Designation;
     Bs.BVS_State__c = bal2.state;
     Bs.BVS_LastName__c =bal2.Lastname;
     Bs.BVS_FirstName__c = bal2.Firstname;
     Bs.BVS_Email__c = bal2.Email;
     Bs.BVS_Company__c =bal2.Company;
     Bs.BVS_City__c = bal2.City;
     Bs.BVS_PhoneNumber__c =bal2.PhoneNo;
     Bs.Mrecordid__c = bal2.Barcodeid+'-'+bal2.UserId;
     lisOfmreords123.add(Bs.Mrecordid__c );
     lisOfmreords.add(Bs.Mrecordid__c+'.jpeg');
     
     Bs.BVS_SurveyQuestion4__c= bal2.SurveyQuestion4;
     Bs.BVS_SurveyQuestion3__c= bal2.SurveyQuestion3;
     Bs.BVS_SurveyQuestion2__c= bal2.SurveyQuestion2;
     Bs.BVS_SurveyQuestion1__c = bal2.SurveyQuestion1;
     
     
     Bs.BVS_SurveyAnswer1__c = bal2.SurveyAnswer1;
     Bs.BVS_SurveyAnswer2__c = bal2.SurveyAnswer2;
     Bs.BVS_SurveyAnswer3__c = bal2.SurveyAnswer3;
     Bs.BVS_SurveyAnswer4__c = bal2.SurveyAnswer4;           
     Bs.BVS_FollowUps__c = bal2.FollowupTypes;  
     Bs.BVS_Notes__c = bal2.notes;
     Bs.Temp__c =bal2.EventId;
     Bs.SalesForceStatus__c=bal2.SalesForceStatus;
     
      system.debug('333333333333 '+bal2.NextFollowUpdate);
     system.debug('tZoneShortForm ->>>'+bal2.tZoneShortForm);
    
     if(bal2.NextFollowUpdate!='' && bal2.NextFollowUpdate!=null){  
        Bs.Follow_Update__c = DateTime.valueOf(bal2.NextFollowUpdate);
        //dateTime.valueOf(bal2.NextFollowUpdate);
         system.debug('567547567657567'+Bs.Follow_Update__c);
       }
     if(bal2.ScannedTime !=null && bal2.ScannedTime!=''&& bal2.tzone !=null && bal2.tzone !=''){
    //    string customerDateTimeString = bal2.ScannedTime;
     //   DateTime dt= DateTime.valueofGmt(customerDateTimeString);
/****************************************************************************************/   
try{
 
string ESTtime;
string tsting_m=bal2.tZoneShortForm;
string sttime=bal2.ScannedTime;
string terzone=bal2.tzone;
system.debug('@tshort'+tsting_m);
system.debug('@ttimet'+sttime);
system.debug('@tzonet'+terzone);
 
string[] dttime = sttime.Split(' ',2);
string[] timet = dttime[1].Split(':',3);
string[] datet = dttime[0].Split('-',3);

integer   h = integer.valueof(timet[0]);
integer yyyy=integer.valueof(datet[0]);
integer mm=integer.valueof(datet[1]);
integer dde=integer.valueof(datet[2]);
integer min=integer.valueof(timet[1]);
integer sss=integer.valueof(timet[2]);

Schema.DescribeFieldResult fieldResult = User.TimeZoneSidKey.getdescribe();
List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
system.debug('@ple'+ple.size());
map<string,string> fmap=new map<string,string>();
map<string,string> stmap=new map<string,string>();
for(Schema.PicklistEntry xdd:ple){
string nq=xdd.getlabel();
string mq=xdd.getValue();
fmap.put(mq,nq);


String gmtsrings= (nq.substringBetween(')','(')).trim();
string gmt_times= (nq.substringBetween('(GMT',')')).trim();
gmt_times='GMT'+gmt_times;
stmap.put(gmtsrings,gmt_times);
gmt_times='';

}
/****************unknown timezones adding ****************/
/********based on key****************/
fmap.put('Europe/Tirane','(GMT+02:00)');
fmap.put('Asia/Calcutta','(GMT+05:30)');
fmap.put('America/Araguaina','(GMT-03:00)');
fmap.put('Europe/Belgrade','(GMT+01:00)');
fmap.put('Europe/Sarajevo','(GMT+01:00)');
fmap.put('Europe/Zagreb','(GMT+01:00)');
fmap.put('Europe/Tirane','(GMT+01:00)');
fmap.put('Europe/Zagreb','(GMT+01:00)');
fmap.put('Africa/Brazzaville','(GMT+01:00)');
fmap.put('Europe/Stockholm','(GMT+01:00)');


/*******based on string ********************/
stmap.put('Pacific Standard Time','(GMT-07:00)');

stmap.put('Eastern Standard Time','(GMT-04:00)');
stmap.put('GMT','(GMT+00:00)');
stmap.put('Atlantic Standard Time','(GMT-03:00)');
stmap.put('Iran Standard Time','(GMT+04:30)');
stmap.put('Indochina Time','(GMT+07:00)');
stmap.put('Peru Standard Time','(GMT-05:00)');
stmap.put('Korean Standard Time','(GMT+09:00)');
stmap.put('Central Standard Time','(GMT-05:00)');
stmap.put('Eastern European Standard Time','(GMT+03:00)');
stmap.put('New Zealand Standard Time','(GMT+12:00)');
stmap.put('Western European Standard Time','(GMT+01:00)');
stmap.put('East Africa Time','(GMT+03:00)');
stmap.put('Hong Kong Standard Time','(GMT+08:00)');
stmap.put('India Standard Time','(GMT+05:30)');
stmap.put('Mountain Standard Time','(GMT-06:00)');
stmap.put('Western Indonesia Time','(GMT+07:00)');
stmap.put('Greenwich Mean Time','(GMT+00:00)');
stmap.put('Argentina Standard Time','(GMT-03:00)');
stmap.put('Central Africa Time','(GMT+01:00)');
stmap.put('Gulf Standard Time','(GMT+04:00)');
stmap.put('Singapore Standard Time','(GMT+08:00)');
stmap.put('Colombia Standard Time','(GMT-05:00)');
stmap.put('Pakistan Standard Time','(GMT+05:00)');
stmap.put('West Africa Standard Time','(GMT+01:00)');
stmap.put('Japan Standard Time','(GMT+09:00)');
stmap.put('Chile Standard Time','(GMT-03:00)');
stmap.put('Central European Standard Time','(GMT+01:00)');
stmap.put('Bangladesh Standard Time','(GMT+06:00)');
stmap.put('Moscow Standard Time','(GMT+03:00)');
stmap.put('Alaska Standard Time','(GMT-09:00)');
stmap.put('Brasilia Standard Time','(GMT-03:00)');
stmap.put('Hawaii-Aleutian Standard Time','(GMT-10:00)');
stmap.put('Philippine Standard Time','(GMT+08:00)');

/*****************end of unknown timezones adding*********/   
//system.debug('alltzone'+fmap.size());
//system.debug('tzone'+terzone);
string xyz=fmap.get(terzone);

if(xyz == NULL || xyz == '')
{
    if(tsting_m !=NULL || tsting_m !='')
    {
        xyz=stmap.get(tsting_m);
    }    
}




//system.debug('timezone'+xyz);
String tme = xyz.substringBetween('(',')');
 system.debug('tme    '+tme );

if(tme.contains('GMT-')){
string[] hour = tme.Split('GMT-',2);
string[] tottime = hour[1].Split(':',2);
system.debug('adapa'+tottime);
Integer hh1 = Integer.valueOf(tottime[0]);
Integer mm1 = Integer.valueOf(tottime[1]);
h=h+hh1;
min=min+mm1;
Datetime finalGMT= Datetime.newInstanceGmt(yyyy,mm,dde,h,min,sss);
ESTtime=finalGMT.format('yyyy-MM-dd HH:mm:ss', 'America/New_York');

}
else if(tme.contains('GMT+')){
system.debug('tme    '+tme );
string[] hour_t = tme.Split('GMT+',2);
string[] tottime_t = hour_t[1].Split(':',2);
Integer hr_t = Integer.valueOf(tottime_t[0]);
Integer mi_t = Integer.valueOf(tottime_t[1]);
h=h-hr_t;
min=min-mi_t;
Datetime finalindianGMT= Datetime.newInstanceGmt(yyyy,mm,dde,h,min,sss);
ESTtime=finalindianGMT.format('yyyy-MM-dd HH:mm:ss', 'America/New_York');
system.debug('ESTtime    '+ESTtime);
}

system.debug('@@est'+ESTtime);
system.debug('@@finlainsert'+Datetime.valueof(ESTtime));
 if(bal2.EventId!=null && bal2.EventId!='a00F000000BA4ljIAD'){
     Bs.ScanTime__c=Datetime.valueof(ESTtime);
  }else{
  Datetime finalindianGMTTemp= System.now();
  String ESTtimeTemp = finalindianGMTTemp.format('yyyy-MM-dd HH:mm:ss', 'America/New_York');
   System.debug('ESTtimeTemp   '+ESTtimeTemp );
   Bs.ScanTime__c = Datetime.valueof(ESTtimeTemp );
    System.debug('Datetime.valueof(ESTtimeTemp ) '+Datetime.valueof(ESTtimeTemp ));
    System.debug('Bs.ScanTime__c '+Bs.ScanTime__c);
  }

} catch(Exception e) {


}



     
//****************************************************************************************/       
  }  
       
    
     if(bal2.leadRating!=null & bal2.leadRating!=''){
       Bs.BVS_LeadRating__c = decimal.valueOf(bal2.leadRating);
      }  
     BsList.add(bs);
  // try{ 
    if(bal2.ImageUrl!=null & bal2.ImageUrl!=''){ 
     document d = new document();
     d.FolderId=filderId;
     d.ispublic=true;
     d.Name=bal2.Barcodeid+'-'+bal2.UserId+'.jpeg';
     docNames.add(d.Name);
     
     system.debug('VVVVVVVVVVVVVVVVVV '+docNames);
     d.Body=EncodingUtil.base64Decode(bal2.ImageUrl);  
     docsList.add(d);  
     system.debug('RRRRRRRRRRR '+d+'****************** '+docsList);
    }              
  // }catch(exception e){}
   }
   
   
   
   
   // ---------------  inserting Or updating booth Visit Summary  Start-------------------------------
   
    system.debug('77777777777 '+docsList.size());
   Schema.SObjectField f = BoothVisitSummary__c.Fields.Mrecordid__c;
   Database.UpsertResult[] Dbbvs = DataBase.upsert(BsList,f,false);
   system.debug('333333333333 32423424242'+Dbbvs );
   
      
   set<Id> bvsIds = new set<Id>(); 
   for(Database.UpsertResult upResult :Dbbvs){
    if(upResult.issuccess()){
         bvsIds.add(upResult.getId());
    }
   }
   
   List<BoothVisitSummary__c> bvslistWithbvs = new List<BoothVisitSummary__c>();
   bvslistWithbvs  = [select id from BoothVisitSummary__c where Mrecordid__c in :lisOfmreords123];
   for(BoothVisitSummary__c v :bvslistWithbvs  ){
   bvsIds.add(v.id);
   }
   
   
   
    system.debug('333333333333 1232311231231'+bvsIds);
   
//  ---------------  inserting Or updating booth Visit Summary End ------------------------------- 
   
    List<Document> listforDelete =new List<Document>();
  
  system.debug('555555555555555 '+docNames);
  
  listforDelete  =[select id from document where  Name IN :docNames];
  system.debug('555555555555555 '+docNames);
  delete listforDelete;
   
 //  ---------------  inserting Documents  ------------------------------- 
   
   List<BoothVisitSummary__c> bvs = new List<BoothVisitSummary__c>();
   database.Saveresult[] dbsaveResult = DataBase.insert(docsList,false);
   system.debug('SSSSSSSSSSSSSSSSSSSSSSSSSSSSS '+dbsaveResult );
  List<Id> docIds= new List<Id>(); 
   for(Database.Saveresult upResult:dbsaveResult){
    if(upResult.issuccess()){
         docIds.add(upResult.getId());
    }
   }
  
  //  ---------------  inserting Documents  End------------------------------- 
   
  
  
  
 
 
 
  List<BoothVisitSummary__c> bvSummaryList = new List<BoothVisitSummary__c>();
  List<BoothVisitSummary__c> bvSummaryBVS = new List<BoothVisitSummary__c>();
  
  MAP<string,BoothVisitSummary__c> bvsWitImage = new MAP<string,BoothVisitSummary__c> (); 
   List<Id> eventssexistedInBV = new List<Id>();
    set<Id> userForupe = new set<Id>();
    
   for(BoothVisitSummary__c bv :[select User_id__r.id,id,AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c,Mrecordid__c from BoothVisitSummary__c where Id In :bvsIds]){
    bvsWitImage.put(bv.Mrecordid__c,bv);
    eventssexistedInBV.add(bv.EA_AttendeeBarcode__r.EV_id__c);
    userForupe.add(bv.User_id__r.id);
   }
   
    system.debug('00000000000000'+lisOfmreords);
    
       for(document df :[select id,name from document where name IN :lisOfmreords]){
         BoothVisitSummary__c bh = new BoothVisitSummary__c();
         system.debug('66666666666666 '+df.id);
          bh= bvsWitImage.get(df.Name.removeEnd('.jpeg'));
          bh.AS_ImageUrl__c =df.id;
         bvSummaryList.add(bh);
         
    }
    
    Database.upsertResult[] dbResult= DataBase.upsert(bvSummaryList,f,false);
       
    
 
    // -------------------------- inserting user_event_BVS ------------------------- 
    
      List<BoothVisitSummary__c> BoothSummaryNew = new List<BoothVisitSummary__c>();
        List<User_Profile_Event__c> listOfUpes = new List<User_Profile_Event__c>(); 
        
      
      MAP<id,User_Profile_Event__c> mapboothabcd = new MAP<id,User_Profile_Event__c>();
    
     system.debug('4444444444 5555555555 '+eventssexistedInBV);
     system.debug('4444444444 5555555555 '+userForupe);
    
   if(eventssexistedInBV.size()>0 && userForupe.size()>0){
   
     List<User_Profile_Event__c> listofUPES1 = new List<User_Profile_Event__c>();
     
     listofUPES1 =[select id, EV_id__r.id from User_Profile_Event__c  where EV_id__r.id IN :eventssexistedInBV and User_id__r.id IN :userForupe  and EV_id__r.id!=null and User_id__r.id!=null]; 
    
     
    for(User_Profile_Event__c IterateUPE:listofUPES1){
     if(IterateUPE.EV_id__r.id!=null){
       mapboothabcd.put(IterateUPE.EV_id__r.id,IterateUPE);
      }
    }
   }  
   
    system.debug('222222222222  '+mapboothabcd);
     
     List<User_Event_BVS__c> UserBVS = new List<User_Event_BVS__c>();
     
      for(BoothVisitSummary__c BSVC:[select Temp__c,User_id__r.id,id,AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c,Mrecordid__c from BoothVisitSummary__c where Id In :bvsIds]){
        User_Profile_Event__c  upe2 = new User_Profile_Event__c();
      
        system.debug('666666666666666 '+BSVC);
        
        User_Event_BVS__c UEB = new User_Event_BVS__c();
        if(BSVC.Temp__c!=null){
        system.debug('333333 '+id.valueOf(BSVC.Temp__c));
        upe2 = mapboothabcd.get(id.valueOf(BSVC.Temp__c));
       }  
            
       if(upe2.EV_id__r.id!=null){
        UEB.EV_id__c = upe2.EV_id__r.id; 
        UEB.BVS_id__c = BSVC.id;  
        UEB.UPE_id__c = upe2.id;
        UEB.Mrecordid__c=BSVC.Mrecordid__c;
        UserBVS.add(UEB); 
       }
      }
      
     try{
       Schema.SObjectField fot = User_Event_BVS__c.Fields.Mrecordid__c;
       Database.UpsertResult[] upsertResults= DataBase.upsert(UserBVS,fot,false);
       system.debug('9999999999999999 '+upsertResults);
      }  catch(Exception ex){
         System.debug('@@@@@exMesssage'+ex.getMessage());
    } 
 }
}
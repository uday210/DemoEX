global class scheduledEBMT implements Schedulable{
global String Apieventname{get;set;}
   global String itemid{get;set;}
   global String eveid{get;set;}
   global String no{get;set;}
   global String opt{get;set;}
public scheduledEBMT(String apieventname,String itid,String evid,String no,String opt)
{
  this.Apieventname=apieventname;
  itemid = itid;
  eveid=evid;
  this.no=no;
  this.opt=opt;
  
} 
  
   global void execute(SchedulableContext SC) {
   bln_event__c bec=[select id,name,last_refreshed_time__c from bln_event__c where id=:eveid];
   Id batchInstanceId = Database.executeBatch(new BLN_BatchEBMT(Apieventname,bec.last_refreshed_time__c,itemid,eveid), 5);
   //schedule after every 1 hour
   Integer intYear = system.now().year();
Integer intMon = system.now ().month ();
Integer intDate = system.now ().day ();
if(opt=='Day')
intDate = system.now ().day ()+Integer.valueOf(no);
Integer intHr = system.now ().hour ();
if(opt=='Hour')
intHr = system.now ().hour ()+Integer.valueOf(no);
Integer intMin = system.now ().minute ();
if(opt=='Minute')
intMin = system.now ().minute ()+Integer.valueOf(no);
Integer intSec = system.now ().second ();
if(opt=='Second')
intSec = system.now ().second ()+Integer.valueOf(no);
if (intSec > 59){
intMin=intMin+1;
IntSec=intSec-60;
}
if (intMin > 59){
IntHr=intHr+1;
IntMin=intMin-60;
}
if (intHr > 23){
IntDate = intDate + 1;
intHr = intHr - 24;
}
if(intMon == 2 && intDate > 28){
intMon = intMon + 1;
intDate = intDate - 28;
}else if( (intMon == 4 || intMon == 6 || intMon == 9 || intMon == 11 ) && ( intDate > 30 ) ){
intMon = intMon + 1;
intDate = intDate - 30;
} else if (intDate > 31) {
intMon = intMon + 1;
intDate = intDate - 31;
}
if(intMon>12){
intYear=intYear+1;
intMon=intMon-12;
}
String Stryear = string.valueOf(intYear);
String Strmonth = string.valueOf(intMon);
String Strday = string.valueOf(intDate);
String Strhour = string.valueOf(intHr);
String Strminute = string.valueOf(intMin);
String Strsecond = string.valueOf(intSec);
String strJobName = Apieventname+'Job-' + Strsecond + '_' + Strminute + '_' + Strhour + '_' + Strday + '_' + Strmonth + '_' + Stryear;
String strSchedule = '0 ' + Strminute + ' ' + Strhour + ' ' + Strday + ' ' + Strmonth + ' ?' + ' ' + Stryear;
   //
   bec.last_refreshed_time__c=System.now()+'';
   update bec;
        system.schedule(strJobName, strSchedule, new scheduledEBMT(Apieventname,itemid,eveid,no,opt));
   }
   
   
  
}
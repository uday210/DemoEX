public with sharing class Bln_Scheduler_tcreation{
  public String Bln_Scheduler(Integer SessionTime,String OrdId){
    
     //  Integer ScTime =10 ;
       if(null !=SessionTime && SessionTime > 0 ){
         datetime nextScheduleTime = system.now().addMinutes(SessionTime);
         String day = string.valueOf(nextScheduleTime.day());
         String month = string.valueOf(nextScheduleTime.month());
         String hour = string.valueOf(nextScheduleTime.hour());
         String minute = string.valueOf(nextScheduleTime.minute());
         String second = string.valueOf(nextScheduleTime.second());
         String year = string.valueOf(nextScheduleTime.year());
         String strJobName = 'Abandoned Job-' + second + '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;
         String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
         String ScheduledJobID = System.schedule(strJobName, strSchedule,new BLN_CreateNewTickets(OrdId));  
         return ScheduledJobID;
        }else{
            return null;
        } 
 }


}
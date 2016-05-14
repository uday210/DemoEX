global class deactivateusersmorethan3 implements Schedulable{
   global void execute(SchedulableContext sc) {
     date d = System.today() -30;
 List<user> users = new List<user>();
 List<Event__c> events = new List<Event__c>();
 events =[select id,createdDate from event__c where createdDate <:d];
 set<id> userids = new set<id>();
 
 for(User_Profile_Event__c UPE :[select User_id__r.id,id from User_Profile_Event__c where EV_id__c NOT IN :events]){
  userids.add(UPE.User_id__r.id); 
 }
 
 
 for (user u:[select id from user where id In :userids and profile.Name!='Event Admin' and profile.Name!='System Administrator' and isActive=true]){
  u.isActive =false;
 users.add(u);
 }

 dataBase.update(users,false);

   }
}
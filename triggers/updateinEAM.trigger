trigger updateinEAM on User_Profile_Event__c(after insert,after update) {
 
    List<User_Profile_Event__c> up = new List<User_Profile_Event__c>();
    set<id> upeids = new  set<id>();
    for(User_Profile_Event__c upe :trigger.new){
        if(upe.IsMatchMakingUser__c==true){
            upeids.add(upe.id);
        }
    }

    up =[SELECT id,User_id__r.username,EV_id__r.id,MAtchMakingProfile__c,IsMatchMakingUser__c from User_Profile_Event__c where id IN :upeids];
     
    List<Event_Attendee_Mapping__c> Eam = new  List<Event_Attendee_Mapping__c>();
    if(up.size()>0){
        Eam =[select id,EV_id__c,IsMatchMakingAttendee__c,Boothleads_Profile__c from Event_Attendee_Mapping__c where EV_id__c=:up[0].EV_id__r.id and AS_id__r.AS_Email__c=:up[0].User_id__r.username];
    }

    if(Eam.size()>0){
        Eam[0].IsMatchMakingAttendee__c=true;
        if(up[0].MAtchMakingProfile__c=='Corporate'){
            Eam[0].Boothleads_Profile__c ='Booth Admin';
        }
        else{
            Eam[0].Boothleads_Profile__c ='Attendee';
        }
        Database.SaveResult res =dataBase.update( Eam[0],false);
    }
}
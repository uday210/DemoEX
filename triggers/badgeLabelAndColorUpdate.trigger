trigger badgeLabelAndColorUpdate on Event_Attendee_Mapping__c (after insert,after update) {
try
{
 if(Attendee_Details_PrintCon.runOnce()){
 list<Event_Attendee_Mapping__c> eamlist=new list<Event_Attendee_Mapping__c>{};
 
 for(Event_Attendee_Mapping__c eamnew : trigger.new){
 Event_Attendee_Mapping__c EAM=new Event_Attendee_Mapping__c();
   EAM.id = eamnew .id;
   if(eamnew.Attendee_Types__c!=null && eamnew.GuestType__c==null)
   {
     EAM.GuestType__c=eamnew.Attendee_Types__c;

   }
   
   if(eamnew.TicketTypes__c!=null && eamnew.TicketTypesBP__c==null)
   {
     EAM.TicketTypesBP__c=eamnew.TicketTypes__c;

   }
   
   /*if(eamnew.Badge_Color__c==null){
   if(eamnew.Attendee_Types__c.toUpperCase()=='EXECUTIVE DIRECTOR')
   EAM.Badge_Color__c='#792e2e';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='PRESIDENT')
   EAM.Badge_Color__c='#2e79ce';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='EXHIBITOR')
   EAM.Badge_Color__c='#008000';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='SECURITY')
   EAM.Badge_Color__c='#2e5c77';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='STAFF')
   EAM.Badge_Color__c='#a63032';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='SPONSOR')
   EAM.Badge_Color__c='#ff0000';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='SPEAKER')
   EAM.Badge_Color__c='#df3434';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='VIP')
   EAM.Badge_Color__c='#501f76';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='HOST')
   EAM.Badge_Color__c='#8a26d4';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='ATTENDEE')
   EAM.Badge_Color__c='#1b75bb';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='BOARD MEMBER')
   EAM.Badge_Color__c='#6e325c';
   else if(eamnew.Attendee_Types__c.toUpperCase()=='MODERATOR')
   EAM.Badge_Color__c='#314542';
   }*/
   
        eamlist.add(eam);
 }

Update eamlist;
}
}catch(Exception e){}


}
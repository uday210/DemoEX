public class BLN_PushNotificationsCon_BAL{
    public BLN_PushNotificationsCon_BAL(){
    
    }
    public Map<String,Integer> getregsett(string selectedEventid){
        BLN_Reg_Settings_DAO regDAO=new BLN_Reg_Settings_DAO();
        List<Reg_Setting__c> regsetting = new List<Reg_Setting__c>();
        regsetting = regDAO.getItemtypeRegSetList(selectedEventid);
        
        Map<String,Integer> regsettingmap=new Map<String,Integer>();
        
        for(Reg_Setting__c r:regsetting)
        {
            if(r.Column_Name__c!='StopEmailsToAttendee' && r.Column_Name__c!='StopEmailsToEventAdmin')
            {
                
                string itypename=r.Column_Name__c=='Attendee'?'Admissions':r.Column_Name__c;
                String q='select id,name,Item_Type__c,Item__r.Item_Type__r.name,Item_Type__r.name,Item_Pool__c,tkt_profile__c,tkt_profile__r.BLN_Company__c,Ticket_Status__c,Tkt_profile__r.Home_Phone__c,Tkt_profile__r.First_Name__c,Tkt_profile__r.Last_Name__c,Tkt_profile__r.Email__c,Tkt_profile__r.User_Pic__c,Tkt_profile__r.BLN_GN_User__r.User__c,Tkt_profile__r.FaceBookId__c,Tkt_profile__r.LinkedInId__c,Tkt_profile__r.BLN_Company__r.Company_Logo__c,Tkt_profile__r.BLN_Company__r.Name,Tkt_profile__r.BLN_Company__r.Website_URL__c,Item_Pool__r.Item_Type__r.name from Ticket__c where (Item__r.Item_Type__r.Name = \''+itypename+'\' or Item_Pool__r.Item_Type__r.name =\''+itypename+'\') and Event__c=\''+selectedEventid+'\' and (Ticket_Status__c=\'Booked\' or Ticket_Status__c=\'Checked-in\' or Ticket_Status__c=\'Checked-out\') and order__r.Order_Status__c !=\'Cancelled\' and order__r.Order_Status__c !=\'Abandoned\' and order__r.Order_Status__c !=\'Not Paid\'';    
                List<Ticket__c> tc=Database.query(q);

                regsettingmap.put(r.Column_Name__c,tc.size()); 
            }

        }
        
        return regsettingmap;
    }

}
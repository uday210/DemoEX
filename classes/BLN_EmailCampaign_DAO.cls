public class BLN_EmailCampaign_DAO{
    public LIST<EmailCampaign__c> getEmailCampaigns(string eventid,string featureType){
        LIST<EmailCampaign__c> ecList = new LIST<EmailCampaign__c>();
        ecList = [SELECT Schedule_Id__c,Name,Event__c,Template_Status__c,Email_Status__c,Email_Send_Date__c,CampSubject__c,CampEmailTemplate__c,ToList__c,Feature_Type__c 
                   FROM EmailCampaign__c
                  WHERE Event__c =: eventid
                    AND Feature_Type__c =: featureType
                    AND Email_Status__c != 'Deleted'];
        return ecList;
    }
    
    public EmailCampaign__c getECforID(string ecId){
        EmailCampaign__c ec = new EmailCampaign__c();
        ec = [SELECT Schedule_Id__c,Name,Event__c,Template_Status__c,Email_Status__c,Email_Send_Date__c,CampSubject__c,CampEmailTemplate__c,ToList__c,Feature_Type__c 
                   FROM EmailCampaign__c
                  WHERE id =: ecId];
        return ec;
    }
}
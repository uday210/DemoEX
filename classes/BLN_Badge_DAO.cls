public without sharing class BLN_Badge_DAO{

/**
* @author :Arindam Sarkar
* @date 05/15/2014
* @ This class is used for DML operations on Badge object
*/ 

//Getting Avalaible Badge By Passing Ticket ID
public String getBadgeForTicket(String ticketid)
{
STring badgeid;
try
      {
       Badge__c badge=[SELECT id,name,ticket_id__c FROM Badge__c where ticket_id__c=:ticketid and cancel_time__c=null and Exp_time__c=null];
       badgeid=badge.id;
       }catch(Exception e){badgeid='';}
       
       return badgeid;
}


public BLN_StatusMessage insertBadge(Badge__c bdg)
{
    dataBase.saveResult saveRes = dataBase.insert(bdg,false);
    return new BLN_StatusMessage(saveRes);
}

public BLN_StatusMessage updateBadge(Badge__c bdg)
{
    dataBase.saveResult saveRes = dataBase.update(bdg,false); 
       return new BLN_StatusMessage(saveRes);
}

   public Badge__c getTicketsInfo(String badgeid,string eventId){
      List<Badge__c> badge=[SELECT (SELECT Id,Event__c,Tkt_profile__r.Work_Address__r.City__c,Tkt_profile__r.Work_Address__r.Country__c,Tkt_profile__r.Work_Address__r.State__c,Tkt_profile__r.Work_Address__r.Address1__c,Tkt_profile__r.Work_Address__r.Address2__c,Tkt_profile__r.Work_Phone__c,Tkt_profile__r.Work_Address__r.Zipcode__c,tkt_profile__r.Email__c,tkt_profile__r.TKT_Company__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Prefix__c,tkt_profile__r.Home_Phone__c,tkt_profile__r.Suffix__c,tkt_profile__r.Mobile__c,Ticket_Status__c,tkt_profile__r.User_Pic__c,tkt_profile__r.TKT_Job_Title__c,Tkt_profile__r.BLN_Company__c from Tickets__r),Id,Name,Ticket_id__c,Cancel_Reason__c,Cancel_time__c,Eff_time__c,Exp_time__c,Ticket_id__r.Event__c,ticket_id__r.Custom_Barcode__c FROM Badge__c where (id=:badgeid OR Name=:badgeid) and Ticket_id__r.Event__c =:eventId];
      if(badge.size()>0){
         return badge[0];
      }else{
       // return new Badge__c();
       return null;
      }
   }



}
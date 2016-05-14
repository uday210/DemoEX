public without sharing class BLN_Booth_Map_DAO{
/**
* @author :Deepthi Kollu
* @date 15/05/2015
* @ This class is used for DML operations on Booth Map object
*/ 

    public List<Booth_Map__c> BoothDetails(string str){
        //string query1 = 'SELECT Ticket_id__r.tkt_profile__r.TKT_Company__c,Ticket_id__r.Event__c,Ticket_id__r.id,Ticket_id__r.Item_Pool__r.Item_Pool_Name__c,Booth_Number__c,Booth_Size__c,Booth_Area__c,BLN_Room__r.Name,Ticket_id__r.Name,Ticket_id__r.Order__r.Name FROM Booth_Map__c'+ str;
        string query1 = 'SELECT Visibility__c,Ticket_id__r.tkt_profile__r.Video__c,Ticket_id__r.tkt_profile__r.TKT_Company__c,Ticket_id__r.Event__c,Ticket_id__r.id,Ticket_id__r.Item_Pool__r.Item_Pool_Name__c,Booth_Number__c,Booth_Size__c,Booth_Area__c,BLN_Room__r.Name,Ticket_id__r.Name,Ticket_id__r.Order__r.Name,Ticket_id__r.Item_Type__r.Name,Ticket_id__r.tkt_profile__r.Company_Logo__c,Ticket_id__r.tkt_profile__r.Company_Description__c,Ticket_id__r.tkt_profile__r.FaceBookId__c,Ticket_id__r.tkt_profile__r.LinkedInId__c,Ticket_id__r.tkt_profile__r.TwitterId__c,Ticket_id__r.tkt_profile__r.Blogger__c,Ticket_id__r.tkt_profile__r.Blog_URL__c,Ticket_id__r.tkt_profile__r.Company_Website_URL__c FROM Booth_Map__c'+ str;
        system.debug('query           '+query1);
        
        List<Booth_Map__c> Boothlist= dataBase.query(query1);
        
          if(Boothlist.size() > 0){
        return Boothlist;
         }else{
             return new LIST<Booth_Map__c>();
         }

    }
    
    public List<Booth_Map__c> BoothDetailslist(string Eventid,Datetime lastmodifieddate){
    
      List<Booth_Map__c> Blist = [SELECT Visibility__c,Ticket_id__r.tkt_profile__r.Video__c,Ticket_id__c, Ticket_id__r.tkt_profile__r.TKT_Company__c,Ticket_id__r.Event__c,Ticket_id__r.id,Ticket_id__r.Item_Pool__r.Item_Pool_Name__c,Booth_Number__c,Booth_Size__c,Booth_Area__c,BLN_Room__r.Name,Ticket_id__r.Name,Ticket_id__r.Order__r.Name FROM Booth_Map__c Where Ticket_id__r.Event__c =:Eventid AND LastModifiedDate>:lastmodifieddate]; 
    
     return Blist;
    }
    
    public LIST<BLN_Sponsorships__c> sponsorshiplist(string eveid){
    system.debug('eveid=================='+eveid);
        LIST<BLN_Sponsorships__c> sponslist=[SELECT Visibility__c,lastmodifieddate,Sponsorship_Category__c,Display_Order__c,Logo_Size__c,Ticket_id__r.Order__r.Name,Ticket_id__r.tkt_profile__r.TKT_Company__c,Ticket_id__r.tkt_profile__r.Company_Logo__c,Ticket_id__r.tkt_profile__r.Company_Description__c,Ticket_id__r.tkt_profile__r.FaceBookId__c,Ticket_id__r.tkt_profile__r.LinkedInId__c,Ticket_id__r.tkt_profile__r.TwitterId__c,Ticket_id__r.tkt_profile__r.Blogger__c,Ticket_id__r.tkt_profile__r.Blog_URL__c,Ticket_id__r.tkt_profile__r.Company_Website_URL__c,Ticket_id__r.item_pool__r.item_type__r.Name,Ticket_id__r.item_type__r.Name,Ticket_id__r.Item_Pool__r.Item_Pool_Name__c from BLN_Sponsorships__c where (Ticket_id__r.item_type__r.Name = 'Sponsorship' OR Ticket_id__r.item_pool__r.item_type__r.Name = 'Sponsorship') and Ticket_id__r.Order__r.Name !=null AND Ticket_id__r.Order__r.Order_Status__c !='Cancelled' AND Ticket_id__r.Order__r.Order_Status__c !='Abandoned' AND Ticket_id__r.Order__r.Order_Status__c !='Not Paid' AND Ticket_id__r.Ticket_Status__c = 'Booked' AND Ticket_id__r.event__c =:eveid order by Display_Order__c ASC];
        system.debug('sponslist====='+sponslist);
         if(sponslist.size() > 0){
              return sponslist;
         }else{
             return new LIST<BLN_Sponsorships__c>();
         }

    }
    
     /*public LIST<ticket__c> sponsorshiplist(string eveid){
        LIST<ticket__c> tlist=[SELECT tkt_profile__r.TKT_Company__c,tkt_profile__r.Company_Logo__c,tkt_profile__r.Company_Description__c,tkt_profile__r.FaceBookId__c,tkt_profile__r.LinkedInId__c,tkt_profile__r.TwitterId__c,tkt_profile__r.Blogger__c,tkt_profile__r.Blog_URL__c,tkt_profile__r.Company_Website_URL__c from ticket__c where item_type__r.Name = 'Sponsorship' AND item_pool__r.item_type__r.Name = 'Sponsorship' and event__c =:eveid];
        return tlist;
    }*/
    
}
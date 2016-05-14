public with sharing class BLN_Speakers_BAL {

 public BLN_Ticket_DAO tcDAo{get;set;}
 public List<inncls> inn{get;set;}
 
 //Method to get all the cancelled tickets related order 
  public List<inncls> getAllTickets(string uid,string eventId){
        tcDAo = new BLN_Ticket_DAO();
        inn= new List<inncls>();
        string status ='Cancelled';
       // string ststus2 = 'Completed';
       string ststus_a = 'Abandoned';
       string ststus_n = 'Not Paid';
        string type= 'Speaker';
        string temp = ' where Item_Pool__c != null AND event__c = \''+eventId+'\''+' and  Ticket_Status__c != \''+status+'\''+' and order__c!=null and tkt_profile__r.BLN_GN_User__c!=null and order_item__c != null';
        
          temp+=' and  order__r.Order_Status__c != \''+status+'\'';
          temp+=' and  order__r.Order_Status__c != \''+ststus_a+'\'';
          temp+=' and  order__r.Order_Status__c != \''+ststus_n+'\'';
          temp+=' and  (Item_Type__r.Name = \''+type+'\'' +' OR Item_Pool__r.Item_Type__r.Name = \''+type+'\'' +')';
        //  temp+=' and  order__r.Transaction_Status__c= \''+ststus2+'\''+'order by order__c';
          temp+=' order by Ticket_Display_Order__c desc';
           
    // order by order__c
        for(Ticket__c tc : tcDao.userOrderAndTickets(temp)){
        System.debug('@@@@@@@:'+tc.Tstatus_Id__r.Tstatus_name__c);
            inn.add(new inncls(tc));
         }
         return inn;
     }

   public class inncls{
     public boolean selectCheckBox{get;set;}
     public Ticket__c ticket{get;set;}  
     public inncls(ticket__c t){
        this.ticket=t;     
     }
   }
}
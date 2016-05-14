//Modifications done by Thirupathi Pattipaka 
public without sharing class BLN_Ticket_DAO{
  /**
* @author :Arindam Sarkar
* @date 05/12/2014
* @ This class is used for DML operations on Ticket object
*/ 
  public List<Ticket__c> getScanAttendeeBuyer(String eventid){
       return [SELECT id,Parent_ID__c,order_item__c,Ticket_Status__c,Order__r.id,tkt_Profile__c,item__c,item_pool__c,tkt_profile__r.BLN_GN_User__r.User__c,tkt_profile__r.Email__c ,tkt_profile__r.First_Name__c,tkt_Profile__r.Last_Name__c from Ticket__c where Event__c=:eventid and Item_Type__r.name='Scan Attendee' and Ticket_Status__c ='Booked'];        
    }

    public Ticket__c tcWithTktPid(String tktId){
       return [SELECT id,Parent_ID__c,order_item__c,Ticket_Status__c,Order__r.id,tkt_Profile__c,item__c,item_pool__c,tkt_profile__r.BLN_GN_User__r.User__c,tkt_profile__r.Email__c ,tkt_profile__r.First_Name__c,tkt_Profile__r.Last_Name__c from Ticket__c where id =:tktId];        
    }
    
    public BLN_StatusMessage insertTicket(List<Ticket__c> tckt){
        dataBase.saveResult[] saveRes = dataBase.insert(tckt,false); 
        return new BLN_StatusMessage(saveRes);
    }
    
    //Getting list of Tstatus that are associated with ticket/attendee
    public List<Tstatus__c> checkinStatus(SET<id> statusId){
        return [Select id,name,Tstatus_name__c,Ticket__r.tkt_Profile__r.First_Name__c,Ticket__r.tkt_Profile__r.Last_Name__c,Ticket__r.Item_type__r.Name, LastModifiedDate From Tstatus__c Where Id IN :statusId Order by LastModifiedDate Desc];
    }
    
    //Updating the tickets  
    public BLN_StatusMessage updateTicket(List<Ticket__c> tckt){
        dataBase.saveResult[] saveRes = dataBase.update(tckt,false); 
        return new BLN_StatusMessage(saveRes);
    }
    
    //Updating the tickets  
    public BLN_StatusMessage updateTicket(Ticket__c tckt){
        dataBase.saveResult saveRes = dataBase.update(tckt,false); 
        return new BLN_StatusMessage(saveRes);
    }

 // This method return user booked tickets 
    public List<Ticket__c> userOrderAndTickets(string str){
        string query1 = 'Select custom_barcode__c,Event__r.Time_Zone__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,'
        +'tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,'
        +'order_item__r.Item_Quantity__c,Order__r.BLN_TKT_Profile__r.Mobile__c,Order__r.BLN_TKT_Profile__c,'
        +'Order__r.BLN_TKT_Profile__r.Email__c,Order__r.BLN_TKT_Profile__r.First_Name__c,Order__r.BLN_TKT_Profile__r.Last_Name__c,'
        +'(select id,name,Tstatus_name__c,scan_time__c,Ticket__r.Item_type__r.Name,Ticket__r.tkt_profile__r.First_Name__c,Ticket__r.tkt_profile__r.Last_Name__c,LastModifiedDate,Owner.Name,'
        +'Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,'
        +'item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,'
        +'Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),'
        +'order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name,'
      
        //TKT_Profile Fields
         +'tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,'
          +'tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,'
          +'tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,'
          +'tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,'
          +'tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,'
          +'tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,'
          +'tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,'
          //Home Address Fields
          +'tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,'
          +'tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,'
          //Work Address Fields
          +'tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,'
          +'tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,'
          //Shipping Address Fields
          +'tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,'
          +'tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,'
          //Billing Address Fields
          +'tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,'
          +'tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c,tkt_profile__r.BLN_GN_User__c'
        
        +'  From Ticket__c t '+str;
        
        List<Ticket__c> ticketsbooked = dataBase.query(query1);
        return ticketsbooked; 
    }

    //for getting available tickets for an item
    public List<Ticket__c> userOrderAndTickets(set<id> idvalues,String userId,string eveId) {
    
        List<Ticket__c> tckt = new List<Ticket__c>();
        if(eveId=='All'){
         tckt=[select  id,order__r.id,Badge_ID__r.Print_status__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,name,Tag_No__c,order__c,item__r.event__r.Name,item__r.item_Name__c ,Event__r.End_Date__c,Event__c,Item_Type__r.name,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Badgable__c,Badge_ID__c,item__r.Ticket_Settings__c,item__r.Item_Pool__r.Item_Pool_Name__c,item__r.item_type__r.Name, 
            //TKT_Profile Fields
              tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
              tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
              tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
              tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
              tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
              tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
              tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
              //Home Address Fields
              tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
              tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
              //Work Address Fields
              tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
              tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
              //Shipping Address Fields
              tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
              tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
              //Billing Address Fields
              tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
              tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
            from 
            Ticket__c where order__c NOT IN :idvalues and  tkt_Profile__r.BLN_GN_User__r.user__c=:userId AND order__r.Order_Status__c!='Abandoned'];
        }else{
            tckt=[select  id,order__r.id,Badge_ID__r.Print_status__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,name,Tag_No__c,order__c,item__r.event__r.Name,item__r.item_Name__c ,Event__r.End_Date__c,Event__c,Item_Type__r.name,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Badgable__c,Badge_ID__c,item__r.Ticket_Settings__c,item__r.Item_Pool__r.Item_Pool_Name__c,item__r.item_type__r.Name, 
              //TKT_Profile Fields
              tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
              tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
              tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
              tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
              tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
              tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
              tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
              //Home Address Fields
              tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
              tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
              //Work Address Fields
              tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
              tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
              //Shipping Address Fields
              tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
              tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
              //Billing Address Fields
              tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
              tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
              from 
              Ticket__c where order__c NOT IN :idvalues and  tkt_Profile__r.BLN_GN_User__r.user__c=:userId and event__c=:eveId AND order__r.Order_Status__c!='Abandoned'];
              }   
        system.debug('Ticket Object Fetch From Database');
        return tckt;
    } 

    //Common Method For Get Ticket Information based on fields and condition
    public List<Ticket__c> getTickets(String fields,String whereCondition){
        List<Ticket__c> tc;
        String sql='select '+fields+' from Ticket__c  where '+whereCondition;
         system.debug('   Sql 0000000000000000  '+sql);
        tc=Database.query(sql);
        return tc;    
    }
    
    //Get Tickets Based on selected Items
    public LIST<Ticket__c> getSelectedTickets(LIST<Id> itemIds){
        LIST<Ticket__c> ticketsList = new LIST<Ticket__c>();
        
        ticketsList = [SELECT ID, NAME,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,Event__c,Parent_ID__c, 
                        //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
        
                        FROM Ticket__c  WHERE item__c IN: itemIds];
                        return ticketsList;
    }
    
    //Get Tickets not availabletickets Based on selected Item
    public LIST<Ticket__c> getTicketsforItem(String itemId){
        LIST<Ticket__c> ticketsList = new LIST<Ticket__c>();        
        ticketsList= [SELECT ID, NAME,Item_Pool__r.Item_Pool_Name__c, Event__c, Parent_ID__c, (SELECT Id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,Ticket__r.Item_Pool__r.Item_Pool_Name__c FROM User_Answers__r Order By Item_Question__r.Question_Level__c DESC), 
                    //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                    
                    
                    FROM Ticket__c  WHERE item__c =: itemId AND (Ticket_Status__c !=: 'Available' OR Ticket_Status__c =: 'Booked')];
                    return ticketsList;
    }
    
    //Get Booked Tickets Based on selected Items
    public LIST<Ticket__c> getSelectedTickets(Set<Id> itemIds){
        LIST<Ticket__c> ticketsList = new LIST<Ticket__c>();
        
        ticketsList = [SELECT ID, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,Event__c,Parent_ID__c,Item__c,Order_Item__r.Item_Discount__c,Order_Item__r.Item_Quantity__c,Order_Item__r.Promotion__r.Name,
                     //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                     
                     FROM Ticket__c  WHERE item__c IN: itemIds AND Ticket_Status__c = 'Booked'];
                    return ticketsList;
    }
    
    
    // This Method is used to get all tickets along with GN User Information belongs to a particular Event written by Manasa Gandham
    //Modified to get TKT_Profile Information By Thirupathi Pattipaka
    public LIST<Ticket__c> ticketsListForEvent(String EventId, Datetime FromDate, Datetime ToDate){        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        if(FromDate != NULL && ToDate != NULL){
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Order__r.CreatedDate >=: FromDate
                          AND Order__r.CreatedDate <=: ToDate  Order By Order__r.CreatedDate ASC];
        }else{
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,

                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Ticket_Status__c =: 'Booked'  Order By Order__r.CreatedDate ASC];
        }
        return ticketsList;
    }
    
    
    
    public LIST<Ticket__c> ticketsListForEvent(String EventId, Datetime FromDate, Datetime ToDate, String searchKey){        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        if(FromDate != NULL && ToDate != NULL){
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Order__r.CreatedDate >=: FromDate
                          AND Order__r.CreatedDate <=: ToDate  
                          AND (Name like : '%'+searchkey+'%' OR tkt_Profile__r.First_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Last_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Email__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Company__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Job_Title__c like : '%'+searchkey+'%' OR tkt_profile__r.Mobile__c like : '%'+searchkey+'%' OR tkt_profile__r.Work_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Home_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Gender__c like : '%'+searchkey+'%' OR item_type__r.Name like : '%'+searchkey+'%' OR Item_Pool__r.Item_Type__r.Name like : '%'+searchkey+'%' OR Order__r.Name like : '%'+searchkey+'%' OR tkt_profile__r.Company_Website_URL__c like : '%'+searchkey+'%' OR tkt_profile__r.Primary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Secondary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Tax_Id__c like : '%'+searchkey+'%' OR Custom_Barcode__c like : '%'+searchkey+'%' )
                          Order By Order__r.CreatedDate ASC];
        }else{
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,

                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Ticket_Status__c =: 'Booked' 
                          AND (Name like : '%'+searchkey+'%' OR tkt_Profile__r.First_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Last_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Email__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Company__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Job_Title__c like : '%'+searchkey+'%' OR tkt_profile__r.Mobile__c like : '%'+searchkey+'%' OR tkt_profile__r.Work_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Home_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Gender__c like : '%'+searchkey+'%' OR item_type__r.Name like : '%'+searchkey+'%' OR Item_Pool__r.Item_Type__r.Name like : '%'+searchkey+'%' OR Order__r.Name like : '%'+searchkey+'%' OR tkt_profile__r.Company_Website_URL__c like : '%'+searchkey+'%' OR tkt_profile__r.Primary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Secondary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Tax_Id__c like : '%'+searchkey+'%' OR Custom_Barcode__c like : '%'+searchkey+'%' )
                          Order By Order__r.CreatedDate ASC];
        }
        return ticketsList;
    }
    
    public LIST<Ticket__c> ticketsListForEvent(String EventId, Datetime FromDate, Datetime ToDate, String searchKey,string selectticket){        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        if(FromDate != NULL && ToDate != NULL){
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Order__r.CreatedDate >=: FromDate
                          AND Order__r.CreatedDate <=: ToDate  
                          AND (Name like : '%'+searchkey+'%' OR tkt_Profile__r.First_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Last_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Email__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Company__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Job_Title__c like : '%'+searchkey+'%' OR tkt_profile__r.Mobile__c like : '%'+searchkey+'%' OR tkt_profile__r.Work_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Home_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Gender__c like : '%'+searchkey+'%' OR item_type__r.Name like : '%'+searchkey+'%' OR Item_Pool__r.Item_Type__r.Name like : '%'+searchkey+'%' OR Order__r.Name like : '%'+searchkey+'%' OR tkt_profile__r.Company_Website_URL__c like : '%'+searchkey+'%' OR tkt_profile__r.Primary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Secondary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Tax_Id__c like : '%'+searchkey+'%' OR Custom_Barcode__c like : '%'+searchkey+'%' )
                          Order By Order__r.CreatedDate ASC];
        }else if(selectticket!='All'){
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,

                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Ticket_Status__c =: 'Booked' 
                          AND item_Pool__r.item_pool_name__c= : selectticket
                          AND (Name like : '%'+searchkey+'%' OR tkt_Profile__r.First_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Last_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Email__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Company__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Job_Title__c like : '%'+searchkey+'%' OR tkt_profile__r.Mobile__c like : '%'+searchkey+'%' OR tkt_profile__r.Work_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Home_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Gender__c like : '%'+searchkey+'%' OR item_type__r.Name like : '%'+searchkey+'%' OR Item_Pool__r.Item_Type__r.Name like : '%'+searchkey+'%' OR Order__r.Name like : '%'+searchkey+'%' OR tkt_profile__r.Company_Website_URL__c like : '%'+searchkey+'%' OR tkt_profile__r.Primary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Secondary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Tax_Id__c like : '%'+searchkey+'%' OR Custom_Barcode__c like : '%'+searchkey+'%' )
                          Order By Order__r.CreatedDate ASC];
        
        } else{
            ticketsList= [SELECT ID,Custom_Barcode__c,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,    
                          (SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,

                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                          AND Ticket_Status__c =: 'Booked' 
                          AND (Name like : '%'+searchkey+'%' OR tkt_Profile__r.First_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Last_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Email__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Company__c like : '%'+searchkey+'%' OR tkt_profile__r.TKT_Job_Title__c like : '%'+searchkey+'%' OR tkt_profile__r.Mobile__c like : '%'+searchkey+'%' OR tkt_profile__r.Work_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Home_Phone__c like : '%'+searchkey+'%' OR tkt_profile__r.Gender__c like : '%'+searchkey+'%' OR item_type__r.Name like : '%'+searchkey+'%' OR Item_Pool__r.Item_Type__r.Name like : '%'+searchkey+'%' OR Order__r.Name like : '%'+searchkey+'%' OR tkt_profile__r.Company_Website_URL__c like : '%'+searchkey+'%' OR tkt_profile__r.Primary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Secondary_Business_Category__c like : '%'+searchkey+'%' OR tkt_profile__r.Tax_Id__c like : '%'+searchkey+'%' OR Custom_Barcode__c like : '%'+searchkey+'%' )
                          Order By Order__r.CreatedDate ASC];
        }
        return ticketsList;
    }
    
    
    
    
    
    
    //booked tickets for specific evet(Getting attendee surveye question answers for both badgable and non badgable items)
    public LIST<Ticket__c> eventBookedTickets(String EventId){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT event__c,Ticket_Display_Order__c,ID,order__r.NAME,Order__r.BLN_TKT_Profile__r.Last_Name__c,Order__r.BLN_TKT_Profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c,Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name,Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c, item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                          //(SELECT Id,Item_Question__r.Item_Pool__c,uanswer_text_update__c, Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answers__r ORDER BY Item_Question__r.Question__r.Question_Order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked' order by order__r.createddate desc];
            return ticketsList;
    }
    
    
    
    //for search key in server side pagination
     public LIST<Ticket__c> eventBookedTickets(String EventId, String searchKey){
        
         set<id> uticid=new set<id>();
         for(user_answer__c u : [select id,name,ticket__r.id from user_answer__c where ticket__r.event__c=:EventId and ticket__r.order__r.order_status__c!='Cancelled' and ticket__r.order__r.order_status__c!='Abandoned' and ticket__r.ticket_status__c='Booked' and item_question__r.question_level__c !='Lead Retrieval']){
             uticid.add(u.ticket__r.id);
         }
         system.debug('DDDDD::'+uticid.size());
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT event__c,Ticket_Display_Order__c,ID,order__r.NAME,Order__r.BLN_TKT_Profile__r.Last_Name__c,Order__r.BLN_TKT_Profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c,Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name,Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c, item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                          (SELECT Id,ticket__r.id,Item_Question__r.Item_Pool__c,uanswer_text_update__c, Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answers__r  ORDER BY Item_Question__r.Question__r.Question_Order__c asc),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE id in : uticid 
                          AND (Name like : '%'+searchkey+'%' OR item_pool__r.item_pool_name__c like : '%'+searchkey+'%' OR item__r.item_name__c like : '%'+searchkey+'%' OR tkt_Profile__r.First_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Last_Name__c like : '%'+searchkey+'%' OR tkt_profile__r.Mobile__c like : '%'+searchkey+'%' OR tkt_profile__r.Email__c like : '%'+searchkey+'%' OR Order__r.Name like : '%'+searchkey+'%' )
                          order by order__r.createddate desc];
                         system.debug('DDDDD11::'+ticketsList.size());
            return ticketsList;
    }
    
  //booked tickets for refresh update 
  public LIST<Ticket__c> eventBookedTickets(String EventId,DateTime LastmodiFieddateFromMobile){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT event__c,Ticket_Display_Order__c,ID,order__r.NAME,Order__r.bln_tkt_profile__r.Last_Name__c,Order__r.bln_tkt_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c,Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c,LastModifiedDate, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c, item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                        (SELECT Id,Item_Question__r.Item_Pool__c,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name,LastModifiedDate, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c,Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answers__r WHERE LastModifiedDate>:LastmodiFieddateFromMobile ORDER BY Item_Question__r.Question__r.Question_Order__c asc),
                        //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId 
                          AND (LastModifiedDate>:LastmodiFieddateFromMobile or tkt_Profile__r.LastModifiedDate>:LastmodiFieddateFromMobile)
                          AND Ticket_Status__c =: 'Booked'];
            return ticketsList;
    }
  
    public LIST<Ticket__c> SupplySurveyInfoForEachQuestion(String EventId,String questionID){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT ID,event__C,tkt_profile__r.BLN_GN_User__c,order__r.NAME,Order__r.bln_tkt_profile__r.Last_Name__c,Order__r.bln_tkt_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, tkt_profile__c, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,  tkt_profile__r.id,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name, 
                          //(SELECT Id,ticket__r.tkt_profile__r.First_Name__c,ticket__r.tkt_profile__r.Last_Name__c,uanswer_text_update__c,Item_Question__r.Item_Pool__c,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c,Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,ticket__r.tkt_profile__r.id,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answers__r WHERE item_question__r.question__c= : questionID ORDER BY Item_Question__r.Question__r.Question_Order__c ASC),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'];
            return ticketsList;
    }
    
    //For server side search in survey by question response
    public LIST<Ticket__c> SupplySurveyInfoForEachQuestion(String EventId,String questionID, String searchKey){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT ID,event__C,tkt_profile__r.BLN_GN_User__c,order__r.NAME,Order__r.bln_tkt_profile__r.Last_Name__c,Order__r.bln_tkt_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, tkt_profile__c, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,  tkt_profile__r.id,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name, 
                          //(SELECT Id,ticket__r.tkt_profile__r.First_Name__c,ticket__r.tkt_profile__r.Last_Name__c,uanswer_text_update__c,Item_Question__r.Item_Pool__c,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c,Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,ticket__r.tkt_profile__r.id,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answers__r WHERE item_question__r.question__c= : questionID ORDER BY Item_Question__r.Question__r.Question_Order__c ASC),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'
                          AND (tkt_profile__r.First_Name__c Like: '%'+searchKey+'%' OR tkt_profile__r.Last_Name__c Like: '%'+searchKey+'%' OR item__r.item_Name__c Like: '%'+searchKey+'%')
                          ];
            return ticketsList;
    }
    
    public LIST<Ticket__c> SupplySurveyInfoForEachQuestionForXprint(String EventId,set<id> questionID){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT ID,event__c,order__r.NAME,Order__r.bln_tkt_profile__r.Last_Name__c,Order__r.bln_tkt_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c,Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, tkt_profile__c,Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,tkt_profile__r.id, item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,
                          (SELECT Id,uanswer_text_update__c,ticket__r.tkt_Profile__r.first_name__c,ticket__r.tkt_Profile__r.last_name__c,Item_Question__r.Item_Pool__c,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c,Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,ticket__r.tkt_profile__r.id,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name,item_question__r.event__c,ticket__r.item_pool__c FROM User_Answers__r WHERE item_question__r.question__c in : questionID ORDER BY Item_Question__r.Question__r.Question_Order__c ASC),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'];
            return ticketsList;
    }
    
    //For exporting survey report ticket level questions and answers
    public LIST<Ticket__c> eventBookedTicketsForTicketLevelQuestions(String EventId){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT ID,order__r.NAME,Order__r.bln_tkt_profile__r.Last_Name__c,Order__r.bln_tkt_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c, item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,tkt_profile__r.Id,  
                          (SELECT Id,ticket__r.tkt_profile__r.bln_gn_user__c,ticket__r.tkt_profile__r.bln_gn_user__r.id,Item_Question__r.Item_Pool__c,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c,Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,ticket__r.tkt_profile__r.id,Item_Question__r.Question__r.Question_Order__c FROM User_Answers__r WHERE Item_Question__r.Question_Level__c='Ticket Level' ORDER BY Item_Question__r.Question__r.Question_Order__c ASC),
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,tkt_profile__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c,tkt_profile__r.BLN_GN_User__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c =: 'Booked'];
            return ticketsList;
    }
    
    public LIST<Ticket__c> ticketsListWithDates(String EventId, String SearchString, DateTime FromDate, DateTime ToDate){
        
        system.debug(EventId+'  FROM DATEEEEEEEEEEE   '+SearchString);
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        if(SearchString == NULL && (FromDate != NULL && ToDate != NULL)){
            ticketsList= [SELECT ID, Name, order__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId 
                          AND Ticket_Status__c !=: 'Available'
                          AND Order__r.CreatedDate >=: FromDate
                          AND Order__r.CreatedDate <=: ToDate];
           
        }else if(SearchString != NULL && (FromDate == NULL && ToDate == NULL)){
            ticketsList= [SELECT ID, Name, order__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId 
                          AND Ticket_Status__c !=: 'Available'
                          AND (Order__r.name LIKE : '%'+SearchString+'%' OR tkt_profile__r.First_Name__c Like: '%'+SearchString+'%' OR tkt_profile__r.Last_Name__c Like: '%'+SearchString+'%' OR tkt_profile__r.Email__c Like: '%'+SearchString+'%' OR tkt_profile__r.TKT_Company__c Like: '%'+SearchString+'%' OR item__r.item_Name__c Like: '%'+SearchString+'%')];

        
        }else if(SearchString != NULL && (FromDate != NULL && ToDate != NULL)){
            ticketsList=[SELECT ID, Name, order__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId 
                          AND Ticket_Status__c !=: 'Available'
                          AND Order__r.CreatedDate >=: FromDate
                          AND Order__r.CreatedDate <=: ToDate           
                          AND (Order__r.name LIKE : '%'+SearchString+'%' OR tkt_profile__r.First_Name__c Like: '%'+SearchString+'%' OR tkt_profile__r.Last_Name__c Like: '%'+SearchString+'%' OR tkt_profile__r.Email__c Like: '%'+SearchString+'%' OR tkt_profile__r.TKT_Company__c Like: '%'+SearchString+'%' OR item__r.item_Name__c Like: '%'+SearchString+'%')];

        }else{
            ticketsList= [SELECT ID, Name, order__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,  
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId
                          AND Ticket_Status__c !=: 'Available']; 
        }
        
        
        return ticketsList;
    }
    
    // All Booked Tickets For An Event     
     public LIST<Ticket__c> bookedTicketsForEvent(String selectedEvent){
        LIST<Ticket__c> bookedTickets= new LIST<Ticket__c>();
        bookedTickets= [SELECT Id,event__c, Tstatus_Id__r.Tstatus_name__c,item__r.id,Tstatus_Id__c,(SELECT Id,Item_Question__r.Item__c ,Item_Question__r.Question_Level__c,Item_Question__r.Question__r.Answer_Type__c,UAnswer_Text__c FROM User_Answers__r),
                           //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                           
                           FROM Ticket__c 
                           WHERE Ticket_Status__c =: 'Booked' 
                           AND Event__c =: selectedEvent];
                           System.debug('QQQ111:::'+bookedTickets.size()); 
        Set<ID> itdsIDSet=new set<ID>();
        for(ticket__c tt : bookedTickets){
            for(User_Answer__c ua : tt.User_Answers__r){
                if(ua.Item_Question__r.Question_Level__c== 'Event Level'){
                    itdsIDSet.add(tt.id);    
                }
            }
        } 
        
        LIST<Ticket__c> bookedTickets1= new LIST<Ticket__c>();
        bookedTickets1= [SELECT Id,item__r.id,tkt_Profile__r.id, Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,(SELECT Id,Item_Question__r.Question__r.Answer_Type__c,item_question__r.question_level__c FROM User_Answers__r),
                           
                           //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                           FROM Ticket__c 
                           WHERE id in : itdsIDSet
                           AND Ticket_Status__c =: 'Booked'];
          System.debug('QQQ2222:::'+bookedTickets1.size());                 
        return bookedTickets1;
    }
    
    
     // All Booked Tickets for printing both event and ticket level    
     public LIST<Ticket__c> bookedTicketsForEventForPrintExport(String selectedEvent){
        LIST<Ticket__c> bookedTickets= new LIST<Ticket__c>();
        bookedTickets= [SELECT Id, event__c,Tstatus_Id__r.Tstatus_name__c,item__r.id,Tstatus_Id__c,(SELECT Id,Item_Question__r.Item__c ,Item_Question__r.Question_Level__c,Item_Question__r.Question__r.Answer_Type__c FROM User_Answers__r),
                           //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                           
                           FROM Ticket__c 
                           WHERE Ticket_Status__c =: 'Booked' 
                           AND Event__c =: selectedEvent];
                           System.debug('QQQ111:::'+bookedTickets.size());                   
        return bookedTickets;
    }
    
    // All Booked Tickets For An Item     
     public LIST<Ticket__c> bookedTicketsForItem(String itemId){
        LIST<Ticket__c> bookedTickets= new LIST<Ticket__c>();
        bookedTickets= [SELECT Id,event__c, Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,(SELECT Id,UAnswer_Text__c,Item_Question__r.Question__r.Answer_Type__c FROM User_Answers__r),
                           //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                           FROM Ticket__c 
                           WHERE item__c =: itemId
                           AND Ticket_Status__c =: 'Booked'];
        //bookedTickets= Integer.valueOf(bookedAggrResult[0].get('expr0'));
        system.debug(itemId+'   '+bookedTickets.size()+'   AGGREGATE RESULT '+bookedTickets);                   
        return bookedTickets;
    }
    
     // All Booked Tickets For An Itempool 
    
     public LIST<Ticket__c> bookedTicketsForItemPool(String itemPoolId){
        LIST<Ticket__c> bookedTicketsforItemPool= new LIST<Ticket__c>();
        bookedTicketsforItemPool= [SELECT Id,event__c, Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,(SELECT Id,Item_Question__r.Question__r.Answer_Type__c FROM User_Answers__r),
                           //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                           
                           FROM Ticket__c 
                           WHERE item_pool__c =: itemPoolId
                           AND Ticket_Status__c =: 'Booked'];
        //bookedTickets= Integer.valueOf(bookedAggrResult[0].get('expr0'));
        system.debug(itemPoolId+'   '+bookedTicketsforItemPool.size()+'   AGGREGATE RESULT '+bookedTicketsforItemPool);                   
        return bookedTicketsforItemPool;
    }
    
  
    public List<Ticket__c> gettlist(String selectedeventid) {
           List<Ticket__c> tlist  = new List<Ticket__c>();
           
           RETURN tlist  = [SELECT Item_Pool__r.Item_Type__r.Name,Item_Type__r.Name,Order__r.Order_Status__c,
                           //TKT_Profile Fields
                              tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                              tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                              tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                              tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                              tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                              tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                              tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                              //Home Address Fields
                              tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                              tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                              //Work Address Fields
                              tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                              tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                              //Shipping Address Fields
                              tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                              tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                              //Billing Address Fields
                              tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                              tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                       
                            FROM Ticket__c WHERE Event__c = :selectedeventid AND Ticket_Status__c='Booked'];
    
    }  
    
    // All ticket status used for TicketDetailsReport by Vineel 
    public LIST<Ticket__c> getTicketdetails(String EventId, Datetime FromDate, Datetime ToDate){
    LIST<Ticket__c> ShowticketDetail  = new LIST<Ticket__c>();
    ShowticketDetail = [select id,Item_pool__r.Item_type__r.Name,Item_pool__r.addon_parent__c,Item_Pool__r.Item_Pool_Name__c,Item__r.Item_Pool__r.Item_Pool_name__c,Name,Order__r.CreatedDate, Order__r.Name,Item__r.item_name__c,Item_type__r.Name,
                            Ticket_Status__c,Item_Pool__c,Ticket__c.Parent_ID__c,Item_Pool__r.Id,
                            //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,Event__r.Time_Zone__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                            
                             from Ticket__c WHERE Event__c =:EventId 
                            AND (Ticket_Status__c != 'Available' AND Ticket_Status__c != 'Deleted' AND Ticket_Status__c != 'Abandoned' AND Ticket_Status__c != 'Reserved')
                            AND Order__r.CreatedDate >=: FromDate 
                            AND Order__r.CreatedDate <=: ToDate 
                            ORDER BY Order__r.CreatedDate DESC];
    return ShowticketDetail  ;
    }
    
     // All ticket status used for TicketDetailsReport by Vineel 
    public LIST<Ticket__c> getTicketdetails(String EventId, Datetime FromDate, Datetime ToDate,string searchkey,String subwhere){
   // LIST<Ticket__c> ShowticketDetail  = new LIST<Ticket__c>();
    String ShowticketDetail = 'select id,Item_pool__r.Item_type__r.Name,Item_pool__r.addon_parent__c,Item_Pool__r.Item_Pool_Name__c,Item__r.Item_Pool__r.Item_Pool_name__c,Name,Order__r.CreatedDate, Order__r.Name,Item__r.item_name__c,Item_type__r.Name,'
                                +'Ticket_Status__c,Item_Pool__c,Ticket__c.Parent_ID__c,Item_Pool__r.Id,Event__r.Time_Zone__c,'
                            //TKT_Profile Fields
                                +'tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,'
                                +'tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,'   
                                +'tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,'
                                +'tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,'  
                                +'tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,'
                                +'tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,'  
                                +'tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,'
                          //Home Address Fields
                                +'tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,'
                                +'tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,'
                          //Work Address Fields
                                +'tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,'
                                +'tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,'
                          //Shipping Address Fields
                                +'tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,'
                                +'tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,'
                          //Billing Address Fields
                                +'tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,'
                                +'tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c'
                                +'from Ticket__c WHERE Event__c =: EventId'
                                + ' AND (Ticket_Status__c != \'Available\' AND Ticket_Status__c != \'Deleted\' AND Ticket_Status__c != \'Abandoned\' AND Ticket_Status__c != \'Reserved\')'
                                +' AND Order__r.CreatedDate >=:' +FromDate 
                                +'  AND Order__r.CreatedDate <=:'+ ToDate 
                                +' AND (Item_Type__r.Name !=\'Package\' OR (Item_Type__r.Name =\'Package\' AND Parent_ID__c!=null))'
                                +' AND (name like : \'%\'+searchkey+\'%\' OR Ticket_Status__c like : \'%\'+searchkey+\'%\' OR tkt_profile__r.TKT_Company__c like : \'%\'+searchkey+\'%\' OR tkt_profile__r.TKT_Job_Title__c like : \'%\'+searchkey+\'%\' OR tkt_profile__r.Email__c like : \'%\'+searchkey+\'%\' OR tkt_profile__r.Last_Name__c like : \'%\'+searchkey+\'%\' OR tkt_profile__r.First_Name__c like : \'%\'+searchkey+\'%\' OR Item_pool__r.Item_Type__r.Name like : \'%\'+searchkey+\'%\' OR Item_Type__r.Name like : \'%\'+searchkey+\'%\' OR Order__r.Name like : \'%\'+searchkey+\'%\' OR Item_Pool__r.Item_Pool_Name__c like : \'%\'+searchkey+\'%\' OR Item__r.Item_Pool__r.Item_Pool_Name__c like : \'%\'+searchkey+\'%\')'
                                +' ORDER BY Order__r.CreatedDate DESC';
                                
       
                                
    String quertstr = 'Select Item_Pool__r.Item_Pool_Name__c,Order__r.createddate,Order__r.Name,Event__r.Time_Zone__c,Item__r.item_name__c,Order_Item__r.Name,Order_Item__c,Item__r.Name,Item__c,Item_Type__r.Name,Parent_ID__c, Item_Pool__r.Badgable__c,Item_Pool__c,Item_Pool__r.Name,Ticket_Display_Order__c,Item_Pool__r.Item_Type__r.Name,LastModifiedDate,Badge_Label__c,Ticket_Status__c,id, Order__c ,Name, Custom_Barcode__c, Note__c, Tag_No__c, Scan_Id__c, tkt_profile__r.First_Name__c, Tkt_profile__r.Last_Name__c, Tkt_profile__r.Email__c, Tkt_profile__r.TKT_Company__c, Tkt_profile__r.Mobile__c,Item__r.Item_Type__r.Name,TKT_profile__r.TKT_Job_Title__c,TKT_profile__r.User_Pic__c,TKT_profile__r.FaceBookId__c,TKT_profile__r.LinkedInId__c,TKT_profile__r.TwitterId__c,TKT_profile__r.Biography__c,TKT_profile__r.Company_Description__c,TKT_profile__r.Company_Logo__c,TKT_profile__r.Company_Website_URL__c from Ticket__c where Event__c = : EventId and (Ticket_Status__c != \'Available\'  And Ticket_Status__c != \'Deleted\' AND Ticket_Status__c != \'Abandoned\' AND Ticket_Status__c != \'Reserved\'  AND (Item_Type__r.Name !=\'Package\' OR (Item_Type__r.Name =\'Package\' AND Parent_ID__c!=null))) ';
    
    if(searchkey!=''){
      quertstr+= ' AND (name like \'%'+searchkey+'%\' OR Ticket_Status__c like \'%'+searchkey+'%\' OR tkt_profile__r.TKT_Company__c like \'%'+searchkey+'%\' OR tkt_profile__r.TKT_Job_Title__c like \'%'+searchkey+'%\' OR tkt_profile__r.Email__c like \'%'+searchkey+'%\' OR tkt_profile__r.Last_Name__c like \'%'+searchkey+'%\' OR tkt_profile__r.First_Name__c like \'%'+searchkey+'%\' OR Item_pool__r.Item_Type__r.Name like \'%'+searchkey+'%\' OR Item_Type__r.Name like \'%'+searchkey+'%\' OR Order__r.Name like \'%'+searchkey+'%\' OR Item_Pool__r.Item_Pool_Name__c like \'%'+searchkey+'%\' OR Item__r.Item_Pool__r.Item_Pool_Name__c like \'%'+searchkey+'%\')';
      }
      if(FromDate  !=null && ToDate !=null){
       quertstr+=' AND ( Order__r.CreatedDate >='+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z AND Order__r.CreatedDate <='+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z)';
}
       if(subwhere !=null)
       {
       quertstr +=subwhere;
       } 
                            
                                      System.debug(quertstr );
                                 return DataBase.query(quertstr);
    }
    
    Public list<Ticket__c> orderedtickets(string selectedEvent)  {
    
                    return [select id ,
                        //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_profile__r.BLN_Company__r.id,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
    
     from Ticket__c where Event__c=: selectedEvent AND Ticket_Status__c !=:'Available'];
    }
    
    // to get event id by passing itemtid
   public string  getevntid(string itemtid){
   
   Ticket__c tktobj=new Ticket__c();
   tktobj = [SELECT ID, NAME,Event__c,Parent_ID__c,
           //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
   
    FROM Ticket__c  WHERE item__c =:itemtid limit 1];
   
   return tktobj.Event__c;
   }

   public List<Ticket__c> getTcFromPid(String pId){
     return [select id,Parent_ID__c,Ticket_Status__c,
         //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
      from Ticket__c where Parent_ID__c=:pId];
  } 

  public LIST<Ticket__c> eventBookedlistoftics(String EventId,set<id> setofticids){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
            ticketsList= [SELECT ID,order__r.NAME,Order__r.bln_tkt_profile__r.Last_Name__c,Order__r.bln_tkt_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c,Name, Tag_No__c,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, tkt_profile__c,Ticket_Status__c,LastModifiedDate, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c,  item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name, 
                          //TKT_Profile Fields
                          tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,
                          tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,
                          tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,
                          tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,
                          tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,
                          tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,
                          tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,
                          //Home Address Fields
                          tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,
                          tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,
                          //Work Address Fields
                          tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,
                          tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,
                          //Shipping Address Fields
                          tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,
                          tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,
                          //Billing Address Fields
                          tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,
                          tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c
                          
                          FROM Ticket__c 
                          WHERE Event__c =: EventId 
                          AND id IN:setofticids
                          AND Ticket_Status__c =: 'Booked'];
            return ticketsList;
    }

    public ticket__c checkTicketEventMapping(string eveId,string ticId){

        Ticket__c tic= new Ticket__c();
        tic=[SELECT id,tkt_profile__r.First_Name__c,tkt_Profile__r.Last_Name__c,Badge_Label__c from ticket__c where id= :ticId and event__c = :eveId];

        return tic;
    
    }
    
    public LIST<ticket__c> getUserTracks(string uid){
        LIST<ticket__c> ticlst = new LIST<ticket__c>();
        ticlst=[select id,item_pool__r.track__c,item__r.Payment__c from ticket__C where tkt_profile__r.BLN_GN_User__r.User__c = :uid];
        return ticlst;
    }
    
    public list<ticket__c> eventSeminarTickets(string eventid){
        LIST<ticket__c> ticlst = new LIST<ticket__c>();
        ticlst=[select id,item_pool__c,item_pool__r.Item_Pool_Name__c,item_pool__r.track__c,item__r.Payment__c,tkt_profile__r.BLN_GN_User__r.User__c from ticket__c where event__c = :eventid and Item_Pool__r.Item_Type__r.Name='Seminars' and Ticket_Status__c = 'Booked'];
        return ticlst;
    }
    
    public List<ticket__c> getEddata(String eventId,String queryStr,dateTime lmDate){
    system.debug('queryStr========'+queryStr);
       String str = 'Select Badge_ID__c,(SELECT LastModifiedDate, Ticket_ID__c, id, Display_Order__c, Logo_Size__c, Sponsorship_Category__c from BLN_Sponsorships__r),Item_Pool__r.Item_Pool_Name__c,Item__r.Item_Pool__r.Badgable__c,Item__r.item_name__c,Order_Item__r.Name,Order_Item__c,Item__r.Name,Item__c,Item_Type__r.Name,Parent_ID__c, Item_Pool__r.Badgable__c,Item_Pool__c,Item_Pool__r.Name,Ticket_Display_Order__c,Item_Pool__r.Item_Type__r.Name,LastModifiedDate,Badge_Label__c,Ticket_Status__c,id, Order__c ,Name, Custom_Barcode__c, Note__c, Tag_No__c, Scan_Id__c, tkt_profile__r.First_Name__c, Tkt_profile__r.Last_Name__c, Tkt_profile__r.Email__c, Tkt_profile__r.TKT_Company__c, Tkt_profile__r.Mobile__c,Item__r.Item_Type__r.Name,TKT_profile__r.TKT_Job_Title__c,TKT_profile__r.User_Pic__c,TKT_profile__r.FaceBookId__c,TKT_profile__r.LinkedInId__c,TKT_profile__r.TwitterId__c,TKT_profile__r.Biography__c,TKT_profile__r.Company_Description__c,TKT_profile__r.Blogger__c,TKT_profile__r.Blog_URL__c ,TKT_profile__r.Company_Logo__c,TKT_profile__r.Company_Website_URL__c,TKT_profile__r.Video__c from Ticket__c where Event__c = : eventid and (Ticket_Status__c =\'Booked\' OR Ticket_Status__c = \'Cancelled\')';
        if(queryStr!='')
         str+=queryStr;
        system.debug('Query String values '+str);  
       return DataBase.query(str);
    }

    public ticket__c getcustombarcode(String badgeid,string eventId){
   list< ticket__c> lict=[SELECT Id,Event__c,Tkt_profile__r.Work_Address__r.City__c,Tkt_profile__r.Work_Address__r.Country__c,Tkt_profile__r.Work_Address__r.State__c,Tkt_profile__r.Work_Address__r.Address1__c,Tkt_profile__r.Work_Address__r.Address2__c,Tkt_profile__r.Work_Phone__c,Tkt_profile__r.Work_Address__r.Zipcode__c,tkt_profile__r.Email__c,tkt_profile__r.TKT_Company__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Prefix__c,tkt_profile__r.Home_Phone__c,tkt_profile__r.Suffix__c,tkt_profile__r.Mobile__c,Ticket_Status__c,tkt_profile__r.User_Pic__c,tkt_profile__r.TKT_Job_Title__c,Tkt_profile__r.BLN_Company__c from Ticket__c WHERE (Custom_Barcode__c=:badgeid Or Scan_Id__c=:badgeid) and event__c =:eventId];
  if(lict.size()>0){
    return lict[0];
    }return null;
    
    }
    public list<ticket__c> getcustombarcodesyc(list<string> BarcodeIds, String eventId){
    system.debug('BarcodeIds========='+BarcodeIds);
    system.debug('eventId======='+eventId);
      list< ticket__c> lict=[SELECT Id,Event__c,Tstatus_Id__c,Tstatus_Id__r.Tstatus_name__c,Scan_Id__c,Tkt_profile__r.Work_Address__r.City__c,Tkt_profile__r.Work_Address__r.Country__c,Tkt_profile__r.Work_Address__r.State__c,Tkt_profile__r.Work_Address__r.Address1__c,Tkt_profile__r.Work_Address__r.Address2__c,Tkt_profile__r.Work_Phone__c,Tkt_profile__r.Work_Address__r.Zipcode__c,tkt_profile__r.Email__c,tkt_profile__r.TKT_Company__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Prefix__c,tkt_profile__r.Home_Phone__c,tkt_profile__r.Suffix__c,tkt_profile__r.Mobile__c,Ticket_Status__c,tkt_profile__r.User_Pic__c,tkt_profile__r.TKT_Job_Title__c,Tkt_profile__r.BLN_Company__c,Custom_Barcode__c,Badge_ID__c from Ticket__c WHERE  Event__c=:eventId AND Ticket_Status__c='Booked' AND (Custom_Barcode__c IN:BarcodeIds OR Badge_ID__c IN :BarcodeIds OR Scan_Id__c IN :BarcodeIds)];
    return lict;
    }
    public list<ticket__c> getAllbadges(String eventId){
    return [SELECT Badge_ID__c,Scan_Id__c,Custom_Barcode__c  from Ticket__c WHERE  Event__c=:eventId AND Ticket_Status__c='Booked'];
    }
    public Integer getTicketsQuan(String uId,String eId,String itemType){
        Integer buyQuan =  0;
        for(AggregateResult agrr : [SELECT count(id) cn from Ticket__c WHERE  Event__c=:eId AND Ticket_Status__c='Booked' AND Tkt_profile__r.BLN_GN_User__r.User__c=:uId AND Item_Type__r.Name=:itemType GROUP BY Item_Type__c]){
           buyQuan =integer.valueof(agrr.get('cn'));
        }
       return buyQuan; 
    }
public set<string> getAllitemtypes(String eventId){
   set<string> tickettype = new set<string>();
  for(Ticket__c r:[SELECT Id,Event__c,Item_type__r.Name  from Ticket__c WHERE  Event__c=:eventId AND Ticket_Status__c='Booked' AND order__r.order_status__c!='Cancelled' and order__r.order_status__c!='Abandoned' ])
  {
  tickettype.add(r.Item_type__r.Name);
  }
  return tickettype;
    }

     public List<Ticket__c> getTickets(SET<String> notinIds,String eve,String itemType){
   return [SELECT tkt_profile__r.BLN_GN_User__c, Id, Order__c, Order__r.Name, Name, tkt_profile__r.First_Name__c, tkt_profile__r.Last_Name__c, tkt_profile__r.Email__c, tkt_profile__r.TKT_Company__c, tkt_profile__c FROM Ticket__c WHERE EVent__c = :eve AND tkt_profile__r.Email__c NOT IN :notinIds AND  Item_Type__r.Name = :itemType AND Ticket_Status__c = 'Booked'];
  }
 
  public List<Ticket__c> getuserTickets(SET<String> notinIds,String eve,String itemType){
   return [SELECT tkt_profile__r.BLN_GN_User__c, Id, Order__c, Order__r.Name, Name, tkt_profile__r.First_Name__c, tkt_profile__r.Last_Name__c, tkt_profile__r.Email__c, tkt_profile__r.TKT_Company__c, tkt_profile__c FROM Ticket__c WHERE EVent__c = :eve AND tkt_profile__r.Email__c NOT IN :notinIds AND  Item_Type__r.Name = :itemType AND Ticket_Status__c = 'Booked' AND Order__r.BLN_TKT_profile__r.EMail__c=:userInfo.getUserName()];
  }

  public List<Ticket__c> getuserTickets(SET<String> notinIds,String eve,String itemType,String searcgstr){
    return [SELECT tkt_profile__r.BLN_GN_User__c, Id, Order__c, Order__r.Name, Name, tkt_profile__r.First_Name__c, tkt_profile__r.Last_Name__c, tkt_profile__r.Email__c, tkt_profile__r.TKT_Company__c, tkt_profile__c FROM Ticket__c WHERE EVent__c = :eve AND tkt_profile__r.Email__c NOT IN :notinIds AND  Item_Type__r.Name = :itemType AND Ticket_Status__c = 'Booked' AND Order__r.BLN_TKT_profile__r.EMail__c=:userInfo.getUserName()];
  }
  
}
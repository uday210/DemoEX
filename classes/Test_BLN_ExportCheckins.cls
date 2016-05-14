@isTest
private class Test_BLN_ExportCheckins{

    static testMethod void Testmethod_BLN_ExportCheckins() {
   User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
           
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 

            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);

            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;


            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
   
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
      
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
     
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
    
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            list<BLN_Item__c>  itemli = new list<BLN_Item__c>();   
            itemli.add(item);
        
    
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);

            tstatus__c tstat=new tstatus__c ();
            tstat = globalTest.createTstatus(ticket.id);
            tstat.scan_time__c = system.now();
            update tstat;
    
            BLN_Scanusr_item__c si=new BLN_Scanusr_item__c();
            si.BLN_Event__c=eventInfo.id;
            si.BLN_GN_User__c=gnUser.id;
            si.BLN_Item_Pool__c=ItemPool.id;
            si.Status__c='Active';
            insert si;
   
         
         string query1='Select Event__r.Time_Zone__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,'
            +'tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,'
            +'order_item__r.Item_Quantity__c,Order__r.BLN_TKT_Profile__r.Mobile__c,Order__r.BLN_TKT_Profile__c,'
            +'Order__r.BLN_TKT_Profile__r.Email__c,Order__r.BLN_TKT_Profile__r.First_Name__c,Order__r.BLN_TKT_Profile__r.Last_Name__c,'
            +'(select id,name,Tstatus_name__c,Ticket__r.Item_type__r.Name,Ticket__r.tkt_profile__r.First_Name__c,Ticket__r.tkt_profile__r.Last_Name__c,LastModifiedDate,Owner.Name,'
            +'Device_Name__c,scan_time__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,'
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
              //+'Tstatus__r.scan_time__c'
            +'  From Ticket__c t ';
          BLN_ExportCheckins bes= new BLN_ExportCheckins(query1,'Attendee','America/New_York','Registration Type',eventInfo.id,'');
         BLN_ExportCheckins bes1= new BLN_ExportCheckins(query1,'Ticket','America/New_York','Registration Type',eventInfo.id,'');
         
         
        Database.QueryLocator QL;
        Database.BatchableContext BC;
          
          database.executebatch(bes,90);
          database.executebatch(bes1,90);
           
        }
         
         
    
    
    
    
    
    
    
    
    }
    
    
}
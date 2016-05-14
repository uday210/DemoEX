public without sharing class globalForTestClass{

    /**
        * @author : Manasa Gandham
        * @date 10/11/2014
        * @ This class is used for Code Coverage of all Test Classes
    */ 
    //public string fullUrl{get;set;}
     public  string  fullUrl=Site.getBaseUrl(); 
     public String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    
    public User createUser(){
    
         //Account acc= new Account(Name='Globalnest');
         //insert acc;
         
         //contact con = new contact(firstname='testcontactfn',lastname='testcontactln',AccountId=acc.id);
         //insert con;
         Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         // ------------------ Eventadmin Insert ---------------------

         User u = new User(alias = 'salesf', email='iamasalesforcedev401@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='iamasalesforcedev401@noemail.com');
         insert u;
         return u;     
         
    }
    
    public BLN_Event__c createEvent(id countryId, Id stateId, Id companyId){
    
        BLN_Event__c insertEvent= new BLN_Event__c();
        insertEvent.Name= 'myevent';
        insertEvent.Start_Date__c= system.today();
        insertEvent.End_Date__c= system.today()+4; 
        //insertEvent.Start_Time__c= '7:00 AM';
        //insertEvent.End_Time__c= '4:00 PM'; 
        insertEvent.venue_name__c= 'Hyderabad';
        insertEvent.Organizer_Email__c= 'manasatest@gmail.com';
        insertEvent.organizer_id__c= companyId;
        insertEvent.BLN_State__c= stateId;
        insertEvent.BLN_Country__c= countryId;
        insertEvent.Logo_URL__c = '015c0000000IAj8';
        insertEvent.Event_Ticket_Options__c='Collect info from Buyers only';
        
        insert insertEvent;      
        return insertEvent;
        
    }
    
    public Item_Pool__c createItemPool(Id eventId, Id itemTypeId, Id itemPoolId, Id trackId){
        
        Item_Pool__c insertItemPool= new Item_Pool__c();
        
        //BLN_Event__c insertEvent= new BLN_Event__c();
        //insertEvent= createEvent();  
        
        //Item_Type__c insertItemType= new Item_Type__c();
        //insertItemType= createItemType();
               
        insertItemPool.Event__c= eventId;
        insertItemPool.Item_Pool_Name__c= 'ItemPool';
        insertItemPool.item_type__c= itemTypeId;
        insertItemPool.Item_Count__c= 12;
        insertItemPool.Addon_Parent__c= itemPoolId;
        insertItemPool.Track__c= trackId;
        insertItemPool.Addon_Count__c= 4;
        insert insertItemPool;
        
        return insertItemPool;
    }
    
    public BLN_Item__c createItem(Id itemPoolId, Id itemTypeId, Id eventId){
        
        //Item_Pool__c insertItemPool= new Item_Pool__c();
        //insertItemPool= createItemPool();
        
        //Item_Type__c insertItemType= new Item_Type__c();
        //insertItemType= createItemType();
       
        
        BLN_Item__c insertItem= new BLN_Item__c();
        insertItem.item_name__c= 'testItem';
        insertItem.Item_Pool__c= itemPoolId;
        insertItem.item_type__c= itemTypeId;
        insertItem.Event__c= eventId;
        insertItem.price__c= 22.50;
        insertItem.Payment__c= 'Paid';
        insertItem.item_count__c= 10;
        insertItem.Taxable__c = false;
        insertItem.sale_start__c=System.today();
        insertItem.sale_end__c=System.today()+2;
        
        insert insertItem;
        return insertItem;
    }
    
    public Item_Type__c createItemType(){
    
        Item_Type__c insertItemType= new Item_Type__c();
        insertItemType.Name= 'Package';
        insertItemType.Badge_Label__c= 'BadgeLabel';
        insertItemType.Order__c= 22.12;
        insertItemType.Add_On__c= TRUE;
        insertItemType.Unlimited__c=false;
        
        insert insertItemType;
        
        return insertItemType;
    }    
    
    
    
     public Item_Type__c createItemType12(){
    
        Item_Type__c insertItemType= new Item_Type__c();
        insertItemType.Name= 'Seminars';
        insertItemType.Badge_Label__c= 'BadgeLabel';
        insertItemType.Order__c= 22.12;
        insertItemType.Add_On__c= TRUE;
        insertItemType.Unlimited__c=false;
        
        insert insertItemType;
        
        return insertItemType;
    }    
    
    public Item_Type__c createItemType13(){
    
        Item_Type__c insertItemType= new Item_Type__c();
        insertItemType.Name= 'Lead Retrieval';
        insertItemType.Badge_Label__c= 'BadgeLabel';
        insertItemType.Order__c= 22.12;
        insertItemType.Add_On__c= TRUE;
        insertItemType.Unlimited__c=false;
        
        insert insertItemType;
        
        return insertItemType;
    }    
    
    public Item_Type__c createItemType15(){
    
        Item_Type__c insertItemType= new Item_Type__c();
        insertItemType.Name= 'Exhibitor';
        insertItemType.Badge_Label__c= 'BadgeLabel';
        insertItemType.Order__c= 22.12;
        insertItemType.Add_On__c= TRUE;
        insertItemType.Unlimited__c=false;
        
        insert insertItemType;
        
        return insertItemType;
    }    
    
    public User createUserForGNUser(){
        
         Account acc= new Account(Name='Globalnest');
         insert acc;
         
        contact con = new contact(firstname='gn',lastname='user',AccountId=acc.id);
        insert con;
        Profile p = [select id from profile where name='Event Admin'];
        //userRole r=[SELECT ID FROM userRole WHERE name =: 'Custom Role'];   userRoleId= r.id,
        User insertUser= new User(alias = 'Indain', email='hegotthelogic@gfcforce.com', firstname= 'fngn', Phone= '9878654345',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnuser', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest',
                                  timezonesidkey='America/Los_Angeles', username='hegotthelogic@gfcforce.com', Title= 'SFDC Developer');
        insert insertUser;
        return insertUser;        
    }    
    
    public GN_User__c createGNUser(User userInfo, Id CountryId, Id stateId){
        
        GN_User__c insertGNUser= new GN_User__c();
        
        //User insertUser= new User();
        //insertUser= createUserForGNUser();
        
        insertGNUser.User__c= userInfo.Id;
        //insertGNUser.Company_Name__c= userInfo.CompanyName;
        insertGNUser.Email__c= userInfo.email;
        insertGNUser.First_Name__c= userInfo.firstname;
        insertGNUser.Last_Name__c= userInfo.lastname;
        insertGNUser.Home_Phone__c= userInfo.Phone;
        //insertGNUser.Title__c= userInfo.Title;
        //insertGNUser.Country__c= CountryId;
        //insertGNUser.State__c= stateId;
        
        insert insertGNUser;
        return insertGNUser;
        
    }
    
    public Company__c createCompany(String compName){
        
        Company__c insertCompany= new Company__c();
        insertCompany.Name= compName;        
        insert insertCompany;
        
        return insertCompany;
    }
    
    public Company_Ext__c createCompanyExt(Id companyId, Id primaryNaicsId, Id secondaryNaicsId, Id countryId, Id stateId){
        Company_Ext__c insertCompanyExt= new Company_Ext__c();
        insertCompanyExt.Company__c= companyId;
        insertCompanyExt.Primary_NAICS_Code__c= primaryNaicsId;
        insertCompanyExt.Secondary_NAICS_Code__c= secondaryNaicsId;
        insertCompanyExt.BLN_Business_Country__c= countryId;
        insertCompanyExt.BLN_Business_State__c= stateId;
        
        insert insertCompanyExt;
        return insertCompanyExt;
        
    }
    
    
    
    public Promotion__c createPromotion(Id eventId, String promotionName, String promotionType, String discountType){
              
        Promotion__c insertPromotion= new Promotion__c();        
         
        //BLN_Event__c insertEvent= new BLN_Event__c();
        //insertEvent= createEvent();      
       
        insertPromotion.Name= promotionName;
        insertPromotion.Promo_Code__c= 'BASIC-0001';
        insertPromotion.Event__c= eventId;
        insertPromotion.Eff_TimeStamp__c= system.today();
        insertPromotion.Exp_TimeStamp__c= system.today()+2;
        insertPromotion.Discount_Value__c = 8;
        insertPromotion.Discount_Type__c= discountType;
        insertPromotion.Promotion_Type__c= promotionType;
        insertPromotion.Status__c= 'Active and Enable for online registrations';
        insertPromotion.Type__c= 'Promo code';
        
        insert insertPromotion;
        return insertPromotion;
        
    }
    
    public Item_Promotion__c createItemPromotion(Id itemId, Id itemPromotionId, String itemDiscType){
        
        Item_Promotion__c insertItemPromotion= new Item_Promotion__c();
        
        //Promotion__c insertPromotion= new Promotion__c();
        //insertPromotion= createPromotion();
        
        //BLN_Item__c insertItem= new BLN_Item__c();
        //insertItem= createItem();
       
        insertItemPromotion.Buy_Item__c= itemId;
        insertItemPromotion.Buy_Item_Quantity__c= 2;
        insertItemPromotion.Item_Discount_Type__c= itemDiscType;
        insertItemPromotion.Item_Discount_Value__c= 10;
        insertItemPromotion.Free_Item__c= itemId;
        insertItemPromotion.Free_Item_Quantity__c= 4;
        insertItemPromotion.Promotion__c= itemPromotionId;
        
        insert insertItemPromotion;
        return insertItemPromotion;
        
    }
    
    
    public Order_Item__c createOrderItem(Id itemId, Id orderId, Id promotionId, Id currencyId){
        
        Order_Item__c insertOrderItem= new Order_Item__c();
        
        //Item_Promotion__c insertItemPromotion= new Item_Promotion__c();
        //insertItemPromotion= createItemPromotion();
        
        //Order__c insertOrder= new Order__c();
        //insertOrder= createOrder();     
           
        insertOrderItem.Item__c= itemId;
        insertOrderItem.Order__c= orderId;
        insertOrderItem.Promotion__c= promotionId;
        insertOrderItem.Item_Discount__c= 10;
        insertOrderItem.Item_Price__c= 20;
        insertOrderItem.Item_Quantity__c= 2;
        insertOrderItem.Item_Total__c= 2;
        insertOrderItem.Status__c= 'Active';
        insertOrderItem.Currency__c= currencyId;
        
        insert insertOrderItem;
        return insertOrderItem;
        
    }
    
    
    public Tkt_profile__c createTktprofile(User userInfo){
        
        Tkt_profile__c insertTktprofile= new Tkt_profile__c();
        
       
        insertTktprofile.First_Name__c= 'testfname';
        insertTktprofile.Last_Name__c= 'testlname';
        insertTktprofile.Email__c= userInfo.email;
        insertTktprofile.TKT_Job_Title__c= userInfo.Title;
        
        insert insertTktprofile;
        return insertTktprofile;
        
    }
    
    public Ticket__c createTicket(Id eventId, Id itemId, Id itemPoolId, Id itemTypeId, Id orderId,id GNuserid){
        
        Ticket__c insertTicket= new Ticket__c();        
        
        //Order_Item__c insertOrderItem= new Order_Item__c();  
        //insertOrderItem= createOrderItem();
              
        //BLN_Item__c insertItem= new BLN_Item__c();
        //insertItem= createItem();
                        
        insertTicket.Event__c = eventId;
        insertTicket.Item__c = itemId;
        insertTicket.Item_Pool__c = itemPoolId;
        insertTicket.Item_Type__c = itemTypeId;                    
        insertTicket.Badge_Label__c =  'badgeLabel';
        insertTicket.Order__c= orderId;
        insertTicket.Ticket_Status__c= 'Booked';
        insertTicket.tkt_profile__c = GNuserid;
        insertTicket.Tstatus_Id__c=null;
        
        
        insert insertTicket;
        
        system.debug('*********'+InsertTicket.Name);
        return insertTicket;
    }
    
    //inserting ticket with tkt profile changes
    public Ticket__c createTicketwithtktProfile(Id eventId, Id itemId, Id itemPoolId, Id itemTypeId, Id orderId,id tktprofileId){
        
        Ticket__c insertTicket= new Ticket__c();        
        
        //Order_Item__c insertOrderItem= new Order_Item__c();  
        //insertOrderItem= createOrderItem();
              
        //BLN_Item__c insertItem= new BLN_Item__c();
        //insertItem= createItem();
                        
        insertTicket.Event__c = eventId;
        insertTicket.Item__c = itemId;
        insertTicket.Item_Pool__c = itemPoolId;
        insertTicket.Item_Type__c = itemTypeId;                    
        insertTicket.Badge_Label__c =  'badgeLabel';
        insertTicket.Order__c= orderId;
        insertTicket.Ticket_Status__c= 'Booked';
        insertTicket.tkt_profile__c = tktprofileId;
        insertTicket.Tstatus_Id__c=null;
        
        
        insert insertTicket;
        
        system.debug('*********'+InsertTicket.Name);
        return insertTicket;
    }
    
    public Currency__c createCurrency(){
        
        Currency__c insertCurrency= new Currency__c();
        insertCurrency.Name= 'USD';
        insertCurrency.Currency_Name__c= 'US Dollar';
        insertCurrency.Currency_Symbol__c= '$';
        
        insert insertCurrency;
        return insertCurrency;
    }
    
    public Order__c createOrder(Id gnUserId, Id userId, Id compId, Id eventId, Id currencyId){
        
        Order__c insertOrder= new Order__c();
        
        //insertOrder.bln_tkt_profile__r.bln_gn_user__c= gnUserId;
        //insertOrder.bln_tkt_profile__r.bln_company__c= compId;
        //insertOrder.bln_tkt_profile__r.bln_gn_user__r.user__c= userId;
        insertOrder.bln_tkt_profile__c=gnUserId;
        insertOrder.Events__c= eventId;
        insertOrder.Order_Total__c= 2;
        insertOrder.Order_Status__c= 'Fully Paid';
        insertOrder.Amount_Paid__c= 25.12;
        insertOrder.Fee_Amount__c= 23.29;
        insertOrder.Currency_Code__c= currencyId;
        
        insert insertOrder;      

        return insertOrder;        
        
    }
    
    public BLN_Room__c createRoom(Id eventId){
    
        BLN_Room__c insertRoom= new BLN_Room__c();
        insertRoom.Name= 'New Room';
        insertRoom.Event__c= eventId;
        insertRoom.Room_Number__c= 'Room-0001';
        insert insertRoom;
        
        return insertRoom;
        
    }
    
    public Agenda__c createAgenda(Id eventId, Id trackId){
        
        Agenda__c insertAgenda= new Agenda__c();
        insertAgenda.Event__c= eventId;
        insertAgenda.BLN_Track__c= trackId;
        insertAgenda.Agenda_Type__c= 'Event level Agenda';
        insertAgenda.Agenda_Description__c= 'It is for test';
        
        insert insertAgenda;
        return insertAgenda;
        
    }
    
    public BLN_Track__c createTrack(Id eventId){
    
        BLN_Track__c insertTrack= new BLN_Track__c();
        insertTrack.name= 'New Track';
        insertTrack.Event__c= eventId;
        
        insert insertTrack;        
        return insertTrack;
    }
    
    public Participant__c createParticipant(Id userId, Id timeSlotId){
    
        Participant__c insertParticipant= new Participant__c();
       // insertParticipant.Ext_ID__c= 'PARTICIPANT-1';
        //insertParticipant.GN_User__c= userId;
        //nsertParticipant.Participant_Role__c= 'Speaker';
        insertParticipant.Time_Slot__c= timeSlotId;
        
        insert insertParticipant;
        return insertParticipant;
    }
    
    public Time_Slots__c createTimeSlot(Id agendaId, Id roomId){
        
        Time_Slots__c insertTimeSlot= new Time_Slots__c();
        insertTimeSlot.Agenda__c= agendaId;
        insertTimeSlot.Room__c= roomId;
        insertTimeSlot.Slot_Start_date__c= system.today();
        insertTimeSlot.Slot_End_date__c= system.today()+2;
        
        insert insertTimeSlot;
        return insertTimeSlot;
    }
    
    public Hash_Tag__c createHashTag(Id eventId){
    
        Hash_Tag__c HashTag = new Hash_Tag__c ();
        HashTag.Event__c = eventId;
        HashTag.Tag_Text__c = 'SPONSOR';
        
        insert HashTag;
        return HashTag;

    }
    /*public ItemPool_Tag_Junction__c createtagjunction(Id itemPoolId, Id HashTagId){
    
    ItemPool_Tag_Junction__c Tagjunction = new ItemPool_Tag_Junction__c ();
    Tagjunction.Pool_Id__c = itemPoolId;
    Tagjunction.Tag_Id__c = HashTagId;
    
    insert Tagjunction;
    return Tagjunction;
    
    }*/
    
    public Role__c createRole(){
        Role__c insertRole= new Role__c();
        insertRole.name= 'Company Admin';
        insertRole.Role_ShortName__c= 'CA';
        insert insertRole;
        return insertrole;
    }
    
    public UC_Role__c createUCRole(Id companyId, Id eventId, Id gnUserId, Id userId, Id roleId){
        
        UC_Role__c insertUCRole= new UC_Role__c();
        insertUCRole.Company__c= companyId;
        insertUCRole.Event__c= eventId;
       // insertUCRole.Role__c= 'Company Admin';
        insertUCRole.RoleId__c= roleId;
        insertUCRole.GN_User__c= gnUserId;
        //insertUCRole.User__c= userId;
        
        insert insertUCRole;
        return insertUCRole;
    }
    
    public Country__c createCountry(Id currencyId){
        Country__c insertCountry= new Country__c();
        insertCountry.Long_Name__c = 'United States Of America';
        insertCountry.Short_Name__c= 'US';
        insertCountry.Currency__c= currencyId;
        insertCountry.Order__c= 123;
        insert insertCountry;
        return insertCountry;
    }
    
    public State__c createState(Id countryId){
        State__c insertState= new State__c();
        insertState.Country__c= countryId;
        insertState.Long_Name__c= 'Andhra Pradesh';
        insertState.Order__c= 123;
        insertState.Short_Name__c= 'AP';
        
        insert insertState;
        return insertState;
    }
    
    public NAICS_Code__c createNaicsCode(){
        NAICS_Code__c insertNaicsCode= new NAICS_Code__c();
        insertNaicsCode.Name= 'Naics Code1';
        insertNaicsCode.Description__c= 'Naics Desc';
        
        insert insertNaicsCode;        
        return insertNaicsCode;
    }
    
    
    public Pay_Address__c createPayAddress(Id companyId, Id eventId, Id countryId){
        
        Pay_Address__c insertPayAddress= new Pay_Address__c();
        insertPayAddress.City__c= 'Hyderabad';
        insertPayAddress.Company__c= companyId;
        insertPayAddress.Event__c= eventId;
        insertPayAddress.BLN_Country__c= countryId;
        
        insert insertPayAddress;
        return insertPayAddress;
    }
    
    
    public Reg_Setting__c createRegSettings(Id eventId, Id itemPoolId, Id itemId, Id companyId, Id tagId, String settingType, String columnName){
    
        Reg_Setting__c insertRegSettings= new Reg_Setting__c();
        insertRegSettings.Event__c= eventId;
        insertRegSettings.Setting_Type__c= settingType;
        insertRegSettings.Group_Name__c= 'Basic Information'; 
        insertRegSettings.Item__c= itemId;
        insertRegSettings.Item_Pool__c= itemPoolId;
        insertRegSettings.Organizer__c= companyId;
        insertRegSettings.Tag_Id__c= tagId;
        insertRegSettings.Column_Name__c= columnName;
        insertRegSettings.Table_Name__c= 'insertItemType';
        
        insert insertRegSettings;
        return insertRegSettings;
    }
    
    public Hash_Tag__c createTag(Id eventId){
    
        Hash_Tag__c inserttag= new Hash_Tag__c();
        inserttag.Event__c= eventId;
        inserttag.RowId__c= 'Row1';
        inserttag.Table_Name__c= 'Tab01';
        inserttag.Tag_Text__c= 'Exhibitor';
        
        insert insertTag;        
        return insertTag;
    }
    
    public Question__c createQuestion(Id eventId){
        Question__c insertQue=new Question__c();
        insertQue.Event__c= eventId;
        insertQue.Question_Text__c= 'Who are you?' ;
        insertQue.Answer_Type__c='Text' ;
        insertQue.Question_Order__c=1 ;
    
        insert insertQue;
        return insertQue;
    }

    public Item_Question__c createItemQuestion(Id eventId, Id itemId, Id questionId){
        Item_Question__c insertItemQue=new Item_Question__c();
        insertItemQue.Event__c= eventId;
        insertItemQue.Item__c= itemId;
        insertItemQue.Question__c= questionId;
        insertItemQue.Question_Level__c='Event Level' ;
        insertItemQue.isRequired__c= True;
        insertItemQue.Visibility__c= True;
    
        insert insertItemQue;
        return insertItemQue;
    }
    
    public BLN_Answer__c createAnswer(Id questionId){
        BLN_Answer__c insertAns=new BLN_Answer__c();
        insertAns.BLN_Question__c= questionId;
        insertAns.Answer_Text__c= 'Yes I agree' ;
        insertAns.Answer_Order__c=1 ;
        insertAns.Answer_Default__c=True ;
    
        insert insertAns;
        return insertAns;
    }
    
    public User_Answer__c createUserAnswer(Id userId,Id itemQueId,Id answerId){
        User_Answer__c insertUsrAns=new User_Answer__c();
        insertUsrAns.UAnswer_Text__c= 'TP Answer';
        //insertUsrAns.User__c= userId ;
        insertUsrAns.Item_Question__c=itemQueId;
        insertUsrAns.BLN_Answer__c=answerId;
    
        insert insertUsrAns;
        return insertUsrAns;
    }
    
    public EmailCampaign__c createEmailCampaign(BLN_Event__c EventInfo){
    
        EmailCampaign__c insertEmailCampaign= new EmailCampaign__c();
        insertEmailCampaign.Name =  'Lead Retrieval Sign Up Reminder';
        //insertEmailCampaign.CampEmailTemplate__c= et.CampEmailTemplate__c;
        insertEmailCampaign.CampFromEmailId__c =EventInfo.Organizer_Email__c;
        insertEmailCampaign.CampSubject__c  = 'Lead Retrieval Sign Up Reminder';
        insertEmailCampaign.Event__c=EventInfo.Id;
        insertEmailCampaign.Available_to_Use__c = true;
        insertEmailCampaign.Template_Type__c = 'Standard';
        insertEmailCampaign.CampType__c = 'Reminder';
        insertEmailCampaign.ToListType__c='Selected Contacts';
        insertEmailCampaign.System_Template_Type__c='TempType';
        insertEmailCampaign.Product_Type__c = 'Lead Retrieval';
        
        insert insertEmailCampaign;
        return insertEmailCampaign;    
     }
     
     public Event_Price__c createEventPrice(Id EventId, Id ItemTypeId){
         
         Event_Price__c insertEventPrice= new Event_Price__c();
         //insertEventPrice.Name='EP-000005';
         insertEventPrice.BL_Fee_Amount__c= 15.00;
         insertEventPrice.BL_Fee_Level__c= 'E - Event';
         insertEventPrice.BL_Fee_Percentage__c= 25.00;
         insertEventPrice.Event__c= eventId;
         insertEventPrice.Item_Count__c= 50;
         insertEventPrice.Item_type__c= ItemTypeId;
         insertEventPrice.Active_Flag__c=true;
         //insertEventPrice.Item_Type__r.Name='Lead Retrieval';
         //insertEventPrice.Item_type__r.Item_Type_Number__c='IT-000003';
         
         
         insert insertEventPrice;
         return insertEventPrice;
     }
     
     public Registration_Template__c createRegistrationTemplate(){
         Registration_Template__c insertRegistrationTemplate= new Registration_Template__c();
         insertRegistrationTemplate.Name='Grey';
         insertRegistrationTemplate.Header_Image_URL__c= '';
         insertRegistrationTemplate.Order__c= 1;
         insertRegistrationTemplate.Styles__c='width:250px;';
         insertRegistrationTemplate.Template_Image_URL__c= sfbaseURL;
         
         insert insertRegistrationTemplate;
         return insertRegistrationTemplate;
     }
    
    //Written by Thirupathi Pattipaka 
    public BLN_BadgeTemplate_Styles__c createBadgeTemplateStyle(Id eventId){
        BLN_BadgeTemplate_Styles__c insertBadTempStyle=new BLN_BadgeTemplate_Styles__c();
        insertBadTempStyle.Name='badge1';
        insertBadTempStyle.BadgeName__c='{"name":"badge1","width":360,"height":288,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAEqAXIDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC1LIsSbmzj2qH7bF/tflS33/HufqKgtbeOWIs2c5xwaAJvtsX+1+VH22L/AGvyo+xw+/50fY4ff86AD7bF/tflUsUyzAlM8etVri1jjhZlzke9O0//AFb/AFoAsu4jQs3QU2KZZgSmePWm3R/0d/pVCGd4gQmOfUUAXmu4lYqd2QcdKfFMk2dmePWs6MebcDf/ABHnFaEMKRZ2Z59TQA17uJHKnOR7U37bF/tflVV1D3pU9C2KtfYof9r86AD7bF/tflR9ti/2vyo+xw+/50fYof8Aa/OgBReRMwA3ZPHSrFZboI7ravQMK1KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo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C7ccetWKKAIVjYW3l8Z24plrbvCzFiOR2qzRQBTktXa58wEYyDVyiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigCs/32+tFD/fb60UAWaKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigCs/wB9vrRQ/wB9vrRQBZooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAGPKkZ+YkfgaQzIBk7gB/sH/CmXf+qH+8Kf5sZIUMrE8YBzQA8HIzS1EzlJETaNrcA5pTIRMqFRhhwc0AAmQy+WDlh19qBMhl8sHLDr7Uw/8AH6v+5/Wg/wDH6v8Auf1oAmJwM01JUdiqn5h1BGKfVaWNjI0kf31xj39qAJ3dUGWzj2BNKrBhkZx7jFReaJbZmHocj0p8kmwDjJY4AoAfRUSykyFHXDAZ4Ocimi4LhtkTEg4weKAJ6Kg+0ExB0jLDvzjH+NSeYCqsOd3QUAPoqISnzPLdQpIyMHIP8qloAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAKz/fb60UP99vrRQBZooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAILs4iX/AHhUxAOPbmkaNGOWRSfUilVQowoAHoBQBDcELJCzHADdfwpskqfaYiDkcjI5qwyhhhgCPQ0BQMYA44FAEJ/4/V/3P60H/j9X/c/rUhjQtuKLn1xQY0Lbii59cUAPpin94/4U+mCONTlUUH1AoAr3CNEWkjHysMMP61LM2GjUAZY8MR0/+vUpGRg9KGVWGGAI9CKAKwKre4LZOzHJ70+D/WTf79ShFGMKOBgcUgijHSNRn2oAig/49W/4FUZwIIHYbkH3hjNWfKjwRsXB7YpVRVBCqAD2AoAjTySw8tUJ9VA4qamqqoMKoUewp1ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUU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"},';
        insertBadTempStyle.Event__c=eventId;
        insertBadTempStyle.FirstRowElement__c='[{"id":"cqrcd","height":125,"width":125,"positionTop":0,"positionLeft":0,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(fullurl+/resource/1403783597000/qrcodelogoimage)"}]';
        insertBadTempStyle.SecondElement__c='[{"id":"cfulln","height":31,"width":349,"line-height":31,"position":"absolute","positionTop":144,"positionLeft":13,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"28px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Full Name","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
        insertBadTempStyle.ThirdElement__c='[{"id":"cticketn","height":40,"width":224,"line-height":40,"position":"absolute","positionTop":36,"positionLeft":138,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"37px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Ticket Name","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
        insertBadTempStyle.FourthElement__c='[{"id":"cticketCategory","height":42,"width":352,"line-height":42,"position":"absolute","positionTop":192,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"26px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Ticket Category","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
        insertBadTempStyle.FifthElement__c='[{"id":"cjobTitle","height":42,"width":352,"line-height":42,"position":"absolute","positionTop":245,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"26px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Job Title","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
        
        insert insertBadTempStyle;
        return insertBadTempStyle; 
    }
    
    //Written by Thirupathi Pattipaka 
    public Badge__c createBadge(Id ticketId){
        Badge__c  insertBadge=new Badge__c ();
        
        DateTime myDateTime = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
        DateTime newDateTime = myDateTime.addHours(3);
        
        insertBadge.Eff_time__c=myDateTime ;
        insertBadge.Exp_time__c=newDateTime ;
        insertBadge.ticket_id__c=ticketId;
        
        insert insertBadge;
        return insertBadge; 
    }
    
    //Written by Deepthi Kollu 
    public booth_map__c createBoothmap(Id ticketId){
        booth_map__c bmap=new booth_map__c();
        bmap.Ticket_id__c=ticketId;
        bmap.Booth_Number__c='test';
        
        insert bmap;
        return bmap; 
    }
    
    //Written by Deepthi Kollu 
    public tstatus__c createTstatus(Id ticketId){
        tstatus__c tstat=new tstatus__c ();
        tstat.Ticket__c=ticketId;
        tstat.Tstatus_name__c=true;
        
        insert tstat;
        return tstat; 
    }
    
    //INSERTING COMPANY NAICS CODES BY VINEEl 
    public Company_Naicscodes__c createCompanyNaicsCodes(Id companyId, Id gnUserId, Id NaicscodesId, String Uniquestring){
        Company_Naicscodes__c compnaicscode = new Company_Naicscodes__c();
        compnaicscode.BLN_Company__c = companyId;
        //compnaicscode.BLN_GN_User__c = gnUserId;
        compnaicscode.BLN_NAICS_Code__c = NaicscodesId;
        
        insert compnaicscode;
        return compnaicscode; 
    }
    
    public BLN_Address__c createaddress (String Address1, String Address2, String City, Id CountryId, Id StateId, String ZipperCode) {
        BLN_Address__c tktaddress = new BLN_Address__c();
        tktaddress.Address1__c = Address1;
        tktaddress.Address2__c = Address2;
        tktaddress.City__c = City;
        tktaddress.Country__c = CountryId;
        tktaddress.State__c = StateId;
        tktaddress.ZipCode__c = ZipperCode;
        
    
   
        insert tktaddress;
        return tktaddress;
    }
   
}
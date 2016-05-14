public with sharing class SA_ManageProfileController{
    public User EventUser{get;set;}
    public SA_ManageProfileController(){
        EventUser = [SELECT Id,Alias,States__c,Country__c,FirstName,LastName,UserName,Email,CompanyAddr2__c,
                     CompanyCity__c,companyName,CompanyAddr1__c ,CompanyCountry__c,Companyphone__c,CompanyState__c,
                     Company_website__c,Zipcode__c,CompanyFaxNumber__c,PoBox__c, Title 
                     FROM User 
                     WHERE Id = :UserInfo.getUserId()];
    }
    
    public PageReference SaveProfile(){
        try{       
            EventUser.FirstName = EventUser.FirstName;
            EventUser.LastName= EventUser.LastName;
            EventUser.Email = EventUser.Email;
            EventUser.CompanyAddr2__c = EventUser.CompanyAddr2__c;
            EventUser.CompanyAddr1__c = EventUser.CompanyAddr1__c ;   
            EventUser.Companyphone__c = EventUser.Companyphone__c;    
            EventUser.Title = EventUser.Title;    
            EventUser.Country__c = EventUser.Country__c;
            EventUser.States__c = EventUser.States__c;
            EventUser.Company_website__c = EventUser.Company_website__c;
            EventUser.Zipcode__c = EventUser.Zipcode__c;
            EventUser.CompanyFaxNumber__c = EventUser.CompanyFaxNumber__c;
            EventUser.PoBox__c = EventUser.PoBox__c ;
            EventUser.CompanyName = EventUser.CompanyName;
            
            update EventUser; 
            
            AttendeeSummary__c UpdatingAttendee= new AttendeeSummary__c();
            UpdatingAttendee= [SELECT As_FirstName__c,AS_LastName__c, AS_WorkPhone__c, AS_Company__c, AS_WorkAddress1__c,  
                               AS_Title__c, AS_WorkCity__c, AS_Work_Country__c, AS_Work_States__c, AS_WorkZip__c, AS_WorkAddress2__c
                               FROM AttendeeSummary__c 
                               WHERE AS_Email__c=:EventUser.Email];
            
            UpdatingAttendee.AS_FirstName__c= EventUser.FirstName; 
            UpdatingAttendee.AS_LastName__c= EventUser.LastName;
            UpdatingAttendee.AS_Company__c= EventUser.CompanyName;
            UpdatingAttendee.AS_WorkPhone__c= EventUser.Companyphone__c;
            UpdatingAttendee.AS_Title__c= EventUser.Title;
            UpdatingAttendee.AS_WorkAddress1__c= EventUser.CompanyAddr1__c;
            UpdatingAttendee.AS_WorkAddress2__c= EventUser.CompanyAddr2__c;            
            UpdatingAttendee.AS_WorkCity__c= EventUser.CompanyCity__c;
            UpdatingAttendee.AS_Work_States__c= EventUser.States__c;
            UpdatingAttendee.AS_Work_Country__c= EventUser.Country__c;   
            UpdatingAttendee.AS_WorkZip__c= EventUser.Zipcode__c;                                    
            UpdatingAttendee.AS_uniqueField__c=(EventUser.FirstName+EventUser.LastName+EventUser.Email).tolowercase();
            
            Update UpdatingAttendee;
        
        }
        catch(Exception ex){
        }   
        PageReference pg=new PageReference('/apex/SA_ManageEvents');
        pg.setRedirect(true);
        return pg;
    } 
    
    
    public PageReference checkUserId() {
        if (userInfo.getUserType() == 'guest') {
            Pagereference pg = new pagereference('/SA_Signup');
            pg.setredirect(true);
            return pg;
        }else {
            return null;
        }
    }
    
}
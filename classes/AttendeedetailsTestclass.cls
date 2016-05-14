@isTest
private class AttendeedetailsTestclass {

static testMethod void myUnitTest() {
Profile p = [select id FROM profile where name='Standard User'];
        
        User u = new User(alias = 'test123', email='mallikarjunan+user7489@globalnest.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='mallikarjunan+user7489@globalnest.com');
                  
                  insert u;
                  
                  Event__c event = new Event__c(EV_Title__c='testEvent',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 22806 easy peal square Badges',EventDiversityValues__c='Reception;monday pass');
                insert event;
                  string fieldsOf = 'AS_Age__c,isUpdated__c,AS_BirthDate__c,AS_BlogUrl__c,AS_BusinessDescription__c,AS_BusinessDunsNumber__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_CellPhone__c,AS_Company__c,AS_DiversityType__c,Registration_type__c,AS_Email__c,AS_FaxNumber__c,AS_FirstName__c,AS_Gender__c,AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,AS_HomeCountry__c,AS_HomePhone__c,AS_HomePoBox__c,AS_HomeZip__c,AS_ImageUrl__c,AS_LastName__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_NumberOfEmployees__c,AS_PrefixNew__c,AS_PrimaryBusinessCategory1__c,AS_SecondaryBusinessCategory1__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingCountry__c,AS_ShippingPhone__c,AS_shippingzip__c,AS_ShippingState__c,AS_ShippingZipcode__c,AS_SuffixNew__c,AS_ThroughEventBrite__c,AS_Title__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkCountry__c,AS_WorkPhone__c,AS_WorkPoBox__c,AS_Work_Country__c,AS_WorkZip__c,AS_Work_States__c,As_Home_Country__c,As_Home_State__c,As_Shipping_Country__c,As_Shipping_States__c';
                 SecurityControls__c  attsett = new SecurityControls__c(EV_id__c = event.id, EV_Fields__c = fieldsOf);
                 insert attsett; 
                 
                  AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        insert att;  
        
        
                 
                   Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=event.id); 
        insert eam;
        
        ApexPages.currentPage().getParameters().put('id',eam.id );
                  system.runAs(u){
      
          attendeedetail detail  = new attendeedetail ();
          
         
          
          detail.checkUserId(); 
               

      
      
      }
    
                  
                  

}



}
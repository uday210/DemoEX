public with sharing class BL_EventsList_DAO{    
    
    public LIST<Event__c> GetAllEvents(){
        list<Event__c> Events = [ SELECT Id, Name, Accept_Pay_at_the_Door_Payments__c, Accept_Pay_by_Check_Payments__c, 
                                      Accept_Send_an_Invoice_Payments__c, Attendee_Tags__c, Attendee_can_send_request__c, 
                                      Attendee_Types__c, Available__c, Badge_Name__c, BoothLeads_Fee__c, BreakTime_Between_Appointments__c, 
                                      CCRDetails_Required__c, EV_ContactURL__c, EV_CustomReg__c, EV_Description__c, Email_Notifications_flag__c, 
                                      Enable_Scan_To_ATT__c, Enable_Scan_To_BA__c, EV_EndDate__c, EV_EndTime__c, Event_ZipCode__c, EventDiversityValues__c, 
                                      EV_EventLogo__c, Event_PostalCode__c, Event_Printer__c, Event_Type__c, Exhibitor_can_send_request__c, FacebookId__c, 
                                      Fee_Type__c, Floor_Map_Image__c, EV_HistingAddr1__c, EV_HostedByEventBrite__c, AS_HostingAddr2__c, AS_HostingCity__c, 
                                      EV_HostingCountry__c, EV_HostingCountryNew__c, EV_HostingFax__c, EV_HostingLocation__c, EV_HostingOrgName__c, 
                                      EV_HostingPhone__c, EV_HostingPostalCode__c, EV_HostingState__c, EV_HostingStateNew__c, EV_HostingTimeZone__c, 
                                      EV_HostingZipcode__c, EV_IncludedFields__c, isActive__c, Is_Approval_Required__c, Is_For_Testing__c, Is_MatchMaking_Event__c, 
                                      IsRegistration__c, Is_Webank_event__c, Lable_First_Line__c, Lable_First_Line_Color__c, Lable_First_Line_Font__c, 
                                      Lable_First_Line_Size__c, Lable_Secoend_Line__c, Lable_Secoend_Line_Color__c, Lable_Secoend_Line_Font__c, 
                                      Lable_Secoend_Line_Size__c, Lable_Third_Line__c, Lable_Third_Line_Color__c, Lable_Third_Line_Font__c, 
                                      Lable_Third_Line_Size__c, Match_Making_Schedules__c, MatchMaking_Type__c, Maximum_slots_allowed__c, 
                                      MM_Slot_Timeperiod__c, MM_End_Date__c, MM_End_Time__c, MM_Firstaday_EndTime__c, MM_Firstaday_startTime__c, 
                                      MM_no_of_days__c, MM_Secondaday_EndTime__c, MM_Secondaday_startTime__c, MM_Start_Date__c, MM_Start_Time__c, 
                                      Need_FloorMap__c, No_Appointments_Per_Attendee__c, OrganizerId__c, Paypal_Password__c, Paypal_Email__c, 
                                      Paypal_Username__c, Primary__c, EV_Publish__c, EV_QuickReg__c, Quickregfields__c, Quickreqfields__c, EV_RedirectURI__c, 
                                      Registration_Back_End_Color__c, Registration_Colors__c, Registration_Email_flag__c, Registration_Front_End_Color__c, 
                                      ReportRecords__c, Ev_RequiredFields__c, Reserved__c, Sales_Tax__c, scan_attendee_limit__c, SecondaryCategory__c, 
                                      Session_Time__c, ShowAgain__c, Signature__c, EV_SiteLocation__c, Sold__c, EV_StartDate__c, StartTime__c, Status__c, 
                                      Through_Paypal__c, EV_Title__c, TwitterHashTag__c, TwitterId__c, Type_Of_registration_allow__c, EV_WebsiteURL__c
                                      FROM Event__c where is_Live_Event__c=true order by EV_StartDate__c];
                                      
        system.debug('Events-------------'+Events);
        return Events;
    }
}
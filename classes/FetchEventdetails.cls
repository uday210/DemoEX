public without sharing  class FetchEventdetails{
  public Event__c evedetails(string eid){
     return [Select e.scan_attendee_limit__c, e.isActive__c, e.Type_Of_registration_allow__c, e.TwitterId__c, e.TwitterHashTag__c, 
             		e.Through_Paypal__c, e.SystemModstamp, 
             		e.Status__c, e.StartTime__c, e.Sold__c, e.Signature__c, e.ShowAgain__c, e.Session_Time__c, e.SecondaryCategory__c, 
             		e.Sales_Tax__c, e.Reserved__c, e.ReportRecords__c, e.Registration_Front_End_Color__c, e.Registration_Email_flag__c, 
             		e.Registration_Colors__c, e.Registration_Back_End_Color__c, e.Quickreqfields__c, e.Quickregfields__c, e.Primary__c, 
             		e.Paypal_Username__c, e.Paypal_Password__c, e.Paypal_Email__c, e.OwnerId, e.OrganizerId__c, 
             		e.No_Appointments_Per_Attendee__c, e.Need_FloorMap__c, e.Name, e.Maximum_slots_allowed__c, e.Match_Making_Schedules__c, 
             		e.MatchMaking_Type__c, e.MM_no_of_days__c, e.MM_Start_Time__c, e.MM_Start_Date__c, e.MM_Slot_Timeperiod__c, 
             		e.MM_Secondaday_startTime__c, e.MM_Secondaday_EndTime__c, e.MM_Firstaday_startTime__c, e.MM_Firstaday_EndTime__c, 
             		e.MM_End_Time__c, e.MM_End_Date__c, e.LastViewedDate, e.LastReferencedDate, e.LastModifiedDate, e.LastModifiedById, 
             		e.LastActivityDate, e.Lable_Third_Line__c, e.Lable_Third_Line_Size__c, e.Lable_Third_Line_Font__c, 
             		e.Lable_Third_Line_Color__c, e.Lable_Secoend_Line__c, e.Lable_Secoend_Line_Size__c, e.Lable_Secoend_Line_Font__c, 
             		e.Lable_Secoend_Line_Color__c, e.Lable_First_Line__c, e.Lable_First_Line_Size__c, e.Lable_First_Line_Font__c, 
             		e.Lable_First_Line_Color__c, e.Is_Webank_event__c, e.Is_MatchMaking_Event__c, e.Is_For_Testing__c, 
             		e.Is_Approval_Required__c, e.IsRegistration__c, e.IsDeleted, e.Id, e.Floor_Map_Image__c, e.Fee_Type__c, 
             		e.FacebookId__c, e.Exhibitor_can_send_request__c, e.Event_ZipCode__c, e.Event_Type__c, e.Event_Printer__c, 
             		e.Event_PostalCode__c, e.EventDiversityValues__c, e.Ev_RequiredFields__c, e.Enable_Scan_To_BA__c, 
             		e.Enable_Scan_To_ATT__c, e.Email_Notifications_flag__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, 
             		e.EV_SiteLocation__c, e.EV_RedirectURI__c, e.EV_QuickReg__c, e.EV_Publish__c, e.EV_IncludedFields__c, 
             		e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, e.EV_HostingState__c, e.EV_HostingStateNew__c, 
             		e.EV_HostingPostalCode__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, 
             		e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, 
             		e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.EV_CustomReg__c, 
             		e.EV_ContactURL__c, e.CreatedDate, e.CreatedById, e.CCRDetails_Required__c, e.BreakTime_Between_Appointments__c, 
             		e.BoothLeads_Fee__c, e.Badge_Name__c, e.Available__c, e.Attendee_can_send_request__c, e.Attendee_Types__c, 
             		e.Attendee_Tags__c, e.Accept_Send_an_Invoice_Payments__c, e.Accept_Pay_by_Check_Payments__c, 
             		e.Accept_Pay_at_the_Door_Payments__c,e.AS_HostingCity__c, e.AS_HostingAddr2__c,
                    e.Stop_Schedule_for_Mobile__c
                     From Event__c e where id=:eid];
  }
}
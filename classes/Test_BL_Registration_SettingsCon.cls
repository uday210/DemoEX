@istest
public class Test_BL_Registration_SettingsCon{
    static testmethod void TestmethodRS() {
           
       Event__c eve = new Event__c(EV_Title__c='Global Event',Enable_Scan_To_ATT__c=true,EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',Session_Time__c='10');
      insert eve;
      Id EventId=eve.Id;
    
    
     TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Sales_Start_Date__c=date.valueOf('2018-01-01 09:09:09'),Sales_End_Date__c=date.valueOf('2080-01-01 09:09:09'));
     insert tic;
    
    Event_Registration_jun__c eam = new Event_Registration_jun__c(Event__c=eve.id,Setting_Type__c='Collect information below for each attendee');
    insert eam;
    Registration_Settings__c ressetting = new Registration_Settings__c(TicketTypes__c=tic.id,EventRegistration__c=eam.id);
    insert ressetting ;
    
    PageREference pg = page.BL_Registration_setting;
    Test.SetcurrentPage(pg);
    Apexpages.CurrentPage().getParameters().PUT('Id',eve.id);
    BL_Registration_SettingsCon res = new BL_Registration_SettingsCon();
    
    res.Save();
    res.event.Enable_Scan_To_BA__c =true;
    res.event.Enable_Scan_To_ATT__c =true;
    res.saveScan();
    res.event.Session_Time__c ='20';
    res.saveSession();
    res.SelectedRegSetting = 'Collect information below for the ticket buyer only';
     res.OnchnageAction();
     res.Save();
    
    
    
    }

}
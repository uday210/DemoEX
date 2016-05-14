trigger ReportCreation on User_Profile_Event__c (after insert, after  update) {

public Reports__c BoothAdminReports {get; set;}
public Reports__c EventAdminReports {get; set;}
public list<Reports__c> ReportIds{get; set;}
public list<Reports__c> UpdateReportIds{get; set;}


if (Trigger.isAfter && Trigger.isInsert) {
ReportIds =new list<Reports__c> ();
list<User_Profile_Event__c> ListIds=trigger.new;
system.debug('~~~~~~~~~~~~~OUT SIDE Trigger~~~~~~~~~~~~~~'+ListIds);
list<User_Profile_Event__c> UpeIds=[select id,Profile_id__r.PR_Name__c from User_Profile_Event__c where id IN: ListIds];
system.debug('~~~~~~~~~~~~~OUT SIDE Trigger~~~~~~~~~~~~~~'+UpeIds);

if(UpeIds.size()  != 0)
{
system.debug('11111111111111111111111111111111'+UpeIds);
for(User_Profile_Event__c UPS:UpeIds) 
{
system.debug('222222222222222222222222222222'+UPS);

if((Ups.Profile_id__r.PR_Name__c == 'EventAdmin')|| (Ups.Profile_id__r.PR_Name__c == 'EventAdmin Staff')) 
             {
system.debug('444444444444444444444444444444'+Ups.Profile_id__r.PR_Name__c);
                system.debug('_-----------inside IF------------'+UPS.Profile_id__c);
                
                               
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Industry';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                
                
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Geography';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                
                
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Business Revenue';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                
                
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Ticket Types';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                
                
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Diversity Certification';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                
                
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Registartions by Date';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                
                EventAdminReports= new Reports__c();
                EventAdminReports.RE_Name__c ='Report By Booth Admin Scans';
                EventAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(EventAdminReports);
                               
                
                system.debug('RRRRRRRRRRRRRRRRRR'+ReportIds);
                }
                

 
if((Ups.Profile_id__r.PR_Name__c == 'BoothPersonnel') || (Ups.Profile_id__r.PR_Name__c == 'Attendee'))
{
system.debug('55555555555555555555555555555'+Ups.Profile_id__r.PR_Name__c);

                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Industry';
                BoothAdminReports.UPE_id__c=UPS.id;
                system.debug('1111111111111111111'+BoothAdminReports);
                ReportIds.add(BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Geography';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports); 
                system.debug('22222222222222222'+BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Lead Rating';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports);
                system.debug('33333333333333333'+BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Booth User Scans';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports);
                system.debug('44444444444444'+BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Hourly Scans';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports);
                system.debug('5555555555555555'+BoothAdminReports);
                
               
                system.debug('RRRRRRRRRRRRRRRRRR'+ReportIds);

                

}
if(Ups.Profile_id__r.PR_Name__c == 'BoothAdmin')
{
system.debug('6666666666666666666666666666'+Ups.Profile_id__r.PR_Name__c);


                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Industry';
                BoothAdminReports.UPE_id__c=UPS.id;
                system.debug('1111111111111111111'+BoothAdminReports);
                ReportIds.add(BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Geography';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports); 
                system.debug('22222222222222222'+BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Lead Rating';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports);
                system.debug('33333333333333333'+BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Booth Admin and Booth User Scans';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports);
                system.debug('44444444444444'+BoothAdminReports);
                
                BoothAdminReports= new Reports__c();
                BoothAdminReports.RE_Name__c ='Report By Hourly Scans';
                BoothAdminReports.UPE_id__c=UPS.id;
                ReportIds.add(BoothAdminReports);
                system.debug('5555555555555555'+BoothAdminReports);
                
               
                system.debug('RRRRRRRRRRRRRRRRRR'+ReportIds);

                }
      }     
      insert ReportIds;     
} 

}

if(Trigger.isAfter && Trigger.isUpdate) {
system.debug('11111111111111111111111111111');
UpdateReportIds= new list<Reports__c> ();
list<User_Profile_Event__c> ListIds=trigger.new;
list<User_Profile_Event__c> UpeIds=[select id,Profile_id__r.PR_Name__c from User_Profile_Event__c where id IN: ListIds];
system.debug('222222222222222222222'+UpeIds);
list<Reports__c> report=[select id,RE_Name__c,UPE_id__r.Profile_id__r.PR_Name__c from Reports__c where RE_Name__c='Report By Booth User Scans'  
                   and UPE_id__c IN : UpeIds];
  system.debug('33333333333333333333333'+report);                 
 for(Reports__c R:report)
            {
            system.debug('444444444444444444444'+R); 
            if(R.UPE_id__r.Profile_id__r.PR_Name__c== 'BoothAdmin')
            {  
            
         R.RE_Name__c = 'Report By Booth Admin and Booth User Scans';
         system.debug('5555555555555555555555555'+R);  
         UpdateReportIds.add(R);   
         system.debug('66666666666666666'+UpdateReportIds);            
                }   
               }                 
update UpdateReportIds;
}
}
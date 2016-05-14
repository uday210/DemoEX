global without sharing class BLN_ExportAttendeereport implements Database.batchable<sObject>, Database.Stateful
{
   global final String Query;
   global string filterKey{get;set;}
   global string timezone{get;set;}
   global string selectedEvent{get;set;}
   global date FromDate{get;set;}
   global date ToDate{get;set;}
   
   private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportAttendeereport(String q,String tzone,String selEvent,date FrmDate,date TDate){
    Query=q;
    timezone = tzone;
    selectedEvent=selEvent;
    FromDate=FrmDate;
    ToDate=TDate;
   }
   global Iterable<sObject> start(Database.batchableContext batchableContext)
   { 
   system.debug('query'+query);
      return Database.getQueryLocator(query);

   }
   global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
   {
        String temp1='Prefix,First Name,Last Name,Suffix,Email,Company Name,Designation,Mobile Number,Work Phone Number,Home Phone Number,Age,Gender,DOB,Ticket Type,Ticket Name,Seat No,Badge Status,Checkin Status,Pay Type,Buyer Name,Tag,Order Id,Ticket Id,Primary Business Category,Secondary Business Category,Business Established Date,Business Duns Number,Business Revenue,No. Of Employees,Business Tax Id,Website URL,Blog URL,Business Description,Business Address1,Business Address2,Business City,Business State,Business Country,Business Zip Code,Billing Address1,Billing Address2,Billing City,Billing State,Billing Country,Billing Zip,Home Address1,Home Address2,Home City,Home State,Home Country,Home Zip,NAICS Codes,Diversity Type,Blogger,Order Date,Custom Barcode\n';
        BLN_AttendeeDetailReport_BAL attendeeDetailReportBAL = new BLN_AttendeeDetailReport_BAL();
        LIST <BLN_AttendeeDetailReport_BAL.AttendeeDetailInner> ListTickets = new LIST < BLN_AttendeeDetailReport_BAL.AttendeeDetailInner > ();
        ListTickets = attendeeDetailReportBAL.ticketsListForEvent(scope, selectedEvent, FromDate, ToDate, '');
      
      for(BLN_AttendeeDetailReport_BAL.AttendeeDetailInner ticket:ListTickets){
           
          if (ticket.ticketData.tkt_profile__r.Prefix__c != null && ticket.ticketData.tkt_profile__r.Prefix__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Prefix__c+'",';
           } else {
           temp1+='"",';
           } 
           
           if (ticket.ticketData.tkt_profile__r.First_Name__c != null && ticket.ticketData.tkt_profile__r.First_Name__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.First_Name__c+'",';
           } else {
           temp1+='"",';
           } 

            if (ticket.ticketData.tkt_profile__r.Last_Name__c != null && ticket.ticketData.tkt_profile__r.Last_Name__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Last_Name__c+'",';
           } else {
           temp1+='"",';
           }           

            
            if (ticket.ticketData.tkt_profile__r.Suffix__c != null && ticket.ticketData.tkt_profile__r.Suffix__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Suffix__c+'",';
           } else {
           temp1+='"",';
           } 
            
          if (ticket.ticketData.tkt_profile__r.Email__c != null && ticket.ticketData.tkt_profile__r.Email__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Email__c+'",';
           } else {
           temp1+='"",';
           }
           
            if (ticket.ticketData.tkt_profile__r.TKT_Company__c != null && ticket.ticketData.tkt_profile__r.TKT_Company__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.TKT_Company__c+'",';
           } else {
           temp1+='"",';
           }
           
            if (ticket.ticketData.tkt_profile__r.TKT_Job_Title__c != null && ticket.ticketData.tkt_profile__r.TKT_Job_Title__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.TKT_Job_Title__c+'",';
           } else {
           temp1+='"",';
           }

            
            if (ticket.ticketData.tkt_profile__r.Mobile__c != null && ticket.ticketData.tkt_profile__r.Mobile__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Mobile__c+'",';
           } else {
           temp1+='"",';
           }

            
            
            if (ticket.ticketData.tkt_profile__r.Work_Phone__c != null && ticket.ticketData.tkt_profile__r.Work_Phone__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Work_Phone__c+'",';
           } else {
           temp1+='"",';
           }
           
           if (ticket.ticketData.tkt_profile__r.Home_Phone__c != null && ticket.ticketData.tkt_profile__r.Home_Phone__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Home_Phone__c+'",';
           } else {
           temp1+='"",';
           }
           
           if (ticket.ticketData.tkt_profile__r.Age__c != null) { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Age__c+'",';
           } else {
           temp1+='"",';
           }
           
           
           if (ticket.ticketData.tkt_profile__r.Gender__c != null && ticket.ticketData.tkt_profile__r.Gender__c !='') { 
          temp1+='"'+ticket.ticketData.tkt_profile__r.Gender__c+'",';
           } else {
           temp1+='"",';
           }
            
            if (ticket.ticketData.tkt_profile__r.DOB__c != null ) { 
         temp1+='"'+ticket.ticketData.tkt_profile__r.DOB__c+'",';
           } else {
           temp1+='"",';
           }
            
            
            
             if (ticket.ticketData.Item_Type__r.Name=='Admissions' || ticket.ticketData.Item_Pool__r.Item_Type__r.Name=='Admissions') { 
                  temp1+='"Attendee",';
              }
              
              if (ticket.ticketData.Item_Type__r.Name!='Admissions' && ticket.ticketData.Item_Type__r.Name!='Package') {
              if (ticket.ticketData.item_type__r.Name != null && ticket.ticketData.item_type__r.Name != '') {
                  temp1+='"'+ticket.ticketData.item_type__r.Name+'",';
             } else {
             temp1+='"",';
             }
              }
          
              if (ticket.ticketData.Item_Pool__r.Item_Type__r.Name!='Admissions' && ticket.ticketData.Item_Type__r.Name=='Package') {
                if (ticket.ticketData.Item_Pool__r.Item_Type__r.Name != null && ticket.ticketData.Item_Pool__r.Item_Type__r.Name != '') {
                  temp1+='"'+ticket.ticketData.Item_Pool__r.Item_Type__r.Name+'",';
                  } else {
                  temp1+='"",';
                 }
              }
            
            
           // temp1+='"'+ticket.ticketData.Item_Pool__r.Item_Pool_Name__c+'",';
           if (ticket.ticketData.Item__r.item_name__c != null && ticket.ticketData.Item__r.item_name__c != '') {
            temp1+='"'+ticket.ticketData.Item__r.item_name__c+'",';
            } else {
            temp1+='"",';
            }
            //temp1+='"'+ticket.ticketData.Badge_Label__c+'",';
            if (ticket.ticketData.Tag_No__c != null && ticket.ticketData.Tag_No__c != '') {
            temp1+='"'+ticket.ticketData.Tag_No__c+'",';
            } else {
            temp1+='"",';
            }
            
            if (ticket.ticketData.Badge_ID__c!=null) {
              temp1+='"Printed",';
          }else {
              temp1+='"Not Printed",';
          }
           
            
            if (ticket.ticketData.Tstatus_Id__c!=null) {
                 if (ticket.ticketData.Tstatus_Id__r.Tstatus_name__c==true) {
                     temp1+='"Checked In",';
                 } else {
                     temp1+='"Checked Out",';
                 }
             } else {
                 temp1+='"Checked Out",';
             } 
            
            
            if (ticket.ticketData.item__r.Payment__c != null ) { 
          temp1+='"'+ticket.ticketData.item__r.Payment__c+'",';
           } else {
           temp1+='"",';
           }
            
           if (ticket.ticketData.Order__r.bln_tkt_profile__r.First_Name__c != null && ticket.ticketData.Order__r.bln_tkt_profile__r.First_Name__c != '') { 
           temp1+='"'+ticket.ticketData.Order__r.bln_tkt_profile__r.First_Name__c+' '+ticket.ticketData.Order__r.bln_tkt_profile__r.Last_Name__c+'",';
           } else {
           temp1+='"",';
           }
           
           temp1+='"'+'tag'+'",';
            
            if (ticket.ticketData.order__r.NAME != null && ticket.ticketData.order__r.NAME != '') {
            temp1+='"'+ticket.ticketData.order__r.NAME+'",';
            } else {
            temp1+='"",';
            }
            
             if (ticket.ticketData.NAME != null && ticket.ticketData.NAME != '') {
            temp1+='"'+ticket.ticketData.NAME+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Primary_Business_Category__c != null && ticket.ticketData.tkt_profile__r.Primary_Business_Category__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Primary_Business_Category__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Secondary_Business_Category__c != null && ticket.ticketData.tkt_profile__r.Secondary_Business_Category__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Secondary_Business_Category__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Established_Date__c != null) {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Established_Date__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Duns_Number__c != null && ticket.ticketData.tkt_profile__r.Duns_Number__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Duns_Number__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Revenue__c != null) {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Revenue__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Number_Of_Employees__c != null) {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Number_Of_Employees__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Tax_Id__c != null && ticket.ticketData.tkt_profile__r.Tax_Id__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Tax_Id__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Company_Website_URL__c != null && ticket.ticketData.tkt_profile__r.Company_Website_URL__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Company_Website_URL__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Blog_URL__c != null && ticket.ticketData.tkt_profile__r.Blog_URL__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Blog_URL__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_profile__r.Company_Description__c != null && ticket.ticketData.tkt_profile__r.Company_Description__c != '') {
            temp1+='"'+ticket.ticketData.tkt_profile__r.Company_Description__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Work_Address__r.Address1__c != null && ticket.ticketData.tkt_Profile__r.Work_Address__r.Address1__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Work_Address__r.Address1__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Work_Address__r.Address2__c != null && ticket.ticketData.tkt_Profile__r.Work_Address__r.Address2__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Work_Address__r.Address2__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Work_Address__r.City__c != null && ticket.ticketData.tkt_Profile__r.Work_Address__r.City__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Work_Address__r.City__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Work_Address__r.State__r.Long_Name__c != null && ticket.ticketData.tkt_Profile__r.Work_Address__r.State__r.Long_Name__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Work_Address__r.State__r.Long_Name__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c != null && ticket.ticketData.tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Work_Address__r.ZipCode__c != null && ticket.ticketData.tkt_Profile__r.Work_Address__r.ZipCode__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Work_Address__r.ZipCode__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Billing_Address__r.Address1__c != null && ticket.ticketData.tkt_Profile__r.Billing_Address__r.Address1__c != '') {
           temp1+='"'+ticket.ticketData.tkt_Profile__r.Billing_Address__r.Address1__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Billing_Address__r.Address2__c != null && ticket.ticketData.tkt_Profile__r.Billing_Address__r.Address2__c != '') {
           temp1+='"'+ticket.ticketData.tkt_Profile__r.Billing_Address__r.Address2__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Billing_Address__r.City__c != null && ticket.ticketData.tkt_Profile__r.Billing_Address__r.City__c != '') {
           temp1+='"'+ticket.ticketData.tkt_Profile__r.Billing_Address__r.City__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c != null && ticket.ticketData.tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c != '') {
           temp1+='"'+ticket.ticketData.tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c != null && ticket.ticketData.tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Billing_Address__r.ZipCode__c != null && ticket.ticketData.tkt_Profile__r.Billing_Address__r.ZipCode__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Billing_Address__r.ZipCode__c+'",';
            } else {
             temp1+='"",';
            }
           
            if (ticket.ticketData.tkt_Profile__r.Home_Address__r.Address1__c != null && ticket.ticketData.tkt_Profile__r.Home_Address__r.Address1__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Home_Address__r.Address1__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Home_Address__r.Address2__c != null && ticket.ticketData.tkt_Profile__r.Home_Address__r.Address2__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Home_Address__r.Address2__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Home_Address__r.City__c != null && ticket.ticketData.tkt_Profile__r.Home_Address__r.City__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Home_Address__r.City__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Home_Address__r.State__r.Long_Name__c != null && ticket.ticketData.tkt_Profile__r.Home_Address__r.State__r.Long_Name__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Home_Address__r.State__r.Long_Name__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c != null && ticket.ticketData.tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c != '') {
            temp1+='"'+ticket.ticketData.tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.tkt_Profile__r.Home_Address__r.ZipCode__c != null && ticket.ticketData.tkt_Profile__r.Home_Address__r.ZipCode__c != '') {
           temp1+='"'+ticket.ticketData.tkt_Profile__r.Home_Address__r.ZipCode__c+'",';
            } else {
             temp1+='"",';
            }
            
           
            string NCCodes='';
            if(ticket.companyNaicsCode != null){
                 for(integer i=0;i<ticket.companyNaicsCode.size();i++){
                NCCodes= NCCodes +ticket.companyNaicsCode[i].BLN_NAICS_Code__r.Description__c+',';
                 }
                  
              }
            temp1+='"'+NCCodes+'",';
            
            
            string CompanyNaics='';
             if(ticket.companyDiversityData != null){
                 for(integer i=0;i<ticket.companyDiversityData.size();i++){
                CompanyNaics= CompanyNaics+ticket.companyDiversityData[i].Diversity__r.Name+',';
                 }
              }
              temp1+='"'+CompanyNaics+'",';
            
            if (ticket.ticketData.tkt_Profile__r.Blogger__c != null && ticket.ticketData.tkt_Profile__r.Blogger__c != '') {
           temp1+='"'+ticket.ticketData.tkt_Profile__r.Blogger__c+'",';
            } else {
             temp1+='"",';
            }
              
            if (ticket.ticketData.order__r.createdDate != null) {
           temp1+='"'+ticket.ticketData.order__r.createdDate+'",';
            } else {
             temp1+='"",';
            }
            
            if (ticket.ticketData.Custom_Barcode__c != null) {
            temp1+='"'+ticket.ticketData.Custom_Barcode__c +'",';
            } else {
             temp1+='"",';
            }
            
            //temp1+='"'+'survey'+'",';
          
          
          
          
         
         temp1+='\n';
      }
      
      try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportAttendeereport.csv');
            attachment.setBody(Blob.valueOf(temp1));
            attachment.setContentType('text/csv');          
         
                
               String emailMessage = 'Please find attached your exported data as an attachment';                      
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
                
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

                    if ( owea.size() > 0 ) {
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        //emailTOea.setOrgWideEmailAddressId(owea.get(0).Id);
                    }
                
                 String[] toAddresses = new String[] {UserInfo.getUserName()};
                 mail.setToAddresses(toAddresses);
                 mail.setReplyTo('support@eventdex.com');
                 mail.setSubject('Attendee Detail Report');
                 mail.setHtmlBody(emailMessage);
                
                 
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 }catch(Exception e){}
   }
      
      
       global void finish(Database.BatchableContext batchableContext){}
 
}
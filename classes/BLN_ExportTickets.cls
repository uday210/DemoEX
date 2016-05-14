global without sharing class BLN_ExportTickets implements Database.batchable < sObject > , Database.Stateful {
    global final String Query;


    private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportTickets(String q) {
        Query = q;
    }
    global Iterable < sObject > start(Database.batchableContext batchableContext) {
        system.debug('query' + query);
        return Database.getQueryLocator(query);

    }
    global void execute(Database.BatchableContext batchableContext, List < sObject > scope) {
        String temp = 'Ticket No.,Ticket Name,Order Id,Ticket Type,First Name,Last Name,Email,Title,Company,Status,Sale Date\n';

        for (sObject tickets: scope) {
            Ticket__c ticket = (Ticket__c) tickets;

            temp += '"' + ticket.Name + '",';
            if (ticket.Item_Type__r.Name != 'Package') {
                temp += '"' + ticket.Item_Pool__r.Item_Pool_Name__c + '",';
            } else {
                string poolname = ticket.Item_Pool__r.Item_Pool_Name__c + ' (' + ticket.Item__r.Item_Pool__r.Item_Pool_Name__c + ')';
                temp += '"' + poolname + '",';
            }
            temp += '"' + ticket.Order__r.Name + '",';

            if (ticket.Item_Type__r.Name != 'Package') {
                temp += '"' + ticket.Item_Type__r.Name + '",';
            } else {
                temp += '"' + ticket.Item_Pool__r.Item_Type__r.Name + '",';
            }

            if (ticket.tkt_profile__r.First_Name__c != null && ticket.tkt_profile__r.First_Name__c != '') {
                temp += '"' + ticket.tkt_profile__r.First_Name__c + '",';
            } else {
                temp += '"",';

            }

            if (ticket.tkt_profile__r.Last_Name__c != null && ticket.tkt_profile__r.Last_Name__c != '') {
                temp += '"' + ticket.tkt_profile__r.Last_Name__c + '",';
            } else {
                temp += '"",';

            }

            if (ticket.tkt_profile__r.Email__c != null && ticket.tkt_profile__r.Email__c != '') {
                temp += '"' + ticket.tkt_profile__r.Email__c + '",';
            } else {
                temp += '"",';

            }



            if (ticket.tkt_profile__r.TKT_Job_Title__c != null && ticket.tkt_profile__r.TKT_Job_Title__c != '') {
                temp += '"' + ticket.tkt_profile__r.TKT_Job_Title__c + '",';
            } else {
                temp += '"",';

            }

            if (ticket.tkt_profile__r.TKT_Company__c != null && ticket.tkt_profile__r.TKT_Company__c != '') {
                temp += '"' + ticket.tkt_profile__r.TKT_Company__c + '",';
            } else {
                temp += '"",';

            }




            temp += '"' + ticket.Ticket_Status__c + '",';
            BLN_timeConToEvzoneCon tz = new BLN_timeConToEvzoneCon();
            tz.tZone = ticket.Event__r.Time_Zone__c;
            tz.format = 'MM/dd/yyyy hh:mm a';
            tz.dateTimeValue = ticket.Order__r.createddate;
            temp += '"' + tz.getTimeZoneValue();

            temp += '"';


            temp += '\n';

        }


        try {
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportTickets.csv');
            attachment.setBody(Blob.valueOf(temp));
            attachment.setContentType('text/csv');


            String emailMessage = 'Please find attached your exported data as an attachment';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {
                attachment
            });

            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

            if (owea.size() > 0) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                //emailTOea.setOrgWideEmailAddressId(owea.get(0).Id);
            }

            String[] toAddresses = new String[] {
                UserInfo.getUserName()
            };
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('support@eventdex.com');
            mail.setSubject('Ticket Detail Report');
            //mail.setPlainTextBody(emailMessage);
            mail.setHtmlBody(emailMessage);


            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
        } catch (Exception e) {}
    }


    global void finish(Database.BatchableContext batchableContext) {}

}
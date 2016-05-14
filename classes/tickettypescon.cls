public with sharing class tickettypescon {

public LIST<TicketTypes__c> ticketslist{get;set;}


public tickettypescon(){
 ticketslist = [select id from TicketTypes__c where User_Type__c = 'MSDC Member Corporation'];
}

}
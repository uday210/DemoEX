@isTest(SeeAllData=true)
public class Test_BLN_ASC_WS_TicketCheckin{
    static testmethod void myTickChecknTestMethod(){
      
         Test_BLN_ASC_AddEvents addevent= new Test_BLN_ASC_AddEvents();
         Test_BLN_ASC_AddEvents.Test_BLN_ASC_AddEvents();
       /* Tstatus__c tc= new Tstatus__c();
         tc.Device_Name__c='mobile';
         tc.Ticket__c=Test_BLN_ASC_AddEvents.ticket.id;
         tc.Tstatus_name__c=true;
         insert tc;*/
           system.debug('hhhhhhhhhhh'+Test_BLN_ASC_AddEvents.ticket.id);
            
        //BLN_ASC_WS_TicketCheckin tchObj=new BLN_ASC_WS_TicketCheckin();
        BLN_ASC_WS_TicketCheckin.ticidsToUpdate t4 = new BLN_ASC_WS_TicketCheckin.ticidsToUpdate();
        t4.TicketId=Test_BLN_ASC_AddEvents.ticket.id;
        t4.isCHeckIn=true;
        t4.device='IOs';
           
       BLN_ASC_WS_TicketCheckin.SuccessTickets t1 = new BLN_ASC_WS_TicketCheckin.SuccessTickets(Test_BLN_ASC_AddEvents.ticket.id,true,'01/30/2015 11:00 AM');
        BLN_ASC_WS_TicketCheckin.FailureTickets t2 = new BLN_ASC_WS_TicketCheckin.FailureTickets(Test_BLN_ASC_AddEvents.ticket.id,true,'01/30/2015 6:00 PM');
       BLN_ASC_WS_TicketCheckin.TicketCheckIn t3 = new BLN_ASC_WS_TicketCheckin.TicketCheckIn();
        
        
        //RestContext.request.addParameter('Event_Id',BLN_ASC_WS_TicketCheckin.ScannedBy);
        RestContext.request.addParameter('scannedby',Test_BLN_ASC_AddEvents.gnUser.id);
         RestContext.request.addParameter('eveid',Test_BLN_ASC_AddEvents.eventInfo.id);
        RestContext.request.requestURI ='/BLN_ASC_WS_TicketCheckin';
       
      string bodys='[{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": true},{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": true},{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": true},{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": true}]';
        
        //string bodys = '{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
        blob b = blob.valueOf(bodys);
        RestContext.request.requestBody  = b;
        
        
        
        BLN_ASC_WS_TicketCheckin chck = new BLN_ASC_WS_TicketCheckin();
        
        BLN_ASC_WS_TicketCheckin.ticidsToUpdate tcp = new BLN_ASC_WS_TicketCheckin.ticidsToUpdate();
       
          //  BLN_ASC_WS_TicketCheckin.dopost();    
      //   RestContext.request.addParameter('scannedby',Test_BLN_ASC_AddEvents.gnUser.id);
       //   RestContext.request.addParameter('eveid',Test_BLN_ASC_AddEvents.eventInfo.id);
        
            string bodys1='[{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": false},{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": false},{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": false},{"TicketId" : "'+Test_BLN_ASC_AddEvents.ticket.id+'","isCHeckIn": false}]';
       
          blob b1 = blob.valueOf(bodys1);
        RestContext.request.requestBody  = b1;
        /* System.RunAs(Test_BLN_ASC_AddEvents.u){
          Tstatus__c tc1= new Tstatus__c();
         tc1.Device_Name__c='mobile';
         tc1.Ticket__c=Test_BLN_ASC_AddEvents.ticket.id;
         tc1.Tstatus_name__c=true;
        insert tc1;
        
        Test_BLN_ASC_AddEvents.ticket.Tstatus_Id__c=null;
        update Test_BLN_ASC_AddEvents.ticket; */
     try{
        
            BLN_ASC_WS_TicketCheckin.dopost();    
         }
         catch(Exception e){}
         }
        
        
           //RestContext.request.addParameter('scannedby', null);
           //BLN_ASC_WS_TicketCheckin.dopost();    
    }
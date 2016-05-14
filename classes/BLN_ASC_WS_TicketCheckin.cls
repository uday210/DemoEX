/***********************************************************************************************
*   Controller Name : BLN_ASC_WS_TicketCheckin
*   Date            : 24/12/2014
*   Author          : Rajesh Kumar Ch
*   Purpose         : This class is Web service Class to update tickets status and creat check-in and check-out history.
**************************************************************************************************/

@RestResource(urlMapping='/BLN_ASC_WS_TicketCheckin')

global class BLN_ASC_WS_TicketCheckin{

    public Static String ScannedBy;
    public Static String eveid;
    //Static String TicketId;
    //Static Boolean isCHeckIn;


    @HttpPost
    global static TicketCheckIn doPost(){
        
        TicketCheckIn res = new TicketCheckIn();
        List<SuccessTickets> sts = new List<SuccessTickets>();
        List<FailureTickets> fts = new List<FailureTickets>();
        
        
        RestRequest req = RestContext.Request;
        ScannedBy = req.params.get('scannedby');
        system.debug('ScannedBy==== '+ScannedBy);
        String JsonString = req.requestBody.toString();
        system.debug('JsonString ==== '+ JsonString );
        
        if(ScannedBy==null && ScannedBy == ''){
            res.ErrorMsg = 'Please send ScannedBy Id';
            return res;
        }
        
        
        MAP<Id,Boolean> Tickets = new MAP<Id,Boolean>();
        MAP<id,ticidsToUpdate> TstatusInfo = new MAP<id,ticidsToUpdate>();// Written By Phani
        
        JSONParser parser = JSON.createParser(JsonString);
        
        while (parser.nextToken() != null ) {
            system.debug('getting into while');
        
            if (parser.getCurrentToken() == JSONToken.START_OBJECT){
                ticidsToUpdate ttu = (ticidsToUpdate)parser.readValueAs(ticidsToUpdate.class);
                system.debug('TicketId---'+ttu.TicketId);
                system.debug('isCHeckIn---'+ttu.isCHeckIn);
                 system.debug('isCHeckIn---'+ttu.device);
                if(ttu.TicketId!=null){
                    Tickets.put(ttu.TicketId,ttu.isCHeckIn);
                    TstatusInfo.put(ttu.TicketId,ttu); 
                }
            }
            
            
            
            /*if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'TicketId')){
                parser.nextToken();                
                TicketId = id.ValueOf(parser.getText());
                system.debug('TicketId---'+TicketId);  
                parser.nextToken();              
            }
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'isCHeckIn')){
                parser.nextToken();                
                isCHeckIn= Boolean.ValueOf(parser.getText());
                system.debug('isCHeckIn---'+isCHeckIn);    
                 parser.nextToken();            
            } */ 
            
           /* if(ttu.TicketId!=null){
                Tickets.put(ttu.TicketId,ttu.isCHeckIn);
            }*/
               
        }
        system.debug('Tickets==========='+Tickets);
        
        BLN_Ticket_DAO TicsDAO = new BLN_Ticket_DAO();
        
        List<Id> ticsIds = new list<id>();        
        
        List<Ticket__c> TickestToUpdate = [SELECT Id,Name,Tstatus_Id__c,Tstatus_Id__r.Id,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__r.scan_time__c FROM Ticket__c WHERE Id IN : Tickets.KeySet()];
        //List<Ticket__c> TickestToUpdate = TicsDAO.getTickets('Id','Name IN :\''+Tickets.KeySet()+'\'');        
        system.debug('TickestToUpdate====== '+TickestToUpdate);
        
        
        List<Tstatus__c> tsts = new List<Tstatus__c>();
        List<Ticket__c> errorTics = new List<Ticket__c>();
        List<Ticket__c> updateTics = new List<Ticket__c>();
        
        for(Ticket__c ts : TickestToUpdate ){
            if(ts.Tstatus_Id__c==null && ts.Tstatus_Id__c==''){
                system.debug('no status found');
                Tstatus__c eachTs = new Tstatus__c();
                eachTs.Ticket__c = ts.Id;
                eachTs.Scan_source__c = 'Scan Attendee';
                eachTs.scan_time__c = system.now();
                eachTs.Tstatus_name__c = Tickets.get(ts.id);
                eachTs.OwnerId = Id.valueOf(scannedby);
                try{
                  eachTs.Device_Name__c = TstatusInfo.get(ts.id).device;
                 }catch(exception rf){}
                tsts.add(eachTs);
                updateTics.add(ts);
             }else{
                system.debug('ts.Tstatus_Id__r.Tstatus_name__c ==='+ts.Tstatus_Id__r.Tstatus_name__c );
                system.debug('Tickets.keyset()=== '+Tickets.keyset());
                system.debug('Tickets.get(ts.id)=== '+Tickets.get(ts.id));
                system.debug('ts.id  === '+ts.id);
                if(ts.Tstatus_Id__r.Tstatus_name__c != Tickets.get(ts.id)){
                    Tstatus__c eachTs = new Tstatus__c();
                    eachTs.Ticket__c = ts.Id;
                    eachTs.Scan_source__c = 'Scan Attendee';
                    eachTs.scan_time__c = system.now();
                    eachTs.Tstatus_name__c = Tickets.get(ts.id);
                    eachTs.OwnerId = Id.valueOf(scannedby); 
                    try{ 
                     eachTs.Device_Name__c = TstatusInfo.get(ts.id).device;
                    }catch(exception rf){}
                    tsts.add(eachTs);
                    updateTics.add(ts);
                }else{
                    if(Tickets.get(ts.id)==true){
                        fts.add(new FailureTickets(ts.Id,true,ts.Tstatus_Id__r.scan_time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZZZZ','GMT')) );
                    }else{
                        fts.add(new FailureTickets(ts.Id,false,ts.Tstatus_Id__r.scan_time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZZZZ','GMT')) );
                    }
                }                
            }        
        }
        
        BLN_TStatus_DAO BlnTstsDao = new BLN_TStatus_DAO();
        BLN_StatusMessage TstsStatus = new BLN_StatusMessage();
        TstsStatus = BlnTstsDao.insertTStatus(tsts);
        if(TstsStatus != null){            
            system.debug('TstsStatus.successId======= '+TstsStatus.successIds);
        }
         system.debug('TstsStatus.successId=======1 '+TstsStatus.successIds);
        
        
        
        List<Tstatus__c> TsAfterInsert = BlnTstsDao.getTStatusByIds(TstsStatus.successIds);
        for(Tstatus__c ticsstat : TsAfterInsert ){
            if(ticsstat.Tstatus_name__c==true){
                sts.add(new SuccessTickets(ticsstat.Ticket__c ,true,ticsstat.scan_time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZZZZ','GMT') ));
            }else{
                sts.add(new SuccessTickets(ticsstat.Ticket__c ,false,ticsstat.scan_time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZZZZ','GMT') ));
            }
        }
        
        Map<Id,Id> TicketsToUpdateAfterTsInsert = new Map<Id,Id>();
        for(Tstatus__c tsids : TsAfterInsert ){
            TicketsToUpdateAfterTsInsert.put(tsids.Ticket__c,tsids.Id);
        }
        system.debug('TicketsToUpdateAfterTsInsert=== '+ TicketsToUpdateAfterTsInsert);
        
        List<Ticket__c> ticketslist = new List<Ticket__c>();
        
        for(Ticket__c tic : updateTics){            
            tic.Tstatus_Id__c = TicketsToUpdateAfterTsInsert.get(tic.Id);
            ticketslist.add(tic);
        }
        system.debug('ticketslist========== '+ticketslist);
        
        BLN_StatusMessage TicsStatus = new BLN_StatusMessage();
        TicsStatus = TicsDAO.updateTicket(ticketslist);
        system.debug('TicsStatus ==== = '+ TicsStatus);
        
        
        /*List<Tstatus__c> tsts = new List<Tstatus__c>();
        for(Id TststoInsert : Tickets.keySet()){
            Tstatus__c eachTs = new Tstatus__c();
            eachTs.Ticket__c = TststoInsert;
            eachTs.Tstatus_name__c = Tickets.get(TststoInsert); 
            tsts.add(eachTs);  
        }
        
        BLN_TStatus_DAO BlnTstsDao = new BLN_TStatus_DAO();
        BLN_StatusMessage TstsStatus = new BLN_StatusMessage();
        TstsStatus = BlnTstsDao.insertTStatus(tsts);
        if(TstsStatus != null){            
            system.debug('TstsStatus.successId======= '+TstsStatus.successIds);
        }
        
        
        for(Id ts : TstsStatus.successIds){
            res.add(new TicketCheckIn(ts,'CheckedIn'));
        }*/
        
        //Map<Id,String> TickestToUpdateWithId = new Map<Id, String>();
        
        res.SuccessTickets = sts;
        res.FailureTickets = fts;
        return res;
    }

    
    global class SuccessTickets{
        public Id STicketId;
        public Boolean Status;
        public string TimeStamp;
        
        global SuccessTickets(Id ticis, Boolean sts, String ts){
            STicketId = ticis;
            Status = sts;
            TimeStamp = ts;
        }
    }
    
    global class FailureTickets{
        public Id STicketId;
        public Boolean Status;
        public string TimeStamp;
        
        global FailureTickets(Id ticis, Boolean sts, String ts){
            STicketId = ticis;
            Status = sts;
            TimeStamp = ts;
        }
    }
    
    
    global class TicketCheckIn{
        /*global Id Id;
        global string status;
        global String timestamp;*/
        List<SuccessTickets> SuccessTickets = new List<SuccessTickets>();
        List<FailureTickets> FailureTickets = new List<FailureTickets>();
        global string ErrorMsg;
        
        /*global TicketCheckIn(Id TstsId, String CheckinStatus, String tmstmp){
            Id = TstsId;
            status = CheckinStatus;
            timestamp = tmstmp;
        }*/
    }
    
    global class ticidsToUpdate{
        public Id TicketId;
        public boolean isCHeckIn;
        public String device;
    }
    
}
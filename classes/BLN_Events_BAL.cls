public with sharing class BLN_Events_BAL {
    
  
  
  //========================================================================  
     
    
     public String createEvent(LIST<BLN_Event__c> events,String companyName,String CompanyIdV,Id uid,Id lguserid){
        // We are Upserted 2 objects 
        //    1) Event
        //    2) UC_Role
        
          BLN_Events_DAO eventsDAO = new BLN_Events_DAO();
          String successEventId='';
          
            LIST<Database.UpsertResult> dbr  = eventsDAO.createEvent(events);
         
          system.debug('EVENTS CREATIONNNNNNNNNNnnnnnnn  222222222222222222222  '+ dbr);
          
        MAP<Id, Database.UpsertResult> eventSaveResult = new MAP<Id, Database.UpsertResult>();
        
        for(Database.UpsertResult r: dbr){
            if(r.isSuccess()){
                eventSaveResult.put(r.getId(), r);   
                successEventId = r.getId();
            }
        }
        
       
       User US = [Select id,name,FirstName,LastName,username From User Where id =: uid];
       
        String companyIDs='';
       boolean companychange=false;
            /*if(loginUser.CompanyName != null){
                companyName = loginUser.CompanyName;
            }*/
            Company__c companyId=new Company__c();
            BLN_Company_DAO company = new BLN_Company_DAO();
            String usertype='Business';

        
        if(companyName==''&&companyIdV=='')//take the P record or create a new one
        {
           //search for P Record
           try{
           
        companyId = company.queryPersonalCompanyId(US.username);
        companyIDs=companyId.id;
        }
        catch(Exception e){
        //if company not found create new one
          companyName=US.FirstName +US.LastName;
          usertype='Personal';
          companyId.Name=companyName;
          BLN_StatusMessage compmsg=company.insertCompany(companyId);
           if(compmsg.successBool){
            companyIDs= compmsg.successId;
        }
        }
             
        }
        if(companyName!=''&&companyIdV=='')//when user doesnt select an existing company from picklist and enter a new name
        {
           //create a brecord for new company
           companyId.Name=companyName;
           companychange=true;
          BLN_StatusMessage compmsg=company.insertCompany(companyId);
           if(compmsg.successBool){
            companyIDs= compmsg.successId;
                }
        }
        if(companyIdV!='')//when user select an existing company
        companyIDs=companyIdV;
       
       
      
       
         system.debug('ROLEEEEEEEEEEEEEE          22222222222222222222222222222     '+ companyId);
        
        //LIST<UC_Role__c> usercompanyRole = new LIST<UC_Role__c>();
       BLN_UCRole_DAO blnUserDAO = new BLN_UCRole_DAO();
       BLN_StatusMessage ucRoleMessage = new BLN_StatusMessage();
       
      // for(Database.UpsertResult rs :dbr){
           
           //if(rs.isSuccess() && rs.isCreated()){
           BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();

                   
                    UC_Role__c ucr = new UC_Role__c();
                    
                    ucr.Company__c = companyIDs;
                    ucr.User_Type__c= usertype;
                    //ucr.Event__c = rs.getId();
                    //ucr.Invited_date__c = system.Today(); 
                    
                     try{
                     GN_User__c  GNUID;
                     if(companychange==true&&lguserid!=US.id)
                     GNUID = gndao.gettinggnuser(US.id);
                     else
                     GNUID = gndao.gettinggnuser(lguserid);
                     system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD '+GNUID);
                     if(null!= GNUID){ 
                           ucr.GN_User__c =GNUID.id;
                      }
                    }catch(Exception e){}
                    
                    //usercompanyRole.add(ucr);
                    
                    //Insert User Role here,.............
                    ucRoleMessage = blnUserDAO.insertUCRole(ucr, 'Company Admin'); 
 
           //}
       
       //} 
       
       //If the loggedin user and organizer email is different(i.e:create an EventAdmin Role to run the event)
       try{
       if(lguserid!=US.id)
       {
                   ucr = new UC_Role__c();
                    
                    
                    ucr.User_Type__c= usertype;
                    ucr.Event__c = successEventId;
                    
                    
                     try{
                     GN_User__c  GNUID = gndao.gettinggnuser(US.id);
                    ucr.GN_User__c =GNUID.id;
                    
                    }catch(Exception e){}
                   ucr.Company__c = gndao.gettinggnuser(lguserid).Default_Company_ID__c; 
                  ucr.Invited_date__c = system.Today(); 
                  ucr.Invited_by__c=gndao.gettinggnuser(lguserid).Id;
                    
                    //Insert User Role here,.............
                    ucRoleMessage = blnUserDAO.insertUCRole(ucr, 'Event Admin');
       }
       
       }catch(Exception e){}
       
       system.debug('ROLEEEEEEEEEEEEEE         3333333333333333333333   '+ ucRoleMessage);
       
       if(ucRoleMessage.successBool != null){
            if(ucRoleMessage.successBool){
            try{
            Bln_event__c ble=[select id,name from bln_event__c where id=:successEventId];
            ble.User_Company__c=ucRoleMessage.successId;
            if(lguserid!=US.id)
            ble.organizer_id__c=gndao.gettinggnuser(lguserid).Default_Company_ID__c;
            else
            ble.organizer_id__c=companyIDs;
            update ble;
            }catch(Exception e){}
              return successEventId;
              }
            else    
               return successEventId; 
               
           
               
       } 
       
         system.debug('ROLEEEEEEEEEEEEEE         successEventId'+ successEventId);
 
        return successEventId;
    }

    public LIST<dataBase.Upsertresult> paymentGateWays(LIST<Pay_Gateway__c> gateWays){
        
        BLN_PGateway_Type_DAO pgate = new BLN_PGateway_Type_DAO();
        return pgate.pgateWaySaves(gateWays);
        
    }
   // for gettig all events based on login User//written by mythily
    public list<BLN_Event__c> listOfEvents( id uid){
    system.debug('-----------------BAL------------------'+uid);
    BLN_Events_DAO eventsDao = new BLN_Events_DAO ();
    list<BLN_Event__c> ListOfEvents= eventsDao.gettingAllEvents(uid);
    system.debug('-----------------BAL1111111111-------------'+ListOfEvents);
    return ListOfEvents;
    
    }
    public list<UC_Role__c> roles(id uid){
    BLN_Events_DAO eventsDao = new BLN_Events_DAO ();
    list<UC_Role__c> URoles = eventsDao.TogetRoleofanEvent(uid);
    return URoles ;
    }

}
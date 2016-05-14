/******************************************************
*   Author                  : Mythily Nagandla
*   Date                    : 5/12/2014 
*   Purpose                 : This is Web Service class for deleting Event.


********************************************************/



@RestResource(urlMapping='/BLN_ASC_DeleteEvents/*')
global class BLN_ASC_DeleteEvents{
global static BLN_Event__c Event {get ; set ;}
global static container ct {get ; set ;}

@HttpPost  

    global static container  doPost(){ 
    RestRequest req = RestContext.Request;
    string evid = req.params.get('Event_id');//Parameter from request
    system.debug('aaaaaaaaaaaaaaaaa'+evid);
    ct = new container();//Inner class instance
    id eveid=(id)evid;//converting string to id for sending to other class to delete an event
    
    BLN_UserEvents evebal = new BLN_UserEvents();//core class instance for deleting
    Event = evebal.deleteEvent(eveid);//Passing event id to deletemethod in the above class
    ct.Eventid = Event.id;
    ct.Eventstatus = Event.Event_Status__c;
    if(Event.Event_Status__c!='Deleted')
    {
    ct.Success='false';
    ct.SuccessMsg='There are sold tickets and event date is in the future.  You are not allowed to delete '+Event.Name+' event';
    }
    else
    {
     ct.Success='true';
    ct.SuccessMsg='Deleted successfully';
    }
    
    
    return ct;
    
    }

    global class container{
    public string Eventid {get ; set ;}
    public string Eventstatus {get ; set  ;}
    public String Success{get;set;}
    public String SuccessMsg{get;set;}
    public container(){
    }
    
    }






}
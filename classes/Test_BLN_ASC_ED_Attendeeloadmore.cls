@isTest(SeeAllData=true)
public class Test_BLN_ASC_ED_Attendeeloadmore{
    static testmethod void myAttendeeLoadMoreTestMethod(){
      
         Test_BLN_ASC_AddEvents addevent= new Test_BLN_ASC_AddEvents();
         Test_BLN_ASC_AddEvents.Test_BLN_ASC_AddEvents();
           system.debug('hhhhhhhhhhh'+Test_BLN_ASC_AddEvents.ticket.id);
            
       // RestContext.request.addParameter('scannedby',Test_BLN_ASC_AddEvents.gnUser.id);
         RestContext.request.addParameter('Event_id',Test_BLN_ASC_AddEvents.eventInfo.id);
        RestContext.request.requestURI ='/BLN_ASC_ED_Attendeeloadmore';
       
        
        
        BLN_ASC_ED_Attendeeloadmore lmore = new BLN_ASC_ED_Attendeeloadmore();
        
       try{
        
            BLN_ASC_ED_Attendeeloadmore.dopost();    
         }
         catch(Exception e){}
         }
        
      
    }
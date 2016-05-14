/******************************************************
*   Author                  : Phani Kumar Ch    
*   Date                    : 08/11/2015 
*   Purpose                 : This is Web Service class for getting statistics and dash board values.
********************************************************/
@RestResource(urlMapping='/BLN_ASC_Statistics/*')
global class BLN_ASC_Statistics {

@HttpPost  
 global static BLN_RegDashBoardInfo doPost(){ //Post Mthod
   RestRequest req = RestContext.Request;
   string Eventid = req.params.get('Event_id');
    BLN_RegDashBoardInfo statistics = new BLN_RegDashBoardInfo(Eventid );
   return statistics;  
   
  }
}
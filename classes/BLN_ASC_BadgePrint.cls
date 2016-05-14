@RestResource(urlMapping='/BLN_ASC_BadgePrint/*')
/***********************************************************************************************
*   Service Name : BLN_ASC_BadgePrint
*   Date            : 04/02/2015
*   Author          : Arindam Sarkar
*   Purpose         : This class is for printing badges for ScanAttendee
* Reused classes    : BLN_Quick_Registration_BAL
************************************************************************************************/
  

    global with sharing class BLN_ASC_BadgePrint{
   
    @HttpPost  
    global static List<Ticket> doPost(){
        RestRequest req = RestContext.request;  
        
        RestResponse response = RestContext.response; 
      
      
      
       //Ticket object
    List<Ticket> tcinfo;
    tcinfo = new List<Ticket>(); 
    // Parse entire JSON response for event mandatory fields.
    String JsonString = req.requestBody.toString();
    system.debug('@@@@@@@@@'+JsonString);
     JSONParser parser = JSON.createParser(JsonString);
    while (parser != null && parser.nextToken() != null) {
        
                    tcinfo= (List<Ticket>)parser.readValueAs(List<Ticket>.class);
                   

       }
       
       BLN_Quick_Registration_BAL quickbal=new BLN_Quick_Registration_BAL();
       
       for(integer i=0;i<tcinfo.size();i++)
       {
          try{
         tcinfo[i].BadgeId=quickbal.generateBadge(tcinfo[i].BadgeLabel,tcinfo[i].TicketId,tcinfo[i].Reason); 
         }catch(Exception e){
         tcinfo[i].Error=e.getMessage();
         }
       }
        
       
      return tcinfo;
      
        }
        
        
        global class Ticket
        {
         public String TicketId{get;set;}
         public String Reason{get;set;}
         public String BadgeLabel{get;set;}
         public String BadgeId{get;set;}
         public String Error{get;set;}
        }
        
        
        
 }
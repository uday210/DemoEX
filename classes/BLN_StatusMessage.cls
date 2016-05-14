public class BLN_StatusMessage{

/***********************************************************************************************
*   Controller Name : BLN_SuccessMessage
*   Date            : 05/05/2014
*   Author          : Naga Mallikarjuna Rao B
*   Purpose         : This class is for checking all records are created Successfully or not.
*   Change History  : 05/05/2014 
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   05/05/2014          Naga Mallikarjuna Rao B           To Create Class
**************************************************************************************************/
      
        public ID successId{get; set;}
        public List<ID> successIds{get;set;}
        public Boolean successBool{get; set;}
        public Boolean iscreated{get; set;}
        public String errors{get; set;}
        public List<String> errorslist{get; set;}
        
        
        public BLN_StatusMessage(){
            
        }
        
        public BLN_StatusMessage(Database.UpsertResult r){
            iscreated = FALSE;
            successBool = FALSE;
            errors = '';
            
            successId = r.getId();
            successBool = r.isSuccess();
            iscreated = r.isCreated();
            if(r.getErrors() != null){
                errors = String.valueOf(r.getErrors());
            }   
        }
        
        
         public  BLN_StatusMessage(Database.SaveResult sr){
            iscreated = FALSE;
            successBool = FALSE;
            errors = '';
            
            successId = sr.getId();
            successBool = sr.isSuccess();
            if(sr.getErrors() != null){
                errors = String.valueOf(sr.getErrors());
            }   
        }
        
          public  BLN_StatusMessage(Database.SaveResult[] srlist){
            iscreated = FALSE;
            successBool = FALSE;
            errors = '';
            successIds=new List<ID>();
            errorslist=new List<String>();
        for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        successIds.add(sr.getId());
         successBool = sr.isSuccess();
    }
    else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
           errorslist.add(err.getStatusCode() + ': ' + err.getMessage()+' fields that affected this error: ' + err.getFields());
        }
    }
} 
        }
        
}
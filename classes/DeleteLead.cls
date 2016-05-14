@RestResource(urlMapping='/DeleteLead/*')

global with sharing class DeleteLead{

 @HttpPost
    
    global static string doPost(){
      RestRequest req = RestContext.request;
      RestResponse res = RestContext.response;
      System.debug('@@@@@req'+req);
   
     string userid= req.params.get('userid');
    string EamId= req.params.get('leadbarcodeid');
    system.debug('ttttttttttttttttt '+EamId);
    string[] str = new string[]{};
    str=EamId.split(',');
    
      
    
    List<BoothVisitSummary__c> bvsList = new List<BoothVisitSummary__c>();
    bvsList =[SELECT id,EA_AttendeeBarcode__c,User_id__c from BoothVisitSummary__c where  EA_AttendeeBarcode__r.id IN :str and User_id__r.id=:userid ];
    DataBase.DeleteResult[] saveres = dataBase.delete(bvsList,false);
    system.debug('#############'+userid + '$$$$$$$$$$$$$$'+str);
    
   if(str!=null)
   {
   string imagename = EamId+'-'+userid+'.jpeg';
   List<Document> d=new List<document>();
   d= [SELECT id,Name FROM Document where name Like:imagename ];
   dataBase.delete(d);
    system.debug('^^^^^^^^^^'+userid + '&&&&&&&&&&&&'+str);
   }
   
   string Message ='';
       for( DataBase.DeleteResult trd:saveres ){
      if(trd.isSuccess()){
      Message  = 'Success';
         
       }else{
       Message  = 'Fail';
      
      }
    }
     return Message  ;
 }
    
}
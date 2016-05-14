@RestResource(urlMapping='/Saveimage/*')

  global class Saveimage{
   @HttpPost
    global static string doPost(){
      RestRequest req = RestContext.request;
      RestResponse res = RestContext.response;
      String UserId= req.params.get('id');   
      String imageurl= req.headers.get('imageurl');  
        string message='No image found';
        string filderId;
        List<document> docs =[Select d.Name, d.FolderId, d.Body From Document d where folder.Name='shared documents'limit 1];
           if(docs.size()>0){
           filderId=docs[0].FolderId;
       }

  
    document d = new document();
    d.FolderId=filderId;
    d.ispublic=true;
    d.Name='attendee.jpeg';
    system.debug('hiiiiiiiiiiiiiii '+imageurl);
    d.Body=EncodingUtil.base64Decode(imageurl);
    dataBase.saveResult saveres = dataBase.insert(d,false);
    message ='Success';
   
    
    for(user u:[select id,email,userName from user where id=:UserId limit 1]){
     List<AttendeeSummary__c>  AttSummary= new List<AttendeeSummary__c>();
     AttSummary =[select id, AS_Email__c,AS_ImageUrl__c  from AttendeeSummary__c where  AS_Email__c=:u.userName];
      
      if(saveres.isSuccess()){
        AttSummary[0].AS_ImageUrl__c =saveres.getId(); 
        dataBase.saveResult rests = dataBase.update(AttSummary[0],false);
       System.debug('AAAAAAAAAAAAAAAA  '+rests);
         if(rests.isSuccess()){
            message ='Success';
         }else{
             message ='Fail';
         }       
        
       }else{
         try{
            message = saveres.getErrors()[0].getMessage();
          
          }catch(exception rd){
           message ='Fail';
         }
       }
     
    }
   System.debug('BBBBBBBBBBBBBBB '+   message); 
   
    return message;
    }
  }
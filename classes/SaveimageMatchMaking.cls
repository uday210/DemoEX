@RestResource(urlMapping='/SaveimageMatchMaking/*')

  global class SaveimageMatchMaking{
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
     
  
     List<AttendeeSummary__c>  AttSummary= new List<AttendeeSummary__c>();
     AttSummary =[select id, AS_Email__c,AS_ImageUrl__c  from AttendeeSummary__c where  AS_Email__c=:UserId];
       if(saveres.isSuccess()){
        AttSummary[0].AS_ImageUrl__c =saveres.getId(); 
        dataBase.saveResult rest = dataBase.update(AttSummary[0],false);
         if(rest.isSuccess()){
            message ='Success';
         }else{
             message ='Fail';
         }       
        
       }
   
    return message;
    }
  }
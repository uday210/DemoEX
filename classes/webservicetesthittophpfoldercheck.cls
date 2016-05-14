public with sharing class webservicetesthittophpfoldercheck{

public string webhitfoldercheck(string fldname){
try {

HttpRequest req = new HttpRequest();
   String body = 'serviceName=glst_foldercheck&folder_name='+fldname;
   
    req.setCompressed(false);
    req.setHeader('Content-Type', 'application/x-www-form-urlencoded');  

    req.setbody(body);
    //string endpoint = 'http://www.tcheckin.com/testurl/eventdexapi.php?';
    string endpoint = 'http://www.eventdex.com/eventdexapi.php?';
    req.setEndpoint(endpoint);
    req.setMethod('POST');
  Http h = new Http();
      req.setTimeout(120000);
      HTTPResponse res = h.send(req);
      String JsonString = res.getBody(); 
      shorturlkeys resp_vars=new  shorturlkeys();
      resp_vars = parse(JsonString);
      system.debug('@@@@@@@@@@@@############'+resp_vars.foldercontainbool);
      
      return resp_vars.foldercontainbool;
      }catch (Exception e) {
      return null;
      }
   }
   
   
    public class shorturlkeys{
        public String status;
        public String foldercontainbool;  
   
   }
   public static shorturlkeys parse(String json){
        return (shorturlkeys) System.JSON.deserialize(json, shorturlkeys.class);
    }



}
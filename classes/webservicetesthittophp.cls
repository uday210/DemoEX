public with sharing class webservicetesthittophp{

public string webhitphp(string fullurl,string foldername,string eventname,date evestartdate,date eveenddate,string eventid){
try {

HttpRequest req = new HttpRequest();
   String body = 'serviceName=glst_urlshort&reg_url='+fullurl+'&eventfoldername='+foldername+'&eventname='+eventname+'&eventstartdate='+evestartdate+'&eventenddate='+eveenddate+'&eventid='+eventid;
   
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
      system.debug('@@@@@@@@@@@@############'+resp_vars.url);
      
      return resp_vars.url;
      }catch (Exception e) {
      return null;
      }
   }
   
   
    public class shorturlkeys{
        public String status;
        public String url;  
   
   }
   public static shorturlkeys parse(String json){
        return (shorturlkeys) System.JSON.deserialize(json, shorturlkeys.class);
    }



}
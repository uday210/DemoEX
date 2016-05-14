public without sharing class pushToSalesforce{

    public pushToSalesforce()
    {
        displayError = 'none';
     }
     
     public string displayError{get;set;}
      public string values{get;set;}
    public string fetch(string uName,string pword,List<Id> bVSids)
    {
      String LOGIN_DOMAIN = 'login';
      String pwd=pword;
      String userName=uName;
     
      
       //try
       //  { 
             HttpRequest request = new HttpRequest();
             request.setEndpoint('https://' + LOGIN_DOMAIN + '.salesforce.com/services/Soap/u/20.0');
             request.setMethod('POST');
             request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
             request.setHeader('SOAPAction', '""');
        
        
        system.debug('4444444444 '+uName +'  5555555555 '+pword+' 6666666666 '+bVSids);
        
             request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + userName+ '</username><password>' + pwd+ '</password></login></Body></Envelope>');
             Dom.XmlNode resultElmt = (new Http()).send(request).getBodyDocument().getRootElement()
             .getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/')
             .getChildElement('loginResponse', 'urn:partner.soap.sforce.com')
             .getChildElement('result', 'urn:partner.soap.sforce.com');
        
            //-------------------------------
            // Grab session id and server url
            //--------------------------------
             final String SERVER_URL = resultElmt.getChildElement('serverUrl', 'urn:partner.soap.sforce.com') .getText().split('/services')[0];
             final String SESSION_ID = resultElmt.getChildElement('sessionId', 'urn:partner.soap.sforce.com') .getText();
             system.debug('Hello SERVER URL'+SERVER_URL);
             system.debug('Hello SESSION Id'+SESSION_ID);
            integer i =0;
         
         
         string xmlvalue ='<?xml version="1.0" encoding="UTF-8"?><jobInfo xmlns="http://www.force.com/2009/06/asyncapi/dataload"><operation>insert</operation><object>Lead</object><contentType>CSV</contentType></jobInfo>';
       Http hLLogin = new Http();
       HttpRequest request1 = new HttpRequest();
        request1.setEndpoint(SERVER_URL+'/services/async/27.0/job');
        request1.setMethod('POST');
        request1.setHeader('X-SFDC-Session:',SESSION_ID);
        request1.setHeader('Content-Type','application/xml');
        request1.setHeader('charset','UTF-8');
        request1.setBody(xmlvalue); 
         Dom.XmlNode resultElmt1 = (new Http()).send(request1).getBodyDocument().getRootElement();
         string jobId= walkThrough(resultElmt1);
         
         
          values = 'FirstName,LastName,Company,Phone,Rating,Title,Email,LeadSource,Description'+'\n';
           for(BoothVisitSummary__c c:[Select  b.ScannedTime__c, b.ScanTime__c, b.Name, b.Mrecordid__c, b.LastModifiedDate, b.ImageData__c, b.Id, b.Follow_Update__c, b.EA_AttendeeBarcode__c, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c, b.AttachmentId__c, b.AS_ImageUrl__c From BoothVisitSummary__c b where Id IN :bVSids]){
             string abf =c.BVS_FirstName__c+','+c.BVS_LastName__c+',"'+c.BVS_Company__c+'",'+c.BVS_PhoneNumber__c+','+c.BVS_LeadRating__c+','+c.BVS_Title__c+','+c.BVS_Email__c+','+'salesforce'+','+c.BVS_Notes__c+'\n';
             values +=abf;
              }
       
        system.debug('44444444444444444 '+values );   
     
     
        Http hLLogin2 = new Http();
        HttpRequest request2= new HttpRequest();
        request2.setEndpoint(SERVER_URL+'/services/async/27.0/job/'+jobId+'/batch');
        request2.setMethod('POST');
        request2.setHeader('X-SFDC-Session:',SESSION_ID);
        request2.setHeader('Content-Type','text/csv');
        request2.setHeader('charset','UTF-8');
        request2.setBody(values ); 
       Http hLLogin3 = new Http();
       
      HttpResponse resLLogin = hLLogin3.send(request2);
        
        
        
        //   }catch (exception e){
         
         
        // }
            
     
    return null;
    
    }   
    
    
   public String results12 ;
    public String walkThrough(DOM.XMLNode node) {
  
  if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
    if(node.getName()=='Id'){
    
    if(node.getText() != null){
       results12 =  node.getText().trim();
       system.debug('hiiiiiiiiiiiiiiiii '+results12 ); 
    
    }
   }
  }
  for (Dom.XMLNode child: node.getChildElements()) {
   walkThrough(child);
  }

  
  return results12 ;  //should never reach here 
}  
      
    
    
}
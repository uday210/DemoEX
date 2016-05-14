public class PaypalPrymentscon{

public  string amount{get;set;}
public  string FirstName{get; set; }
public  string LastName{get; set; }
public  string Addy1{get; set; }
public  string Addy2{get; set; }
public  string Country{get; set; }
public  string CardType{get; set; }
public  string CardNo{get; set; }
public  string expMo{get; set; }
public  string expYe{get; set; }
public  string CVV{get; set; }
public  string city{get; set; }
public  string state{get; set; }
public  string zip{get; set; }
public  string payer{ get; set; }

public  string transid {get; set;}
public  string message {get; set; }
public  string err {get; set; }
public  string rawResponse {get; set; }
public  string rawResponse1 {get; set; }
public  String result {set;get;}
public  String result1 {set;get;}
public  string transid1 {get; set;}
public string pay{get;set;}


public PaypalPrymentscon(){
/**
city = 'dddd';
state = 'CA';
zip = '1233';
CVV = '';
expYe = '2018';
expMo = '05';
CardNo = '4955817800043311';
CardType = 'Visa';
FirstName = 'Ph33333ani';
LastName = '2222';
Country = 'US';
Addy1 = '411114';
Addy2 = '1111';
//p.payer = 'soi.ve_1343366860_per@gmail.com';
amount = '150';
**/
}


public string blamount{get;set;}

public boolean doDirectPayment(string expYe,string expMo,string CardNo,string eveamount,string blamount,string FirstName,string LastName)
{ 
 
city = 'Al';
state = 'CA';
zip = '1233';
CVV = '';
expYe = expYe ;
expMo = expMo;
CardNo = CardNo ;
CardType = 'Visa';
FirstName =FirstName ;
LastName = LastName ;
Country = 'US';
Addy1 = '411114';
Addy2 = '1111';
//p.payer = 'soi.ve_1343366860_per@gmail.com';
amount = eveamount;
 blamount= blamount;
 
 // Firtst Request 
  Http h = new Http();
  HttpRequest req = new HttpRequest();
  String url = 'https://api-3t.sandbox.paypal.com/2.0/';
  
 
  string un = 'phani_api1.globalnest.com';
  string pw = '1367819439';
  string sig = 'AFcWxV21C7fd0v3bYYYRCpSSRl31AYuT9SDTIfzZBYAUcdMbCQ6qjAdI';
 
  
  
  String doDirectRequest;
  doDirectRequest =  '<soap:Envelope xmlns:soap=' + '\'' + 'http://schemas.xmlsoap.org/soap/envelope/'  + '\'' + ' xmlns:xsi=' + '\''+ 'http://www.w3.org/2001/XMLSchema-instance'  + '\'' + ' xmlns:xsd=' + '\''+ 'http://www.w3.org/2001/XMLSchema' + '\'' + '>';
  doDirectRequest += '<soap:Header><RequesterCredentials xmlns="urn:ebay:api:PayPalAPI"><Credentials xmlns="urn:ebay:apis:eBLBaseComponents">';
  doDirectRequest += '<Username>' + un + '</Username><ebl:Password xmlns:ebl="urn:ebay:apis:eBLBaseComponents">' + pw;
  doDirectRequest += '</ebl:Password><Signature>' + sig + '</Signature>';
  doDirectRequest += '</Credentials></RequesterCredentials></soap:Header><soap:Body><DoDirectPaymentReq xmlns="urn:ebay:api:PayPalAPI">';
  doDirectRequest += '<DoDirectPaymentRequest><Version xmlns="urn:ebay:apis:eBLBaseComponents">1.00</Version>';
  doDirectRequest += '<DoDirectPaymentRequestDetails xmlns="urn:ebay:apis:eBLBaseComponents">';
  doDirectRequest += '<PaymentAction>Sale</PaymentAction><PaymentDetails><OrderTotal currencyID="USD">' + amount + '</OrderTotal>';
  doDirectRequest += '<ShipToAddress><Name>' + FirstName + ' ' + LastName + '</Name><Street1>' + Addy1 + '</Street1><Street2>' +Addy2 + '</Street2>';
  doDirectRequest += '<CityName>' + city + '</CityName><StateOrProvince>' + state + '</StateOrProvince><PostalCode>' + zip + '</PostalCode>';
  doDirectRequest += '<Country>' + country + '</Country></ShipToAddress>';
  doDirectRequest += '</PaymentDetails><CreditCard><CreditCardType>' + CardType + '</CreditCardType><CreditCardNumber>' + CardNo + '</CreditCardNumber>';
  doDirectRequest += '<ExpMonth>' + expMo + '</ExpMonth><ExpYear>' + expYe + '</ExpYear><CardOwner><PayerStatus>verified</PayerStatus>';
  doDirectRequest += '<PayerName><FirstName>' + FirstName+ '</FirstName><LastName>' + LastName + '</LastName></PayerName><PayerCountry>' + country + '</PayerCountry>';
  doDirectRequest += '<Address><Street1>' + Addy1 + '</Street1><Street2>' + Addy2 + '</Street2><CityName>' + city + '</CityName>';
  doDirectRequest += '<StateOrProvince>' + state + '</StateOrProvince><Country>' + country + '</Country><PostalCode>' + zip + '</PostalCode></Address>';
  doDirectRequest += '</CardOwner><CVV2>' + CVV + '</CVV2></CreditCard></DoDirectPaymentRequestDetails>';
  doDirectRequest += '</DoDirectPaymentRequest></DoDirectPaymentReq></soap:Body></soap:Envelope>';
  
  req.setBody(doDirectRequest);
  
  req.setEndpoint(url);
  req.setMethod('POST');
  req.setHeader('Content-length', '1753' );
  req.setHeader('Content-Type', 'text/xml;charset=UTF-8'); 
  req.setHeader('SOAPAction','');
  req.setHeader('Host','api-aa.sandbox.paypal.com');
  HttpResponse res = h.send(req);
  String xml = res.getBody();
  rawResponse = xml;
  system.debug('555555555555555555555555555 ' + rawResponse);
  XmlStreamReader reader = res.getXmlStreamReader();
  result = readXMLResponse(reader,'Ack');
  reader = res.getXmlStreamReader();
  err = readXMLResponse(reader, 'LongMessage');
  
  if (result == 'Success')
  {
    reader = res.getXmlStreamReader();
    transid = readXMLResponse(reader, 'TransactionID'); 
      system.debug('::' + transid ); 
  }
  else
  {
    result = err;
  }
    System.debug('@@@@@result'+result);
   
   
   
  // ------------------------------ Request 2 -------------------------------------------------- -->
   
 if(transid !=null && transid !=''){  
  Http h1 = new Http();
  HttpRequest req1 = new HttpRequest();
  String url1 = 'https://api-3t.sandbox.paypal.com/2.0/';
  
 
  string un1 = 'laxman_api1.globalnest.com';
  string pw1 = '1367821778';
  string sig1 = 'A7EBmp3YAffU74zdPkXxuzDRZFC9A4yWrpkqoW1vC86mpXUAqelE99Jq';
 
  
  String doDirectRequest2;
  doDirectRequest2 =  '<soap:Envelope xmlns:soap=' + '\'' + 'http://schemas.xmlsoap.org/soap/envelope/'  + '\'' + ' xmlns:xsi=' + '\''+ 'http://www.w3.org/2001/XMLSchema-instance'  + '\'' + ' xmlns:xsd=' + '\''+ 'http://www.w3.org/2001/XMLSchema' + '\'' + '>';
  doDirectRequest2 += '<soap:Header><RequesterCredentials xmlns="urn:ebay:api:PayPalAPI"><Credentials xmlns="urn:ebay:apis:eBLBaseComponents">';
  doDirectRequest2 += '<Username>' + un1 + '</Username><ebl:Password xmlns:ebl="urn:ebay:apis:eBLBaseComponents">' + pw1;
  doDirectRequest2 += '</ebl:Password><Signature>' + sig1 + '</Signature>';
  doDirectRequest2 += '</Credentials></RequesterCredentials></soap:Header><soap:Body><DoDirectPaymentReq xmlns="urn:ebay:api:PayPalAPI">';
  doDirectRequest2 += '<DoDirectPaymentRequest><Version xmlns="urn:ebay:apis:eBLBaseComponents">1.00</Version>';
  doDirectRequest2 += '<DoDirectPaymentRequestDetails xmlns="urn:ebay:apis:eBLBaseComponents">';
  doDirectRequest2 += '<PaymentAction>Sale</PaymentAction><PaymentDetails><OrderTotal currencyID="USD">' + blamount+ '</OrderTotal>';
  doDirectRequest2 += '<ShipToAddress><Name>' + FirstName + ' ' + LastName + '</Name><Street1>' + Addy1 + '</Street1><Street2>' +Addy2 + '</Street2>';
  doDirectRequest2 += '<CityName>' + city + '</CityName><StateOrProvince>' + state + '</StateOrProvince><PostalCode>' + zip + '</PostalCode>';
  doDirectRequest2 += '<Country>' + country + '</Country></ShipToAddress>';
  doDirectRequest2 += '</PaymentDetails><CreditCard><CreditCardType>' + CardType + '</CreditCardType><CreditCardNumber>' + CardNo + '</CreditCardNumber>';
  doDirectRequest2 += '<ExpMonth>' + expMo + '</ExpMonth><ExpYear>' + expYe + '</ExpYear><CardOwner><PayerStatus>verified</PayerStatus>';
  doDirectRequest2 += '<PayerName><FirstName>' + FirstName+ '</FirstName><LastName>' + LastName + '</LastName></PayerName><PayerCountry>' + country + '</PayerCountry>';
  doDirectRequest2 += '<Address><Street1>' + Addy1 + '</Street1><Street2>' + Addy2 + '</Street2><CityName>' + city + '</CityName>';
  doDirectRequest2 += '<StateOrProvince>' + state + '</StateOrProvince><Country>' + country + '</Country><PostalCode>' + zip + '</PostalCode></Address>';
  doDirectRequest2 += '</CardOwner><CVV2>' + CVV + '</CVV2></CreditCard></DoDirectPaymentRequestDetails>';
  doDirectRequest2 += '</DoDirectPaymentRequest></DoDirectPaymentReq></soap:Body></soap:Envelope>';
  
  req1.setBody(doDirectRequest2);
  
  req1.setEndpoint(url1);
  req1.setMethod('POST');
  req1.setHeader('Content-length', '1753' );
  req1.setHeader('Content-Type', 'text/xml;charset=UTF-8'); 
  req1.setHeader('SOAPAction','');
  req1.setHeader('Host','api-aa.sandbox.paypal.com');
  
  HttpResponse res1 =  h1.send(req1);
  String xml1 = res1.getBody();
  rawResponse1 = xml1;
  system.debug(':: 2 ' + rawResponse1);
  
  XmlStreamReader reader1 = res1.getXmlStreamReader();
  result1 = readXMLResponse(reader1,'Ack');
  reader1 = res1.getXmlStreamReader();
  err = readXMLResponse(reader1, 'LongMessage');
  
  if (result1 == 'Success')
  {
    reader1 = res1.getXmlStreamReader();
    transid1= readXMLResponse(reader1, 'TransactionID'); 
    system.debug(':: 2 ' + transid1 ); 
  }
  else
  {
    result1 = err;
  }
    System.debug('@@@@@result 2'+result1);
   
   if(transid1!=null && transid!=null){
       return True;
   }else{
       return false;
   }
 } else{
      

  return false;
 } 
 
   
}


public String readXMLResponse(XmlStreamReader reader, String sxmltag)
{
try{
  string retValue; // Read through the XML
  while(reader.hasNext())
  {
    if (reader.getEventType() == XmlTag.START_ELEMENT)
    {
      if (reader.getLocalName() == sxmltag) {
        reader.next();
        if (reader.getEventType() == XmlTag.characters)
        {
          retValue = reader.getText();
        }
      }
    }
    reader.next();
  }
  return retValue;
   }catch(exception e){return null;}
 }

}
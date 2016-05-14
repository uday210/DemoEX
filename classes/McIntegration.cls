/***************************************************************************************************************************************************************************************************
* Author : Sai Kumar
* Date : 12/30/2014
* Purpose : This class for Integration with Mailchimp inorder to send campaign through Mailchimp
* Last Modified : Sai kumar - 12/30/2014
*****************************************************************************************************************************************************************************************************/

//creating a class with name McIntegration
public with sharing class McIntegration{

public void McIntegration(){
McIntegration();


}

//splitting apikey for instance
public string gettingapi(){

user u = [select id,Name from user where Name='Sai D'];
//Api_key__c ap = [select Name FROM Api_key__c ];
//string apikey = ap.Name;
//system.debug('rrrrrrrrrrrrrr='+apikey);
//return apikey;
return null;

}


public string splitapi(string ak) {

string[] instance;
instance = ak.split('\\-');
System.debug('rrrrrrrrrrrr'+instance[1] );
return instance[1];
}

//gettinglistid() method is created to retrieve a list id associated with that api key
public String gettinglistid(string ak) {

String ListId;
JSONGenerator gn = JSON.createGenerator(true);
gn.writeStartObject();
gn.writeStringField('apikey',ak);
gn.writeEndObject();
String listbody = gn.getAsString();
system.debug('listbody is ============'+listbody);

string apiInstance = splitapi(ak);

HttpRequest req = new HttpRequest();
HttpResponse res = new HttpResponse();
Http http1 = new Http();

req.setEndpoint('https://'+apiInstance+'.api.mailchimp.com/2.0/lists/list');
req.setMethod('POST');
req.setBody(listbody);
res = http1.send(req);
string str = res.getbody();
system.debug('str==================='+str);

//Parsing response to get ListId for late use
JSONParser parser = JSON.createParser(str);
while (parser.nextToken()!= null) {
if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
if(parser.getText() == 'id') {
parser.nextToken();
ListId = parser.getText();
system.debug('ListId is ==========='+ListId);
}
}
}
return ListId;
}
public String creatingSegment(string ak, string campaignname){

string apiInstance = splitapi(ak);
string ListId = gettinglistid(ak);

string SegmentId;

JSONGenerator gn = JSON.createGenerator(true);
gn.writeStartObject();
gn.writeStringField('apikey',ak);
gn.writeStringField('id',ListId);
gn.writeStringField('name','campaignname');
gn.writeEndObject();

String Segmentadd = gn.getAsString();
system.debug('Segmenetaddis============'+Segmentadd);

HttpRequest req = new HttpRequest();
HttpResponse res = new HttpResponse();
Http http1 = new Http();

req.setEndpoint('https://'+apiInstance+'/2.0/lists/static-segment-add');

req.setMethod('POST');
req.setBody(Segmentadd);

res = http1.send(req);
string str = res.getbody();
system.debug('str==================='+str);

//Parsing response to get SegmentId for late use
JSONParser parser = JSON.createParser(str);
while (parser.nextToken()!= null) {
if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
if(parser.getText() == 'id') {
parser.nextToken();
SegmentId = parser.getText();
system.debug('SegmentId is'+SegmentId);
}
}
}
return SegmentId;
}

}
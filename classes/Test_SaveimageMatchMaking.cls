@isTest
public class Test_SaveimageMatchMaking {


static testMethod void testDoGet() {
           
      System.RestContext.request = new RestRequest();
      
      AttendeeSummary__c att2 = new AttendeeSummary__c();
        att2.AS_FirstName__c='re';
        att2.AS_LastName__c ='lo';
        att2.AS_Email__c ='buser3@badmin.com';
        att2.AS_Company__c ='global';
        insert att2;  
      string s =EncodingUtil.base64Encode(blob.valueOf('hi'));
    
    
    
       RestContext.request.requestURI = '/SaveimageMatchMaking';
       RestContext.request.addParameter('id', 'buser3@badmin.com');
       RestContext.request.addHeader('imageurl',s );
       SaveimageMatchMaking.dopost();
        }
   }
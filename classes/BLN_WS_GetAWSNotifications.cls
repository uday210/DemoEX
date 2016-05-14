global class BLN_WS_GetAWSNotifications{

    global class inputsFromPHP{
        webservice String NotificationsJson;
    }

    global class outputForPHP{
        webservice String errorMessage;
        webservice Boolean success;
        webservice ID rddid;
    }
    
    webservice static outputForPHP InsertAwsSnsNotification(String NotificationsJson){
        
      system.debug('Jsons====='+NotificationsJson);       
       
      LIST<AWS_SNS_Notifications__c> awssnsnotifs = new LIST<AWS_SNS_Notifications__c>(); 
       
      MAP<String, String> ms = new MAP<String, String>();      
      
       JSONParser parser = JSON.createParser(NotificationsJson);
       while (parser.nextToken() != null) {
           String MessageId;
           String Destination;
           String Type;
               
           if (parser.getCurrentToken() == JSONToken.START_OBJECT){
           
               system.debug('parser nextToken 333==='+parser.nextToken()+'444==='+parser.getText());
               
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'MessageId')) {
                    parser.nextToken();
                      system.debug('MessageId==='+parser.getText());
                      MessageId = parser.getText();
                    parser.nextToken();
                }
                
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Destination')) {
                    parser.nextToken();
                      system.debug('Destination==='+parser.getText());
                      Destination = parser.getText();
                    parser.nextToken();
                }
                
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Type')) {
                    parser.nextToken();
                    Type = parser.getText();
                      system.debug('Type==='+parser.getText());
                }
                
                ms.put(MessageId , Destination+'###'+Type  );
                
           }
       }
       
       for(AWS_SNS_Notifications__c asn : [SELECT DestinationEmail__c, MessageId__c, NotificationType__c FROM AWS_SNS_Notifications__c WHERE MessageId__c IN: ms.KeySet() ] ){
          
           String[] abc = ms.get(asn.MessageId__c).split('###');           
           asn.DestinationEmail__c = abc[0];
           asn.NotificationType__c = abc[1];
           awssnsnotifs.add(asn);
       }
       database.Update(awssnsnotifs ,False);
       
      return null;
    }
}
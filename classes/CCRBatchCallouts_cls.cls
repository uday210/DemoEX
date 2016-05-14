global class CCRBatchCallouts_cls implements Database.Batchable<AttendeeSummary__c>, Database.AllowsCallouts{

global AttendeeSummary__c[] AttendeesToUpdate;
    
global void fetchccr(set<Id> setOfatts){
 AttendeesToUpdate = [SELECT id,AS_Company__c,AS_Email__c 
                      FROM AttendeeSummary__c 
                      WHERE Id IN :setOfatts];  
                                      
}

global Iterable<AttendeeSummary__c> start(database.batchablecontext BC){
    return (AttendeesToUpdate); 
}

global void execute(Database.BatchableContext BC, List<AttendeeSummary__c> scope){
    try{  
    List<AttendeeSummary__c> listdg=new List<AttendeeSummary__c>();
    Set<AttendeeSummary__c> setdg= new Set<AttendeeSummary__c>();
    List<AttendeeSummary__c> result = new List<AttendeeSummary__c>(); 
    
     // CCR Details Variable Declaration   
   
    
    
    for(AttendeeSummary__c att : scope){
     String CCRCageCode;
    String CCRCompany;
    String CCRDomain;
    String CCREmailId;
    String CCRWebsiteUrl;
    String CCRCellPhone;  
    String CCRBusinessRevenue;
    String CCRBusinessTaxId;
    String CCRBusinessDunsNumber;        
    String CCRNaicsCodes;
    String CCRNaicsCodes1;
    String CCRNaicsCodes2;
    String CCRNaicsCodes3;
    String CCRNaicsCodes4;
    String CCRNaicsCodes5;
    String CCRBusinessEstablishedDate;
    String CCRBusinessEstablishedDate1;   
    String CCRFiscalYearEndDate;
    String CCRWorkAddress1;
    String CCRWorkAddress2;
    String CCRWorkCity;
    String CCRWorkState;
    String CCRWorkCountry;
    String CCRZipCode1;
    String CCRWorkZipCode;
    String CCRPOBox1;
    String CCRPOBox2;
    String CCRPOBox3;
    String CCRWorkPOBox;
    String CCRWorkPhone;
    String CCRHomeAddress1;
    String CCRHomeAddress2;
    String CCRHomeCity;
    String CCRHomeState;
    String CCRHomeCountry;
    String CCRHomeCode1;
    String CCRHomeZipCode;    
    String CCRHomePOBox;
    String CCRHomePhone;
    String CCRMailingAddress1;
    String CCRMailingAddress2;
    String CCRMailingCity;
    String CCRMailingState;
    String CCRMailingCountry;
    String CCRZipCode2;
    String CCRMailingZipCode;
    String CCRMailingPOBox;
    String CCRMailingPhone;       
    
    String CCREmail;  
    String CCRDomainName;
    String CCRData;
     system.debug('ppppppppppppp '+att.id+'AAAAAAAAAAAAAAA '+att.As_email__c);
    
        http h = new http();
        HttpRequest req = new HttpRequest();
        if(att.AS_Email__c.contains('gmail.com') || att.AS_Email__c.contains('yahoo') || att.AS_Email__c.contains('live') || att.AS_Email__c.contains('yahoo')){
            CCRDomainName=att.AS_Company__c;
            if(CCRDomainName != null || CCRDomainName !=''){  
             String encoded = EncodingUtil.urlEncode(CCRDomainName,'UTF-8');   
             req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_100,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_01011959,untitled_27,_16_commerce_blvd_ste_d,_023461030_3,middleboro,ma_5,usa_9,_023461030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023461030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&louis_m_gerson_co_inc_1='+encoded);                     
             req.setHeader('X-App-Token','vJuJxl8Tjb6wvEnDkd0JUJNDf');
             req.setHeader('Content-Type','text/xml');
             req.setMethod('GET');  
             req.setCompressed(true); 
             req.setTimeout(120000);
        
             HTTPResponse res = h.send(req);
             CCRData=res.getBody(); 
            }
        }
        
        else{
            CCRDomainName='*'+att.AS_Email__c.substringAfter('@');
            // CCRDomainName='\''+CCRDomainName+'\'';              
            if(CCRDomainName != null || CCRDomainName !=''){  
                req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_100,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_01011959,untitled_27,_16_commerce_blvd_ste_d,_023461030_3,middleboro,ma_5,usa_9,_023461030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023461030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&$q='+CCRDomainName+'*');         
                req.setHeader('X-App-Token','vJuJxl8Tjb6wvEnDkd0JUJNDf');
                req.setHeader('Content-Type','text/xml');
                req.setMethod('GET');  
                req.setCompressed(true); 
                req.setTimeout(120000);
        
                HTTPResponse res1 = h.send(req);
                CCRData=res1.getBody(); 
            }
        }        
                                   
   if(CCRData.length() <= 3){
         CCRDomainName=att.AS_Company__c;
         if(CCRDomainName != null || CCRDomainName !=''){  
             String encoded = EncodingUtil.urlEncode(CCRDomainName,'UTF-8');   
             req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_100,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_01011959,untitled_27,_16_commerce_blvd_ste_d,_023461030_3,middleboro,ma_5,usa_9,_023461030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023461030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&louis_m_gerson_co_inc_1='+encoded);        
             req.setHeader('X-App-Token','vJuJxl8Tjb6wvEnDkd0JUJNDf');
             req.setHeader('Content-Type','text/xml');
             req.setMethod('GET');  
             req.setCompressed(true); 
             req.setTimeout(120000);  
             
             HTTPResponse res2 = h.send(req);           
             CCRData=res2.getBody();      
         }
        }      
              
        JSONParser parser = JSON.createParser(CCRData);
             
      system.debug('ppppppppppppp QQQQQQQQQQQQQQ  '+CCRData);       
             
        while (parser.nextToken() != null){
        if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){                                          
            String fieldName = parser.getText();
            parser.nextToken();
            if(fieldName == 'louis_m_gerson_co_inc_1') {
                CCRCompany=parser.getText();
            } 
            else if(fieldName == '_26895'){
                CCRCageCode=parser.getText();
            } 
            else if(fieldName == 'custserv_gersonco_com'){
                CCREmailId=parser.getText();
            } 
            else if(fieldName == 'http_www_gersonco_com'){
                parser.nextToken();
                parser.nextToken();
                CCRWebsiteUrl=parser.getText();
            } 
            else if(fieldName == '_20000000'){
                CCRBusinessRevenue=parser.getText();                       
            } 
            else if(fieldName == '_01011959'){
                CCRBusinessEstablishedDate=parser.getText();                     
                if(CCRBusinessEstablishedDate.length()<8){
                    if(Decimal.Valueof(CCRBusinessEstablishedDate.substring(1, 3))<12){
                        CCRBusinessEstablishedDate1 = CCRBusinessEstablishedDate.substring(3,7)+ '-' + CCRBusinessEstablishedDate.substring(1, 3)+ '-' + '0' + CCRBusinessEstablishedDate.substring(0, 1);}
                }
                else if (CCRBusinessEstablishedDate.length()>=8){
                    if(Decimal.Valueof(CCRBusinessEstablishedDate.substring(2, 4))<12){
                        CCRBusinessEstablishedDate1 = CCRBusinessEstablishedDate.substring(4,8)+ '-' +CCRBusinessEstablishedDate.substring(2, 4)+ '-' + CCRBusinessEstablishedDate.substring(0, 2);}
                }
            }                      
            else if(fieldName == 'untitled_27'){
                CCRWorkAddress1=parser.getText();
            } 
            else if(fieldName == '_16_commerce_blvd_ste_d'){
                CCRWorkAddress2=parser.getText();
            } 
            else if(fieldName == 'middleboro'){
                CCRWorkCity=parser.getText();
            }
            else if(fieldName == 'ma_5'){
                CCRWorkState=parser.getText();
            }  
            else if(fieldName == 'usa_9'){
                CCRWorkCountry=parser.getText();
                if(CCRWorkCountry == 'USA'){
                 CCRWorkCountry='United States Of America';
                }
            }
            else if(fieldName == '_023461030_3'){
                CCRWorkZipCode=parser.getText();
            }
            else if(fieldName == '_023461030'){
                CCRPOBox1=parser.getText();
                if(CCRPOBox1.length()>8){
                    CCRWorkPObox=CCRPOBox1.substring(4,8);}
                else
                    CCRWorkPObox=CCRPOBox1;
            } 
            else if(fieldName == '_5089475442_3'){
                CCRWorkPhone=parser.getText();
            }
            else if(fieldName == 'untitled_25'){
                CCRHomeAddress1=parser.getText();
            } 
            else if(fieldName == '_16_commerce_blvd'){
                CCRHomeAddress2=parser.getText();
            } 
            else if(fieldName == 'middleboro_2'){
                CCRHomeCity=parser.getText();
            }
            else if(fieldName == 'ma'){
                CCRHomeState=parser.getText();
            } 
            else if(fieldName == 'usa_2'){
                CCRHomeCountry=parser.getText();
                if(CCRHomeCountry == 'USA'){
                 CCRHomeCountry='United States Of America';
                }
            }
            else if(fieldName == '_023461030_3'){
                CCRHomeZipCode=parser.getText();
                //CCRMailingZipCode=CCRZipCode1.substring(0,4);
            }
            else if(fieldName == '_023461030_6'){
                CCRPOBox2=parser.getText();
                if(CCRPOBox2.length()>8){
                    CCRHomePObox=CCRPOBox2.substring(4,8);}
                else
                    CCRHomePObox=CCRPOBox2;
            } 
            else if(fieldName == '_5089233031_2'){
                CCRHomePhone=parser.getText();
            } 
            else if(fieldName == 'untitled_25'){
                CCRMailingAddress1=parser.getText();
            } 
            else if(fieldName == '_16_commerce_blvd_7'){
                CCRMailingAddress2=parser.getText();
            } 
            else if(fieldName == 'middleboro_2'){
                CCRMailingCity=parser.getText();
            }
            else if(fieldName == 'ma_6'){
                CCRMailingState=parser.getText();
            }  
            else if(fieldName == 'usa_6'){
                CCRMailingCountry=parser.getText();
                if(CCRMailingCountry == 'USA'){
                 CCRMailingCountry='United States Of America';
                }
            }
            else if(fieldName == '_023461030_3'){
                CCRMailingZipCode=parser.getText();
            }
            else if(fieldName == '_023461030'){
                CCRPOBox3=parser.getText();
                if(CCRPOBox3.length()>8){
                    CCRMailingPObox=CCRPOBox3.substring(4,8);}
                else
                    CCRMailingPObox=CCRPOBox3;
            } 
            else if(fieldName == '_5089474000'){
                CCRMailingPhone=parser.getText();
            }
            else if(fieldName == '_8002258623'){
                CCRCellPhone=parser.getText();
            }   
            else if(fieldName == '_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn'){
                CCRNaicsCodes=parser.getText();
                CCRNaicsCodes1=CCRNaicsCodes.substring(0,6);  
                if(CCRNaicsCodes.length()> 8) {
                    CCRNaicsCodes2=CCRNaicsCodes.substring(9,15);}         
                else if(CCRNaicsCodes.length()>15 && CCRNaicsCodes.length()<25) {
                    CCRNaicsCodes3=CCRNaicsCodes.substring(18,24);}
                else if(CCRNaicsCodes.length()>24 && CCRNaicsCodes.length()<33) {
                    CCRNaicsCodes4=CCRNaicsCodes.substring(27,33);}
                else if(CCRNaicsCodes.length()>32 && CCRNaicsCodes.length()<42) {
                    CCRNaicsCodes5=CCRNaicsCodes.substring(36,42);}                 
            }                       
            
        att.isFetched__c=true;
        if(att.AS_Company__c == null || att.AS_Company__c ==''){ att.AS_Company__c=CCRCompany; }
        if(att.AS_CageCode__c == null || att.AS_Company__c ==''){ att.AS_CageCode__c=CCRCageCode;}
        if(att.AS_CellPhone__c == null || att.AS_CellPhone__c ==''){ att.AS_CellPhone__c =CCRCellPhone;}
        if(att.AS_BusinessDunsNumber__c == null || att.AS_BusinessDunsNumber__c ==''){ att.AS_BusinessDunsNumber__c =CCRBusinessDunsNumber;}
        if(att.AS_BusinessTaxId__c == null || att.AS_BusinessTaxId__c ==''){ att.AS_BusinessTaxId__c =CCRBusinessTaxId ;}
        if(att.AS_WebsiteURL__c == null || att.AS_WebsiteURL__c ==''){ att.AS_WebsiteURL__c =CCRWebsiteURL;}
        
        if(att.AS_BusinessRevenue__c == null){
            if(CCRBusinessRevenue!=null && CCRBusinessRevenue!=''){
            att.AS_BusinessRevenue__c =Decimal.ValueOf(CCRBusinessRevenue);
            }
        }
        if(att.AS_BusinessEstablishedDate__c == null){
            if(CCRBusinessEstablishedDate1!=null && CCRBusinessEstablishedDate1!=''){
                att.AS_BusinessEstablishedDate__c=Date.ValueOf(CCRBusinessEstablishedDate1);
            } 
        }
        if(att.AS_NAICSCode1__c == null){
            if(CCRNaicsCodes1!=null && CCRNaicsCodes1!=''){
                att.AS_NAICSCode1__c=Decimal.ValueOf(CCRNaicsCodes1);
            }
        }
        if(att.AS_NAICSCode2__c == null){
            if(CCRNaicsCodes2!=null && CCRNaicsCodes2!=''){
                att.AS_NAICSCode2__c=Decimal.ValueOf(CCRNaicsCodes2);
            }  
        }
        if(att.AS_NAICSCode3__c == null){ 
            if(CCRNaicsCodes3!=null && CCRNaicsCodes3!=''){
                att.AS_NAICSCode3__c=Decimal.ValueOf(CCRNaicsCodes3);
            }  
        }
        if(att.AS_NAICSCode4__c == null){
            if(CCRNaicsCodes4!=null && CCRNaicsCodes4!=''){
                att.AS_NAICSCode4__c=Decimal.ValueOf(CCRNaicsCodes4);
            }  
        }
        if(att.AS_NAICSCode5__c == null){  
            if(CCRNaicsCodes5!=null && CCRNaicsCodes5!=''){
                att.AS_NAICSCode5__c=Decimal.ValueOf(CCRNaicsCodes5);
            }   
        }
        
        
        if(att.AS_ShippingAddress1__c == null || att.AS_ShippingAddress1__c ==''){att.AS_ShippingAddress1__c = CCRMailingAddress1;}
        if(att.AS_ShippingAddress2__c == null || att.AS_ShippingAddress2__c ==''){att.AS_ShippingAddress2__c = CCRMailingAddress2;}
        if(att.AS_shippingCity__c == null || att.AS_shippingCity__c ==''){att.AS_shippingCity__c = CCRMailingCity;}
        if(att.As_Shipping_States__c == null || att.As_Shipping_States__c ==''){ att.As_Shipping_States__c = CCRMailingState; }
        if(att.As_Shipping_Country__c == null || att.As_Shipping_Country__c ==''){att.As_Shipping_Country__c = CCRMailingCountry;}
        if(att.AS_Shippingpoboxno__c == null || att.AS_Shippingpoboxno__c ==''){att.AS_Shippingpoboxno__c = CCRMailingPOBox;}
        if(att.AS_shippingzip__c == null || att.AS_shippingzip__c ==''){att.AS_shippingzip__c = CCRMailingZipCode;}
        if(att.AS_ShippingPhone__c == null || att.AS_ShippingPhone__c ==''){att.AS_ShippingPhone__c = CCRMailingphone;}
        if(att.AS_WorkAddress1__c == null || att.AS_WorkAddress1__c ==''){att.AS_WorkAddress1__c = CCRWorkAddress1;}
        if(att.AS_WorkAddress2__c == null || att.AS_WorkAddress2__c ==''){att.AS_WorkAddress2__c = CCRWorkAddress2;}
        if(att.AS_Workcity__c == null || att.AS_Workcity__c ==''){att.AS_Workcity__c = CCRWorkCity;}
        if(att.AS_Work_States__c == null || att.AS_Work_States__c ==''){att.AS_Work_States__c = CCRWorkState;}
        if(att.AS_Work_Country__c == null || att.AS_Work_Country__c ==''){att.AS_Work_Country__c= CCRWorkCountry;}
        if(att.AS_Workpoboxno__c == null || att.AS_Workpoboxno__c ==''){att.AS_Workpoboxno__c = CCRWorkPOBox;}
        if(att.AS_WorkZip__c == null || att.AS_WorkZip__c ==''){att.AS_WorkZip__c = CCRWorkZipCode;}
        if(att.AS_WorkPhone__c == null || att.AS_WorkPhone__c ==''){att.AS_WorkPhone__c = CCRWorkPhone;}
        if(att.AS_HomeAddress1__c == null || att.AS_HomeAddress1__c ==''){att.AS_HomeAddress1__c = CCRHomeAddress1;}
        if(att.AS_HomeAddress2__c == null || att.AS_HomeAddress2__c ==''){att.AS_HomeAddress2__c = CCRHomeAddress2;}
        if(att.AS_HomeCity__c == null || att.AS_HomeCity__c ==''){att.AS_HomeCity__c = CCRHomeCity;}
        if(att.As_Home_State__c == null || att.As_Home_State__c ==''){att.As_Home_State__c = CCRHomeState;  }
        if(att.As_Home_Country__c == null || att.As_Home_Country__c ==''){att.As_Home_Country__c = CCRHomeCountry;}
        if(att.AS_HomePoboxNo__c == null || att.AS_HomePoboxNo__c ==''){att.AS_HomePoboxNo__c = CCRHomePOBox;}
        if(att.AS_HomeZip__c == null || att.AS_HomeZip__c ==''){att.AS_HomeZip__c= CCRHomeZipCode;  }
        if(att.AS_HomePhone__c == null || att.AS_HomePhone__c ==''){att.AS_HomePhone__c= CCRHomePhone;}
        listdg.add(att);
        } 
       }             
    }
     setdg.addAll(listdg);
     result.addAll(setdg);
    Database.SaveResult[] result1=database.update(result,false);  
     for(Database.SaveResult res:result1){
     }
   }
   catch(Exception ex){
        system.debug(ex.getStackTraceString());
   } 
}

global void finish(Database.BatchableContext BC){
   // Get the ID of the AsyncApexJob representing this batch job from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email
                     FROM AsyncApexJob 
                     WHERE Id =:BC.getJobId()];
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {a.CreatedBy.Email};
   mail.setToAddresses(toAddresses);
   mail.setInReplyTo('support@boothleads.com');
   mail.setSubject('BoothLeads: CCR Details Batch Process ' + a.Status);
   mail.setHTMLBody('The CCR Details Fetch has processed ' + a.JobItemsProcessed + ' batches with '+ a.NumberOfErrors + ' failures.' + '<br/>' +'You can select the failed records manually and try the fetch process again.'+ '<br/>' + '<br/>' + '<br/>' + 'If you have any questions please contact Booth Leads customer support.' + '<br/>' + '' + '<br/>' + '<br/>' +
                 ' Thank you,' + '<br/>' + '<br/>' +
                 'Booth Leads customer support' + '<br/>' +
                 'support@boothleads.com.' + '<br/>' +
                 'Phone: 1-(800)-492-1289.');
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}

}
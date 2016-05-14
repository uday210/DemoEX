@istest
public class Test_BLN_WS_GetAWSNotifications {
    static testmethod void Test_BLN_WS_GetAWSNotifications (){
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
 
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            EmailCampaign__c campaignInfo= new EmailCampaign__c();
            campaignInfo= globalTest.createEmailCampaign(eventInfo);
            AWS_SNS_Notifications__c awsInfo= new AWS_SNS_Notifications__c();
            awsInfo.DestinationEmail__c= 'manasa1243@gmail.com';
            awsInfo.Email_Campaign_Id__c= campaignInfo.Id;
            awsInfo.Event_Id__c= eventInfo.Id;
            awsInfo.MessageId__c= 'Type';
            awsInfo.NotificationType__c= 'Delivery';
            insert awsInfo;
            
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestRequest req = new RestRequest(); 
            
            req.requestURI = sfbaseURL+'/services/apexrest/BLN_WS_GetAWSNotifications';  
            req.httpMethod = 'POST';
            //string bodys= '[{"tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "a0tc0000002coCMAAY","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}]';
           
            string bodys = '{"MessageId" : "Type","Destination":"Dev", "Type" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
            blob b = blob.valueOf(bodys);
            req.requestBody  = b;
            RestContext.request = req;
            
           
             BLN_WS_GetAWSNotifications BLNObj1 = new BLN_WS_GetAWSNotifications();
            
            BLN_WS_GetAWSNotifications.inputsFromPHP blinp = new BLN_WS_GetAWSNotifications.inputsFromPHP();
            
            BLN_WS_GetAWSNotifications.outputForPHP blout = new BLN_WS_GetAWSNotifications.outputForPHP();
            
              String   s='{"MessageId":"Type","Destination":"testing","Type":"testing"}';
              
            try{
                BLN_WS_GetAWSNotifications.InsertAwsSnsNotification(s);
                
                    
            }catch(Exception Ex){ }
            
            }
            }  
            }
/**
author        : Phani Kumar Ch
date          : 20 JAN, 2015
description   : This is the main Lib class which handles and contains all methods representing 
                transaction related to authorize.net, you first need to set your merchant login and transkey
                then call transaction method then process method.
*/
public class AuthorizeDotNet{
// issue 33 durga
// issue 32 durga
// issue31 durga
// issue34 durga 2
    // Test By Phani
    //Set Merchant's Login id and transaction key
    string login = '';
    string transkey = '';
    
    //Class level useful variables
    private list<string> results;
    private boolean approved;
    private boolean declined;
    private boolean error;
    private string url;
    private boolean isTest;
    private string fields;
    public string response;
    private map<string, string> params;
    
    public static Boolean runningInASandbox() {
       return [SELECT Id, IsSandbox FROM Organization LIMIT 1].IsSandbox;
    }
    public AuthorizeDotNet(boolean isTest, String LoginId, String TransactionKey){
        login = LoginId;
        transkey = TransactionKey;
        results = new list<string>();
        approved = false;
        declined = false;
        error    = true;
        fields = '';
        params = new map<string, string>();
        
        //For setting sandbox or production
        this.isTest = isTest;
        if (!runningInASandbox()){
           this.url = 'https://secure.authorize.net/gateway/transact.dll';
        }
        else {
             this.url = 'https://test.authorize.net/gateway/transact.dll';
        }

  
          system.debug('#### ' +login +'@@@@@@@@@ '+transkey );       
        //Some Predefined useful parameters for authorize.net API
        params.put('x_delim_data', 'TRUE');
        params.put('x_delim_char', '|');
        params.put('x_relay_response', 'FALSE');
        params.put('x_url', 'false');
        params.put('x_version', 'false');
        params.put('x_method', 'CC');
        params.put('x_type', 'AUTH_CAPTURE');
        params.put('x_login', login);
        params.put('x_tran_key', transkey);
        params.put('x_description', 'Sample Transaction');
        params.put('x_description', '0');            
        params.put('x_version','3.1');
        // params.put('x_address ','');
        
    }
 
     public AuthorizeDotNet(boolean isTest,string eventid){
        results = new list<string>();
        approved = false;
        declined = false;
        error    = true;
        fields = '';
        params = new map<string, string>();
        
        List<Pay_Pal_Account__c> paycredentials =  [select Email_Id__c,Payment_Type__c,AuthorizationDotNet__c,StripeKey__c,AuthorizationDotNetKey__c,Fee_Payer__c,Account_types__c,OurEmail__c,Accept_check__c,check_amount_Minimum__c,Check_Address__c,isTest__c from Pay_Pal_Account__c where Event__c=:eventid];
            login = paycredentials[0].AuthorizationDotNet__c; 
            transkey = paycredentials[0].AuthorizationDotNetKey__c; 
        
        //For setting sandbox or production
       // this.isTest = isTest;
        if (paycredentials[0].isTest__c){
            this.url = 'https://test.authorize.net/gateway/transact.dll';
        }
        else {
            this.url = 'https://secure.authorize.net/gateway/transact.dll';
        }
        
     
        
        //Some Predefined useful parameters for authorize.net API
        params.put('x_delim_data', 'TRUE');
        params.put('x_delim_char', '|');
        params.put('x_relay_response', 'FALSE');
        params.put('x_url', 'false');
        params.put('x_version', 'false');
        params.put('x_method', 'CC');
        params.put('x_type', 'AUTH_CAPTURE');
        params.put('x_login', login);
        params.put('x_tran_key', transkey);
        params.put('x_description', 'Sample Transaction');
        params.put('x_description', '0');            
        params.put('x_version','3.1');
    }
    
    public void transaction(string cardnum, string expiration, string amount, string cvv, string invoice, string tax){
        params.put('x_card_num', cardnum);
        params.put('x_exp_date', expiration);
        params.put('x_amount', amount);
        params.put('x_po_num', invoice);
        params.put('x_tax', tax);
        params.put('x_card_code', cvv);       
    }
    
    //Calls the Authorize.Net service and fetch the response
    public void process(integer retries){
        retries = 3;
        system.debug('************* '+params);
        this.prepareParameters();
                
        integer count = 0;
        while (count < retries){
            HttpRequest hReq = new HttpRequest();
            hReq.setEndpoint(this.url);
            hReq.setMethod('POST');
            hReq.setBody(this.fields);
            Http con = new Http();
            if(!Test.isRunningTest()){
                HttpResponse res = con.send(hReq);
                this.response = res.getBody();
            }else{
                //Test response filling in case Test class is running
                this.response = '1|1|1|This transaction has been approved.|LDV9JR|Y|2160295577||0|600.00|CC|auth_capture||aslam|bari||dfsdf||wa|5555||||||||||||||||||71AFA2003D02930E47E84F23E14E07C3|P|2|||||||||||XXXX1111|Visa|||||||||||||||||false|1';
            }
            system.debug('#### ' + this.response);
            this.parseResults();
            if (this.getResultResponseFull() == 'Approved'){
                this.approved = true;
                this.declined = false;
                this.error    = false;
                break;
            }
            else if (this.getResultResponseFull() == 'Declined'){
                this.approved = false;
                this.declined = true;
                this.error    = false;
                break;
            }
            count++;
        }
    }

    private void parseResults(){
        this.results = this.response.split('\\|');
    }

    public void setParameter(String param, String value){
       system.debug('XXXXXXXXX '+param+' YYYYYYYYY '+value);
        param                = param.trim();
        value                = value.trim();
        this.params.put(param, value);
    }

    public void setTransactionType(String types){
        this.params.put('x_type', types.toUpperCase().trim());
    }

    private void prepareParameters(){
     system.debug('$$$$$$$$$$ '+params.keyset());
     
        for(String ss: params.keyset()){
            this.fields += ss + '=' +  EncodingUtil.UrlEncode(params.get(ss),'UTF-8') + '&';
        }
        this.fields = this.fields.substring(0,this.fields.length() - 1);
        system.debug('************  '+fields );
    }

    public string getResultResponse(){
        return this.results[0];
    }

    public string getResultResponseFull(){
        list<string> response = new list<string>();
        response.add('');
        response.add('Approved');
        response.add('Declined');
        response.add('Error');
        if(this.results[0] == '1')
            return response[1];
        else if(this.results[0] == '2')
            return response[2];
        else if(this.results[0] == '3')
            return response[3];
        
        return '';
    }

    public boolean isApproved(){
        return this.approved;
    }

    public boolean isDeclined(){
        return this.declined;
    }

    public boolean isError(){
        return this.error;
    }

    public string getResponseText(){
        return this.results[3];
    }

    public string getAuthCode(){
        return this.results[4];
    }

    public string getAVSResponse(){
        return this.results[5];
    }

    public string getTransactionID(){
        return this.results[6];
    }
    
    //Last 4 digits of credit card
    public String getlast4(){
       //if(results[50].length()>5)
       System.debug('KKKKKKKKKKK '+results[50]);
       try{
           return results[50].substring(results[50].length()-4,results[50].length());
       }catch(exception er){
         return '';
       }
       
    }
  //Credit card type  
     public string getSelectedCardType(){
        return this.results[51];
    }

}
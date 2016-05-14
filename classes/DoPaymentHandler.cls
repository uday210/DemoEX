/**
author        : Phani
date          : 20 JAN, 2015
description   : The class is the controlling for DoPayment VF page. It handles the all form fields
                and gives to AuthorizeDotNet class to process the actual payment.
*/
public class DoPaymentHandler{

    public PageReference displatvalues() {
     paypalbool = false;
     authrizationbool = false;
     if(country=='Paypal'){
     paypalbool =true;
     }else if(country=='Authorization.Net'){
         authrizationbool = true;
     }
    
    
    
        return null;
    }

    public string amount{get;set;}
    public string firstname{get;set;}
    public string description{get;set;}
    public string lastname{get;set;}
    public string email{get;set;}
    public string address{get;set;}
    public string city{get;set;}
    public string state{get;set;}
    public string phone{get;set;}
    public string company{get;set;}
    public string zip{get;set;}
    public string cardholder{get;set;}
    public string cardnumber{get;set;}
    public string cardyear{get;set;} 
    public string cardmonth{get;set;}
    public string cardcvv{get;set;}
    public string expiration{get;set;}
    public string selectedCardType{get;set;}
    public string eventid{get;set;}    
        
    public boolean isSuccess{get;set;}
    
    public boolean paypalbool{get;set;}
    
    public boolean authrizationbool{get;set;}
    
    
    public DoPaymentHandler(){
       paypalbool = false;
       authrizationbool = false;
    }
   
    
    
     public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Paypal','Paypal')); 
        options.add(new SelectOption('Authorization.Net','Authorization.Net')); 
        return options; 
    }
              
              
    public string country{get;set;}           
 
    
    
    public List<SelectOption> getMonths(){
       list<SelectOption> months = new list<SelectOption>();
       months.add(new selectOption('01','Jan'));
       months.add(new selectOption('02','Feb'));
       months.add(new selectOption('03','Mar'));
       months.add(new selectOption('04','Apr'));
       months.add(new selectOption('05','May'));
       months.add(new selectOption('06','Jun'));
       months.add(new selectOption('07','Jul'));
       months.add(new selectOption('08','Aug'));
       months.add(new selectOption('09','Sep'));
       months.add(new selectOption('10','Oct'));
       months.add(new selectOption('11','Nov'));
       months.add(new selectOption('12','Dec'));
       return months;
    }
    
    public List<SelectOption> getYears(){
       list<SelectOption> years = new list<SelectOption>();
       integer curMonth = system.today().year();
       for(integer i=1;i<10;i++){
           years.add(new selectOption(curMonth + '',curMonth++ + ''));
       }
       return years;
    }
    
      public List<SelectOption> getCardTypes(){
       list<SelectOption> cardtype = new list<SelectOption>();
       cardtype.add(new selectOption('Visa','Visa'));
       cardtype.add(new selectOption('Master Card','Master Card'));
       cardtype.add(new selectOption('American Express','American Express'));
       return cardtype;
    }
    
    public string message {get;set;}
    
    
    //Handling payment processing submitting by VF page button
    public string process(){
       isSuccess = false;
        expiration = cardmonth + cardyear;
        
        if(!validate()){
            isSuccess = false;
            return null;
        }
       
       AuthorizeDotNet ath = new AuthorizeDotNet(true,eventid);
        ath.transaction(cardnumber, expiration, amount, cardcvv,'','');  
        ath.setParameter('x_device_type','1');  
        ath.setParameter('x_first_name',firstname);  
        ath.setParameter('x_last_name',lastname); 
        if(address!=null&&address!='') 
        ath.setParameter('x_address',address); 
        if(state!=null&&state!='')  
        ath.setParameter('x_state',state); 
        if(company!=null&&company!='')  
        ath.setParameter('x_company',company);
        if(city!=null&&city!='') 
        ath.setParameter('x_city',city);
        if(country!=null&&country!='') 
        ath.setParameter('x_country',country);
        if(phone!=null&&phone!='') 
        ath.setParameter('x_phone',phone);
        ath.setParameter('x_response_format','1'); 
        if(zip!=null&&zip!='')  
        ath.setParameter('x_zip',zip);
        if(description!=null&&description!='')  
        ath.setParameter('x_description',description);
        try{
            ath.process(3);
        }catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage())); 
            message = ex.getMessage();
            isSuccess = false;
        }
        
        if(ath.isApproved()){
            String responsetext = ath.getResponseText();
            String transactionid = ath.getTransactionID();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info, responsetext + '\nTransaction Id: ' + transactionid )); 
             message =transactionid ;
            isSuccess = true;
        }
        else if(ath.isDeclined()){
            String reason = ath.getResponseText();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, reason)); 
            message = reason;
            isSuccess = false;
        }
        else{
            String reason = ath.getResponseText();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, reason)); 
             message = reason;
            isSuccess = false;
        }
        
        return  message ;
    }
    
    private boolean validate(){
        boolean isvalid = true;
        if(!isValid(amount)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: Amount')); 
            isvalid = false;
        }
        if(!isValid(cardnumber)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: Card Number')); 
            isvalid = false;
        }
        if(!isValid(expiration)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: Expiration Date')); 
            isvalid = false;
        }
        if(!isValid(cardcvv)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: CVV Number')); 
            isvalid = false;
        }
        if(!isValid(firstname)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: First Name')); 
            isvalid = false;
        }
        if(!isValid(lastname)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: Last Name')); 
            isvalid = false;
        }
      /*  if(!isValid(address)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: Address')); 
            isvalid = false;
        }
        if(!isValid(state)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: State')); 
            isvalid = false;
        }
        if(!isValid(zip)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Field Missing: Zip')); 
            isvalid = false;
        }
        */
        return isvalid;
    
    }
    
    private boolean isValid(string val){
        return val == null ? false : val.trim().length() == 0 ? false: true;
    }
}
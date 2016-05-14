public with sharing class AttendeePackageInfoCls {

 
/*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   :AttendeePackageInfoCls self registered user with paypal integration
 */


public boolean Resultant{get;set;}
public String DeviceLimit{get;set;}
public String Leads{get;set;}
public String PortalAccess{get;set;}
public String Amount{get;set;}
public String discount{get;set;}
public String MobileAppAccess{get;set;}
public String PackageName{get;set;}
public String TotalAmount{get;set;}
public String s{set;get;}
public Boolean paymentBool{get;set;}
// Credit Card Details 
public String CardType{get;set;}
public String CardNumber{get;set;}
public String CardHolderName{get;set;}
public String ExpMonth{get;set;}
public  String ExpYear{get;set;}
public String SecurityCode{get;set;}
//Billing Address
public String Bname{get;set;}
Public String BFirstName{get;set;}
public String BLastName{get;set;}
public  String Bcompany{get;set;}  
public String Baddress1{get;set;}
public String Baddress2{get;set;}
Public String BCity{get;set;}
public String BState{get;set;}
public String Bzip{get;set;}
public String Bphone{get;set;}
public String Bemail{get;set;}
public  AttendeeSummary__c AttSummary{get;set;}
public User AttUser{get;set;}
//Pricing Information
Public BL_Pricing__c PriceType;
 //String s = 'blue';

 public String getString() {
 return s;
 }
                        
    public void setString(String s) {
    System.debug('@@@@@String'+s);
    this.s = s;
    PackageDetails();
    }



//Paypal Response


public String  Message{get;set;}
Public String TransactionId{get;set;} 
public pagereference PackageDetails(){
//s = 'Attendee-Package'; 
Resultant = false;
Id Attid =ApexPages.currentpage().getParameters().get('id');
 
    if(s.contains('None')){
         Leads = ''; 
         DeviceLimit= '';
         PortalAccess ='';
         Amount= '';
         discount = '';
         MobileAppAccess = '';
         PackageName = '';
         paymentBool=false; 
    }
    
    
    if(!(s.contains('None'))){
         PriceType =[Select BLP_BoothLimit__c,BLP_DeviceLimit__c,BLP_Discount__c,BLP_Leads__c,BLP_Amount__c,BLP_Applicable__c,BLP_MobileAppAccess__c,
         
                                  PackageName__c,BLP_PortalAccess__c,BLP_TotalDeviceLimit__c,PR_Type__c,BLP_UserLimit__c  from BL_Pricing__c where PackageName__c=:s];
         
         Leads = PriceType.BLP_Leads__c; 
         DeviceLimit=  String.ValueOf(PriceType.BLP_DeviceLimit__c);
         PortalAccess = PriceType.BLP_PortalAccess__c;
         Amount=String.ValueOf(PriceType.BLP_Amount__c);
         discount = String.ValueOf(PriceType.BLP_Discount__c);
         MobileAppAccess = PriceType.BLP_MobileAppAccess__c;
         PackageName = PriceType.PackageName__c;
         
         if(PriceType.BLP_Discount__c != null){
         TotalAmount =String.valueOf(PriceType.BLP_Amount__c -((PriceType.BLP_Amount__c*PriceType.BLP_Discount__c)/100));
         }
         System.debug('@@@@@PriceTye'+PriceType);
         paymentBool =true;
            
     if(Attid != null){    
         
    AttSummary = [Select AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Email__c,AS_CellPhone__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingState__c,AS_ShippingZipcode__c from AttendeeSummary__c where id=:Attid];
    BFirstName =  AttSummary.AS_FirstName__c;
    BLastName =  AttSummary.AS_LastName__c;
    Bcompany = AttSummary.AS_Company__c;
    Baddress1 = AttSummary.AS_ShippingAddress1__c;
    Baddress2 = AttSummary.AS_ShippingAddress2__c;
    BCity   = AttSummary.AS_ShippingCity__c;
    Bzip =  String.valueOf(AttSummary.AS_ShippingZipcode__c);
    BState = AttSummary.AS_ShippingState__c;
    Bphone = AttSummary.AS_CellPhone__c;
    Bemail = AttSummary.AS_Email__c;
    }
    
  }
  return null;
}



 public PageReference Cancel() {
        return null;
    }


    public PageReference Paynow() {


      PaypalProccessor Payprocess =new PaypalProccessor();
      System.debug('222222222222222222222');
      Payprocess.FirstName = BFirstName;
      Payprocess.LastName = BLastName;
      Payprocess.Addy1 =  Baddress1;
      Payprocess.Addy2 = Baddress2;
      Payprocess.city = BCity;
      Payprocess.state  = BState;
      Payprocess.zip  = Bzip;
      Payprocess.CardType= CardType;
      Payprocess.CardNo= CardNumber;
      Payprocess.expMo= ExpMonth;
      Payprocess.expYe= ExpYear;
      Payprocess.CVV= SecurityCode;
      PayProcess.amount = TotalAmount;  
      System.debug('@@@@@TotalAmount'+PayProcess.amount);
      Payprocess.pay();  
      Message  = Payprocess.message;
      TransactionId  = Payprocess.transid;
      if(Message.Contains('Success')){
      createCustomerPortalUser();
      } 
      Resultant = true;
      return null;
    }







public  void createCustomerPortalUser(){
 Profile p = [select Id,Name from Profile where Name = 'Attendee'];
       
     Id Attid =ApexPages.currentpage().getParameters().get('id');  
     
     AttSummary = [Select AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Email__c,AS_CellPhone__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingState__c,AS_ShippingZipcode__c from AttendeeSummary__c where id=:Attid]; 
     system.debug('@@@@@p'+p); 
   
            Account a = new account(Name='aaaa');
            insert a;
            Contact Contact = new Contact();
            Contact.Lastname = AttSummary.AS_LastName__c; 
            Contact.AccountID =a.id;   
            insert Contact;
               
            AttUser= new User();
            AttUser.ContactID = Contact.id;
            AttUser.FirstName = AttSummary.AS_FirstName__c;
            AttUser.LastName = AttSummary.AS_LastName__c;
            AttUser.Username = AttSummary.AS_Email__c;
            AttUser.Email = AttSummary.AS_Email__c;
            AttUser.Alias = 'Attends';
            AttUser.ProfileID = P.id;
            AttUser.LocaleSidKey = 'en_US';
            AttUser.LanguageLocaleKey = 'en_US';
            AttUser.TimeZoneSidKey = 'America/Los_Angeles';
            AttUser.EmailEncodingKey='UTF-8';
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.EmailHeader.triggerUserEmail = true;
            AttUser.setOptions(dmo);
            insert AttUser; 
            System.debug('@@@@@AttUser'+AttUser);
     }

 


public  pagereference okbutton(){
pagereference pf = new pagereference('http://www.boothleads.com');
pf.setRedirect(true);
return pf;
}



static testMethod void resttest(){

AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
insert attSummary;

BL_Pricing__c blprice = new BL_Pricing__c(PackageName__c='MyFirstPackage',BLP_DeviceLimit__c=9,BLP_PortalAccess__c='true',BLP_Amount__c=9999999,BLP_Discount__c=10,BLP_MobileAppAccess__c='true');
insert blprice ;

pagereference pageRef=page.QRCode_Headertemplate;
Test.setCurrentPage(pageRef);

AttendeePackageInfoCls  attcla = new AttendeePackageInfoCls();
attcla.okbutton();
attcla.s = 'MyFirstPackage';
ApexPages.currentpage().getParameters().put('id',attSummary.id);
attcla.PackageDetails();

attcla.createCustomerPortalUser();
attcla.Cancel();


attcla.BFirstName='phani';

attcla.s='None,kljk';
attcla.PackageDetails();

}




}
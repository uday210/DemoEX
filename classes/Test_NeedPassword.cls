@istest
private class Test_NeedPassword{

static testMethod void testRest() {
contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
       user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
       emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
       localesidkey='en_US',country='United States',
       timezonesidkey='America/Los_Angeles', username='abc@boothleads.com',password__c = 'pass',CompanyName='Nest',Title='dev');
       insert u;
       string pwd;
       MM_NeedPasswordCon np= new MM_NeedPasswordCon();
       np.username ='abc@boothleads.com';
       np.forgotPassword();
       
       QRCode_NeedPasswordCon Qn= new QRCode_NeedPasswordCon();
       Qn.username ='abc@boothleads.com';
       Qn.forgotPassword();
       
       u.issignup__c =true;
       update u;
       np.forgotPassword();
       Qn.forgotPassword();
       
       np.username ='abc3@boothleads.com';
       np.forgotPassword();
       
        Qn.username ='abc3@boothleads.com';
       Qn.forgotPassword();
       
       
       np.loginpage() ;
      
       
    }   
       
}
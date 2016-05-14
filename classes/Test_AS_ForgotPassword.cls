@istest
private class Test_AS_ForgotPassword{

    static testMethod void testRest() {
        contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
        insert m;
        
        Profile w = [select id from profile where name='Standard User'];
        
        user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
        emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='boothadmin@boothleads.com',CompanyName='Nest',Title='dev');
        insert u;
        
        user u1= new User(alias = 'busers', email='boothadmineadmin@boothleads.com',
        emailencodingkey='UTF-8',isactive=false,profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='boothadmineadmin@boothleads.com',CompanyName='Nest',Title='dev');
        insert u1;
        
        string pwd;
        try{
            System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
            u.password__c =rt.getPassword();
            update u;
            pwd =rt.getPassword();
        }
        catch(exception e){}
        System.RestContext.request = new RestRequest();
        RestContext.request.addParameter('Username', 'boothadmin@boothleads.com');
        AS_ForgotPassword.doGet(); 
        RestContext.request.addParameter('Username', 'boothadmineadmin@boothleads.com');
        AS_ForgotPassword.doGet(); 
        RestContext.request.addParameter('Username', 'boothadmin123@boothleads.com');
        AS_ForgotPassword.doGet(); 
    }         
}
@isTest(seeAlldata=true)
public class Test_BLN_ResetPasswordCon{
    static testmethod void Test_BLN_ResetPasswordCon(){
    test.startTest();
    BLN_ResetPasswordCon sb =  new BLN_ResetPasswordCon();
      sb.oldPassword = 'hello';
     sb.newPassword = 'hii';
     sb.verifyNewPassword = 'hii';   
     sb.myticket = new BLN_UtillDisplayLinks(); 
     sb.se= new BLN_Event__c(); 
    sb.booleanforDisplayBoothadminTab = true;
    sb.successbool = true;
    sb.EventId = 'test';
    //sb.changePassword() change = sb.changePassword();
    //change.loggedid = UserInfo.getUserId();
    sb.success =system.Site.changePassword('test', 'test', 'test123');
    //PageReference pageRef2success = new PageReference('http://www.google.com');
    //sb.success=pageRef2success;
    sb.successbool = true;
    PageReference pageRef = Page.BLn_profile;
    Test.setCurrentPage(pageRef);
    pageRef.getParameters().put('id',sb.EventId);
    sb.changePassword();
    
    BLN_ResetPasswordCon sbc =  new BLN_ResetPasswordCon();
     PageReference pageRef1 = Page.BLn_profile;
    Test.setCurrentPage(pageRef1);
    pageRef1.getParameters().put('id','testId');
      sbc.back();
    
    test.stopTest();
    }
    
    static testmethod void Test_BLN_ResetPasswordCon2() {
    
    
    BLN_ResetPasswordCon sbp =  new BLN_ResetPasswordCon();
    User u = [SELECT Id,UserType FROM user WHERE UserType='guest' limit 1]; 
        
    if(userInfo.getUserType()==u.usertype)
    {
    PageReference pageRef2 = Page.BLN_Signup;
    Test.setCurrentPage(pageRef2);
    
    
    }
      test.startTest();
    sbp.checkUserId();
    test.stopTest();
    
    }
 }
/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
@IsTest public with sharing class CommunitiesSelfRegControllerTest {
    @IsTest(SeeAllData=true) 
    public static void testCommunitiesSelfRegController() {
        CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
        controller.firstName = 'FirstName';
        controller.lastName = 'LastName';
        controller.email = 'testsd@force.com';
        controller.password = 'sri@1234';
       // controller.communityNickname = 'test';
        controller.registerUser();
        // registerUser will always return null when the page isn't accessed as a guest user
        //System.assert(controller.registerUser() == null);    
        
        
       // controller.confirmPassword = 'abcd123';
       // System.assert(controller.registerUser() == null);  
    }    
}
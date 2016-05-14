public with sharing class CustomLandingController {
// Code we will invoke on page load.
    public PageReference forwardToCustomAuthPage() {
        if(UserInfo.getUserType() == 'Guest'){
            return new PageReference('/CustomLogin');
        }
        else{
            return null;
        }
    }
    public CustomLandingController() {}
}
public with sharing class ASC_CustomLandingController {
    // Code we will invoke on page load.
    public PageReference forwardToCustomAuthPage() {
        if(UserInfo.getUserType() == 'Guest'){
            return new PageReference('/ASC_CustomLogin');
        }
        else{
            return null;
        }
    }
    public ASC_CustomLandingController() {}

}
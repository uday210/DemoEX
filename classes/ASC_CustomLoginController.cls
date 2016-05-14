/**
 * An apex page controller that exposes the site login functionality
 */
public with sharing class ASC_CustomLoginController{
    public String username{get;set;}
    public String password{get;set;}
    public String urlVal{get; set;}
    public String ida{get; set;}
    public String error{get; set;}
    public string uinit{set;get;}
    public ASC_CustomLoginController() {
        uinit=ApexPages.currentPage().getParameters().get('uname');
        if(uinit != null && uinit != '')
        {
            username=uinit ;
        }
    }   
    public PageReference forwardToCustomAuthPage() {
        return new PageReference( 'ASC_CustomLogin');
    }
    
    public PageReference login() {
        PageReference pf = Site.login(username, password, null);
        If(pf == null){
            error = 'Username or password incorrect';
            return null;
        }else{
            return pf;
        }
    }
    
    public PageReference signup() {
        return new PageReference('ASC_CommunitiesSelfReg');
    }

}
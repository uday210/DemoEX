/**
 * An apex page controller that exposes the change password functionality
 */
public with sharing class ChangePasswordController {
	
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public String error{get; set;}
    public Boolean ResetPasswordDiv{get; set;}
    public string tablabel {get; set; }
    
    public BLN_UtillDisplayLinks Util {get; set; }
    
    public ChangePasswordController(){
    	Util = new BLN_UtillDisplayLinks();
    	Util.tablabel = 'Change Password';
    } 
    
    public PageReference changePassword() {
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);
    }
    
    public PageReference ResetPassword(){
    	if(newPassword == verifyNewPassword){
    		return Site.changePassword(newPassword, verifyNewPassword);
    	}else{    		
    		error = 'New Password and Verify Passsword must be same.';
    		return null;
    	}	
    	
    }
	
	public PageReference redirect() {
    system.debug('PPPPPPPPPPPPPPPPPPP ');
     String  fullUrl =  Site.getBaseUrl() ; 
        pageReference pg =new pageReference(fullUrl);
        pg.setRedirect(true);
        return pg;
    }
    
   	
}
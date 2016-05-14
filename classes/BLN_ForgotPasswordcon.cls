public without sharing class BLN_ForgotPasswordcon {


	public string tablabel {get; set; }
	
	public BLN_UtillDisplayLinks Util {get; set; }
	
	public BLN_ForgotPasswordcon(){
		Util = new BLN_UtillDisplayLinks();
		Util.tablabel = 'Forgot Password';
	}
	
    public PageReference redirect() {
    system.debug('PPPPPPPPPPPPPPPPPPP ');
     String  fullUrl =  Site.getBaseUrl() ; 
        pageReference pg =new pageReference(fullUrl);
        pg.setRedirect(true);
        return pg;
    }

	public String username {get; set;}   
    public string error {get;set;}   
    public string successMsg{get;set;}
    
                    	
	
   
        public PageReference forgotPassword1() {
        	system.debug('forgotPassword1 === username'+username);
        	List<user> users  =new List<user>();
        	users  = [select id,Password__c,isActive,isSignup__c,Name,userName from user where userName=:username ];
            if(users.size()>0){
        	Boolean checkRest = Site.forgotPassword(username);
        	if(checkRest==true){
        		PageReference reDir = Page.BLN_Signup;
                reDir.setRedirect(true);
                return reDir;
        	}else{
        		error ='Passwor Reset Failed';
                return null;
        	}
            }else{
            	error ='User does not exists';
                return null;
            }        	
        }
        
        public PageReference AscForgotPassword() {
        	system.debug('forgotPassword1 === username  '+username);
        	List<user> users  =new List<user>();
        	users  = [ select id,Password__c,isActive,isSignup__c,Name,userName from user where userName=:username ];
            if(users.size()>0){
            	if(users[0].isSignup__c==true ){                    	
					if(users[0].isActive==true){
		            	System.ResetPasswordResult checkRest = System.resetPassword(users[0].Id,false);
		            	system.debug('checkRest === '+checkRest);
		            	system.debug('checkRest.getPassword === '+checkRest.getPassword());
		            	
		            	string htmlBody =  'Dear ' + ' ' + users[0].Name +',' +  + '<br/>' + '<br/>' + 
		                         'The forgot password request for your ID has been successfully processed. Your login details are as follows:' + '<br/>' +'<br/>' +
		                         '<b>Username</b>'+' : '+ '' + users[0].username + +'<br/>'+
		                         '<b>Password</b>'+' : '+ '' + checkRest.getPassword() + +'<br/>'+'<br/>'+
		                         'If you have any questions regarding Eventdex, please contact Eventdex support.'+ '<br/>'+'<br/>'+
		                         'Thank you!'+'<br/>'+
		                         'Eventdex Customer Support'+'<br/>'+
		                         +'<a>'+'support@eventdex.com'+'</a>'+'<br/>'+
		                         'Phone: 1-(800)-492-1289';
		                         
		                   
		                OrgWideEmailAddress Org;
						try{
                            org = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];
                             
						}catch(exception e){
							error =e.getMessage();
							return null;                       
						} 
						  
						Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
						email.setSubject('Welcome to Eventdex – Forgot Password');
						
						if( Org != null){  
							email.setOrgWideEmailAddressId(Org.id);
						}
						
						LIST<String> ccAddresses = new LIST<String>();  
						ccAddresses.add(users[0].userName);
						email.setToAddresses(ccAddresses);
						email.setHtmlBody(htmlBody); 
						List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
						EmailsList.add(email);
						
						if(EmailsList.size()>0){
							Messaging.sendEmail(EmailsList);
						}  
						successMsg ='Successfully sent your password to your registered email id';
						
            	
			        	//if(checkRest==true){
			        		system.debug( 'Password reset done' );
			        		String  fullUrl =  Site.getBaseUrl() ; 
			        		
			        		PageReference reDir =  new PageReference(fullUrl+'/ASC_CustomLogin');
			        		system.debug('reDir === '+reDir);
			                reDir.setRedirect(true);
			                return reDir;
			        	//}else{
			        	//	error ='Password Reset Failed';
			            //    return null;
			        	//}
		            }else{
                                error ='User deactivated, please contact administrator';
                        return null;
                            }
                        }else{
                                error ='User not yet signup';
                    return null;
                        }
            }else{
		            	error ='User does not exists';
                    	return null;
		            }
        }
        
        public PageReference EveForgotPassword() {
                system.debug('forgotPassword1 === username  '+username);
                List<user> users  =new List<user>();
                users  = [ select id,Password__c,isActive,isSignup__c,Name,userName from user where userName=:username ];
            if(users.size()>0){
                if(users[0].isSignup__c==true ){                        
                                        if(users[0].isActive==true){
                                System.ResetPasswordResult checkRest = System.resetPassword(users[0].Id,false);
                                system.debug('checkRest === '+checkRest);
                                system.debug('checkRest.getPassword === '+checkRest.getPassword());
                                
                                string htmlBody =  'Dear ' + ' ' + users[0].Name +',' +  + '<br/>' + '<br/>' + 
                                         'The forgot password request for your ID has been successfully processed. Your login details are as follows:' + '<br/>' +'<br/>' +
                                         '<b>Username</b>'+' : '+ '' + users[0].username + +'<br/>'+
                                         '<b>Password</b>'+' : '+ '' + checkRest.getPassword() + +'<br/>'+'<br/>'+
                                         'If you have any questions regarding Eventdex, please contact Eventdex support.'+ '<br/>'+'<br/>'+
                                         'Thank you!'+'<br/>'+
                                         'Eventdex Customer Support'+'<br/>'+
                                         +'<a>'+'support@eventdex.com'+'</a>'+'<br/>'+
                                         'Phone: 1-(800)-492-1289';
                                         
                                   
                                OrgWideEmailAddress Org;
                                                try{
                                                       // org = [select id from OrgWideEmailAddress WHERE address='support@boothleads.com'];
                                                       org = [select id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];
                                                }catch(exception e){
                                                        error =e.getMessage();
                                                        return null;                       
                                                } 
                                                  
                                                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                                                email.setSubject('Welcome to Eventdex – Forgot Password');
                                                
                                                if( Org != null){  
                                                        email.setOrgWideEmailAddressId(Org.id);
                                                }
                                                
                                                LIST<String> ccAddresses = new LIST<String>();  
                                                ccAddresses.add(users[0].userName);
                                                email.setToAddresses(ccAddresses);
                                                email.setHtmlBody(htmlBody); 
                                                List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
                                                EmailsList.add(email);
                                                
                                                if(EmailsList.size()>0){
                                                        Messaging.sendEmail(EmailsList);
                                                }  
                                                successMsg ='Successfully sent your password to your registered email id';
                                                
                
                                        //if(checkRest==true){
                                                system.debug( 'Password reset done' );
                                                String  fullUrl =  Site.getBaseUrl() ; 
                                                
                                                PageReference reDir =  new PageReference(fullUrl+'/CustomLogin');
                                                system.debug('reDir === '+reDir);
                                        reDir.setRedirect(true);
                                        return reDir;
                                        //}else{
                                        //      error ='Password Reset Failed';
                                    //    return null;
                                        //}
                            }else{
                                error ='User deactivated, please contact administrator';
                        return null;
                            }
		        }else{
		        	error ='User not yet signup';
                    return null;
		        }
            }else{
            	error ='User does not exists';
                return null;
            }        	
        }
        
}
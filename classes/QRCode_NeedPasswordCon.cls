public class QRCode_NeedPasswordCon {
/**
 * An apex page controller that exposes the site forgot password functionality
 */
    public String username {get; set;}   
    public string error {get;set;}   
       
    public QRCode_NeedPasswordCon() {}
        
        public PageReference forgotPassword() {
                //boolean success = Site.forgotPassword(username);
               // PageReference pr = Page.portal_forgotpasswordconfirm;
                List<user> users  =new List<user>();              
                users  = [select id,Password__c,isActive,isSignup__c,Name,userName from user where userName=:username ];
                 if(users.size()>0){
                    if(users[0].isSignup__c==true ){
                       if(users[0].isActive==true){
                          
                       } else{
                          users[0].isActive=true;
                          database.saveResult res = dataBase.update(users[0],false);                
                           for (Database.Error err : res.getErrors()){
                             error = err.getMessage() ;
                             break;
                             return null;
                         }
                       }
                    
                    
                   // string htmlBody = '<table style="width:100%;"><tr><td> Hi '+ users[0].Name+', </td></tr><tr><td>&nbsp;</td></tr><tr><td>Please find your login credentials :</td></tr><tr><td> <span style="font-weight:bold;color:#674ea7">User Name : <span> ' +users[0].userName +'</td></tr><tr><td><span style="font-weight:bold;color:#674ea7">Password : <span>'+ users[0].password__c+'<br /><br /><br /></td></tr><tr><td>Thanks,<br />Boothleads support.</td></tr></table>';
                    
                   
                 string htmlBody =  'Dear ' + ' ' + users[0].Name +',' +  + '<br/>' + '<br/>' + 
                         'The forgot password request for your ID has been successfully processed. Your login details are as follows:' + '<br/>' +'<br/>' +
                         '<b>Username</b>'+' : '+ '' + users[0].username + +'<br/>'+
                         '<b>Password</b>'+' : '+ '' + users[0].Password__c + +'<br/>'+'<br/>'+
                         'If you have any questions regarding Boothleads, please contact Boothleads support.'+ '<br/>'+'<br/>'+
                         'Thank you!'+'<br/>'+
                         'BoothLeads Customer Support'+'<br/>'+
                         +'<a>'+'support@boothleads.com'+'</a>'+'<br/>'+
                         'Phone: 1-(800)-492-1289';
                         
                   
                    OrgWideEmailAddress Org;
                    try{
                       org = [select id from OrgWideEmailAddress WHERE address='support@boothleads.com'];
                     }catch(exception e){
                       error =e.getMessage();
                       return null;                       
                     } 
                      
                       Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                       email.setSubject('Welcome to Boothleads – Need Password');
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
                      
                    }else{
                       error ='User not yet signedup';
                       return null;
                    }                 
                 
                 } else{
                    error ='User does not exists';
                    return null;
                 }
                 
                 
                PageReference pr = Page.BL_Eventadmin_Signup;
                pr.setRedirect(true);
                return pr;
               
        }
        
         
}
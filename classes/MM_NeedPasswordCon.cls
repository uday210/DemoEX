public without sharing class MM_NeedPasswordCon {

    public PageReference loginpage() {
    PageReference pg = new PageREference('/apex/MM_newSignup');
    return  pg;
    }


    public String username {get; set;}   
       
    public MM_NeedPasswordCon() {}
        public string Message{get;set;}
        public PageReference forgotPassword(){   
                //  boolean success = Site.forgotPassword(username);
               // PageReference pr = Page.portal_forgotpasswordconfirm;
               
                //if (success) {                          
                    //    return pr;
               // }
             
                List<User> u = [select id,Name,username,Password__c,isActive,Issignup__c from user where Username =: username  limit 1];
                
                if(u.size()>0){
                  if(u[0].issignup__c != true){
                      Message ='The user with the email ID did not signed up yet, Please sign up !!';
                      return null;
                  }
                
                
                  if(u[0].isActive==true){
                                   
     
                 }else{
                   u[0].isactive=true;
                   database.update(u[0],false);
                  // return null;
                 }
                 
                 
                 Messaging.SingleEmailMessage emailsh = new Messaging.SingleEmailMessage();
                     OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Booth Leads'];
                     if(owea.size() > 0 ) {
                          emailsh.setOrgWideEmailAddressId(owea.get(0).Id);
                     } 
                     emailsh .setSubject('Welcome to Match Making – Need Password');
                     String[] toaddress = new String[] {
                         u[0].username
                     };
                     emailsh.setToAddresses(toaddress);
    
                     emailsh.setHTMLBody('Dear ' + ' ' + u[0].Name +',' +  + '<br/>' + '<br/>' + 
                         'The forgot password request for your ID has been successfully processed. Your login details are as follows:' + '<br/>' +'<br/>' +
                         '<b>Username</b>'+' : '+ '' + u[0].username + +'<br/>'+
                         '<b>Password</b>'+' : '+ '' + u[0].Password__c + +'<br/>'+'<br/>'+
                         'If you have any questions regarding matchmaking, please contact Boothleads.'+ '<br/>'+'<br/>'+
                         'Thank you!'+'<br/>'+
                         'BoothLeads Customer Support'+'<br/>'+
                         +'<a>'+'support@boothleads.com'+'</a>'+'<br/>'+
                         'Phone: 1-(800)-492-1289');
                     Messaging.SendEmailResult[] r=Messaging.sendEmail(New Messaging.SingleEmailMessage[] {emailsh});  
                 
                 
                  PageReference pr = Page.mm_newsignup;
                     pr.setRedirect(true);                  
                     return pr;
                 
                 
               
                }else{
                    Message ='User does not exists';
                    return null;
                }
                
                return null;
        }
                
}
@istest

public class Test_signupEmail1{

  static testmethod void Testmethod_signupEmail(){
    folder f = [select id,name from folder where name Like: 'Booth Leads Templates'];
    Profile p = [select id FROM profile where name = 'System Administrator'];
   try{
      EmailTemplate Email_Template  = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Welcome Template']; 
   }catch(exception er){
      EmailTemplate Email_Template = new EmailTemplate(Name = 'Welcome Template',DeveloperName = 'mythilypriya',FolderId= f.id,TemplateType= 'Text' );
      insert Email_Template;
    }
     User u = new User(alias = 'Mythtest', email = 'yu@gmail.com',emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US',localesidkey = 'en_US', country = 'United States',timezonesidkey = 'America/Los_Angeles', username = 'testmyth@gmail.com',Password__c='1',isactive=true,isSignup__c = True);
     insert u;
    }
  }
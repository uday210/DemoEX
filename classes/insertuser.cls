public class insertuser{
 public static user u{get;set;}

 public static user inuser(){
  Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         // ------------------ Eventadmin Insert ---------------------

 u = new User(alias = 'Test', email='testcode12@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode12@noemail.com');
         
        database.saveResult sav =  database.insert(u,false);
        return u;
      
  }      


}
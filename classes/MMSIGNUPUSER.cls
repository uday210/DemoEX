@RestResource(urlMapping='/MMSIGNUPUSER/*')
 /**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : To insert attendee
 */


  global without sharing class MMSIGNUPUSER{
      global static String firstName;
      global static String lastName; 
      global static String email;
      global static String company; 
      global static String password;
       global static String phoneNo ;  
      global static String title;  
       global static String imageurl;
        global static String matchmaking;
        global static Id userIdvalue;
      @HttpGet
      global static inncls doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        firstName= req.params.get('fName');
        lastName= req.params.get('lName');
        email= req.params.get('EmailId');
        company= req.params.get('Company');
        password =req.params.get('pw');
        
        try{
          matchmaking=req.params.get('matchmaking');
        }catch(exception e){}      
        
       
        phoneNo =req.headers.get('phone');
        try {
        if(phoneNo =='Windows'){
            phoneNo ='';   
         }      
        } catch(exception e) {} 
        
        
        
        
        title=req.headers.get('title');
        imageurl=req.headers.get('imageurl');
        
        InnCls inn ;
        
        List<User> listOfUsers = new List<user>();
        listOfUsers =[select title,id,userName,Email,CompanyName,password__c,isSignup__c from user where UserName=:email];
        
        
     // --------------------------- If event admin import Or add user before user sign up -------------------------------------  
        if(listOfUsers.size()>0){
          if(listOfUsers[0].isSignup__c==true){
           inn = new Inncls('User Already Exist');
           }else{
             listOfUsers[0].isActive =true;
              listOfUsers[0].isSignup__c =true;
              update listOfUsers[0];
            
            inn = new Inncls(string.valueOf(listOfUsers[0].id));
           }
        }else{
           //try{
                  
                
                // Insert User  
                       Profile profile = [select Id from Profile where Name='attendee'];
                       Account Acc= [select id from Account where Name =: 'Booth Leads' LIMIT 1];
                        contact contact = new Contact(AccountId =Acc.id,
                        LastName = lastName,
                        FirstName = firstName);
                        insert contact;
                        
                        
                        
                        string df = string.valueOf(email);
                        integer i = df.indexOf('@');
                        if(i>3){
                        string ght = df.substring(0,3);
                        }else{
                        string ght = df.substring(0,1);
                        }
                        
                        
                        
                       
                        System.debug('UserName'+email);
                          List<user> listUser = new    List<user>();
                          
                        User user1 = new User();
                         
                        
                        user1.Username = email;
                        user1.Email =email;
                        user1.contactId =contact.id;
                        user1.firstname = FirstName;
                        user1.LastName = LastName;
                        user1.Alias ='BAdmin';
                        user1.phone =phoneNo;
                        user1.Title = title;
                        user1.ProfileID =profile.Id;
                        user1.LocaleSidKey ='en_US';
                          system.debug('44444444444 '+user1);
                        user1.LanguageLocaleKey ='en_US';
                        user1.TimeZoneSidKey ='America/Los_Angeles';
                        user1.EmailEncodingKey='UTF-8';
                        user1.companyName=company;
                        user1.isSignup__c=true;
                        user1.isActive =true;
                        system.debug('44444444444 5555555555'+user1.isActive );
                      
                        listUser.add(user1);
                         system.debug('44444444444 5555555555 888888888 '+user1);
                         system.debug('44444444444 5555555555 999999999'+listUser);
                        DataBase.Saveresult[] saveRes =dataBase.insert(listUser,false);
                          system.debug('44444444444 5555555555 777777777 '+listUser);
                      
                        for(DataBase.Saveresult Ds:saveRes){
                            if(Ds.isSuccess()){
                             system.debug('rrrrrrrrrrrr '+Ds);
                                system.debug('ccccccccccccccc '+Ds.getId());
                                userIdvalue =Ds.getId();
                             
                         user ure =[select id,isactive from user where id=:userIdvalue ];    
                             system.debug('44444444444 5555555555 66666666'+ure );
                      
                            }else{
                            string err =Ds.getErrors()[0].getMessage();
                                inn = new Inncls(err); 
                            }
                         }    
                         
                         
              if(userIdvalue!=null){
                    
                 List<AttendeeSummary__c> listOfAtts = new List<AttendeeSummary__c>();
                 listOfAtts =[select id from AttendeeSummary__c where AS_Email__c=:email]; 
                 system.debug('1111111111111111 '+listOfAtts);
                 
                 if(listOfAtts.size()<=0){
                  system.debug('22222222222222222  '+listOfAtts);
                  AttendeeSummary__c att = new AttendeeSummary__c();
                   att.AS_FirstName__c = FirstName;
                   att.AS_LastName__c = LastName;
                   att.AS_Email__c = email;
                   att.AS_Company__c = company;  
                   att.AS_Title__c =title;
                   att.AS_CellPhone__c = phoneNo ; 
                   
                   dataBase.Upsertresult dbUpsert = dataBase.upsert(att,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(),false);
                   if(dbUpsert.isSuccess()){
                   inn = new Inncls(string.valueOf(userIdvalue));    
                   }
                  
                 }else{
                    
                   MAP<string,Id> ProfileNameMAP =  new MAP<string,Id>();
                   for(Profile__c pro :[select id,PR_Name__c from  Profile__c]){
                   ProfileNameMAP.put(pro.PR_Name__c,pro.id);
                   }
                   
                   
                    List<User_Profile_Event__c> listOfUpes = new  List<User_Profile_Event__c>();                  
                    for(Event_Attendee_Mapping__c EAM :[select AS_id__c,Boothleads_Profile__c,EV_id__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:email and EV_id__c!=null]){
                    User_Profile_Event__c upe = new User_Profile_Event__c();
                   system.debug('333333333333333333  '+EAM);
                    upe.EV_id__c =EAM.EV_id__c; 
                    upe.Profile_id__c =ProfileNameMAP.get(EAM.Boothleads_Profile__c);
                    upe.Status__c= 'Active';
                    upe.User_id__c=user1.Id;
                    upe.UEP_isActive__c =true;
                      upe.IsMatchMakingUser__c =true;
                       
                    listOfUpes.add(upe);
                }   
                              
                LIST<Database.SaveResult> saveresList =dataBase.insert(listOfUpes,false); 
               
              List<User_Profile_Event__c> listOfUpesusers = new List<User_Profile_Event__c>();
               if(saveresList.size()>0){
               listOfUpesusers =[select User_id__r.id from User_Profile_Event__c where id=:saveresList[0].getId()];
               try{
                inn = new Inncls(listOfUpesusers[0].User_id__r.id); 
               }catch(exception e){}
             }else{
                inn = new Inncls('Success');    
              }
            }
         }    
                 
       // }catch (exception e){inn = new Inncls('Registration Unsucessful');   }
        }
          
    return  inn ;
  }
  
         
  global class inncls{
  public string message{get;set;}
   public inncls(string err){
     message= err;
    }
  }
 }
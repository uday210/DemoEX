@RestResource(urlMapping='/AS_SignUp/*')
  
global class AS_SignUp{
    
    global static Container ct=new Container();
    global static List<User> users{get;set;}
    global static List<User_Pricing__c> UserPricing{get;set;}
    global static List<User_Profile_Event__c> PricingInfo{get;set;}
    global static User LoginUser;
    
    @HttpPost  
    global static Container doPost(){  
        RestRequest req = RestContext.request;
        String FirstName = req.params.get('FirstName');
        String LastName = req.params.get('LastName');
        String Password=req.params.get('Password');
        String Email=req.params.get('Email');
        String Phone=req.params.get('Phone');
        String Company=req.params.get('Company');
        String City=req.params.get('City');
        String State=req.params.get('State');
        system.debug(' ####111 '+Email);
        String Country=req.params.get('Country');
        system.debug('####222 '+Country);
        String AccountType=req.params.get('AccountType');
        Decimal AttendeeLimit;
        String PayPalEmail= req.params.get('PayPalEmail');
        try{
            AttendeeLimit=Decimal.valueOf(req.params.get('AttendeeLimit'));
        }
        catch(Exception e){}

        String Status=req.params.get('Status'); 
        system.debug('#### '+Status);
        Blob jSONRequestBody=req.requestBody; 
        system.debug('$$$$$ '+jSONRequestBody);
        Commanforstates con = new Commanforstates();
        
        if(Status=='CREATE'){
         system.debug('%%%%%222 '+Status);
         try{
            Profile P = [SELECT id,Name FROM Profile WHERE Name='Event Admin'];
            List<User> listOfUsers= new List<User>();
            List<User> updateUsers= new List<User>();
            listOfUsers =[SELECT Id, Password__c, ProfileId,Username,FirstName,LastName,Email,Companyphone__c,CompanyName,States__c,Country__c,CompanyCity__c,isActive,ScanAttendee_User__c FROM User WHERE UserName=:Email];
            
            if(listOfUsers.size()>0){
                if(listOfUsers[0].ScanAttendee_User__c == TRUE && listOfUsers[0].isActive == TRUE){
                    ct.error='User already exists!';
                }else{                    
                   
                    for(User uc:listOfUsers){
                        uc.ScanAttendee_User__c = TRUE;
                        uc.isActive= TRUE;
                        
                        uc.Username = Email;
                        uc.Email =Email;
                        uc.firstname = FirstName;
                        uc.LastName = LastName;
                        uc.Companyphone__c =Phone;
                        uc.companyName=Company;  
                        uc.Password__c=Password;           
            
                        updateUsers.add(uc);
                    }
                    database.update(updateUsers);
                    system.debug(updateUsers.size()+'  UPDATE USERS '+updateUsers);
                    updateUser(updateUsers[0].Id,Email);
                    
                     updateDetails(Email, Password, FirstName, LastName, Phone, Company);
                     LIST<AttendeeSummary__c> AttSum= new LIST<AttendeeSummary__c>();
                     AttSum= [SELECT ID FROM AttendeeSummary__c WHERE AS_Email__c =: Email];
                     
                     ct.Success=new Success(updateUsers[0].Id,Attsum[0].id);
                     ct.FirstName=FirstName;
                     ct.LastName=LastName;
                     ct.Password=Password;
                     ct.Email=Email;
                     ct.Phone=Phone;
                     ct.Company=Company;
                     ct.City=City;
                     system.debug('  INNER USERS '+ct);
                 }                
            
             }else{
                //Insert Contacts and Account
                contact contact;
                
                Account account=new Account();   
                if(Company== NULL || Company== ''){
                    account.Name='Booth Leads';
                }
                else{
                    account.Name=Company;    
                }
                insert account;
                
                contact = new Contact(AccountId =account.id,LastName = LastName,FirstName = FirstName);
                insert contact;
                
    
                //insert Attendee
                AttendeeSummary__c attsum=new AttendeeSummary__c();
                LIST<AttendeeSummary__c> attlist =new LIST<AttendeeSummary__c>();
                attlist = [SELECT Id,AS_Email__c FROM AttendeeSummary__c WHERE AS_Email__c=:Email];
                if(attlist.size()>0){
                    Id atteid= attlist[0].id;
                    attsum = [Select Id,AS_Company__c,AS_WorkZip__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_FirstName__c,AS_LastName__c,AS_Email__c,AS_WorkPhone__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c,AS_ImageUrl__c FROM AttendeeSummary__c WHERE Id=:atteid];
                    attsum.AS_FirstName__c=FirstName;
                    attsum.AS_LastName__c=LastName;
                    attsum.AS_Email__c=Email;
                    attsum.AS_Company__c=Company;
                    attsum.AS_WorkPhone__c=Phone;
                    attsum.AS_WorkCity__c=City;
                    attsum.AS_Work_States__c=State;
                    attsum.AS_Work_Country__c=Country;    
                    Update attsum;
                }else{  
                    attsum.AS_FirstName__c=FirstName;
                    attsum.AS_LastName__c=LastName;
                    attsum.AS_Email__c=Email;
                    attsum.AS_Company__c=Company;
                    attsum.AS_WorkPhone__c=Phone;
                    attsum.AS_WorkCity__c=City;
                    attsum.AS_Work_States__c=State;
                    attsum.AS_Work_Country__c=Country;    
                    insert attsum;
                }
                
                //Get Pricing Info
                BL_Pricing__c PricingId = new BL_Pricing__c();
                PricingId = [SELECT Id,BLP_AccountType__c,BLP_AttendeeLimit__c,App_Access__c FROM BL_Pricing__c WHERE BLP_AccountType__c =: AccountType AND App_Access__c='Attendee Scan'];
                
                //insert user
                Profile profile = [select Id from Profile where Name='Event Admin'];
                User user1 = new User();
                user1.Username = Email;
                user1.Email ='abcdefg@gmail.com';
                user1.firstname = FirstName;
                user1.LastName = LastName;
                user1.Alias ='SAUser';
                user1.Companyphone__c=Phone;
                user1.ProfileID =profile.Id;
                user1.LocaleSidKey ='en_US';
                user1.LanguageLocaleKey ='en_US';
                user1.TimeZoneSidKey ='America/Los_Angeles';
                user1.EmailEncodingKey='UTF-8';
                user1.companyName=Company;
                user1.isSignup__c=true;
                user1.isActive =true;
                user1.CompanyCity__c=City;
                user1.Country__c=Country;
                user1.States__c=State;
                user1.contactId =contact.id;
                user1.Password__c=Password;
                user1.ScanAttendee_User__c = TRUE;
                insert user1;
                updateUser(user1.Id,Email);
                insertUpe(user1.id,attsum.Id,PricingId.Id);
             
             
                ct.Success=new Success(user1.id,attsum.id);
                ct.FirstName=FirstName;
                ct.LastName=LastName;
                ct.Password=Password;
                ct.Email=Email;
                ct.Phone=Phone;
                ct.Company=Company;
                ct.City=City;
                ct.State = con.mapstate(user1.States__c);
                ct.State_LongCode = user1.States__c;
                ct.Country = con.mapstate(user1.Country__c);
                ct.Country_LongCode = user1.Country__c;
                ct.AccountType=AccountType;
                ct.AttendeeLimit=AttendeeLimit;      
            } 
        }
        catch(Exception e){
            ct.error=e.getMessage();
        }
     }
     
    if(Status=='EDIT'){
        //Get User Info
        updateUserInfo(Email,FirstName,LastName,Phone,Company,City,Country,State); 
    
        //Get Attendee Info
        LIST<AttendeeSummary__c> attmap= new LIST<AttendeeSummary__c>();
        attmap= [select AS_Company__c, AS_FirstName__c,AS_LastName__c,Id,AS_Email__c,AS_WorkPhone__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c,AS_ImageUrl__c from AttendeeSummary__c where AS_Email__c=:Email];     
        system.debug('attmap is '+attmap);
        if(attmap.size()==0)
            ct.error='No Such User Exists';
        else
        {
            attmap[0].AS_FirstName__c=FirstName ;
            attmap[0].AS_LastName__c=LastName;
            attmap[0].AS_Email__c=Email;
            attmap[0].AS_WorkPhone__c=Phone;
            attmap[0].AS_WorkCity__c=City;
            attmap[0].AS_Work_States__c=State;
            attmap[0].AS_Work_Country__c=Country;
            attmap[0].AS_Company__c= Company;
            String imageURL='';
            
            try{
                Document d=[SELECT Id,Name FROM Document WHERE Name=:attmap[0].Id];
                    if(d!= NULL){
                        database.delete(d,false);
                    }
            }
            catch(exception e){}
            try{
                Document document = new document();
                document.Name=attmap[0].Id;
                
                document.isPublic=true;
                document.ContentType='image/png';
                document.type='png';
                document.IsInternalUseOnly =false;
                document.body=jSONRequestBody;
                
                document.folderId=UserInfo.getUserId();
                insert document;
                
                string urlbase =URL.getSalesforceBaseUrl().getHost();
                string orgId = UserInfo.getOrganizationId();
                
                imageURL= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+document.id;    
                system.debug('Image URL is'+imageURL);
            }
            catch(Exception e){}
            attmap[0].AS_ImageUrl__c=imageURL;
            update attmap;
        } 

        if(users.size()!=0&&attmap.size()!=0){
       
            //User_Pricing__c uplist = [SELECT Id,User__c,Pricing__c,Customer_Stripe_Id__c,AttendeeLimit__c,Pricing__r.BLP_AccountType__c FROM User_Pricing__c WHERE User__c=:users[0].id AND Pricing__r.App_Access__c='Attendee Scan' LIMIT 1];
            ct.Success=new Success(users[0].id,attmap[0].id);
            ct.FirstName=FirstName;
            ct.LastName=LastName;
            ct.Password=Password;
            ct.Email=Email;
            ct.Phone=Phone;
            ct.Company=Company;
            ct.City=City;
            system.debug('####333 '+users[0].States__c);
            system.debug('####444 '+users[0].Country__c);
            ct.State = con.mapstate(users[0].States__c);
            ct.State_LongCode = users[0].States__c;
            ct.Country = con.mapstate(users[0].Country__c);
            ct.Country_LongCode = users[0].Country__c;
            ct.ImageUrl=attmap[0].AS_ImageUrl__c;
            //ct.AccountType=uplist.Pricing__r.BLP_AccountType__c;
            //ct.AttendeeLimit=uplist.AttendeeLimit__c; 
            //ct.CustomerStripeId=uplist.Customer_Stripe_Id__c; 
        
        }
    }  
    
    if(Status=='EDITPAYPAL'){
        system.debug(Email+'  PAYPAL DETAILS '+PayPalEmail);
        LIST<Pay_Pal_Account__c> existingPaypalAccount= new LIST<Pay_Pal_Account__c>();
        existingPaypalAccount= [SELECT ID, Email_Id__c, OurEmail__c FROM Pay_Pal_Account__c WHERE User_Email__c =: Email];
        if(existingPaypalAccount.size() >0){
            existingPaypalAccount[0].Email_Id__c= PayPalEmail;
            existingPaypalAccount[0].OurEmail__c= 'durga@globalnest.com';
            Database.SaveResult[] InsertedPaypalResult= Database.Update(existingPaypalAccount, FALSE);
            system.debug('  UPDATED PAYPAL ACCOUNT '+InsertedPaypalResult);
            ct.PaypalEmail= existingPaypalAccount[0].Email_Id__c;
        }else{
            Pay_Pal_Account__c createPaypalAccount= new Pay_Pal_Account__c();
            createPaypalAccount.OurEmail__c= 'durga@globalnest.com';
            createPaypalAccount.Email_Id__c= PayPalEmail;
            createPaypalAccount.User_Email__c = Email;            
            Database.SaveResult InsertedPaypalResult= Database.Insert(createPaypalAccount, FALSE);
            system.debug('  INSERTED PAYPAL ACCOUNT '+InsertedPaypalResult);
            ct.PaypalEmail= createPaypalAccount.Email_Id__c;
        }
        
    }    
    return ct;
}

    @future
    public static void updateUser(Id UserId,String Email){
           User U1 = new User();
           U1 =[SELECT Id,Email,password__c FROM User WHERE Id =: UserId];
           System.setPassword(U1.Id, U1.Password__c);
           //U1.password__c = rt.getPassword();
           U1.Email=Email;
           update U1;
    }
    
    @future
    public static void insertUpe(Id UserId1, Id attid1,Id PricingTableId){
    
        Profile__c ASProfile = [SELECT Id FROM Profile__c WHERE PR_Name__c = 'EventAdmin'];
        
        // Insert User_Profile_Event
        User_Profile_Event__c UPE = new User_Profile_Event__c();
        UPE.EventAdmin_Id__c = UserInfo.getUserId();
        UPE.BLP_id__c = PricingTableId;
        upe.Attendee_Summary__c = attid1;
        UPE.UEP_isActive__c = True;
        UPE.Profile_id__c = ASProfile.id;
        UPE.User_id__c = UserId1; 
        insert UPE; 
        
        // Insert User_Pricing
        BL_Pricing__c PricingTableList = [SELECT Id,BLP_AccountType__c,BLP_UserLimit__c,BLP_EventLimit__c,BLP_AttendeeLimit__c,BLP_Amount__c,BLP_SignUp__c,PR_Type__c,App_Access__c FROM BL_Pricing__c WHERE Id=:PricingTableId];
        
        User_Pricing__c UP = new User_Pricing__c();
        UP.User__c = UserId1;
        UP.Pricing__c = PricingTableList.id;
        UP.AttendeeLimit__c = PricingTableList.BLP_AttendeeLimit__c;
        insert UP;         
    }
     

   global static void updateUserInfo(String Email, String FirstName, String LastName,String Phone,String Company,String City,String Country,String State) {
        system.debug('$$$$ '+Email);
        users= new LIST<User>();
        users =[select Id,ProfileId,Username,FirstName,LastName,Email,Companyphone__c,CompanyName,States__c,Country__c,CompanyCity__c from User where Username=:Email]; 
        if(users.size()==0)
            ct.error='No Such User Exists';
        else{
            users[0].Username = Email;
            users[0].Email =Email;
            users[0].firstname = FirstName;
            users[0].LastName = LastName;
            users[0].Companyphone__c =Phone;
            users[0].companyName=Company;  
            users[0].CompanyCity__c=City;
            users[0].States__c=State;
            users[0].Country__c=Country;
            
            update users[0];
        }
    }
    @future 
    global static void updateDetails(String AttEmail, String AttPwd, String AttFirst, String AttLast, String AttCompany, String AttPhone){
           
                
                    LIST<AttendeeSummary__c> AttSum= new LIST<AttendeeSummary__c>();
                    AttSum= [SELECT ID FROM AttendeeSummary__c WHERE AS_Email__c =: AttEmail];                           
                    LIST<AttendeeSummary__c> updateAttsum= new LIST<AttendeeSummary__c>();
                    if(AttSum.size() ==0){
                        ct.error='No Such Attendee Exists';
                    } else{
                    
                        for(AttendeeSummary__c att: AttSum){
                            att.AS_Email__c= AttEmail;
                            att.AS_FirstName__c= AttFirst;
                            att.AS_LastName__c= AttLast;
                            att.AS_WorkPhone__c=AttPhone;
                            att.AS_Company__c=AttCompany; 
                            updateAttsum.add(att);
                        }
                        Database.update(updateAttsum);
                    }
                    
    }

    global class Container{
    
        public Success Success{get;set;}
        public String FirstName {get;set;}
        public String LastName {get;set;}
        public String Password{get;set;}
        public String Email{get;set;}
        public String Phone{get;set;}
        public String Company{get;set;}
        public String City{get;set;}
        public String State{get;set;}
        public String State_LongCode{get;set;}
        public String Country{get;set;}
        public String Country_LongCode{get;set;}
        public String ImageUrl{get;set;}
        public String AccountType{get;set;}
        public Decimal AttendeeLimit{get;set;}
        public String CustomerStripeId{get;set;}
        public String error{get;set;}
        
        public String PaypalEmail{get; set;}                       
        public Container(){
        
        }
    }
    
    global class Success{    
        public String User_Id{get;set;}
        public Id Attendee_Id{get;set;}
        
        public Success(Id userid,Id attid){
            this.User_Id=userid;
            this.Attendee_Id=attid;
        }
    }
    
    /*
    
               
            if(listOfUsers.size()>0  && listOfUsers[0].ScanAttendee_User__c == TRUE){
                ct.error='User already exists!';
            }else if(listOfUsers.size()>0 && listOfUsers[0].ScanAttendee_User__c == FALSE){
                for(User uc:listOfUsers){
                    uc.ScanAttendee_User__c = TRUE;
                }
                database.update(listOfUsers);
                for(User usr: listOfUsers){
                    AttendeeSummary__c attId=new AttendeeSummary__c();
                    attId= [SELECT ID FROM AttendeeSummary__c WHERE AS_Email__c =: usr.Username];    
                    ct.Success=new Success(usr.id,attId.id);                
                }

                ct.error='User created succesfully';
            }
           if(listOfUsers.size()>0 && listOfUsers[0].ProfileId==P.Id){
                ct.error='User already exists!';
            }
            else if(listOfUsers.size()>0 && listOfUsers[0].ProfileId!=P.Id){
                ct.error='User already exists as non event admin!';
            }
            
            */
    
}
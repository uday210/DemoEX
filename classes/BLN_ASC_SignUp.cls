@RestResource(urlMapping='/BLN_ASC_SignUp/*')
  
global class BLN_ASC_SignUp{
global static Container ct=new Container();
global static BLN_SignUpCon signupcon {get ; set ;}
@HttpPost  
    global static Container doPost(){ 
         signupcon = new BLN_SignUpCon();
        RestRequest req = RestContext.request;
        String FirstName = req.params.get('FirstName');
        String LastName = req.params.get('LastName');
        String Password=req.params.get('Password');
        String Email=req.params.get('Email');
        String Company=req.params.get('Company');
         system.debug(':::::::::::::service 1 ::::::::::;;'+FirstName +'111111'+FirstName +'2222'+LastName+'3333'+Email);
        signupcon.ASUserEmail  = Email;
        signupcon.ASLastName   = LastName ;
        signupcon.ASFirstName  =FirstName ;
        signupcon.ASCompanyName = Company; 
        signupcon.password = Password;
         
        signupcon.BLS_SignUpUser();
        system.debug(':::::::::::::service 1 ::::::::::;;'+signupcon.successMSG);
           ct.Success = signupcon.successMSG;
           if(ct.Success == 'success'){
               ct.Email = Email;
               ct.password = Password;
           }else{
           ct.error = signupcon.successMSG;
           
           }
       return ct;
    }
    
    
      global class Container{
    
        public string Success{get;set;}
        public string Error {get ; set ;}
        //public String FirstName {get;set;}
        //public String LastName {get;set;}
        public String Password{get;set;}
        public String Email{get;set;}        
        //public String Company{get;set;}
        
        public Container(){
        
        }
        }

}
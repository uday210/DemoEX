public with sharing class bl_boothQrCon {

public boolean disableseeventselection { get; set; }
public boolean displayPopUpForQRCODE {get;set;}
public string code{get;set;}
public String selectedEvent { get; set; }
public boolean registrationDisplay { get; set; }
public boolean broucherDisplay { get; set; }
public boolean secondDisplay { get; set; }
public boolean firstDiplayBool { get; set; }
public Boolean rendervalue { get; set; }
public String sn { get; set; }
public Integer listsize{get;set;}
public String sitename { get; set; }
public Booth_Qrcode__c booth{get;set;}
public transient Blob broacherBlob{get;set;}
public List<Booth_Qrcode__c> ListOfUserLinks{get;set;}
public DateTime lastlogindate{get;set;}
public String fileName{ get; set; }

public Booth_Qrcode__c boothEdit{get;set;}
public Booth_Qrcode__c booth1{get;set;}
public Booth_Qrcode__c booth2{get;set;}
public Booth_Qrcode__c booth3{get;set;}
public Booth_Qrcode__c booth4{get;set;}
public Booth_Qrcode__c booth5{get;set;}
public User_Profile_Event__c BoothValue {get;set;}
public Boolean r1{ get; set; }
public Boolean r2{ get; set; }
public Boolean r3{ get; set; }
public Boolean r4{ get; set; }
public Boolean r5{ get; set; }
public string boothname{get;set;}

    public PageReference backbrocher() {
      broucherDisplay= false;
       firstDiplayBool = true;
       secondDisplay = false;
       registrationDisplay = false;
        return null;
    }

    public PageReference Cancel() {
        firstDiplayBool = true;secondDisplay = false; registrationDisplay  = false;broucherDisplay = false; 
        return null;
    }
    
   public PageReference login() {
   if(userInfo.getUserType()=='guest'){
    Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
    pg.setredirect(true);
        return pg;
   
   }
   
   List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
      ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventadmin'];
       if(ty.size()>0){
       Pagereference pg = new pagereference('/apex/BL_EA_Dashboard');
       pg.setredirect(true);
        return pg;
       
       }else{
       return null;
       }   
      
  }

   public boolean displaybuttons{get;set;}
    public PageReference closePopupdetail() {
    displayPopUpForQRCODE = false;
        return null;
    }


    public PageReference Printaspdf() {
         pagereference pf=page.bl_boothpdf;
     return pf;
    }


      public PageReference generateQrcode() {
  
 try{ 
  String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    string ret=sfdcBaseURL+'/BL_MobileScreen?id='+BoothName+'&vid=1'+'&Eid='+selectedEvent; 
    String encoded = EncodingUtil.urlEncode(ret, 'UTF-8');   
    code=encoded;
    
     system.debug('ppppppppppppppppppppp '+ret);
     
    displayPopUpForQRCODE = true;
 }catch(exception e){
        
 
 }
        return null;
    }




    public PageReference save() {
        try{
    system.debug('0000000000000000000000 '+sitename);
      if(boothEdit.Data_Types__c =='Contact Information'){
        if(sitename !=null){
         boothEdit.Link_LabelName__c=sitename;
         List<attachment> attch = new List<attachment>();      
         attch  = [select id from attachment where parentId=:boothEdit.id];
         delete attch;
         
         
         
          string trertr ='BEGIN:VCARD\n'+ 'VERSION:3.0\n'+ 'N:'+ boothEdit.Name__c+';;;\n'+'FN:'+ boothEdit.Name__c+'\n'+'TITLE:'+boothEdit.Title__c+'\n'+'EMAIL;type=INTERNET;type=WORK;type=pref:'+boothEdit.Email_Address__c+'\n'+
     'TEL;type=CELL;type=VOICE;type=pref:'+boothEdit.Phone_number__c+'\n'+'ORG:'+boothEdit.Company__c+'\n'+'ADR;TYPE=WORK:;;'+boothEdit.Address__c+';'+boothEdit.Address_2__c+';'+boothEdit.City__c+';'+boothEdit.State__c+';'+boothEdit.Country__c+'\n'+'URL;WORK:'+boothEdit.Website_URL__c+'\n'+
     'END:VCARD';
     Blob beforeblob = Blob.valueOf(trertr);
     string paramvalue = EncodingUtil.base64Encode(beforeblob);
     
     string s= 'BEGIN:VCALENDAR\n'+
     'VERSION:2.0\n'+
     'BEGIN:VEVENT\n'+
     'DTSTART;TZID=Europe/London:20120708T220000\n'+
     'DTEND;TZID=Europe/London:20120708T230000\n'+
     'SUMMARY:Click to download contact to your address book\n'+
     'DTSTAMP:20120708T203910Z\n'+
     'ATTACH;VALUE=BINARY;ENCODING=BASE64;FMTTYPE=text/directory;\n'+
     ' X-APPLE-FILENAME=iphonecontact.vcf:\n'+' '+paramvalue+'\n'+
     'END:VEVENT\n'+
     'END:VCALENDAR';
      blob b = blob.valueOf(s);
      attachment attach  = new attachment();
      attach.Name ='iphonecontact.ics';
      attach.body=b;
      attach.parentId=boothEdit.id;
     insert attach;
    
    
    
    
    
    string trertr1 ='BEGIN:VCARD\n'+ 'VERSION:3.0\n'+ 'N:'+boothEdit.Name__c+';;;\n'+'FN:'+boothEdit.Name__c+'\n'+'TITLE:'+boothEdit.Title__c+'\n'+'EMAIL;type=INTERNET;type=WORK;type=pref:'+boothEdit.Email_Address__c+'\n'+
     'TEL;type=CELL;type=VOICE;type=pref:'+boothEdit.Phone_number__c+'\n'+'ORG:'+boothEdit.Company__c+'\n'+'ADR;TYPE=WORK:;;'+boothEdit.Address__c+';'+boothEdit.Address_2__c+';'+boothEdit.City__c+';'+boothEdit.State__c+';'+boothEdit.Country__c+'\n'+'URL;WORK:'+boothEdit.Website_URL__c+'\n'+
     'END:VCARD';
     Blob beforeblob1 = Blob.valueOf(trertr1);
    
      attachment attach1  = new attachment();
      attach1.Name ='Android.Vcf';
      attach1.body=beforeblob1 ;
      attach1.parentId=boothEdit.id;
     insert attach1;
      }
        update boothEdit;
                
       }else if(boothEdit.Data_Types__c =='Registration Link'){
        boothEdit.Link_LabelName__c=sn;
        string sd =boothEdit.Registration_Link__c;
        system.debug('666666666677777777777 '+sd);
       if(sd!=null && sd!=''){
      if(sd.contains('http://')){
      boothEdit.Registration_Link__c=(boothEdit.Registration_Link__c).substringAfter('http://');
    }else{
      boothEdit.Registration_Link__c =boothEdit.Registration_Link__c;
    }
     }
    
        update boothEdit;
       }
       else if(boothEdit.Data_Types__c =='Company Broacher'){
        if(broacherBlob != null){
        
        List<attachment> attch1 = new List<attachment>();      
         attch1  = [select id from attachment where parentId=:boothEdit.id];
         delete attch1;       
       system.debug('hiiiiiiiiiiiiiiiiiiiiiiiii ');
        attachment a = new attachment();
        if(broacherBlob!=null){
        a.parentId=boothEdit.id;
        a.body =broacherBlob;
        a.Name =fileName;
       insert a;
      }
      }
      system.debug('!!!!!!!!!!!!!!!!!!'+boothEdit);
        update boothEdit;
       }
    
     system.debug('~~~~~~~~~~~~~~~~~~'+boothEdit);
     firstMethod();  
     firstDiplayBool = true;secondDisplay = false; registrationDisplay  = false;broucherDisplay = false;   
  
        }catch(exception e){}
        return null;
    }


    

    public PageReference editRecord() {
    try{
    firstDiplayBool = false;secondDisplay = false; registrationDisplay  = false;broucherDisplay = false;
    boothEdit  = new Booth_Qrcode__c();
    boothEdit = [select id,Address__c,Address_2__c,Booth__c,City__c,Company__c,Country__c,Email_Address__c,Data_Types__c,Link_LabelName__c,Name__c,Phone_number__c,Pin_code__c,POBox__c,Registration_Link__c,State__c,Title__c,Website_URL__c,(select id,name from attachments limit 1) from Booth_Qrcode__c where id=:Apexpages.currentpage().getparameters().get('editRecord')];
   
    if(boothEdit.Data_Types__c =='Contact Information'){
     sitename=boothEdit.Link_LabelName__c;
    secondDisplay = true;
    
    }else if(boothEdit.Data_Types__c =='Registration Link'){
    sn =boothEdit.Link_LabelName__c;
    registrationDisplay  = true;
    
    }else if(boothEdit.Data_Types__c =='Company Broacher'){
     
      broucherDisplay = true;
    
    }
    }catch(exception e){}    
   
   return null;
    }




 public PageReference deleteRecord() {
try{    
 Booth_Qrcode__c s =[select id from Booth_Qrcode__c where id=:Apexpages.currentpage().getparameters().get('deleterecord')];
 delete s;
 firstMethod();
}catch(exception e){} 
 return null;
}


Public List<User_Profile_Event__c > Events {get;set;}
public List<selectOption> options{get;set;}


public bl_boothQrCon(){
try{    
String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
Events = new List<User_Profile_Event__c > ();
options = new List<selectOption>();
Events=[select EV_id__r.EV_Title__c,EV_id__c,Status__c,BoothAdmin_id__c,id,User_id__r.Name,User_id__r.FaceBookId__c,User_id__c,User_id__r.FirstName,UEP_isActive__c ,User_id__r.LastName,User_id__r.Email,User_id__r.CompanyName,User_id__r.Title from User_Profile_Event__c where   BoothAdmin_id__c=:UserInfo.getUserId() and Profile_id__r.PR_Name__c='BoothAdmin'  and EV_id__r.EV_Title__c!=null and (Status__c!='Mobile only access' And Status__c!='InActive') ]; 

for(User_Profile_Event__c eve:Events){
system.debug('44444444444444 '+eve.EV_id__c);
system.debug('55555555555555 '+eve.EV_id__r.EV_Title__c);
 options.add(new selectOption(eve.EV_id__c,eve.EV_id__r.EV_Title__c));
}  

if(Events.size()>0){
selectedEvent =Events[0].EV_id__c;
}
onchangeRender();
firstDiplayBool  = true;

firstMethod();
}catch(exception e){} 
}


public pageReference onchangeRender(){
try{
BoothValue = new User_Profile_Event__c();
BoothValue =[select BT_id__r.BT_Name__c,EV_id__r.EV_Title__c,EV_id__c,Status__c,BoothAdmin_id__c,id,User_id__r.Name,User_id__r.FaceBookId__c,User_id__c,User_id__r.FirstName,UEP_isActive__c ,User_id__r.LastName,User_id__r.Email,User_id__r.CompanyName,User_id__r.Title,BT_id__c from User_Profile_Event__c where   BoothAdmin_id__c=:UserInfo.getUserId() and Profile_id__r.PR_Name__c='BoothAdmin' and EV_id__c=:selectedEvent limit 1]; 
boothname =BoothValue.BT_id__c;

firstMethod();
}catch(exception e){}
return null;
}

public List<Booth_Qrcode__c> forUrlType{get;set;}
public List<Booth_Qrcode__c> forContactType{get;set;}
public List<Booth_Qrcode__c> forPdfType{get;set;} 
public List<Booth_Qrcode__c> forEmpty{get;set;} 


public pageReference firstMethod(){
try{
rendervalue  = false;
forEmpty = new List<Booth_Qrcode__c>();
forUrlType= new List<Booth_Qrcode__c>();
forPdfType= new List<Booth_Qrcode__c>();
forContactType  = new List<Booth_Qrcode__c>();
displaybuttons = true;
ListOfUserLinks = new List<Booth_Qrcode__c>();
 user u =[select lastloginDate from user where id=:userInfo.getuserId()];
 lastlogindate =u.lastloginDate;
 ListOfUserLinks  =  [select id,Address__c,Address_2__c,Booth__c,City__c,Company__c,Country__c,Email_Address__c,Data_Types__c,Link_LabelName__c,Name__c,Phone_number__c,Pin_code__c,POBox__c,Registration_Link__c,State__c,Title__c,Website_URL__c,(select id,name from Booth_Qrcode__c.attachments)  from Booth_Qrcode__c where Booth__c=:BoothName and  Event__c=:selectedEvent];
system.debug('w111111111111111111 '+ListOfUserLinks);

for(Booth_Qrcode__c b:ListOfUserLinks){
if(b.Data_Types__c=='Contact Information'){
 forContactType.add(b);
}

if(b.Data_Types__c=='Registration Link'){
forUrlType.add(b);
system.debug('w3333333333333333333333 '+b);
}

if(b.Data_Types__c=='Company Broacher'){

forPdfType.add(b);
}
}
 
 
for(integer f=1;f<=5-ListOfUserLinks.size();f++){
Booth_Qrcode__c iu = new Booth_Qrcode__c();
forEmpty.add(iu); 

} 
 
 
 
system.debug('w111111111111111111 '+ListOfUserLinks.size()); 
 
 
 listsize=ListOfUserLinks.size();
 if(ListOfUserLinks.size()>0){
 rendervalue = true;
  }
  
  if(ListOfUserLinks.size()>=5){ 
  displaybuttons =false;
  }
  booth = new Booth_Qrcode__c();
 }catch(exception e){} 
return null;
}


//---------------------------- Add contact Method --------------------------
  
    public PageReference addContact() {
   try{         
      system.debug('44444444444444444444444 '+sitename);
    booth.Data_Types__c ='Contact Information';
    booth.Link_LabelName__c =sitename;
    booth.Booth__c=boothname;
    booth.Event__c=selectedEvent;
    insert booth;
   
    List<attachment> att = [select name,id  from attachment where parentId=:booth.id];
    delete att;
    
    
    string trertr ='BEGIN:VCARD\n'+ 'VERSION:3.0\n'+ 'N:'+ booth.Name__c+';;;\n'+'FN:'+ booth.Name__c+'\n'+'TITLE:'+Booth.Title__c+'\n'+'EMAIL;type=INTERNET;type=WORK;type=pref:'+booth.Email_Address__c+'\n'+
     'TEL;type=CELL;type=VOICE;type=pref:'+booth.Phone_number__c+'\n'+'ORG:'+booth.Company__c+'\n'+'ADR;TYPE=WORK:;;'+Booth.Address__c+';'+Booth.Address_2__c+';'+Booth.City__c+';'+Booth.State__c+';'+Booth.Country__c+'\n'+'URL;WORK:'+Booth.Website_URL__c+'\n'+
     'END:VCARD';
     Blob beforeblob = Blob.valueOf(trertr);
     string paramvalue = EncodingUtil.base64Encode(beforeblob);
     
     string s= 'BEGIN:VCALENDAR\n'+
     'VERSION:2.0\n'+
     'BEGIN:VEVENT\n'+
     'DTSTART;TZID=Europe/London:20120708T220000\n'+
     'DTEND;TZID=Europe/London:20120708T230000\n'+
     'SUMMARY:Click to download contact to your address book\n'+
     'DTSTAMP:20120708T203910Z\n'+
     'ATTACH;VALUE=BINARY;ENCODING=BASE64;FMTTYPE=text/directory;\n'+
     ' X-APPLE-FILENAME=iphonecontact.vcf:\n'+' '+paramvalue+'\n'+
     'END:VEVENT\n'+
     'END:VCALENDAR';
      blob b = blob.valueOf(s);
      attachment attach  = new attachment();
      attach.Name ='iphonecontact.ics';
      attach.body=b;
      attach.parentId=booth.id;
     insert attach;
    
    
    
    
    
    string trertr1 ='BEGIN:VCARD\n'+ 'VERSION:3.0\n'+ 'N:'+booth.Name__c+';;;\n'+'FN:'+booth.Name__c+'\n'+'TITLE:'+Booth.Title__c+'\n'+'EMAIL;type=INTERNET;type=WORK;type=pref:'+booth.Email_Address__c+'\n'+
     'TEL;type=CELL;type=VOICE;type=pref:'+booth.Phone_number__c+'\n'+'ORG:'+booth.Company__c+'\n'+'ADR;TYPE=WORK:;;'+Booth.Address__c+';'+Booth.Address_2__c+';'+Booth.City__c+';'+Booth.State__c+';'+Booth.Country__c+'\n'+'URL;WORK:'+Booth.Website_URL__c+'\n'+
     'END:VCARD';
     Blob beforeblob1 = Blob.valueOf(trertr1);
    
      attachment attach1  = new attachment();
      attach1.Name ='Android.Vcf';
      attach1.body=beforeblob1 ;
      attach1.parentId=booth.id;
     insert attach1;
    
    
     sitename ='';
     
    firstMethod();
    }catch(exception e){} 
    return null;
    }


// ---------------------------- Add Broacher Method -------------------------- 
    public PageReference addbrochureAction() {
   try{ 
        if(broacherBlob!=null){
    system.debug('33333333333377777777777 '+ broacherBlob.size());
    booth.Data_Types__c ='Company Broacher';
     booth.Event__c=selectedEvent;
     booth.Booth__c=boothname;
    insert booth;
    
    attachment a = new attachment();
   
    a.parentId=booth.id;
    a.body =broacherBlob;
    a.Name =fileName;
    insert a;
    broacherBlob=null;
    firstMethod();
    }
    
    }catch(exception e){} 
        return null;
    }
    

// ---------------------------- Add Registration  Link Method --------------------------  -->
    public PageReference addAction() {
   try{
    system.debug('77777777777777777777 '+ sn);
    booth.Link_LabelName__c =sn;     
    booth.Booth__c=boothname;
    booth.Data_Types__c ='Registration Link';
    booth.Event__c=selectedEvent;
    string sd =booth.Registration_Link__c;
    if(sd.contains('http://')){
    booth.Registration_Link__c=booth.Registration_Link__c;
    }else{
    booth.Registration_Link__c ='http://'+booth.Registration_Link__c;
    }
    upsert booth;
    sn ='';
    firstMethod();
 }catch(exception e){} 
    return null;
    }

    
}
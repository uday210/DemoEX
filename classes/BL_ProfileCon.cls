public without sharing class BL_ProfileCon {
  public Blob boothadminimage { get; set; }
    public string mydoc {get; set;}
    
    public String imagename { get; set; }
    public List<inn> listinn{get;set;}
    public List<SelectOption> optionsevediversity {get;set;}
    List<SelectOption> optionsevediversity2 {get;set;}
    public List<string> optionsAttdiversity {get;set;}
    public List<Event_Attendee_Mapping__c> eventslist{get;set;}
    public List<string> optionsattdiversity2 {get;set;}
    public MAP<Id,Event_Attendee_Mapping__c> mapIdandObject{get;set;}
    public String selectedgender { get; set; }
    public String HomePoBox { get; set; }
    public String HomeZipcode { get; set; }
    public String ShippingPoBox { get; set; }
    public String ShippingZipcode { get; set; }
    public String WorkPoBox { get; set; }
    public String WorkZipCode { get; set; }
    public String NAICSCode5 { get; set; }
    public String NAICSCode4 { get; set; }
    public String NAICSCode3 { get; set; }
    public String NAICSCode2 { get; set; }
    public String NAICSCode1 { get; set; }
    public String BusinessDunsNumber { get; set; }
    public String BusinessTaxId { get; set; }
    public String BusinessRevenue { get; set; }
    public String NumberOfEmployees { get; set; }
    public String age { get; set; }
    public user userForTimeZone{get;set;}
   
    
    public PageReference login() {
    EventId  = apexpages.currentpage().getparameters().get('id');
   system.debug( ' GGGGG GGGG GGGGGGGGGG'+EventId);
   if(userInfo.getUserType()=='guest'){
    Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
    pg.setredirect(true);
        return pg;
   
   } 
   
   
   List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
      ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventAdmin'];
       if(ty.size()>0){
       Pagereference pg = new pagereference('/apex/BL_EA_Dashboard');
       pg.setredirect(true);
        return pg;
       
       }else{
       return null;
       }    
      
  }

   
  public PageReference cancel() {
    string urlforRedirect =Apexpages.Currentpage().getParameters().get('url');  
    Pagereference pg = new pagereference('/apex/'+urlforRedirect);
    return pg;
   
   } 

    
    public boolean booleanforDisplayBoothadminTab { get; set; }

  public PageReference save() {
   List<folder> folderList =new List<folder>();
  folderList = [select id from folder where name='shared Documents']; 
   if(folderList.size()>0){
   mydoc =folderList[0].id;
   }
   
  
   if(imagename != null && imagename !='')
   { 
      if(boothadminimage.size()<102400 ){
      List<Document> listOfattachments = new  List<Document>();
      listOfattachments =[select id from document where name=:listOfSummary.AS_email__c+'.jpeg'];
      delete listOfattachments ;
      
      Document attach = new Document();
      attach.body = boothadminimage;
      attach.Name =listOfSummary.AS_email__c+'.jpeg';
      attach.ispublic =true;
      attach.FolderId=mydoc ;
      insert attach;
     
      listOfSummary.AS_ImageUrl__c= attach.id;
       system.debug('################### '+listOfSummary.AS_ImageUrl__c);
       }   
     }
 
   
   if(listOfSummary.AS_ImageUrl__c=='' || listOfSummary.AS_ImageUrl__c==null){
    List<document> doc = new List<document>();
      doc =[select id from document where name='Boothadmindefalt.jpeg'];
    if(doc.size()>0){
     listOfSummary.AS_ImageUrl__c =doc[0].id;
     }
   }
   
    
 try{   
 system.debug('Age :'+age+' NO.OF Employees :'+NumberOfEmployees+'BusinessRevenue : '+BusinessRevenue
   +'BusinessTaxId :'+BusinessTaxId +'BusinessDunsNumber :'+BusinessDunsNumber +' NAICS 1 :'+NAICSCode1+
   +' NAICS 2 :'+NAICSCode2 +' NAICS 3'+NAICSCode3+' NAICS 4'+NAICSCode4+'WorkZipCode :'+WorkZipCode +' ShippingPoBox :'+ShippingPoBox
   +'HomeZipcode :'+HomeZipcode);  
    
  if(age != null && age !=''){
  listOfSummary.AS_Age__c= integer.valueOf(age);
  }   
    
  if(NumberOfEmployees!= null && NumberOfEmployees!=''){
  listOfSummary.AS_NumberOfEmployees__c =integer.valueOf(NumberOfEmployees);
  }
    
   if(selectedgender !=null && selectedgender !=''){
   listOfSummary.AS_Gender__c =selectedgender;
   } 
    
   if(BusinessRevenue!= null && BusinessRevenue!=''){
  listOfSummary.AS_BusinessRevenue__c =integer.valueOf(BusinessRevenue);  }
  
    if(BusinessTaxId!= null && BusinessTaxId!=''){
  listOfSummary.AS_BusinessTaxId__c =BusinessTaxId;  
  }
    
      if(BusinessDunsNumber!= null && BusinessDunsNumber!=''){
  listOfSummary.AS_BusinessDunsNumber__c =BusinessDunsNumber; 
  }
   
    
 if(NAICSCode1!= null && NAICSCode1!=''){
  listOfSummary.As_NAICSCode_1__c =NAICSCode1; 
  }
  if(NAICSCode2!= null && NAICSCode2!=''){
  listOfSummary.As_NAICSCode_2__c =NAICSCode2; 
  }
  if(NAICSCode3!= null && NAICSCode3!=''){
  listOfSummary.As_NAICSCode_3__c =NAICSCode3; 
  }
  if(NAICSCode4!= null && NAICSCode4!=''){
  listOfSummary.As_NAICSCode_4__c =NAICSCode4; 
  }
  if(NAICSCode5!= null && NAICSCode5!=''){
  listOfSummary.As_NAICSCode_5__c =NAICSCode5; 
  } 
    
  if(WorkZipCode!= null && WorkZipCode!=''){
  listOfSummary.AS_WorkZip__c= WorkZipCode; 
  }
  
  if(ShippingZipcode!= null && ShippingZipcode!=''){
  listOfSummary.AS_shippingzip__c= ShippingZipcode; 
  }
    
  
    
   
    if(HomeZipcode!= null && HomeZipcode!=''){
  listOfSummary.AS_HomeZip__c= HomeZipcode;
  }   
    
  
  saveDiversity();
    system.debug('3443434434343434343434343434 '+listOfSummary);
  update listOfSummary;
  
  
  
  /*
   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@ '+listOfSummary.id);
   user u=[select FirstName,LastName,Email,Title from user where email =:userInfo.getUserName() limit 1];
   //user u=[select FirstName,LastName,Email,Title from user where email =:'durga+boothadmin1@globalnest.com' limit 1];
   */
    userForTimeZone.FirstName = listOfSummary.AS_FirstName__c;
    userForTimeZone.LastName =listOfSummary.AS_LastName__c;
    userForTimeZone.Title =listOfSummary.AS_Title__c;
    userForTimeZone.States__c=listOfSummary.AS_Work_States__c;
    userForTimeZone.Phone =  listOfSummary.AS_CellPhone__c;
    userForTimeZone.MobilePhone = listOfSummary.AS_WorkPhone__c;
    userForTimeZone.Country__c=listOfSummary.AS_Work_Country__c;
    userForTimeZone.City =listOfSummary.AS_WorkCity__c;
    update userForTimeZone;
    
    
   List<Event_Attendee_Mapping__c> updateList= new List<Event_Attendee_Mapping__c>();
   map<id,string> mapAejandDiversity = new map<id,string>();   
   for(inn h:listinn){
   string strAfterformation='';
   string[] total = new string[]{};
   total=h.optionsAttdiversityInn; 
   total.addAll(h.optionsAttdiversityInn2);
   for(string tre:total){
   if(strAfterformation ==''){
   strAfterformation=tre+';';
   }else{
   strAfterformation = strAfterformation+tre+';';
   }
   }
   system.debug('yyyyyyyyyyyy '+strAfterformation);
   Event_Attendee_Mapping__c obj =mapIdandObject.get(h.iInn);
   obj.DiversityType__c = strAfterformation;
   updateList.add(obj);
   } 
   update updateList;
   
   
   
  string urlforRedirect =Apexpages.Currentpage().getParameters().get('url');  
  system.debug('ZZZZZZZZZZZZZZZZ '+urlforRedirect );
  if(urlforRedirect !=null && urlforRedirect !=''){
      if(EventId == null){
          EventId = '';
      }  
   pageReference pg = new pageReference('/apex/'+urlforRedirect+'?id='+EventId);
   pg.setRedirect(true);
   return pg; 
   }else{
   pageReference pg = new pageReference('/apex/BL_BA_Dashboard?id='+EventId);
   pg.setRedirect(true);
   return pg; 
    }   
 }catch(exception e){return null;}  
}
public string bolId {get;set;}
public string defalutImage {get;set;}

public string attachmentId{get;set;}
public AttendeeSummary__c listOfSummary {get;set;}
public LIST<selectoption> states{get;set;}
 public  List<SelectOption> options {get;set;}
public string nodiversity{get;set;}
public string EventId {get;set;}

    public BL_ProfileCon(){ 
     EventId  = System.currentPageReference().getParameters().get('id');
   system.debug( ' GGGGG GGGG GGGGGGGGGG'+EventId); 
        try{
   //EventId  = System.currentPageReference().getParameters().get('eventid');
   system.debug( ' GGGGG GGGG GGGGGGGGGG'+EventId); 
   listOfSummary = new AttendeeSummary__c();
   nodiversity='';
   attachmentId='';
   
    List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }
   
   
   listOfSummary=[Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.As_NAICSCode_5__c, a.As_NAICSCode_4__c, a.As_NAICSCode_3__c, 
                  a.As_NAICSCode_2__c, a.As_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, 
                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c From AttendeeSummary__c a where a.AS_Email__c =: UserInfo.getUserName()  limit 1];
                  
             system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii '+listOfSummary);
             //UserInfo.getUserName()---a.AS_BusinessTaxId__c, a.AS_BusinessDunsNumber__c,
           userForTimeZone = new user();      
           try{
             userForTimeZone  =[select userName,TimeZoneSidKey from user where userName=:UserInfo.getUserName()]; 
           }catch(exception e){}
     
     
        options = new  List<SelectOption>();
        options.add(new SelectOption('Male','Male')); 
        options.add(new SelectOption('Female','Female')); 
         
         if(listOfSummary.AS_Gender__c =='Male'){
         selectedgender ='Male';
         }else if(listOfSummary.AS_Gender__c =='Female'){
         selectedgender ='Female';
         }
         
             
       if(listOfSummary.AS_ImageUrl__c ==null || listOfSummary.AS_ImageUrl__c ==''){
             
           listOfSummary.AS_ImageUrl__c=defalutImage ;
       
       }  
         
         
         
         
eventslist = new List<Event_Attendee_Mapping__c>();
eventslist  =[select EV_id__c,EV_id__r.EV_Title__c,EV_id__r.EventDiversityValues__c,DiversityType__c from Event_Attendee_Mapping__c where AS_id__c=:listOfSummary.Id and (EV_id__r.Status__c='Event in Progress' Or EV_id__r.Status__c='Event Registration Open')];
listinn = new List<inn>();
mapIdandObject = new MAP<Id,Event_Attendee_Mapping__c>();
if(eventslist.size()==0){
 nodiversity ='No Diversities found';
 
 }

for(Event_Attendee_Mapping__c at :eventslist){
mapIdandObject.put(at.Id,at);
optionsAttdiversity = new List<string>();
optionsevediversity = new List<SelectOption>();
optionsevediversity2 = new List<SelectOption>();
integer i=0;
 for(string s:at.EV_id__r.EventDiversityValues__c.split(';')){
    if(math.mod(i,2)==0){
    optionsevediversity.add(new SelectOption(s,s));
    }else{
    optionsevediversity2.add(new SelectOption(s,s));
    }
    i++;
  }
  
  if(at.DiversityType__c != null){
  optionsAttdiversity=at.DiversityType__c.split(';');
  optionsattdiversity2 =at.DiversityType__c.split(';');
}
  listinn.add(new inn(at.EV_id__r.EV_Title__c,optionsAttdiversity ,optionsevediversity2,optionsevediversity,at.id,optionsattdiversity2 ));
 
 
 
  }
   
           
          
   age =string.valueOf(listOfSummary.AS_Age__c); 
   NumberOfEmployees=string.valueOf(listOfSummary.AS_NumberOfEmployees__c); 
   BusinessRevenue =string.valueOf(listOfSummary.AS_BusinessRevenue__c); 
   BusinessTaxId =string.valueOf(listOfSummary.AS_BusinessTaxId__c);
   BusinessDunsNumber =string.valueOf(listOfSummary.AS_BusinessDunsNumber__c);
   NAICSCode1 =string.valueOf(listOfSummary.As_NAICSCode_1__c); 
   NAICSCode2 =string.valueOf(listOfSummary.As_NAICSCode_2__c); 
   NAICSCode3 =string.valueOf(listOfSummary.As_NAICSCode_3__c); 
   NAICSCode4 =string.valueOf(listOfSummary.As_NAICSCode_4__c); 
   NAICSCode5=string.valueOf(listOfSummary.As_NAICSCode_5__c); 
   WorkZipCode =string.valueOf(listOfSummary.AS_WorkZip__c); 
   ShippingZipcode =string.valueOf(listOfSummary.AS_shippingzip__c); 
   HomeZipcode =string.valueOf(listOfSummary.AS_HomeZip__c); 
  
     
   if(listOfSummary.AS_DiversityType__c != NULL){
   if(listOfSummary.AS_DiversityType__c.contains('Minority Owned Business Enterprise'))
   Select0 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Disadvantaged Business Enterprise'))
   select1 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Service Disabled Veteran Business Enterprise'))
   Select2 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Small Business Enterprise'))
   select3 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Ability One'))
   Select4 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Woman Owned Business Enterprise'))
    Select5 = True;
   if(listOfSummary.AS_DiversityType__c.contains('SBA 8(A) Program'))
   Select6 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Veteran Owned Business Enterprise'))
   Select7 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Lesbian Gay Bisexual Transgender Business'))
   Select8 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Alaskan Native Corporation Owned Firm'))
   Select9 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Small Disadvantaged Business'))
   Select10 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Historically Underutilized Business Zone'))
   Select11 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Disabled Business Enterprise'))
   Select12 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Historically Black Colleges And Universities'))
   Select13 = True;
   if(listOfSummary.AS_DiversityType__c.contains('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS '))
   Select14 = True;
 }  
 
 booleanforDisplayBoothadminTab = false;
 List<User_Profile_Event__c>  forDisplayBoothdmintab= [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:userInfo.getUserName()];
    for(User_Profile_Event__c tt:forDisplayBoothdmintab){
      if(tt.Profile_id__r.PR_Name__c !='Attendee' && tt.Profile_id__r.PR_Name__c !='BoothPersonnel' ){
       booleanforDisplayBoothadminTab = true;
      }   
    }
        }catch(exception e){}
  }
    
 //Diversity Type
 
   Public List<String> Selvalue {get;set;}
    Public Boolean Select0{get;set;}
    Public Boolean Select1{get;set;}
    Public Boolean Select2{get;set;}
    Public Boolean Select3{get;set;}
    Public Boolean Select4{get;set;}
    Public Boolean Select5{get;set;}
    Public Boolean Select6{get;set;}
    Public Boolean Select7{get;set;}
    Public Boolean Select8{get;set;}
    Public Boolean Select9{get;set;}
    Public Boolean Select10{get;set;} 
    Public Boolean Select11{get;set;}
    Public Boolean Select12{get;set;}
    Public Boolean Select13{get;set;}
    Public Boolean Select14{get;set;}   
    
    Public string selectedvaluesfordiversity{get;set;}
    
    Public Void saveDiversity(){
    
    Selvalue =new LIST<String> ();
    if(Select0 == TRUE)
    selValue.add('Minority Owned Business Enterprise');
    if(Select1== TRUE)
    selValue.add('Disadvantaged Business Enterprise');
    if(Select2== TRUE)
    selValue.add('Service Disabled Veteran Business Enterprise');
    if(Select3== TRUE)
    selValue.add('Small Business Enterprise');
    if(Select4== TRUE)
    selValue.add('Ability One');
    if(Select5== TRUE)
    selValue.add('Woman Owned Business Enterprise');
    if(Select6== TRUE)
    selValue.add('SBA 8(A) Program');
    if(Select7== TRUE)
    selValue.add('Veteran Owned Business Enterprise');
    if(Select8== TRUE)
    selValue.add('Lesbian Gay Bisexual Transgender Business');
    if(Select9== TRUE)
    selValue.add('Alaskan Native Corporation Owned Firm');
    if(Select10== TRUE)
    selValue.add('Small Disadvantaged Business');
    if(Select11== TRUE)
    selValue.add('Historically Underutilized Business Zone');
    if(Select12== TRUE)
    selValue.add('Disabled Business Enterprise');
    if(Select13== TRUE)
    selValue.add('Historically Black Colleges And Universities');
    if(Select14== TRUE)
    selValue.add('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ');
    
    selectedvaluesfordiversity= '';
    for(string s: selValue)
        {
            selectedvaluesfordiversity+=s+';';
    listOfSummary.AS_DiversityType__c = selectedvaluesfordiversity;
        }
    
    }

public class inn{
 public List<SelectOption> optionsevediversityInn {get;set;}
 public List<string> optionsAttdiversityInn {get;set;}
 public List<SelectOption> optionsevediversityInn2 {get;set;}
 public List<string> optionsAttdiversityInn2 {get;set;}
 public Id iInn{get;set;}
 public string eventName{get;set;}
 public inn(string s,List<string> l1,List<selectOption> l2,List<selectOption> l3,id i,List<string> l4){
 this.eventName =s;
 this.optionsAttdiversityInn =l1;
 this.optionsAttdiversityInn2 =l4;
 this.optionsevediversityInn =l2;
 this.optionsevediversityInn2 =l3;
 this.iInn =i;
 }





} 
}
public with sharing class BL_PortalHealthCheckCon {

 public List<selectOption> options{get;set;}
 public string selectedValue{get;set;}
 public MAP<id,User_Profile_Event__c> mapIdWininn{get;set;}
 public string password{get;set;}
 public string error{get;set;}
 SET<string> emails = new SEt<string>();
 public boolean reportPage{get;set;}
 public boolean isPortalAdmin{get;set;}
 public event__c eve{get;set;}  
 public MAP<id,event__c>  maieentWithId{get;set;} 
 public string globalSearch{get;set;}
   
   public List<incls> innList{get;set;}
   public MAP<string,Event_Attendee_Mapping__c> mapemailWitheamIds{get;set;}
   public MAP<string,user> mapemailWithuserIds{get;set;} 
   
   public integer counter=0;  //keeps track of the offset
   private integer list_size=100; //sets the page size or number of rows
   public integer total_size; //used to show user the total size of the list
 
   public List<Event__c> eventsList {get;set;}
   public string num{get;set;}
   
   
   
   
     public BL_PortalHealthCheckCon() {
       maieentWithId = new MAP<id,event__c>();
        
         eventsList  = new List<Event__c>(); 
          eventsList =[select id,EV_Title__c,Is_MatchMaking_Event__c from Event__c ];
         for(Event__c e :eventsList ){
           maieentWithId.put(e.id,e); 
         } 
          
          
         selectedValue ='';
          isPortalAdmin  = false;
            try{
            string abd = Apexpages.currentPage().getParameters().get('Admin');
              if(abd =='Phani'){
                isPortalAdmin = true;
              }
            }catch(exception er ){}
           selectedValue =Apexpages.currentPage().getParameters().get('id');         
            if(selectedValue !=null && selectedValue !=''){
              
            }else{
               system.debug('qqqqqqqqqqqqqqqq '+selectedValue );
               if(eventsList.size()>0){
                selectedValue= eventsList[0].id;
                
              }
            
            }
            options = new List<selectOption>();
            for(Event__c eve1 : eventsList){
             options.add(new selectOption(eve1.id,eve1.EV_Title__c));  
               
           }
        reportPage =true;
       selectednumber = '0';
         num = Apexpages.currentPage().getParameters().get('count');
        if(num!=null){
          if(num!='All'){
            list_size =integer.valueOf(num);
          }else{
             list_size =total_size;
             selectednumber ='All';
          }
        }
           
      globalSearch ='';
      getchangedeventvalue();
    }

    
  public string selectednumber{get;set;}
    
   public List<selectOption> getNumberPickList(){
      List<selectOption> optNumbers = new List<selectOption>();
      integer defvalue = 0;
      integer numSlots =  total_size/list_size;
        if(math.mod(total_size, list_size)>0){
           numSlots=numSlots+1;
        }
      
      system.debug('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '+numSlots );
     
       for(integer x=0;x<numSlots;x++){
         optNumbers.add(new selectOption(string.valueOf(defvalue),string.valueOf(defvalue)+'-'+string.valueOf(defvalue+list_size))); 
         defvalue=defvalue+list_size;
      }
       optNumbers.add(new selectOption('All','All'));
      
      return optNumbers;
   }
   
   
   public void getchangedeventvalue(){
     counter=0;  //keeps track of the offset
      total_size=[select count() from Event_Attendee_Mapping__c where EV_id__c =:selectedValue and as_id__c!=null ]; //set the total size in the constructor
     globalSearch ='';
     onchangeEvent();   
   }
   
   
   public void onchangeEvent(){
   innList = new List<incls>();
   error='';
   mapIdWininn = new MAP<id,User_Profile_Event__c>();
   mapemailWithuserIds = new MAP<string,user>();
   
    system.debug('qqqqqqqqqqqqqqqq '+selectednumber );
   
    if(selectednumber!='All'){
     counter=  integer.valueOf(selectednumber);
     if(num!=null){
           if(num!='All'){
            list_size =integer.valueOf(num);
           }else{
            list_size =total_size;
           }
        }else{
      list_size =100;
     }
     
  }else{
       counter=0;
      list_size = total_size;
     }
     
     eve = new event__c();
     if(selectedValue  != null){    
       eve  = maieentWithId.get(selectedValue);
    }
            
       mapemailWitheamIds = new MAP<string,Event_Attendee_Mapping__c>();
       
       
       List<Event_Attendee_Mapping__c> eams;
       
       integer rowcount =0;
       
       if(globalSearch.length() > 1){
           eams = [select Owner.Name,GuestType__c,TicketTypes__c,id,as_id__c,EV_id__c,as_id__r.AS_FirstName__c,as_id__r.AS_LastName__c,as_id__r.AS_Email__c,as_id__r.AS_company__c from Event_Attendee_Mapping__c where (EV_id__c =:selectedValue and as_id__c!=null) and (as_id__r.AS_FirstName__c Like :globalSearch+'%' OR as_id__r.AS_LastName__c Like :globalSearch+'%' OR as_id__r.AS_Email__c Like :globalSearch+'%' OR as_id__r.AS_company__c Like :globalSearch+'%')];   
      
        
       }else{
            eams = [select Owner.Name,GuestType__c,TicketTypes__c,id,as_id__c,EV_id__c,as_id__r.AS_FirstName__c,as_id__r.AS_LastName__c,as_id__r.AS_Email__c,as_id__r.AS_company__c from Event_Attendee_Mapping__c where EV_id__c =:selectedValue and as_id__c!=null limit :list_size    offset :counter];   
          rowcount =counter;
        }
       
       
       
        for(Event_Attendee_Mapping__c eam :eams  ){
           mapemailWitheamIds.put(eam.as_id__r.AS_Email__c,eam); 
           system.debug('CCCCCCCCCCCCCCC '+eam.as_id__r.AS_Email__c);
       }
       
       emails.addAll(mapemailWitheamIds.keySet());
       
      
     LIst<user> users =new List<user>();
       for(user u : [select id,userName,isActive,isSignup__c,email,profile.Name,password__c,lastName, name from user where userNAme in :emails]){
          mapemailWithuserIds.put(u.userName,u); 
       } 
      
       
     List<Dummay__c> dumsList = [select id,Email__c,customer_key__c,customer_key__r.Name,TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c from Dummay__c  where Event__c =:selectedValue and customer_key__r.IsInserted__c =true and email__c in :emails];
     MAP<string,List<Dummay__c>> mapemailWithIds = new MAP<string,List<Dummay__c>>();
     
     
       List<User_Profile_Event__c>  upeList = new List<User_Profile_Event__c>();
       upeList = [Select u.User_id__c, u.UEP_isActive__c, u.Status__c, u.Request_for_upgrade_profile__c, u.Profile_id__c, u.OwnerId, u.Name,  u.MAtchMakingProfile__c, u.IsMatchMakingUser__c,  u.IsBoothLeadsUser__c, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c, u.Attendee_Summary__c,Profile_id__r.PR_Name__c,User_id__r.userName,User_id__r.Isactive,User_id__r.isSignup__c,User_id__r.password__c,Owner.Name,BT_id__r.BT_Name__c,Attendee_Summary__r.AS_company__c,Attendee_Summary__r.AS_email__C,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_FirstName__c From User_Profile_Event__c u where EV_id__c=:selectedValue and User_id__r.userName in :emails];
    
      MAP<string,List<User_Profile_Event__c>> mapemailWithupeIds = new MAP<string,List<User_Profile_Event__c>>();
     
      
     //Get user Bought tickets
     for(string str : emails){ 
     List<Dummay__c> dumsListtemp = new List<Dummay__c> ();
      for(Dummay__c dums :dumsList  ){
             if(dums.Email__c == str){
                dumsListtemp.add(dums); 
             }  
       }
       mapemailWithIds.put(str,dumsListtemp);
       
       List<User_Profile_Event__c>  upeListTemp = new List<User_Profile_Event__c>();
        for(User_Profile_Event__c upe : upeList ){
           mapIdWininn.put(upe.id,upe);
          if(upe.User_id__r.userName == str){
             upeListTemp.add(upe);           
           }
       
       }
       mapemailWithupeIds.put(str,upeListTemp );     
     }  
  
  
      
      
       for(Event_Attendee_Mapping__c eamIn :eams  ){
         rowcount++;
          if(mapemailWithuserIds.get(eamIn.AS_Id__r.AS_Email__c)!=null){
          
             innList.add(new incls(eamIn,mapemailWithupeIds.get(eamIn.AS_Id__r.AS_Email__c),mapemailWithIds.get(eamIn.AS_Id__r.AS_Email__c),mapemailWithuserIds.get(eamIn.AS_Id__r.AS_Email__c),rowcount));
          }else{
             innList.add(new incls(eamIn,mapemailWithupeIds.get(eamIn.AS_Id__r.AS_Email__c),mapemailWithIds.get(eamIn.AS_Id__r.AS_Email__c),new user(),rowcount));
          }
        
       }
      dumsList.clear();
      eams.clear();
      upeList.clear();
      users.clear();
     //return innList;
   }

  
  
  
/*  public List<incls> getinnList(){
    onchangeEvent();
    return innList;  
  }
*/
   
     
   

  
  public Integer getTotal_size() {
   return total_size;
  }
  
 
  
 
/* Pagination End*/


  public void updateIndUpeValues(){
  error ='';
     string upeId  = Apexpages.currentPage().getParameters().get('upeValue');
     List<User_Profile_Event__c> uprForupdate = new List<User_Profile_Event__c>();
     List<Event_Attendee_Mapping__c> eamlListFoup = new  List<Event_Attendee_Mapping__c>();
         
     if(upeId!='' && upeId!=null){
        uprForupdate.add(mapIdWininn.get(upeId));
     }else{
        for(incls imc :innList){
           uprForupdate.addAll(imc.upeInn);
        }     
     }
     system.debug('999999999999999999999 '+uprForupdate);
     for(User_Profile_Event__c uip :uprForupdate){
       Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
       system.debug('AAAAAAAAAAAA '+uip.User_id__r.userName);
         if(uip.MatchMakingProfile__c=='Corporate'){
           eam.Boothleads_Profile__c  ='Booth Amin'; 
         }else{
            eam.Boothleads_Profile__c  ='MBE'; 
         }
         
         if(uip.IsMatchMakingUser__c){
            eam.IsMatchMakingAttendee__c =true;
         }else{
            eam.IsMatchMakingAttendee__c =false;
         }
         
          eam = mapemailWitheamIds.get(uip.User_id__r.userName);
          eam.GuestType__c= uip.MatchMakingProfile__c;
          eamlListFoup.add(eam ); 
     } 
     
    dataBase.update(uprForupdate,false);
    dataBase.update(eamlListFoup,false);
    error = 'Updated successfully';
  }
  
  
  public void deleteUpe(){
     string upeId  = Apexpages.currentPage().getParameters().get('upeValue');
     if(upeId!='' && upeId!=null){
       dataBase.delete(mapIdWininn.get(upeId),false);
      
     }
  
  }
  
  
  
  public pageReference updatePassword(){
  error ='';
    string emailstr = Apexpages.currentPage().getParameters().get('emValue');
    
    string tr= Apexpages.currentPage().getParameters().get('index');
    system.debug('WWWWWWWWWWWWWWWWWWW '+emailstr +' EEEEEEEEEEEEEEEEE '+tr);
     List<user> uL = new List<user>();
      if(mapemailWithuserIds.get(emailstr)!=null){
        user uy = new user();
         uy = mapemailWithuserIds.get(emailstr);
         if(uy.isSignup__c ==true || uy.profile.Name =='Event Admin' ){
           if(tr!=null && tr!=''){   
             uy.password__c =tr;
             uL.add(uy);
           }
        }else{
             error ='please Sign up';  
              return null;    
         }
      }else{
         error ='please Sign up';  
         return null; 
      }
      dataBase.saveResult[] upres = new dataBase.saveResult[]{};
     
     if(uL.size()>0){
       try{
           system.setPassword(uL[0].id,tr);
             upres = dataBase.update(uL,false);
           
             if(upres[0].isSuccess()){
                error = 'Updated successfully';
             }else{
                for(dataBase.saveResult up :upres){
                  for (Database.Error err : up.getErrors()){
                     error = err.getMessage() ;
                     break;
                  } 
               }
             }
          
           } catch(exception e){
             system.debug('DDDDDDDDDDDDDDDDDD '+e);
              error =e.getMessage() ;
        } 
         
     }
     return null;   
   }
  
  public UtillForInsertUser utillUser{get;set;}
  
  public Pagereference userSignup(){
  utillUser = new UtillForInsertUser();  
     string emailstr = Apexpages.currentPage().getParameters().get('emValue');
     string tr= Apexpages.currentPage().getParameters().get('index');
     system.debug('WWWWWWWWWWWWWWWWWWW 2222222222222'+emailstr +' EEEEEEEEEEEEEEEEE 3333333333333'+tr);
      boolean isSetpassword =false;
      List<user> uL = new List<user>();
      if(mapemailWithuserIds.get(emailstr)!=null){
          user uy = new user();
           uy = mapemailWithuserIds.get(emailstr);
           if(uy.isSignup__c){
               uy.isActive =true;
               uL.add(uy);
               dataBase.update(uy,false);
               error = 'user already Signedup';
              return null; 
            }else{
               //savePoint sp2 = new Database.setsavepoint();
               Savepoint sp2 = Database.setSavepoint(); 
                uy.isSignup__c =true;
                uy.password__c =tr;
                uy.isActive =true;
                dataBase.update(uy,false);
                try{
                 system.setPassword(uy.id,tr); 
                 isSetpassword  =true; 
                 SET<string> strEmailforInsertUpes = new SET<string>();
                 strEmailforInsertUpes.add(uy.userName);
                // UtillForInsertUser utt = new UtillForInsertUser();
                 UtillForInsertUser.forupdateEAM(strEmailforInsertUpes ,selectedValue,false);
                 error = 'Updated successfully';
                return null; 
              }catch(exception er){
                 isSetpassword =false;
                 error = er.getMessage();
                 dataBase.rollBack(sp2);
                 return null; 
              }
           }
       }else{
          utillUser = new UtillForInsertUser();  
          List<Event_Attendee_Mapping__c> listValues = new List<Event_Attendee_Mapping__c >(); 
          listValues.add(mapemailWitheamIds.get(emailstr));
         error  = utillUser.insertUsers(listValues,true,selectedValue,false,tr);
       }
       return null;
  }
  
  
  public pageReference createUpes(){
       error ='';
       string isMat= Apexpages.currentPage().getParameters().get('match');
       system.debug('PPPPPPPPPPPPPPPPPPPPPpp '+isMat);
        boolean isMatbool = boolean.valueOf(isMat);
     
        if(isMat=='true'){ 
         if(eve.Is_MatchMaking_Event__c==false){
             isMatbool  =false;
        }
       } 
       utillUser =new UtillForInsertUser();  
        List<Event_Attendee_Mapping__c> listValues = new List<Event_Attendee_Mapping__c >(); 
       for(incls inc :innList){
          if(inc.chk){
            listValues.add(inc.eamsInn);     
          }
       }
      string msg  = utillUser.insertUsers(listValues,false,selectedValue,isMatbool,'');
      
       if(msg=='You have successfully signed up'){
        error = 'You have created upes successfully'; 
        
       }
     return null; 
  }
  
  
  public PAgereference updateEmail(){
      string emailstr = Apexpages.currentPage().getParameters().get('emValue');
      string cheEmail= Apexpages.currentPage().getParameters().get('index');
      system.debug('111111111111 '+emailstr +' 2222222222222 '+cheEmail);
      
       if(mapemailWitheamIds.get(emailstr)!=null){
           List<AttendeeSummary__c> atts = new List<AttendeeSummary__c>();
           List<user> usersLi  = new List<user>();
          
          
           for(user u : [select id,userName,Email from user where userName=:emailstr]){
               u.Email = cheEmail;
               u.userName  =cheEmail;
               u.isActive =true;
               usersLi.add(u);      
           }
          
          
           for (AttendeeSummary__c ad : [select id,AS_Email__C from AttendeeSummary__c where id =:mapemailWitheamIds.get(emailstr).AS_Id__c]){
               ad.AS_Email__c = cheEmail;
               atts.add(ad);
           }
           
           
           Savepoint sp = Database.setSavepoint(); 
           
            if(usersLi.size()>0){
                 dataBase.saveResult[] sar  = dataBase.update(usersLi,false);
                 for(dataBase.saveResult sa :sar){
                  for (Database.Error err : sa.getErrors()){
                     error = err.getMessage() ;
                     return null;
                  } 
                }
             }
       if(usersLi.size()<=0){    
          if(atts.size()>0){
             dataBase.saveResult[] sar1  = dataBase.update(atts,false);
             system.debug('RRRRRRRRRRRR '+sar1);
               for(dataBase.saveResult sa1 :sar1){
                  for (Database.Error err : sa1.getErrors()){
                     error = err.getMessage() ;
                     Database.rollback(sp);
                     return null;
                  } 
                }
            } 
          }else{
          List<AttendeeSummary__c > alList =[select id,AS_email__c from  AttendeeSummary__c where AS_email__c  = :cheEmail];
             if(alList.size()<=0){
               updateAttendee(emailstr,cheEmail);
            }else{
              Database.rollback(sp);
               error = 'we already have user with this name';
              return null;
            }
          }   
           
       }
     error = 'Email has changed successfully';
     return null;
  }
  
  @future 
  public static void  updateAttendee(string oldemail,string newemail){
    List<AttendeeSummary__c> ats = new List<AttendeeSummary__c>();
    for( AttendeeSummary__c ade : [select id,AS_email__c from  AttendeeSummary__c where AS_email__c  = :oldemail]){
        ade.AS_Email__c = newemail; 
       ats.add(ade);
    }
    dataBase.saveResult[] sar1  = dataBase.update(ats,false);
  
  }
  
  
  
  
  
  public class incls{
    public boolean chk {get;set;}
    public Event_Attendee_Mapping__c eamsInn{get;set;}
    public List<User_Profile_Event__c> upeInn{get;set;}
    public List<Dummay__c> dumsList{get;set;}
    public user uInn{get;set;}
    public string passInn{get;set;}
    public integer rowcountInn{get;set;}
    
    public incls(Event_Attendee_Mapping__c ea,List<User_Profile_Event__c> upeI,List<Dummay__c> dums,user uIn,integer ro){
      eamsInn= new Event_Attendee_Mapping__c();
      this.eamsInn = ea;
      upeInn =new List<User_Profile_Event__c>();
      this.upeInn = upeI;
      dumsList = new List<Dummay__c>();
      this.dumsList  = dums;
      rowcountInn = ro;
      uInn = new user();
      uInn = uIn;
    } 
  
  }
  
   public void showhidePanel2(){
      reportPage =true;
   }
   
   
   
  
   public void showhidePanel(){
      reportPage=false;
       
  }
  
  public PageReference insertBooth() {
     string upeId  = Apexpages.currentPage().getParameters().get('upeValue');
       User_Profile_Event__c uypnew = new User_Profile_Event__c ();
       if(upeId!='' && upeId!=null){
           uypnew=mapIdWininn.get(upeId);
          string boothName =uypnew.Attendee_Summary__r.AS_company__c;
          List<booth__c> booths =[select id,Name from booth__c where Name = :boothName and EV_id__c=:selectedValue];
          if(booths.size()>0){
            uypnew.BT_id__c =  booths[0].id;
            Update uypnew ;
           
          }else{
                 Booth__c Booth  = new Booth__c();
                 booth.EV_id__c =selectedValue;
                 booth.BT_ContactEmail__c = uypnew.Attendee_Summary__r.AS_email__C;
                 booth.BT_Name__c =boothName ;
                 booth.BT_ContactName__c =uypnew.Attendee_Summary__r.AS_LastName__c+' '+uypnew.Attendee_Summary__r.AS_FirstName__c;
                 dataBase.saveResult rtres  = dataBase.insert(booth,false);
                 if(rtres.isSuccess()){
                     uypnew.BT_id__c =  rtres.getid();
                     Update uypnew ;
                    
                 }
          
          }
        // onchangeEvent();
     }
        return null;
    }

  
  
}
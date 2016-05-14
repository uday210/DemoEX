public without sharing class BL_Eventadmin_BoothAdminsCon {


    public BL_Eventadmin_BoothAdminsCon () {
            URLEvent();// Added by Shruthi            
            ListOfEvents();
            commonMethod();
            conlst=false;
            HideBoothAdminBtn = False; 
            ExportBoothAdmins = True;
            HideBoothBtn = True; 
            ForU = new User();
           
             
            
    
  }

public Transient List<User_Profile_Event__c> BoothAdminsList{get;set;}
public List<User_Profile_Event__c> ForPaginationBoothAdminsList{get;set;}
Public String SelectEvent{get;set;}
public String SelectedBooth{get;set;}
public List<Booth__c> Booths{get;set;}
public List<selectoption> eventslistforselect {get;set;}
public List<User_Profile_Event__c> EventsList{get;set;}
public Boolean hasLast{get;set;}
public Boolean hasFirst{get;set;}
public Integer PgNo{get;set;}
Public Boolean conlst{get;set;}
Public Boolean hasPrevious {get;set;}
Public Boolean hasNext {get;set;}
Public Integer pageno {get;set;}
Public Integer count {get;set;}
public Boolean Disabled_First_Icon{get;set;}
public Boolean Disabled_Last_Icon{get;set;}
public Boolean Disabled_Previous_Icon{get;set;}
public Boolean Disabled_Next_Icon{get;set;}
public Booth__c Booth{get;set;}
public User BoothAdminUser{get;set;}
public string Email{get;set;}
public contact con{get;set;}
public Boolean CreatBoothAdminPopUp{get;set;}
public Account A{get;set;}
public Boolean HideTable{get;set;}
public Boolean CloseBoothName{get;set;}
public Boolean CloseBoothLocation{get;set;}
public Boolean ExportBoothAdmins{get;set;}
public Boolean HideBoothAdminBtn{get;set;}
public Boolean HideBoothBtn{get;set;}
public string BoothAdminDetails{get;set;}
public Boolean ShowBoothAdminPopUp {get;set;}
public User BoothAdmininfo {get;set;}
public Booth__c OnlyBoothInfo {get;set;}
public map<string,string> states{get;set;} 
public map<string,string> countries{get;set;}
Public string Country{get;set;}
Public string state{get;set;}
public Boolean EditBoothAdminPopUp {get;set;}
public String BoothAdminId{get;set;}
public Boolean IsInactive{get;set;}
public Boolean Isactive{get;set;}
public List<InnerClass> ListOfInnerClass{get;set;}
public List<InnerClass> ForPagination{get;set;}
public String Selectedstatus{get;set;}
public String BoothSelected{get;set;}
public String Status{get;set;}
public Boolean Statuspopup{get;set;}
public String SelectBoothId{get;set;}
public List<User_Profile_Event__c> listOfBoothadminsforExport {get;set;}
public Boolean DisplayNoEventMessage{get;set;}
public String SelectedBoothName {get;set;}
public String SelectedEventName {get;set;}
public Boolean NoRecordsFound{get;set;}
public boolean DisplayPages{get;set;} 
public Boolean CreatOnlyBoothAdminPopUp {get;set;} 
public Boolean Error{get;set;}
public String ErrorMessage{get;set;}
public User ForU{get;set;}
public string SelectedEName{get;set;}
public integer ForPagesize{get;set;}
public Event__c SelectedEventId {get;set;}
public Booth__c BoothName{get;set;}
public string id{get;set;}
public Boolean HideFloorMapButton{get;set;}

  public PageReference exportBoothadmins() { 
    
    system.debug('11111111111111111111111 '+SelectedBooth);
    listOfBoothadminsforExport = new List<User_Profile_Event__c>();
    
    if(SelectedBooth == null ){
    system.debug(' -------------------------------------- ***********************'+selectevent);
    listOfBoothadminsforExport = [select BT_id__r.BT_Name__c,BT_id__r.BT_Location__c,
                                  EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c,BoothAdmin_id__r.Email,BoothAdmin_id__r.Name,
                                  BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Companyphone__c,
                                  BoothAdmin_id__r.CompanyAddr1__c,BoothAdmin_id__r.CompanyAddr2__c,
                                  BoothAdmin_id__r.CompanyCity__c,BoothAdmin_id__r.States__c,
                                  BoothAdmin_id__r.Country__c,BoothAdmin_id__r.CompanyFaxNumber__c,
                                  BoothAdmin_id__r.Company_website__c,BoothAdmin_id__r.Zipcode__c,
                                  BoothAdmin_id__r.PoBox__c from  User_Profile_Event__c where EV_id__c=:selectEvent and Profile_id__r.PR_Name__c='BoothAdmin'];
    system.debug(' ---- $$$$$$$$$$$$$$ ---'+listOfBoothadminsforExport );
    
    }
     else{
     system.debug(' ------ ******************** -----------');
     listOfBoothadminsforExport = [select BT_id__r.BT_Name__c,BT_id__r.BT_Location__c,
                                     EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c,BoothAdmin_id__r.Email,BoothAdmin_id__r.Name,
                                     BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Companyphone__c,
                                     BoothAdmin_id__r.CompanyAddr1__c,BoothAdmin_id__r.CompanyAddr2__c,
                                     BoothAdmin_id__r.CompanyCity__c,BoothAdmin_id__r.States__c,
                                     BoothAdmin_id__r.Country__c,BoothAdmin_id__r.CompanyFaxNumber__c,
                                     BoothAdmin_id__r.Company_website__c,BoothAdmin_id__r.Zipcode__c,
                                     BoothAdmin_id__r.PoBox__c from  User_Profile_Event__c where 
                                     EV_id__c=:selectEvent and Profile_id__r.PR_Name__c='BoothAdmin' and 
                                     BT_id__c=:SelectedBooth];
     system.debug(' ------ ******************** -----------'+listOfBoothadminsforExport );
    
    }
    
    for(User_Profile_Event__c b:listOfBoothadminsforExport ){
   
   
    if(b.BoothAdmin_id__r.Zipcode__c!=null){
   if(b.BoothAdmin_id__r.Zipcode__c.length()==5 && b.BoothAdmin_id__r.Zipcode__c.startsWith('0')){
                   string HomeZip =b.BoothAdmin_id__r.Zipcode__c;
                   b.BoothAdmin_id__r.Zipcode__c='';
                   b.BoothAdmin_id__r.Zipcode__c ='"=TEXT('+HomeZip+','+'\""00000\"")"';
                  }
    
    }
    
    if(b.BoothAdmin_id__r.PoBox__c !=null){
   if(b.BoothAdmin_id__r.PoBox__c .length()==5 && b.BoothAdmin_id__r.PoBox__c .startsWith('0')){
                   string HomeZip1 =b.BoothAdmin_id__r.PoBox__c ;
                   b.BoothAdmin_id__r.PoBox__c ='';
                   b.BoothAdmin_id__r.PoBox__c ='"=TEXT('+HomeZip1+','+'\""00000\"")"';
                  }
    
    }
    
    
 }  
    if(listOfBoothadminsforExport.size() > 0){
    PageReference pageRef= new PageReference('/apex/BL_Eventadmin_exportBoothAdmins');
    pageRef.setredirect(false);
    return pageRef;
    }else {
    
    DisplayNoEventMessage = True;
    
    }
    return null;
    }
  
  public void commonMethod(){
  BoothsList();
  ListOfBoothAdmins();
  
  }
  

  public void  BoothsList(){
  
   system.debug('------------------- EEEEEEEEEEEEEEEEEEEEE'+SelectEvent );
   BoothAdminsList = new List<User_Profile_Event__c> ();
   BoothAdminsList = [select BT_id__c,BT_id__r.BT_Name__c,EV_id__r.Is_MatchMaking_Event__c from User_Profile_Event__c 
                  //where EventAdmin_Id__r.id=: userinfo.getUserId() 
                  where EV_id__c =:SelectEvent 
                  AND Profile_id__r.PR_Name__c ='BoothAdmin' 
                  AND BT_id__r.BT_isBoothActive__c = True]; 
   system.debug('------------------- &&&&&&&&&&&&&&&&&&&&&&& '+BoothAdminsList );               
   set<ID> UniqueBoothIds = new  set<ID> ();
   
   for(User_Profile_Event__c BoothsIds :BoothAdminsList ){
   UniqueBoothIds.add(BoothsIds.BT_id__c);
   system.debug('------------------- &&&&&&&&&&&&&&&&&&&&&&& '+UniqueBoothIds);
   }
   
   Booths = new List<Booth__c> ();        
   Booths = [select Id,BT_Name__c,Table_Room_No__c from Booth__c where Id IN:UniqueBoothIds ORDER BY BT_Name__c ASC];  
   system.debug('------------------- &&&&&&&&&&&&&&&&&&&&&&& '+UniqueBoothIds);
  
  if(selectevent != null){ 
      Event__c ForEventName = [select EV_Title__c,Is_MatchMaking_Event__c,Need_FloorMap__c from Event__c where id=:selectevent];
      SelectedEventName = 'of '+ForEventName.EV_Title__c;
      SelectedEName = ForEventName.EV_Title__c;
      system.debug(' ------ !!!!!!!!!!!!!! -----'+SelectedEventName );
      SelectedBoothName = '';
      if(ForEventName.Need_FloorMap__c == True){
          HideFloorMapButton = TRUE;
      }else{
          HideFloorMapButton = False;
      }
  }

   
  }
  
    
   
   Public void  ListOfEvents(){
   eventslistforselect = new List<selectoption>();  
   EventsList = new List<User_Profile_Event__c>(); 
   EventsList = [SELECT Id,EV_id__c,EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c 
                 FROM User_Profile_Event__c 
                 WHERE (EventAdmin_Id__c =: userinfo.getUserId() OR User_Id__c =: userinfo.getUserId())
                 AND (Profile_id__r.PR_Name__c ='EventAdmin' OR Profile_id__r.PR_Name__c ='EventAdmin Staff')
                 ORDER BY CreatedDate ASC]; 
    system.debug (' AAAAAAAAAAAAAAAAAA '+EventsList+'fffffffffff'+id  );                            
                            
    for(User_Profile_Event__c UserPEvent: EventsList){
    
    if(UserPEvent.EV_id__c != null){
    
    eventslistforselect.add(new Selectoption(UserPEvent.EV_id__c,UserPEvent.EV_id__r.EV_Title__c));
    
     if(id == null || id == ''){
     system.debug(' GGGGGGG GGGGGGGG'+id);
        SelectEvent = UserPEvent.EV_id__c;
    }  
    }
    
    
    
    system.debug (' ddddddddddddd '+SelectEvent );               
    }
   // return eventslistforselect; 
   
    
   }
   
   
   
    
    
    public void ListOfBoothAdmins(){
         ForPageSize = null;
   
         ListOfInnerClass = new List<InnerClass>();
         
        
         SelectBoothId = ApexPages.currentpage().getparameters().get('BoothName');
        
         SelectedBooth = SelectBoothId ;
         
         system.debug( ' AAAAAAAAAAAAAAAAAAAAAAAAAA NNNNNNNNNNNN '+SelectedBooth );
         
         ForPagination = new List<InnerCLass>();   
        if(SelectedBooth == null && SelectEvent != null){
        
         HideBoothAdminBtn = False; 
         HideBoothBtn = True;
         List<User_Profile_Event__c>  Example = new List<User_Profile_Event__c>();
        
        BoothAdminsList = [SELECT UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BT_id__r.Table_Room_No__c,
                                  BoothAdmin_id__r.FirstName,BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                                  BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,
                                  BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate
                           FROM User_Profile_Event__c 
                         //  WHERE ( EventAdmin_Id__c=: UserInfo.getUserId() OR User_Id__c=: UserInfo.getUserId())
                           WHERE EV_id__c =:SelectEvent 
                           AND Profile_id__r.PR_Name__c ='BoothAdmin'];
                   system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+BoothAdminsList );            
                             for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }
                              
        system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+ListOfInnerClass.size()); 
        try{                   
       if(ListOfInnerClass.size()>0)
        {
        
         
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=ListOfInnerClass.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ListOfInnerClass[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
       if(ListOfInnerClass.size() <= 10){
     
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }         
        
        }
         
        } else {
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False;
        
        }
       }catch(Exception ex){}                 
           system.debug(' 444444444444'+SelectedBooth +'$$$$$ $$$$$$ $$$$$$$'+SelectEvent);

    }else {
      system.debug(' FFFFFFFFFFFFF FFFFFFFFFFFF FFFFFFFFFFFFFFF'+SelectedBooth +'$$$$$ $$$$$$ $$$$$$$'+SelectEvent);
      HideBoothAdminBtn = True;
      HideBoothBtn = False;
      BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BT_id__r.Table_Room_No__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                              BoothAdmin_id__r.LastLoginDate from User_Profile_Event__c 
                             // where EventAdmin_Id__c=: UserInfo.getUserId() 
                              where EV_id__c =:SelectEvent 
                              AND BT_ID__c =: SelectedBooth 
                              AND Profile_id__r.PR_Name__c ='BoothAdmin'];
                              
                        for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }      
 
        try{                  
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         conlst=true;
         hasLast = True;
         hasFirst = False;
         count=BoothAdminsList.size();
         hasPrevious =false;
         hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+BoothAdminsList[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
       
        } 
    } catch(exception ex){
    
    }
    } 
    if(SelectedBooth != null){
    BoothName = [select BT_Name__c from Booth__c where id=: SelectedBooth ];
    system.debug(' ------- !!!!!!!!!! @@@@@@@@@@@@-----'+BoothName);
    SelectedeventName = ''; 
    //SelectedEName = '';
    SelectedBoothName = 'of '+BoothName.BT_Name__c;
     system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+selectedbooth );
   } 
    
  if(ForPagination.size() == 0){
       NoRecordsFound = True;
       DisplayPages = False;
     }  else {
        NoRecordsFound = False;
        DisplayPages = True;
    }
    ForPagesize = ForPagination.size();
}


 Public void First()
     {   
     try{
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True;
         Disabled_Previous_Icon = True;
         Disabled_First_Icon = True;
         Disabled_Next_Icon = False;
         Disabled_Last_Icon = False;
         ForPagination.clear();
         //hasPrevious=false;
         pageno =1;
         for(integer i=0;i<10;i++)
          {
          ForPagination.add(ListOfInnerClass[i]);
          
         }
         if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            ForPagesize = ForPagination.size();
            }catch(Exception ex){
     
     }
     }
     
         Public void Previous()
     {   
       try{ 
          hasLast=True;
          hasNext=true;
          Disabled_Previous_Icon = False;
          Disabled_First_Icon = False;
          Disabled_Next_Icon = False;
          Disabled_Last_Icon = False;
          
         ForPagination.clear();
         if(pageno  !=1)
             {    
                  system.debug( ' PPPPPPPPPPPPPPPPPP'+Disabled_Previous_Icon);
                  system.debug( ' FFFFFFFFFFFFFFF'+Disabled_First_Icon);
                  
                  pageno  = pageno  - 1;
                  If(pageno  ==1 ){
                  hasPrevious=false;
                  hasFirst = False;
                  Disabled_Previous_Icon = True;
                  Disabled_First_Icon = True;
                  Disabled_Next_Icon = False;
                  Disabled_Last_Icon = False;
                 }  
                   for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
                     {
                         ForPagination.add(ListOfInnerClass[i]); 
                     }
             }                           
             else
              {   
              
              system.debug( ' AAAAAA '+Disabled_Previous_Icon + ' BBBBBB'+Disabled_First_Icon);
                  hasPrevious=false;
                  hasFirst = False;
                //  Disabled_Previous_Icon = True;
                //  Disabled_First_Icon = True;
                  
                  for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
                     {
                         ForPagination.add(ListOfInnerClass[i]); 
                      }
              }
              ForPagesize = ForPagination.size();
       }
       catch(Exception ex){
     
     }
     
    
     }
       
            Public void Next()
     {   try{
     
         pageno  = pageno +1;
        // integer pgno;
         ForPagination.clear();
         if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                  Disabled_Next_Icon = True;
                  Disabled_Last_Icon = True;
                  for(integer i=(pageno -1)*10;i<ListOfInnerClass.size();i++ )
                    {
                     ForPagination.add(ListOfInnerClass[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST------'+ForPagination.size()+' RECORDS '+ListOfInnerClass[i]+ ' sssssssssssswwwwwwww'+Pgno);
                    
                    }
             }
           else            
            for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
              {
                     ForPagination.add(ListOfInnerClass[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+ListOfInnerClass[i]);
             }
            hasPrevious=true;
            hasFirst = True;
            Disabled_Previous_Icon = False;
            Disabled_First_Icon = False;
            
        System.debug('---------------------------- LIST SIZE OF TEMPLIST ---------------------'+ListOfInnerClass.size());
     
     ForPagesize = ForPagination.size();
    
    }catch(Exception Ex){
     
     }
    
     }
     
     Public void Last()     
     {  
     
     try{
         hasLast = False;
         Disabled_Last_Icon = True;
         System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
        Disabled_Previous_Icon=False;
        hasFirst = true;
        Disabled_First_Icon=False;
        ForPagination.clear();
         hasNext=false;
          Disabled_Next_Icon=True;
        if( math.mod(ListOfInnerClass.size(),10)==0){
          System.debug('---------44444444444444444----'+pageno );
             pageno =ListOfInnerClass.size()/10;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
            pageno =(ListOfInnerClass.size()/10) +1; 
            }
         for(integer i=(pageno -1)*10;i<ListOfInnerClass.size();i++)
          {
              ForPagination.add(ListOfInnerClass[i]);  
         }
          ForPagesize = ForPagination.size();
     }catch(Exception ex){
     }
     }
     
 
     
     public void AddBoothAdmin(){
     
     BoothAdminUser = new User();
     Con = new Contact();
     A  = new Account();
     DisplayNoEventMessage = False; 
     CreatOnlyBoothAdminPopUp = True;
     email = '';
     error = False;
     }
     
     
     public void AddBooth(){
     CreatBoothAdminPopUp = True;
    // CreatOnlyBoothAdminPopUp = True;
     DisplayNoEventMessage = False;
     Booth = new Booth__c();
     BoothAdminUser = new User();
     Con = new Contact();
     A  = new Account();
     email = '';
     error = False;
     
    
     
     
     }
 
     public void SaveBooth(){
       
        system.debug( ' DDDDDDDDDDDDDDDDDDDDDDDDDDD '+selectedBooth );
        
        if(selectedBooth != null){
        List<User> ComparingUserEmailsev = [Select Id,Email,Username From User Where UserName =: Email AND  Profile.Name=:'Event Admin' ];
                if(ComparingUserEmailsev.size()!= 0){
                error=true;
               errormessage='Email Already Exist';
               system.debug(' First Error ***************');
               
               BoothAdminUser = new User();
               Con = new Contact();
               A  = new Account();
               }
               else {
        Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c 
                                           where PR_Name__c='BoothAdmin'];
                                           
        system.debug('::::::::: Inserting Booth ::::::::::::'+Email);
        List<User> ComparingUserEmails = [Select Id,Email,Username From User Where UserName =:Email];
        System.debug('========AAAAAAAAAAAAAAAAAAAAAA ========='+Email );
        if(ComparingUserEmails.size()>0){
            List<User_Profile_Event__c> FindingDuplicates = new List<User_Profile_Event__c> ([select User_id__r.Profile.Name,User_id__r.Email,User_id__r.UserName 
                                                             From User_Profile_Event__c where User_Profile_Event__c.User_id__r.UserName=:Email 
                                                             AND  EV_id__c=:selectEvent]);
                                                             
             System.debug('========AAAAAAAAAAAAAAAAAAAAAA ========='+FindingDuplicates); 
            if(FindingDuplicates.size()>0 && FindingDuplicates[0].User_id__r.Profile.Name == 'Booth Admin'){  
                  system.debug('======== Error User already Exist ==========='  );
                  Error = True;
                  ErrorMessage = 'Email Already exist';
                  system.debug(' second Error ***************');
                  
                //   Con = new Contact();
               //    A  = new Account();
            } else {
            
               
                ForU = new User();
                ForU = [select FirstName,LastName,id,isActive,isSignUp__c from User where Username =:Email ];
                
                ForU.FirstName = BoothAdminUser.FirstName;
                ForU.LastName  = BoothAdminUser.LastName;
                ForU.companyName = BoothName.BT_Name__c;
                ForU.Company_website__c = BoothAdminUser.Company_website__c;
                ForU.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                ForU.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                ForU.CompanyCity__c = BoothAdminUser.CompanyCity__c;
               // if(SelectedCountry != '--None--')
                ForU.Country__c = BoothAdminUser.Country__c;
                //if(Selectedstates != '--None--')
                ForU.States__c =  BoothAdminUser.States__c;
                ForU.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                ForU.Companyphone__c = BoothAdminUser.Companyphone__c;
               // ForU.isActive  = False;
                
                Database.Update(ForU); 
                
                FutureMethod(Email);
                forattendee();
                User_Profile_Event__c GettingPRID = [Select Id,BLP_id__c from User_Profile_Event__c 
                                                     Where Ev_Id__c=: SelectEvent AND User_Id__c =: UserInfo.getUserId() 
                                                     AND EventAdmin_Id__c =: UserInfo.getUserId()];   
               
                
               
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c(); 
                               
                 
                UserBoothAdminProfile.BLP_id__c = GettingPRID.BLP_id__c;
                UserBoothAdminProfile.BoothAdmin_id__c =ForU.id;
                UserBoothAdminProfile.BT_id__c  = selectedBooth;
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = UserInfo.getUserId();
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Status__c='Active';
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = ForU.id;
                UserBoothAdminProfile.isFirstBoothAdmin__c=true;
                system.debug(';;;;;;;;;;;;;;;;;;;;;;;;;;'+UserBoothAdminProfile.isFirstBoothAdmin__c);
                
                insert UserBoothAdminProfile;
              //No Reports are Added  
              
              // Attendee Should be added.
              
              // No Email Notification to be sent.
             // SendanEmail();
              
             
              
              system.debug('       AttendeeSummaryid         '+UserBoothAdminProfile.Attendee_Summary__c);
              CreatOnlyBoothAdminPopUp = False;
         HideBoothAdminBtn = True;
         ListOfInnerClass = new List<InnerClass>();
         ForPagination = new List<InnerCLass>(); 
     
        
      
      HideBoothAdminBtn = True;
      HideBoothBtn = False;
      BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                              BoothAdmin_id__r.LastLoginDate from User_Profile_Event__c 
                              where EventAdmin_Id__c=: UserInfo.getUserId() AND EV_id__c =:SelectEvent AND BT_ID__c =: SelectedBooth 
                              AND Profile_id__r.PR_Name__c ='BoothAdmin'];
                              
                        for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }      
        try{            
                          
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         conlst=true;
         hasLast = True;
         hasFirst = False;
         count=BoothAdminsList.size();
         hasPrevious =false;
         hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+BoothAdminsList[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
       
        } 
     
     }  Catch(Exception ex){
     
     }
     
    
    //  BoothsList();
      exportBoothadmins();
            }
           
        }else {
               
               InsertUser();
             //  SendanEmail();
              CreatOnlyBoothAdminPopUp = False;
         HideBoothAdminBtn = True;
         ListOfInnerClass = new List<InnerClass>();
         ForPagination = new List<InnerCLass>(); 
     
        
      
      HideBoothAdminBtn = True;
      HideBoothBtn = False;
      BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                              BoothAdmin_id__r.LastLoginDate from User_Profile_Event__c 
                              where EventAdmin_Id__c=: UserInfo.getUserId() AND EV_id__c =:SelectEvent AND BT_ID__c =: SelectedBooth 
                              AND Profile_id__r.PR_Name__c ='BoothAdmin'];
                              
                        for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }      
        try{            
                          
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         conlst=true;
         hasLast = True;
         hasFirst = False;
         count=BoothAdminsList.size();
         hasPrevious =false;
         hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+BoothAdminsList[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
       
        } 
     
     }  Catch(Exception ex){
     
     }
     
    
    //  BoothsList();
      exportBoothadmins();
        }
         
    // 
      
       
     
     }
   }      
              
    else {  
            
            
           
        system.debug( ' FFFFFFFFFFFFFFFFFFFFFFFFFFF ' +Booth );
        system.debug('-------------- ********************8 ------------------'+SelectedBooth);
                  
                List<User> ComparingUserEmailsev = [Select Id,Email,Username From User Where UserName =: Email AND 
                                                    Profile.Name=:'Event Admin' ];
                if(ComparingUserEmailsev.size() != 0){
                error=true;
                errormessage='Email Already Exist';
               system.debug( ' EEEEEEEEEEEEEEEE RRRRRRRRRRRRRR OOOOOO RRRRRRRRR' );
               }else {
                   List<User> ComparingUserEmails = [Select Id,Email,Username From User Where UserName =: Email ];
               
               System.debug('========@@@@@@ Comparing Email with Existing Email From User Object @@@@@ ========='+ComparingUserEmails);
                   
               if(ComparingUserEmails.size()>0){
               
               List<User_Profile_Event__c> FindingDuplicates = [select User_id__r.Email,User_id__r.UserName,User_id__r.Profile.Name 
                                                                From User_Profile_Event__c where User_Profile_Event__c.User_id__r.UserName=:Email 
                                                                AND  EV_id__c=:selectEvent ];
                                                                
             //  System.debug('========@@@@@@ Comparing Email with Existing Email From User_Profile_Event Object @@@@@ ========='+FindingDuplicates.size()+ 'ddddd'+FindingDuplicates[0].User_id__r.Profile.Name);
               
               if(FindingDuplicates.size()>0 && FindingDuplicates[0].User_id__r.Profile.Name == 'Booth Admin'){
               //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Booth Admin is Already an Admin for this Booth'));
                 error=true;
                 errormessage='Email ID is already registered as Booth Admin for this Event';
                 system.debug( ' EEEEEEEEEEEEEEEE RRRRRRRRRRRRRR OOOOOO RRRRRRRRR' );
                 
               }
               
               else{
                Booth.BT_Location__c         =  Booth.BT_Location__c;
                Booth.Table_Room_No__c       =  Booth.Table_Room_No__c;
                Booth.BT_Name__c             =  BoothAdminUser.companyName;
                Booth.EV_id__c               =  SelectEvent;
                Booth.BT_ContactName__c      =  BoothAdminUser.Firstname +' '+ BoothAdminUser.LastName;
                Booth.BT_ContactPhone__c     =  BoothAdminUser.Companyphone__c;
                Booth.BT_WebsiteURL__c       =  BoothAdminUser.Company_website__c;
                Booth.BT_ContactEmail__c     =  Email;    
            
                Database.insert(Booth,false); 
                system.debug(' * **** ******* ************'+Booth);      
               Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c where PR_Name__c='BoothAdmin'];
                
                ForU = new User();
                
                ForU = [select FirstName,LastName,id,isActive,isSignup__c from User where Username =:Email ];
                
                ForU.FirstName = BoothAdminUser.FirstName;
                ForU.LastName  = BoothAdminUser.LastName;
                ForU.companyName = BoothAdminUser.companyName;
                ForU.Company_website__c = BoothAdminUser.Company_website__c;
                ForU.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                ForU.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                ForU.CompanyCity__c = BoothAdminUser.CompanyCity__c;
               // if(SelectedCountry != '--None--')
                ForU.Country__c = BoothAdminUser.Country__c;
                //if(Selectedstates != '--None--')
                ForU.States__c =  BoothAdminUser.States__c;
                ForU.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                ForU.Companyphone__c = BoothAdminUser.Companyphone__c;
                Database.Update(ForU);  
                
                FutureMethod(Email);
                forAttendee();
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                UserBoothAdminProfile.BoothAdmin_id__c = ForU.id;
                UserBoothAdminProfile.BT_id__c  = Booth.id;
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = UserInfo.getUserId();
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = ForU.id;
                UserBoothAdminProfile.Status__c='Active';
                Database.insert(UserBoothAdminProfile) ;
                
               // SendanEmail();
                
              
                CreatBoothAdminPopUp = False;
                CreatOnlyBoothAdminPopUp = False;
                ListOfBoothAdmins();
                BoothsList();
                Email = '';   
                
               } 
               
               }else {
                Booth.BT_Location__c         =  Booth.BT_Location__c;
                Booth.Table_Room_No__c       =  Booth.Table_Room_No__c;
                
                
                Booth.BT_Name__c             =  BoothAdminUser.companyName;
                Booth.EV_id__c               =  SelectEvent;
                Booth.BT_ContactName__c      =  BoothAdminUser.Firstname +' '+ BoothAdminUser.LastName;
                Booth.BT_ContactPhone__c     =  BoothAdminUser.Companyphone__c;
                Booth.BT_WebsiteURL__c       =  BoothAdminUser.Company_website__c;
                Booth.BT_ContactEmail__c     =  Email;    
                
                Database.insert(Booth);
                InsertUser();
              //  SendanEmail();
                CreatBoothAdminPopUp = False;
                CreatOnlyBoothAdminPopUp = False;
                ListOfBoothAdmins();
                BoothsList();
                Email = '';   
                
                } 
                                          
            }
           
        }
          
  }  
     
    
     public  AttendeeSummary__c AttendeeSummary{get;set;}
     public void forattendee(){
    system.debug('++++++++++++++++++++++++++++++'+BoothAdminUser.Firstname);
    string unique =  Email.tolowercase();
    AttendeeSummary = new AttendeeSummary__c();// Added by shruthi as there was an error saying "Attempt to dereference a null object" at line 1030
            system.debug('++++++++++++++++++++++++++++++'+unique );     
                List<AttendeeSummary__c> AttendeeDetails = [select  id  from AttendeeSummary__c Where 
                                                            AS_Email__c =: unique ];
                
                
                
                
                system.debug(' ===== Alredy Existed Attendee Email Id ===='+AttendeeDetails);
                
                if(AttendeeDetails.size() > 0){
                
              
                 AttendeeSummary__c UpdatingAttendee = new AttendeeSummary__c();
                 UpdatingAttendee  = [select id,AS_FirstName__c,AS_LastName__c from AttendeeSummary__c where id=:AttendeeDetails[0].id];
                 AttendeeSummary.id = UpdatingAttendee.id;
                
            
            
                system.debug('       attid1111111         '+AttendeeSummary.id);
                UpdatingAttendee.AS_FirstName__c = BoothAdminUser.FirstName; 
                UpdatingAttendee.AS_LastName__c = BoothAdminUser.LastName;
                UpdatingAttendee.AS_Company__c  = BoothAdminUser.CompanyName;
                UpdatingAttendee.AS_CellPhone__c  = BoothAdminUser.Companyphone__c;
                UpdatingAttendee.AS_uniqueField__c=(BoothAdminUser.FirstName+BoothAdminUser.LastName+Email).tolowercase();

                DataBase.Update(UpdatingAttendee);
                
                List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c =: Email AND EV_id__c =: SelectEvent];
                system.debug('========================= Attendee is inserted in Junction Object Or not ==========='+EventAttendeeJun );
                
                if(EventAttendeeJun.size()>0){}
                else{
                
                    Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                    InsertinginJun.AS_id__c = AttendeeDetails[0].id;
                    InsertinginJun.EV_id__c = selectEvent;
                    InsertinginJun.Boothleads_Profile__c = 'Booth Admin';
                   
                   // InsertinginJun.Attendee_Event_IDs__c  = AttendeeDetails[0].Name + EventAttendeeJun[0].EV_id__r.Name;
                    insert InsertinginJun; 
                     InsertinginJun.EA_AttendeeBarcode__c=InsertinginJun.id+'-'+SelectEvent;
                     InsertinginJun.Attendee_Event_IDs__c=AttendeeDetails[0].id+SelectEvent;
                       update InsertinginJun;
                   }
                 
            }else {
                      AttendeeSummary = new AttendeeSummary__c();
                       AttendeeSummary.AS_Email__c = Email;
                       AttendeeSummary.AS_FirstName__c = BoothAdminUser.FirstName;
                       AttendeeSummary.AS_LastName__c = BoothAdminUser.LastName;
                       AttendeeSummary.AS_Company__c  = BoothAdminUser.CompanyName;
                       AttendeeSummary.AS_CellPhone__c  = BoothAdminUser.Companyphone__c;
                       //AttendeeSummary.AS_uniqueField__c=(BoothAdminUser.FirstName+BoothAdminUser.LastName+Email).tolowercase();
                       Database.insert(AttendeeSummary);
                   
                       Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                       InsertinginJun.AS_id__c = AttendeeSummary.id;
                       InsertinginJun.EV_id__c = SelectEvent;
                       InsertinginJun.Attendee_Event_IDs__c  = AttendeeSummary.Name;
                        InsertinginJun.Boothleads_Profile__c = 'Booth Admin';
                       Database.insert(InsertinginJun);  
                       
                        InsertinginJun.EA_AttendeeBarcode__c=InsertinginJun.id+'-'+SelectEvent;
                        InsertinginJun.Attendee_Event_IDs__c=AttendeeSummary.id+SelectEvent;
                        
                        Database.update (InsertinginJun);       
                       
        
            }
           
    } 
 
 
  
   Public void InsertUser(){
   
               Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin'];
               
               system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
              
                Profile sys=[Select Id,Name from Profile where Name = 'system Administrator'];
                User  SystemAdmin = [select createdby.id from user where profile.id =: sys.id Limit 1];
                system.debug('======:::::::: ddddddddddddddddddt ========::::::'+SystemAdmin );              
               
                Account aa = [select id from Account where name = 'Booth Leads' Limit 1];
                
                A= new Account();
                if(BoothAdminUser.companyName !=null)
                A.Name = BoothAdminUser.companyName;
               else
                A.Name = BoothName.BT_Name__c;                 
                 A.ownerid = SystemAdmin.createdby.id;      
               //  insert A;

               
                 Con.LastName = BoothAdminUser.LastName;
                 Con.FirstName = BoothAdminUser.FirstName;     
                // Con.AccountId = '001Z000000PIOCA';
                Con.AccountId = aa.id;
                 insert Con ;
               
               system.debug('=====::::::::: Inserting Contact :::::::======='+Con );
               
                             
               
                BoothAdminUser.ContactID = Con.id;
                BoothAdminUser.Username = Email;
                BoothAdminUser.Email = Email;
                BoothAdminUser.Firstname = BoothAdminUser.Firstname;
                BoothAdminUser.LastName = BoothAdminUser.LastName;
                BoothAdminUser.Alias ='BAdmin';
                BoothAdminUser.ProfileID =UserAsBA.Id;
                BoothAdminUser.LocaleSidKey ='en_US';
                BoothAdminUser.LanguageLocaleKey ='en_US';
                BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                BoothAdminUser.EmailEncodingKey='UTF-8';
               if(BoothAdminUser.companyName !=null)
                BoothAdminUser.companyName = BoothAdminUser.companyName;
               else
                BoothAdminUser.companyName = BoothName.BT_Name__c;
                BoothAdminUser.Company_website__c = BoothAdminUser.Company_website__c;
                BoothAdminUser.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                BoothAdminUser.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                BoothAdminUser.CompanyCity__c = BoothAdminUser.CompanyCity__c;                
                BoothAdminUser.Country__c = BoothAdminUser.Country__c;                
                BoothAdminUser.States__c = BoothAdminUser.States__c;
                BoothAdminUser.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                BoothAdminUser.Companyphone__c = BoothAdminUser.Companyphone__c;
                BoothAdminUser.Zipcode__c = BoothAdminUser.Zipcode__c;
                BoothAdminUser.PoBox__c = BoothAdminUser.PoBox__c;
                BoothAdminUser.IsActive = False;
               
                
               insert BoothAdminUser;
               
                 forattendee();    
                 
                Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c 
                where PR_Name__c='BoothAdmin'];
                
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                UserBoothAdminProfile.BoothAdmin_id__c = BoothAdminUser.id;
                if(selectedBooth != null){
                UserBoothAdminProfile.BT_id__c  = selectedBooth;
                }else {
                UserBoothAdminProfile.BT_id__c  = Booth.id;
                }
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = Userinfo.getUserId();
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = BoothAdminUser.Id;
                UserBoothAdminProfile.Status__c= 'Active';
                insert UserBoothAdminProfile;
                
               
                        
          
   
   }
   
   public void ClosePopUp(){
   
   system.debug( ' CCCCCCCCCCCCCCC LLLLLLLLLLLLL');
   
   CreatBoothAdminPopUp = False;
   ShowBoothAdminPopUp = False;
   EditBoothAdminPopUp = False;
   CreatOnlyBoothAdminPopUp = False;
   Statuspopup = False; 
   IsInactive = False;
   Isactive = True;
   }
    
     public void EditBoothAdmin(){
     
     
     
     DisplayBoothAdminDetails();
     
     if(selectedBooth != null){
     selectedBooth = OnlyBoothInfo.id;
     }
     
     ShowBoothAdminPopUp = False;
     EditBoothAdminPopUp = True; 
     system.debug(' BBBBBBBBBBBBB AAAAAAAAAAAAAAAAAAA MMMMMMMMMMMMMM '+BoothAdminDetails+' BBBBBBBBBBB '+selectedBooth);
      
     }
     
     public void UpdateUser(){
     try{
     User_Profile_Event__c ParticularJuncID = [select isFirstBoothAdmin__c  from User_Profile_Event__c where id =: BoothAdminDetails];
    system.debug('=================================='+ParticularJuncID.isFirstBoothAdmin__c);
     system.debug('------------Admin.Email------------------'+BoothAdmininfo.Email );
   
    AttendeeSummary__c AttendeeEdit = [select AS_FirstName__c,AS_LastName__c,id from AttendeeSummary__c  where AS_Email__c =: BoothAdmininfo.Email];
    system.debug('------------------------------'+AttendeeEdit );
    
    AttendeeEdit.AS_FirstName__c = BoothAdmininfo.FirstName;
    AttendeeEdit.AS_LastName__c = BoothAdmininfo.LastName;

    Database.Update(AttendeeEdit);
     
     BoothAdmininfo.FirstName = AttendeeEdit.AS_FirstName__c;
     BoothAdmininfo.LastName = AttendeeEdit.AS_LastName__c;
     BoothAdmininfo.companyName = BoothAdmininfo.companyName ;
     BoothAdmininfo.Company_website__c = BoothAdmininfo.Company_website__c ;
     BoothAdmininfo.CompanyAddr1__c = BoothAdmininfo.CompanyAddr1__c ;
     BoothAdmininfo.CompanyAddr2__c = BoothAdmininfo.CompanyAddr2__c ;
     BoothAdmininfo.CompanyCity__c = BoothAdmininfo.CompanyCity__c ;
     BoothAdmininfo.Country__c = BoothAdmininfo.Country__c ;
     BoothAdmininfo.States__c = BoothAdmininfo.States__c ;
     BoothAdmininfo.CompanyFaxNumber__c  = BoothAdmininfo.CompanyFaxNumber__c  ;
     BoothAdmininfo.Companyphone__c = BoothAdmininfo.Companyphone__c ;
     BoothAdmininfo.Zipcode__c = BoothAdmininfo.Zipcode__c ;
     BoothAdmininfo.PoBox__c = BoothAdmininfo.PoBox__c ;
    
     
     Database.Update (BoothAdmininfo);
     
     OnlyBoothInfo.BT_Name__c = BoothAdmininfo.companyName;
     OnlyBoothInfo.BT_Location__c = OnlyBoothInfo.BT_Location__c;
     OnlyBoothInfo.BT_ContactName__c = AttendeeEdit.AS_FirstName__c +' '+AttendeeEdit.AS_LastName__c;
     OnlyBoothInfo.BT_WebsiteURL__c = BoothAdmininfo.Company_website__c ;
     OnlyBoothInfo.BT_Phone__c = BoothAdmininfo.Companyphone__c ;
     
     Database.Update(OnlyBoothInfo);
     
     EditBoothAdminPopUp = False;
   
     ListOfInnerClass = new List<InnerClass>();
     ForPagination = new List<InnerCLass>(); 
     system.debug('^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^'+SelectedBooth );
        if(SelectedBooth == null){
        
         HideBoothAdminBtn = False; 
         HideBoothBtn = True;
        
        
        BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate
                              from User_Profile_Event__c where EventAdmin_Id__c=: UserInfo.getUserId() 
                              AND EV_id__c =:SelectEvent AND Profile_id__r.PR_Name__c ='BoothAdmin'
                             ];
                             
                             for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }
                        
                           
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         system.debug( ' ---------------------------- @@@@@@@@@@@@@@@@@@ '+HideTable);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=ListOfInnerClass.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ListOfInnerClass[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
     
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
        }                          
     
    }else {
      
      HideBoothAdminBtn = True;
      HideBoothBtn = False;
      BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                              BoothAdmin_id__r.LastLoginDate from User_Profile_Event__c 
                              where EventAdmin_Id__c=: UserInfo.getUserId() AND EV_id__c =:SelectEvent AND BT_ID__c =: SelectedBooth 
                              AND Profile_id__r.PR_Name__c ='BoothAdmin'];
                              
                        for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }      
                    
                          
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         conlst=true;
         hasLast = True;
         hasFirst = False;
         count=BoothAdminsList.size();
         hasPrevious =false;
         hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+BoothAdminsList[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
       
        } 
     
     }
     
    
      
       }Catch(Exception ex){
      BoothsList();
      exportBoothadmins();
     }
     }
     
    public User_Profile_Event__c ParticularJuncID{get;set;} 
     
    public void DisplayBoothAdminDetails(){
           
           StatesCountry();

            system.debug( ' BBBBBBBBBBB AAAAAAAAAAAAA '+BoothAdminDetails);
            
            ShowBoothAdminPopUp = True;
           
            
            ParticularJuncID = [select EV_ID__c,BT_id__c,User_Id__c,UEP_isActive__c,Status__c from 
                                User_Profile_Event__c where id =: BoothAdminDetails];
            
            system.debug('==******************=====::::'+ParticularJuncID);
            
            BoothAdmininfo = [Select Id,FirstName,LastName,UserName,CompanyName,Email,Company_website__c,CompanyAddr1__c,
                              CompanyAddr2__c,CompanyCity__c,CompanyCountry__c,CompanyState__c,CompanyFaxNumber__c,
                              Companyphone__c,Zipcode__c,PoBox__c,Country__c,States__c from User where Id =:ParticularJuncID.User_Id__c];
            
                            system.debug('==&&&&&&&&&&&&&&&&&&=====::::'+BoothAdmininfo );
            
            OnlyBoothInfo = [Select Id,BT_BoothUserCount__c,BT_ContactEmail__c,BT_ContactName__c,BT_ContactPhone__c,BT_Description__c,BT_isBoothActive__c,
                             BT_Location__c,BT_Name__c,BT_PDFLocation__c,   BT_Phone__c,BT_RegistrationLink__c,Table_Room_No__c,
                             BT_WebsiteURL__c,MM_TableNo__c from  Booth__c where Id =:ParticularJuncID.BT_id__c];
                             
                             system.debug('============ Booth For Edit ======'+OnlyBoothInfo );   
            
            Country = countries.get(BoothAdmininfo.Country__c); 
            state = states.get(BoothAdmininfo.states__c);           
            
    }    


    Public List<selectOption> getStatuslist(){
       
        List<selectoption> Options = new List<selectoption>();
        options.add(new selectoption('Active','Active'));
        options.add(new selectoption('InActive','InActive'));
        return options;
    }   
    
    public void ChangeStatus(){
        DisplayBoothAdminDetails(); 
        if(selectedBooth != null){
     selectedBooth = OnlyBoothInfo.id;
     }
        if(ParticularJuncID.UEP_isActive__c == True ){
            SelectedStatus = 'Active';        
        }else{
            SelectedStatus = 'InActive';
        } 

        ShowBoothAdminPopUp = False;        
        StatusPopUp = True;          
    
    }
    
    public void SaveStatus(){
    try{
        system.debug( '------------------ AAAAAAAAA SSSSSSSSSSSSSS'+Selectedstatus); 
        if(SelectedStatus == 'Active'){
        system.debug('------------------ BBBBBBBBBBBB SSSSSSSSSSSSSS'+Selectedstatus);
        ParticularJuncID.Status__c = 'Active'; 
        ParticularJuncID.UEP_isActive__c = True;
        }else {
        system.debug('------------------ CCCCCCCCC SSSSSSSSSSSSSS'+Selectedstatus);
        ParticularJuncID.Status__c = 'Inactive'; 
        ParticularJuncID.UEP_isActive__c = False;
         }
        Database.Update(ParticularJuncID);
         
        system.debug( ' ------------ SSSSSSSSS SSSSSSSSSSSS FFFFFFFFFF'+selectedBooth+ ' VVVVVVVVVVV'+SelectEvent ); 
         
        
         
         StatusPopUp = False; 
         
           ListOfInnerClass = new List<InnerClass>();
     ForPagination = new List<InnerCLass>(); 
     
        if(SelectedBooth == null){
        
         HideBoothAdminBtn = False; 
         HideBoothBtn = True;
        
        
        BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate
                              from User_Profile_Event__c where EventAdmin_Id__c=: UserInfo.getUserId() 
                              AND EV_id__c =:SelectEvent AND Profile_id__r.PR_Name__c ='BoothAdmin'
                             ];
                             
                             for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }
                        
                           
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         system.debug( ' ---------------------------- @@@@@@@@@@@@@@@@@@ '+HideTable);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=ListOfInnerClass.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ListOfInnerClass[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
     
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
        }                          
     
    }else {
      
      HideBoothAdminBtn = True;
      HideBoothBtn = False;
      BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                              BoothAdmin_id__r.LastLoginDate from User_Profile_Event__c 
                              where EventAdmin_Id__c=: UserInfo.getUserId() AND EV_id__c =:SelectEvent AND BT_ID__c =: SelectedBooth 
                              AND Profile_id__r.PR_Name__c ='BoothAdmin'];
                              
                        for(User_Profile_Event__c V : BoothAdminsList ){
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }      
                    
                          
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         conlst=true;
         hasLast = True;
         hasFirst = False;
         count=BoothAdminsList.size();
         hasPrevious =false;
         hasNext=true;
         pageno=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+BoothAdminsList[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
       
        } 
     
     }
     
     
      BoothsList();
      exportBoothadmins(); 
      }Catch(Exception ex){
     
     }       
    }
    
    public void StatesCountry(){
    
        states=new map<string,string>();
        states.put('None','None');
        states.put('Alabama','AL');
        states.put('Alaska', 'AK');
        states.put('Arizona','AZ');
        states.put('Arkansas','AR');
        states.put('California','CA');
        states.put('Colorado','CO');
        states.put('Connecticut','CT');
        states.put('Delaware','DE');
        states.put('District of Columbia','DC');
        states.put('Florida','FL');
        states.put('Georgia','GA');
        states.put('Hawaii','HI');
        states.put('Idaho','ID');
        states.put('Illinois','IL');
        states.put('Indiana','IN');
        states.put('Iowa','IA');
        states.put('Kansas','KS');
        states.put('Kentucky','KY');
        states.put('Louisiana','LA');
        states.put('Maine','ME');
        states.put('Maryland','MD');
        states.put('Massachusetts','MA');
        states.put('Michigan','MI');
        states.put('Minnesota','MN');
        states.put('Mississippi','MS');
        states.put('Missouri','MO');
        states.put('Montana','MT');
        states.put('Nebraska','NE');
        states.put('Nevada','NV');
        states.put('New Hampshire','NH');
        states.put('New Jersey','NJ');
        states.put('New Mexico','NM');
        states.put('New York','NY');
        states.put('North Carolina','NC');
        states.put('North Dakota','ND');
        states.put('Ohio','OH');
        states.put('Oklahoma','OK');
        states.put('Oregon','OR');
        states.put('Pennsylvania','PA');
        states.put('Rhode Island','RI');
        states.put('South Carolina','SC');
        states.put('South Dakota','SD');
        states.put('Tennessee','TN');
        states.put('Texas','TX');
        states.put('Utah','UT');
        states.put('Vermont','VT');
        states.put('Virginia','VA');
        states.put('Washington','WA');
        states.put('West Virginia','WV');
        states.put('Wisconsin','WI');
        states.put('Wyoming','WY');                     
        states.put('Andhra Pradesh','Andhra Pradesh');
        states.put('Arunachal Pradesh','Arunachal Pradesh');
        states.put('Assam','Assam');
        states.put('Bihar','Bihar');
        states.put('Chhattisgarh','Chhattisgarh');
        states.put('Goa','Goa');
        states.put('Gujarat','Gujarat');
        states.put('Haryana','Haryana');
        states.put('Himachal Pradesh','Himachal Pradesh');
        states.put('Jammu and Kashmir','Jammu and Kashmir');
        states.put('Jharkhand','Jharkhand');
        states.put('Karnataka','Karnataka');
        states.put('Kerala','Kerala');
        states.put('Madhya Pradesh','Madhya Pradesh');
        states.put('Maharashtra','Maharashtra');
        states.put('Manipur','Manipur');
        states.put('Meghalaya','Meghalaya');
        states.put('Mizoram','Mizoram');
        states.put('Nagaland','Nagaland');
        states.put('Orissa','Orissa');
        states.put('Punjab','Punjab');
        states.put('Rajasthan','Rajasthan');
        states.put('Sikkim','Sikkim');
        states.put('Tamil Nadu','Tamil Nadu');
        states.put('Tripura','Tripura');
        states.put('Uttar Pradesh','Uttar Pradesh');
        states.put('Uttarakhand','Uttarakhand');
        states.put('West Bengal','West Bengal');
        states.put('Andaman and Nicobar Islands','Andaman and Nicobar Islands');
        states.put('Daman and Diu','Daman and Diu');
        states.put('Lakshadweep','Lakshadweep');
        states.put('National Capital Territory of Delhi','National Capital Territory of Delhi');                                     
    
         countries = new map<string,string>();
         countries.put('India','India');
         countries.put('United States of America','USA');
    
    }
   //For email Template
  
  
    
    public class InnerClass{
    public User_Profile_Event__c UPE{get;set;}
    public String BStatus{get;set;}
        public InnerClass(User_Profile_Event__c ConUPE,String ConBStatus){
            UPE = ConUPE;
            BStatus = ConBStatus;    
        }
    
    }
    public PageReference login() {
       
       if(userInfo.getUserType()=='guest'){
            Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
            pg.setredirect(true);
            return pg;
       } else{
            return null;
       }     
    }
    
     @Future
    public static Void FutureMethod(String UserId){
    User ForU = new User();
                ForU = [select FirstName,Profileid,LastName,id,isActive,isSignUp__c from User where Username =:UserId];
                Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin'];
                
                ForU.ProfileId = UserAsBA.Id;
                if(ForU.isSignUp__c == True)
                ForU.isActive  = True;
                else
                ForU.isActive  = False;
                
                DataBase.Update(ForU); 
    
    
    }    
    
    // Added by Shruthi to populate selected Event in the before Tab on November 18th
        
    public void URLEvent(){  
      
    id = apexpages.currentpage().getparameters().get('id');     
   
    if(id != null && id != ''){ 
  
    selectEvent = id;
   } 
 }
    
}
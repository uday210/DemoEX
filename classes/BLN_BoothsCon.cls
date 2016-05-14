/***********************************************************************************************
*   Controller Name : BLN_BoothsCon
*   Date            : 14/5/2015
*   Author          : Deepthi Kollu
*   Purpose         : This class is to display and edit Booth Details
*   Change History  : 14/5/2015
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  14/5/2015            Deepthi Kollu                  To Create Page
*  
**************************************************************************************************/

global class BLN_BoothsCon {
global String mybbol{get;set;}
public String getMybbol(){
return mybbol;
}
    public ApexPages.StandardSetController setCon {get;set;}
    public List<Booth_Map__c> RecList{get;set;}
    public list<BLN_Sponsorships__c> RecListsp{get;set;}
    public BLN_UtillDisplayLinks Booths { get; set; }
    Public string selectedeventid{get;set;}
    public LIST<Booth_Map__c> BoothMapList{get;set;}
     public LIST<Booth_Map__c> BoothMapListprint{get;set;}
     public List<List<Booth_Map__c>> BoothMapListoflist{get;set;}
    public String  selectedBoothSize{get;set;}
    public LIST<SelectOption> BoothInformation{get; set;}
    public string boothsizelist{get; set;}
    public LIST<string> boothsizeDuplicatelist{get; set;}
    public boolean showTextFlag{get; set;}
    public BLN_Booth_Map_DAO bmDAO{get; set;}
    public string bnolist{get;set;}
    public boolean editpopup{get;set;}
    public boolean editsppopup{get;set;}
    public string jsonDataExhibitors {get;set;}
     public string jsonDataSponsors{get;set;}
    public LIST<SelectOption> bsizelist{get;set;}
    public transient String AttName {get;set;}
     public transient String AttNamespon {get;set;}
  public transient String AttData {get;set;}
  public transient String AttDataspon {get;set;}
  public transient String iframelink{get;set;}
    public transient String iframelinkspon{get;set;}
 public transient String imageData {get;set;}
    public LIST<SelectOption> filterTypes{get; set;}
    public String selectedFilterType{get; set;}
    public LIST<SelectOption> filterTypes1{get; set;}
    public String selectedFilterType1{get; set;}
    
    public string boothid{get;set;}
    public BLN_BoothsCon(){
   
        newbsz = '';
        newroomval = '';
        sponscatlst='';
      // editPopUp = false;
        editsppopup = false;
        isMove =false;
         Cookie k = ApexPages.currentPage().getCookies().get('counter');
             if(k!=null){
             selectedeventid = k.getValue();
             }
       // selectedeventid ='a1918000000TuCG';
        //eventslist= new BLN_Event__c();
        showTextFlag = false;
       
       // ExhibitorsprocessData();

        //Booth size picklist values
        
        filterTypes= new LIST<SelectOption>();
        filterTypes.add(new SelectOption('Visibility','Visibility'));
        filterTypes.add(new SelectOption('Public','Public'));
        filterTypes.add(new SelectOption('Private','Private'));
        selectedFilterType= 'Visibility';

        filterTypes1= new LIST<SelectOption>();
        filterTypes1.add(new SelectOption('Visibility','Visibility'));
        filterTypes1.add(new SelectOption('Public','Public'));
        filterTypes1.add(new SelectOption('Private','Private'));
        selectedFilterType1= 'Visibility';
  
       mainMethod();
    }
    
    public LIST<BLN_Sponsorships__c> sponsorticlist{get;set;}
    public string sponscatlst{get;set;}
    public void mainMethod(){
         
        BLN_Booth_Map_DAO bmDAO1= new BLN_Booth_Map_DAO();
        LIST<BLN_Sponsorships__c> sponsorticlist1 = new LIST<BLN_Sponsorships__c>();
        sponsorticlist1 = bmDAO1.sponsorshiplist(selectedeventid);
        
        sponsorticlist = new LIST<BLN_Sponsorships__c>();

        sponscatlst='';
        
        list<string> catgrySet=new list<string>();
        
        for(BLN_Sponsorships__c s:sponsorticlist1){
            boolean existFlag= false;
            
            if(s.Sponsorship_Category__c != '' && s.Sponsorship_Category__c != null){
               for(integer i=0;i<catgrySet.size();i++)
               {
                  if(catgrySet[i]==s.Sponsorship_Category__c)
                  {
                  existFlag=true;
                  }
               }
                   
    
                if(existFlag==false){
                    sponscatlst=sponscatlst+s.Sponsorship_Category__c+',';
                    catgrySet.add(s.Sponsorship_Category__c);
                }
                
                system.debug('existFlag'+existFlag);
            }
            if(selectedFilterType1 =='Visibility'){
                sponsorticlist.add(s);
            }else{
                if(s.visibility__c == selectedFilterType1){
                    sponsorticlist.add(s);
                }
            }
        }
        
    }
    
    
   //method to save new booth sizez
    public PageReference update_newboothsize() {
       string new_bsize12 = Apexpages.currentPage().getParameters().get('nw_bsizetxtval');
       string tID11 = Apexpages.currentPage().getParameters().get('row_tid4');
       
       Booth_Map__c bm = [SELECT Name,Booth_Size__c FROM Booth_Map__c WHERE id = :tID11];
       bm.Booth_Size__c = new_bsize12;
       update bm; 
       pagereference pg=new pagereference('/apex/BLN_booths');
       pg.setRedirect(true);
       return pg;
    }
    
    //method to update multiple booth areas
    public PageReference update_boothareas() {
        string newbooth1 = Apexpages.currentPage().getParameters().get('newbooth');
       string ticketid11 = Apexpages.currentPage().getParameters().get('ticketlist1');
       system.debug('newbooth1:'+newbooth1+'       ticketid1:'+ticketid11);       
       
       try{
       List<String> parts1 =ticketid11.split(',');  
           LIST<Booth_Map__c> bm5 = [SELECT Name,Booth_Area__c FROM Booth_Map__c WHERE id = :parts1];
           for(Booth_Map__c b:bm5){
           b.Booth_Area__c = newbooth1;
           }
           update bm5;
        }catch(exception e){}
        return null;
    }

    //method to update multiple booth rooms and insert if new room
    public PageReference update_boothRooms() {
        
       string new_bRoom2 = Apexpages.currentPage().getParameters().get('newroom');
       string tID1 = Apexpages.currentPage().getParameters().get('ticketlist');
       system.debug('new_bRoom2:'+new_bRoom2+'       tID1:'+tID1);
       try{
       List<String> parts =tID1.split(',');     

           LIST<Booth_Map__c> bm4 = new LIST<Booth_Map__c>();
           bm4 = [SELECT Name,BLN_Room__r.Name FROM Booth_Map__c WHERE id = :parts];
           Integer c = [SELECT count() FROM BLN_Room__c WHERE NAME = :new_bRoom2];
               system.debug('count is:'+c);
               if(c<=0){   
                    BLN_Room__c[] rm= new BLN_Room__c[1];
                    rm[0] = new BLN_Room__c(Name=new_bRoom2);
                    insert rm;
               }
       BLN_Room__c br =[SELECT ID FROM BLN_Room__c WHERE NAME = :new_bRoom2 LIMIT 1];
       for(Booth_Map__c b:bm4){
       b.BLN_Room__C = br.ID;
       }
       update bm4;
       }catch(exception e){}
       return null;
    }

    //method to update booth room and insert if new room
    public PageReference update_boothRoom() {
       string new_bRoom1 = Apexpages.currentPage().getParameters().get('new_bRoom');
       string tID1 = Apexpages.currentPage().getParameters().get('row_tid3');
       system.debug('new_bRoom1:'+new_bRoom1+'       tID1:'+tID1);       
       Booth_Map__c bm3 = [SELECT Name,BLN_Room__r.Name FROM Booth_Map__c WHERE id = :tID1 ];
       LIST<BLN_Room__c> br1 =new LIST<BLN_Room__c>();
       BLN_Room__c br =new BLN_Room__c();
       try{
       br1=[SELECT Name FROM BLN_Room__c WHERE NAME = :new_bRoom1];
           
           if(br1.size()==0){      
                br1.add(new BLN_Room__c(Name = new_bRoom1));
                insert br1;

           }
       br =[SELECT ID FROM BLN_Room__c WHERE NAME = :new_bRoom1];
       }catch(exception e){}
       if(new_bRoom1!='' ||new_bRoom1!=null){
       bm3.BLN_Room__C = br.ID;
       }else{
       bm3.BLN_Room__C ='';
       }
       update bm3;
       
       return null;
    }

    //method to update booth area
    public PageReference update_boothArea() {
       string new_bArea1 = Apexpages.currentPage().getParameters().get('new_bArea');
       string tID1 = Apexpages.currentPage().getParameters().get('row_tid2');
       system.debug('new_bArea1:'+new_bArea1+'       tID1:'+tID1);       
       Booth_Map__c bm2 = [SELECT Name,Booth_Area__c FROM Booth_Map__c WHERE id = :tID1 ];
       bm2.Booth_Area__c = new_bArea1;
       update bm2;
        return null;
    }

    //method to update booth no
    public PageReference update_boothNo() {
    
       string new_bNo1 = Apexpages.currentPage().getParameters().get('new_bNo');
       string tID1 = Apexpages.currentPage().getParameters().get('row_tid1');
       system.debug('new_bNo1:'+new_bNo1+'       tID1:'+tID1);       
       Booth_Map__c bm1 = [SELECT Name,Booth_Number__c FROM Booth_Map__c WHERE id = :tID1 ];
       bm1.Booth_Number__c = new_bNo1;
       update bm1;
       //return null;
       pagereference pg1=new pagereference('/apex/BLN_booths');
       pg1.setRedirect(true);
       return pg1;
    }

    //method to update booth size
    public PageReference update_boothsize() {
        
       string new_bsize1 = Apexpages.currentPage().getParameters().get('new_bsize');
       string tID1 = Apexpages.currentPage().getParameters().get('row_tid');
       system.debug('new_bsize1:'+new_bsize1+'       tID1:'+tID1);       
       Booth_Map__c bm = [SELECT Name,Booth_Size__c FROM Booth_Map__c WHERE id = :tID1 ];
       bm.Booth_Size__c = new_bsize1;
       update bm;
       pagereference pg1=new pagereference('/apex/BLN_booths');
       pg1.setRedirect(true);
       return pg1;
       return null;
    }

     //method to update sponsorship category
    public PageReference save_sponscat() {
       string new_sc= Apexpages.currentPage().getParameters().get('new_sc');
       string spid= Apexpages.currentPage().getParameters().get('spid');
       system.debug('new_sc:'+new_sc+'       spid:'+spid);       
       BLN_Sponsorships__c sp1 = new BLN_Sponsorships__c();     
       try{  
       sp1 = [SELECT logo_size__c FROM BLN_Sponsorships__c where Sponsorship_Category__c = :new_sc limit 1];
       }catch(exception ee){}
       
       BLN_Sponsorships__c sp = [SELECT Sponsorship_Category__c FROM BLN_Sponsorships__c WHERE id = :spid];
       sp.Sponsorship_Category__c = new_sc;
       if(null != sp1.logo_size__c)
       sp.logo_size__c = sp1.logo_size__c;
       
       else
       sp.logo_size__c ='Medium';
       update sp;
       pagereference pg1=new pagereference('/apex/BLN_booths');
       pg1.setRedirect(true);
       return null;
    }

   /*method to update Logo Size
    public PageReference updatesize() {
        
        return null;
    }*/
                
        
    
        public BLN_EventDetails eventInfo{get; set;}
        
        public PageReference printBooths() {
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
            eventInfo= new BLN_EventDetails();
            eventInfo.eventDetailsToDisplay(selectedeventid);
        string temp='';
         string s1='Booths /Tables';
          temp = ' WHERE Ticket_id__c !=null AND Name =\''+s1+'\''+' AND Ticket_id__r.Order__r.Name !=null AND Ticket_id__r.Order__r.Order_Status__c !=\'Cancelled\' AND Ticket_id__r.Order__r.Order_Status__c !=\'Abandoned\' AND Ticket_id__r.Order__r.Order_Status__c !=\'Not Paid\' AND Ticket_id__r.Ticket_Status__c = \''+'Booked'+'\''+' AND Ticket_id__r.Event__r.id =\''+selectedeventid+'\''; 
          bmDAO = new BLN_Booth_Map_DAO();
          BoothMapList = bmDAO.BoothDetails(temp);
           BoothMapListprint=new LIST<Booth_Map__c>();
      BoothMapListoflist=new List<List<Booth_Map__c>>();
            for(Booth_Map__c bpm:BoothMapList){
            
            BoothMapListprint.add(bpm);
            
            if(BoothMapListprint.size() == 999){
                BoothMapListoflist.add(BoothMapListprint);                
                BoothMapListprint=new LIST<Booth_Map__c>();
            }
            
            
            
            }
            if(BoothMapListprint.size() != 0){
            BoothMapListoflist.add(BoothMapListprint);
        }
            pageReference pg =  new pagereference('/apex/BLN_printBooths');
            return pg;
        }
        
      // -------------------------- This method is to Retrieve Event Details.--------------------------
      
     /* Public BLN_Event__c geteventdetails(){
         BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
         RETURN eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }*/
   
   public void displayPermissions(){

     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
      BLN_Event__c  eventslist = new BLN_Event__c  ();
      try{
        eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }catch(exception e){}
     
     /*try{
     eventslist  = geteventdetails();
     }catch(exception e){}*/

    SYSTEM.DEBUG(selectedeventid +'  EVENTID:  ' + eventslist);

         Booths = new BLN_UtillDisplayLinks();
         Booths.isBoothsPage='active';
         Booths.isTicketsPageExpand='expand';
         Booths.tablabel='Exhibitors/Sponsors';
         try{
         Booths.eventName = eventslist.Name;
         }catch(exception e){}
         Booths.EventId= selectedeventid;
         Booths.userPermissions(userInfo.getUserId(),selectedeventid);
    }

    public booth_map__c boothedit{get;set;}
   
    public document mydoc{get;set;}
    public String newroomval { get; set; }
    public String newbsz { get; set; }
    public transient List<Attachment> attlist{get;set;}
    public transient List<Attachment> attlistspon{get;set;}

public string exbPic{ get; set; }
public String exbImageName{get; set;}
public void editMethod() {
     editPopUp = true;
    
     String editID = apexpages.currentpage().getparameters().get('editID');//boothid
     //String editID = boothid;
      
     BLN_Booth_Map_DAO bmap=new BLN_Booth_Map_DAO();
     string condition=' Where id =\''+editID+'\'';
     
     LIST<booth_map__c> bootheditlist = bmap.BoothDetails(condition);
     boothedit=bootheditlist[0];
     system.debug('editPopUp======='+editPopUp);
      try{
    
     attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:bootheditlist[0].Ticket_id__r.Tkt_profile__r.id];
     }catch(Exception e){}
        //return null;
    }
    
    public Boolean IsUploadComLogo {get;set;}
     public PageReference SavePopup() {
   string ifmlk= Apexpages.CurrentPage().GetParameters().get('iframelinkexp');
   if(IsUploadComLogo){
         if (exbPic != NULL && exbPic != '' ) {

             mydoc = new document();
             mydoc.body = EncodingUtil.base64Decode(exbPic);
             mydoc.folderid = UserInfo.getUserId();
             mydoc.ispublic = true;
             mydoc.Name = exbImageName;
              DataBase.saveResult docSaveResult;
                                 docSaveResult = DataBase.insert(mydoc, false);
                                 
                                 if(docSaveResult.isSuccess()){
                                        boothedit.Ticket_id__r.tkt_profile__r.Company_Logo__c = mydoc.id;
                                 }
                         
            
             
          }
        else{
                                boothedit.Ticket_id__r.tkt_profile__r.Company_Logo__c = null;
                                } 
       } 
       try{
 if(AttData!=''){                       
         Attachment a = new Attachment(parentId = boothedit.Ticket_id__r.tkt_profile__r.id, name=AttName , body =EncodingUtil.base64Decode(AttData));
       
         insert a;
         

       } 
       }catch(exception er){
       system.debug('exception');
       }  
      
       boothedit.Ticket_id__r.tkt_profile__r.Video__c=ifmlk;
       LIST<BLN_Room__c> br1 =new LIST<BLN_Room__c>();
       BLN_Room__c br =new BLN_Room__c();

       if(newroomval != null && newroomval != ''){
       br1=[SELECT Name FROM BLN_Room__c WHERE NAME =:newroomval];
       
           
           if(br1.size()==0){      
            br1.add(new BLN_Room__c(Name = newroomval));
                insert br1;

             system.debug('bbb'+newroomval);
            
           }
       
       if(newroomval!='' && newroomval!=null){
       br =[SELECT ID FROM BLN_Room__c WHERE NAME = :newroomval LIMIT 1];
       boothedit.BLN_Room__c = br.ID;
       }
       }else{
       boothedit.BLN_Room__c =null;
       }

       
       if(newbsz != null && newbsz != ''){
       boothedit.Booth_Size__c = newbsz; 
       }
       system.debug('boothedit.Ticket_id__r.tkt_profile__r===='+boothedit.Ticket_id__r.tkt_profile__r);
        update boothedit.Ticket_id__r.tkt_profile__r; 
        update boothedit;

        editPopUp = false;
        //editsppopup = false;
        pagereference pg=new pagereference('/apex/BLN_booths');
       pg.setRedirect(true);
       return pg;
    }
    
     public PageReference closePopup() {
     editPopUp = false;
     editsppopup = false;
        return null;
    }

   

   public BLN_Sponsorships__c sponsorEdit{get;set;}
    public string spPic{ get; set; }
    public String spImageName{get; set;}
    public string oldLogoSize{get;set;}
    public PageReference editspMethod() {
        editsppopup = true;
        String editspID = apexpages.currentpage().getparameters().get('editspID');
        system.debug('vvvvvvv'+editspID);
        sponsorEdit = [select Visibility__c,Ticket_id__r.tkt_profile__r.Video__c,Logo_Size__c,Sponsorship_Category__c,Ticket_id__r.tkt_profile__r.TKT_Company__c,Ticket_id__r.tkt_profile__r.Company_Logo__c,Ticket_id__r.tkt_profile__r.Company_Description__c,Ticket_id__r.tkt_profile__r.FaceBookId__c,Ticket_id__r.tkt_profile__r.LinkedInId__c,Ticket_id__r.tkt_profile__r.TwitterId__c,Ticket_id__r.tkt_profile__r.Blogger__c,Ticket_id__r.tkt_profile__r.Blog_URL__c,Ticket_id__r.tkt_profile__r.Company_Website_URL__c from BLN_Sponsorships__c where id =:editspID];
        oldLogoSize = sponsorEdit.Logo_Size__c;
         try{
    
     attlistspon=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:sponsorEdit.Ticket_id__r.Tkt_profile__r.id];
     system.debug('attlistspon====='+attlistspon);
     }catch(Exception e){}
        return null;
    }
    
    
    public PageReference SavespPopup() {
    string sponlik=Apexpages.CurrentPage().GetParameters().get('iframelinksponst');
if(IsUploadComLogo){
       if (spPic != NULL && spPic  != '' ) {
             mydoc = new document();
             mydoc.body = EncodingUtil.base64Decode(spPic);
             mydoc.folderid = UserInfo.getUserId();
             mydoc.ispublic = true;
             mydoc.Name = spImageName;
             DataBase.saveResult docSaveResult;
                                 docSaveResult = DataBase.insert(mydoc, false);
                                 
                                 if(docSaveResult.isSuccess()){
                                        sponsorEdit.Ticket_id__r.tkt_profile__r.Company_Logo__c = mydoc.id;
                                 }
          }
          else{
          sponsorEdit.Ticket_id__r.tkt_profile__r.Company_Logo__c = null;
          }
       } 
        try{

 if(AttDataspon!=''){  
       Attachment aspon = new Attachment(parentId = sponsorEdit.Ticket_id__r.tkt_profile__r.id, name=AttNamespon , body =EncodingUtil.base64Decode(AttDataspon));
         
         insert aspon;
         }
        }catch(exception er){
       
      }  
       
       // sponsorEdit.Ticket_id__r.tkt_profile__r.Video__c=sponlik;
      
       
       update sponsorEdit.Ticket_id__r.tkt_profile__r;
       update sponsorEdit;
              
       if(oldLogoSize != sponsorEdit.Logo_Size__c){
         LIST<BLN_Sponsorships__c> sponsors= [select Logo_Size__c,Sponsorship_Category__c from BLN_Sponsorships__c where Sponsorship_Category__c  = :sponsorEdit.Sponsorship_Category__c];
         for(BLN_Sponsorships__c s: sponsors){
             s.Logo_Size__c = sponsorEdit.Logo_Size__c;
         }
          update sponsors;
       }
       
       editPopUp = false;
       editsppopup = false;
       pagereference pg=new pagereference('/apex/BLN_booths');
       pg.setRedirect(true);
       return pg;
    }
    
    public PageReference printSponsors() {

            BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
            eventInfo= new BLN_EventDetails();
            eventInfo.eventDetailsToDisplay(selectedeventid);
            
            pageReference pg =  new pagereference('/apex/BLN_printSponsors');
            return pg;
    }
    
    public Boolean isMove {get;set;}
    public String displayOrder{get;set;}{displayOrder='';}
    public void updateDisplayOrder() {
       isMove=true;
       displayOrder= Apexpages.Currentpage().getparameters().get('displayOrder');
       system.debug('displayOrder'+displayOrder);
       string[] splitted = displayOrder.split(' ');
       system.debug('splitted'+splitted);
       
       List<BLN_Sponsorships__c> SponsorshipList=new List<BLN_Sponsorships__c>();
        for(integer i=0;i<splitted.size();i++)
        {
             string[] ordersplit = splitted[i].split(',');
             System.debug('MY IDDDDD:'+ordersplit[0]);

             BLN_Sponsorships__c q=new BLN_Sponsorships__c(id=ordersplit[0],Display_Order__c=Integer.valueOf(ordersplit[1]));
             SponsorshipList.add(q);
             
        }
        system.debug('SponsorshipList====='+SponsorshipList);
        update SponsorshipList;
    }
    
    public void ExhibitorsprocessData(){
    system.debug('expppp');
   // editPopUp = false;
    string temp='';
    bmDAO = new BLN_Booth_Map_DAO();
    string s1='Booths /Tables';
     String searchKey = ApexPages.currentPage().getParameters().get('searchKey');
     String filterKey = ApexPages.currentPage().getParameters().get('filterKey');
     system.debug('searchKey====='+searchKey);
     string serch;
       //string selectedeventid='a1918000000TuCG';
    temp = ' WHERE Ticket_id__c !=null AND Name =\''+s1+'\''+' AND Ticket_id__r.Order__r.Name !=null AND Ticket_id__r.Order__r.Order_Status__c !=\'Cancelled\' AND Ticket_id__r.Order__r.Order_Status__c !=\'Abandoned\' AND Ticket_id__r.Order__r.Order_Status__c !=\'Not Paid\' AND Ticket_id__r.Ticket_Status__c = \''+'Booked'+'\''+' AND Ticket_id__r.Event__r.id =\''+selectedeventid+'\''; 
       
       
       if(searchKey != null && searchKey != ''){
       
       temp+= 'AND (Ticket_id__r.tkt_profile__r.TKT_Company__c=\''+searchKey+'\' OR Booth_Number__c =\''+searchKey+'\' OR Ticket_id__r.tkt_profile__r.TKT_Company__c=\''+searchKey+'\' OR Booth_Size__c=\''+searchKey+'\' OR Booth_Area__c=\''+searchKey+'\' OR BLN_Room__r.Name=\''+searchKey+'\' OR Ticket_id__r.Item_Pool__r.Item_Pool_Name__c=\''+searchKey+'\' OR Ticket_id__r.Item_Type__r.Name=\''+searchKey+'\' OR Ticket_id__r.Order__r.Name=\''+searchKey+'\' OR Ticket_id__r.tkt_profile__r.TKT_Company__c=\''+searchKey+'\')'; 
       }
       
       if(filterKey != 'Visibility'){
       temp+= ' AND visibility__c = \''+filterKey +'\'';
       }
       
       BoothMapList = bmDAO.BoothDetails(temp);
       
       // past codeeee
       boothsizelist='8\\\' x 8\\\',10\\\' x 10\\\','; 
        bsizelist= new LIST<SelectOption>();
        bsizelist.add(new SelectOption('8\' x 8\'','8\' x 8\''));
        bsizelist.add(new SelectOption('10\' x 10\'','10\' x 10\''));
       boothsizeDuplicatelist=new LIST<string>();
       bnolist='';
       system.debug('bnolist'+bsizelist);
       
       
        setcon=new ApexPages.StandardSetController(BoothMapList);
          
                    
           
            //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);
            setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon.setPageSize(size);
            
        
            //set pagenumber
            setCon.setPageNumber((start/size)+1);
            
            RecList = setCon.getRecords(); 
            
            
        
       List<SubWrapper> orderList1 = new List<SubWrapper>();
       
       // create a sub wrapper
      for(Booth_Map__c ac: RecList){
       Id val=ac.id;
       orderList1.add(new SubWrapper(ac, val));
       
       }
       // totalAttendees=RecList.size();
              System.debug('&&&&&&&&&&&&&&&'+orderList1.size());
      
            //create wrapper
            System.debug('Records of order------------------------------------------------------------------'+orderList1);
            DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,orderList1);
            
            jsonDataExhibitors = JSON.serialize(datawrap);
           
    }
    
    
     public void delattachment(){
     List<Attachment> attac = new List<Attachment>();
     attac = [select Id,Name From Attachment where id=: ApexPages.currentPage().getParameters().get('deletedId') ];
      SYSTEM.DEBUG(' ====================@@ '+attac );
     Database.DeleteResult[] DR_Dels = Database.delete(attac,True); 
   //get the attachements for clientgnuser
    attlist=new List<Attachment>();
    attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:boothedit.Ticket_id__r.tkt_profile__r.id];
    //
 }
      
 public void delattachmentsp(){
     List<Attachment> attacsp = new List<Attachment>();
     attacsp  = [select Id,Name From Attachment where id=: ApexPages.currentPage().getParameters().get('deletedIdsp') ];
      SYSTEM.DEBUG(' ====================@@ '+attacsp );
     Database.DeleteResult[] DR_Dels = Database.delete(attacsp,True); 
   //get the attachements for clientgnuser
    attlistspon=new List<Attachment>();
    attlistspon=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:sponsorEdit.Ticket_id__r.tkt_profile__r.id];
    system.debug('attlistcvvv===='+attlistspon.size());
    //
 }
    
public class SubWrapper{

  public Id DT_RowId{ get; set; }
  public Booth_Map__c item { get; set;}
 // public String createdon{get;set;}
  

  public SubWrapper(Booth_Map__c item, Id counter) {
    this.item = item;
    this.DT_RowId= counter;
    
   
  }  
  }
  
  public class DataTableWrapper
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<SubWrapper> data;
            //  public List<Contact> allids;
            public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<SubWrapper> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data = data;
              
            }
         
        } 
        
        
 @RemoteAction
  global static string dynamicboothsize(string evenid){
  
     LIST<string> boothsizeDuplicatelistboth;
 
  string boothsizelistbooth;
     
       
       LIST<SelectOption> bsizelistopt;

        boothsizelistbooth='8\' x 8\',10\' x 10\','; 
        bsizelistopt= new LIST<SelectOption>();
        bsizelistopt.add(new SelectOption('8\' x 8\'','8\' x 8\''));
        bsizelistopt.add(new SelectOption('10\' x 10\'','10\' x 10\''));
        boothsizeDuplicatelistboth=new LIST<string>();
        
        for(Booth_Map__c bmap: [SELECT ID,Booth_Size__c,Booth_Number__c FROM Booth_Map__c WHERE Booth_Size__c != '' AND Ticket_id__r.Event__r.id =:evenid order by Booth_Size__c]){
          
          boolean existFlag= false;
          boothsizeDuplicatelistboth.add('8\' x 8\'');
          boothsizeDuplicatelistboth.add('10\' x 10\'');
          for(integer i=0;i<boothsizeDuplicatelistboth.size();i++)
          {
              if(boothsizeDuplicatelistboth[i]==bmap.Booth_Size__c)
              {
              existFlag=true;
              }
          
          }
         
          if(existFlag==false){
          boothsizeDuplicatelistboth.add(bmap.Booth_Size__c);
          if(bmap.Booth_Size__c!=''){
          string bsz=bmap.Booth_Size__c;
          bsizelistopt.add(new SelectOption(bsz,bsz));
          if(bsz.contains('\''))
         //bsz=bsz.replaceAll('\'','\\\\\'');
         bsz=bsz.replaceAll('\'','\'');
          boothsizelistbooth= boothsizelistbooth+bsz+',';
          }
         }
         
        }
        return boothsizelistbooth;
   }   
      
@RemoteAction
  global static string dynamicboothnumbers(string evenid){
  list<Booth_Map__c> BoothMapListsize = [select Booth_Number__c from Booth_Map__c where Booth_Number__c!=null AND Ticket_id__r.Event__r.id =:evenid];
   string bnolistremot;
   bnolistremot='';
  for(Booth_Map__c b:BoothMapListsize){
          if(b.Booth_Number__c!=''){
          bnolistremot=bnolistremot+b.Booth_Number__c+',';
       }
  }
  return bnolistremot;
  }


}
@RestResource(urlMapping='/BLN_ASC_ITEMTYPEDETAILS/*')
/***********************************************************************************************
*   Service Name : BLN_ASC_ITEMTYPEDETAILS
*   Date            : 06/02/2015
*   Author          : Arindam Sarkar
*   Purpose         : This class is for getting all details of a itemtype like sponsor,exhibitor,etc.
************************************************************************************************/
  

    global with sharing class BLN_ASC_ITEMTYPEDETAILS{
   
    @HttpPost  
    global static MainContainer doPost(){
        RestRequest req = RestContext.request;  
        String ItemTypeName= req.params.get('ItemType_Name');
        
        String EventID=req.params.get('Event_Id');
        MainContainer mc=new MainContainer();
             
        RestResponse response = RestContext.response;
        mc.ItemTypeName=ItemTypeName;
        
        system.debug('ItemTypeName From Mobile ' +ItemTypeName);
        
        //Attendee is admission
        if(ItemTypeName=='Attendees')
        ItemTypeName='Admissions';
        
        //Exhibitors
        if(ItemTypeName=='Exhibitors')
        ItemTypeName='Exhibitor';
        
        //Speakers
        if(ItemTypeName=='Speakers')
        ItemTypeName='Speaker';
        
        //Sponsors
        if(ItemTypeName=='Sponsors')
        ItemTypeName='Sponsor';
        
        //GET ALL THE USER AND COMPANY INFORMATION FROM BOOKED TICKET BASED ON POOLID or TICKETID
        String q='select id,Event__c,name,Item_Type__c,Item_Type__r.name,Item_Pool__c,tkt_profile__c,tkt_profile__r.TKT_Company__c,Ticket_Status__c,tkt_profile__r.Home_Phone__c,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.User_Pic__c,tkt_profile__r.BLN_Company__c,tkt_profile__r.Home_Address__r.City__c,tkt_profile__r.Home_Address__r.State__c,tkt_profile__r.BLN_GN_User__r.User__c,tkt_profile__r.Work_Address__r.City__c,tkt_profile__r.Work_Address__r.State__c,tkt_profile__r.Work_Address__r.Country__c,tkt_profile__r.Home_Address__r.Country__c,tkt_profile__r.FaceBookId__c,tkt_profile__r.LinkedInId__c,tkt_profile__r.TwitterId__c,tkt_profile__r.Blogger__c,tkt_profile__r.Biography__c,tkt_profile__r.Video__c,tkt_profile__r.Company_Logo__c,tkt_profile__r.Company_Website_URL__c from Ticket__c where (Item_Type__r.Name=\''+ItemTypeName+'\' OR Item_Pool__r.Item_Type__r.Name=\''+ItemTypeName+'\') and Event__c=\''+EventID+'\' and (Ticket_Status__c=\'Booked\' or Ticket_Status__c=\'Checked-in\' or Ticket_Status__c=\'Checked-out\')';
		system.debug('qqqqqqqqqqqqqqqqqqqqqq'+q);
         //list<Booth_Map__c> bm =[select id,name,Booth_Area__c,Booth_Number__c,BLN_Room__r.Room_Number__c from Booth_Map__c];
         List<Ticket__c> Ticket=Database.query(q); 
         LIST<booth_map__c> bMap=[select id,name,Booth_Area__c,Booth_Number__c,BLN_Room__r.Room_Number__c,BLN_Room__r.Name,Ticket_id__r.tkt_profile__r.BLN_Company__c,Ticket_id__r.tkt_profile__r.TKT_Company__c from booth_map__c where Ticket_id__r.Event__c=:EventID];
         MAP<string,LIST<booth_map__c>> bmapMAp=new MAP<string,LIST<booth_map__c>>();
         for(booth_map__c bM:bMap){
             LIST<booth_map__c> bMap1=new LIST<booth_map__c>();
             if(bmapMAp.containsKey(bm.ticket_id__R.tkt_profile__r.BLN_Company__c)){
                 bMap1=bmapMAp.get(bm.ticket_id__R.tkt_profile__r.BLN_Company__c);
                 bmapMAp.put(bm.ticket_id__R.tkt_profile__r.BLN_Company__c,bMap1);
             }else{
                 bMap1.add(bm);
                 bmapMAp.put(bm.ticket_id__R.tkt_profile__r.BLN_Company__c,bMap1);
         
               }
         
         }
         List<Container> container=new List<Container>();
         for(Ticket__c tc:Ticket)
         {
          Container cnt=new Container();
          cnt.TicketId=tc.id;
          cnt.FirstName=tc.tkt_profile__r.First_Name__c==null?'':tc.tkt_profile__r.First_Name__c;
          cnt.LastName=tc.tkt_profile__r.Last_Name__c==null?'':tc.tkt_profile__r.Last_Name__c;
          cnt.Email=tc.tkt_profile__r.Email__c==null?'':tc.tkt_profile__r.Email__c;
          cnt.CompanyName=tc.tkt_profile__r.TKT_Company__c==null?'':tc.tkt_profile__r.TKT_Company__c;
          //cnt.UserWebSite=tc.Client_GN_User__r.User_Website__c==null?'':tc.Client_GN_User__r.User_Website__c;
          cnt.UserPhoto=tc.tkt_profile__r.User_Pic__c==null?'':tc.tkt_profile__r.User_Pic__c;
          cnt.tktprofileid=tc.tkt_profile__c==null?'':tc.tkt_profile__c;
          cnt.SfuserID=tc.tkt_profile__r.BLN_GN_User__r.User__c==null?'':tc.tkt_profile__r.BLN_GN_User__r.User__c;
          cnt.CompanyID=tc.tkt_profile__r.BLN_Company__c==null?'':tc.tkt_profile__r.BLN_Company__c;
          cnt.City=tc.tkt_profile__r.Home_Address__r.City__c==null?'':tc.tkt_profile__r.Home_Address__r.City__c;
          cnt.State=tc.tkt_profile__r.Home_Address__r.State__c==null?'':tc.tkt_profile__r.Home_Address__r.State__c;
          cnt.Country=tc.tkt_profile__r.Home_Address__r.Country__c==null?'':tc.tkt_profile__r.Home_Address__r.Country__c;
          cnt.Facebook=tc.tkt_profile__r.FaceBookId__c==null?'':tc.tkt_profile__r.FaceBookId__c;
          cnt.Linkedin=tc.tkt_profile__r.LinkedInId__c==null?'':tc.tkt_profile__r.LinkedInId__c;
          cnt.Twitter=tc.tkt_profile__r.TwitterId__c==null?'':tc.tkt_profile__r.TwitterId__c;
          cnt.SpeakerBlog=tc.tkt_profile__r.Blogger__c==null?'':tc.tkt_profile__r.Blogger__c;
          cnt.Biography=tc.tkt_profile__r.Biography__c==null?'':tc.tkt_profile__r.Biography__c;
          cnt.Youtube=tc.tkt_profile__r.Video__c==null?'':tc.tkt_profile__r.Video__c;
          cnt.CompanyWebSite=tc.tkt_profile__r.Company_Website_URL__c==null?'':tc.tkt_profile__r.Company_Website_URL__c;
          cnt.CompanyLogo=tc.tkt_profile__r.Company_Logo__c==null?'':tc.tkt_profile__r.Company_Logo__c; 
          cnt.Phone=tc.tkt_profile__r.Home_Phone__c==null?'':tc.tkt_profile__r.Home_Phone__c;
          List<boothContainer> boothContainer=new List<boothContainer>();
          LIST<booth_map__c> bm1=new LIST<booth_map__c>();
          bm1=bmapMAp.get(tc.tkt_profile__r.BLN_Company__c);
          if(ItemTypeName!='Speaker' && ItemTypeName!='Admissions'){
          if(bm1.size()>0 && bm1 != null ){
              for(booth_map__c b: bm1){
                  boothContainer bcnt=new boothContainer();
                  bcnt.BoothName=b.Ticket_id__r.tkt_profile__r.TKT_Company__c==null?'':b.Ticket_id__r.tkt_profile__r.TKT_Company__c;
                  bcnt.BoothArea=b.Booth_Area__c==null?'':b.Booth_Area__c;
                  bcnt.BoothNumber=b.Booth_Number__c==null?'':b.Booth_Number__c;
                  bcnt.Room=b.BLN_Room__r.Name==null?'':b.BLN_Room__r.Name;
                  boothContainer.add(bcnt);
              }
          }else{
              boothContainer bcnt=new boothContainer();
              bcnt.BoothName='';
              bcnt.BoothArea='';
              bcnt.BoothNumber='';
              bcnt.Room='';
              boothContainer.add(bcnt);
          }
          
          cnt.boothDetails=boothContainer;
          }
          container.add(cnt); 
         }
         mc.details=new List<Container>();
         mc.details=container;
         string orgid = UserInfo.getOrganizationId();
        mc.ImagePath=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?oid='+orgid+'&id=';
        
         return mc;
        
      }
      
      global class boothContainer{
           public string BoothName{get;set;}
           public string BoothArea{get;set;}
           public string BoothNumber{get;set;}
           public string Room{get;set;}
      }
      
      
      global Class Container
      {
           public String TicketId{get;set;}
           public String FirstName{get;set;}
           public String LastName{get;set;}
           public String Email{get;set;}
           public String CompanyName{get;set;}
           public String UserWebSite{get;set;}
           public String UserPhoto{get;set;}
           public String tktprofileid{get;set;}
           public String SfuserID{get;set;}
           public String CompanyID{get;set;}
           public String City{get;set;}
           public String State{get;set;}
           public String Country{get;set;}
           public String Facebook{get;set;}
           public String linkedin{get;set;}
           public String Twitter{get;set;}
           public String SpeakerBlog{get;set;}
           public String Biography{get;set;}
           public String Youtube{get;set;}
           public String CompanyWebSite{get;set;}
           public String CompanyLogo{get;set;}
           public String Phone{get;set;}
           LIST<boothContainer> boothDetails{get;set;}
      }
      
      global class MainContainer
      {
         List<Container> details{get;set;}
         
         public String ItemTypeName{get;set;}
         public String ImagePath{get;set;}
      }
      
      
    
        
      
      
      }
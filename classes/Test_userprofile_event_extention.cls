@istest
public class Test_userprofile_event_extention{
    static testmethod void Testmethod_userprofile_event_extention(){
    Event__c env=new Event__c(EV_Title__c='new event',Is_Webank_event__c=false);
    insert env;
    
    
   cookie  counter = new Cookie('counter',env.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});



   Booth__c bot= new  Booth__c(MM_TableNo__c='10');
   insert bot;
   AttendeeSummary__c aten=new AttendeeSummary__c( AS_FirstName__c='at test1',AS_LastName__c ='at test2',AS_Email__c='abc@gmail.com',AS_Company__c='globalnest');
       insert aten;
       User_Profile_Event__c upe=new User_Profile_Event__c( EV_id__c=env.id,Attendee_Summary__c=aten.id,BT_id__c=bot.id);
     insert upe ;
   
   Event_Attendee_Mapping__c eam=new Event_Attendee_Mapping__c( AS_id__c=aten.id ,EV_id__c=env.id);
    insert eam;
  EventSchedule__c t_eve_shed = new EventSchedule__c();
  
  t_eve_shed.EV_id__c =env.id;
  t_eve_shed.Is_Matchmaking__c=true;
  t_eve_shed.MM_slot_StartTime__c='01:40 PM';
  t_eve_shed.MM_Slot_End_Time__c ='01:50 PM';
  t_eve_shed.MM_To_EAM__c=eam.id;
  t_eve_shed.MM_To_UPE__c=upe.id;
  insert t_eve_shed ;

  ApexPAges.StandardController sc = new ApexPages.StandardController(t_eve_shed);
userprofile_event_extention lc1= new userprofile_event_extention(sc);

 
string ue='test1';
string b_t='test2';
integer l=10;
lc1.selectedValAs='ALL_CORPORATE';
lc1.allmatches=false;
lc1.all_match_chart=false;
lc1.allcorp=true;
lc1.all_corp_chart=true;
lc1.all_mbe=false;
lc1.all_mbe_chart=false;
lc1.showpick();
lc1.selectedValAs='Corporate_No_Match';
lc1.showpick();
lc1.selectedValAs='ALL_MBE';
lc1.showpick();
lc1.selectedValAs='MBE_No_Match';
lc1.showpick();

userprofile_event_extention.PieWedgeData  cd=new userprofile_event_extention.PieWedgeData (b_t,l,ue);


lc1.getPieData();

Event__c env2=env;
env2.EV_Title__c='new eventt';
env2.Is_Webank_event__c=true;
    update env2;
    lc1.selectedValAs='ALL_MBE';
lc1.showpick();
lc1.getcustomPieData();
lc1.custcrp_mbe_industry_md();

lc1.customallmbemd();
lc1.getcustompieData_allmbe();
lc1.selectedValAs='MBE_No_Match';
lc1.allmatches=false;
     lc1.allcorp=false;
     lc1.all_corp_chart=false;            
     lc1.all_match_chart=false;  
    lc1.all_mbe=false;
    lc1.all_mbe_chart=false;
    lc1.table_crp_mbe_pri_industry=false;
    lc1.crpmbepr_indust_chrt=false;
    lc1.customeveallmatches=true;
    lc1.custeve_chrt=true;
    lc1.cutomcrpmbeindgrpchart=false;
    lc1.cutomcrpmbeindgrp=false;
    lc1.allmbecustchrt=false;
    lc1.customall_mbe=false;
    
lc1.showpick();
lc1.selectedValAs='MBE_No_Match1';
lc1.showpick();

/****************************************************************/
Event__c env1=new Event__c(EV_Title__c='new event',Is_Webank_event__c=true);
    insert env1;
    
    
   cookie  counter1 = new Cookie('counter1',env1.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter1});



   Booth__c bot1= new  Booth__c(MM_TableNo__c='101');
   insert bot1;
   AttendeeSummary__c aten1=new AttendeeSummary__c( AS_FirstName__c='at test11',AS_LastName__c ='at test21',AS_Email__c='abcd@gmail.com',AS_Company__c='globalnest ll');
       insert aten1;
       User_Profile_Event__c upe1=new User_Profile_Event__c( EV_id__c=env1.id,Attendee_Summary__c=aten1.id,BT_id__c=bot1.id);
     insert upe1 ;
   
   Event_Attendee_Mapping__c eam1=new Event_Attendee_Mapping__c( AS_id__c=aten1.id ,EV_id__c=env1.id);
    insert eam1;
  EventSchedule__c t_eve_shed1 = new EventSchedule__c();
  
  t_eve_shed1.EV_id__c =env.id;
  t_eve_shed1.Is_Matchmaking__c=true;
  t_eve_shed1.MM_slot_StartTime__c='01:40 PM';
  t_eve_shed1.MM_Slot_End_Time__c ='01:50 PM';
  t_eve_shed1.MM_To_EAM__c=eam.id;
  t_eve_shed1.MM_To_UPE__c=upe.id;
  insert t_eve_shed1 ;

  ApexPAges.StandardController sc1 = new ApexPages.StandardController(t_eve_shed1);
userprofile_event_extention lc2= new userprofile_event_extention(sc1);

/**************************/
string ue1='test11';
string b_t1='test21';
integer l1=9;
lc2.allmatches=false;
     lc2.allcorp=false;
     lc2.all_corp_chart=false;            
     lc2.all_match_chart=false;  
     lc2.all_mbe=false;
     lc2.all_mbe_chart=false;
     lc2.table_crp_mbe_pri_industry=false;
lc2.crpmbepr_indust_chrt=false;
lc2.customeveallmatches=false;
lc2.custeve_chrt=false;
lc2.cutomcrpmbeindgrpchart=false;
lc2.cutomcrpmbeindgrp=false;
lc2.allmbecustchrt=true;
lc2.customall_mbe=true;

lc2.selectedValAs='ALL_MBE';
lc2.showpick();
lc2.getcustomPieData();
lc2.custcrp_mbe_industry_md();

lc2.customallmbemd();
lc2.getcustompieData_allmbe();
lc2.selectedValAs='ALL_MBE1';
lc2.showpick();
lc2.selectedValAs='MBE_No_Match';
lc2.showpick();

userprofile_event_extention.PieWedgeData  cde=new userprofile_event_extention.PieWedgeData (b_t1,l1,ue1);


lc2.getPieData();


/************************/



    }
    }
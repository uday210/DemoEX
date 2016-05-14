public with sharing class userprofile_event_extention {
// global declaration
public String eventSelected{get;set;} 
public Transient  list<EventSchedule__c> my_eve ;
public LIST<LIST<EventSchedule__c>> my_eve_LL{get;set;}
public LIST<LIST<EventSchedule__c>> my_eve_cust_LL {get;set;}
public LIST<LIST<User_Profile_Event__c>> all_crp_sel_eve_LL{get;set;} 
public LIST<LIST<Event_Attendee_Mapping__c>> all_mbe_sel_eve_LL {get;set;}
public LIST<LIST<EventSchedule__c>> my_eve_industrty_final_LL {get;set;}
public LIST<LIST<EventSchedule__c>> custmy_eve_industrty_final_LL{get;set;}
public LIST<LIST<Event_Attendee_Mapping__c>> csall_mbe_sel_eve_LL{get;set;}
public Transient  list<EventSchedule__c> my_eve_industrty ;
public Transient list<EventSchedule__c> my_eve_industrty_final ;
public Transient  list<EventSchedule__c> custmy_eve_industrty ;
public Transient list<EventSchedule__c> custmy_eve_industrty_final ;
public Transient list<User_Profile_Event__c> all_crp_sel_eve ;
public Transient list<Event_Attendee_Mapping__c> all_mbe_sel_eve ;
public Transient list<Event_Attendee_Mapping__c> csall_mbe_sel_eve ;
 public  list<selectoption> apps {get;set;} 
  public  String selectedapp {get;set;}
 
public  list<AggregateResult> utilizationchart{get;set;}
public decimal totalrec;
public decimal totalrec_allcrp;
public decimal totalrec_allmbe;
public decimal totalreccrpmbe_ind;
public decimal customtotalrec;
public decimal custtotalreccrpmbe_ind;
public decimal cstotalrec_allmbe;

public string selectedValAs{get;set;}
public List<selectOption> selOption{get;set;}
public boolean allcorp{get;set;}
public boolean all_corp_chart{get;set;}
public boolean allmatches{get;set;}
public boolean all_match_chart{get;set;}
public boolean all_mbe{get;set;}
public boolean all_mbe_chart{get;set;}
public boolean customeveallmatches{get;set;}
public boolean table_crp_mbe_pri_industry{get;set;}
public boolean crpmbepr_indust_chrt {get;set;}
public boolean custeve_chrt{get;set;}
public boolean cutomcrpmbeindgrp{get;set;}
public boolean cutomcrpmbeindgrpchart{get;set;}
public boolean customall_mbe{get;set;}
public boolean allmbecustchrt{get;set;}

public List<PieWedgeData> datae{get;set;}
public List<PieWedgeData> cudata{get;set;}
public List<PieWedgeData> custdatae{get;set;}
public List<PieWedgeData> cdata_allmbe{get;set;}

public string attendeealias {get ; set ;}
public string exhibitoralias {get ; set ;}
public list<Tags__c> tagslist {get; set ;}
public Event__c event_name;
public list<EventSchedule__c> my_eve_cust{get;set;}
//public list<EventSchedule__c> my_eve1{get;set;}
//end of global declaration
//construter method
    public userprofile_event_extention(ApexPages.StandardController controller) {
    
    apps = new list<selectoption> ();
      apps.add(new selectoption('Match Leads','Match Leads'));
      apps.add(new selectoption('Booth Leads','Booth Leads'));
      selectedapp = 'Match Leads';
    
    try{
     LIST<User_Profile_Event__c> corporateUsers = new LIST<User_Profile_Event__c>();
               Cookie k = ApexPages.currentPage().getCookies().get('counter');
               eventSelected = k.getValue();
    allmatches=true;
    allcorp=false;
    all_corp_chart=false;            
    all_match_chart=true;            
    
    tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventSelected];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       } 
    
     event_name = new Event__c();
    event_name=[select EV_Title__c , Is_Webank_event__c from Event__c where id=:eventSelected]; 
   // system.debug('eve$$$$$$$'+event_name);
    
  if(event_name.Is_Webank_event__c==true){
   my_eve_cust=new list<EventSchedule__c>();
   my_eve_cust_LL = new LIST<LIST<EventSchedule__c>>();
  my_eve_cust =  [select id, MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.IsMatchMakingUser__c,MM_To_UPE__r.MAtchMakingProfile__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c from EventSchedule__c Where 
                      Ev_id__c =: eventSelected 
                       AND Is_Matchmaking__c = true 
                       AND MM_To_EAM__c != null
                       AND MM_To_UPE__c != null
                       AND MM_To_EAM__r.MBE_Profile__c != null
                       AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
                       AND MM_To_UPE__r.Attendee_Summary__c != null 
                       Order BY MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c
                       ];
  
  
  /***************list of list**********************/
  
  

 LIST<EventSchedule__c> my_eve_cust_999= new LIST<EventSchedule__c>(); 
        for(EventSchedule__c mycustld: my_eve_cust){
            my_eve_cust_999.add(mycustld);
            if(my_eve_cust_999.size() == 999){

                my_eve_cust_LL.add(my_eve_cust_999);

                my_eve_cust_999 = new LIST<EventSchedule__c>();
            }
        }  
        if(my_eve_cust_999.size() != 0){

            my_eve_cust_LL.add(my_eve_cust_999);    
    
        }     
  
  
  
  /***************end of list of list******************/
  
  
  
  customtotalrec=my_eve_cust.size();
  
  }else if(event_name.Is_Webank_event__c==false){  
     my_eve=new list<EventSchedule__c>();
     my_eve_LL = new LIST<LIST<EventSchedule__c>>();
  my_eve =  [select id, MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.IsMatchMakingUser__c,MM_To_UPE__r.MAtchMakingProfile__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c from EventSchedule__c Where 
                      Ev_id__c =: eventSelected 
                       AND Is_Matchmaking__c = true 
                       AND MM_To_EAM__c != null
                       AND MM_To_UPE__c != null
                       AND MM_To_EAM__r.AS_id__c != null
                       AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
                       AND MM_To_UPE__r.Attendee_Summary__c != null 
                       Order BY MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c
                       ];
                       
                       //system.debug('%%%%%%'+my_eve);              
//system.debug('@@@@'+my_eve.size());

/***************list of list**********************/

 LIST<EventSchedule__c> my_eve_999= new LIST<EventSchedule__c>(); 
        for(EventSchedule__c myld: my_eve){
            my_eve_999.add(myld);
            if(my_eve_999.size() == 999){

                my_eve_LL.add(my_eve_999);

                my_eve_999= new LIST<EventSchedule__c>();
            }
        }  
        if(my_eve_999.size() != 0){

            my_eve_LL.add(my_eve_999);    
    
        }      



/***************end of list of list******************/
 totalrec=my_eve.size();
             }        
 
 selectedValAs='Corporate_And_MBE_Primari_industry_Group';
getselectedpicAs();
  showpick();
   
}catch(exception ex){} 
   

    }
    
//end of constructor method   
//picklist method
public List<selectOption> getselectedpicAs(){
      selOption  = new List<selectOption>();
      selOption.add(new selectOption('Corporate_And_MBE_Primari_industry_Group',exhibitoralias+' and '+attendeealias+' matches by Industry'));
      selOption.add(new selectOption('Corporate_AND_MBE_primary_NAICS_code',exhibitoralias+' and '+attendeealias+' matches by NAICS code'));
      selOption.add(new selectOption('Corporate_primary_NAICS_code',exhibitoralias+' Matches'));
      selOption.add(new selectOption('MBE_primary_NAICS_code',attendeealias+' Matches'));
      selOption.add(new selectOption('ALL_CORPORATE','Complete '+exhibitoralias+' NAICS codes'));
      selOption.add(new selectOption('ALL_MBE','Complete '+attendeealias+' NAICS codes'));   
      selOption.add(new selectOption('Corporate_No_Match',exhibitoralias+' no Matches'));
      selOption.add(new selectOption('MBE_No_Match',attendeealias+' no Matches'));  
      
      
      return selOption;
    }

//end of picklist method
// piclist action method
public void showpick(){

//system.debug('######################'+selectedValAs);
if(selectedValAs=='ALL_CORPORATE'){
allmatches=false;
all_match_chart=false;
allcorp=true;
all_corp_chart=true;
all_mbe=false;
all_mbe_chart=false;
table_crp_mbe_pri_industry=false;
crpmbepr_indust_chrt=false;
customeveallmatches=false;
custeve_chrt=false;
cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=false;
customall_mbe=false;
allcorptmd();
getpieData_allcrp();
}else if(selectedValAs=='Corporate_No_Match'){
allmatches=false;
all_match_chart=false;
allcorp=true;
all_corp_chart=true;
all_mbe=false;
all_mbe_chart=false;
table_crp_mbe_pri_industry=false;
crpmbepr_indust_chrt=false;
customeveallmatches=false;
custeve_chrt=false;
cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=false;
customall_mbe=false;
allcorptmd();
getpieData_allcrp();

}else if(selectedValAs=='ALL_MBE'){
     if(event_name.Is_Webank_event__c==true){
     
     allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
     all_mbe=false;
     all_mbe_chart=false;
     table_crp_mbe_pri_industry=false;
crpmbepr_indust_chrt=false;
customeveallmatches=false;
custeve_chrt=false;
cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=true;
customall_mbe=true;
customallmbemd();
getcustompieData_allmbe();
     
     }else{
     allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
     all_mbe=true;
     all_mbe_chart=true;
     table_crp_mbe_pri_industry=false;
crpmbepr_indust_chrt=false;
customeveallmatches=false;
custeve_chrt=false;
cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=false;
customall_mbe=false;
    allmbemd();
    getpieData_allmbe();

}
}else if(selectedValAs=='MBE_No_Match'){
    if(event_name.Is_Webank_event__c==true){
    allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
     all_mbe=false;
     all_mbe_chart=false;
     table_crp_mbe_pri_industry=false;
crpmbepr_indust_chrt=false;
customeveallmatches=false;
custeve_chrt=false;
cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=true;
customall_mbe=true;
customallmbemd();
getcustompieData_allmbe();
    
    }else{
    allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
     all_mbe=true;
     all_mbe_chart=true;
     table_crp_mbe_pri_industry=false;
crpmbepr_indust_chrt=false;
customeveallmatches=false;
custeve_chrt=false;
cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=false;
customall_mbe=false;
    allmbemd();
    getpieData_allmbe();
}
}else if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){

if(event_name.Is_Webank_event__c==true){

      table_crp_mbe_pri_industry=false;
     crpmbepr_indust_chrt=false;
     allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
     all_mbe=false;
     all_mbe_chart=false;
     customeveallmatches=false;
     custeve_chrt=false;
     cutomcrpmbeindgrpchart=true;
     cutomcrpmbeindgrp=true;
     allmbecustchrt=false;
customall_mbe=false;
    custcrp_mbe_industry_md();
    getcustcrpmbeindustrychart_md();


}else{

table_crp_mbe_pri_industry=true;
crpmbepr_indust_chrt=true;
  allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
     all_mbe=false;
     all_mbe_chart=false;
     customeveallmatches=false;
     custeve_chrt=false;
     cutomcrpmbeindgrpchart=false;
    cutomcrpmbeindgrp=false;
    allmbecustchrt=false;
customall_mbe=false;
     crp_mbe_industry_md();
    getcrpmbeindustrychart_md();
    }
}else {
    if(event_name.Is_Webank_event__c==true){
    allmatches=false;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=false;  
    all_mbe=false;
    all_mbe_chart=false;
    table_crp_mbe_pri_industry=false;
    crpmbepr_indust_chrt=false;
    customeveallmatches=true;
    custeve_chrt=true;
    cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=false;
customall_mbe=false;
    getcustomPieData();
    }
    else{
     allmatches=true;
     allcorp=false;
     all_corp_chart=false;            
     all_match_chart=true;  
    all_mbe=false;
    all_mbe_chart=false;
    table_crp_mbe_pri_industry=false;
    crpmbepr_indust_chrt=false;
    customeveallmatches=false;
    custeve_chrt=false;
    cutomcrpmbeindgrpchart=false;
cutomcrpmbeindgrp=false;
allmbecustchrt=false;
customall_mbe=false;
    //system.debug('check&&&&&&');
    }
}

}
//End of piclist action method
     public List<PieWedgeData> getPieData() {
    // system.debug('sagar');
     try{
        List<PieWedgeData> data = new List<PieWedgeData>();
        List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
        list<AggregateResult> utilizationchart=new list<AggregateResult>();

/***************************standard event****************************/       
if(selectedValAs=='Corporate_primary_NAICS_code'){
utilizationchart= [select count(id) xyz,  MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c  abc from EventSchedule__c Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
AND MM_To_EAM__r.AS_id__c != null
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
AND MM_To_UPE__r.Attendee_Summary__c != null Group By MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC

];

//system.debug('$$$$$$$$$$$$$$$$$'+utilizationchart.size());
//system.debug('test2@@@'+utilizationchart);
}
else if(selectedValAs=='MBE_primary_NAICS_code'){
utilizationchart= [select count(id) xyz,  MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c  abc from EventSchedule__c Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
AND MM_To_EAM__r.AS_id__c != null
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
AND MM_To_UPE__r.Attendee_Summary__c != null Group By MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC

];
        //system.debug('$$$$$$$$$$$$$$$$$&&&'+utilizationchart.size());
        //system.debug('test2@@@'+utilizationchart);
 }       
/*************************************************/
else if(selectedValAs=='Corporate_AND_MBE_primary_NAICS_code'){


utilizationchart= [select   count(id) xyz,   MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c  abc, MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c  efgh  from EventSchedule__c  Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND MM_To_EAM__r.AS_id__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
//AND MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c IN : corp_naic_set
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c =: MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c
AND MM_To_UPE__r.Attendee_Summary__c != null 
Group By MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC

];



//system.debug('utilizationchart === '+utilizationchart);


 }    






/*************************************************/        
        
       
//system.debug('####'+utilizationchart.size());
//system.debug('$$$'+totalrec);

        string st;
        integer i;
        string ps_v;
        integer j=0;
        string std;
        string   ps_v1;
        integer x;
        x=1;
        for (AggregateResult ar : utilizationchart){
        /*******************************************/
        if(selectedValAs=='Corporate_AND_MBE_primary_NAICS_code'){
        
           if(string.valueof(ar.get('abc'))==string.valueof(ar.get('efgh')) && string.valueof(ar.get('abc')) !=null){
           
            i=integer.valueof(ar.get('xyz'));
            st=string.valueof(ar.get('abc'));
            if(st !=null){
            st=st.mid(0,63);
            }
            
            ps_v=st+'  '+((i/totalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
            temp_cdata_allmbe.add(new PieWedgeData(st,i,ps_v));
        }
     else{
     
    
     
     
        //system.debug('eeeeeeeeeeee');
        std='Other';
        i=integer.valueof(ar.get('xyz'));
        j=j+i;
         ps_v1=std+'  '+((j/totalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
         //system.debug('rajeshchek'+x);
        // system.debug('rajeshchek_totoalrec'+utilizationchart.size());
         if(x==utilizationchart.size()){
        // system.debug('rajeshchek'+x);
         //system.debug('goodbbb'+std);
          temp_cdata_allmbe.add(new PieWedgeData(std,j,ps_v1));
          }
      }
     
      
        }
       else{
        
        /********************************************/
        //system.debug('@@'+ar.get('abc'));
       // system.debug('@@'+ar.get('xyz'));
         i=integer.valueof(ar.get('xyz'));
        
         st=string.valueof(ar.get('abc'));
         if(st !=null){
            st=st.mid(0,63);
            }
         
        if(String.isBlank(st)){
       
        st='Other';
        }
          ps_v=st+'  '+((i/totalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
        //system.debug('****'+ps_v);
        temp_cdata_allmbe.add(new PieWedgeData(st,i,ps_v));
        }
        
        x++;
        
        }
        
        
 /*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      data.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((totalrec-top_rec));
temp_pval= 'Other'+'  '+((other_rec/totalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
data.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 data.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/  
        
        
        //system.debug('piedata%%%'+data);
        return data;
       }catch(exception ex){ return null;} 
    }

/*********************all corporate method*************************/
public integer countOftpr{get; set;}
public List<List<User_Profile_Event__c>> thousandPlusRecs {get; set;}
public void allcorptmd(){
     thousandPlusRecs = new List<List<User_Profile_Event__c>>();
     List<User_Profile_Event__c> thousandBelowRecs = new List<User_Profile_Event__c>();


if(selectedValAs=='ALL_CORPORATE'){
totalrec_allcrp=null;
  all_crp_sel_eve=new list<User_Profile_Event__c>();
  all_crp_sel_eve_LL = new LIST<LIST<User_Profile_Event__c>>();
  all_crp_sel_eve =  [select id,IsMatchMakingUser__c,UEP_isActive__c,MAtchMakingProfile__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,Attendee_Summary__r.As_NAICSCode_1__c from User_Profile_Event__c Where 
                      Ev_id__c =: eventSelected
                      AND MAtchMakingProfile__c = 'Corporate'
                      AND Attendee_Summary__c != null 
                       Order BY Attendee_Summary__r.AS_PrimaryBusinessCategory1__c 
                       ];//Limit 1000
    
   /********************list of list************************/ 
  

 LIST<User_Profile_Event__c> all_crp_sel_eve_999= new LIST<User_Profile_Event__c>(); 
        for(User_Profile_Event__c allcrpsel: all_crp_sel_eve){

            all_crp_sel_eve_999.add(allcrpsel);

            if(all_crp_sel_eve_999.size() == 999){

                all_crp_sel_eve_LL.add(all_crp_sel_eve_999);

                all_crp_sel_eve_999 = new LIST<User_Profile_Event__c>();
            }
        }  
        if(all_crp_sel_eve_999.size() != 0){

            all_crp_sel_eve_LL.add(all_crp_sel_eve_999);    
    
        }     
    
    
    
    
    /***************end of list of list******************/
   /* 
    for (Integer i = 0; i < all_crp_sel_eve.size(); i++) {
        if (thousandBelowRecs.size() < 1000) {
            thousandBelowRecs.add(all_crp_sel_eve[i]);
            system.debug('thousandBelowRecs1 === '+thousandBelowRecs.size());
            system.debug('thousandBelowRecs1 === '+thousandBelowRecs.size());
        } //End of if
        else {
            system.debug('thousandBelowRecs2 === '+thousandBelowRecs.size());
            system.debug('thousandBelowRecs2 === '+thousandBelowRecs.size());
            thousandPlusRecs.add(thousandBelowRecs);
            thousandBelowRecs = new List <User_Profile_Event__c> ();
            thousandBelowRecs.add(all_crp_sel_eve[i]);
        } //End of else
    } //End of for
    thousandPlusRecs.add(thousandBelowRecs);
    system.debug('thousandPlusRecs3 === '+thousandPlusRecs.size());
    system.debug('thousandPlusRecs.size3 === '+thousandPlusRecs);        
    countOftpr = thousandPlusRecs.size();
//system.debug('%%%%%ttt'+all_crp_sel_eve.size());
*/

totalrec_allcrp=all_crp_sel_eve.size();
}else if(selectedValAs=='Corporate_No_Match'){
totalrec_allcrp=null;
list<User_Profile_Event__c> all_crp_sel_eve1=new list<User_Profile_Event__c>();
all_crp_sel_eve=new list<User_Profile_Event__c>();
all_crp_sel_eve_LL = new LIST<LIST<User_Profile_Event__c>>();
  all_crp_sel_eve1 =  [select id,IsMatchMakingUser__c,UEP_isActive__c,(select id,name,MM_Slot_Status__c from EventSchedule__r),MAtchMakingProfile__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,Attendee_Summary__r.As_NAICSCode_1__c from User_Profile_Event__c Where 
                      Ev_id__c =: eventSelected 
                      AND MAtchMakingProfile__c = 'Corporate'
                      AND Attendee_Summary__c != null 
                       Order BY Attendee_Summary__r.AS_PrimaryBusinessCategory1__c
                       ];
set<id> stid=new set<id>();
set<id> accstid=new set<id>();
for(User_Profile_Event__c bdd:all_crp_sel_eve1){
list<EventSchedule__c> ab_evesced=new list<EventSchedule__c>();
ab_evesced=bdd.EventSchedule__r;
//SYSTEM.DEBUG('scedule@@@'+ab_evesced);
//system.debug('allnomatch$$$$'+bdd);

    for(EventSchedule__c ees:ab_evesced){
    
    if(ees.MM_Slot_Status__c =='Accepted' || ees.MM_Slot_Status__c =='Pending'){
    accstid.add(bdd.id);
    //system.debug('&&&&aa'+accstid);
    }
    
    }



for(EventSchedule__c ees:ab_evesced){


    if((ees.MM_Slot_Status__c !='Accepted' || ees.MM_Slot_Status__c !='Pending') && (ees.MM_Slot_Status__c == 'Cancelled' || ees.MM_Slot_Status__c == 'Rejected' ) ) {
        if(!stid.contains(bdd.id)){
            //system.debug('DDDDDDDDDDDD'+accstid.contains(bdd.id));
            if(!(accstid.contains(bdd.id))){
             all_crp_sel_eve.add(bdd);
           
                   }
        stid.add(bdd.id);
        }
    }
 }   
if(ab_evesced.size()==0 ){
all_crp_sel_eve.add(bdd);
} 

}
//system.debug('%%%%%ttt'+all_crp_sel_eve);
//system.debug('%%%%%ttt'+all_crp_sel_eve.size());

/*********List of List**************/
LIST<User_Profile_Event__c> all_crp_sel_eve_999= new LIST<User_Profile_Event__c>(); 
        for(User_Profile_Event__c allcrpsel: all_crp_sel_eve){

            all_crp_sel_eve_999.add(allcrpsel);

            if(all_crp_sel_eve_999.size() == 999){

                all_crp_sel_eve_LL.add(all_crp_sel_eve_999);

                all_crp_sel_eve_999 = new LIST<User_Profile_Event__c>();
            }
        }  
        if(all_crp_sel_eve_999.size() != 0){

            all_crp_sel_eve_LL.add(all_crp_sel_eve_999);    
    
        }     
    
    



/********* end of List of List**************/

totalrec_allcrp=all_crp_sel_eve.size();

}

}
/**************************end of all corporate method**********************/
/**************************all corporate chart ***************************/
 public List<PieWedgeData> getpieData_allcrp() {
        string st_crp;
        integer i_crp;
        string ps_v_crp;
 
 List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
  List<PieWedgeData> data_allcrp= new List<PieWedgeData>();
 list<AggregateResult> crp_all_chart=new list<AggregateResult>();
 try{
if(selectedValAs=='ALL_CORPORATE'){
st_crp=null;
i_crp=null;
ps_v_crp=null;
data_allcrp.clear();
crp_all_chart= [select count(id) xyz_crp,  Attendee_Summary__r.As_NAICSCode_1__c  abc_crp from User_Profile_Event__c Where
 Ev_id__c =: eventSelected 
AND MAtchMakingProfile__c = 'Corporate'
AND Attendee_Summary__c != null Group By Attendee_Summary__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC
];
}else if(selectedValAs=='Corporate_No_Match'){
st_crp=null;
i_crp=null;
ps_v_crp=null;
data_allcrp.clear();
crp_all_chart= [select count(id) xyz_crp,  Attendee_Summary__r.As_NAICSCode_1__c  abc_crp from User_Profile_Event__c Where
 Ev_id__c =: eventSelected 
AND MAtchMakingProfile__c = 'Corporate'
AND ID IN:all_crp_sel_eve
AND Attendee_Summary__c != null Group By Attendee_Summary__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC
];


}

     for (AggregateResult ar_cr : crp_all_chart){
         i_crp=integer.valueof(ar_cr.get('xyz_crp'));
        
         st_crp=string.valueof(ar_cr.get('abc_crp'));
         if(st_crp !=null){
            st_crp=st_crp.mid(0,63);
            }
         
        if(String.isBlank(st_crp)){
       
        st_crp='Other';
        }
          ps_v_crp=st_crp+'  '+((i_crp/totalrec_allcrp)*100).setScale(2, RoundingMode.HALF_UP)+'%';
       // system.debug('****'+ps_v_crp);
        temp_cdata_allmbe.add(new PieWedgeData(st_crp,i_crp,ps_v_crp));
        }
 /*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      data_allcrp.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((totalrec_allcrp-top_rec));
temp_pval= 'Other'+'  '+((other_rec/totalrec_allcrp)*100).setScale(2, RoundingMode.HALF_UP)+'%';
data_allcrp.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 data_allcrp.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/
 
     return data_allcrp;
 }catch(exception ex){ return null;} 

}
/****************************end of all corporate chart********************/
/*************************** all MBE Method***********************/
public void allmbemd(){
if(selectedValAs=='ALL_MBE' && event_name.Is_Webank_event__c==false){
totalrec_allmbe=null;
 all_mbe_sel_eve=new list<Event_Attendee_Mapping__c>();
 all_mbe_sel_eve_LL = new LIST<LIST<Event_Attendee_Mapping__c>>();
  all_mbe_sel_eve =  [select id,AS_id__r.AS_Company__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Email__c,AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.As_NAICSCode_1__c  from Event_Attendee_Mapping__c Where 
                      Ev_id__c =: eventSelected 
                      AND AS_id__c != null
                         AND IsMatchMakingAttendee__c =: TRUE 
                         AND Boothleads_Profile__c =: 'Attendee'
                       Order BY AS_id__r.AS_PrimaryBusinessCategory1__c
                       ];

/**************List of List*****************************/

 

 LIST<Event_Attendee_Mapping__c> all_mbe_sel_eve_999= new LIST<Event_Attendee_Mapping__c>(); 
        for(Event_Attendee_Mapping__c allmbeseleve: all_mbe_sel_eve){

            all_mbe_sel_eve_999.add(allmbeseleve);

            if(all_mbe_sel_eve_999.size() == 999){

                all_mbe_sel_eve_LL.add(all_mbe_sel_eve_999);

                all_mbe_sel_eve_999 = new LIST<Event_Attendee_Mapping__c>();
            }
        }  
        if(all_mbe_sel_eve_999.size() != 0){

            all_mbe_sel_eve_LL.add(all_mbe_sel_eve_999);    
    
        }     



/***************end of List of List****************************/
//system.debug('%%%%%ttt'+all_mbe_sel_eve.size());

totalrec_allmbe=all_mbe_sel_eve.size();

}else if(selectedValAs=='MBE_No_Match' && event_name.Is_Webank_event__c==false){

totalrec_allmbe=null;
list<Event_Attendee_Mapping__c> all_mbe_sel_eve1=new list<Event_Attendee_Mapping__c>();
 all_mbe_sel_eve=new list<Event_Attendee_Mapping__c>();
 all_mbe_sel_eve_LL = new LIST<LIST<Event_Attendee_Mapping__c>>();
  all_mbe_sel_eve1 =  [select id,AS_id__r.AS_Company__c,AS_id__r.AS_FirstName__c,(select id,name,MM_Slot_Status__c  from EventSchedule__r),AS_id__r.AS_LastName__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Email__c,AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.As_NAICSCode_1__c  from Event_Attendee_Mapping__c Where 
                      Ev_id__c =: eventSelected 
                      AND AS_id__c != null
                         AND IsMatchMakingAttendee__c =: TRUE 
                         AND Boothleads_Profile__c =: 'Attendee'
                       Order BY AS_id__r.AS_PrimaryBusinessCategory1__c
                       ];
set<id> stdidmbe=new set<id>();
set<id> mbestdid=new set<id>();
//system.debug('$$$$$allrec'+all_mbe_sel_eve1 );
for(Event_Attendee_Mapping__c bdd_mbe:all_mbe_sel_eve1 ){
list<EventSchedule__c> ab_evesced_mbe=new list<EventSchedule__c>();
ab_evesced_mbe=bdd_mbe.EventSchedule__r;

for(EventSchedule__c eesmb:ab_evesced_mbe){
if(eesmb.MM_Slot_Status__c =='Accepted' || eesmb.MM_Slot_Status__c =='Pending'){
mbestdid.add(bdd_mbe.id);
//system.debug('&&&&aa'+mbestdid);
}
}

for(EventSchedule__c eesmb:ab_evesced_mbe){
if((eesmb.MM_Slot_Status__c !='Accepted' || eesmb.MM_Slot_Status__c !='Pending') && (eesmb.MM_Slot_Status__c == 'Cancelled' || eesmb.MM_Slot_Status__c == 'Rejected' )){
    if(!stdidmbe.contains(bdd_mbe.id)){
        if(!(mbestdid.contains(bdd_mbe.id))){
           all_mbe_sel_eve.add(bdd_mbe);
           }
        stdidmbe.add(bdd_mbe.id);
        }

}
}

if(ab_evesced_mbe.size()==0){
all_mbe_sel_eve.add(bdd_mbe);
} 
}

//system.debug('%%%%%ttt'+all_mbe_sel_eve.size());

/**************List of List*****************************/

 

 LIST<Event_Attendee_Mapping__c> all_mbe_sel_eve_999= new LIST<Event_Attendee_Mapping__c>(); 
        for(Event_Attendee_Mapping__c allmbeseleve: all_mbe_sel_eve){

            all_mbe_sel_eve_999.add(allmbeseleve);

            if(all_mbe_sel_eve_999.size() == 999){

                all_mbe_sel_eve_LL.add(all_mbe_sel_eve_999);

                all_mbe_sel_eve_999 = new LIST<Event_Attendee_Mapping__c>();
            }
        }  
        if(all_mbe_sel_eve_999.size() != 0){

            all_mbe_sel_eve_LL.add(all_mbe_sel_eve_999);    
    
        }     



/***************end of List of List****************************/







totalrec_allmbe=all_mbe_sel_eve.size();

}
}

/**************************End of all MBE Method******************************/
/************************start of all MBE chart *****************************/
public List<PieWedgeData> getpieData_allmbe(){
 string st_mbe;
        integer i_mbe;
        string ps_v_mbe;
 
 List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
  List<PieWedgeData> data_allmbe= new List<PieWedgeData>();
 list<AggregateResult> mbe_all_chart=new list<AggregateResult>();
 try{
if(selectedValAs=='ALL_MBE' && event_name.Is_Webank_event__c==false){
st_mbe=null;
i_mbe=null;
ps_v_mbe=null;
data_allmbe.clear();

mbe_all_chart= [select count(id) xyz_mbe,  AS_id__r.As_NAICSCode_1__c   abc_mbe from Event_Attendee_Mapping__c Where
 Ev_id__c =: eventSelected 
 AND AS_id__c != null
 AND IsMatchMakingAttendee__c =: TRUE 
 AND Boothleads_Profile__c =: 'Attendee'
 Group By AS_id__r.As_NAICSCode_1__c
 ORDER BY COUNT(Id) DESC
];
}else if(selectedValAs=='MBE_No_Match' && event_name.Is_Webank_event__c==false){
st_mbe=null;
i_mbe=null;
ps_v_mbe=null;
data_allmbe.clear();

mbe_all_chart= [select count(id) xyz_mbe,  AS_id__r.As_NAICSCode_1__c   abc_mbe from Event_Attendee_Mapping__c Where
 Ev_id__c =: eventSelected 
 AND AS_id__c != null
 AND ID IN : all_mbe_sel_eve
 AND IsMatchMakingAttendee__c =: TRUE 
 AND Boothleads_Profile__c =: 'Attendee'
 Group By AS_id__r.As_NAICSCode_1__c
 ORDER BY COUNT(Id) DESC
];


}
     for (AggregateResult ar_mb : mbe_all_chart){
         i_mbe=integer.valueof(ar_mb.get('xyz_mbe'));
        
         st_mbe=string.valueof(ar_mb.get('abc_mbe'));
         if(st_mbe !=null){
            st_mbe=st_mbe.mid(0,63);
            }
         
        if(String.isBlank(st_mbe)){
       
        st_mbe='Other';
        }
          ps_v_mbe=st_mbe+'  '+((i_mbe/totalrec_allmbe)*100).setScale(2, RoundingMode.HALF_UP)+'%';
       // system.debug('****'+ps_v_mbe);
        temp_cdata_allmbe.add(new PieWedgeData(st_mbe,i_mbe,ps_v_mbe));
        }
 
 /*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      data_allmbe.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((totalrec_allmbe-top_rec));
temp_pval= 'Other'+'  '+((other_rec/totalrec_allmbe)*100).setScale(2, RoundingMode.HALF_UP)+'%';
data_allmbe.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 data_allmbe.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/
 
 
     return data_allmbe;
 }catch(exception ex){ return null;} 



}
/**************************End of all MBE chart***************************/
/***************************corporate mbe primary industry method*******************/
public void crp_mbe_industry_md(){
 my_eve_industrty=new list<EventSchedule__c>();
 my_eve_industrty_final=new list<EventSchedule__c>();
 my_eve_industrty_final_LL = new LIST<LIST<EventSchedule__c>>();
 if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){
  my_eve_industrty=  [select id, MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.IsMatchMakingUser__c,MM_To_UPE__r.MAtchMakingProfile__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c from EventSchedule__c Where 
                      Ev_id__c =: eventSelected 
                       AND Is_Matchmaking__c = true 
                       AND MM_To_EAM__c != null
                       AND MM_To_UPE__c != null
                       AND MM_To_EAM__r.AS_id__c != null
                       AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
                       AND MM_To_UPE__r.Attendee_Summary__c != null 
                       Order BY MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c
                       ];
 for(EventSchedule__c evsched: my_eve_industrty){                     
if(evsched.MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c == evsched.MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c){
my_eve_industrty_final.add(evsched);
}
}

/**********************List of List ************************/
 
 

 LIST<EventSchedule__c> my_eve_industrty_final_999= new LIST<EventSchedule__c>(); 
        for(EventSchedule__c myeveindustrtyfinal: my_eve_industrty_final){

            my_eve_industrty_final_999.add(myeveindustrtyfinal);

            if(my_eve_industrty_final_999.size() == 999){

                my_eve_industrty_final_LL.add(my_eve_industrty_final_999);

                my_eve_industrty_final_999 = new LIST<EventSchedule__c>();
            }
        }  
        if(my_eve_industrty_final_999.size() != 0){

            my_eve_industrty_final_LL.add(my_eve_industrty_final_999);    
    
        }      




/**********************end of List of List ***************/
totalreccrpmbe_ind=my_eve_industrty_final.size();
}
}
/***********************End of corporate mbe primary industry method************************/
/***********************corporate mbe primary industry chart*****************************/
public List<PieWedgeData> getcrpmbeindustrychart_md(){
 datae= new List<PieWedgeData>();
  List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
list<AggregateResult> crpmbe_chrt=new list<AggregateResult>();

try{

if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){
crpmbe_chrt= [select   count(id) xyzcrpmbe_ind,   MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c  abccrpmbe_ind, MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c  efghcrpmbe_ind  from EventSchedule__c  Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND MM_To_EAM__r.AS_id__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
//AND MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c IN : corp_naic_set
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c =: MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c
AND MM_To_UPE__r.Attendee_Summary__c != null 
Group By MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c
ORDER BY COUNT(Id) DESC

];
//system.debug('sagar'+crpmbe_chrt);
}
 
        string ste;
        integer ie;
        string ps_ve;
        integer je=0;
        string stde;
        string   ps_v1e;
        integer xe;
        xe=2;
        for (AggregateResult aree : crpmbe_chrt){
        /*******************************************/
        
        if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){
        
        
           if(string.valueof(aree.get('abccrpmbe_ind'))==string.valueof(aree.get('efghcrpmbe_ind'))){
          // system.debug('sagar2'+aree);
            ie=integer.valueof(aree.get('xyzcrpmbe_ind'));
            ste=string.valueof(aree.get('abccrpmbe_ind'));
            if(ste !=null){
            ste=ste.mid(0,63);
            }
            
            if(String.isBlank(ste)){
                   ste='Other';
            }
            ps_ve=ste+'  '+((ie/totalreccrpmbe_ind)*100).setScale(2, RoundingMode.HALF_UP)+'%';
            
            temp_cdata_allmbe.add(new PieWedgeData(ste,ie,ps_ve));
            
        }
     
     
      
        }
 
 
 
 xe++;
        
        }
        
/*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      datae.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((totalreccrpmbe_ind-top_rec));
temp_pval= 'Other'+'  '+((other_rec/totalreccrpmbe_ind)*100).setScale(2, RoundingMode.HALF_UP)+'%';
datae.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 datae.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/ 
// system.debug('sagardata'+datae);
 
return datae;
}catch(exception ex){ return null;} 
}
/************************End of corporate mbe primary industry chart*******************/
/*******************************************custom event chart1******************************/

  public List<PieWedgeData> getcustomPieData() {
     
     try{
         cudata= new List<PieWedgeData>();
        List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
        list<AggregateResult> customutilizationchart=new list<AggregateResult>();

if(selectedValAs=='Corporate_primary_NAICS_code'){
customutilizationchart= [select count(id) xyz,  MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c  abc from EventSchedule__c Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
AND MM_To_EAM__r.MBE_Profile__c != null
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
AND MM_To_UPE__r.Attendee_Summary__c != null Group By MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC

];

//system.debug('$$$$$$$$$$$$$$$$$'+customutilizationchart.size());
//system.debug('test2@@@'+customutilizationchart);
}
else if(selectedValAs=='MBE_primary_NAICS_code'){
customutilizationchart= [select count(id) xyz,  MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c  abc from EventSchedule__c Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
AND MM_To_EAM__r.MBE_Profile__c != null
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
AND MM_To_UPE__r.Attendee_Summary__c != null Group By MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC ];
        //system.debug('$$$$$$$$$$$$$$$$$&&&'+customutilizationchart.size());
        //system.debug('test2@@@'+customutilizationchart);
 }       
/*************************************************/
else if(selectedValAs=='Corporate_AND_MBE_primary_NAICS_code'){


customutilizationchart= [select   count(id) xyz,   MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c  abc, MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c  efgh  from EventSchedule__c  Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND MM_To_EAM__r.MBE_Profile__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
//AND MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c IN : corp_naic_set
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c =: MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c
AND MM_To_UPE__r.Attendee_Summary__c != null 
Group By MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c
ORDER BY COUNT(Id) DESC

];



//system.debug('utilizationchartsagar === '+customutilizationchart);


 }    





/*************************************************/        
 // system.debug('list@@@@'+my_eve_cust.size());      
//system.debug('%%%%%'+customutilizationchart);       
//system.debug('####'+customutilizationchart.size());
//system.debug('$$$'+customtotalrec);

        string cust;
        integer cui;
        string cups_v;
        integer cuj=0;
        string custd;
        string   cups_v1;
        integer cux;
        cux=1;
        for (AggregateResult custar : customutilizationchart){
        /*******************************************/
        if(selectedValAs=='Corporate_AND_MBE_primary_NAICS_code'){
        
           if(string.valueof(custar.get('abc'))==string.valueof(custar.get('efgh')) && string.valueof(custar.get('abc')) !=null){
           
            cui=integer.valueof(custar.get('xyz'));
            cust=string.valueof(custar.get('abc'));
            if(cust !=null){
            cust=cust.mid(0,63);
            }
            
            cups_v=cust+'  '+((cui/customtotalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
            temp_cdata_allmbe.add(new PieWedgeData(cust,cui,cups_v));
        }
     else{
         
        custd='Other';
        
        cui=integer.valueof(custar.get('xyz'));
        cuj=cui+cuj;
        //system.debug('eeeeeeeeeeee'+cuj);
         cups_v1=custd+'  '+((cuj/customtotalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
        // system.debug('rajeshchek1'+cux);
        // system.debug('rajeshchek_totoalrec'+customutilizationchart.size());
         if(cux==customutilizationchart.size()){
        // system.debug('rajeshchek'+cux);
       //  system.debug('goodbbb'+custd);
          temp_cdata_allmbe.add(new PieWedgeData(custd,cuj,cups_v1));
          }
      } 
     
      
        }
       else{
       
       // system.debug('@@'+custar.get('abc'));
       // system.debug('@@'+custar.get('xyz'));
         cui=integer.valueof(custar.get('xyz'));
        
         cust=string.valueof(custar.get('abc'));
         
        if(cust !=null){
            cust=cust.mid(0,63);
        }
        if(String.isBlank(cust)){
       
        cust='Other';
        }
          cups_v=cust+'  '+((cui/customtotalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
     //   system.debug('****'+cups_v);
        temp_cdata_allmbe.add(new PieWedgeData(cust,cui,cups_v));
        }
        
        cux++;
        
        }
        
        
/*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      cudata.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((customtotalrec-top_rec));
temp_pval= 'Other'+'  '+((other_rec/customtotalrec)*100).setScale(2, RoundingMode.HALF_UP)+'%';
cudata.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 cudata.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/
       // system.debug('piedata%%%'+cudata);
        return cudata;
       }catch(exception ex){ return null;} 
    }



/******************************************end of cutom event chart*************************/
/***************************custom event corporate mbe primary industry method*******************/
public void custcrp_mbe_industry_md(){
 custmy_eve_industrty=new list<EventSchedule__c>();
 custmy_eve_industrty_final=new list<EventSchedule__c>();
 custmy_eve_industrty_final_LL = new LIST<LIST<EventSchedule__c>>();
 if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){
  custmy_eve_industrty=  [select id, MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.IsMatchMakingUser__c,MM_To_UPE__r.MAtchMakingProfile__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c from EventSchedule__c Where 
                      Ev_id__c =: eventSelected 
                       AND Is_Matchmaking__c = true 
                       AND MM_To_EAM__c != null
                       AND MM_To_UPE__c != null
                       AND MM_To_EAM__r.MBE_Profile__c != null
                       AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
                       AND MM_To_UPE__r.Attendee_Summary__c != null 
                       Order BY MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c
                       ];
 for(EventSchedule__c cuevsched: custmy_eve_industrty){                     
if(cuevsched.MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c == cuevsched.MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c){
custmy_eve_industrty_final.add(cuevsched);
}
}
/*****************List of List ******************************/




 LIST<EventSchedule__c> custmy_eve_industrty_final_999= new LIST<EventSchedule__c>(); 
        for(EventSchedule__c custmyeveindustrtyfinal: custmy_eve_industrty_final){

            custmy_eve_industrty_final_999.add(custmyeveindustrtyfinal);

            if(custmy_eve_industrty_final_999.size() == 999){

                custmy_eve_industrty_final_LL.add(custmy_eve_industrty_final_999);

                custmy_eve_industrty_final_999 = new LIST<EventSchedule__c>();
            }
        }  
        if(custmy_eve_industrty_final_999.size() != 0){

            custmy_eve_industrty_final_LL.add(custmy_eve_industrty_final_999);    
    
        }      


/****************End of List of List ***********************/


custtotalreccrpmbe_ind=custmy_eve_industrty_final.size();
}
}
/***********************End of custom event corporate mbe primary industry method************************/
/***********************custom event corporate mbe primary industry chart*****************************/
public List<PieWedgeData> getcustcrpmbeindustrychart_md(){
 custdatae= new List<PieWedgeData>();
 List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
list<AggregateResult> custcrpmbe_chrt=new list<AggregateResult>();

try{

if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){
custcrpmbe_chrt= [select   count(id) cxyzcrpmbe_ind,   MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c  cabccrpmbe_ind, MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c  cefghcrpmbe_ind  from EventSchedule__c  Where
 Ev_id__c =: eventSelected 
AND Is_Matchmaking__c = true
AND MM_To_EAM__c != null
AND MM_To_UPE__c != null
AND MM_To_EAM__r.MBE_Profile__c != null
AND (  MM_Slot_Status__c='Accepted' OR MM_Slot_Status__c='Pending')
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c != null
//AND MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c IN : corp_naic_set
//AND MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c =: MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c
AND MM_To_UPE__r.Attendee_Summary__c != null 
Group By MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c
ORDER BY COUNT(Id) DESC

];
//system.debug('sagar'+custcrpmbe_chrt);
}
 
        string aste;
        integer aie;
        string aps_ve;
        integer aje=0;
        string astde;
        string   aps_v1e;
        integer axe;
        axe=2;
        for (AggregateResult aaree : custcrpmbe_chrt){
        /*******************************************/
        
        if(selectedValAs=='Corporate_And_MBE_Primari_industry_Group'){
        
        
           if(string.valueof(aaree.get('cabccrpmbe_ind'))==string.valueof(aaree.get('cefghcrpmbe_ind'))){
          // system.debug('sagar2'+aaree);
            aie=integer.valueof(aaree.get('cxyzcrpmbe_ind'));
            aste=string.valueof(aaree.get('cabccrpmbe_ind'));
            if(aste !=null){
            aste=aste.mid(0,63);
            }
            
            if(String.isBlank(aste)){
                   aste='Other';
            }
            aps_ve=aste+'  '+((aie/custtotalreccrpmbe_ind)*100).setScale(2, RoundingMode.HALF_UP)+'%';
            
            temp_cdata_allmbe.add(new PieWedgeData(aste,aie,aps_ve));
            
        }
     
     
      
        }
 
 
 
 axe++;
        
        }
        
        
/*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      custdatae.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((custtotalreccrpmbe_ind-top_rec));
temp_pval= 'Other'+'  '+((other_rec/custtotalreccrpmbe_ind)*100).setScale(2, RoundingMode.HALF_UP)+'%';
custdatae.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 custdatae.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/ 
 //system.debug('sagardata'+custdatae);
 
return custdatae;
}catch(exception ex){ return null;} 
}
/************************End of custom event corporate mbe primary industry chart*******************/
/***************************custom all MBE Method***********************/
public void customallmbemd(){
if(selectedValAs=='ALL_MBE' && event_name.Is_Webank_event__c==true){
cstotalrec_allmbe=null;
 csall_mbe_sel_eve=new list<Event_Attendee_Mapping__c>();
 csall_mbe_sel_eve_LL = new LIST<LIST<Event_Attendee_Mapping__c>>();
  csall_mbe_sel_eve =  [select id,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_WorkPhone__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MBE_Profile__r.As_NAICSCode_1__c  from Event_Attendee_Mapping__c Where 
                      Ev_id__c =: eventSelected 
                      AND MBE_Profile__c != null
                         AND IsMatchMakingAttendee__c =: TRUE 
                         AND Boothleads_Profile__c =: 'Attendee'
                       Order BY MBE_Profile__r.AS_PrimaryBusinessCategory1__c
                       ];



//system.debug('%%%%%ttt'+csall_mbe_sel_eve.size());
/***************************List of List ****************************/



 LIST<Event_Attendee_Mapping__c> csall_mbe_sel_eve_999= new LIST<Event_Attendee_Mapping__c>(); 
        for(Event_Attendee_Mapping__c csallmbeseleve: csall_mbe_sel_eve){

            csall_mbe_sel_eve_999.add(csallmbeseleve);

            if(csall_mbe_sel_eve_999.size() == 999){

                csall_mbe_sel_eve_LL.add(csall_mbe_sel_eve_999);

                csall_mbe_sel_eve_999 = new LIST<Event_Attendee_Mapping__c>();
            }
        }  
        if(csall_mbe_sel_eve_999.size() != 0){

            csall_mbe_sel_eve_LL.add(csall_mbe_sel_eve_999);    
    
        }    

/************************end of List of List ***********************/
cstotalrec_allmbe=csall_mbe_sel_eve.size();

}else if(selectedValAs=='MBE_No_Match' && event_name.Is_Webank_event__c==true){

cstotalrec_allmbe=null;
list<Event_Attendee_Mapping__c> all_mbe_sel_eve2=new list<Event_Attendee_Mapping__c>();
 csall_mbe_sel_eve=new list<Event_Attendee_Mapping__c>();
  csall_mbe_sel_eve_LL = new LIST<LIST<Event_Attendee_Mapping__c>>();
  all_mbe_sel_eve2 =  [select id,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_FirstName__c,(select id,name,MM_Slot_Status__c  from EventSchedule__r),MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_WorkPhone__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MBE_Profile__r.As_NAICSCode_1__c  from Event_Attendee_Mapping__c Where 
                      Ev_id__c =: eventSelected 
                      AND MBE_Profile__c != null
                         AND IsMatchMakingAttendee__c =: TRUE 
                         AND Boothleads_Profile__c =: 'Attendee'
                       Order BY MBE_Profile__r.AS_PrimaryBusinessCategory1__c
                       ];

set<id> cstmide=new set<id>();
set<id> cstmidacc=new set<id>();
//system.debug('rec@@@@@'+all_mbe_sel_eve2);
for(Event_Attendee_Mapping__c cstbdd_mbe:all_mbe_sel_eve2 ){
list<EventSchedule__c> cstab_evesced_mbe=new list<EventSchedule__c>();
cstab_evesced_mbe=cstbdd_mbe.EventSchedule__r;
/***************************************************/

for(EventSchedule__c csteesmb:cstab_evesced_mbe){
if(csteesmb.MM_Slot_Status__c =='Accepted' || csteesmb.MM_Slot_Status__c =='Pending'){
cstmidacc.add(cstbdd_mbe.id);
//system.debug('&&&&aa'+cstmidacc);
}
}

for(EventSchedule__c csteesmb:cstab_evesced_mbe){
if((csteesmb.MM_Slot_Status__c !='Accepted' || csteesmb.MM_Slot_Status__c !='Pending') && (csteesmb.MM_Slot_Status__c == 'Cancelled' || csteesmb.MM_Slot_Status__c == 'Rejected' )){
    if(!cstmide.contains(cstbdd_mbe.id)){
    
        if(!(cstmidacc.contains(cstbdd_mbe.id))){
           csall_mbe_sel_eve.add(cstbdd_mbe);
           }
           
        cstmide.add(cstbdd_mbe.id);
        }

}
}





/*****************************************************/

if(cstab_evesced_mbe.size()==0){
csall_mbe_sel_eve.add(cstbdd_mbe);
} 
}

//system.debug('%%%%%ttt'+csall_mbe_sel_eve.size());
/***************************List of List ****************************/



 LIST<Event_Attendee_Mapping__c> csall_mbe_sel_eve_999= new LIST<Event_Attendee_Mapping__c>(); 
        for(Event_Attendee_Mapping__c csallmbeseleve: csall_mbe_sel_eve){

            csall_mbe_sel_eve_999.add(csallmbeseleve);

            if(csall_mbe_sel_eve_999.size() == 999){

                csall_mbe_sel_eve_LL.add(csall_mbe_sel_eve_999);

                csall_mbe_sel_eve_999 = new LIST<Event_Attendee_Mapping__c>();
            }
        }  
        if(csall_mbe_sel_eve_999.size() != 0){

            csall_mbe_sel_eve_LL.add(csall_mbe_sel_eve_999);    
    
        }    

/************************end of List of List ***********************/





cstotalrec_allmbe=csall_mbe_sel_eve.size();

}
}

/**************************End of all MBE Method******************************/
/************************start of all MBE chart *****************************/
public List<PieWedgeData> getcustompieData_allmbe(){
 string cst_mbe;
        integer ci_mbe;
        string cps_v_mbe;
 
 
   cdata_allmbe= new List<PieWedgeData>();
 List<PieWedgeData>  temp_cdata_allmbe= new List<PieWedgeData>();
 list<AggregateResult> cmbe_all_chart=new list<AggregateResult>();
 try{
if(selectedValAs=='ALL_MBE' && event_name.Is_Webank_event__c==true){
cst_mbe=null;
ci_mbe=null;
cps_v_mbe=null;
cdata_allmbe.clear();

cmbe_all_chart= [select count(id) cxyz_mbe,  MBE_Profile__r.As_NAICSCode_1__c   cabc_mbe from Event_Attendee_Mapping__c Where
 Ev_id__c =: eventSelected 
 AND MBE_Profile__c != null
 AND IsMatchMakingAttendee__c =: TRUE 
 AND Boothleads_Profile__c =: 'Attendee'
 Group By MBE_Profile__r.As_NAICSCode_1__c
 ORDER BY COUNT(Id) DESC
];
}else if(selectedValAs=='MBE_No_Match' && event_name.Is_Webank_event__c==true){
cst_mbe=null;
ci_mbe=null;
cps_v_mbe=null;
cdata_allmbe.clear();

cmbe_all_chart= [select count(id) cxyz_mbe,  MBE_Profile__r.As_NAICSCode_1__c   cabc_mbe from Event_Attendee_Mapping__c Where
 Ev_id__c =: eventSelected 
 AND MBE_Profile__c != null
 AND ID IN : csall_mbe_sel_eve
 AND IsMatchMakingAttendee__c =: TRUE 
 AND Boothleads_Profile__c =: 'Attendee'
 Group By MBE_Profile__r.As_NAICSCode_1__c
 ORDER BY COUNT(Id) DESC
];

//system.debug('888***'+cmbe_all_chart);

}
     for (AggregateResult car_mb : cmbe_all_chart){
         ci_mbe=integer.valueof(car_mb.get('cxyz_mbe'));
        
         cst_mbe=string.valueof(car_mb.get('cabc_mbe'));
          if(cst_mbe !=null){
            cst_mbe=cst_mbe.mid(0,63);
            }
         
        if(String.isBlank(cst_mbe)){
       
        cst_mbe='Other';
        }
          cps_v_mbe=cst_mbe+'  '+((ci_mbe/cstotalrec_allmbe)*100).setScale(2, RoundingMode.HALF_UP)+'%';
 //       system.debug('****'+cps_v_mbe);
        
        temp_cdata_allmbe.add(new PieWedgeData(cst_mbe,ci_mbe,cps_v_mbe));
        }
 /*********************************edited to restrict to show top 10 records****************************/
 
 integer r;
 integer top_rec;
 string temp_pval;
 r=0;
 top_rec=0;
 temp_pval=null;
 
if(temp_cdata_allmbe.size()>10){
 for(PieWedgeData tmp_pi:temp_cdata_allmbe)
 {
     if((r<10)&&tmp_pi.name!='Other'){
      top_rec=integer.valueof(tmp_pi.data)+top_rec;
      cdata_allmbe.add(tmp_pi);
          }
     r++;
 
 }
 
integer other_rec=integer.valueof((cstotalrec_allmbe-top_rec));
temp_pval= 'Other'+'  '+((other_rec/cstotalrec_allmbe)*100).setScale(2, RoundingMode.HALF_UP)+'%';
cdata_allmbe.add(new PieWedgeData('Other',other_rec,temp_pval));
 }
 else{
 
 cdata_allmbe.addall(temp_cdata_allmbe);
 }
 /********************************end of edited code***************************/
 
     return cdata_allmbe;
 }catch(exception ex){ return null;} 



}
/**************************End of all MBE chart***************************/






    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public Integer data { get; set; }
        public string percent_val{get;set;}
        public PieWedgeData(String name, Integer data,string percent_val) {
            this.name = name;
            this.data = data;
            this.percent_val=percent_val;
        }
    }
 
  

}
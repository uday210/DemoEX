global class BLN_UpdateSchedulerRecordCon {

    public PageReference save() {
    Map<String,String> tikcetidcountrymap=new Map<String,String>();
     Map<String,String> tikcetidstatemap=new Map<String,String>();
     
   List<BLN_ExceptionCountryState__c > exlist=new List<BLN_ExceptionCountryState__c >();
    for(integer i=0;i<ecslist.size();i++)
    {
      List<string> s=ecslist[i].ticketids.split(',');
      for(integer j=0;j<s.size();j++)
      {
         tikcetidcountrymap.put(s[j],ecslist[i].OutputCountry);
         
         if(ecslist[i].OutputState!=null&&ecslist[i].OutputState!='')
         tikcetidstatemap.put(s[j],ecslist[i].OutputState);
      }
      
      List<string> s1=ecslist[i].excepids.split(',');
      for(integer j=0;j<s1.size();j++)
      {
        BLN_ExceptionCountryState__c  e=new BLN_ExceptionCountryState__c(id=s1[j],OutputCountry__c=ecslist[i].OutputCountry,schedulerupdated__c=true);
        if(ecslist[i].OutputState!=null&&ecslist[i].OutputState!='')
         e.OutputState__c=ecslist[i].OutputState;
        
        exlist.add(e); 
      }
    
   }
   
   List<Ticket__c> tclist=[select id,name,tkt_profile__r.Work_Address__r.id from Ticket__c where id in:tikcetidcountrymap.keyset()];
   List<BLN_Address__c > bllist=new List<BLN_Address__c >();
   
   List<BLN_Address__c > bllistcreate=new List<BLN_Address__c >();
   for(Ticket__c tc:tclist)
   {
   BLN_Address__c bl;
   if(tc.tkt_profile__r.Work_Address__r.id!=null){
   if(tikcetidstatemap.get(tc.id)==null)
      bl=new BLN_Address__c(id=tc.tkt_profile__r.Work_Address__r.id,Country__c=tikcetidcountrymap.get(tc.id));
      else
       bl=new BLN_Address__c(id=tc.tkt_profile__r.Work_Address__r.id,Country__c=tikcetidcountrymap.get(tc.id),State__c=tikcetidstatemap.get(tc.id));
      bllist.add(bl);
      }
      else
      {
       //handle if tickets does not have workaddress record
      }
   }
   
   update bllist;
   
   update exlist;
   PageReference pg=new Pagereference('/apex/BLN_UpdateSchedulerRecord?id='+apexpages.currentpage().getparameters().get('id'));
   pg.setRedirect(true);
        return pg;
    }

public  LIST<SelectOption> countryOptions{get;set;}
public string selectedcountry{get;set;}
public  LIST<State__c>   statelist{get;set;}
 public class ExceptionCountryState
   {
     public String InputCountry{get;set;}
     public String InputState{get;set;}
     public String OutputCountry{get;set;}
     public String OutputState{get;set;}
     public String ticketids{get;set;}
     public String excepids{get;set;}
     public boolean outputstatenotneeded{get;set;}
     
   }
   public List<ExceptionCountryState> ecslist{get;set;}
public BLN_UpdateSchedulerRecordCon()
{
BLN_event__c eve=[select id,name from bln_event__c where id=:apexpages.currentpage().getparameters().get('id')];
eventname=eve.name;
  ecslist=new List<ExceptionCountryState>();
  Map<String,ExceptionCountryState> ecslistmap=new Map<String,ExceptionCountryState>();
   for(BLN_ExceptionCountryState__c ecc:[select id,name,InputCountry__c,InputState__c,BLN_Events__c,BLN_Ticket__c from BLN_ExceptionCountryState__c where BLN_Events__c=:apexpages.currentpage().getparameters().get('id') and BLN_Ticket__c!=null and schedulerupdated__c=false])
   {
                   
                 
                  if(!ecslistmap.containskey(ecc.InputCountry__c+ecc.InputState__c)){
                  ExceptionCountryState ec=new ExceptionCountryState();
                  ec.InputCountry=ecc.InputCountry__c;
                  ec.InputState=ecc.InputState__c;
                  ec.ticketids=ecc.BLN_Ticket__c;
                  ec.excepids=ecc.id;
                  if(ecc.InputState__c==null)
                  ec.outputstatenotneeded=true;
                 ecslistmap.put(ecc.InputCountry__c+ecc.InputState__c,ec);
                  }
                  else
                  {
                     ExceptionCountryState ec=new ExceptionCountryState();
                     ec=ecslistmap.get(ecc.InputCountry__c+ecc.InputState__c);
                     ec.ticketids=ecc.BLN_Ticket__c+','+ec.ticketids;
                     ec.excepids=ecc.id+','+ec.excepids;
                     ecslistmap.put(ecc.InputCountry__c+ecc.InputState__c,ec);
                  }
   }
   ecslist=ecslistmap.values();
   
 try{getcoutries();}catch(Exception e){}            
} 
public String eventname{get;set;}
public void getcoutries(){
  countryOptions= new LIST<SelectOption>();
     BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
    
     
     countryOptions = bcd.countryStatesforprofile();
     if(countryOptions.size()>0){
     countryOptions.remove(0); 
      string usaid= BLN_CountryState_DAO.getusacountryid(apexpages.currentpage().getparameters().get('id'));
      if(usaid!=null){
      selectedcountry  = usaid;
      }else{
      selectedcountry  = countryOptions[0].getValue();
      }
     statelist = new LIST<State__c> ();  
     statelist = BLN_CountryState_DAO.statesBasedOnCountry(selectedcountry); 
     }
}
@RemoteAction
  Global  static List<SObject> statesBasedOnCountry(String country) {
    //eventCurrency =  Currencies;
    return [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__r.Long_Name__c,Country__r.Short_Name__c, Country__c FROM State__c WHERE Country__c = : country];
  }
}
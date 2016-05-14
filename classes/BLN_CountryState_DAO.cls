Global with sharing class BLN_CountryState_DAO {
    
    Global  LIST<SelectOption> countryStates(string EventId){ 
      LIST<BLN_Event_Countries_Include__c> country = new LIST<BLN_Event_Countries_Include__c>();
       LIST<SelectOption> countryOptionsinclude = new LIST<SelectOption>();
        countryOptionsinclude.add(new SelectOption('', ''));
        
        for(BLN_Event_Countries_Include__c c: [SELECT ID, NAME, BLN_Country__r.Short_Name__c, BLN_Country__r.Long_Name__c, BLN_Country__r.Order__c,BLN_Event__c FROM BLN_Event_Countries_Include__c where BLN_Event__c=:EventId ORDER BY BLN_Country__r.Order__c]){
            countryOptionsinclude.add(new SelectOption(c.BLN_Country__r.id, c.BLN_Country__r.Long_Name__c));           
        }
        system.debug('CCCCCCCCC1'+countryOptionsinclude);
        return countryOptionsinclude;  
    }
    
     Global  LIST<SelectOption> statesBasedOnCountry(LIST<SelectOption> countryOptions){
            
       LIST<SelectOption>  stateOptions= new LIST<SelectOption>(); 
        String sel='';
        For(SelectOption so : countryOptions)
          sel=sel+so.getValue()+',';  
        stateOptions.add(new SelectOption('',''));
        integer i=0;
        for(State__c s: [SELECT ID, NAME, Short_Name__c,Long_Name__c, Country__c, Order__c FROM State__c ]){
            if(sel.indexOf(s.Country__c)!=-1){               
            stateOptions.add(new SelectOption(s.id,s.Short_Name__c+'-'+s.Long_Name__c));                    
            i++;
            
            }
            if(i== 999)
            break;
        }
         system.debug('CCCCCCCCC1'+stateOptions);
        return stateOptions;
    }
     @RemoteAction
  Global  static List<SObject> statesBasedOnCountry(String country) {
    //eventCurrency =  Currencies;
    return [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__r.Long_Name__c,Country__r.Short_Name__c, Country__c FROM State__c WHERE Country__c = : country];
  }
  public static string getusacountryid(string EventId){
  list<BLN_Event_Countries_Include__c> evecountryusa=new list<BLN_Event_Countries_Include__c>();
   evecountryusa = [SELECT ID, NAME, BLN_Country__r.Short_Name__c, BLN_Country__r.Long_Name__c, BLN_Country__r.Order__c,BLN_Event__c FROM BLN_Event_Countries_Include__c where BLN_Event__c=:EventId AND BLN_Country__r.Long_Name__c=:'United States Of America' ORDER BY BLN_Country__r.Order__c LIMIT 1];
   if(evecountryusa.size()>0){
   return evecountryusa[0].BLN_Country__c;
   }else{
   return null;
   }
  }
    
   Global LIST<SelectOption> countryStatesforprofile(){  
    LIST<SelectOption> countryOptions = new LIST<SelectOption>();       
            countryOptions.add(new SelectOption('', ''));
         
               for(Country__c c: [SELECT ID, NAME, Short_Name__c, Long_Name__c, Order__c FROM Country__c ORDER BY Order__c]){        
                  countryOptions.add(new SelectOption(c.id, c.Long_Name__c));       
                      
                }   
              return   countryOptions;                
            }
            
        @RemoteAction
  Global  static LIST<SelectOption> statesBasedOnCountryforprofile(String country) {
    //eventCurrency =  Currencies;
    LIST<SelectOption>  stateOptions= new LIST<SelectOption>(); 
    stateOptions.add(new SelectOption('',''));
    for (State__c  s: [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__r.Long_Name__c,Country__r.Short_Name__c, Country__c FROM State__c WHERE Country__c = : country]){
    stateOptions.add(new SelectOption(s.id,s.Short_Name__c+'-'+s.Long_Name__c)); 
    }
    return stateOptions;
  }  
  
  
    
}
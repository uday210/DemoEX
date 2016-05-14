global without sharing class BLN_BatchImportAttendee implements Database.batchable<List<String>>, Database.Stateful
{
   List<List<String>> allFields;
   LIST<BLN_ImportAttendeesCon.header> gridrows;
   public String selecteditem{get;set;}
   public  Map<Id,Map<String,Id>> longstatesparent{get;set;}
   public  Map<Id,Map<String,Id>> shortstatesparent{get;set;}
   public Map<String,Id> longcountries{get;set;}
   public Map<String,Id> shortcountries{get;set;}
   public Set<String> eventincludecountries{get;set;}
   public Map<String,Id> naicscodes{get;set;} 
   public Map<String,Id> diversList{get;set;}
   String mailCSVAttachment;
   public Map<String,Id> commoditiesList{get;set;}
   Integer K;
   public integer recimported{get;set;}
   public integer reccreated{get;set;}
   public integer recfailed{get;set;}
   public MAP<string,id> unDifinedCountryStateIds;
   public Map<String,String> inputcountrymap{get;set;}
   public Map<String,String> inputstatemap{get;set;}
   public Map<String,String> inputstatecountrymap{get;set;}
   public String csvFileName{get;set;}
   public string eventid;
   
    public BLN_BatchImportAttendee(List<List<String>> allFields,LIST<BLN_ImportAttendeesCon.header> gridrows,String selecteditem,String csvFileName){
    this.allFields=allFields;
    this.K = 0;
    recimported=reccreated=recfailed=0;
    this.gridrows=gridrows;
    this.selecteditem=selecteditem;
    longstatesparent=new Map<Id,Map<String,Id>>();
    shortstatesparent=new Map<Id,Map<String,Id>>();
    longcountries=new Map<String,Id>(); 
    shortcountries=new Map<String,Id>(); 
    naicscodes=new Map<String,Id>();
     diversList=new Map<String,Id>();
     this.csvFileName=csvFileName;
      commoditiesList=new Map<String,Id>();
      mailCSVAttachment = '';
      inputcountrymap=new Map<String,String>();
      inputstatemap=new Map<String,String>();
      inputstatecountrymap=new Map<String,String>();
      BLN_Item__c it=[select id,item_name__c,event__c from BLN_Item__c where id=:selecteditem limit 1];
      eventid=it.event__c;
      try{
      eventincludecountries=new Set<String>();
      for(BLN_Event_Countries_Include__c ec:[select id,name,BLN_Country__c,BLN_Event__c from BLN_Event_Countries_Include__c where BLN_Event__c=:it.event__c])
      {
        eventincludecountries.add(ec.BLN_Country__c);  
      }  
      }catch(Exception e){}
      
      
      
      for(integer j=0;j<gridrows.size();j++){
          if(j==0){
          if(gridrows[j].csvheader !=null && gridrows[j].csvheader != ''){
              mailCSVAttachment = mailCSVAttachment + gridrows[j].csvheader;
          }
          }
          else{
            if(gridrows[j].csvheader !=null && gridrows[j].csvheader != ''){
              mailCSVAttachment = mailCSVAttachment + ',' + gridrows[j].csvheader;
          }
      }
      }
      
     mailCSVAttachment = 'Error,'+mailCSVAttachment + '\n';
     try{
            for(State__c state:[SELECT Id, Long_Name__c,Short_Name__c,Country__c  FROM State__c]){
        if(state.Long_Name__c != null && state.Long_Name__c != ''){
      if(longstatesparent.containskey(state.country__c))
      {
      try{
      Map<String,Id> onlystates=new Map<String,Id>();
      onlystates=longstatesparent.get(state.country__c);
      try{onlystates.put(state.Long_Name__c.touppercase(),state.id);}catch(Exception e){}
      longstatesparent.put(state.country__c,onlystates); }catch(Exception e){}
      }
      else{
      try{Map<String,Id> onlystates=new Map<String,Id>();
      try{onlystates.put(state.Long_Name__c.touppercase(),state.id);}catch(Exception e){}
      longstatesparent.put(state.country__c,onlystates);}catch(Exception e){}
      }
      }
      if(state.Short_Name__c != null && state.Short_Name__c != ''){
     
      if(shortstatesparent.containskey(state.country__c))
      {
      try{
      Map<String,Id> onlystates=new Map<String,Id>();
      onlystates=shortstatesparent.get(state.country__c);
      onlystates.put(state.Short_Name__c.touppercase(),state.id);
      shortstatesparent.put(state.country__c,onlystates); }catch(Exception e){}
      }
      else{
      try{Map<String,Id> onlystates=new Map<String,Id>();
      onlystates.put(state.Short_Name__c.touppercase(),state.id);
      shortstatesparent.put(state.country__c,onlystates);}catch(Exception e){}
      }
    }
    }
    }catch(exception ex){}
    
    try{
            for(Country__c country:[SELECT Id, Long_Name__c,Short_Name__c  FROM Country__c]){
    if(country.Long_Name__c != null && country.Long_Name__c != ''){
      longcountries.put(country.Long_Name__c.touppercase(),country.id);
      }
      if(country.Short_Name__c != null && country.Short_Name__c != ''){
      try{shortcountries.put(country.Short_Name__c.touppercase(),country.id);}catch(Exception e){}
    }
    }
    }catch(exception ex){}
    
    
   
   
    try{
            for(NAICS_Code__c naics : [SELECT id,Name,Description__c FROM NAICS_Code__c]){
    if(naics.Description__c != null && naics.Description__c != ''){
     naicscodes.put(naics.Description__c.touppercase(),naics.id);
    }
    }
    }catch(exception ex){}
    
    try{
        for(Diversity__c diver: BLN_Diversity_DAO.getDiversities()){
    if(diver.Name != null && diver.Name != ''){
     diversList.put(diver.Name.touppercase(),diver.id);
    }
    }
    }catch(exception ex){}
    
    try{
            for(BLN_Commodities__c comm: BLN_CompCommodity_DAO.getCommodities()){
    if(comm.Description__c != null && comm.Description__c != ''){
     commoditiesList.put(comm.Description__c.touppercase(),comm.id);
    }
    }
    }catch(exception ex){}
    
   
     unDifinedCountryStateIds = new MAP<string,id>();
    unDifinedCountryStateIds.put('UNDCOUNTRY',Id.valueOf('c1O8A0000000ID0UND'));
    unDifinedCountryStateIds.put('UNDSTATE',Id.valueOf('s1T8A0000000ID0UND'));
     }
     
   global Iterable<List<String>> start(Database.batchableContext batchableContext)
   { 
       
       return new BLN_BatchListIterator(allFields);
   }
   global void execute(Database.BatchableContext batchableContext, List<List<String>> scope)  
   {
   try{
      for(BLN_ExceptionCountryState__c ec:[select id,name,InputCountry__c,InputState__c,OutputCountry__c,OutputState__c,BLN_Events__c from BLN_ExceptionCountryState__c where BLN_Events__c=:eventid and OutputCountry__c!=null])
   {
   if(ec.InputCountry__c!=null&&ec.OutputCountry__c!=null)
   inputcountrymap.put(ec.InputCountry__c.touppercase(),ec.OutputCountry__c);
   if(ec.InputState__c!=null)
   {
   if(inputstatemap.containskey(ec.InputState__c)&&inputstatemap.get(ec.InputState__c)!=null)
   {
     inputstatemap.put(ec.InputState__c.touppercase(),ec.OutputState__c);
   }
   else if(!inputstatemap.containskey(ec.InputState__c))
   inputstatemap.put(ec.InputState__c.touppercase(),ec.OutputState__c);
   }
   
   if(ec.InputCountry__c==null&&ec.InputState__c!=null){
   inputstatecountrymap.put(ec.InputState__c.touppercase(),ec.OutputCountry__c);
   }
   }}catch(Exception e){}
     //TODO: Create a map with the column name and the position.
       List<BLN_Event_Countries_Include__c> neweventincludecountries=new List<BLN_Event_Countries_Include__c>();
       List<Ticket__c> tcid=[select id,Custom_Barcode__c,Event__c,Tag_No__c,Badge_Label__c,name,item__r.id,item__r.Item_Pool__r.id,Item_Type__c,Item__c,Item__r.price__c,Item_Type__r.Item_Type_Number__c,Ticket_Status__c,Item__r.Event__c,Item__r.item_name__c,Item_Type__r.name,item__r.Ticket_Settings__c,Parent_ID__c,Item_Pool__r.Badgable__c,Item_Pool__r.Ticket_Settings__c from Ticket__c where Item__c=:selecteditem and Ticket_Status__c='Available' limit:scope.size()];
       BLN_MyticketsCon ordercon=new BLN_MyticketsCon('load');
        ordercon.isOrderEdit = false;
        BLN_Item_DAO itdao=new BLN_Item_DAO();
        BLN_Item__c  BLNItem=itdao.GetItemDetails(' where id=\''+tcid[0].Item__c+'\'');
        
        //calculating fee
        Decimal fee=0;
        Decimal ticketamount,onlyticketamount,feeamount;
        MAP<id,decimal> mapitemWithFee = new MAP<id,decimal>();
        try{
        Event_Price__c ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c from Event_Price__c where Event__c=:BLNItem.event__c and Item_type__c=:tcid[0].Item_Type__c];
       fee= ((ep.BL_Fee_Percentage__c*tcid[0].Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
       if(tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000010'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000023'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000008'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000003'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000004'||tcid[0].Item_Type__r.Item_Type_Number__c=='IT-000007')
       {
       ep=[select id,name,BL_Fee_Amount__c,BL_Fee_Percentage__c,Event__c,Item_type__c,Item_Type__r.Item_Type_Number__c from Event_Price__c where Event__c=:BLNItem.event__c and Item_Type__r.Item_Type_Number__c='IT-000001'];
       fee= ((ep.BL_Fee_Percentage__c*tcid[0].Item__r.price__c)/100) + ep.BL_Fee_Amount__c;
       }
        }catch(Exception e){}
       
       try{
       if(tcid[0].Item__r.price__c==0){
       ticketamount=0;
       onlyticketamount=0;
       feeamount=0;
        mapitemWithFee.put(tcid[0].Item__c,0);
       }
       else
       {
       ticketamount=tcid[0].Item__r.price__c+fee;
       onlyticketamount=tcid[0].Item__r.price__c;
       feeamount=fee;
        mapitemWithFee.put(tcid[0].Item__c,fee);
        }
        }catch(exception ex){}
     
     
      for(integer i=0;i<scope.size();i++)
      {
           recimported++;
           List<String> eachrowrecord=scope[i];
           Gn_User__c gnu1=new Gn_User__c();
           User newu=new User();
            ordercon.comp=new Company__c();
            ordercon.compext=new Company_Ext__c();
            ordercon.billingaddr=new Pay_Address__c();
            ordercon.mapguIdWithGNU=new MAP<id,GN_User__c>();
            Tkt_Profile__c tktProfileObject= new Tkt_Profile__c();
            BLN_Address__c workAddress=new BLN_Address__c();
            BLN_Address__c homeAddress=new BLN_Address__c();
            String workstatename='',homestatename='';
            boolean workadd=false;
            boolean homeadd=false;
            String selectedNaicsCodes,selectedDiver,selectedCommodities;
            String tagName;
           //Ticket__c tc=new Ticket__c(id=tcid[i].id,Ticket_Status__c='Booked',Item__c=tcid[0].Item__c,Event__c=BLNItem.event__c);
           for(integer j=0;j<gridrows.size();j++)
           {
              if(gridrows[j].field!='')
              {
                  try{
                  if(gridrows[j].field=='Prefix__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                }catch(exception ex){}
                
                
                try{
                  if(gridrows[j].field=='TKT_Job_Title__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='First_Name__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Last_Name__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='TKT_Company__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                    }catch(exception ex){}
                    
                    try{
                  if(gridrows[j].field=='Email__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].tolowercase().trim());
                   }
                       }catch(exception ex){}
                       
                       try{
                  if(gridrows[j].field=='Tag_Name__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tagName=eachrowrecord[j].trim();
                   }
                       }catch(exception ex){}
                       
                       try{
                  if(gridrows[j].field=='WorkAddress1__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  workAddress.put('Address1__c',eachrowrecord[j].unescapeCsv().trim());
                  workadd=true;
                  }
                  }
                      }catch(exception ex){}
                    
                    try{
                  if(gridrows[j].field=='WorkAddress2__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  workAddress.put('Address2__c',eachrowrecord[j].unescapeCsv().trim());
                  workadd=true;
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='HomeAddress1__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  homeAddress.put('Address1__c',eachrowrecord[j].unescapeCsv().trim());
                  homeadd=true;
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='HomeAddress2__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  homeAddress.put('Address2__c',eachrowrecord[j].unescapeCsv().trim());
                  homeadd=true;
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Age__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  try{
                  tktProfileObject.put(gridrows[j].field,Decimal.valueOf(eachrowrecord[j].trim()));
                  }catch(Exception e){}}
                  }
                      }catch(exception ex){}
                      
                      try{
                   if(gridrows[j].field=='Biography__c'){
                   if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                      }catch(exception ex){}
                  
                      try{
                  if(gridrows[j].field=='WorkCity__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  workAddress.put('City__c',eachrowrecord[j].unescapeCsv().trim());
                  workadd=true;
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='WorkCountry__c'){
system.debug('Test1');
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  system.debug('Test2');

                  if(longcountries.get(eachrowrecord[j].touppercase().trim())!=null){
system.debug('Test3');
                  workAddress.put('Country__c',longcountries.get(eachrowrecord[j].touppercase().trim()));
                  try{
                  if(!eventincludecountries.contains(longcountries.get(eachrowrecord[j].touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=longcountries.get(eachrowrecord[j].touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(longcountries.get(eachrowrecord[j].touppercase().trim()));  
                  }
                  }catch(Exception e){}
                  }else{
                         if(shortcountries.get(eachrowrecord[j].touppercase().trim())==null){
                         if(inputcountrymap.containskey(eachrowrecord[j].touppercase().trim()))
                         {
                         workAddress.put('Country__c',inputcountrymap.get(eachrowrecord[j].touppercase().trim()));
                         try{if(!eventincludecountries.contains(inputcountrymap.get(eachrowrecord[j].touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=inputcountrymap.get(eachrowrecord[j].touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(inputcountrymap.get(eachrowrecord[j].touppercase().trim()));  
                  }}catch(Exception e){}
                         }
                         else
                         workAddress.put('Country__c',unDifinedCountryStateIds.get('UNDCOUNTRY'));
                        //   system.debug('y@@@@@@@undcountr'+unDifinedCountryStateIds.get('UNDCOUNTRY'));                       
                        //  string wcountryerrec = geterrec(String.valueOf(eachrowrecord));
                        // mailCSVAttachment = mailCSVAttachment + 'Error: Mandatory Fields Missing: Country'+','+wcountryerrec+'\n';
                        // break;
                         }
                  }
                  
                  if(shortcountries.get(eachrowrecord[j].touppercase().trim())!=null){
system.debug('Test4');
                  workAddress.put('Country__c',shortcountries.get(eachrowrecord[j].touppercase().trim()));
                  try{
                  if(!eventincludecountries.contains(shortcountries.get(eachrowrecord[j].touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=shortcountries.get(eachrowrecord[j].touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(shortcountries.get(eachrowrecord[j].touppercase().trim()));  
                  }
                  }catch(Exception e){}
                  }
                  workadd=true;
                  

                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='HomeCity__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  homeAddress.put('City__c',eachrowrecord[j].unescapeCsv().trim());
                  homeadd=true;
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='HomeCountry__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){

                  if(longcountries.get(eachrowrecord[j].touppercase().trim())!=null){
                  homeAddress.put('Country__c',longcountries.get(eachrowrecord[j].touppercase().trim()));
                  try{
                  if(!eventincludecountries.contains(longcountries.get(eachrowrecord[j].touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=longcountries.get(eachrowrecord[j].touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(longcountries.get(eachrowrecord[j].touppercase().trim()));  
                  }
                  }catch(Exception e){}
                  }else{
                      if(shortcountries.get(eachrowrecord[j].touppercase().trim())==null){
                      if(inputcountrymap.containskey(eachrowrecord[j].touppercase().trim())){
                         homeAddress.put('Country__c',inputcountrymap.get(eachrowrecord[j].touppercase().trim()));
                         try{if(!eventincludecountries.contains(inputcountrymap.get(eachrowrecord[j].touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=inputcountrymap.get(eachrowrecord[j].touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(inputcountrymap.get(eachrowrecord[j].touppercase().trim()));  
                  }}catch(Exception e){}
                         }
                         else
                         homeAddress.put('Country__c',unDifinedCountryStateIds.get('UNDCOUNTRY'));
                        
                  }
                  }
                  if(shortcountries.get(eachrowrecord[j].touppercase().trim())!=null){
                  homeAddress.put('Country__c',shortcountries.get(eachrowrecord[j].touppercase().trim()));
                  try{
                  if(!eventincludecountries.contains(shortcountries.get(eachrowrecord[j].touppercase().trim())))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=shortcountries.get(eachrowrecord[j].touppercase().trim()),BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(shortcountries.get(eachrowrecord[j].touppercase().trim()));  
                  }
                  }catch(Exception e){}
                  }
                  homeadd=true;

                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='DOB__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  Date theDate;
                try {
                      // parse works in the case of 10/11/1983
                      theDate = Date.parse(eachrowrecord[j].trim());
                    }
                    catch(Exception e) {}
                    if (theDate == null) {
                      try {
                        // valueof works in the case of 1983-10-11
                            theDate = Date.valueOf(eachrowrecord[j].trim());
                          }
                      catch(Exception e) {}
                            }
                if (theDate != null) {
                  // parse
                  tktProfileObject.put(gridrows[j].field,theDate);
                        }
                  }
                  
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Blogger__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='FaceBookId__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Gender__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='LinkedInId__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Mobile__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  {
                  if(eachrowrecord[j].trim().touppercase().contains('E+')||eachrowrecord[j].trim().touppercase().contains('E-')){
                    try{
                    Decimal d=Decimal.valueOf(eachrowrecord[j].trim());
                    tktProfileObject.put(gridrows[j].field,d.toPlainString());
                     }catch(Exception e)
                        {
                        tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                        }
                        }
                        else
                        tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Work_Phone__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  {
                  if(eachrowrecord[j].trim().touppercase().contains('E+')||eachrowrecord[j].trim().touppercase().contains('E-')){
                    try{
                    Decimal d=Decimal.valueOf(eachrowrecord[j].trim());
                    tktProfileObject.put(gridrows[j].field,d.toPlainString());
                     }catch(Exception e)
                        {
                        tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                        }
                        }
                        else
                        tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Home_Phone__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  {
                  if(eachrowrecord[j].trim().touppercase().contains('E+')||eachrowrecord[j].trim().touppercase().contains('E-')){
                    try{
                    Decimal d=Decimal.valueOf(eachrowrecord[j].trim());
                    tktProfileObject.put(gridrows[j].field,d.toPlainString());
                     }catch(Exception e)
                        {
                        tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                        }
                        }
                        else
                        tktProfileObject.put(gridrows[j].field,eachrowrecord[j].trim());
                  
                  }
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Badge_Label__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tcid[i].put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Tag_No__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tcid[i].put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='Custom_Barcode__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tcid[i].put(gridrows[j].field,eachrowrecord[j].trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='WorkState__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                 workstatename=eachrowrecord[j].touppercase().trim();
                  workadd=true;
                  }
                  
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='HomeState__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  homestatename=eachrowrecord[j].touppercase().trim();
                  homeadd=true;
                    }
                  
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='TwitterId__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!='')
                  tktProfileObject.put(gridrows[j].field,eachrowrecord[j].unescapeCsv().trim());
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='WorkZip_Code__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  workAddress.put('ZipCode__c',eachrowrecord[j].unescapeCsv().trim());
                  workadd=true;}
                  }
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='HomeZip_Code__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  homeAddress.put('ZipCode__c',eachrowrecord[j].unescapeCsv().trim());
                  homeadd=true;}
                  }
                  
                      }catch(exception ex){}
                      
                      try{
                  if(gridrows[j].field=='NAICS_Code__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  String[] arrnaic = eachrowrecord[j].trim().split(';');
                  for(String s:arrnaic){
                  if(selectedNaicsCodes==null){
                  try{
                  selectedNaicsCodes=naicscodes.get(s.touppercase());
                  }catch(Exception e){}
                  }
                  else{
                  try{
                  selectedNaicsCodes=selectedNaicsCodes+'-'+naicscodes.get(s.touppercase());
                  }catch(Exception e){}
                  }
                  }
                  }
                 }
                     }catch(exception ex){}
                 
                     try{
                 if(gridrows[j].field=='Diversity__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  String[] arrnaic = eachrowrecord[j].trim().split(';');
                  for(String s:arrnaic){
                  if(selectedDiver==null){
                  try{
                  selectedDiver=diversList.get(s.touppercase());
                  }catch(Exception e){}
                  }
                  else{
                  try{
                  selectedDiver=selectedDiver+'-'+diversList.get(s.touppercase());
                  }catch(Exception e){}
                  }
                  }
                  }
                 }
                     }catch(exception ex){}
                     
                     try{
                 if(gridrows[j].field=='Commodities__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  String[] arrnaic = eachrowrecord[j].trim().split(';');
                  for(String s:arrnaic){
                  if(selectedCommodities==null){
                  try{
                  selectedCommodities=commoditiesList.get(s.touppercase());
                  }catch(Exception e){}
                  }
                  else{
                  try{
                  selectedCommodities=selectedCommodities+'-'+commoditiesList.get(s.touppercase());
                  }catch(Exception e){}
                  }
                  }
                  }
                 }
                     }catch(exception ex){}
                 
                    
              }
           }
           
 if(workadd==true){
 if(workAddress.Country__c ==null&&workstatename!=null)
 {
 try{
 workAddress.Country__c=inputstatecountrymap.get(workstatename);
  if(inputstatecountrymap.get(workstatename)!=null)
  if(!eventincludecountries.contains(workAddress.Country__c))
                  {
                     BLN_Event_Countries_Include__c newcountries=new BLN_Event_Countries_Include__c(BLN_Country__c=workAddress.Country__c,BLN_Event__c=BLNItem.event__c);
                     neweventincludecountries.add(newcountries);
                     eventincludecountries.add(workAddress.Country__c);  
                  }
                  }catch(Exception e){}
 }
 if(workstatename!=null&&workstatename!=''&&workAddress.country__c!=null&&workAddress.Country__c != unDifinedCountryStateIds.get('UNDCOUNTRY')){
       Map<String,Id> onlystates=new Map<String,Id>();
       onlystates=longstatesparent.get(workAddress.country__c);
       try{
       if(onlystates.containskey(workstatename))
       workAddress.state__c=onlystates.get(workstatename);
       else
       {
          onlystates=new Map<String,Id>();
       onlystates=shortstatesparent.get(workAddress.country__c);
       try{
       if(onlystates.containskey(workstatename))
       workAddress.state__c=onlystates.get(workstatename);
       else
       {
          if(inputstatemap.containskey(workstatename))
          workAddress.put('State__c',inputstatemap.get(workstatename));
          else
          workAddress.put('State__c',unDifinedCountryStateIds.get('UNDSTATE'));
       }
       }catch(Exception e){
       if(inputstatemap.containskey(workstatename))
          workAddress.put('State__c',inputstatemap.get(workstatename));
          else
          workAddress.put('State__c',unDifinedCountryStateIds.get('UNDSTATE'));
       }
       }
       }catch(Exception e){
       if(inputstatemap.containskey(workstatename))
          workAddress.put('State__c',inputstatemap.get(workstatename));
          else
          workAddress.put('State__c',unDifinedCountryStateIds.get('UNDSTATE'));
       }
 
 }
 
 }
 
 if(homeadd==true){
 if(homeAddress.Country__c ==null&&homestatename!=null)
 {
 homeAddress.Country__c=inputstatecountrymap.get(homestatename);
 }
 if(homestatename!=null&&homestatename!=''&&homeAddress.country__c!=null&&homeAddress.Country__c != unDifinedCountryStateIds.get('UNDCOUNTRY')){
       Map<String,Id> onlystates=new Map<String,Id>();
       onlystates=longstatesparent.get(homeAddress.country__c);
       try{
       if(onlystates.containskey(homestatename))
       homeAddress.state__c=onlystates.get(homestatename);
       else
       {
           onlystates=new Map<String,Id>();
       onlystates=shortstatesparent.get(homeAddress.country__c);
       try{
       if(onlystates.containskey(homestatename))
       homeAddress.state__c=onlystates.get(homestatename);
       else
       {
          if(inputstatemap.containskey(homestatename))
          homeAddress.put('State__c',inputstatemap.get(homestatename));
          else
          homeAddress.put('State__c',unDifinedCountryStateIds.get('UNDSTATE'));
       }
       }catch(Exception e){
        if(inputstatemap.containskey(homestatename))
          homeAddress.put('State__c',inputstatemap.get(homestatename));
          else
          homeAddress.put('State__c',unDifinedCountryStateIds.get('UNDSTATE'));
    
       }
       }
       }catch(Exception e){
       if(inputstatemap.containskey(homestatename))
          homeAddress.put('State__c',inputstatemap.get(homestatename));
          else
          homeAddress.put('State__c',unDifinedCountryStateIds.get('UNDSTATE'));
       }
 
 }
 
 }
           
           //ordercon.saveLogic(newu,tc,new order__c(),gnu1);
           
           //create order with external paygateway
           BLN_Payments_BAL PaymentsBAL = new BLN_Payments_BAL();
           BLN_TrasactionStatus paymentStatus = new BLN_TrasactionStatus(); 
 BLN_VariablesCls variablecls = new BLN_VariablesCls();
 String SelectedCardType = 'External Pay Gateway';
  paymentStatus = PaymentsBAL.externalPayGatewayPayment(variablecls);
  String ChargeId;
  if((paymentStatus.transactionId!=null && paymentStatus.transactionId!='') )
 ChargeId=paymentStatus.transactionId;
 
 LIST<BLN_RegistrationnewCon.TicketInnerClass> TicketList= new LIST<BLN_RegistrationnewCon.TicketInnerClass>();
 BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
Set<Id> blnitemset=new Set<Id>();
blnitemset.add(tcid[0].Item__c);
MAP<id,LIST<Reg_Setting__c>> RegSettingsMap = RegSettingsBAL.regsettings(blnitemset,BLNItem.event__c);

BLN_RegistrationnewCon.TicketInnerClass ticketlistnew=new BLN_RegistrationnewCon.TicketInnerClass(tcid[i],1,1,BLNItem,null,null,null,false,new List<List<NAICS_Code__c>>(),new List<Diversity__c>(),null);
ticketlistnew.tktProfileObject =tktProfileObject;
if(tcid[i].Custom_BarCode__c!=null&&tcid[i].Custom_BarCode__c!='')
ticketlistnew.custombarcode=tcid[i].Custom_BarCode__c;
if(selectedDiver!=null&&selectedDiver!=''){
ticketlistnew.selecteddivers=selectedDiver;
}
if(selectedNaicsCodes!=null&&selectedNaicsCodes!=''){
ticketlistnew.selectedNaicsCodes=selectedNaicsCodes;
}
if(selectedCommodities!=null&&selectedCommodities!=''){
ticketlistnew.selectedCommodities=selectedCommodities;
}
if(workadd==true){
ticketlistnew.workAddress=new BLN_Address__c();
ticketlistnew.workAddress=workAddress;
}
if(homeadd==true){
ticketlistnew.homeAddress=new BLN_Address__c();
ticketlistnew.homeAddress=homeAddress;
}
ticketlistnew.RegSettingMap=RegSettingsMap;
 TicketList.add(ticketlistnew);
 
LIST<Selectoption> itemWiseCount = new LIST<Selectoption>();
itemWiseCount.add(new Selectoption(string.valueOf(1), string.valueOf(1) ));

LIST<BLN_RegistrationnewCon.ItemInnerClass> ItemList= new List<BLN_RegistrationnewCon.ItemInnerClass>();
 ItemList.add(new BLN_RegistrationnewCon.ItemInnerClass(BLNItem,itemWiseCount,String.valueOf(1),0,''));
 
 BLN_RegistrationnewCon.TicketInnerClass buyerTicketInn=new BLN_RegistrationnewCon.TicketInnerClass();
 Tkt_Profile__c tktProfileObject1= new Tkt_Profile__c();
 tktProfileObject1=tktProfileObject.clone();
 buyerTicketInn.tktProfileObject =tktProfileObject1;
 if(tcid[i].Custom_BarCode__c!=null&&tcid[i].Custom_BarCode__c!='')
buyerTicketInn.custombarcode=tcid[i].Custom_BarCode__c;
 if(selectedDiver!=null&&selectedDiver!=''){
buyerTicketInn.selecteddivers=selectedDiver;
}
if(selectedNaicsCodes!=null&&selectedNaicsCodes!=''){
buyerTicketInn.selectedNaicsCodes=selectedNaicsCodes;
}
if(selectedCommodities!=null&&selectedCommodities!=''){
buyerTicketInn.selectedCommodities=selectedCommodities;
}

 if(workadd==true){
buyerTicketInn.workAddress=new BLN_Address__c();
buyerTicketInn.workAddress=workAddress;
}
if(homeadd==true){
buyerTicketInn.homeAddress=new BLN_Address__c();
buyerTicketInn.homeAddress=homeAddress;
}
buyerTicketInn.RegSettingMap=RegSettingsMap;
 
  
    String qpaymentmethod = 'External Pay Gateway';
   BLN_Quick_Registration_BAL quickbal = new BLN_Quick_Registration_BAL ();
   string ordstatus;
   string errmsg='';
   try{
   system.debug('@@@@@@@@@@countrych'+TicketList[0].workAddress.Country__c+'================'+unDifinedCountryStateIds.get('UNDCOUNTRY'));
     if(TicketList[0].workAddress.Country__c == unDifinedCountryStateIds.get('UNDCOUNTRY') && TicketList[0].workAddress.State__c == unDifinedCountryStateIds.get('UNDSTATE')){
     errmsg = 'Error: Invalid Country and State';
     }else if(TicketList[0].workAddress.Country__c == unDifinedCountryStateIds.get('UNDCOUNTRY')){
     system.debug('it is coming@@@@@');
     errmsg = 'Error: Invalid Country';
     }else if(TicketList[0].workAddress.State__c == unDifinedCountryStateIds.get('UNDSTATE')){
      errmsg = 'Error: Invalid State';
     }else if(TicketList[0].homeAddress.Country__c == unDifinedCountryStateIds.get('UNDCOUNTRY') && TicketList[0].homeAddress.State__c == unDifinedCountryStateIds.get('UNDSTATE')){
     errmsg = 'Error: Invalid Country and State';
     }else if(TicketList[0].homeAddress.Country__c == unDifinedCountryStateIds.get('UNDCOUNTRY')){
      errmsg = 'Error: Invalid Country';
     }else if(TicketList[0].homeAddress.State__c == unDifinedCountryStateIds.get('UNDSTATE')){
     errmsg = 'Error: Invalid State';
     }else{
 ordstatus =quickbal.insertingTotalorder(ItemList, TicketList,buyerTicketInn,onlyticketamount, 0, feeamount,0, onlyticketamount, mapitemWithFee,null,null, SelectedCardType, qpaymentmethod,ChargeId, qpaymentmethod,'Onsite','','');
      }
 try{
 if(ordstatus=='Success'){ 
  if(tagName!=null&&tagName!='')
  {
    BLNUtility blutil=new BLNUtility();
   blutil.AssignTags(tcid[i].id,tagName,BLNItem.event__c,'Ticket__c');
  }
  }
 }catch(Exception e){}
 }catch(Exception e){}
           //end of order creation
           if(ordstatus=='Success'){ 
    
    try{
        //Sending email
       //BLN_SuccessController blsuc=new BLN_SuccessController(); 
       //System.debug('quickbal.orderId '+quickbal.orderId);
       //blsuc.eventId=BLNItem.Event__c;
       //blsuc.orderId=quickbal.orderId;
       //blsuc.sendMail(quickbal.orderId,BLNItem.Event__c); 
        order__c orders =new order__c();
      orders =   [select owner.Name,createdDate,Events__r.Name,Events__r.Start_Date__c,Events__r.Venue_Name__c,Events__r.End_Date__c,Events__r.Description__c,Events__c,o.Fee_Amount__c,o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_GN_User__c, o.BLN_TKT_profile__r.BLN_Company__c, o.Amount_Paid__c,(Select Each_Ticket_Price__c,item__r.event__r.Name ,Promotion__c,Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c,order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.BLN_GN_User__r.Email__c,Item_Quantity__c, Item_Price__c, Item_Discount__c, Id,Item__r.Event__r.End_Date__c,item__r.item_name__c,Status__c,Promotion__r.Promo_Code__c,Currency__c,item__r.price__c  From Order_Items__r ),(Select Order_Item__r.Each_Ticket_Price__c,Item_Pool__c,Item_Type__c,item__r.item_name__c,id,tkt_profile__r.BLN_Company__c,tkt_profile__r.BLN_Company__r.Name,tkt_profile__r.BLN_GN_User__r.Email__c,tkt_profile__r.BLN_GN_User__r.user__c,tkt_profile__r.BLN_GN_User__r.user__r.userName,tkt_profile__r.BLN_GN_User__r.user__r.email,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,Event__c,Order__c,Order_Item__c,Ticket_Status__c,Badge_Label__c,NAme,Item_Type__r.Name,tkt_profile__r.BLN_GN_User__r.user__r.MobilePhone,lastmodifiedDate,item_pool__r.item_type__r.name from Tickets__r),(select Currency_Code__c,Pay_Address__c,Payment_Ref_Number__c,Payment_Mode__c,Payment_Amount__c,Registration_Type__c from Payments__r),BLN_TKT_profile__r.BLN_GN_User__r.user__r.Name,BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName,BLN_TKT_profile__r.BLN_GN_User__r.user__r.MobilePhone,BLN_TKT_profile__r.BLN_GN_User__r.Name,BLN_TKT_profile__r.Last_Name__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.TKT_Company__c From Order__c o where Id=: quickbal.orderId];
      orders.Order_Status__c='Fully Paid';
      SET<id> tIdForMatchleads = new SET<id>();
      List<Booth_Map__c>  bmp=new List<Booth_Map__c>();
     List<BLN_Sponsorships__c> Sponsorships=new List<BLN_Sponsorships__c>();
      for(Ticket__c ty : orders.Tickets__r){
        ty.Ticket_Status__c='Booked';
        if((ty.Item_Type__r.Name=='MatchLeads Buyer' || ty.Item_Type__r.Name=='MatchLeads Seller') || ( ty.item_pool__r.item_type__r.name=='MatchLeads Buyer' ||  ty.item_pool__r.item_type__r.name=='MatchLeads Seller')){
            tIdForMatchleads.add(ty.id);
         }
        if(ty.item_pool__r.item_type__r.name == 'Booths /Tables'){
            bmp.add(new Booth_Map__c(name=ty.Item_Pool__r.Item_Type__r.Name,Ticket_id__c=ty.id)); 
        }
        if(ty.item_pool__r.item_type__r.name == 'Sponsorship'){
            Sponsorships.add(new BLN_Sponsorships__c(name=ty.Item_Pool__r.Item_Type__r.Name,Ticket_id__c=ty.id)); 
        }
     }
     for(Payment__c py : orders.Payments__r){
        py.Registration_Type__c='Import';
     }
      database.update(orders.Tickets__r,false); 
       database.update(orders.Payments__r,false); 
      database.update(orders,false);
      try{   
  BLN_Insertmldata insMldt = new BLN_Insertmldata();
  insMldt.insertMLData(tIdForMatchleads);
  }catch(exception ex){}
      if(bmp.size()>0){
          Database.insert(bmp,false);
      }
      if(Sponsorships.size()>0){
          Database.insert(Sponsorships,false);
      }
    }
    catch(Exception e)
    {
       
    }
    reccreated++;
      }
      else
      {
      k++;
      
      String eachrowValue = String.valueOf(eachrowrecord);
      if(eachrowValue.startswith('(')){
          eachrowValue = eachrowValue.Substring(1,eachrowValue.length());
      }
      if(eachrowValue.endswith(')')){
          eachrowValue = eachrowValue.Substring(0,eachrowValue.length()-1);
      }
        if(ordstatus==null){
        if(errmsg.length()>1)
            mailCSVAttachment = mailCSVAttachment + errmsg +','+eachrowValue+'\n';
            else
        mailCSVAttachment = mailCSVAttachment + 'Error is:problem with emailId.Check with the data. '+','+eachrowValue+'\n';
        }else{
         mailCSVAttachment = mailCSVAttachment + 'Error is: '+ordstatus+','+eachrowValue+'\n';
         }try{
         Ticket__c tcu=new Ticket__c(id=tcid[i].id,custom_barcode__c='',Ticket_status__c='Available');
         update tcu;
         }catch(Exception e){}
         recfailed++;
      }
      }
      
      try{
      insert neweventincludecountries;
      }catch(Exception e){}
      
   }
   global void finish(Database.BatchableContext batchableContext){
   //Send Mail when failure
      try{
      Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
                
                //Prepare Mail For Failure Attachments
                
                if(mailCSVAttachment != null && mailCSVAttachment != '' && mailCSVAttachment != 'null' && k > 0){
                blob csvBlob = Blob.valueOf(mailCSVAttachment);
                string csvname= 'Import Attendees Failures.csv';
                csvAttc.setFileName(csvname);
                csvAttc.setBody(csvBlob);}
                
                EmailTemplate E = new EmailTemplate();    
                E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Import Attendees Summary']; 
                
                /*String emailMessage =  'Eventdex.com has just completed your import process!'+'<br/><br/>'+
                                       'We strongly recommend that you check a few of your imported records to verify that your information was imported as expected.'+'<br/><br/>'+
                                       'If you encounter any problems or have any questions, please contact Eventdex Customer Support.<br/><br/>'+
                                       'Thank you! <br/> Eventdex Customer Support <br/> support@eventdex.com <br/> Phone: 1-(800)-492-1289' ;*/
                 String emailMessage = E.HtmlValue;
                 emailMessage =emailMessage.replace('{!filename}',csvFileName); 
                 emailMessage =emailMessage.replace('{!recimported}',String.valueOf(recimported)); 
                 emailMessage =emailMessage.replace('{!reccreated}',String.valueOf(reccreated)); 
                 emailMessage =emailMessage.replace('{!recfailed}',String.valueOf(recfailed));
                 
                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

                    if ( owea.size() > 0 ) {
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        //emailTOea.setOrgWideEmailAddressId(owea.get(0).Id);
                    }
                   BLN_Item__c it=new BLN_Item__c(); 
                    try{
      it=[select id,item_name__c,event__r.Organizer_Email__c,event__c,event__r.name from BLN_Item__c where id=:selecteditem limit 1];
      }catch(Exception e3){}
                try{
                Reg_Setting__c r=[select id,name,event__c,included__c,column_name__c,setting_type__c from Reg_Setting__c where event__c=:it.event__c and column_name__c='StopEmailsToEventAdmin' and setting_type__c='Display' limit 1];
                if(r.included__c==true)
                {
                  String[] toAddresses = new String[] {'support@eventdex.com'};
                 mail.setToAddresses(toAddresses);
                }
                else
                {
                  String[] toAddresses = new String[] {it.event__r.Organizer_Email__c,'support@eventdex.com'};
                 mail.setToAddresses(toAddresses);
                }
                
                }catch(Exception e2){
                String[] toAddresses = new String[] {it.event__r.Organizer_Email__c,'support@eventdex.com'};
                 mail.setToAddresses(toAddresses);}
                 
                 mail.setReplyTo('support@eventdex.com');
                 try{
      emailMessage =emailMessage.replace('{!EventName}',it.event__r.name);
      mail.setSubject('Import Attendees for event : '+it.event__r.name);
      }catch(Exception e1){mail.setSubject('Import Attendees');} 
                 
                 //mail.setPlainTextBody(emailMessage);
                 mail.setHtmlBody(emailMessage);
                
                 if(mailCSVAttachment!=null&&mailCSVAttachment!=''&&mailCSVAttachment!='null'  && k > 0)
                 mail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 }catch(Exception e){}
   
   
   }
   
 
}
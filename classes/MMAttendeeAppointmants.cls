@RestResource(urlMapping='/MMAttendeeAppointmants/*')

global without sharing class MMAttendeeAppointmants{

@httpPost
  
 global static AllDetails doPost(){
  
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;     
     string exhibitorid;
     String isMM;
     eveid =req.params.get('eveid');
       AllDetails alDetail = new AllDetails();
     string attendeeId = req.params.get('exhibitorid');
     isMM = req.params.get('isMM');
     system.debug('eveid---'+eveid);
     system.debug('attendeeId ---'+attendeeId );
    
    Event__c eveobj = new Event__c();
    FetchEventdetails evedetails= new FetchEventdetails();
    alDetail.eventscheduleStatus = 'Live';
    if(eveid!=null && eveid!=''){  
      try{
        if(null !=evedetails.evedetails(eveid)){
            eveobj  = evedetails.evedetails(eveid);
            if(null != evedetails.evedetails(eveid).Match_Making_Schedules__c){
                alDetail.eventscheduleStatus = evedetails.evedetails(eveid).Match_Making_Schedules__c;
           }
        }
       }catch(exception er){} 
      } 
     
       
         User_Profile_Event__c exdtls = new User_Profile_Event__c();
         system.debug('        exid      ');
          
     if(eveobj.Is_Webank_event__c){ 
          string mbeprofileid = ''; 
           for(Event_Attendee_Mapping__c eam : [select id,MBE_Profile__c from Event_Attendee_Mapping__c  where (MBE_Profile__r.Id =:attendeeId Or AS_Id__r.id=:attendeeId) AND EV_id__r.Id =: eveid]){
              mbeprofileid = eam.MBE_Profile__c; 
              System.debug('AAAAAAAAAAA    '+eam.id);
           }
           System.debug('PPPPPPPPPPP AAAAAAAAA'+mbeprofileid);
           
           if(mbeprofileid !=null && mbeprofileid !=''){
                MBE_Profile__c mbepro =  new MBE_Profile__c();
                try{
                 mbepro =  [Select m.distribution_Country__c, m.Year_in_business__c, m.SystemModstamp, m.Revenue_Range__c, m.References__c, m.OwnerId, m.Name, m.Manufactures_Country__c, m.LastViewedDate, m.LastReferencedDate, m.LastModifiedDate, m.LastModifiedById, m.LastActivityDate, m.Key_Words__c, m.IsDeleted, m.Id, m.Geographical_Region__c, m.GSA_Schedule__c, m.FaxNumber__c, m.Exhibitor_company_imageUrl__c, m.Exceptional_Key_Words__c, m.Event_Organizer_Id__c, m.DBA__c, m.CreatedDate, m.CreatedById, m.Company_Certifications__c, m.Commodity_5__c, m.Commodity_4__c, m.Commodity_3__c, m.Commodity_2__c, m.Commodity_1__c, m.Certificate_Processed_by_RPO__c, m.Business_type__c, m.Business_Structure__c, m.BBB_Number__c, m.AttendeeSummary__c, m.As_prefixNew__c, m.As_SuffixNew__c, m.As_Shipping_States__c, m.As_Shipping_Country__c, m.As_SecondaryBusinessCategory1__c, m.As_NAICSCode_5__c, m.As_NAICSCode_4__c, m.As_NAICSCode_3__c, m.As_NAICSCode_2__c, m.As_NAICSCode_1__c, m.As_Home_State__c, m.As_Home_Country__c, m.AS_shippingzip_c__c, m.AS_Work_States__c, m.AS_Work_Country__c, m.AS_WorkZip__c, m.AS_WorkZipCode__c, m.AS_WorkPhone__c, m.AS_WorkCity__c, m.AS_WorkAddress2__c, m.AS_WorkAddress1__c, m.AS_WebsiteUrl__c, m.AS_Title__c, m.AS_ShippingZipcode__c, m.AS_ShippingState__c, m.AS_ShippingPoBox__c, m.AS_ShippingPhone__c, m.AS_ShippingCity__c, m.AS_ShippingAddress2__c, m.AS_ShippingAddress1__c, m.AS_PrimaryBusinessCategory1__c, m.AS_NumberOfEmployees__c, m.AS_NAICSCode9__c, m.AS_NAICSCode8__c, m.AS_NAICSCode7__c, m.AS_NAICSCode6__c, m.AS_LastName__c, m.AS_ImageUrl__c, m.AS_HomeZip__c, m.AS_HomePoBox__c, m.AS_HomePhone__c, m.AS_HomeCity__c, m.AS_HomeAddress2__c, m.AS_HomeAddress1__c, m.AS_Gender__c, m.AS_FirstName__c, m.AS_FaxNumber__c, m.AS_Email__c, m.AS_DiversityType__c, m.AS_Company__c, m.AS_CellPhone__c, m.AS_CageCode__c, m.AS_BusinessTaxId_c__c, m.AS_BusinessTaxId__c, m.AS_BusinessRevenue__c, m.AS_BusinessEstablishedDate__c, m.AS_BusinessDunsNumber__c, m.AS_BusinessDescription__c, m.AS_BlogUrl__c, m.AS_BirthDate__c, m.AS_Age__c From MBE_Profile__c m where id=:mbeprofileid ];
                   GlobalUtillClass.MMEXHDetails mmexdtls2 = new GlobalUtillClass.MMEXHDetails(mbepro);
                   alDetail.MMEXHDetails.add(mmexdtls2);
                }catch(exception ed){}
            }          
      
      }else{
         try{
         exdtls = [SELECT Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.Id, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Email__c, 
         Attendee_Summary__r.Company_Certifications__c, Attendee_Summary__r.AS_CellPhone__c, Attendee_Summary__r.AS_ImageUrl__c, 
         Attendee_Summary__r.Exhibitor_company_imageUrl__c,  Attendee_Summary__r.AS_PrimaryBusinessCategory1__c, Attendee_Summary__r.As_SecondaryBusinessCategory1__c, 
         Attendee_Summary__r.AS_WebsiteUrl__c, Attendee_Summary__r.AS_WorkAddress1__c, 
         Attendee_Summary__r.AS_WorkAddress2__c, Attendee_Summary__r.AS_WorkCity__c, 
         Attendee_Summary__r.AS_Work_Country__c, Attendee_Summary__r.AS_Work_States__c, 
         Attendee_Summary__r.AS_WorkZip__c, Attendee_Summary__r.AS_Company__c, Attendee_Summary__r.AS_Title__c,
         Attendee_Summary__r.As_NAICSCode_1__c, Attendee_Summary__r.As_NAICSCode_2__c, 
         Attendee_Summary__r.As_NAICSCode_3__c, Attendee_Summary__r.AS_NAICSCode_4__c, 
         Attendee_Summary__r.AS_NAICSCode_5__c, Attendee_Summary__r.Keywords__c,
         Attendee_Summary__r.AS_BusinessDescription__c,Attendee_Summary__r.Commodity_1__c,Attendee_Summary__r.Commodity_2__c,
         Attendee_Summary__r.Commodity_3__c,Attendee_Summary__r.Commodity_4__c,Attendee_Summary__r.Commodity_5__c, Attendee_Summary__r.Exceptional_Key_Words__c, 
         BT_id__r.Table_Room_No__c, BT_id__r.BT_Location__c, BT_id__r.MM_TableNo__c, User_id__r.Id,User_id__r.userName
         FROM User_Profile_Event__c WHERE IsMatchMakingUser__c = true AND MAtchMakingProfile__c = 'MBE' AND Attendee_Summary__r.Id =:attendeeId AND EV_id__r.Id =: eveid];         
         
          GlobalUtillClass.MMEXHDetails mmexdtls = new GlobalUtillClass.MMEXHDetails(exdtls);
          alDetail.MMEXHDetails.add(mmexdtls);
         System.debug('PPPPPPPPPPPPP  '+mmexdtls );
         }catch(exception e){
          
            
          for(AttendeeSummary__c  att : [ Select a.updateRevenue__c, a.isUpdated__c, a.isFetched__c, a.distribution_Country__c, a.customer_key__c, a.biography__c, 
                                                a.Youtube_Link__c, a.Year_in_business__c, a.Total_Name__c, a.Ticket_Number__c, a.SystemModstamp, a.Revenueupdate__c, 
                                                a.Revenue_Range__c, a.Registration_type__c, a.References__c, a.OwnerId, a.Name, a.Manufactures_Country__c, 
                                                a.LastViewedDate, a.LastReferencedDate, 
                                                a.LastModifiedDate, a.LastModifiedById, a.LastActivityDate, a.Keywords__c, a.IsDeleted, a.Id, a.Geographical_Region__c, 
                                                a.GSA_Schedule__c, a.FullName__c, a.FetchStatus__c, a.Exhibitor_company_imageUrl__c, a.Exceptional_Key_Words__c, 
                                                a.EventBriteCount__c, a.DBA__c, a.CreatedDate, a.CreatedById, 
                                                a.Company_Certifications__c, a.Commodity_5__c, a.Commodity_4__c, a.Commodity_3__c, a.Commodity_2__c, 
                                                a.Commodity_1__c, a.Certificate_Processed_by_RPO__c, a.Business_type__c, a.BBB_Number__c, a.As_prefixNew__c, a.As_SuffixNew__c, 
                                                a.As_Shipping_States__c, 
                                                a.As_Shipping_Country__c, a.As_SecondaryBusinessCategory1__c, a.As_NAICSCode_5__c, a.As_NAICSCode_4__c, a.As_NAICSCode_3__c, a.As_NAICSCode_2__c, 
                                                a.As_NAICSCode_1__c, a.As_Home_State__c, a.As_Home_Country__c, a.AddedBy__c, 
                                                a.AS_uniqueField__c, a.AS_shippingzip__c, a.AS_Workpoboxno__c, a.AS_Work_States__c, 
                                                a.AS_Work_Country__c, a.AS_WorkZip__c, a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                                                a.AS_WorkCountry__c, 
                                                a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, a.AS_WebsiteUrl__c, a.AS_Title__c, 
                                                a.AS_ThroughEventBrite__c, a.AS_Suffix__c, a.AS_Shippingpoboxno__c, a.AS_ShippingZipcode__c, a.AS_ShippingState__c, 
                                                a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c, 
                                                a.AS_SecondaryBusinessCategory__c, a.AS_PrimaryBusinessCategory__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                                                a.AS_NumberOfEmployees__c, a.AS_NAICSCode9__c, a.AS_NAICSCode8__c, a.AS_NAICSCode7__c, a.AS_NAICSCode6__c, a.AS_NAICSCode5__c, a.AS_NAICSCode4__c, 
                                                a.AS_NAICSCode3__c, a.AS_NAICSCode2__c, 
                                                a.AS_NAICSCode1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c, a.AS_HomeZip__c, a.AS_HomeState__c, 
                                                a.AS_HomePoboxNo__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c, a.AS_HomeAddress2__c, 
                                                a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c, a.AS_Email__c, a.AS_DiversityType__c, 
                                                a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c, a.AS_BusinessTaxId__c, 
                                                a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, 
                                                a.AS_BusinessDunsNumber__c, a.AS_BusinessDescription__c, a.AS_BlogUrl__c, a.AS_BirthDate__c, 
                                                a.AS_Age__c From AttendeeSummary__c a where id =: attendeeId  ]){
             GlobalUtillClass.MMEXHDetails mmexdtls1 = new GlobalUtillClass.MMEXHDetails(att);
            System.debug('QQQQQQQQQ  '+mmexdtls1 );
             alDetail.MMEXHDetails.add(mmexdtls1);
           }
        }
      
      
      }   
      
         
           for(Event_Attendee_Mapping__c em : [select id from Event_Attendee_Mapping__c where (MBE_Profile__r.Id =:attendeeId Or AS_Id__r.id=:attendeeId) and IsMatchMakingAttendee__c= true AND EV_id__r.Id =: eveid] ){
              System.debug('PPPPPPPPPP '+em.Id);
              exhibitorid =em.Id;
           }
          
          
       
        // system.debug('exdtls.AS_Email__c----------'+exdtls.Attendee_Summary__r.AS_Email__c);
         
         for(Event_Attendee_Mapping__c eam :[select id,(select id,Break_End_Time__c,Break_Start_Time__c,Break_Title__c,Event_Attendee_Mapping__c,MatchLeads_Days__c,MatchLeads_Days__r.MatchLeads_Date__c from Event_Breaks__r where Event_Attendee_Mapping__c!=null) from Event_Attendee_Mapping__c where EV_id__c=:eveid and (AS_Id__r.id=:attendeeId OR MBE_Profile__r.id=:attendeeId)]){
               alDetail.EventAttendeeMapping  =eam.id; 
              for(Event_Breaks__c Ebc:eam.Event_Breaks__r){
                GlobalUtillClass.MMBlockedslots gn = new GlobalUtillClass.MMBlockedslots(Ebc);
                alDetail.BlockedSchedules.add(gn);
              }
         }
      
       
      
         MAP<date, LIST<String>> eventOpenDatesSchedules = new MAP<Date, LIST<String>>();
         
         eventOpenDatesSchedules = MM_Utility.giveEventTimingsWithDates(eveid, null);
         system.debug('ooooooooooooo'+eventOpenDatesSchedules );
         MAP<Date, MAP<String, EventSchedule__c>>  MBESchedules = new MAP<Date, MAP<String, EventSchedule__c>> ();
         
         MBESchedules = MM_Utility.attendeeScheduleTimings(eveId, exhibitorid);
         map<string, EventSchedule__c> mapappointments=new  map<string, EventSchedule__c>();
                                     
         for(Date schDat: MBESchedules.keySet()){
             MAP<String,EventSchedule__c> Exschdules = new MAP<String,EventSchedule__c>();
             Exschdules = MBESchedules.get(schDat);
             
             // alDetail.MMEXAppointmentlist = null;
             LIST<GlobalUtillClass.MMEXAppointmentlist> dateWiseSchedules = new LIST<GlobalUtillClass.MMEXAppointmentlist>();
            
             for(EventSchedule__c es: Exschdules.Values()){
               //  mapappointments.put(es.MM_slot_StartTime__c,es);
                 GlobalUtillClass.MMEXAppointmentlist reslt = new GlobalUtillClass.MMEXAppointmentlist(es); 
                 alDetail.MMEXAppointmentlist.add(reslt);
                 //dateWiseSchedules.add(reslt);
             }
           }
         
         system.debug('rrrrrr'+eventOpenDatesSchedules);
        system.debug('llllll'+eventOpenDatesSchedules.keySet());
         for(Date schDat:  eventOpenDatesSchedules.keySet()){
            
            LIST<String> dateWiseOpenOppointments = new LIST<String>();
            LIST<String> dateWiseAllOppointments = new LIST<String>();
            
            dateWiseAllOppointments = eventOpenDatesSchedules.get(schDat);
            MAP<String, EventSchedule__c> MBEBookedSchedules = new MAP<String, EventSchedule__c> ();
            
            if(MBESchedules.containsKey(schDat))
                MBEBookedSchedules = MBESchedules.get(schDat);
            
                for(String s: dateWiseAllOppointments){
                    
                    if(s.Contains('-')){
                        String compareString = s.substring(0, s.indexOf('-'));
                        
                        if(!MBEBookedSchedules.containsKey(compareString)){
                            GlobalUtillClass.MMEXOpenslots reslt = new GlobalUtillClass.MMEXOpenslots(s,string.valueof(schDat)); 
                            alDetail.MMEXOpenslotslist.add(reslt);
                        }
                        
                    }
                    
                    
                }
            }
        System.debug('PPPPPPPPPPPPPP  '+alDetail.MMEXHDetails); 
        return alDetail;  

}
//--------------------------------inner class--------------------------
   global  class InnerForTimeslots{
       public String Stime{get;set;}
       public String ETime{get;set;}
       public InnerForTimeslots(string Stime  , string ETime ){
           this.Stime = Stime  ;
           this.ETime = ETime ;
       }
   }
   //----------------------------------------------------------------
         
         

global class AllDetails{
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.MMEXHDetails> MMEXHDetails = new List<GlobalUtillClass.MMEXHDetails>();
List<GlobalUtillClass.MMEXAppointmentlist> MMEXAppointmentlist = new List<GlobalUtillClass.MMEXAppointmentlist>();
List<GlobalUtillClass.MMEXOpenslots> MMEXOpenslotslist = new List<GlobalUtillClass.MMEXOpenslots>();
List<GlobalUtillClass.MMBlockedslots> BlockedSchedules= new List<GlobalUtillClass.MMBlockedslots>();
string EventAttendeeMapping = '';
string eventscheduleStatus = '';

}
}
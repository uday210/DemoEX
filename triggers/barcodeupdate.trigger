trigger barcodeupdate on Event_Attendee_Mapping__c (after insert) {
//try
//{
 list<Event_Attendee_Mapping__c> eamlist=new list<Event_Attendee_Mapping__c>{};
 getEamsForEvent ForUniqNo = new getEamsForEvent();
 
  list<MBE_Profile__c>  mbepro = new List<MBE_Profile__c>{};
  set<id> sttid = new set<id> ();
  string evid ='';
   // Getting all existing uniq ids respect to Event
    SET<integer> localInts = new SET<integer>();
    localInts  = ForUniqNo.eams(trigger.new[0].Ev_id__c); 
  
 for(Event_Attendee_Mapping__c eamnew : trigger.new){
  string barcode=String.valueOf(eamnew.id +'-'+ eamnew.EV_id__c);
  Event_Attendee_Mapping__c EAM=new Event_Attendee_Mapping__c(id = eamnew .id,EA_AttendeeBarcode__c = barcode );
  eamlist.add(eam);
  evid =eamnew.EV_id__c;
   integer random = (integer) (Math.random() * (99999-10000))+10000;
   
     if(localInts.contains(random)){
        for(integer d=0;d<=1000;d++){
           random = (integer) (Math.random() * (99999-10000))+10000;
            if(!localInts.contains(random)){
               EAM.UniqNo__c= string.valueOf(random);
               localInts.add(random);
               Break;
            }
        }
     } else{
        EAM.UniqNo__c= String.valueOf(random);
        localInts.add(random);
     }
     
     
  sttid.add(eamnew.id);
 }
 
Upsert eamlist;

list<Event_Attendee_Mapping__c> eamlist2 =[SELECT id,AS_id__c,AS_id__r.id from Event_Attendee_Mapping__c WHERE id IN: sttid  ];
Event__c ev= [SELECT id,Is_Webank_event__c,Owner.Username FROM Event__c WHERE id=: evid ];

if(ev.Is_Webank_event__c == true){
 set<id> sttid1 = new set<id> ();
 
for(Event_Attendee_Mapping__c eamnew2 : eamlist2 ){
sttid1.add(eamnew2.AS_id__c);
}
system.debug('ssssssssssssssssssssssssssssssssssssssssssss'+sttid);

list<MBE_Profile__c> mbeprolist =new list<MBE_Profile__c>();
mbeprolist =  [select id,AttendeeSummary__r.id,Event_Organizer_Id__c from MBE_Profile__c Where Event_Organizer_Id__c =: ev.Owner.Username ];
MAP<string,MBE_Profile__c> mbemap = new MAP<string,MBE_Profile__c>();
for(MBE_Profile__c mm: mbeprolist ){
mbemap.put(mm.AttendeeSummary__r.id,mm);

}


List<AttendeeSummary__c> attlist = [Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                          a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                          a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                          a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Keywords__c,
                          a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                          a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                          a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                          a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, a.Company_Certifications__c,
                          a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                          a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                          a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                          a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                          a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                          a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                          a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,a.AS_BusinessTaxId__c,a.AS_WorkZip__c,a.AS_HomeZip__c,a.AS_shippingzip__c,
                          a.DBA__c,
                          a.Ethnicity__c,
                          a.Business_Structure__c,
                          
                          a.AS_Secondary_Email__c,
                          a.Geographical_Region__c,
                          a.Certificate_Processed_by_RPO__c,
                          a.BBB_Number__c,
                          a.Commodity_1__c,
                          a.Commodity_2__c,
                          a.Commodity_3__c,
                          a.Commodity_4__c,
                          a.Commodity_5__c,
                          a.AS_NAICSCode6__c,
                          a.AS_NAICSCode7__c,
                          a.AS_NAICSCode8__c,
                          a.AS_NAICSCode9__c,
                           a.distribution_Country__c,
                         a.Manufactures_Country__c,
                          a.References__c,
                          a.Revenue_Range__c, 
                          a.Any_non_WBENC_awards_received__c,
                          a.Companyhaveafacility_partneroutsideUSA__c,    
                          AS_BusinessDunsNumber__c,(SELECT Id, Name,Description,ContentType FROM Attachments),(select id,YouTubeId_c__c From Widgets__r) From AttendeeSummary__c a Where a.id IN :sttid1];
         // List<Widget__c> wid = new list<Widget__c>();
          // wid = [select id,YouTubeId_c__c From Widget__c Where AttendeeSummary__r.id =: attlist[0].id];
  //attachments att = [Select Id, Name,Description,ContentType FROM Attachments Where parentId =: attlist[0].id]; 
  
  Custom_Widget__c cyoutubelink = new Custom_Widget__c();
  list<Custom_Widget__c> totallinks = new list<Custom_Widget__c>();
  mbeprolist= new List<MBE_Profile__c>();
    for(AttendeeSummary__c at: attlist){
    system.debug(':::::::::::::::::::mbe map:::::::::::::'+mbemap.get(at.id));
        if((mbemap.get(at.id)== null)){
        system.debug(':::::::::::::::::::mbe map:::::::::::::'+mbemap.get(at.id));
           //cyoutubelink = new Custom_Widget__c();
            MBE_Profile__c mp = new MBE_Profile__c();
            mp.Event_Organizer_Id__c = ev.Owner.Username;
            mp.Key_Words__c = at.Keywords__c;
            mp.AS_BusinessDunsNumber__c = at.AS_BusinessDunsNumber__c;
            mp.AS_BusinessTaxId__c = at.AS_BusinessTaxId__c;
            mp.AS_BusinessDescription__c = at.AS_BusinessDescription__c;
            mp.Business_type__c = at.Business_type__c;
            mp.AS_BusinessRevenue__c = at.AS_BusinessRevenue__c;
            mp.AS_BusinessEstablishedDate__c = at.AS_BusinessEstablishedDate__c;
            mp.AS_CageCode__c = at.AS_CageCode__c;
            mp.AS_WebsiteUrl__c = at.AS_WebsiteUrl__c;
            mp.AS_DiversityType__c = at.AS_DiversityType__c;
            mp.GSA_Schedule__c = at.GSA_Schedule__c;
            mp.AS_NumberOfEmployees__c = at.AS_NumberOfEmployees__c;
            mp.AS_PrimaryBusinessCategory1__c = at.AS_PrimaryBusinessCategory1__c;
            mp.As_SecondaryBusinessCategory1__c = at.As_SecondaryBusinessCategory1__c;
            mp.Company_Certifications__c = at.Company_Certifications__c;
            mp.AS_CellPhone__c  = at.AS_CellPhone__c;
            mp.AS_Company__c = at.AS_Company__c;
            mp.AS_Email__c = at.AS_Email__c;
            mp.AS_FirstName__c = at.AS_FirstName__c;
            mp.As_Home_Country__c = at.As_Home_Country__c;
            mp.As_Home_State__c = at.As_Home_State__c;
            mp.AS_HomeZip__c = at.AS_HomeZip__c;
            mp.AS_LastName__c = at.AS_LastName__c;
            mp.As_prefixNew__c = at.As_prefixNew__c;
            mp.AS_shippingzip_c__c = at.AS_shippingzip__c;
            mp.As_SuffixNew__c = at.As_SuffixNew__c;
            mp.AS_Title__c = at.AS_Title__c;
            mp.AS_Work_States__c = at.AS_Work_States__c;
            mp.AS_WorkAddress1__c = at.AS_WorkAddress1__c;
            mp.AS_WorkAddress2__c = at.AS_WorkAddress2__c;
            mp.AS_WorkCity__c = at.AS_WorkCity__c;
            mp.AS_WorkPhone__c = at.AS_WorkPhone__c;
            mp.AS_WorkZipCode__c = at.AS_WorkZipCode__c;
            mp.AS_WorkZip__c = at.AS_WorkZip__c;
            mp.AS_Work_Country__c = at.AS_Work_Country__c;
            mp.As_NAICSCode_1__c = at.As_NAICSCode_1__c;
            mp.As_NAICSCode_2__c = at.As_NAICSCode_2__c;
            mp.As_NAICSCode_3__c = at.As_NAICSCode_3__c;
            mp.As_NAICSCode_4__c = at.As_NAICSCode_4__c;
            mp.As_NAICSCode_5__c = at.As_NAICSCode_5__c;
            mp.AS_NAICSCode6__c = at.AS_NAICSCode6__c;
            mp.AS_NAICSCode7__c = at.AS_NAICSCode7__c;
            mp.AS_NAICSCode8__c = at.AS_NAICSCode8__c;
            mp.AS_NAICSCode9__c = at.AS_NAICSCode9__c;
            mp.DBA__c = at.DBA__c;
            mp.Geographical_Region__c = at.Geographical_Region__c;
            mp.Certificate_Processed_by_RPO__c = at.Certificate_Processed_by_RPO__c;
            mp.BBB_Number__c = at.BBB_Number__c;
            mp.Commodity_1__c = at.Commodity_1__c;
            mp.Commodity_2__c = at.Commodity_2__c;
            mp.Commodity_3__c = at.Commodity_3__c;
            mp.Commodity_4__c = at.Commodity_4__c;
            mp.Commodity_5__c = at.Commodity_5__c;
            mp.distribution_Country__c = at.distribution_Country__c;
            mp.Manufactures_Country__c =at.Manufactures_Country__c;
            mp.References__c = at.References__c;
            mp.Revenue_Range__c = at.Revenue_Range__c;
            mp.AS_ImageUrl__c = at.AS_ImageUrl__c;
            mp.AttendeeSummary__c = at.id;
            mp.Ethnicity__c = at.Ethnicity__c;
            mp.Companyhaveafacility_partneroutsideUSA__c = at.Companyhaveafacility_partneroutsideUSA__c;
            mp.Any_non_WBENC_awards_received__c  = at.Any_non_WBENC_awards_received__c;  
          mp.Business_Structure__c = at.Business_Structure__c;
          mp.AS_FaxNumber__c = at.AS_FaxNumber__c ;
          mp.AS_Secondary_Email__c = at.AS_Secondary_Email__c;
            mbeprolist.add(mp);
            
                   
        }else{
       /** MBE_Profile__c mp = new MBE_Profile__c();
          mp =  [Select  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                          a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                          a.AS_WorkZipCode__c,a.AS_WorkPhone__c, 
                          a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, a.Key_Words__c,
                          a.AS_WebsiteUrl__c, a.AS_Title__c, 
                          a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                          a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                          a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                          a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                          a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                          a.AS_HomePhone__c,a.AS_HomeCity__c,
                          a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                          a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                          a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,a.Exceptional_Key_Words__c,
                          a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                          a.AS_BusinessDunsNumber__c,a.AS_BusinessTaxId__c,a.Company_Certifications__c from MBE_Profile__c a Where id =: mbemap.get(at.id).id];
                  
            
            mp.Event_Organizer_Id__c = ev.Owner.Username;
            mp.Key_Words__c = at.Keywords__c;
            mp.AS_BusinessDunsNumber__c = at.AS_BusinessDunsNumber__c;
            mp.AS_BusinessTaxId__c = at.AS_BusinessTaxId__c;
            mp.AS_BusinessDescription__c = at.AS_BusinessDescription__c;
            mp.Business_type__c = at.Business_type__c;
            mp.AS_BusinessRevenue__c = at.AS_BusinessRevenue__c;
            mp.AS_BusinessEstablishedDate__c = at.AS_BusinessEstablishedDate__c;
            mp.AS_CageCode__c = at.AS_CageCode__c;
            mp.AS_WebsiteUrl__c = at.AS_WebsiteUrl__c;
            mp.AS_DiversityType__c = at.AS_DiversityType__c;
            mp.GSA_Schedule__c = at.GSA_Schedule__c;
            mp.AS_NumberOfEmployees__c = at.AS_NumberOfEmployees__c;
            mp.AS_PrimaryBusinessCategory1__c = at.AS_PrimaryBusinessCategory1__c;
            mp.As_SecondaryBusinessCategory1__c = at.As_SecondaryBusinessCategory1__c;
            mp.Company_Certifications__c = at.Company_Certifications__c;
            mp.AS_CellPhone__c  = at.AS_CellPhone__c;
            mp.AS_Company__c = at.AS_Company__c;
            mp.AS_Email__c = at.AS_Email__c;
            mp.AS_FirstName__c = at.AS_FirstName__c;
            mp.As_Home_Country__c = at.As_Home_Country__c;
            mp.As_Home_State__c = at.As_Home_State__c;
            mp.AS_HomeZip__c = at.AS_HomeZip__c;
            mp.AS_LastName__c = at.AS_LastName__c;
            mp.As_prefixNew__c = at.As_prefixNew__c;
            mp.AS_shippingzip_c__c = at.AS_shippingzip__c;
            mp.As_SuffixNew__c = at.As_SuffixNew__c;
            mp.AS_Title__c = at.AS_Title__c;
            mp.AS_Work_States__c = at.AS_Work_States__c;
            mp.AS_WorkAddress1__c = at.AS_WorkAddress1__c;
            mp.AS_WorkAddress2__c = at.AS_WorkAddress2__c;
            mp.AS_WorkCity__c = at.AS_WorkCity__c;
            mp.AS_WorkPhone__c = at.AS_WorkPhone__c;
            mp.AS_WorkZipCode__c = at.AS_WorkZipCode__c;
            mp.AS_WorkZip__c = at.AS_WorkZip__c;
            mp.AS_Work_Country__c = at.AS_Work_Country__c;
            mp.As_NAICSCode_1__c = at.As_NAICSCode_1__c;
            mp.As_NAICSCode_2__c = at.As_NAICSCode_2__c;
            mp.As_NAICSCode_3__c = at.As_NAICSCode_3__c;
            mp.As_NAICSCode_4__c = at.As_NAICSCode_4__c;
            mp.As_NAICSCode_5__c = at.As_NAICSCode_5__c;
            mp.AS_NAICSCode6__c = at.AS_NAICSCode6__c;
            mp.AS_NAICSCode7__c = at.AS_NAICSCode7__c;
            mp.AS_NAICSCode8__c = at.AS_NAICSCode8__c;
            mp.AS_NAICSCode9__c = at.AS_NAICSCode9__c;
            mp.AS_ImageUrl__c = at.AS_ImageUrl__c;
            mp.DBA__c = at.DBA__c;
            mp.Geographical_Region__c = at.Geographical_Region__c;
            mp.Certificate_Processed_by_RPO__c = at.Certificate_Processed_by_RPO__c;
            mp.BBB_Number__c = at.BBB_Number__c;
            mp.Commodity_1__c = at.Commodity_1__c;
            mp.Commodity_2__c = at.Commodity_2__c;
            mp.Commodity_3__c = at.Commodity_3__c;
            mp.Commodity_4__c = at.Commodity_4__c;
            mp.Commodity_5__c = at.Commodity_5__c;
            mp.distribution_Country__c = at.distribution_Country__c;
            mp.Manufactures_Country__c =at.Manufactures_Country__c;
            mp.References__c = at.References__c;
            mp.Revenue_Range__c = at.Revenue_Range__c; 
            mp.AttendeeSummary__c = at.id;
            mbeprolist.add(mp);
        
        */
        
        }
     

    }
    database.upsert(mbeprolist,false);
    /**if(wid[0].YouTubeId_c__c != null && wid[0].YouTubeId_c__c != ''){
    cyoutubelink.YouTubeId_c__c = wid[0].YouTubeId_c__c;
    cyoutubelink.MBE_Profile__c = mbeprolist[0].id;
    insert cyoutubelink;
    
    }*/
    
    set<id> MID = new SET<id>();
    for(MBE_Profile__c m: mbeprolist){
    MID.add(m.id);
    }
  list<MBE_Profile__c> mbeprolist1 = [select id,AttendeeSummary__r.id from MBE_Profile__c where Event_Organizer_Id__c =: ev.Owner.Username ];
MAP<string,string> mbemap1 = new MAP<string,string>();
for(MBE_Profile__c mmm: mbeprolist1 ){
mbemap1.put(mmm.AttendeeSummary__r.id,mmm.id);

}
system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmap'+mbemap1); 
list<Event_Attendee_Mapping__c> eamlist1=new list<Event_Attendee_Mapping__c>{}; 

 for(Event_Attendee_Mapping__c eamnew1 : eamlist2 ){
  system.debug('ddddddddddddddddd'+mbemap1.get(eamnew1.AS_id__r.id));
     eamnew1.MBE_Profile__c =  mbemap1.get(eamnew1.AS_id__r.id);
     eamlist1.add(eamnew1);
 }
Upsert eamlist1;
//}
//}catch(Exception e){}

}
}
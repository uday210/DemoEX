//This class is for search values in object fields this will return string with all rec values
/** 
   Author : Phani Kumar Ch
   Date : 05-08-2015 
**/ 
public class MM_GlobalSearch{
  public String Gnsearch(Event_Attendee_Mapping__c Eam,boolean b){
    String strValue ='';
    if(b){
    strValue+=Eam.MBE_Profile__r.AS_FirstName__c+',';
    strValue+=Eam.MBE_Profile__r.AS_LastName__c+',';
    strValue+=Eam.MBE_Profile__r.FullName__c+',';
    strValue+=Eam.MBE_Profile__r.AS_Email__c+',';
    strValue+=Eam.MBE_Profile__r.AS_Company__c+',';
    strValue+=Eam.MBE_Profile__r.Key_Words__c+',';
    strValue+=Eam.MBE_Profile__r.As_NAICSCode_1__c+',';
    strValue+=Eam.MBE_Profile__r.As_NAICSCode_2__c+',';
    strValue+=Eam.MBE_Profile__r.As_NAICSCode_3__c+',';
    strValue+=Eam.MBE_Profile__r.As_NAICSCode_4__c+',';
    strValue+=Eam.MBE_Profile__r.As_NAICSCode_5__c+',';
    
    strValue+=Eam.MBE_Profile__r.AS_NAICSCode6__c+',';
    strValue+=Eam.MBE_Profile__r.AS_NAICSCode7__c+',';
    strValue+=Eam.MBE_Profile__r.AS_NAICSCode8__c+',';
    strValue+=Eam.MBE_Profile__r.AS_NAICSCode9__c+',';
    strValue+=Eam.MBE_Profile__r.Year_in_business__c+',';
    strValue+=Eam.MBE_Profile__r.References__c+',';
    strValue+=Eam.MBE_Profile__r.References2__c+',';
    strValue+=Eam.MBE_Profile__r.Scope_of_Work__c+',';
    strValue+=Eam.MBE_Profile__r.Scope_of_Work2__c+',';
    strValue+=Eam.MBE_Profile__r.Revenue_Range__c+',';
    
    
    strValue+=Eam.MBE_Profile__r.Commodity_1__c+',';
    strValue+=Eam.MBE_Profile__r.Commodity_2__c+',';
    strValue+=Eam.MBE_Profile__r.Commodity_3__c+',';
    strValue+=Eam.MBE_Profile__r.Commodity_4__c+',';
    strValue+=Eam.MBE_Profile__r.Commodity_5__c+',';
   if(Eam.DiversityType__c!=null ){ 
     try{
      strValue+=string.valueOf(Eam.DiversityType__c)+',';
      }catch(exception er){}
    }
    strValue+=Eam.MBE_Profile__r.GSA_Schedule__c+',';
    strValue+=Eam.MBE_Profile__r.AS_BusinessRevenue__c+',';
    strValue+=Eam.MBE_Profile__r.AS_NumberOfEmployees__c+',';
    strValue+=Eam.MBE_Profile__r.Geographical_Region__c+',';
    strValue+=Eam.MBE_Profile__r.Company_Certifications__c+',';
    strValue+=Eam.MBE_Profile__r.AS_PrimaryBusinessCategory1__c+',' ;
    strValue+=Eam.MBE_Profile__r.AS_CellPhone__c+',';
    strValue+=Eam.MBE_Profile__r.AS_Work_States__c;
      if(strValue!=''){
         strValue = strValue.toLowerCase();
      }
  }else{

strValue+=Eam.AS_Id__r.AS_FirstName__c+',';
    strValue+=Eam.AS_Id__r.AS_LastName__c+',';
    strValue+=Eam.AS_Id__r.FullName__c+',';
    strValue+=Eam.AS_Id__r.AS_Email__c+',';
    strValue+=Eam.AS_Id__r.AS_Company__c+',';
    //strValue+=Eam.AS_Id__r.Key_Words__c+',';
    strValue+=Eam.AS_Id__r.As_NAICSCode_1__c+',';
    strValue+=Eam.AS_Id__r.As_NAICSCode_2__c+',';
    strValue+=Eam.AS_Id__r.As_NAICSCode_3__c+',';
    strValue+=Eam.AS_Id__r.As_NAICSCode_4__c+',';
    strValue+=Eam.AS_Id__r.As_NAICSCode_5__c+',';
    
    strValue+=Eam.AS_Id__r.AS_NAICSCode6__c+',';
    strValue+=Eam.AS_Id__r.AS_NAICSCode7__c+',';
    strValue+=Eam.AS_Id__r.AS_NAICSCode8__c+',';
    strValue+=Eam.AS_Id__r.AS_NAICSCode9__c+',';
    strValue+=Eam.AS_Id__r.Year_in_business__c+',';
    strValue+=Eam.AS_Id__r.References__c+',';
    strValue+=Eam.AS_Id__r.References2__c+',';
    strValue+=Eam.AS_Id__r.Scope_of_Work__c+',';
    strValue+=Eam.AS_Id__r.Scope_of_Work2__c+',';
    strValue+=Eam.AS_Id__r.Revenue_Range__c+',';
   
    
    strValue+=Eam.AS_Id__r.Commodity_1__c+',';
    strValue+=Eam.AS_Id__r.Commodity_2__c+',';
    strValue+=Eam.AS_Id__r.Commodity_3__c+',';
    strValue+=Eam.AS_Id__r.Commodity_4__c+',';
    strValue+=Eam.AS_Id__r.Commodity_5__c+',';
    
    
   if(Eam.DiversityType__c!=null ){ 
     try{
      strValue+=string.valueOf(Eam.DiversityType__c)+',';
      }catch(exception er){}
    }
    strValue+=Eam.AS_Id__r.GSA_Schedule__c+',';
    strValue+=Eam.AS_Id__r.AS_BusinessRevenue__c+',';
    strValue+=Eam.AS_Id__r.AS_NumberOfEmployees__c+',';
    strValue+=Eam.AS_Id__r.Geographical_Region__c+',';
    strValue+=Eam.AS_Id__r.Company_Certifications__c+',';
    strValue+=Eam.AS_Id__r.AS_PrimaryBusinessCategory1__c+',' ;
    strValue+=Eam.AS_Id__r.AS_CellPhone__c+',';
    strValue+=Eam.AS_Id__r.AS_Work_States__c;
      
      if(strValue!=''){
         strValue = strValue.toLowerCase();
      }


  }
   return strValue;
   }

}
public class Blfee{
public static decimal blf(){
      List<App_Settings__c> AappSettingsFee = [select id,User_Type__c,Secret_Id__c,Redirect_URL__c,Paypal_Key__c,Fee__c,Client_Id__c from App_Settings__c where User_Type__c='Boohtleads' ];
        Decimal  AppFee  =0.0;
          if(AappSettingsFee.size()>0){
            AppFee  = AappSettingsFee [0].Fee__c;
          }else{
             AppFee  = 0.75;
          }
   return AppFee  ;
}

 

}
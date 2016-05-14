public with sharing class BLN_Pay_Address_DAO{

/***********************************************************************************************
*   Controller Name         : BLN_Pay_Address_DAO
*   Date                    : 16/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This class is for inserting and retrieving pay address.
**************************************************************************************************/
    
    // This method is used for inserting pay address during payments.
    public BLN_StatusMessage insertPayAddress(Pay_Address__c PayAddress){
        Database.Upsertresult PayAddressResult = Database.Upsert(PayAddress,false);
        return new BLN_StatusMessage(PayAddressResult);
    }
    //This method is used for getting payment address to show as a billing address in profile page
    public List<Pay_Address__c> getbillingAddress(string cid){
    List<Pay_Address__c> billingaddress = [select id,City__c,Company__c,BLN_Country__c,
                                                  BLN_State__c,Street1_Address__c,Street2_Address__c,Zip__c from Pay_Address__c where Company__c = : cid ];
    return billingaddress;
    }
    
    //This method is used get list of billing adresses for selected company
    public List<Pay_Address__c> billingAddrssForReport(set<id> companyId){
    List<Pay_Address__c> billingaddress = [select id,City__c,Company__c,BLN_Country__c,BLN_Country__r.long_name__c,BLN_State__r.long_name__c,
                                                  BLN_State__c,Street1_Address__c,Street2_Address__c,Zip__c from Pay_Address__c where Company__c in : companyId ];
    
    if(billingaddress.size() > 0){
            return billingaddress;
        }else{
            return new List<Pay_Address__c>();
        }
    }
    
    
    public BLN_StatusMessage insertPayAddressprocess(String event,String OrderCompanyId,String OrderUserId)
    {
        //Insert Pay Address
        BLN_Pay_Address_DAO PayAddressDAO = new BLN_Pay_Address_DAO();
        Pay_Address__c PayAddress = new Pay_Address__c();
        PayAddress.Event__c = event;
        PayAddress.Company__c = OrderCompanyId;
        PayAddress.GN_User__c = OrderUserId;
        BLN_StatusMessage PayAddressMessage = PayAddressDAO.insertPayAddress(PayAddress);
        return PayAddressMessage;
        
    }

}
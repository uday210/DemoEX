public without sharing class BLN_Hash_Tag_DAO{
  /**
* @author :Unni Krishna
* @date 17/07/2014
* @ This class is used for DML operations on Hash Tag object
*/ 

    public List<Hash_Tag__c> getTags(String fields,String whereCondition){
        List<Hash_Tag__c> tc;
        String sql='select '+fields+' from Hash_Tag__c  where '+whereCondition;
        tc=Database.query(sql);
        return tc;    
    }
    
// ------------------------------------------------------------------------------------------- Edit By Mahesh Sakunala Start ------------------------------------------------------------------------------------------
    // This Method is used to fetch all the tags and related registration tabs based on the Event Id as a parameter
    public List<Hash_Tag__c> getEventTags(String EventId){
        List<Hash_Tag__c> TagList = [SELECT RowId__c,Table_Name__c,Tag_Text__c,Event__c
                                     FROM Hash_Tag__c 
                                     WHERE Event__c =:EventId];
        return TagList;    
    }

// ------------------------------------------------------------------------------------------- Edit By Mahesh Sakunala End  ------------------------------------------------------------------------------------------   
   public List<Hash_Tag__c> getTags(LIst<id> ticids){
       return [SELECT BLN_Item_Pool__c,lastmodifieddate,Event__c,IsDefault__c,ParentId__c,RowId__c,Table_Name__c,Tag_Text__c from Hash_Tag__c where RowId__c IN :ticids];
   }




}
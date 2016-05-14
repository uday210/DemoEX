public class BLN_Hash_Tag_BAL
{

/**************************************************
* @author :Unni krishna
* @date 07/17/2014
* @ This class is used for Hash tags module
****************************************************/ 
    
    //Creating the method for Hashtags& fetching the parameters form DAO
    public List<Hash_Tag__c> gethashtags(String FilteredString){     
        BLN_Hash_Tag_DAO tcdao=new BLN_Hash_Tag_DAO();
        List<Hash_Tag__c> tgs= tcdao.getTags('RowId__c,Table_Name__c,Tag_Text__c,Event__c','ORDER BY '+FilteredString);
        return tgs;
    }
    
    //Creating the method for Hashtags& fetching the parameters form DAO
    public List<Hash_Tag__c> getEventTags(String EventId){     
        BLN_Hash_Tag_DAO TagDAO = new BLN_Hash_Tag_DAO();
        List<Hash_Tag__c> Tags= TagDAO.getEventTags(EventId);
        return Tags;
    }
}
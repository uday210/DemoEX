@isTest
public class Test_BLN_StatusMessage {

    public static testMethod void testmethod_BLN_StatusMessage() {
        
        BLN_StatusMessage blnstatmsg = new BLN_StatusMessage (); 
        
        list<account> acc= new list<account>();
        Account a1= new Account();
        a1.name='test';
        acc.add(a1);
        Database.SaveResult[] upRes=database.insert(acc,false);
        BLN_StatusMessage blnstatmsg1 = new BLN_StatusMessage(upRes);
        
        account a2=new account();
        a2.name='test2';
        database.saveresult ss=database.insert(a2,false);
        BLN_StatusMessage blnstatmsg2 = new BLN_StatusMessage (ss);
        
        Schema.SObjectField f = Account.Fields.id;
        a2.name='test3';
        database.UpsertResult upRes1 =Database.upsert(a2,f,false);
        BLN_StatusMessage blnstatmsg3 = new BLN_StatusMessage(upRes1);
        
        
    }
    
}
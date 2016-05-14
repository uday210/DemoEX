@isTest
public class Test_BLN_BatchListIteratorEBMT{
public static testmethod void Test_BLN_BatchListIteratorEBMT(){
List<Participant> records;
BLN_BatchListIteratorEBMT s = new BLN_BatchListIteratorEBMT(records);
try{
s.hasNext();
}catch(Exception e){}
try{
s.Next();
}catch(Exception e){}
try{
s.Iterator();
}catch(Exception e){}

}

}
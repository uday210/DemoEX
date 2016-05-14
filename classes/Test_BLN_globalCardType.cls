@istest(SeeAllData=true)
public class Test_BLN_globalCardType{
    static testmethod void Test_BLN_globalCardType(){
        BLN_globalCardType cardvalid =new BLN_globalCardType();
        cardvalid.GetCreditCardType('4242424242424242');
        cardvalid.GetCreditCardType('5555555555554444');
        cardvalid.GetCreditCardType('378282246310005');
        cardvalid.GetCreditCardType('30569309025904');
        cardvalid.GetCreditCardType('6011111111111117');
        cardvalid.GetCreditCardType('3530111333300000');


}

}
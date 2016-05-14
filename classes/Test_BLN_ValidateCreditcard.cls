@isTest(seeAllData=True)
public class Test_BLN_ValidateCreditcard {

static testmethod void Test_BLN_ValidateCreditcard(){
BLN_ValidateCreditcard vlcard = new BLN_ValidateCreditcard();
BLN_ValidateCreditcard.ValidateCreditcard('41111111111111111','visa','2016','05','123');
BLN_ValidateCreditcard.ValidateCheck('12345');
BLN_ValidateCreditcard.validateEmail('test@gmail.com');

BLN_ValidateCreditcard.ValidateCreditcard('41111111111111111 ','visa','15','5','112 ');
BLN_ValidateCreditcard.ValidateCreditcard('41111111111111111 ','visa','15','5','abc ');
BLN_ValidateCreditcard.ValidateCreditcard('41111111111111111','American Express','2016','05','123');
BLN_ValidateCreditcard.ValidateCreditcard(' ','American Express','16','05','123');
BLN_ValidateCreditcard.ValidateCreditcard('41111111111111111','American Express1','15','05','12');

BLN_ValidateCreditcard.ValidateCreditcard('41111111a11111111','v','2015','10','1');
  
BLN_ValidateCreditcard.ValidateCreditcard('1111111111111111','American Express1','2015','10','1a');
BLN_ValidateCreditcard.ValidateCreditcard('1111111111111111','American Express1','2015','10','12');
BLN_ValidateCreditcard.ValidateCreditcard('1111111111111111','American Express1','2015','10',' ');
}
}
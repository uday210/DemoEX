@isTest
public class Test_globalTimeConvertion {

    public static testMethod void testdoget(){
      globalTimeConvertion GTC = new globalTimeConvertion();
      Time myTime = Time.newInstance(12, 30, 2, 20);
      GTC.timeTostring(myTime);
        Time myTime1= Time.newInstance(18, 30, 2, 20);
       GTC.timeTostring(myTime1);
        Time myTime2= Time.newInstance(2, 30, 2, 20);
        GTC.timeTostring(myTime2);
       
      GTC.stringTotime('5:00 PM');
      
    }
    
 }
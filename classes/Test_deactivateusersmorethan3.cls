@isTest
public class Test_deactivateusersmorethan3 {

public static testMethod void testschedule() {
Test.StartTest();
deactivateusersmorethan3  dec = new deactivateusersmorethan3 ();

system.schedule('Job1', '0 0 20 * * ? 2016', new deactivateusersmorethan3());


         
         
         
Test.stopTest();

}

}
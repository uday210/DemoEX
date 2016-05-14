/******************************************************
*   Author                  : Rajendra Y
*   Date                    : 16/12/2014 
*   Purpose                 : This is Testclass for BLN_ASC_deleteTickets .


********************************************************/

@isTest
public class Test_BLN_ASC_deleteTickets
{
 static testmethod void Testmethod_BLN_ASC_deleteTickets(){
 
 User U= new User();
            globalForTestClass globalTest= new globalForTestClass();
            U= globalTest.createUser();
             system.runas(U)
    {
   System.RestContext.request = new RestRequest();
     RestContext.request.requestURI ='/GlobalnestEM/BLN_ASC_deleteTickets';
      BLN_ASC_deleteTickets.doPost();
 }
 }
}
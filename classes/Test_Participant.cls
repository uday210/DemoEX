@isTest
public class Test_Participant{

 public static testMethod void Testmethod_Participant() {
 Participant p=new Participant();
 System.assertEquals(null, p.Identifier);
 System.assertEquals(null, p.FirstName);
 System.assertEquals(null, p.LastName);
 System.assertEquals(null, p.Email);
 System.assertEquals(null, p.StatusCode);
 System.assertEquals(null, p.Title);
 System.assertEquals(null, p.CompanyName);
 System.assertEquals(null, p.Street);
 System.assertEquals(null, p.ZipCode);
 System.assertEquals(null, p.City);
 System.assertEquals(null, p.State);
 System.assertEquals(null, p.Country);
 System.assertEquals(null, p.LastModificationDate);
 
 }
 
}
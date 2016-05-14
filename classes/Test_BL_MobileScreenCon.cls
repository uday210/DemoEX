@istest

public class Test_BL_MobileScreenCon
{
  static testmethod void BL_MobileScreenCon_testmethod()
  {

    contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
   
       Profile w = [select id from profile where name='Standard User'];
       
   User u = new User(alias = 'tesft123', email='tesfft123@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='tesfft123@noemail.com');

         insert u;
         Id eventAdminId=u.id;    


   Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  customProfileBooth;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;

 Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100);
      insert booth1;

   Booth_Qrcode__c bothQr=new Booth_Qrcode__c(Address__c='Add1',Address_2__c='add2',Booth__c=booth1.Id,City__c='city',Company__c='company',Country__c='India',Email_Address__c='phani@globalnest.com',Event__c=EventId,
   isSelected__c=true,Link_LabelName__c='phani Link',Name__c='phani label',Phone_number__c='9999999999',Pin_code__c='98768',Registration_Link__c='www.globalnest.com',
   Site_Name__c='www.boothleads.com',State__c='Ap',Title__c='Developer',Website_URL__c='www.globalnest.com',Data_Types__c='Contact Information');
   insert bothQr ;


    attachment a = new attachment();
     blob b=blob.valueOf('phani');
     a.parentId=bothQr.Id;
     a.Name ='Android.Vcf';  
     a.body =b;   
    insert a;
    
pageReference pageRef = page.BL_MobileScreen;
     Test.setCurrentpage(pageRef);
     
     ApexPages.currentpage().getParameters().put('VId','1');
     ApexPages.currentpage().getParameters().put('Id',booth1.Id);
     ApexPages.currentpage().getParameters().put('EId',eventId);
     BL_MobileScreenCon MBS = new BL_MobileScreenCon();
    
     ApexPages.currentPage().getHeaders().put('User-Agent','Android');
      MBS.login1();
      MBS.QueryContactInformation();
     MBS.interested();
    MBS.send();
MBS.cancel();
}
}
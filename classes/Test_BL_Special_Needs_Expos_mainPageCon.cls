@isTest
private class Test_BL_Special_Needs_Expos_mainPageCon {

    static testMethod void myUnitTest() {
      Event__c eve = new Event__c(EV_Title__c='TestEvent');
      insert eve;
  
   PageReference pg = Page.BL_Special_Needs_Expos_mainpage;
   Test.setCurrentPage(pg); 
   ApexPages.currentPage().getParameters().put('id', eve.id);
  BL_Special_Needs_Expos_mainPageCon BL_spcon = new BL_Special_Needs_Expos_mainPageCon();
  
  
    }
}
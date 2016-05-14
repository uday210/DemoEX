@isTest
public with sharing class Test_DeveloperConsole{
  static testMethod void unitTest(){
    DeveloperConsole dev = new DeveloperConsole();
    dev.quertstr  = 'select id from account limit 1';
    dev.getResult();
  }

}
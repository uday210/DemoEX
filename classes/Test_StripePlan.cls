@istest

public class Test_StripePlan{
  static testmethod void unittest(){
    StripePlan str = new StripePlan('');
    str.createPlan('4242424242424242','','1000','usd','description');
    str.retrievePlan('');
    
  }
}
public class StripeCardResponseModel{
    
/****************************************************************************************************
*   Controller Name         : StripeCardResponseModel
*   Date                    : 19/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This model class is for constructing stripe card response post transaction.
*****************************************************************************************************/
    
    public string country {get;set;}
    public string appfee {get;set;}
    public string cObject {get;set;}
    public string cvc_check {get;set;}
    public string ctype {get;set;}
    public string exp_month {get;set;}
    public string exp_year {get;set;}
    public string last4 {get;set;}
}
public class StripeErrorModel{

/****************************************************************************************************
*   Controller Name         : StripeErrorModel
*   Date                    : 19/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This model class is for constructing stripe card error post transaction.
*****************************************************************************************************/

    public Integer code {get;set;}
    public string message {get;set;}
    public string param {get;set;}
    public string error_type {get;set;}
}
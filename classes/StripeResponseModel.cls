public class StripeResponseModel{
    
/*******************************************************************************************************************
*   Controller Name         : StripeResponseModel
*   Date                    : 19/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This model class is for constructing stripe card response and error post transaction.
*******************************************************************************************************************/
    
    public string id {get;set;}
    public string rObject{get;set;}
    public string amount {get;set;}
    public string paid {get;set;}
    public String appfee{get;set;}
    public String curency{get;set;}
    public string fee {get;set;}
    public string created {get;set;}
    public string livemode {get;set;}
    public string description {get;set;}
    public string refunded {get;set;}
    public boolean isError {get;set;}
    public String name{get;set;}
    public String interval{get;set;}
    
    public StripeCardResponseModel card {get;set;}
    public StripeErrorModel errorResponse {get;set;}
    
    public StripeResponseModel(){
        card=new StripeCardResponseModel();
        errorResponse=new StripeErrorModel();
    }
}
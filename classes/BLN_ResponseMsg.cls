global with sharing class BLN_ResponseMsg {
    public  String titleStr{get;set;}
    public  String message{get;set;}
    public  boolean validbadge{get;set;}  
    
    global  void ldvalueAssign(String title,String msg,boolean statusbool){
        titleStr =title;
        message =msg;
        validbadge = statusbool;
    } 
   
}
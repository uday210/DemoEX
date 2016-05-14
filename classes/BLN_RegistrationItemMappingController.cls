public with sharing class BLN_RegistrationItemMappingController {
public BLN_Template__c bt{get;set;}
public List<SelectOption> itemoptions{get;set;}
public String selecteditemid{get;set;}

public BLN_RegistrationItemMappingController (){

bt=[select id,name,Template_Name__c,HTML__c from BLN_Template__c where id=:ApexPages.currentPage().getParameters().get('templateid') and BLN_Events__c=:ApexPages.currentPage().getParameters().get('id') limit 1];
List<BLN_Item__c> blitemlist=[select id,name,item_name__c from BLN_Item__c where event__c=:ApexPages.currentPage().getParameters().get('id')];
 itemoptions=new List<SelectOption>();
    itemoptions.add(new SelectOption('','--None--'));
    itemoptions.add(new SelectOption('Buyer','Buyer'));
    for(BLN_Item__c blitem:blitemlist)
    {
    itemoptions.add(new SelectOption(blitem.id,blitem.item_name__c));
    }
}
 public class MapClass
   {
     public String htmlfield{get;set;}
     public String regfield{get;set;}
     
   }
   public List<MapClass> gridrows{get;set;}
   public List<SelectOption> fieldsoptions{get;set;}
    public PageReference GetMapping() {
   
    String allhtmlfield=apexpages.currentpage().getparameters().get('fieldnames');
    List<String> eachhtmlfield=allhtmlfield.split(',');
    gridrows=new List<MapClass>();
    
    selecteditemid=apexpages.currentpage().getparameters().get('selecteditem');
    List<Reg_Setting__c> regSettings = new List<Reg_Setting__c>();
    BLN_Reg_Settings_DAO regDao=new BLN_Reg_Settings_DAO();
    if(selecteditemid=='Buyer')
    regSettings = regDao.setsResevent('Buyer',ApexPages.currentPage().getParameters().get('id')); 
    else
    regSettings = regDao.setsResitem('Regular',selecteditemid); 
    fieldsoptions=new List<SelectOption>();
    fieldsoptions.add(new SelectOption('','--None--'));
    for(String htmlfield:eachhtmlfield)
    {
      fieldsoptions.add(new SelectOption(htmlfield,htmlfield));
   }
    
    for(Reg_Setting__c reg:regSettings)
    {
      if(reg.Included__c==true){
      MapClass mc;
     if(reg.Defaullt_Label__c=='Work Address'){
     mc=new MapClass();
      mc.htmlfield='WorkAddress1';
     mc.regfield='WorkAddress1';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='WorkAddress2';
     mc.regfield='WorkAddress2';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='WorkCity';
     mc.regfield='WorkCity';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='WorkCountry';
     mc.regfield='WorkCountry';
      gridrows.add(mc);
     mc=new MapClass();
      mc.htmlfield='WorkState';
     mc.regfield='WorkState';
      gridrows.add(mc);
    mc=new MapClass();
      mc.htmlfield='WorkZipCode';
     mc.regfield='WorkZipCode';
      gridrows.add(mc);
    
       }
      else if(reg.Defaullt_Label__c=='Billing Address'){
      mc=new MapClass();
      mc.htmlfield='BillingAddress1';
     mc.regfield='BillingAddress1';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='BillingAddress2';
     mc.regfield='BillingAddress2';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='BillingCity';
     mc.regfield='BillingCity';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='BillingCountry';
     mc.regfield='BillingCountry';
      gridrows.add(mc);
    mc=new MapClass();
      mc.htmlfield='BillingState';
     mc.regfield='BillingState';
      gridrows.add(mc);
     mc=new MapClass();
      mc.htmlfield='BillingZipCode';
     mc.regfield='BillingZipCode';
      gridrows.add(mc);
     }
      else if(reg.Defaullt_Label__c=='Home Address'){
      mc=new MapClass();
      mc.htmlfield='HomeAddress1';
     mc.regfield='HomeAddress1';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='HomeAddress2';
     mc.regfield='HomeAddress2';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='HomeCity';
     mc.regfield='HomeCity';
      gridrows.add(mc);
      mc=new MapClass();
      mc.htmlfield='HomeCountry';
     mc.regfield='HomeCountry';
      gridrows.add(mc);
     mc=new MapClass();
      mc.htmlfield='HomeState';
     mc.regfield='HomeState';
      gridrows.add(mc);
     mc=new MapClass();
      mc.htmlfield='HomeZipCode';
     mc.regfield='HomeZipCode';
      gridrows.add(mc);
     }
      else{
      mc=new MapClass();
      mc.htmlfield=reg.Defaullt_Label__c;
     mc.regfield=reg.Defaullt_Label__c;
      gridrows.add(mc);
     }
     
    
      }
    }
    
    
    
        return null;
    }  
    public boolean allitem{get;set;}
     public PageReference SaveMapping() {

 
 List<BLN_Template_Mapping__c> addmaplist=new List<BLN_Template_Mapping__c> ();
 List<BLN_Template_Mapping__c> delmaplist=new List<BLN_Template_Mapping__c>();
 if(allitem!=true)
 {
 for(MapClass mc:gridrows)
 {
   BLN_Template_Mapping__c newbl=new BLN_Template_Mapping__c();
   newbl.DB_Field_Name__c=mc.regfield;
   if(mc.htmlfield==''||mc.htmlfield==null)
    {ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please map all fields.');
    ApexPages.addMessage(myMsg);
    return null;
    }
   newbl.Html_Field_Name__c=mc.htmlfield;
     newbl.BLN_Template__c=bt.id;
   newbl.BLN_Events__c=ApexPages.currentPage().getParameters().get('id');
    if(selecteditemid!='Buyer')
   newbl.BLN_Item__c=selecteditemid;
   addmaplist.add(newbl);
 }
 
 if(selecteditemid!='Buyer')
 delmaplist=[select id,name,DB_Field_Name__c,BLN_Item__c,Html_Field_Name__c,BLN_Template__c from BLN_Template_Mapping__c where BLN_Template__c=:bt.id and BLN_Item__c=:selecteditemid];
 else
 delmaplist=[select id,name,DB_Field_Name__c,BLN_Item__c,Html_Field_Name__c,BLN_Template__c from BLN_Template_Mapping__c where BLN_Template__c=:bt.id and BLN_Item__c=null];
 delete delmaplist;
 
 insert addmaplist;
 }
 else
 {
   for(integer i=0;i<itemoptions.size();i++)
   {
   if(itemoptions[i].getValue()!='')
      for(MapClass mc:gridrows)
 {
   BLN_Template_Mapping__c newbl=new BLN_Template_Mapping__c();
   newbl.DB_Field_Name__c=mc.regfield;
   if(mc.htmlfield==''||mc.htmlfield==null)
    {ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please map all fields.');
    ApexPages.addMessage(myMsg);
    return null;
    }
   newbl.Html_Field_Name__c=mc.htmlfield;
     newbl.BLN_Template__c=bt.id;
   newbl.BLN_Events__c=ApexPages.currentPage().getParameters().get('id');
    if(itemoptions[i].getValue()!='Buyer')
   newbl.BLN_Item__c=itemoptions[i].getValue();
   addmaplist.add(newbl);
 }
   }
   delmaplist=[select id,name,DB_Field_Name__c,BLN_Item__c,Html_Field_Name__c,BLN_Template__c from BLN_Template_Mapping__c where BLN_Template__c=:bt.id];
 delete delmaplist;
 insert addmaplist;
 }
 
 
        return null;
    }
}
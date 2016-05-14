public with sharing class BL_Special_Needs_Expos_mainPageCon {

public string urlId{get;set;}
public string attendeeUrl {get;set;}
public string exhibitorUrl {get;set;}
public string SponsorUrl {get;set;}
public string sfdcBaseURL{get;set;} 
public string retailUrl{get;set;}

public BL_Special_Needs_Expos_mainPageCon(){
 urlid= ApexPAges.currentPage().getParameters().get('Id');
 sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
System.debug('Base URL: ' + sfdcBaseURL ); 
 
 attendeeUrl ='<a href="'+ sfdcBaseURL+'/BL_Special_Needs_Expos_Attendee?id='+urlid+'"><img src="http://www.boothleads.com/images/BUTTON1.png"   width="300" height="50"/>   </a>';
 exhibitorUrl ='<a href="'+sfdcBaseURL+'/BL_Special_Needs_Expos_Exhibitor?id='+urlid+'"><img src="http://www.boothleads.com/images/BUTTON2.png"   width="300" height="50"/>   </a>';
  sponsorUrl='<a href="'+sfdcBaseURL+'/BL_Special_Needs_Expos_Sponsor?id='+urlid+'"><img src="http://www.boothleads.com/images/BUTTON3.png"   width="300" height="50"/>   </a>';
  retailUrl='<a href="'+sfdcBaseURL+'/BL_Special_Needs_Expos_retail?id='+urlid+'"><img src="http://www.boothleads.com/markemailtemp_images/retail_long_island_with_blue_background.png"   width="300" height="50"/>   </a>';
 
 
 
} 




}
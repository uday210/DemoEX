/*
Author:Arindam
Date:10/03/2016
Pupose:This class gets all the data for buyer and attendee in json and set the data and returns the list*/
public class BLN_AttendeeRegistration_Bean
{
  public class BuyerInfo
   {
   public String FirstName{get;set;}
   public String LastName{get;set;}
   public String Prefix{get;set;}
   public String Suffix{get;set;}
   public String Email{get;set;}
   public String CompanyName{get;set;}
   public String Designation{get;set;}
   public String MobileNumber{get;set;}
   public String WorkPhoneNumber{get;set;}
   public String HomePhoneNumber{get;set;}
   public String Image{get;set;}
   public String ImageName{get;set;}
   public String NoOfEmployees{get;set;}
   public String BusinessEstablishedDate{get;set;}
   public String BusinessRevenue{get;set;}
   public String BusinessTaxID{get;set;}
   public String BusinessDunsNumber{get;set;}
   public String WebSiteURL{get;set;}
   public String BlogURL{get;set;}
   public String BusinessDescription{get;set;}
   public String Keywords{get;set;}
   public String ExceptionalKeywords{get;set;}
   public String Age{get;set;}
   public String Attachment{get;set;}
   public String AttachmentName{get;set;}
   public String Gender{get;set;}
   public String NAICSCodes{get;set;}
   public String DiversityType{get;set;}
   public String Commodities{get;set;}
   public String DOB{get;set;}
   public String PrimaryBusinessCategory{get;set;}
   public String SecondaryBusinessCategory{get;set;}
   public String Video{get;set;}
   public String CompanyLogo{get;set;}
   public String CompanyLogoName{get;set;}
   public String FaceBookId{get;set;}
   public String Linkedin{get;set;}
   public String Twitter{get;set;}
   public String Blogger{get;set;}
   public String Biography{get;set;}
   public String WorkAddress1{get;set;}
public String WorkAddress2{get;set;}
public String WorkCity{get;set;}
public String WorkState{get;set;}
public String WorkCountry{get;set;}
public String WorkZipCode{get;set;}
public String HomeAddress1{get;set;}
public String HomeAddress2{get;set;}
public String HomeCity{get;set;}
public String HomeState{get;set;}
public String HomeCountry{get;set;}
public String HomeZipCode{get;set;}
public String BillingAddress1{get;set;}
public String BillingAddress2{get;set;}
public String BillingCity{get;set;}
public String BillingState{get;set;}
public String BillingCountry{get;set;}
public String BillingZipCode{get;set;}
public String CustomBarcode{get;set;}

   } 
   
   public transient List<BuyerInfo> binfo{get;set;}
   public transient List<BuyerInfo> tinfo{get;set;}
   
   public BLN_RegistrationnewCon3.TicketInnerClass parseBuyer(String buyerinform,BLN_RegistrationnewCon3.TicketInnerClass buyerTicketInn)
   {
      try{
   binfo= new List<BuyerInfo>();
   // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(buyerinform);
    while (parser != null && parser.nextToken() != null) {
        
                    binfo= (List<BuyerInfo>)parser.readValueAs(List<BuyerInfo>.class);
                   

       }
       buyerTicketInn.tktProfileObject.Prefix__c=binfo[0].Prefix;
       buyerTicketInn.tktProfileObject.First_Name__c=binfo[0].FirstName;
       buyerTicketInn.tktProfileObject.Last_Name__c=binfo[0].LastName;
       buyerTicketInn.tktProfileObject.Suffix__c=binfo[0].Suffix;
       buyerTicketInn.tktProfileObject.Email__c=binfo[0].Email;
       if(binfo[0].CompanyName!=null&&binfo[0].CompanyName!='')
       buyerTicketInn.tktProfileObject.TKT_Company__c=binfo[0].CompanyName;
       else
       buyerTicketInn.tktProfileObject.TKT_Company__c='';
       buyerTicketInn.tktProfileObject.TKT_Job_Title__c=binfo[0].Designation;
       buyerTicketInn.tktProfileObject.Mobile__c=binfo[0].MobileNumber;
       if(binfo[0].Image!=''&&binfo[0].Image!=null){
       buyerTicketInn.SpeakerPic1=binfo[0].Image;
       buyerTicketInn.SpeakerImageName1=binfo[0].ImageName;}
       try{buyerTicketInn.tktProfileObject.Number_Of_Employees__c=Decimal.valueOf(binfo[0].NoOfEmployees);}catch(Exception e){}
       try{buyerTicketInn.tktProfileObject.Revenue__c=Decimal.valueOf(binfo[0].BusinessRevenue);}catch(Exception e){}
       buyerTicketInn.tktProfileObject.Tax_Id__c=binfo[0].BusinessTaxID;
       buyerTicketInn.tktProfileObject.Duns_Number__c=binfo[0].BusinessDunsNumber;
       buyerTicketInn.tktProfileObject.Company_Website_URL__c=binfo[0].WebSiteURL;
       buyerTicketInn.tktProfileObject.Blog_URL__c=binfo[0].BlogURL;
       buyerTicketInn.tktProfileObject.Company_Description__c=binfo[0].BusinessDescription;
       buyerTicketInn.tktProfileObject.Keywords__c=binfo[0].Keywords;
       buyerTicketInn.tktProfileObject.Exceptional_Keywords__c=binfo[0].ExceptionalKeywords;
       buyerTicketInn.tktProfileObject.Work_Phone__c=binfo[0].WorkPhoneNumber;
       buyerTicketInn.tktProfileObject.Home_Phone__c=binfo[0].HomePhoneNumber;
        if(binfo[0].Attachment!=''&&binfo[0].Attachment!=null){
       buyerTicketInn.myfile1=binfo[0].Attachment;
       buyerTicketInn.myfileName1=binfo[0].AttachmentName;}
       if(binfo[0].DOB!=''&&binfo[0].DOB!=null)
       try{buyerTicketInn.tktProfileObject.DOB__c=Date.valueOf(binfo[0].DOB);}catch(Exception e){}
       if(binfo[0].BusinessEstablishedDate!=''&&binfo[0].BusinessEstablishedDate!=null)
       try{buyerTicketInn.tktProfileObject.Established_Date__c=Date.valueOf(binfo[0].BusinessEstablishedDate);}catch(Exception e){}
       if(binfo[0].CompanyLogo!=''&&binfo[0].CompanyLogo!=null){
       buyerTicketInn.CompanyPic1=binfo[0].CompanyLogo;
       buyerTicketInn.CompanyImageName1=binfo[0].CompanyLogoName;}
       buyerTicketInn.tktProfileObject.FaceBookId__c=binfo[0].FaceBookId;
       buyerTicketInn.tktProfileObject.LinkedInId__c=binfo[0].Linkedin;
       buyerTicketInn.tktProfileObject.TwitterId__c=binfo[0].Twitter;
       buyerTicketInn.tktProfileObject.Blogger__c=binfo[0].Blogger;
       buyerTicketInn.tktProfileObject.Biography__c=binfo[0].Biography;
       try{buyerTicketInn.tktProfileObject.Age__c=Decimal.valueOf(binfo[0].Age);}catch(Exception e){}
       buyerTicketInn.tktProfileObject.Gender__c=binfo[0].Gender;
       if(binfo[0].NAICSCodes!=null&&binfo[0].NAICSCodes!='')
       buyerTicketInn.selectedNaicsCodes=binfo[0].NAICSCodes;
       if(binfo[0].DiversityType!=null&&binfo[0].DiversityType!='')
       buyerTicketInn.selecteddivers=binfo[0].DiversityType;
       if(binfo[0].Commodities!=null&&binfo[0].Commodities!='')
       buyerTicketInn.selectedCommodities=binfo[0].Commodities;
       if(binfo[0].PrimaryBusinessCategory!=null&&binfo[0].PrimaryBusinessCategory!='')
       buyerTicketInn.tktProfileObject.Primary_Business_Category__c=binfo[0].PrimaryBusinessCategory;
       if(binfo[0].SecondaryBusinessCategory!=null&&binfo[0].SecondaryBusinessCategory!='')
       buyerTicketInn.tktProfileObject.Secondary_Business_Category__c=binfo[0].SecondaryBusinessCategory;
       buyerTicketInn.tktProfileObject.Video__c=binfo[0].Video;
       buyerTicketInn.workAddress.Address1__c=binfo[0].WorkAddress1;
       buyerTicketInn.workAddress.Address2__c=binfo[0].WorkAddress2;
       if(binfo[0].WorkCity!=null&&binfo[0].WorkCity!='')
       buyerTicketInn.workAddress.City__c=binfo[0].WorkCity;
       if(binfo[0].WorkState!=null&&binfo[0].WorkState!='')
       buyerTicketInn.workAddress.State__c=binfo[0].WorkState;
       if(binfo[0].WorkCountry!=null&&binfo[0].WorkCountry!='')
       buyerTicketInn.workAddress.Country__c=binfo[0].WorkCountry;
       buyerTicketInn.workAddress.ZipCode__c=binfo[0].WorkZipCode;
       buyerTicketInn.homeAddress.Address1__c=binfo[0].HomeAddress1;
       buyerTicketInn.homeAddress.Address2__c=binfo[0].HomeAddress2;
       if(binfo[0].HomeCity!=null&&binfo[0].HomeCity!='')
       buyerTicketInn.homeAddress.City__c=binfo[0].HomeCity;
       if(binfo[0].HomeState!=null&&binfo[0].HomeState!='')
       buyerTicketInn.homeAddress.State__c=binfo[0].HomeState;
       if(binfo[0].HomeCountry!=null&&binfo[0].HomeCountry!='')
       buyerTicketInn.homeAddress.Country__c=binfo[0].HomeCountry;
       buyerTicketInn.homeAddress.ZipCode__c=binfo[0].HomeZipCode;
       buyerTicketInn.billingAddress.Address1__c=binfo[0].BillingAddress1;
       buyerTicketInn.billingAddress.Address2__c=binfo[0].BillingAddress2;
       if(binfo[0].BillingCity!=null&&binfo[0].BillingCity!='')
       buyerTicketInn.billingAddress.City__c=binfo[0].BillingCity;
       if(binfo[0].BillingState!=null&&binfo[0].BillingState!='')
       buyerTicketInn.billingAddress.State__c=binfo[0].BillingState;
       if(binfo[0].BillingCountry!=null&&binfo[0].BillingCountry!='')
       buyerTicketInn.billingAddress.Country__c=binfo[0].BillingCountry;
       if(binfo[0].HomeCountry!=null&&binfo[0].HomeCountry!='')
       buyerTicketInn.billingAddress.ZipCode__c=binfo[0].BillingZipCode;
       buyerTicketInn.CustomBarcode=binfo[0].CustomBarcode;
       }catch(Exception e){}
       return buyerTicketInn;
       
   }
   
   
   public List<BLN_RegistrationnewCon3.TicketInnerClass> parseAttendee(String attendeeinform,List<BLN_RegistrationnewCon3.TicketInnerClass> TicketList)
   {
    try{
   tinfo= new List<BuyerInfo>();
   // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(attendeeinform);
    while (parser != null && parser.nextToken() != null) {
        
                    tinfo= (List<BuyerInfo>)parser.readValueAs(List<BuyerInfo>.class);
                   

       } 
       integer j=0;
       for(integer i=0;i<ticketlist.size();i++)
       {
       if((TicketList[i].Ticket.Item_Pool__r.Ticket_Settings__c == 'Collect info from All Attendees' && TicketList[i].Ticket.Item_Type__r.name == 'Package' && TicketList[i].Ticket.Parent_ID__c!=null) || (TicketList[i].Ticket.Item__r.Ticket_Settings__c == 'Collect info from All Attendees' && TicketList[i].Ticket.Item_Type__r.name != 'Package') || (TicketList[i].Ticket.Item__r.Ticket_Settings__c == 'Collect info from All Attendees' && TicketList[i].Ticket.Item_Type__r.name == 'Package' && TicketList[i].Ticket.Parent_ID__c==null))
        {
        TicketList[i].tktProfileObject.Prefix__c=tinfo[j].Prefix;
       TicketList[i].tktProfileObject.First_Name__c=tinfo[j].FirstName;
       TicketList[i].tktProfileObject.Last_Name__c=tinfo[j].LastName;
       TicketList[i].tktProfileObject.Email__c=tinfo[j].Email;
       TicketList[i].tktProfileObject.Suffix__c=tinfo[j].Suffix;
       if(tinfo[j].CompanyName!=null&&tinfo[j].CompanyName!='')
       TicketList[i].tktProfileObject.TKT_Company__c=tinfo[j].CompanyName;
       else
       TicketList[i].tktProfileObject.TKT_Company__c='';
       TicketList[i].tktProfileObject.TKT_Job_Title__c=tinfo[j].Designation;
       TicketList[i].tktProfileObject.Mobile__c=tinfo[j].MobileNumber;
       if(tinfo[j].Image!=''&&tinfo[j].Image!=null){
       TicketList[i].SpeakerPic1=tinfo[j].Image;
       TicketList[i].SpeakerImageName1=tinfo[j].ImageName;}
       try{TicketList[i].tktProfileObject.Number_Of_Employees__c=Decimal.valueOf(tinfo[j].NoOfEmployees);}catch(Exception e){}
       try{TicketList[i].tktProfileObject.Revenue__c=Decimal.valueOf(tinfo[j].BusinessRevenue);}catch(Exception e){}
       TicketList[i].tktProfileObject.Tax_Id__c=tinfo[j].BusinessTaxID;
       TicketList[i].tktProfileObject.Duns_Number__c=tinfo[j].BusinessDunsNumber;
       TicketList[i].tktProfileObject.Company_Website_URL__c=tinfo[j].WebSiteURL;
       TicketList[i].tktProfileObject.Blog_URL__c=tinfo[j].BlogURL;
       TicketList[i].tktProfileObject.Company_Description__c=tinfo[j].BusinessDescription;
       TicketList[i].tktProfileObject.Keywords__c=tinfo[j].Keywords;
       TicketList[i].tktProfileObject.Exceptional_Keywords__c=tinfo[j].ExceptionalKeywords;
       TicketList[i].tktProfileObject.Work_Phone__c=tinfo[j].WorkPhoneNumber;
       TicketList[i].tktProfileObject.Home_Phone__c=tinfo[j].HomePhoneNumber;
        if(tinfo[j].Attachment!=''&&tinfo[j].Attachment!=null){
       TicketList[i].myfile1=tinfo[j].Attachment;
       TicketList[i].myfileName1=tinfo[j].AttachmentName;}
       if(tinfo[j].DOB!=''&&tinfo[j].DOB!=null)
       try{TicketList[i].tktProfileObject.DOB__c=Date.valueOf(tinfo[j].DOB);}catch(Exception e){}
       if(tinfo[j].BusinessEstablishedDate!=''&&tinfo[j].BusinessEstablishedDate!=null)
       try{TicketList[i].tktProfileObject.Established_Date__c=Date.valueOf(tinfo[j].BusinessEstablishedDate);}catch(Exception e){}
       if(binfo[0].CompanyLogo!=''&&tinfo[j].CompanyLogo!=null){
       TicketList[i].CompanyPic1=tinfo[j].CompanyLogo;
       TicketList[i].CompanyImageName1=tinfo[j].CompanyLogoName;}
       TicketList[i].tktProfileObject.FaceBookId__c=tinfo[j].FaceBookId;
       TicketList[i].tktProfileObject.LinkedInId__c=tinfo[j].Linkedin;
       TicketList[i].tktProfileObject.TwitterId__c=tinfo[j].Twitter;
       TicketList[i].tktProfileObject.Blogger__c=tinfo[j].Blogger;
       TicketList[i].tktProfileObject.Biography__c=tinfo[j].Biography;
       try{TicketList[i].tktProfileObject.Age__c=Decimal.valueOf(tinfo[j].Age);}catch(Exception e){}
       TicketList[i].tktProfileObject.Gender__c=tinfo[j].Gender;
       if(tinfo[j].NAICSCodes!=null&&tinfo[j].NAICSCodes!='')
       TicketList[i].selectedNaicsCodes=tinfo[j].NAICSCodes;
       if(tinfo[j].DiversityType!=null&&tinfo[j].DiversityType!='')
       TicketList[i].selecteddivers=tinfo[j].DiversityType;
        if(tinfo[j].Commodities!=null&&tinfo[j].Commodities!='')
       TicketList[i].selectedCommodities=tinfo[j].Commodities;
       //buyerTicketInn.tktProfileObject.Email__c=tinfo[j].DOB;
       if(tinfo[j].PrimaryBusinessCategory!=null&&tinfo[j].PrimaryBusinessCategory!='')
       TicketList[i].tktProfileObject.Primary_Business_Category__c=tinfo[j].PrimaryBusinessCategory;
       if(tinfo[j].SecondaryBusinessCategory!=null&&tinfo[j].SecondaryBusinessCategory!='')
       TicketList[i].tktProfileObject.Secondary_Business_Category__c=tinfo[j].SecondaryBusinessCategory;
       TicketList[i].tktProfileObject.Video__c=tinfo[j].Video;
       TicketList[i].workAddress.Address1__c=tinfo[j].WorkAddress1;
       TicketList[i].workAddress.Address2__c=tinfo[j].WorkAddress2;
       if(tinfo[j].WorkCity!=null&&tinfo[j].WorkCity!='')
       TicketList[i].workAddress.City__c=tinfo[j].WorkCity;
       if(tinfo[j].WorkState!=null&&tinfo[j].WorkState!='')
       TicketList[i].workAddress.State__c=tinfo[j].WorkState;
       if(tinfo[j].WorkCountry!=null&&tinfo[j].WorkCountry!='')
       TicketList[i].workAddress.Country__c=tinfo[j].WorkCountry;
       TicketList[i].workAddress.ZipCode__c=tinfo[j].WorkZipCode;
       TicketList[i].homeAddress.Address1__c=tinfo[j].HomeAddress1;
       TicketList[i].homeAddress.Address2__c=tinfo[j].HomeAddress2;
       if(tinfo[j].HomeCity!=null&&tinfo[j].HomeCity!='')
       TicketList[i].homeAddress.City__c=tinfo[j].HomeCity;
       if(tinfo[j].HomeState!=null&&tinfo[j].HomeState!='')
       TicketList[i].homeAddress.State__c=tinfo[j].HomeState;
       if(tinfo[j].HomeCountry!=null&&tinfo[j].HomeCountry!='')
       TicketList[i].homeAddress.Country__c=tinfo[j].HomeCountry;
       TicketList[i].homeAddress.ZipCode__c=tinfo[j].HomeZipCode;
       TicketList[i].billingAddress.Address1__c=tinfo[j].BillingAddress1;
       TicketList[i].billingAddress.Address2__c=tinfo[j].BillingAddress2;
       if(tinfo[j].BillingCity!=null&&tinfo[j].BillingCity!='')
       TicketList[i].billingAddress.City__c=tinfo[j].BillingCity;
       if(tinfo[j].BillingState!=null&&tinfo[j].BillingState!='')
       TicketList[i].billingAddress.State__c=tinfo[j].BillingState;
       if(tinfo[j].BillingCountry!=null&&tinfo[j].BillingCountry!='')
       TicketList[i].billingAddress.Country__c=tinfo[j].BillingCountry;
       TicketList[i].billingAddress.ZipCode__c=tinfo[j].BillingZipCode;
       TicketList[i].CustomBarcode=tinfo[j].CustomBarcode;
       j++;
       }
       }
       }catch(Exception e){}
       return TicketList;
   }
}
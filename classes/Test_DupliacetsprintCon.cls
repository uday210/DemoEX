@istest

public class Test_DupliacetsprintCon{
  static testmethod void DupliacetsprintCon(){
  Profile p = [select id FROM profile where name='Standard User'];
        
        User u = new User(alias = 'test123', email='mallikarjunan+user7489@globalnest.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='mallikarjunan+user7489@globalnest.com');
                  
                  insert u;
                  
                  Event__c event = new Event__c(EV_Title__c='testEvent',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 22806 easy peal square Badges',EventDiversityValues__c='Reception;monday pass');
                insert event;
                
                BadgeTemplate_Styles__c bt= new BadgeTemplate_Styles__c(Name='AveryNew',Event__c =event.id,BadgeName__c='{"name":"AveryNew","width":324,"height":223,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/7H60AQP8A6xvrRTWbcxPrRQB//9k="},',
                Badge_Type__c='Avery',
                Module__c='Attendee Registration',
                FirstRowElement__c='[{"id":"cqrcd","height":106,"width":120,"positionTop":69,"positionLeft":102,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(https://boothleads-boothleads.cs11.force.com/resource/1403783597000/qrcodelogoimage)"}]',
                SecondElement__c='[{"id":"cticketn","height":25,"width":261,"line-height":25,"position":"absolute","positionTop":184,"positionLeft":29,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"22px","textTransform":"none","contentText":"Ticket Name","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]',
                ThirdElement__c='[{"id":"cfulln","height":25,"width":248,"line-height":25,"position":"absolute","positionTop":38,"positionLeft":40,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"22px","textTransform":"none","contentText":"Full Name","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]');
               insert bt;
                
                
                
                  string fieldsOf = 'AS_Age__c,isUpdated__c,AS_BirthDate__c,AS_BlogUrl__c,AS_BusinessDescription__c,AS_BusinessDunsNumber__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_CellPhone__c,AS_Company__c,AS_DiversityType__c,Registration_type__c,AS_Email__c,AS_FaxNumber__c,AS_FirstName__c,AS_Gender__c,AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,AS_HomeCountry__c,AS_HomePhone__c,AS_HomePoBox__c,AS_HomeZip__c,AS_ImageUrl__c,AS_LastName__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_NumberOfEmployees__c,AS_PrefixNew__c,AS_PrimaryBusinessCategory1__c,AS_SecondaryBusinessCategory1__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,AS_ShippingCity__c,AS_ShippingCountry__c,AS_ShippingPhone__c,AS_shippingzip__c,AS_ShippingState__c,AS_ShippingZipcode__c,AS_SuffixNew__c,AS_ThroughEventBrite__c,AS_Title__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkCountry__c,AS_WorkPhone__c,AS_WorkPoBox__c,AS_Work_Country__c,AS_WorkZip__c,AS_Work_States__c,As_Home_Country__c,As_Home_State__c,As_Shipping_Country__c,As_Shipping_States__c';
                 SecurityControls__c  attsett = new SecurityControls__c(EV_id__c = event.id, EV_Fields__c = fieldsOf);
                 insert attsett; 
                 
                 TicketTypes__c tic = new TicketTypes__c(TT_Name__c='Test Tic', TT_TicketType__c='Free',TT_Amount__c=50,  TT_Available__c=1000,EV_id__c=event.id,User_Type__c='Attendee');
                 insert tic;
                   
                 Constomer__c con = new Constomer__c( Isinserted__c = true,Email__c = 'mmmm@gmail.com' );
                    insert con;
                      AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='mythily',AS_LastName__c='Nagandla',AS_Email__c='mmmm@gmail.com');
                  insert attSummary;
      
                  Event_Attendee_Mapping__c eam =new Event_Attendee_Mapping__c(AS_id__c=attSummary.Id,Ev_Id__c=event.id);
                  insert eam;
                  
                  Dummay__c dd = new Dummay__c (Email__c = 'mmmm@gmail.com',Event__c=event.id,Event_Attendee_Mapping__c=eam.id,First_Name__c='mythily',Last_Name__c='Nagandla',TicketTypes__c=tic.id,customer_key__c=con.id);
                  insert dd;
                   Dummay__c dd1 = new Dummay__c (Email__c = 'mmmm@gmail.com',Event__c=event.id,Event_Attendee_Mapping__c=eam.id,First_Name__c='mythily1',Last_Name__c='Nagandla1',TicketTypes__c=tic.id,customer_key__c=con.id);
                  insert dd1;
                  
                  DupliacetsprintCon dummtest = new DupliacetsprintCon();
                  dummtest.eventprintid=event.id;
                  dummtest.selectedbdtemname='AveryNew';
                  dummtest.Print();
                  dummtest.findtemplate();
                  dummtest.getPrinterlist();
                  DupliacetsprintCon.Badge b1=new DupliacetsprintCon.Badge ('','','');
                  DupliacetsprintCon.Style b2=new DupliacetsprintCon.Style('','','','','','','',
    '','','','','','',
    '','','','','',
    '','','','','');
    DupliacetsprintCon.innercl b3=new DupliacetsprintCon.innercl(new Dummay__c());
                  
}

}
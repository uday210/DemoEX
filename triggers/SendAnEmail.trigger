trigger SendAnEmail on User_Profile_Event__c (after insert) {

LIST<User_Profile_Event__c> UserProfileList = new LIST<User_Profile_Event__c>();
MAP<id,user> mapIdusers = new Map<id,user>();


SET<id> eventIds = new SET<id>();
SET<id> userIds = new SET<id>();

 for(User_Profile_Event__c upevent12:trigger.New){
   userIds.add(upevent12.User_id__c);
   eventIds.add(upevent12.EV_id__c);
 }




List<User> U = new List<User>();
for(user ut:[select id,UserName,FirstName,LastName from User where id In :userIds]){
mapIdusers.put(ut.id,ut);
}



EmailTemplate Email_Template = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Booth Admin Sign Up'];

MAP<id,Event__c> EventIdMap = new MAP<id,Event__c>();


List<Event__c> Events=new List<Event__c>();
for(event__c eve:[select id,EV_HostingLocation__c,AS_HostingAddr2__c,
EV_HistingAddr1__c,EV_HostingStateNew__c,EV_HostingCountryNew__c,
EV_StartDate__c,StartTime__c,EV_EndDate__c,EV_EndTime__c,
AS_HostingCity__c,EV_EventLogo__c,EV_Title__c from Event__c where Id in :eventIds]){
EventIdMap.put(eve.id,eve); 
}

List<Profile__c> p = [select id,PR_Name__c from Profile__c ];

MAP<id,Profile__c> idProfile = new MAP<id,profile__c>();

for (Profile__c p1:[select id,PR_Name__c from Profile__c]){
idProfile.put(p1.id,p1);
}

String ReplacealongwithEventLogo;
String ReplaceEventLocation;
String ReplaceStartDate;
String ReplaceEndDate;
String ReplaceContactName;
String SS;
String RelaceAgain;
String ReplaceSubject;
string EmailIdtimail;
string Location;
String Add1;
String Add2;
String City;
String State;
system.debug('***********************************'+trigger.New.Size());

if(trigger.isInsert){

    if(trigger.New.Size()>0){
      LIST<Messaging.SingleEmailMessage> bulkMails = new LIST<Messaging.SingleEmailMessage>();
      LIST<String> ListOfemails = new LIST<String>();
      
        for(User_Profile_Event__c upevent:trigger.New){
           system.debug('66666666666 '+upevent);
             profile__c pro = new Profile__c();
           pro = idProfile.get(upevent.Profile_id__c);
        
           if(upevent.EV_id__c!= null && pro.PR_Name__c=='BoothAdmin'){
             Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();
           event__c   EE = new event__c();
           EE= EventIdMap.get(upevent.EV_id__c);
             if(EE.EV_HostingLocation__c != null)
                                            Location = EE.EV_HostingLocation__c;
                                            else
                                            Location = '';

                                            if(EE.EV_HistingAddr1__c != null)
                                            Add1 = EE.EV_HistingAddr1__c+',';
                                            else
                                            Add1 ='';

                                            if(EE.AS_HostingAddr2__c != null)
                                            Add2 = EE.AS_HostingAddr2__c;
                                            else
                                            Add2 = '';

                                            if(EE.AS_HostingCity__c != null)
                                            City = EE.AS_HostingCity__c+',';
                                            else
                                            City ='';

                                            if(EE.EV_HostingStateNew__c != null)
                                            State = EE.EV_HostingStateNew__c;
                                            else
                                            State = '';

                                            ReplaceContactName = Email_Template.HtmlValue;

                          user uu = new user();
                          uu = mapIdusers.get(upevent.User_id__c);
                          
                           system.debug('*********** ********** ********'+UU.FirstName);
                                            SS = ReplaceContactName.Replace('{!Contact.Name}',UU.FirstName + ' ' + UU.LastName);

                                            RelaceAgain = SS.Replace('"{!EventName}"',EE.EV_Title__c);


                                            ReplaceSubject = Email_Template.Subject.replace('“{!EventName}”',EE.EV_Title__c);

                                            if(EE.EV_EventLogo__c != null){
                                            ReplacealongwithEventLogo = RelaceAgain.replace('{{!EventLogo}}','<img src="https://c.cs11.content.force.com/servlet/servlet.ImageServer?id='+EE.EV_EventLogo__c+'&oid='+UserInfo.getOrganizationId()+'" style="width:200px; height:80px;" />');
                                            }else{
                                            ReplacealongwithEventLogo = RelaceAgain.replace('{{!EventLogo}}','');
                                            }

                                            ReplaceEventLocation = ReplacealongwithEventLogo.replace('{!EventLocation}',Location +' </br><br/> '+Add1+Add2+'<br/>'+City+State );

                                            ReplaceStartDate = ReplaceEventLocation.replace('"DateStart"',EE.EV_StartDate__c.month()+ '/'+EE.EV_StartDate__c.day()+'/'+EE.EV_StartDate__c.year()+ ' ' +EE.StartTime__c);

                                            ReplaceEndDate = ReplaceStartDate.replace('"DateEnd"',EE.EV_EndDate__c.month()+ '/'+EE.EV_EndDate__c.day()+'/'+EE.EV_EndDate__c.year()+ ' '+EE.EV_EndTime__c);


                                            // ListOfemails.add(UU.UserName);
                                            String[] toAddresses = new String[] {
                                            UU.UserName
                                            };
                                            singleEmail.setHtmlBody(ReplaceEndDate );
                                            singleEmail.setToAddresses( toAddresses );
                                            singleEmail.setSubject(ReplaceSubject );
                                            bulkMails.add(singleEmail );
            }

        }
 

 if(!bulkMails.isEmpty() )
 Messaging.sendEmail(bulkMails);
 }
}
}
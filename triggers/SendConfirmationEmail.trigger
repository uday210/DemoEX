trigger SendConfirmationEmail on EventSchedule__c(after insert , after update){
try{
   EventSchedule__c easlist = new EventSchedule__c();
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    List<EventSchedule__c> eslistids = trigger.new;
    for(EventSchedule__c es: trigger.new){
         easlist = [select EV_id__r.EV_HostingLocation__c,EV_id__r.Email_Notifications_flag__c,id,MM_Slot_Status__c,MM_slot_Date__c,MM_Slot_End_Time__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                      MM_To_UPE__r.BT_id__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                      MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, 
                      MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Company__c, 
               EV_id__r.EV_EventLogo__c,EV_id__r.EV_HistingAddr1__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingStateNew__c,
               EV_id__r.EV_Title__c,EV_id__r.EV_HostingZipcode__c,EV_id__r.owner.Name,EV_id__r.OrganizerId__c,EV_id__r.EV_HostingPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Secondary_Email__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,
               EV_id__r.Match_Making_Schedules__c,MM_To_UPE__r.Attendee_Summary__r.AS_Secondary_Email__c,MM_To_EAM__r.AS_id__r.AS_Secondary_Email__c,owner.UserName FROM EventSchedule__c 
               WHERE Is_Matchmaking__c = true
               //AND MM_Slot_Status__c = 'Accepted'
               AND id =: es.id];
               set<id> BIDS = new set<id>();
               //Collecting Booth IDS from UPE 
         
         List<User_Profile_Event__c> Booths = [select id,Attendee_Summary__r.AS_Secondary_Email__c,Attendee_Summary__r.AS_Email__c,BT_id__r.id from User_Profile_Event__c Where BT_id__r.id =:easlist.MM_To_UPE__r.BT_id__r.id]; 
         List<string> emaillist = new List<string>();
             for(User_Profile_Event__c UI : Booths){
                 if(UI.Attendee_Summary__r.AS_Secondary_Email__c != null){
                      emaillist.add(UI.Attendee_Summary__r.AS_Secondary_Email__c);
                 }else{
                     emaillist.add(UI.Attendee_Summary__r.AS_Email__c);
                 }
             }     
             
         
              boolean isMailSend = false;
              if(null!=easlist){
                 if(null!=easlist.EV_id__c){
                     isMailSend  = easlist.EV_id__r.Email_Notifications_flag__c;
                 } 
              }
         
         
         
          //Getting organization wide Email address 
          OrgWideEmailAddress[] owea = new OrgWideEmailAddress[]{};
           owea =  [select Id from OrgWideEmailAddress where DisplayName =:easlist.EV_id__r.owner.Name];
           if(owea.size()<=0){
               owea =  [select Id from OrgWideEmailAddress where DisplayName = 'Booth Leads'];
           }
          
          Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
          
               if(owea.size() > 0 ) {
                    email.setOrgWideEmailAddressId(owea.get(0).Id);
               } 
           
                if(easlist!=null ){
                  if(easlist.EV_id__r.Match_Making_Schedules__c!='Closed'){

                     List<MatchLeads_Days__c> mmdetails = new List<MatchLeads_Days__c>();
                      mmdetails = [select id,MatchLeads_Date__c,Start_time__c,End_Time__c from  MatchLeads_Days__c  Where Event__c =: easlist.EV_id__r.id];
                      // Sending Mail to Corporate Start 
                       String[] toAddresses = new String[]{easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Secondary_Email__c};
                         
                      // if(easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c != easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Secondary_Email__c){
                        //  toAddresses.add(easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c);
                      // }
                       
                       toAddresses.addall(emaillist);
                       EmailTemplate E = new EmailTemplate(); 
                        EmailTemplate E1 = new EmailTemplate();
                        String subject ='';
                        String subject1='';
                        //string sDate=string.valueOf(MONTH(mmdetails[0].MatchLeads_Date__c) DAY(mmdetails[0].MatchLeads_Date__c), YEAR(mmdetails[0].MatchLeads_Date__c));
                        //string.valueOf(mmdetails[0].MatchLeads_Date__c);
                        Date dToday = mmdetails[0].MatchLeads_Date__c;
                        Datetime dt = datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
                        String myDatetimeStr = dt.format('MMMM d,  yyyy');
                       //Fetching Template to send Data
                          if(easlist.MM_Slot_Status__c =='Accepted'){
                               E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking MBE Schedule Confirmation Email'];                      
                               subject='Schedule Confirmation for: '+ easlist.EV_id__r.EV_Title__c+', '+myDatetimeStr+', '+ easlist.EV_id__r.AS_HostingCity__c+',  '+easlist.EV_id__r.EV_HostingStateNew__c +'.';
                                subject1='Schedule Confirmation for: '+ easlist.EV_id__r.EV_Title__c+', '+myDatetimeStr+', '+ easlist.EV_id__r.AS_HostingCity__c+',  '+easlist.EV_id__r.EV_HostingStateNew__c +'.';
                               E1 =E;
                           }else if(easlist.MM_Slot_Status__c =='Cancelled'){
                              E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking MBE Schedule Cancellation Email'];                      
                               subject='Schedule Cancellation for: '+ easlist.EV_id__r.EV_Title__c+', '+myDatetimeStr+', '+ easlist.EV_id__r.AS_HostingCity__c+',  '+easlist.EV_id__r.EV_HostingStateNew__c +'.';
                                subject1='Schedule Cancellation for: '+ easlist.EV_id__r.EV_Title__c+', '+myDatetimeStr+', '+ easlist.EV_id__r.AS_HostingCity__c+',  '+easlist.EV_id__r.EV_HostingStateNew__c +'.';
                              E1 =E;
                          }else if(easlist.MM_Slot_Status__c =='Rescheduled'){
                           E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking MBE Schedule Reshedule Email'];                      
                           subject='Schedule Rescheduled for: '+ easlist.EV_id__r.EV_Title__c+', '+myDatetimeStr+', '+ easlist.EV_id__r.AS_HostingCity__c+',  '+easlist.EV_id__r.EV_HostingStateNew__c +'.';
                                subject1='Schedule Rescheduled for: '+ easlist.EV_id__r.EV_Title__c+', '+myDatetimeStr+', '+ easlist.EV_id__r.AS_HostingCity__c+',  '+easlist.EV_id__r.EV_HostingStateNew__c +'.';
                              E1 =E;
                         }
                         email.setToAddresses(toAddresses);    
                         //String subject = E.Subject;
                         String ReplaceContactName0 = E.HtmlValue;
                         String ReplaceContactName = constuctBodymessage(easlist,ReplaceContactName0,mmdetails,'Mbe');
                         System.debug('ReplaceContactName 1'+ReplaceContactName);
                         email.setSubject(subject);    
                         email.setHtmlBody(ReplaceContactName);      
                          System.debug('emailemailemailemailemailemail Coporate '+email);
                          
                       if(isMailSend){   
                       emails.add(email);
                         //Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
                        }
                        // Sending Mail to Corporate End 

                          // Sending Mail to Mbe Start 
                           String[] toAddresses1 = new String[]{};
                             Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
                             if(easlist.MM_To_EAM__r.MBE_Profile__r.AS_Secondary_Email__c == null || easlist.MM_To_EAM__r.MBE_Profile__r.AS_Secondary_Email__c ==''){
                             toAddresses1.add(easlist.MM_To_EAM__r.AS_id__r.AS_Secondary_Email__c);

                             }else{
                             toAddresses1.add(easlist.MM_To_EAM__r.MBE_Profile__r.AS_Secondary_Email__c);
                               if(easlist.MM_To_EAM__r.MBE_Profile__r.AS_Secondary_Email__c!= easlist.MM_To_EAM__r.AS_id__r.AS_Email__c){
                                  toAddresses1.add(easlist.MM_To_EAM__r.AS_id__r.AS_Email__c);
                               }
                             }
                              if(owea.size() > 0 ) {
                                email1.setOrgWideEmailAddressId(owea.get(0).Id);
                              }
                              email1.setToAddresses(toAddresses1); 
                              //String subject1 = E1.Subject;
                              String ReplaceContactName1 = E.HtmlValue;
                              String ReplaceContactName11 = constuctBodymessage(easlist,ReplaceContactName1,mmdetails,'Coporate');
                               email1.setSubject(subject1);    
                               email1.setHtmlBody(ReplaceContactName11);   
                                  System.debug('emailemailemailemailemailemail Mbe '+email1);   
                                 if(isMailSend ){
                                 emails.add(email1);        
                                   //Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email1});
                                }
                          // Sending Mail to Mbe End 
                       }
                   }
     }
     if(emails.size()!=0){
     Messaging.sendEmail(emails);
    }
   }catch(exception e){}
 
  public string  constuctBodymessage(EventSchedule__c easlist,string ReplaceCompanyname,List<MatchLeads_Days__c> mmdetails,string type){
                 if(easlist.EV_id__r.EV_EventLogo__c != null && easlist.EV_id__r.EV_EventLogo__c != '' ){
                    ReplaceCompanyname  = ReplaceCompanyname.Replace('{!EventLogo}',easlist.EV_id__r.EV_EventLogo__c);
                    }else{
                    ReplaceCompanyname = ReplaceCompanyname;
                    }
                    string ReplacedCompanyname1Temp;
                   if(easlist.EV_id__r.EV_HostingLocation__c != null && easlist.EV_id__r.EV_HostingLocation__c != ''){ 
                    ReplacedCompanyname1Temp= ReplaceCompanyname.Replace('{!EventHostingLoc}',easlist.EV_id__r.EV_HostingLocation__c);
                    }else{
                    ReplacedCompanyname1Temp= ReplaceCompanyname.Replace('{!EventHostingLoc}','');
                    }
                    string ReplacedCompanyname1;
                   if(easlist.EV_id__r.EV_HistingAddr1__c != null && easlist.EV_id__r.EV_HistingAddr1__c != ''){ 
                    ReplacedCompanyname1 = ReplacedCompanyname1Temp.Replace('{!EventAdd1}',easlist.EV_id__r.EV_HistingAddr1__c);
                    }else{
                    ReplacedCompanyname1 = ReplacedCompanyname1Temp.Replace('{!EventAdd1}','');
                    }
                    string ReplacedCompanyname2;
                    if(easlist.EV_id__r.AS_HostingAddr2__c != null && easlist.EV_id__r.AS_HostingAddr2__c != ''){ 
                    ReplacedCompanyname2 = ReplacedCompanyname1.Replace('{!EventAdd2}',easlist.EV_id__r.AS_HostingAddr2__c);
                    }else{
                    ReplacedCompanyname2 = ReplacedCompanyname1.Replace('{!EventAdd2}','');
                    }
                    string ReplacedCompanyname3;
                    if(easlist.EV_id__r.AS_HostingCity__c != null && easlist.EV_id__r.AS_HostingCity__c != ''){ 
                    ReplacedCompanyname3 = ReplacedCompanyname2.Replace('{!Eventcity}',easlist.EV_id__r.AS_HostingCity__c);
                    }else{
                    ReplacedCompanyname3 = ReplacedCompanyname2.Replace('{!Eventcity}','');
                    }
                    string ReplacedCompanyname4;
                    if(easlist.EV_id__r.EV_HostingStateNew__c != null && easlist.EV_id__r.EV_HostingStateNew__c!= ''){ 
                    ReplacedCompanyname4 = ReplacedCompanyname3.Replace('{!Eventstate}',easlist.EV_id__r.EV_HostingStateNew__c);
                    }else{
                    ReplacedCompanyname4 = ReplacedCompanyname3.Replace('{!Eventstate}','');
                    }
                   
                   // String ReplacedCompanyname5 = ReplacedCompanyname4.Replace('{!Name}',easlist.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + easlist.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
                    
                    //String ReplacedCompanyname6 = ReplacedCompanyname5.Replace('{!CompanyName2}',easlist.MM_To_EAM__r.AS_id__r.AS_Company__c);        
                    //String ReplacedCompanyname6 =  ReplacedCompanyname5;          
                    string ReplacedCompanyname7 = ReplacedCompanyname4.Replace('{!EventName}',easlist.EV_id__r.EV_Title__c);
                    string ReplacedCompanyname8;
                    if(easlist.EV_id__r.EV_HostingZipcode__c != null && easlist.EV_id__r.EV_HostingZipcode__c!= ''){ 
                      ReplacedCompanyname8 = ReplacedCompanyname7.Replace('{!Eventzip}',easlist.EV_id__r.EV_HostingZipcode__c);
                    }else{
                    ReplacedCompanyname8 = ReplacedCompanyname7.Replace('{!Eventzip}','');
                    }
                    
                   System.debug('PPPPPPPPP '+easlist.owner.UserName   +'    '+easlist.MM_To_UPE__r.Attendee_Summary__r.As_Email__c); 
                   string ReplacedCompanyname9; 
                   if(easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c!=null && easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c!=''){
                    if(type=='Coporate'){
                      ReplacedCompanyname9=ReplacedCompanyname8.Replace('{!CompanyName2}',easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c);
                    }else{
                       ReplacedCompanyname9=ReplacedCompanyname8.Replace('{!CompanyName2}',easlist.MM_To_EAM__r.AS_id__r.AS_Company__c);
                    }
                  }else{
                    ReplacedCompanyname9=ReplacedCompanyname8.Replace('{!CompanyName2}','');
                  }
                  string ReplacedCompanyname10; 
                  if(easlist.MM_To_EAM__r.AS_id__r.AS_Company__c!=null && easlist.MM_To_EAM__r.AS_id__r.AS_Company__c!=''){
                   if(type=='Coporate'){
                        ReplacedCompanyname10=ReplacedCompanyname9.Replace('{!CompanyName1}',easlist.MM_To_EAM__r.AS_id__r.AS_Company__c);
                    }else{
                       ReplacedCompanyname10=ReplacedCompanyname9.Replace('{!CompanyName1}',easlist.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c);
                    }
                        
                  }else{
                     ReplacedCompanyname10=ReplacedCompanyname9.Replace('{!CompanyName1}','');
                 }


                  string ReplacedCompanyname11;
                   if(mmdetails.size()>0){
                      string conTable =  '<table>';
                        for(MatchLeads_Days__c madt : mmdetails ){
                          system.debug('PPPPPPPPPPPP '+madt );
                            if(madt.MatchLeads_Date__c!= null){
                               string dateTimeFormat='';
                               date dInputDate= madt.MatchLeads_Date__c;
                               dateTime dd = DateTime.newInstance(dInputDate.year(), dInputDate.month(), dInputDate.day());
                               dateTimeFormat  = dd.format('MMMM dd, YYYY');
                                string Mtime ='';

                                 if((madt.Start_time__c!= null && madt.Start_time__c!= '')){
                                     Mtime+=madt.Start_time__c;
                                  }
                                   if((madt.End_Time__c!= null && madt.End_Time__c!= '')){
                                     Mtime+=' To '+madt.End_Time__c;
                                  }
                                   if(Mtime!='' ){
                                    dateTimeFormat+=', From '+Mtime;
                                   }
                                conTable+= '<tr><td>'+dateTimeFormat+'</td></tr>';
                            }
                        }
                         conTable +='</table>';
                         ReplacedCompanyname11 = ReplacedCompanyname10.Replace('{!MMtime}',conTable);
                     }
                                  
                      string ReplacedCompanyname12;
                      if(easlist.MM_slot_Date__c!=null){
                              string dateTimeFormat='';
                               date dInputDate= easlist.MM_slot_Date__c;
                               dateTime dd = DateTime.newInstance(dInputDate.year(), dInputDate.month(), dInputDate.day());
                               dateTimeFormat  = dd.format('MMMM dd, YYYY');
                          ReplacedCompanyname12=ReplacedCompanyname11.Replace('{!shdate}',dateTimeFormat);
                       }else{
                          ReplacedCompanyname12=ReplacedCompanyname11.Replace('{!shdate}','');
                      }


                    string ReplacedCompanyname13;
                      if(easlist.MM_slot_StartTime__c!=null && easlist.MM_slot_StartTime__c!=''){
                          ReplacedCompanyname13=ReplacedCompanyname12.Replace('{!stime}',easlist.MM_slot_StartTime__c);
                       }else{
                          ReplacedCompanyname13=ReplacedCompanyname12.Replace('{!stime}','');
                      }
                     
                      string ReplacedCompanyname14;
                      if(easlist.MM_Slot_End_Time__c!=null && easlist.MM_Slot_End_Time__c!=''){
                          ReplacedCompanyname14=ReplacedCompanyname13.Replace('{!etime}',easlist.MM_Slot_End_Time__c);
                       }else{
                          ReplacedCompanyname14=ReplacedCompanyname13.Replace('{!etime}','');
                      }

                 return ReplacedCompanyname14;
       }

}
public without sharing class SendEmailAfterReg_SucessCon {

public string cuskey{get;set;}
public id domid{get;set;}
public  SendEmailAfterReg_SucessCon(){
  //cuskey =Apexpages.currentpage().getParameters().get('key');
}

    public PageReference send() {
          
        sendEmail(domid);
        return null;
    }



   public void  sendEmail(ID custmerId) {
      
    Constomer__c custmer = new Constomer__c();
    LIST<Dummay__c> dummyTypes = new LIST<Dummay__c>();
    LIST<Dummay__c> dummyTypesLIST =  new LIST<Dummay__c>();
    Commanforstates  con = new Commanforstates ();
    MAP<id,string> mapsurvetQuestonWithEvent = new MAP<id,string>();
    
    
    dummyTypesLIST =[SELECT customer_key__r.Total_Amount__c ,Individual_Amount_After_Discount__c,Tickets_Quantty__c,Event__r.EV_EventLogo__c,Company__c,DiscountValue__c,Promocode__c,Ticket_Amount__c,Event__r.EV_HostingOrgName__c,customer_key__r.Name,ID, Event__r.owner.Email,Event__r.owner.Name,Event__r.owner.userName,NAME, Last_Name__c, First_Name__c,Email__c,TicketAmount__c,  Event__r.AS_HostingAddr2__c, Event__r.EV_HistingAddr1__c,Event__r.EV_HostingZipcode__c,Event__r.EV_HostingStateNew__c,Event__r.AS_HostingCity__c,Event__r.EV_HostingLocation__c,Event__c,Event__r.EV_Title__c,Event__r.EV_StartDate__c,
    Event__r.StartTime__c,Event__r.EV_EndDate__c,Event__r.EV_EndTime__c,CreatedDate, TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c ,Event__r.TwitterId__c,Event__r.FacebookId__c,Event__r.OrganizerId__c FROM Dummay__c WHERE customer_key__c =: custmerId ];
    
   if(dummyTypesLIST.size()>0){
      for(Survey__c surs:[select id,Answers__c,event__c,Survey_Questions__c,Survey_Questions__r.Question__c from Survey__c where customer_key__c=:custmerId and Event__r.EV_title__c='GNEMSDC/MBDA Capital Summit']){
          if(surs.Survey_Questions__r.Question__c=='Are you certified?'){
           mapsurvetQuestonWithEvent.put(surs.event__c,surs.Answers__c);
          }
      }
   
   }
   
   
   
   string eventSettingType ='';
    if(dummyTypesLIST.size()>0){
       List<Event_Registration_jun__c> regSet = [select id,Setting_Type__c from Event_Registration_jun__c where Event__c=:dummyTypesLIST[0].event__c];
       if(regSet.size()>0){
            eventSettingType=regSet[0].Setting_Type__c;
        }
    } 
   
   List<Dummay__c> listForSendMail = new List<Dummay__c>();
   
    if(eventSettingType=='Collect information below for the ticket buyer only'){
      listForSendMail.add(dummyTypesLIST[0]); 
     }else{
       listForSendMail.addAll(dummyTypesLIST);
     }
   
    List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
    List<Messaging.SingleEmailMessage> EmailsList2 = new List<Messaging.SingleEmailMessage>();
    
     
     
    
    
     
           for(Dummay__c d:listForSendMail){
             // if(d.TicketTypes__r.TT_Name__c!='Exhibitor Staff'){
             
              string questionpeople;
              string partiattendPeople;
             try{
             
              OrgWideEmailAddress Org;
        
             try{
              /*if(d.Event__r.EV_Title__c=='Long Island Commercial Real Estate Expo'){
                  Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Licree'];
               }else if(d.Event__r.EV_Title__c=='Special Needs Expos Long Island'){
                  Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Special Needs Expo'];
               }else{
                if(d.Event__r.OrganizerId__c!=null){
                  Org = [select id from OrgWideEmailAddress WHERE address=:d.Event__r.OrganizerId__c];
                 }else{
                    Org = [select id from OrgWideEmailAddress WHERE address='support@boothleads.com'];
                   }
               
               }*/
               
               if(d.Event__r.OrganizerId__c!=null){
                   try{
               Org = [select id,IsAllowAllProfiles,address from OrgWideEmailAddress WHERE address=:d.Event__r.OrganizerId__c limit 1];
                      }catch(Exception e){
                       //if not exist in orgwideaddress then take default
                       Org = [select id,address from OrgWideEmailAddress WHERE address='orders@boothleads.com'];
                         }
                    if(Org.IsAllowAllProfiles==false)
                    Org = [select id,address from OrgWideEmailAddress WHERE address='orders@boothleads.com'];
               }
               else{
                    Org = [select id,address from OrgWideEmailAddress WHERE address='orders@boothleads.com'];
                   }
               
             //  Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Jerlyn Clarke'];
               }catch(Exception e){return;}
               
              system.debug('44444444444444 rrrrrrrrrrrrr 444444444'+d.TicketTypes__r.Ticket_Category__c);
               
               if(d.TicketTypes__r.Ticket_Category__c=='Attendee'){
               
                system.debug('44444444444444 rrrrrrrrrrrrr 55555555555555  '+d.TicketTypes__r.Ticket_Category__c);
                 List<Survey__c> survey = new List<Survey__c>();
                 survey =[SELECT id,   customer_key__c,Survey_Questions__c,Answers__c,Survey_Questions__r.Question__c from Survey__c where customer_key__c=:custmerId  and Survey_Questions__r.Question__c='My party will total ___ people(Enter number).'];
                  system.debug('44444444444444 rrrrrrrrrrrrr '+survey );
                 if(survey.size()>0){
                   partiattendPeople=survey[0].Answers__c;
                   questionpeople =survey[0].Survey_Questions__r.Question__c;
                 }
              
               }
           
           
             
               d.Event__r.EV_HostingStateNew__c=  con.mapstate(d.Event__r.EV_HostingStateNew__c);
               Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
               email.setSubject('Order confirmation for '+d.Event__r.EV_Title__c);
               if( Org != null){  
               email.setOrgWideEmailAddressId(Org.id);
               
              }
             
               LIST<String> ccAddresses = new LIST<String>();  
             ccAddresses.add(d.Event__r.OrganizerId__c);
              //ccAddresses.add('phani@globalnest.com');
              if(d.Event__r.EV_Title__c=='Special Needs Expos Long Island'){
               ccAddresses.add('jamiezy19@yahoo.com');
              }
               ccAddresses.add('durga@globalnest.com');
              
              email.setToAddresses(ccAddresses);
              
               EmailTemplate E = new EmailTemplate();
            
                try{ 
                  E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Email to user After Registration']; 
                   }catch(exception fr){}
               
             
             
              String ReplaceContactName = E.HtmlValue;
              String replacedname ;
              
              
              try{
              replacedname = ReplaceContactName.Replace('{!userName}',d.First_Name__c +' '+d.Last_Name__c);
              }catch(exception ed){
                  replacedname = ReplaceContactName.Replace('{!userName}','' +' '+'');
              }
              
             try{
               replacedname = replacedname.Replace('{!userEmail}',d.Email__c);
              }catch(exception ed){
               replacedname = replacedname.Replace('{!userEmail}','');
              }
             
           try{  
             replacedname = replacedname.Replace('{!orderNumber}',d.customer_key__r.Name);
              }catch(exception ed){
               replacedname = replacedname.Replace('{!orderNumber}','');
             }
             
              system.debug('TTTTTTTTTTCCCCCCCCCCCCCCCCC'+d.Event__r.EV_EventLogo__c);
             string frd;  
              try{
              if(d.Event__r.EV_EventLogo__c!=null){
                 frd ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id='+d.Event__r.EV_EventLogo__c+'&oid=00DF0000000BpyH';
              }else{
               frd ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id=015F0000002PvfM&oid=00DF0000000BpyH';
               }
               replacedname = replacedname.Replace('{!evelogo}',frd ); 
               system.debug('TTTTTTTTTT$$$$$$$$$$$$$$$$$$$$$'+d.Event__r.EV_EventLogo__c);
              }catch(exception rf){
             }
             
             
              try{ 
               replacedname = replacedname.Replace('{!eventName}',d.Event__r.EV_Title__c);
               }catch(exception ed){
                replacedname = replacedname.Replace('{!eventName}','');
               }
             
              try{ 
             replacedname = replacedname.Replace('{!eventOrgName}',d.Event__r.EV_HostingOrgName__c);
            }catch(exception ed){
              replacedname = replacedname.Replace('{!eventOrgName}','');
            }
            
            
              try{ 
               replacedname = replacedname.Replace('{!company}',d.company__c);
               } catch(exception ed){
               replacedname = replacedname.Replace('{!company}','');
             }
             
             
              try{ 
               replacedname = replacedname.Replace('{!type}',d.TicketTypes__r.Ticket_Category__c);
               } catch(exception ed){
               replacedname = replacedname.Replace('{!type}','');
             }
             
           
             try{ 
               replacedname = replacedname.Replace('{!discount}',d.DiscountValue__c);
               } catch(exception ed){
               replacedname = replacedname.Replace('{!discount}','');
             }
             
             
              try{ 
               replacedname = replacedname.Replace('{!promo}',d.Promocode__c);
               } catch(exception ed){
               replacedname = replacedname.Replace('{!promo}','');
             }
             
             
              try{ 
               replacedname = replacedname.Replace('{!originolant}',string.valueOf(d.Ticket_Amount__c));
               } catch(exception ed){
               replacedname = replacedname.Replace('{!originolant}','');
             }
            
           decimal beforedisValue =0.0;
            
            string stv; 
           if(eventSettingType=='Collect information below for the ticket buyer only'){ 
            stv = '<table style="width:100%;" cellpadiing="0" cellspacing="0"><tr><td style="font-weight:bold;border-bottom:1px solid #CCC;">Name</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Type</td><td style="font-weight:bold;font-weight:bold;border-bottom:1px solid #CCC;">Quantity</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Amount paid</td></tr>';
            
            
             for(Dummay__c  ftr:dummyTypesLIST){
               
                string cf ='<tr><td style="border-bottom:1px solid #CCC;">'+ ftr.First_Name__c +' '+ftr.Last_Name__c+'</td>';
                string tcN = '<td style="border-bottom:1px solid #CCC;">'+ ftr.TicketTypes__r.TT_Name__c + '</td>';
                string tcQuan = '<td style="border-bottom:1px solid #CCC;">'+ftr.Tickets_Quantty__c  +'</td>';
                string tcamnt= '<td style="border-bottom:1px solid #CCC;">'+'$'+ftr.TicketAmount__c  +'</td></tr>';
                stv+=cf+tcN+tcQuan+tcamnt;      
                system.debug('SSSSSSSSSSSSSSSSSS '+stv);    
            }
          }  
            else{
            stv = '<table style="width:100%;" cellpadiing="0" cellspacing="0"><tr><td>Name</td><td>Type</td><td>Quantity</td><td>Amount Paid</td></tr>';
              string cf ='<tr><td style="border-bottom:1px solid #CCC;">'+ d.First_Name__c +' '+d.Last_Name__c+'</td>';
                string tcN = '<td style="border-bottom:1px solid #CCC;">'+ d.TicketTypes__r.TT_Name__c + '</td>';
                string tcQuan = '<td style="border-bottom:1px solid #CCC;">'+d.Tickets_Quantty__c  +'</td>';
                string tcamnt= '<td style="border-bottom:1px solid #CCC;">'+'$'+d.TicketAmount__c  +'</td></tr>';
               stv+=cf+tcN+tcQuan+tcamnt;   
            }
           
           stv+='</table>';
           
          system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA '+stv);   
           
            try{ 
               //replacedname = replacedname.Replace('{!ticketName}',d.TicketTypes__r.TT_Name__c);
               replacedname = replacedname.Replace('{!ticketName}',stv);
             }catch(exception ed){ 
              replacedname = replacedname.Replace('{!ticketName}','');
              }
            
              system.debug('CCCCCCCCCCCCCCCCCCCCCC '+replacedname );
            
             try{ 
               replacedname = replacedname.Replace('{!afterdis}',string.valueOf(d.customer_key__r.Total_Amount__c));
               } catch(exception ed){
               replacedname = replacedname.Replace('{!afterdis}','');
             }
            
            
            
            
             try{ 
              replacedname = replacedname.Replace('{!organizerName}',d.Event__r.OrganizerId__c);
            } catch(exception ed){
               replacedname = replacedname.Replace('{!organizerName}','');
             }
            
           
            
              try{ 
              replacedname = replacedname.Replace('{!eventLocation}',d.Event__r.EV_HostingLocation__c);
              }catch(exception ed){
               replacedname = replacedname.Replace('{!eventLocation}','');
              }
             
              try{ 
               replacedname = replacedname.Replace('{!ordertype}',d.Payment_Type__c);
               } catch(exception ed){
               replacedname = replacedname.Replace('{!ordertype}','');
             }
             
             
             
             
              try{ 
              replacedname = replacedname.Replace('{!eventAdd1}',d.Event__r.EV_HistingAddr1__c);
             }catch(exception ed){
              replacedname = replacedname.Replace('{!eventAdd1}','');
             }
            
             try{ 
             replacedname = replacedname.Replace('{!eventCity}',d.Event__r.AS_HostingCity__c);
              }catch(exception ed){
              replacedname = replacedname.Replace('{!eventCity}','');
              }
             
             
              try{ 
              replacedname = replacedname.Replace('{!eventState}',d.Event__r.EV_HostingStateNew__c);
              }catch(exception ed){
               replacedname = replacedname.Replace('{!eventState}','');
              }
             
             
             
              try{ 
              replacedname = replacedname.Replace('{!EventZip}',d.Event__r.EV_HostingZipcode__c);
              }catch(exception ed){
               replacedname = replacedname.Replace('{!EventZip}','');
              }
              
              
             try{ 
               replacedname = replacedname.Replace('{!peoplenumber}',partiattendPeople);
            
             }catch(exception ed){
              replacedname = replacedname.Replace('{!peoplenumber}','');
             }
            
             try{ 
              replacedname = replacedname.Replace('{!question}',questionpeople);
              }catch(exception ed){
               replacedname = replacedname.Replace('{!question}','');
              }
             
             Datetime myDatetime = d.createddate;
             String myDatetimeStr = myDatetime.format('MM-dd-yyyy hh:mm a');
             
              try{  
             replacedname = replacedname.Replace('{!orderDate}',myDatetimeStr );
             }catch(exception ed){
               replacedname = replacedname.Replace('{!orderDate}','');
              }
             
             
             
             Date myDatetime1 = d.Event__r.EV_StartDate__c;
             String myDatetimeStr1 = myDatetime1.format();
             
             Date myDatetime2 = d.Event__r.EV_EndDate__c;
             String myDatetimeStr2 = myDatetime2.format();
            
             try{ 
             replacedname = replacedname.Replace('{!eventDate}',myDatetimeStr1 +' '+d.Event__r.StartTime__c+'-'+myDatetimeStr2 +' '+d.Event__r.EV_EndTime__c);
              } catch(exception ed){
                replacedname = replacedname.Replace('{!eventDate}','');
            
               }
             
              email.setHtmlBody(replacedname);            
              EmailsList.add(email); 
             
             
             
             
             EmailTemplate E1 = new EmailTemplate();    
               
               
                if(d.Event__r.EV_title__c!='GNEMSDC/MBDA Capital Summit'){
                try{ 
                   E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = :d.Event__r.EV_title__c limit 1];
                   }catch(exception we){   
                   E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Email After Attendee Registration'];  
                 }
               }else{
                   if(mapsurvetQuestonWithEvent.get(d.Event__c)!='Yes'){
                       E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = :d.Event__r.EV_title__c limit 1];
                   }else{
                     E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Email After Attendee Registration']; 
                   }
               
              }   
             
            //  E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Email After Attendee Registration'];  
             
             
             
             
             String ReplaceContactName1 = E1.HtmlValue;
             String replacedname1;
             
             try{ 
             replacedname1 = ReplaceContactName1.Replace('{!userName}',d.First_Name__c +' '+d.Last_Name__c);
             } catch(exception ed){
              replacedname1 = ReplaceContactName1.Replace('{!userName}','');
            }
            
            
             try{ 
               replacedname1 = replacedname1.Replace('{!eventOrgName}',d.Event__r.EV_HostingOrgName__c);
               } catch(exception ed){
                replacedname1 = replacedname1.Replace('{!eventOrgName}','');
             }
             
             
              try{ 
               replacedname1 = replacedname1.Replace('{!company}',d.company__c);
               } catch(exception ed){
               replacedname1 = replacedname1.Replace('{!company}','');
             }
             
             
              try{ 
               replacedname1 = replacedname1.Replace('{!type}',d.TicketTypes__r.Ticket_Category__c);
               } catch(exception ed){
               replacedname1 = replacedname1.Replace('{!type}','');
             }
             
             
             
             
              try{ 
               replacedname1 = replacedname1.Replace('{!ordertype}',d.Payment_Type__c);
               } catch(exception ed){
               replacedname1 = replacedname1.Replace('{!ordertype}','');
             }
             
               try{ 
               replacedname1 = replacedname1.Replace('{!discount}',d.DiscountValue__c);
               } catch(exception ed){
               replacedname1= replacedname1.Replace('{!discount}','');
             }
             
             
              try{ 
               replacedname1= replacedname1.Replace('{!promo}',d.Promocode__c);
               } catch(exception ed){
               replacedname1= replacedname1.Replace('{!promo}','');
             }
             
             
              try{ 
               replacedname1= replacedname1.Replace('{!originolant}',string.valueOf(d.Ticket_Amount__c));
               } catch(exception ed){
               replacedname1= replacedname1.Replace('{!originolant}','');
             }
            
            
            try{ 
               replacedname1= replacedname1.Replace('{!afterdis}',string.valueOf(d.TicketAmount__c));
               } catch(exception ed){
               replacedname1= replacedname1.Replace('{!afterdis}','');
             }
            string frd1;
            try{
              if(d.Event__r.EV_EventLogo__c!=null){
                 frd1 ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id='+d.Event__r.EV_EventLogo__c+'&oid=00DF0000000BpyH';
              }else{
               frd1 ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id=015F0000002PvfM&oid=00DF0000000BpyH';
               }
               replacedname1 = replacedname1.Replace('{!evelogo}',frd1 ); 
               system.debug('TTTTTTTTTT$$$$$$$$$$$$$$$$$$$$$'+d.Event__r.EV_EventLogo__c);
              }catch(exception rf){
             }
             
             
              try{ 
               replacedname1 = replacedname1.Replace('{!organizerName}',d.Event__r.OrganizerId__c);
             } catch(exception ed){
             replacedname1 = replacedname1.Replace('{!organizerName}','');
             }
             
            string stv1; 
           if(eventSettingType=='Collect information below for the ticket buyer only'){ 
            stv1 = '<table style="width:100%;" cellpadding="0" cellspacing="0"><tr><td style="font-weight:bold;border-bottom:1px solid #CCC;">Name</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Type</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Quantity</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Amount Paid</td></tr>';
            
            
             for(Dummay__c  ftr:dummyTypesLIST){
                string cf ='<tr><td style="border-bottom:1px solid #CCC;">'+ ftr.First_Name__c +' '+ftr.Last_Name__c+'</td>';
                string tcN = '<td style="border-bottom:1px solid #CCC;">'+ ftr.TicketTypes__r.TT_Name__c + '</td>';
                string tcQuan = '<td style="border-bottom:1px solid #CCC;">'+ftr.Tickets_Quantty__c  +'</td>';
                string tcamnt = '<td style="border-bottom:1px solid #CCC;">'+'$'+ ftr.TicketAmount__c + '</td></tr>';
                stv1+=cf+tcN+tcQuan+tcamnt;      
                system.debug('SSSSSSSSSSSSSSSSSS '+stv1);    
            }
          }  
            else{
            stv1 = '<table style="width:100%;"><tr><td style="font-weight:bold;border-bottom:1px solid #CCC;">Name</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Type</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Quantity</td><td style="font-weight:bold;border-bottom:1px solid #CCC;">Amount Paid</td></tr>';
              string cf ='<tr><td style="border-bottom:1px solid #CCC;">'+ d.First_Name__c +' '+d.Last_Name__c+'</td>';
                string tcN = '<td style="border-bottom:1px solid #CCC;">'+ d.TicketTypes__r.TT_Name__c + '</td>';
                string tcQuan = '<td style="border-bottom:1px solid #CCC;">'+d.Tickets_Quantty__c  +'</td>';
                string tcamnt = '<td style="border-bottom:1px solid #CCC;">'+ '$'+d.TicketAmount__c + '</td></tr>';
               stv1+=cf+tcN+tcQuan+tcamnt;   
            }
           
           stv1+='</table>';
             
             
             
           try{ 
              replacedname1 = replacedname1.Replace('{!ticketName}',stv1);
             }catch(exception ed){ 
              replacedname1 = replacedname1.Replace('{!ticketName}','');
              }     
             
             
             
             
             
              try{ 
              replacedname1 = replacedname1.Replace('{!eventLocation}',d.Event__r.EV_HostingLocation__c);
              } catch(exception ed){
                 replacedname1 = replacedname1.Replace('{!eventLocation}','');
              }
             
             
             try{ 
              replacedname1 = replacedname1.Replace('{!eventAdd1}',d.Event__r.EV_HistingAddr1__c);
              } catch(exception ed){
              replacedname1 = replacedname1.Replace('{!eventAdd1}','');
              }
             try{ 
             replacedname1 = replacedname1.Replace('{!eventCity}',d.Event__r.AS_HostingCity__c);
             } catch(exception ed){
              replacedname1 = replacedname1.Replace('{!eventCity}','');
             }
             
             try{ 
             replacedname1 = replacedname1.Replace('{!eventState}',d.Event__r.EV_HostingStateNew__c);
             } catch(exception ed){
                replacedname1 = replacedname1.Replace('{!eventState}','');
             }
             
             try{ 
              replacedname1 = replacedname1.Replace('{!EventZip}',d.Event__r.EV_HostingZipcode__c);
            } catch(exception ed){
              replacedname1 = replacedname1.Replace('{!EventZip}','');
            }
            
            try{ 
             replacedname1 = replacedname1.Replace('{!userEmail}',d.Email__c);
             } catch(exception ed){
             replacedname1 = replacedname1.Replace('{!userEmail}','');
             }
             
             try{ 
             replacedname1 = replacedname1.Replace('{!eventName}',d.Event__r.EV_Title__c);
             } catch(exception ed){
             replacedname1 = replacedname1.Replace('{!eventName}','');
             }
             
             try{ 
             replacedname1 = replacedname1.Replace('{!orderNumber}',d.customer_key__r.Name);
             } catch(exception ed){
              replacedname1 = replacedname1.Replace('{!orderNumber}','');
             
             }
             try{
               replacedname1 = replacedname1.Replace('{!peoplenumber}',partiattendPeople);
             }catch(exception exb){
              replacedname1 = replacedname1.Replace('{!peoplenumber}','');
             }
             
             try{
              replacedname1 = replacedname1.Replace('{!question}',questionpeople);
             }catch(exception exb){
              
               replacedname1 = replacedname1.Replace('{!question}','');
             }
             
             Datetime myDatetime10 = d.createddate;
             String myDatetimeStr10 = myDatetime10.format('MM-dd-yyyy hh:mm a');
            try{
             replacedname1 = replacedname1.Replace('{!orderDate}',myDatetimeStr10 );
              }catch(exception exb){
              replacedname1 = replacedname1.Replace('{!orderDate}','');
              }
             
             Date myDatetime12 = d.Event__r.EV_StartDate__c;
             String myDatetimeStr12 = myDatetime12.format();
             
             Date myDatetime13 = d.Event__r.EV_EndDate__c;
             String myDatetimeStr13 = myDatetime13.format();
             try{
             replacedname1 = replacedname1.Replace('{!eventDate}',myDatetimeStr12 +' '+d.Event__r.StartTime__c+'-'+myDatetimeStr13 +' '+d.Event__r.EV_EndTime__c);
           }catch(exception exb){
           replacedname1 = replacedname1.Replace('{!eventDate}','');
           }
             
             
            LIST<String> toAddresses = new LIST<String>();  
              
             toAddresses.add(d.Email__c);
            
             
             Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
             email1.setSubject('Order confirmation Of '+d.Email__c);
                      if( Org != null){  
               email1.setOrgWideEmailAddressId(Org.id);
               
              }
              // Set Attachment 
             
              PageReference pdf = Page.tickettemplate;
              pdf.getParameters().put('id',d.id);   
              system.debug('444444444444444444444444444444 '+pdf);
               system.debug('444444444444444444444444444444 22222222222222 '+d.id);
              
              Blob body;
              
                  body = pdf.getContent();
                  
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName('Ticket.pdf');
            attach.setInline(false);
            attach.Body = body;
           // if(d.Event__r.Id!='a00F0000009tZ6d' && d.Event__r.Id!='a00F000000BMa9Y' ){
            
            //   email1.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
            // }
            email1.setHtmlBody(replacedname1);    
            email1.setToAddresses(toAddresses); 
              
             EmailsList2.add(email1);
             
              
            }catch(exception ex){}
            
            
            
       // }   
             
             
       }
       if(EmailsList.size()>0){  
        Messaging.sendEmail(EmailsList);
        Messaging.sendEmail(EmailsList2);
      }
  }
}
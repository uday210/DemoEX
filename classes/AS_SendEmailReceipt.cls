@RestResource(urlMapping='/AS_SendEmailReceipt/*')
  
 global with sharing class AS_SendEmailReceipt{
    @HttpGet  
    global static Container doGet(){  
        RestRequest req = RestContext.request;
        String TransactionId = req.params.get('TransactionId'); 
        system.debug('  CUSTOMER NAME '+TransactionId);
        Container ct = new Container();
        
        try{
            LIST<Dummay__c> dummyList =  new LIST<Dummay__c>();
            Commanforstates con = new Commanforstates();
            dummyList =[SELECT Event__r.EV_EventLogo__c,Company__c,DiscountValue__c,Promocode__c,Ticket_Amount__c,Event__r.EV_HostingOrgName__c,customer_key__r.Name,ID, Event__r.owner.Email,Event__r.owner.Name,Event__r.owner.userName,NAME, Last_Name__c, First_Name__c,Email__c,TicketAmount__c,  Event__r.AS_HostingAddr2__c, Event__r.EV_HistingAddr1__c,Event__r.EV_HostingZipcode__c,Event__r.EV_HostingStateNew__c,Event__r.AS_HostingCity__c,Event__r.EV_HostingLocation__c,Event__c,Event__r.EV_Title__c,Event__r.EV_StartDate__c, Total_Amount__c,
                               Payment_Status__c,Tickets_Quantty__c,Item__r.Sales_Tax__c,Item__r.Item_name__c,Item_Quantity__c,Event__r.StartTime__c,Event__r.EV_EndDate__c,Event__r.EV_EndTime__c,CreatedDate, TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c ,Event__r.TwitterId__c,Event__r.FacebookId__c,Event__r.OrganizerId__c,Event_Attendee_Mapping__r.AS_Id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_Id__r.AS_LastName__c,Event_Attendee_Mapping__r.AS_Id__r.AS_Email__c,Event_Attendee_Mapping__r.AS_Id__r.AS_Company__c
                        FROM Dummay__c 
                        WHERE customer_key__r.Name =: TransactionId];
            List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();

            OrgWideEmailAddress Org;
            try{
               /* if(dummylist[0].Event__r.OrganizerId__c!=null){
                    Org = [select id from OrgWideEmailAddress WHERE address=:dummylist[0].Event__r.OrganizerId__c];
                    if(Org == NULL){
                        Org = [select id from OrgWideEmailAddress WHERE DisplayNAME =:'Booth Leads'];
                    }
                }*/
                Org = [select id from OrgWideEmailAddress WHERE DisplayNAME =:'Booth Leads'];
                system.debug('  ORGANIZATION WIDE ADDRESS   '+Org);
            }

            catch(Exception e){}
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Order confirmation for '+ dummylist[0].Event__r.EV_Title__c);
            if( Org != null){  
                email.setOrgWideEmailAddressId(Org.id);
            }
            system.debug('  ORGANIZATION WIDE ADDRESS22222222   ');
            dummylist[0].Event__r.EV_HostingStateNew__c=  con.mapstate(dummylist[0].Event__r.EV_HostingStateNew__c);
            LIST<String> ccAddresses = new LIST<String>();
            
            EmailTemplate E = new EmailTemplate();
            try{ 
                E = [SELECT Body,Subject,HtmlValue,Markup FROM EmailTemplate WHERE Name = 'Scan Attendee Registration']; 
            }
            catch(exception Ex){}
            String ReplaceContactName = E.HtmlValue;
            String replacedname;
            Boolean ShowEventName= FALSE;
            Boolean ShowEventLoc= FALSE;       
            Boolean ShowEventAddr= FALSE;     
            Boolean ShowEventCity= FALSE;     
            Boolean ShowEventState= FALSE;     
            Boolean ShowEventZipcode= FALSE;     
                
            try{
                replacedname = ReplaceContactName.Replace('{!userName}',dummylist[0].Event_Attendee_Mapping__r.AS_Id__r.AS_FirstName__c +' '+dummylist[0].Event_Attendee_Mapping__r.AS_Id__r.AS_LastName__c);
            }catch(exception ed){
                replacedname = ReplaceContactName.Replace('{!userName}','' +' '+'');
            }
            
            try{
                replacedname = replacedname.Replace('{!userEmail}',dummylist[0].Event_Attendee_Mapping__r.AS_Id__r.AS_Email__c);
            }catch(exception ed){
                replacedname = replacedname.Replace('{!userEmail}','');
            }
            
            try{
                replacedname = replacedname.Replace('{!userCompany}',dummylist[0].Event_Attendee_Mapping__r.AS_Id__r.AS_Company__c);
            }catch(exception ed){
                replacedname = replacedname.Replace('{!userCompany}','');
            }
                       
            try{ 
                replacedname = replacedname.Replace('{!ordertype}',dummylist[0].Payment_Type__c);
            }catch(exception ed){
                replacedname = replacedname.Replace('{!ordertype}','');
            }
              
            try{ 
                replacedname = replacedname.Replace('{!eventName}',dummylist[0].Event__r.EV_Title__c);
                if(dummylist[0].Event__r.EV_Title__c != NULL || dummylist[0].Event__r.EV_Title__c != ''){
                    ShowEventName= TRUE;
                }
            }catch(exception ed){
                replacedname = replacedname.Replace('{!eventName}','');
            }      
                            
            try{ 
                replacedname = replacedname.Replace('{!eventLocation}',dummylist[0].Event__r.EV_HostingLocation__c);
                if(dummylist[0].Event__r.EV_HostingLocation__c != NULL || dummylist[0].Event__r.EV_HostingLocation__c != ''){
                    ShowEventLoc= TRUE;
                }
            }catch(exception ed){
                replacedname = replacedname.Replace('{!eventLocation}','');
            }
            
            try{ 
                replacedname = replacedname.Replace('{!eventAddress}',dummylist[0].Event__r.EV_HistingAddr1__c);
                if(dummylist[0].Event__r.EV_HistingAddr1__c != NULL || dummylist[0].Event__r.EV_HistingAddr1__c != ''){
                    ShowEventAddr= TRUE;
                }
            }catch(exception ed){
                replacedname = replacedname.Replace('{!eventAddress}','');
            }
            
            try{ 
                replacedname = replacedname.Replace('{!eventCity}',dummylist[0].Event__r.AS_HostingCity__c);
                if(dummylist[0].Event__r.AS_HostingCity__c != NULL || dummylist[0].Event__r.AS_HostingCity__c != ''){
                    ShowEventCity= TRUE;
                }
            }catch(exception ed){
                replacedname = replacedname.Replace('{!eventCity}','');
            }
            
            try{ 
                replacedname = replacedname.Replace('{!eventState}',dummylist[0].Event__r.EV_HostingStateNew__c);
                if(dummylist[0].Event__r.EV_HostingStateNew__c != NULL || dummylist[0].Event__r.EV_HostingStateNew__c != ''){
                    ShowEventState= TRUE;
                }
            }catch(exception ed){
                replacedname = replacedname.Replace('{!eventState}','');
            }
            try{ 
                replacedname = replacedname.Replace('{!eventZipCode}',dummylist[0].Event__r.EV_HostingZipcode__c);  
                if(dummylist[0].Event__r.EV_HostingZipcode__c != NULL || dummylist[0].Event__r.EV_HostingZipcode__c != ''){
                    ShowEventZipcode= TRUE;
                }
            }catch(exception ed){
                replacedname = replacedname.Replace('{!eventZipCode}','');
            }
            system.debug(ShowEventName+' EVENT NAME '+ShowEventLoc+'  '+ShowEventAddr+'   '+ShowEventCity+'   '+ShowEventState);
            Datetime startDatetime;
            try{
                startDatetime = datetime.newInstance(dummylist[0].Event__r.EV_StartDate__c, time.newInstance(0,0,0,0));
               
            }
            catch(Exception ex){}
            String myDatetimeStr1;
            try{
                myDatetimeStr1 = startDatetime.format('MMMM d, yyyy');
            }
            catch(Exception ex){}                
            Datetime endDatetime;
            try{
                endDatetime  = datetime.newInstance(dummylist[0].Event__r.EV_EndDate__c, time.newInstance(0,0,0,0));
            }
            catch(Exception ex){}
            String myDatetimeStr2;
            try{
                myDatetimeStr2 = endDatetime.format('MMMM d, yyyy');
            }
            catch(Exception ex){}
            try{ 
                if(myDatetimeStr1 != myDatetimeStr2){
                    replacedname = replacedname.Replace('{!eventDate}',myDatetimeStr1 +' '+dummylist[0].Event__r.StartTime__c+'-'+myDatetimeStr2 +' '+dummylist[0].Event__r.EV_EndTime__c);
                }else if(myDatetimeStr1 == myDatetimeStr2){
                    replacedname = replacedname.Replace('{!eventDate}',myDatetimeStr1 +' '+dummylist[0].Event__r.StartTime__c+'-'+dummylist[0].Event__r.EV_EndTime__c);                
                }
            } catch(exception ed){
                replacedname = replacedname.Replace('{!eventDate}','');
            }
            
            try{ 
                replacedname = replacedname.Replace('{!organizerName}',dummylist[0].Event__r.OrganizerId__c);
            }catch(exception ed){
                replacedname = replacedname.Replace('{!organizerName}','');
            }

            try{  
                replacedname = replacedname.Replace('{!orderNumber}',dummylist[0].customer_key__r.Name);
            }catch(exception ed){
                replacedname = replacedname.Replace('{!orderNumber}','');
            }
            
            Datetime myDatetime = dummylist[0].createddate;
            String myDatetimeStr = myDatetime.format('MMMM d, yyyy hh:mm a');
            
            try{  
                replacedname = replacedname.Replace('{!orderDate}',myDatetimeStr );
            }catch(exception ed){
                replacedname = replacedname.Replace('{!orderDate}','');
            }

            
            LIST<String> dummylistIds = new LIST<String>();
            Decimal TotalOrderAmount=0.00;
            Decimal TotalDiscountAmount=0;
            Boolean CheckBoolean = false;
            for(Dummay__c d: dummyList){
                dummylistIds.add(d.id); 
                TotalOrderAmount += d.Total_Amount__c;
                if(d.DiscountValue__c!=NULL){
                    TotalDiscountAmount += Decimal.valueOf(d.DiscountValue__c);
                }
                
                
                if(d.TicketTypes__c != NULL){
                    system.debug('$$$$$ '+d.TicketTypes__c);
                    CheckBoolean = true;
                } 
            }
            system.debug('%%%%%%%%% '+CheckBoolean);
            try{
                if(CheckBoolean == true){
                    system.debug('!!!!!!!!');
                    replacedname = replacedname.Replace('{!HeaderBody}','This is your order confirmation for '+dummylist[0].Event__r.EV_Title__c+'. Your detailed order and ticket is attached as a pdf document with this email, feel free to print and bring the ticket to the event. </br>');
                }
                else{
                    system.debug('@@@@@@@');
                    replacedname = replacedname.Replace('{!HeaderBody}','This is your Item order receipt purchased at '+dummylist[0].Event__r.EV_Title__c+'. Your detailed order attached as a pdf document with this email.</br>');
                }  
            }catch(exception ed){
                system.debug('@@@@@@@');
                replacedname = replacedname.Replace('{!HeaderBody}','');
            }
                
            try{ 
                system.debug('  TOTAL ORDER AMOUNT  '+TotalOrderAmount);
                List<String> args = new String[]{'number','###,###,##0.00'};
                String AmountString= String.format(TotalOrderAmount.format(), args);
                system.debug(AmountString+'   2222222  '+AmountString.contains('.'));
                
                String toContructMoney='';
                
                if(AmountString.contains('.')){
                    toContructMoney = AmountString.substring(AmountString.lastIndexOf('.')+1); 
                    system.debug('TTTTTTTTTTTTTTTTTTT      '+ toContructMoney  );
                    if(toContructMoney != ''){
                         system.debug('TTTTTTTTTTTTTTTTTTT      '+ toContructMoney.length()  );
                       if(toContructMoney.length()== 1 ){
                           AmountString += '0';
                       }
                        system.debug('TTTTTTTTTTTTTTTTTTT      '+ AmountString );
                    }
                }else{
                    AmountString += '.00';
                }
               /* 
                String[] SplitAmount= AmountString.split('.');
                //LIST<String> SplitNumbers= new LIST<String>(AmountString.split('.'));
                system.debug(SplitAmount.size()+'   1111111111  '+SplitAmount);                                                  
                
                if(SplitAmount.size() >0){
                    system.debug(SplitAmount[1].length()+'   3333333333  ');
                    if(SplitAmount[1].length() == 1){
                        AmountString= AmountString+'0';                                      
                    }                     
                }                   
            */
                replacedname = replacedname.Replace('{!TotalAmount}',AmountString);
            }catch(exception ed){
                replacedname = replacedname.Replace('{!TotalAmount}','');
            }
            
            try{ 
                replacedname = replacedname.Replace('{!TotalDiscountDetails}',String.valueOf(TotalDiscountAmount));
            }catch(exception ed){
                replacedname = replacedname.Replace('{!TotalDiscountDetails}','');
            }
                
             
            // Set Attachment
            Event_Attendee_Mapping__c eam =new Event_Attendee_Mapping__c();
            eam =[SELECT id,Attendee_Event_IDs__c,EA_AttendeeBarcode__c FROM Event_Attendee_Mapping__c WHERE AS_id__r.AS_Email__c =:dummylist[0].Email__c and EV_id__c=:dummylist[0].event__c LIMIT 1];

            PageReference pdf = Page.SA_TicketTemplate;
            String dummyid = '';
            for(String s:dummylistIds){
                dummyid += s + ',';
            }
            try{
                dummyid =dummyid .substring(0,dummyid.length()-1);
            }
            catch(Exception ex){}
            
            pdf.getParameters().put('id',dummyid);   
            Blob body;
            
            body = pdf.getContent();
                
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName('Ticket.pdf');
            attach.setInline(false);
            attach.Body = body;
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{attach}); 
           
            if(dummylist[0].Event__r.OrganizerId__c!=NULL){
                ccAddresses.add(dummylist[0].Event__r.OrganizerId__c);
            }
            ccAddresses.add(dummylist[0].Email__c);
            email.setToAddresses(ccAddresses);
                
            email.setHtmlBody(replacedname);            
            EmailsList.add(email);   

            if(EmailsList.size()>0){  
                Messaging.sendEmail(EmailsList);
                //Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{EmailsList});
            }   
            ct.Message='Success';
        }
        catch(Exception e){
            ct.Error=e.getMessage();
        }
        return ct; 
    }
    
    global class Container{
        public String Message{get;set;}
        public String Error{get;set;}
        public Container(){ 
        }
    }
}
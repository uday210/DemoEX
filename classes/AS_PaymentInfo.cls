@RestResource(urlMapping='/AS_PaymentInfo/*')
  
 global with sharing class AS_PaymentInfo{
    global static LIST<AttendeeSummary__c> attLIST{get;set;}
    global static LIST<Event_Attendee_Mapping__c> eamLIST{get;set;}
    global static id atteid{get;set;}
    @HttpPost  
    global static Container doPost(){  
    
    RestRequest req = RestContext.request;  
    system.debug('  REQUEST PARAMETERS '+req);
    //parameter for attendee
    String AttendeeFirstName = req.params.get('Attendee_FirstName');
    String AttendeeLastName= req.params.get('Attendee_LastName');
    String AttendeeID = req.params.get('Attendee_Id');
    String EventID = req.params.get('Event_Id');
    String AttendeeEmail=req.params.get('Attendee_Email');
    String AttendeePhone=req.params.get('Attendee_Phone');
    String AttendeeCity=req.params.get('Attendee_City');
    String AttendeeState=req.params.get('Attendee_State');
    String AttendeeCountry=req.params.get('Attendee_Country');
    String AttendeeCompany=req.params.get('Attendee_Company');
    String AttendeeZip=req.params.get('Attendee_Zip');
    String Address1=req.params.get('Address1');
    String Address2=req.params.get('Address2');
    String MobileAttendeeID = req.params.get('MobileAttendee_Id');
    String JobTitle= req.params.get('JobTitle');   
    String AttendeeCategory= req.params.get('AttendeeCategory'); 
    String CustomBarcode= req.params.get('CustomBarcode');   
    
    //parameter for payment
    String Payment_Status=req.params.get('Payment_Status');
    String Payment_Type=req.params.get('Payment_Type');
    String PayKey=req.params.get('PayKey');
    string CardNo= req.params.get('CardNo');
    system.debug(req.params.get('CardNo')+'  ******  '+CardNo);
    system.debug('%%%%%%%% '+PayKey);
    String Check_no=req.params.get('Check_no');

    String Seat_no=req.params.get('Seat_no');
    String Promocode=req.params.get('Promocode');
    boolean isCheckin=boolean.valueOf(req.params.get('isCheckin'));
    system.debug(' TOTAL AMOUNT FOR FREE PAY '+req.params.get('TotalAmount'));     
    Decimal TotalAmount=Decimal.valueOf(req.params.get('TotalAmount'));
    system.debug(req.params.get('TotalScanAttendeeFee')+' TOTAL AMOUNT ATTENDEE FEE '+req.params.get('TotalAmount'));     
    Decimal TotalScanAttendeeFee=Decimal.valueOf(req.params.get('TotalScanAttendeeFee'));
    system.debug(TotalScanAttendeeFee+' SCAN ATTENDEE FEE '+req.params.get('TotalScanAttendeeFee'));     
    RestResponse response = RestContext.response;  
    String jSONRequestBody=req.requestBody.toString().trim(); 
    System.debug('JsonBody '+jSONRequestBody);
    JSONParser jsonParser = JSON.createParser(jSONRequestBody); 
    LIST<String> TicketId=new LIST<String>();
    LIST<String> TicketSold=new LIST<String>();
    LIST<String> TicketAmount=new LIST<String>();
    LIST<String> ItemId=new LIST<String>();
    LIST<String> ItemSold=new LIST<String>();
    LIST<String> ItemAmount=new LIST<String>();
    LIST<String> TicketFeeAmount=new LIST<String>();
    LIST<String> ItemFeeAmount=new LIST<String>();
         
    while(jsonParser.nextToken() != null){
        if(jsonParser.getCurrentToken() == JSONToken.START_ARRAY){
        
            while(jsonParser.nextToken() != JSONToken.END_ARRAY){
            
                if(jsonParser.getText()=='TicketId'){
                    jsonParser.nextToken();
                    TicketId.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='TicketSold'){
                    jsonParser.nextToken();
                    TicketSold.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='TicketAmount'){
                    jsonParser.nextToken();
                    TicketAmount.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='ItemId'){
                    jsonParser.nextToken();
                    ItemId.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='ItemSold'){
                    jsonParser.nextToken();
                    ItemSold.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='ItemAmount'){
                    jsonParser.nextToken();
                    ItemAmount.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='TicketScanAttendeeFee'){
                    jsonParser.nextToken();
                    TicketFeeAmount.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='ItemScanAttendeeFee'){
                    jsonParser.nextToken();
                    ItemFeeAmount.add(jsonParser.getText());                          
                }
                
            }
        }
    }
    system.debug(TicketFeeAmount+'  '+ItemFeeAmount+'   Ticket Ids Are '+TicketId +TicketAmount+TicketSold);
    Container ct=new Container();
        try{
            //Creating Attendee
            AttendeeSummary__c attsum;
            Event_Attendee_Mapping__c evatmap;
            Event_Attendee_Mapping__c eamapping;
            
            Commanforstates con = new Commanforstates();
            
            System.debug('Attendee Email'+AttendeeId+AttendeeEmail+AttendeeCompany+AttendeeCity+AttendeeState+AttendeePhone+AttendeeZip);

            attsum = new AttendeeSummary__c();
            evatmap = new  Event_Attendee_Mapping__c();
            eamapping = new  Event_Attendee_Mapping__c();
            LIST<Event_Attendee_Mapping__c> evLIST = new LIST<Event_Attendee_Mapping__c>();
            system.debug(AttendeeEmail +'   ATTENDEE DETAILS '+EventID);
            if(AttendeeId!=null&&AttendeeId!=''){
                evatmap  = [SELECT id,Custom_Barcode__c,GuestType__c, AS_id__c,IsCancelled__c,Ev_Id__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c 
                            FROM Event_Attendee_Mapping__c 
                            WHERE AS_id__c !=NULL 
                            AND AS_id__c =: AttendeeId 
                            AND Ev_Id__c=:EventID];
                if(evatmap.IsCancelled__c == TRUE){
                    evatmap.IsCancelled__c = FALSE;
                    evatmap.GuestType__c= AttendeeCategory;
                    if(CustomBarcode!=null&&CustomBarcode!='')
                evatmap.Custom_Barcode__c=CustomBarcode;
                    update evatmap;    
                }
                    
                attsum = [SELECT Id,AS_Company__c,AS_WorkZip__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_FirstName__c,AS_LastName__c,AS_Email__c,AS_WorkPhone__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c 
                          FROM AttendeeSummary__c 
                          WHERE AS_Email__c=: AttendeeEmail LIMIT 1];
                                      
                attsum.AS_Company__c=AttendeeCompany;
                attsum.AS_WorkZip__c=AttendeeZip;
                attsum.AS_WorkAddress1__c=Address1;
                attsum.AS_WorkAddress2__c=Address2;
                attsum.AS_FirstName__c=AttendeeFirstName;
                attsum.AS_LastName__c=AttendeeLastName;
                attsum.AS_Email__c=AttendeeEmail;
                attsum.AS_WorkPhone__c=AttendeePhone;
                attsum.AS_WorkCity__c=AttendeeCity;
                attsum.AS_Work_States__c=AttendeeState;
                attsum.AS_Work_Country__c=AttendeeCountry; 
                attsum.AS_Title__c= JobTitle;   
                database.update(attsum,false);
                
                updateUserInfo(AttendeeEmail, AttendeeFirstName, AttendeeLastName, AttendeePhone, AttendeeCompany, AttendeeCity, AttendeeState, AttendeeCountry); 
            }else{ 
                attLIST = [SELECT Id,AS_Email__c FROM AttendeeSummary__c WHERE AS_Email__c=:AttendeeEmail];
                if(attLIST.size()>0){
                    atteid= attLIST[0].id;
                    attsum = [SELECT Id,AS_Company__c,AS_WorkZip__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_FirstName__c,AS_LastName__c,AS_Email__c,AS_WorkPhone__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c FROM AttendeeSummary__c WHERE Id=:atteid];
                    attsum.AS_Company__c=AttendeeCompany;
                    attsum.AS_WorkZip__c=AttendeeZip;
                    attsum.AS_WorkAddress1__c=Address1;
                    attsum.AS_WorkAddress2__c=Address2;
                    attsum.AS_FirstName__c=AttendeeFirstName;
                    attsum.AS_LastName__c=AttendeeLastName;
                    attsum.AS_Email__c=AttendeeEmail;
                    attsum.AS_WorkPhone__c=AttendeePhone;
                    attsum.AS_WorkCity__c=AttendeeCity;
                    attsum.AS_Work_States__c=AttendeeState;
                    attsum.AS_Work_Country__c=AttendeeCountry; 
                    attsum.AS_Title__c= JobTitle;      
                    database.update(attsum,false);
                    system.debug('aaaaa '+attsum);
                }else{
                    System.debug(' Attendee Email2 '+AttendeeId+AttendeeEmail+AttendeeCompany+AttendeeCity+AttendeeState+AttendeePhone+AttendeeZip);
                    attsum.AS_FirstName__c=AttendeeFirstName;
                    attsum.AS_LastName__c=AttendeeLastName;
                    attsum.AS_Email__c=AttendeeEmail;
                    attsum.AS_Company__c=AttendeeCompany;
                    attsum.AS_WorkZip__c=AttendeeZip;
                    attsum.AS_WorkAddress1__c=Address1;
                    attsum.AS_WorkAddress2__c=Address2;
                    attsum.AS_WorkPhone__c=AttendeePhone;
                    attsum.AS_WorkCity__c=AttendeeCity;
                    attsum.AS_Work_States__c=AttendeeState;
                    attsum.AS_Work_Country__c=AttendeeCountry;
                    attsum.AS_Title__c= JobTitle;        
                    insert attsum;
                    atteid = attsum.id;
                    system.debug('bbbb '+attsum);
                }
                system.debug('%%%% '+attsum);
                LIST<Event_Attendee_Mapping__c> EAMListToUpdate= new LIST<Event_Attendee_Mapping__c>();
                EAMListToUpdate= [SELECT ID,Custom_Barcode__c, GuestType__c, IsCancelled__c FROM Event_Attendee_Mapping__c WHERE EV_id__c =: EventID AND AS_id__c =: attsum.id];
                system.debug(' EXISTING EAM LIST '+EAMListToUpdate);
                if(EAMListToUpdate.size() >0){
                    EAMListToUpdate[0].GuestType__c= AttendeeCategory;
                    if(CustomBarcode!=null&&CustomBarcode!='')
                EAMListToUpdate[0].Custom_Barcode__c=CustomBarcode;
                    EAMListToUpdate[0].IsCancelled__c= FALSE;
                    Database.update(EAMListToUpdate, FALSE);
                }else{
                    evatmap=new Event_Attendee_Mapping__c(AS_id__c=attsum.id,EV_id__c=EventID, Attendee_Event_IDs__c= attsum.id+'-'+EventID, GuestType__c= AttendeeCategory,Custom_Barcode__c=CustomBarcode, IsCancelled__c= FALSE);
                    Database.SaveResult EAMToUpsert= Database.insert(evatmap, false);                                 
                }

            }
            
            system.debug('@@22@@ '+evatmap.AS_Id__c+ evatmap.AS_id__r.AS_Firstname__c +evatmap.AS_id__r.AS_Lastname__c+evatmap.AS_id__r.AS_Email__c);
            
            eamapping  = [SELECT id,GuestType__c, EA_AttendeeBarcode__c, AS_id__c,Ev_Id__c, AS_id__r.AS_Title__c, AS_id__r.AS_Company__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c 
                          FROM Event_Attendee_Mapping__c 
                          WHERE AS_id__c !=NULL 
                          AND AS_id__c =: attsum.id
                          AND Ev_Id__c=:EventID LIMIT 1];
            system.debug('$$$$$ '+eamapping+eamapping.AS_Id__r.AS_FirstName__c+eamapping.AS_Id__r.id);
                            
            //Creating response
            Attendee_Details at=new Attendee_Details();
            at.Attendee_FirstName=eamapping.AS_Id__r.AS_FirstName__c;
            at.Attendee_LastName=eamapping.AS_Id__r.AS_LastName__c;
            at.Attendee_Email=eamapping.AS_Id__r.AS_Email__c;
            at.Attendee_Phone=eamapping.AS_Id__r.AS_WorkPhone__c;
            at.AttendeeCompany=eamapping.AS_Id__r.AS_Company__c;
            at.AttendeeZip=eamapping.AS_Id__r.AS_WorkZip__c;
            at.Address1=eamapping.AS_Id__r.AS_WorkAddress1__c;
            at.Address2=eamapping.AS_Id__r.AS_WorkAddress2__c;
            at.AttendeeId=eamapping.AS_Id__r.id;
            at.MobileAttendeeId=MobileAttendeeID;
            at.AttendeeCity=eamapping.AS_Id__r.AS_WorkCity__c;
            at.Attendee_State = con.mapstate(eamapping.AS_Id__r.AS_Work_States__c);
            at.Attendee_State_LongCode =eamapping.AS_Id__r.AS_Work_States__c;
            at.AttendeeCountry = con.mapstate(eamapping.AS_Id__r.AS_Work_Country__c);
            at.AttendeeCountry_LongCode = eamapping.AS_Id__r.AS_Work_Country__c;
            at.JobTitle= eamapping.AS_id__r.AS_Title__c;   
            at.EventID=EventID;
            at.QrcodeIds= eamapping.EA_AttendeeBarcode__c;
            at.AttendeeCategory= eamapping.GuestType__c;
            
            LIST<User> EventAdminUser= new LIST<User>();
            EventAdminUser= [SELECT Id, ProfileId, Username, FirstName, LastName, Email, Companyphone__c, CompanyName, States__c, Country__c, CompanyCity__c FROM User WHERE UserName =: eamapping.AS_Id__r.AS_Email__c];
            UserDetails EventAdminDetails= new UserDetails();
            if(EventAdminUser.size() >0){
            
                EventAdminDetails.FirstName= EventAdminUser[0].FirstName; 
                EventAdminDetails.LastName= EventAdminUser[0].LastName; 
                EventAdminDetails.Company= EventAdminUser[0].CompanyName; 
                EventAdminDetails.PhoneNo= EventAdminUser[0].Companyphone__c;
                EventAdminDetails.City= EventAdminUser[0].CompanyCity__c;
                EventAdminDetails.State= EventAdminUser[0].States__c;
                EventAdminDetails.Country= EventAdminUser[0].Country__c;

            }
                at.usrDetails= EventAdminDetails;            
            
            
            //Creating payments object 
            Constomer__c cust=new Constomer__c(Customer_Name__c=eamapping.AS_Id__r.AS_FirstName__c,
            Email__c=eamapping.AS_Id__r.AS_Email__c,Total_Amount__c=TotalAmount,Isinserted__c=true, ScanAttendee_Fee__c= TotalScanAttendeeFee);
            insert cust;  
    
            //Creating response
            LIST<Dummay__c> payinfo=new LIST<Dummay__c>();
            LIST<Ticket_Details> tt=new LIST<Ticket_Details>();
            LIST<Item_Details> it=new LIST<Item_Details>();
            LIST<Payment_Details> pd=new LIST<Payment_Details>();
            LIST<Each_Ticket_Details> etd=new LIST<Each_Ticket_Details>();
            LIST<Each_Item_Details> eid=new LIST<Each_Item_Details>();
            
            //Updating Ticket Object
            if(TicketId.size()>0){
                LIST<TicketTypes__c> tc=[SELECT id,TT_Sold__c, Available__c, TT_Available__c FROM TicketTypes__c WHERE id in:TicketId]; 
                system.debug(TicketSold+'  '+tc.size()+'   TICKETS SIZE  '+TicketId+'   '+tc);
                MAP<Id, TicketTypes__c> TicketsMAP= new MAP<Id, TicketTypes__c>();
                for(TicketTypes__c t: tc){
                    TicketsMAP.put(t.id, t);
                }
                
                for(integer i=0;i<tc.size();i++){
                    //Decimal pqty=tc[i].TT_Sold__c==null?0:tc[i].TT_Sold__c;
                    //tc[i].TT_Sold__c=pqty+Integer.valueOf(TicketSold[i]);
                    
                    Decimal pqty=TicketsMAP.get(TicketId[i]).TT_Sold__c==null?0:TicketsMAP.get(TicketId[i]).TT_Sold__c;
                    system.debug(TicketSold[i]+'  SOLD QUANTITY  '+pqty);
                    TicketsMAP.get(TicketId[i]).TT_Sold__c=pqty+Integer.valueOf(TicketSold[i]);
                    
                    if(TicketsMAP.get(TicketId[i]).Available__c < Integer.valueOf(TicketSold[i])){
                        TicketsMAP.get(TicketId[i]).TT_Available__c = TicketsMAP.get(TicketId[i]).TT_Sold__c+Integer.valueOf(TicketSold[i]);
                    }
                    system.debug(TicketsMAP.get(TicketId[i]).TT_Available__c+'  AVAILABLE QUANTITY  '+pqty);                    
                    Decimal tam=Decimal.valueOf(TicketAmount[i]);
                    Decimal totalamt= Decimal.valueOf(TicketSold[i])*tam;
                    system.debug(CardNo+'  qqqq '+eamapping.AS_Id__r.AS_FirstName__c + eamapping.AS_Id__r.AS_LastName__c +eamapping.AS_Id__r.AS_Email__c);
                    //tc[i].id
                    payinfo.add(new Dummay__c(First_Name__c=eamapping.AS_Id__r.AS_FirstName__c,Last_Name__c=eamapping.AS_Id__r.AS_LastName__c,
                    Email__c=eamapping.AS_Id__r.AS_Email__c,TicketTypes__c=TicketId[i],Event__c=EventID,
                    TicketAmount__c=totalamt,Payment_Status__c=Payment_Status,
                    Payment_Type__c=Payment_Type,Tickets_Quantty__c=Integer.valueOf(TicketSold[i]),
                    Check_number__c=Check_no,Seat_Number__c=Seat_no, ScanAttendee_Fee__c= Decimal.valueOf(TicketFeeAmount[i]),
                    Promocode__c=Promocode,isCheckedIn__c=isCheckin,payKey__c=PayKey,Credit_Card_Number__c= CardNo,
                    customer_key__c=cust.id,AttendeeSummary__c=eamapping.AS_Id__r.id,Event_Attendee_Mapping__c=eamapping.id));
                    
                    system.debug(payinfo.size()+'  PPPPPPPPPPAAAAAAAYY  '+payinfo);                   
                    Ticket_Details td=new Ticket_Details();
                    td.TicketId=TicketsMAP.get(TicketId[i]).id;
                    td.SoldQty=TicketsMAP.get(TicketId[i]).TT_Sold__c;
                    tt.add(td);         
                }  
                update tc;  
            } 
            
            //Updating Item Object
            if(ItemId.size()>0){
                LIST<Item__c> ic=[SELECT id,Sold_Quantity__c,item_name__c,CreatedDate FROM Item__c WHERE id in:ItemId]; 
                MAP<Id, Item__c> ItemsMAP= new MAP<Id, Item__c>();
                for(Item__c i: ic){
                    ItemsMAP.put(i.id, i);
                }
                
                for(integer i=0;i<ic.size();i++){
                    Decimal pqty=ItemsMAP.get(ItemId[i]).Sold_Quantity__c ==null?0:ItemsMAP.get(ItemId[i]).Sold_Quantity__c;
                    ItemsMAP.get(ItemId[i]).Sold_Quantity__c=pqty+Integer.valueOf(ItemSold[i]);
                    Decimal iam=Decimal.valueOf(ItemAmount[i]);
                    Decimal itotalamt= Decimal.valueOf(ItemSold[i])*iam;
                    system.debug(CardNo+'WWWW '+eamapping.AS_Id__r.AS_FirstName__c + eamapping.AS_Id__r.AS_LastName__c +eamapping.AS_Id__r.AS_Email__c);
                   
                    payinfo.add(new Dummay__c(First_Name__c=eamapping.AS_Id__r.AS_FirstName__c,Last_Name__c=eamapping.AS_Id__r.AS_LastName__c,Email__c=eamapping.AS_Id__r.AS_Email__c,Item__c=ic[i].id,Event__c=EventID,
                    TicketAmount__c=itotalamt,Payment_Status__c=Payment_Status,
                    Payment_Type__c=Payment_Type,Item_Quantity__c=Integer.valueOf(ItemSold[i]),
                    Check_number__c=Check_no,Seat_Number__c=Seat_no, ScanAttendee_Fee__c= Decimal.valueOf(ItemFeeAmount[i]),
                    Promocode__c=Promocode,isCheckedIn__c=isCheckin,payKey__c=PayKey,customer_key__c=cust.id, Credit_Card_Number__c= CardNo,
                    AttendeeSummary__c=eamapping.AS_Id__r.id,Event_Attendee_Mapping__c=eamapping.id));
                    
                    Item_Details id=new Item_Details();
                    id.ItemId=ItemsMAP.get(ItemId[i]).id;
                    id.SoldQty=ItemsMAP.get(ItemId[i]).Sold_Quantity__c;
                    it.add(id);    
                }  
                update ic;
            }
            
            SET<Id> insertedPaymentIds = new SET<Id>(); 
            Database.SaveResult[] RegistrationSaveResultItems =dataBase.insert(payinfo,false); 
            for(Database.SaveResult SaveRes: RegistrationSaveResultItems ){
                if(SaveRes.isSuccess()){
                    insertedPaymentIds.add(SaveRes.getId());
                }
            }
    
            for(integer i=0;i<payinfo.size();i++){
                if(payinfo[i].Item__c==null){
                    Payment_Details p=new Payment_Details();
                    Dummay__c res=[SELECT id,TicketTypes__c,name,customer_key__r.Name,payKey__c FROM Dummay__c WHERE id=:payinfo[i].id AND TicketTypes__c!=NULL limit 1];
                    p.PaymentId=res.name;
                    p.TicketId=res.TicketTypes__c;
                    pd.add(p);
                }
            }  
            
            LIST<Individual_Ticket_Info__c> itiLIST = [SELECT Name,isCheckedIn__c,Registration_Info__r.Check_number__c,Seat__c,Registration_Info__c,Registration_Info__r.name,Registration_Info__r.TicketTypes__c,Registration_Info__r.payKey__c,CreatedDate FROM Individual_Ticket_Info__c WHERE Registration_Info__c IN: insertedPaymentIds AND IsItem__c != TRUE ORDER BY Name]; 
            for(Individual_Ticket_Info__c iti:itiLIST){
                Each_Ticket_Details et = new Each_Ticket_Details();
                et.PaymentId = iti.Name;
                et.TicketId = iti.Registration_Info__r.TicketTypes__c; 
                String DateTimeStr;
                try{
                    DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy hh:mm a');
                }
                catch(Exception e){} 
                et.PaymentTime = DateTimeStr;
                et.PayKey = iti.Registration_Info__r.payKey__c;
                et.Check_no = iti.Registration_Info__r.Check_number__c;
                etd.add(et);
            }
            
            LIST<Individual_Ticket_Info__c> itiitemLIST = [SELECT Name,isCheckedIn__c,Registration_Info__r.Check_number__c,Seat__c,Registration_Info__c,Registration_Info__r.name,Registration_Info__r.Item__c,Registration_Info__r.payKey__c,CreatedDate FROM Individual_Ticket_Info__c WHERE Registration_Info__c IN: insertedPaymentIds AND IsItem__c != FALSE ORDER BY Name]; 
            for(Individual_Ticket_Info__c iti:itiitemLIST){
                Each_Item_Details ei = new Each_Item_Details();
                ei.PaymentId = iti.Name;
                ei.ItemId = iti.Registration_Info__r.Item__c; 
                String DateTimeStr;
                try{
                    DateTimeStr = iti.CreatedDate.format('MMMM d, yyyy hh:mm a');
                }
                catch(Exception e){} 
                ei.PaymentTime = DateTimeStr;
                ei.PayKey = iti.Registration_Info__r.payKey__c;
                ei.Check_no = iti.Registration_Info__r.Check_number__c;
                eid.add(ei);
            }

                    
            Constomer__c cs = [SELECT Id,Name FROM Constomer__c WHERE Id=: cust.id];
            Success sc=new Success();
            sc.Attendee_Details=new LIST<Attendee_Details>();
            sc.Ticket_Details=new LIST<Ticket_Details>();
            sc.Payment_Details=new LIST<Payment_Details>();
            sc.Attendee_Details.add(at);
            sc.Ticket_Details=tt;
            sc.Item_Details=it;
            sc.Payment_Details=pd;
            sc.Each_Ticket_Details=etd;
            sc.Each_Item_Details=eid;
            ct.Success=sc;  
            ct.message='Payment Success';
            ct.TransactionId=cs.Name;
        }
        catch(Exception e){
            ct.error=String.valueOf(e);
        }
        try{
        ct.totalAttendee=[SELECT count() FROM Event_Attendee_Mapping__c WHERE EV_id__c=:EventID AND IsCancelled__c!= TRUE];}catch(Exception e){}
    return ct;
   }
    
    global class Container{
        public Success Success{get;set;}     
        public String message{get;set;}
        public String error{get;set;}
        public String TransactionId{get;set;} 
        public Integer totalAttendee{get;set;}   
    }

    global class Success{    
        public LIST<Attendee_Details> Attendee_Details{get;set;}
        public LIST<Ticket_Details> Ticket_Details{get;set;}
        public LIST<Item_Details> Item_Details{get;set;}
        public LIST<Payment_Details> Payment_Details{get;set;}
        public LIST<Each_Ticket_Details> Each_Ticket_Details{get;set;}
        public LIST<Each_Item_Details> Each_Item_Details{get;set;}
    }
    
    global class Attendee_Details{
        public String Attendee_FirstName{get;set;}
        public String Attendee_LastName{get;set;}
        public String Attendee_Email{get;set;}
        public String Attendee_Phone{get;set;}
        public String AttendeeCompany{get;set;}
        public String AttendeeZip{get;set;}
        public String Address1{get;set;}
        public String Address2{get;set;}
        public String AttendeeID{get;set;}
        public String MobileAttendeeId{get;set;}
        public String EventID{get;set;}
        public String AttendeeCity{get;set;}
        public String Attendee_State{get;set;}
        public String Attendee_State_LongCode{get;set;}
        public String AttendeeCountry{get;set;} 
        public String AttendeeCountry_LongCode{get;set;} 
        public String QrcodeIds{get; set;}
        public String JobTitle{get; set;}        
        public String AttendeeCategory{get; set;}   
        public UserDetails usrDetails{get; set;}     
    }
    
    global class UserDetails{
    
        String FirstName;
        String LastName;
        String Company;
        String PhoneNo;
        String City;
        String State;
        String Country;
                                
        global UserDetails(){}
        
        global UserDetails(String FirstName, String LastName, String Company, String PhoneNo, String City, String State, String Country){
            
            FirstName= FirstName;
            LastName= LastName;
            Company= Company;
            PhoneNo= PhoneNo;
            City= City;
            State= State;                        
            Country= Country;
        }
    }

    
    global class Ticket_Details{
        public Decimal SoldQty{get;set;}
        public String TicketID{get;set;} 
    }
     
    global class Item_Details{
        public Decimal SoldQty{get;set;}
        public String ItemID{get;set;}
    }  
         
    global class Payment_Details{
        public String TicketId{get;set;}     
        public String PaymentId{get;set;}       
    }
    
    global class Each_Ticket_Details{
        public String TicketId{get;set;}     
        public String PaymentId{get;set;} 
        public String PaymentTime{get;set;}
        public String PayKey{get;set;} 
        public String Check_no{get;set;} 
    }
    
    global class Each_Item_Details{
        public String ItemId{get;set;}     
        public String PaymentId{get;set;} 
        public String PaymentTime{get;set;}
        public String PayKey{get;set;} 
        public String Check_no{get;set;} 
    }
    
    
     @future
     global static void updateUserInfo(String Email, String FirstName, String LastName,String Phone,String Company,String City,String State, String Country) {
        system.debug('$$$$ '+Email);
        LIST<User> users= new LIST<User>();
        users =[select Id,ProfileId,Username,FirstName,LastName,Email,Companyphone__c,CompanyName,States__c,Country__c,CompanyCity__c from User where Username=:Email]; 
        if(users.size() > 0){
            users[0].firstname = FirstName;
            users[0].LastName = LastName;
            users[0].Companyphone__c =Phone;
            users[0].companyName=Company;  
            users[0].CompanyCity__c=City;
            users[0].States__c=State;
            users[0].Country__c=Country;
            
            update users[0];
        }
    }
    
}
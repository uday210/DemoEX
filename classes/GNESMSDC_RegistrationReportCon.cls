public with sharing class GNESMSDC_RegistrationReportCon {

    public boolean statuschange{get;set;}
    public Integer TotalAmount{get;set;}
    public Integer TotalccAmount{get;set;}
    public Integer TotalCheckAmount{get;set;}
    public Integer TotalInvoiceAmount{get;set;}
    public Integer TotalRegistrations{get;set;}    
    public id LoginUserID{get;set;}
    public AggregateResult[] results{get;set;}
    public List<Dummay__c> customerkeys {get; set;}
    public LIST<AttendeeSummary__c> attendeeids{get; set;}
    public Event_Attendee_Mapping__c eamid{get; set;}
    public List<Event_Attendee_Mapping__c> eamids{get; set;}    
    public LIST<LIST<Dummay__c>> attforexport{get; set;} 
    public List<Dummay__c> bn{get; set;} 
    public List<Dummay__c> dummyrecords{get; set;}   
    public List<String> entitylist{get; set;}
    public boolean Totalregistrationsbool{get;set;}
    public Dummay__c Dummy{get; set;}
    public ID dummyid {get;set;}
    public String statusvalue{get;set;} 
    public String entityvalue{get;set;} 
        public List<Dummay__c> dummyforprint{get; set;}
        
    public GNESMSDC_RegistrationReportCon(){
        Totalregistrationsbool=true;
        //LoginUserID ='005Z00000019KxV';
        LoginUserID = UserInfo.getUserId();
        customerreport();   
    }
    
    public void customerreport(){ 
        customerkeys = new List<Dummay__c>();
        customerkeys = [SELECT id,customer_key__r.Name,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.User_Type__c,TicketTypes__r.TT_Name__c,customer_key__r.Total_Amount__c,TicketAmount__c,Payment_Status__c,Registered_Date__c
                        FROM Dummay__c 
                        WHERE Event__r.OwnerId =: LoginUserID  
                        AND Primary_Attendee__c = true
                        AND customer_key__c != Null
                        AND customer_key__r.Isinserted__c = true 
                        ORDER BY Company__c];      
               
        TotalRegistrations = customerkeys.size();              
        AggregateResult[] results = [SELECT SUM(customer_key__r.Total_Amount__c) total FROM Dummay__c 
                                     WHERE Event__r.OwnerId =: LoginUserID  
                                     AND Primary_Attendee__c = true
                                     AND customer_key__c != Null
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount = results[0].get('total');
        TotalAmount=Integer.ValueOf(sumAmount);
        
        AggregateResult[] results1 = [SELECT SUM(customer_key__r.Total_Amount__c) total1 FROM Dummay__c 
                                     WHERE Event__r.OwnerId =: LoginUserID  
                                     AND Payment_Type__c = 'Credit Card' 
                                     AND Primary_Attendee__c = true
                                     AND customer_key__c != Null
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount1 = results1[0].get('total1');
        TotalCCAmount=Integer.ValueOf(sumAmount1);
        
        AggregateResult[] results2 = [SELECT SUM(customer_key__r.Total_Amount__c) total2 FROM Dummay__c 
                                     WHERE Event__r.OwnerId =: LoginUserID  
                                     AND Payment_Type__c = 'Check'
                                     AND Primary_Attendee__c = true
                                     AND customer_key__c != Null
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount2 = results2[0].get('total2');
        TotalCheckAmount=Integer.ValueOf(sumAmount2);
        
        AggregateResult[] results3 = [SELECT SUM(customer_key__r.Total_Amount__c) total3 FROM Dummay__c 
                                     WHERE Event__r.OwnerId =: LoginUserID
                                     AND Payment_Type__c = 'Invoice'  
                                     AND Primary_Attendee__c = true
                                     AND customer_key__c != Null
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount3 = results3[0].get('total3');
        TotalInvoiceAmount=Integer.ValueOf(sumAmount3);
    }
     
    public void changestatus(){
        string ss = ApexPages.currentPage().getParameters().get('mycheck');
        dummyid=ss;
        statuschange = true;
    }


    public List<SelectOption> getpaymentstatus(){     
        Dummy= new Dummay__c();       
        List<selectoption> Options = new List<selectoption>();
        Dummy=[SELECT id,customer_key__r.Name,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketAmount__c,Payment_Status__c 
               FROM Dummay__c 
               WHERE id =: dummyid];            
        if(Dummy.Payment_Status__c == 'Paid'){
            statusvalue = 'Paid';
            Options.add(new selectoption('Paid', 'Paid'));
            Options.add(new selectoption('Not Paid', 'Not Paid'));
        }
        else{
            statusvalue = 'Not Paid';
            Options.add(new selectoption('Not Paid', 'Not Paid'));
            Options.add(new selectoption('Paid', 'Paid'));
        }   
       return Options;
    }
    

    public pagereference changingpaymentstatus(){
        attendeeids= new LIST<AttendeeSummary__c>();  
        eamids= new List<Event_Attendee_Mapping__c>();      
        attendeeids=[select id from AttendeeSummary__c where AddedBy__c =: Dummy.Email__c];
        eamids =[SELECT id,AS_id__c FROM Event_Attendee_Mapping__c WHERE AS_id__c IN : attendeeids AND EV_id__c = 'a00F0000008ECae'];                                    
        system.debug('---- '+eamids);
        if(statusvalue=='Paid'){
            Dummy.Payment_Status__c = 'Paid';
            for(Event_Attendee_Mapping__c eamid:eamids)
            {
             eamid.Paid__c = true;                 
            }       
            database.update(eamids,false);    
        }
        else{
            Dummy.Payment_Status__c = 'Not Paid';
            for(Event_Attendee_Mapping__c eamid:eamids)
            {
             eamid.Paid__c = false;                 
            }       
            database.update(eamids,false);            
        }
        update Dummy;
        statuschange=false;
        customerreport();
        pagereference pg= new pagereference('/apex/GNEMSDC_RegistrationReport');       
        return pg; 
    }    
    
    
    public pagereference export(){    
      attforexport = new LIST<LIST<Dummay__c>>();
      dummyrecords = new List<Dummay__c>();
      dummyrecords = [SELECT id,customer_key__r.Name,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.User_Type__c,TicketTypes__r.TT_Name__c,customer_key__r.Total_Amount__c,TicketAmount__c,Payment_Status__c,Registered_Date__c
                        FROM Dummay__c 
                        WHERE Event__r.OwnerId =: LoginUserID  
                        AND Primary_Attendee__c = true
                        AND customer_key__c != Null
                        AND customer_key__r.Isinserted__c = true 
                        ORDER BY Company__c];  
     bn = new List<Dummay__c>();
     for(Dummay__c s: dummyrecords)
     {
      s.Company__c = escape(s.Company__c);
      s.First_Name__c = escape(s.First_Name__c);    
      s.Last_Name__c = escape(s.Last_Name__c);
      bn.add(s);
     }
     attforexport.add(bn);          
     pagereference pg =page.BL_RegistrationExport ;
     return pg;                   
    }
    
    public pagereference print(){    
     dummyforprint = new List<Dummay__c>();
     dummyforprint = [SELECT id,customer_key__r.Name,customer_key__r.Total_Amount__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketAmount__c,Payment_Status__c,Registered_Date__c
                        FROM Dummay__c 
                        WHERE Event__r.OwnerId =: LoginUserID  
                        AND Primary_Attendee__c = true
                        AND customer_key__c != Null
                        AND customer_key__r.Isinserted__c = true 
                        ORDER BY Company__c];          
     Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=GNEMSDC_Registrations_Information.pdf');
     pagereference pg =page.GNEMSDCExport;
     return pg;                  
    }

    public PageReference cancel() {
        statuschange=false;
        pagereference pg= new pagereference('/apex/GNEMSDC_RegistrationReport');
        return pg;
    }   
    
    public string escape(string s){
        if(s != null && s.contains(',')){  
            s=s.replaceAll(',','');
        } 
        return s;
    }  

}
public Class BL_EventAdminRegistration{
    
    public Boolean ReqFields{get; set;}
    public Boolean Prefix{get; set;}
    public Boolean FirstName{get; set;}
    public Boolean LastName{get; set;}
    public Boolean sufix{get; set;}
    public Boolean emailID{get; set;}
    public Boolean Degi{get; set;}
    public Boolean mobile{get; set;}
    public Boolean age{get; set;}
    public Boolean gen{get; set;}
    public Boolean dob{get; set;}
    public Boolean homeinfo{get; set;}
    public Boolean Shippinginfo{get; set;}
    public Boolean workinfo{get; set;}
    public Boolean NAICSCode1{get; set;}
    public Boolean NAICSCode2{get; set;}
    public Boolean NAICSCode3{get; set;}
    public Boolean PBC{get; set;}
    public Boolean SBC{get; set;}
    public Boolean NOEmp{get; set;}
    public Boolean BEDate{get; set;}
    public Boolean BRev{get; set;}
    public Boolean BTaxID{get; set;}
    public Boolean BDN{get; set;}
    public Boolean webUrl{get; set;}
    public Boolean blogURL{get; set;}
    public Boolean DT{get; set;}
    public Boolean BDesc{get; set;}
    public Boolean AttendeePic{get; set;}
    
    public Boolean BusinessBool{get; set;}
    public Boolean NAICSCodeBool{get; set;}
    // NEW Fields.................
    public Boolean comp{get; set;}
    public Boolean NAICSCode4{get; set;}
    public Boolean NAICSCode5{get; set;}
    public Boolean Registration{get; set;}
    
    
    public Boolean workAdd1{get; set;}
    public Boolean workAdd2{get; set;}
    public Boolean workcity{get; set;}
    public Boolean workstate{get; set;}
    public Boolean workCountry{get; set;}     
    public Boolean workzip{get; set;}  
    
          
     //----------------------REQUIREd FIELDS----------------------------
   
    public Boolean ReqReqFields{get; set;}
    public Boolean ReqPrefix{get; set;}
    public Boolean ReqFirstName{get; set;}
    public Boolean ReqLastName{get; set;}
    public Boolean Reqsufix{get; set;}
    public Boolean ReqemailID{get; set;}
    public Boolean ReqDegi{get; set;}
    public Boolean Reqmobile{get; set;}
    public Boolean Reqage{get; set;}
    public Boolean Reqgen{get; set;}
    public Boolean Reqdob{get; set;}
    public Boolean Reqhomeinfo{get; set;}
    public Boolean ReqShippinginfo{get; set;}
    public Boolean Reqworkinfo{get; set;}
    public Boolean ReqNAICSCode1{get; set;}
    public Boolean ReqNAICSCode2{get; set;}
    public Boolean ReqNAICSCode3{get; set;}
    public Boolean ReqPBC{get; set;}
    public Boolean ReqSBC{get; set;}
    public Boolean ReqNOEmp{get; set;}
    public Boolean ReqBEDate{get; set;}
    public Boolean ReqBRev{get; set;}
    public Boolean ReqBTaxID{get; set;}
    public Boolean ReqBDN{get; set;}
    public Boolean ReqwebUrl{get; set;}
    public Boolean ReqblogURL{get; set;}
    public Boolean ReqDT{get; set;}
    public Boolean ReqBDesc{get; set;}
    public Boolean ReqAttendeePic{get; set;}
    
    //public Boolean ReqBusinessBool{get; set;}
    //public Boolean ReqNAICSCodeBool{get; set;}
    
    // NEW Req Fields.................
    public Boolean Reqcomp{get; set;}
    public Boolean ReqNAICSCode4{get; set;}
    public Boolean ReqNAICSCode5{get; set;}
    public Boolean ReqRegistration{get; set;}
    
    
    
    
    
    
    
    
    
    
     
    public SET<String> selectAttlist{get; set;}
    public SET<String> selectReqAttlist{get; set;}
    
    
    
    public BL_EventAdminRegistration(id eventId){
     
     selectAttlist = new SET<String>();
      selectReqAttlist = new SET<String>();
        try{
        Event__c event=[SELECT ID, NAME,EV_IncludedFields__c,EV_QuickReg__c,Ev_RequiredFields__c, EV_Publish__c FROM Event__c WHERE id =: eventId LIMIT 1]; 
        
        
        
      
        
        selectAttlist.addAll(new LIST<String>(event.EV_IncludedFields__c.split(',')));
        
      
        selectReqAttlist.addAll(new LIST<String>(Event.Ev_RequiredFields__c.split(',')));
        
        }catch(Exception e){}
        
        if(selectAttlist.contains('AttendeePic'))
           AttendeePic = TRUE;
      else  AttendeePic = FALSE;  
     if(selectAttlist.contains('AS_FirstName__c'))
           ReqFields = TRUE;
      else  ReqFields = FALSE;  
     if(selectAttlist.contains('AS_Company__c'))
           comp = TRUE;
      else  comp = FALSE;    
     if(selectAttlist.contains('AS_Prefix__c'))
            Prefix = TRUE;
      else Prefix = FALSE;      
     if(selectAttlist.contains('AS_Suffix__c'))
            sufix = TRUE;
      else sufix = FALSE;      
     if(selectAttlist.contains('AS_Title__c'))
             Degi= TRUE;
      else Degi= FALSE;        
     if(selectAttlist.contains('AS_CellPhone__c'))
           mobile = TRUE; 
      else mobile = FALSE;     
      if(selectAttlist.contains('AS_Age__c'))
           age = TRUE; 
       else age = FALSE;    
      if(selectAttlist.contains('AS_Gender__c'))
            gen = TRUE;
        else gen = FALSE;     
      if(selectAttlist.contains('AS_BirthDate__c'))
            dob = TRUE; 
       else  dob = FALSE;
      if(selectAttlist.contains('AS_HomeAddress1__c'))
           homeInfo  = TRUE; 
       else homeInfo  = FALSE;    
      if(selectAttlist.contains('AS_ShippingAddress1__c'))
           Shippinginfo  = TRUE; 
       else Shippinginfo  = FALSE;    
      if(selectAttlist.contains('AS_WorkAddress1__c'))
            workInfo = TRUE; 
       else workInfo = FALSE;      
      if(selectAttlist.contains('AS_NAICSCode1__c'))
            NAICSCode1 = TRUE; 
       else NAICSCode1 = FALSE;     
      if(selectAttlist.contains('AS_NAICSCode2__c'))
            NAICSCode2 = TRUE; 
        else NAICSCode2 = FALSE;    
      if(selectAttlist.contains('AS_NAICSCode3__c'))
           NAICSCode3  = TRUE; 
        else NAICSCode3  = FALSE;   
      if(selectAttlist.contains('AS_NAICSCode4__c'))
           NAICSCode4  = TRUE; 
        else NAICSCode4  = FALSE;  
        system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      if(selectAttlist.contains('AS_NAICSCode5__c'))
           NAICSCode5  = TRUE; 
        else NAICSCode5  = FALSE;  
      if(selectAttlist.contains('AS_PrimaryBusinessCategory__c'))
            PBC = TRUE; 
        else PBC = FALSE;     
      if(selectAttlist.contains('AS_SecondaryBusinessCategory__c'))
            SBC = TRUE; 
        else SBC = FALSE;    
      if(selectAttlist.contains('AS_NumberOfEmployees__c'))
           NOEmp  = TRUE; 
        else NOEmp  = FALSE;   
      if(selectAttlist.contains('AS_BusinessEstablishedDate__c'))
            BEDate = TRUE; 
        else BEDate = FALSE;    
      if(selectAttlist.contains('AS_BusinessRevenue__c'))
            BRev = TRUE; 
        else BRev = FALSE;    
      if(selectAttlist.contains('AS_BusinessTaxId__c'))
           BTaxId  = TRUE; 
        else BTaxId  = FALSE;   
      if(selectAttlist.contains('AS_BusinessDunsNumber__c'))
           BDN  = TRUE; 
        else BDN  = FALSE;   
      if(selectAttlist.contains('AS_WebsiteUrl__c'))
           webUrl  = TRUE;
        else webUrl  = FALSE;    
      if(selectAttlist.contains('AS_BlogUrl__c'))
           blogUrl  = TRUE; 
       else blogUrl  = False;    
      if(selectAttlist.contains('AS_DiversityType__c'))
            DT = TRUE; 
       else DT = FALSE;     
      if(selectAttlist.contains('AS_BusinessDescription__c'))
            BDesc = TRUE; 
       else BDesc = FALSE; 
      if(selectAttlist.contains('Registration_type__c'))
          Registration = TRUE;
       else Registration = FALSE;
       
      BusinessBool = (PBC || SBC || NOEmp || BEDate || BRev || BTaxID || BDN || webUrl || blogURL || BDesc || DT );
      NAICSCodeBool =(NAICSCode1|| NAICSCode2|| NAICSCode3|| NAICSCode4|| NAICSCode5);
      
      system.debug('NAICSCodeBoolNAICSCodeBoolNAICSCodeBool'+ NAICSCodeBool );
      
      
      
      
      // Require Fields
      
       //------------------------REQUIRED FIELDS CHECKING--------------------
      if(selectReqAttlist.contains('AttendeePic'))
           ReqAttendeePic = TRUE;
      else  ReqAttendeePic = FALSE;  
     if(selectReqAttlist.contains('AS_FirstName__c'))
           ReqReqFields = TRUE;
      else  ReqReqFields = FALSE;  
     if(selectReqAttlist.contains('AS_Company__c'))
           Reqcomp = TRUE;
      else  Reqcomp = FALSE;    
     if(selectReqAttlist.contains('AS_Prefix__c'))
            ReqPrefix = TRUE;
      else ReqPrefix = FALSE;      
     if(selectReqAttlist.contains('AS_Suffix__c'))
            Reqsufix = TRUE;
      else Reqsufix = FALSE;      
     if(selectReqAttlist.contains('AS_Title__c'))
             ReqDegi= TRUE;
      else ReqDegi= FALSE;        
     if(selectReqAttlist.contains('AS_CellPhone__c'))
           Reqmobile = TRUE; 
      else Reqmobile = FALSE;     
      if(selectReqAttlist.contains('AS_Age__c'))
           Reqage = TRUE; 
       else Reqage = FALSE;    
      if(selectReqAttlist.contains('AS_Gender__c'))
            Reqgen = TRUE;
        else Reqgen = FALSE;     
      if(selectReqAttlist.contains('AS_BirthDate__c'))
            Reqdob = TRUE; 
       else  Reqdob = FALSE;
      if(selectReqAttlist.contains('AS_HomeAddress1__c'))
           ReqhomeInfo  = TRUE; 
       else ReqhomeInfo  = FALSE;    
      if(selectReqAttlist.contains('AS_ShippingAddress1__c'))
           ReqShippinginfo  = TRUE; 
       else ReqShippinginfo  = FALSE;    
      if(selectReqAttlist.contains('AS_WorkAddress1__c'))
            ReqworkInfo = TRUE; 
       else ReqworkInfo = FALSE;      
      if(selectReqAttlist.contains('AS_NAICSCode1__c'))
            ReqNAICSCode1 = TRUE; 
       else ReqNAICSCode1 = FALSE;     
      if(selectReqAttlist.contains('AS_NAICSCode2__c'))
            ReqNAICSCode2 = TRUE; 
        else ReqNAICSCode2 = FALSE;    
      if(selectReqAttlist.contains('AS_NAICSCode3__c'))
           ReqNAICSCode3  = TRUE; 
        else ReqNAICSCode3  = FALSE;   
      if(selectReqAttlist.contains('AS_NAICSCode4__c'))
           ReqNAICSCode4  = TRUE; 
        else ReqNAICSCode4  = FALSE;  
        system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      if(selectReqAttlist.contains('AS_NAICSCode5__c'))
           ReqNAICSCode5  = TRUE; 
        else ReqNAICSCode5  = FALSE;  
      if(selectReqAttlist.contains('AS_PrimaryBusinessCategory__c'))
            ReqPBC = TRUE; 
        else ReqPBC = FALSE;     
      if(selectReqAttlist.contains('AS_SecondaryBusinessCategory__c'))
            ReqSBC = TRUE; 
        else ReqSBC = FALSE;    
      if(selectReqAttlist.contains('AS_NumberOfEmployees__c'))
           ReqNOEmp  = TRUE; 
        else ReqNOEmp  = FALSE;   
      if(selectReqAttlist.contains('AS_BusinessEstablishedDate__c'))
            ReqBEDate = TRUE; 
        else ReqBEDate = FALSE;    
      if(selectReqAttlist.contains('AS_BusinessRevenue__c'))
            ReqBRev = TRUE; 
        else ReqBRev = FALSE;    
      if(selectReqAttlist.contains('AS_BusinessTaxId__c'))
           ReqBTaxId  = TRUE; 
        else ReqBTaxId  = FALSE;   
      if(selectReqAttlist.contains('AS_BusinessDunsNumber__c'))
           ReqBDN  = TRUE; 
        else ReqBDN  = FALSE;   
      if(selectReqAttlist.contains('AS_WebsiteUrl__c'))
           ReqwebUrl  = TRUE;
        else ReqwebUrl  = FALSE;    
      if(selectReqAttlist.contains('AS_BlogUrl__c'))
           ReqblogUrl  = TRUE; 
       else ReqblogUrl  = False;    
      if(selectReqAttlist.contains('AS_DiversityType__c'))
            ReqDT = TRUE; 
       else ReqDT = FALSE;     
      if(selectReqAttlist.contains('AS_BusinessDescription__c'))
            ReqBDesc = TRUE; 
       else ReqBDesc = FALSE;
      
      
      
      if(selectReqAttlist.contains('AS_WorkAddress1__c'))
            workAdd1 = TRUE; 
       else workAdd1 = FALSE; 
      if(selectReqAttlist.contains('AS_WorkAddress2__c'))
            workAdd2 = TRUE; 
       else workAdd2 = FALSE; 
      if(selectReqAttlist.contains('AS_WorkCity__c'))
            workcity = TRUE; 
       else workcity = FALSE; 
      if(selectReqAttlist.contains('AS_WorkState__c'))
            workstate = TRUE; 
       else workstate = FALSE; 
      if(selectReqAttlist.contains('AS_WorkCountry__c'))
            workCountry = TRUE; 
       else workCountry = FALSE; 
      if(selectReqAttlist.contains('AS_WorkZip__c'))
            workzip = TRUE; 
       else workzip = FALSE;  
       
      
      
      
      
    }
    
    
    
    
    
    
    
}
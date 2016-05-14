public without sharing class BLN_CustomBagdeCon {
    public String selectedBadgeValue { get; set; }

    public String bdgQrValue { get; set; }
    public String bdgLogoValue { get; set; }
    public String bdgCnValue { get; set; }
    public String bdgFulNValue { get; set; }
    public String bdgLnValue { get; set; }
    public String bdgFnValue { get; set; }   
    public BLN_BadgeTemplate_Styles__c BDTEMP { get; set; }    
    public string selectedevent {get ; set ;}
    public transient  list<BLN_BadgeTemplate_Styles__c> exsitingtemps {get ; set ;}
    public list<string> jsonstr {get;set;}
   
    //Constructor
    public BLN_CustomBagdeCon(){
   
    foradd = false;
    foredit = false;
    jsonstr = new list<string> ();
   
    selectedevent = '' ;
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
         if(k!=null){ 
             selectedEvent = k.getValue();
         }
    exsitingtemps = new list<BLN_BadgeTemplate_Styles__c> ();
    exsitingtemps = [select id,Badge_Type__c,Module__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,BadgeName__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c,Event__r.Name from BLN_BadgeTemplate_Styles__c where Event__c =: selectedevent];
    for(BLN_BadgeTemplate_Styles__c bdt : exsitingtemps ){
     if(bdt.FirstRowElement__c != null && bdt.FirstRowElement__c != '')
    {
    bdt.FirstRowElement__c = bdt.FirstRowElement__c.replace('[','');
    bdt.FirstRowElement__c = bdt.FirstRowElement__c.removeend(']');
    }
     if(bdt.SecondElement__c != null && bdt.SecondElement__c != '')
    {
    bdt.SecondElement__c = bdt.SecondElement__c.replace('[','');
    bdt.SecondElement__c = bdt.SecondElement__c.removeend(']');
    }
     if(bdt.ThirdElement__c != null && bdt.ThirdElement__c != '')
    {
    bdt.ThirdElement__c = bdt.ThirdElement__c.replace('[','');
    bdt.ThirdElement__c = bdt.ThirdElement__c.removeend(']');
    }
     if(bdt.FourthElement__c != null && bdt.FourthElement__c != '')
    {
     bdt.FourthElement__c = bdt.FourthElement__c.replace('[','');
    bdt.FourthElement__c = bdt.FourthElement__c.removeend(']');
    }
    if(bdt.FifthElement__c != null && bdt.FifthElement__c != '')
    {
     bdt.FifthElement__c  = bdt.FifthElement__c .replace('[','');
    bdt.FifthElement__c  = bdt.FifthElement__c .removeend(']');
    }
    if(bdt.SixthElement__c!= null && bdt.SixthElement__c!= '')
    {
     bdt.SixthElement__c= bdt.SixthElement__c.replace('[','');
    bdt.SixthElement__c= bdt.SixthElement__c.removeend(']');
    }
    if(bdt.SeventhElement__c!= null && bdt.SeventhElement__c!= '')
    {
     bdt.SeventhElement__c= bdt.SeventhElement__c.replace('[','');
    bdt.SeventhElement__c= bdt.SeventhElement__c.removeend(']');
    }
    if(bdt.EightthElement__c!= null && bdt.EightthElement__c!= '')
    {
     bdt.EightthElement__c  = bdt.EightthElement__c.replace('[','');
    bdt.EightthElement__c  = bdt.EightthElement__c.removeend(']');
    }
    if(bdt.ninthelement__c!= null && bdt.ninthelement__c!= '')
    {
     bdt.ninthelement__c  = bdt.ninthelement__c.replace('[','');
    bdt.ninthelement__c= bdt.ninthelement__c.removeend(']');
    }
    string  jsonstr1 = '';
     bdt.BadgeName__c = bdt.BadgeName__c.removeend(',');
     jsonstr1 = bdt.BadgeName__c+'***';
     jsonstr.add(jsonstr1);
    }
    
   
    }
        

    public void savedimensions() {
        //return null;
        BDTEMP  = new BLN_BadgeTemplate_Styles__c ();
        system.debug('HHHHH========================  '+ApexPages.currentPage().getParameters().get('Abcd'));
      
         string  ss = ApexPages.currentPage().getParameters().get('Abcd');
         list<string> objects = ss.split('"elementPropertiesArray":');
            //list<string> bdnames = objects[0].split('{"badgeDetailsObject":');
          
        list<string> listarray = new list<string> ();
        //objects[1] = objects[1].replace('}]','');
        //system.debug('ddddddddddddddddddddddddddddddddddddddddddddddddddd'+objects[1]);
        objects[1]=objects[1].removeEnd('}]}');
         listarray  = objects[1].split('},');
        objects [0]=objects [0].replace('{"badgeDetailsObject":','');
      BDTEMP.BadgeName__c = objects [0];
      list<string> fornames = objects [0].split('savedImageDataUrl');
      list<string> actualval = fornames[0].split('width');
      string exactname = '';
      exactname = actualval[0].replace('{"name":"','');
      exactname = exactname.replace(',','');
       exactname = exactname.replace('"','');
         system.debug('HHHHH  '+listarray[0]);
         BDTEMP.Name = exactname;
        
         if(listarray.size() > 0)
         BDTEMP.FirstRowElement__c = listarray[0]+'}]';
         if(listarray.size() > 1)
          BDTEMP.SecondElement__c    = '['+listarray[1]+'}]';
          if(listarray.size() > 2)
           BDTEMP.ThirdElement__c = '['+listarray[2]+'}]';
           if(listarray.size() > 3)
            BDTEMP.FourthElement__c = '['+listarray[3]+'}]';
                if(listarray.size() > 4){
               
              BDTEMP.fifthElement__c = '['+listarray[4]+'}]';}
            
            
              if(listarray.size() > 5){
              
             BDTEMP.SixthElement__c = '['+listarray[5]+'}]';}
             if(listarray.size() > 6){
             system.debug('6666666666666666666666666'+listarray[6]);
             BDTEMP.SeventhElement__c = '['+listarray[6]+'}]';}
             if(listarray.size() > 7){
             BDTEMP.EightthElement__c = '['+listarray[7]+'}]';}
             if(listarray.size() > 8){
             BDTEMP.ninthElement__c = '['+listarray[8]+'}]';}
             BDTEMP.Event__c = selectedevent;
             BDTEMP.Badge_Type__c=ApexPages.currentPage().getParameters().get('badgetype');
             BDTEMP.Module__c=ApexPages.currentPage().getParameters().get('vals');
             
             System.debug('Selected Badge Value '+selectedBadgeValue);
            database.upsert(BDTEMP);
        
        system.debug('bbbbbbbbbbbbbbbbbbbbbbbbb'+BDTEMP);
      
        
        
    }
    
    Public BLN_BadgeTemplate_Styles__c  ShowSelectedadge{get;set;}
    public string ShowBadge {get;set;}
    public boolean foradd {get; set;}
    public boolean foredit {get;set;}
    
    public void editBadge(){
    foradd= false;
    foredit = true;
    ShowBadge = '';
    system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'+Apexpages.currentpage().getparameters().get('editnameval'));
    string namevaledit = Apexpages.currentpage().getparameters().get('editnameval');
    ShowSelectedadge =  new BLN_BadgeTemplate_Styles__c(); 
    ShowSelectedadge = [select id,Name,Module__c,Badge_Type__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,
                        SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c,BadgeName__c from BLN_BadgeTemplate_Styles__c
                        where Event__c =: selectedevent AND Name =: namevaledit ];
    if(ShowSelectedadge.FirstRowElement__c != null && ShowSelectedadge.FirstRowElement__c != ''){                    
    ShowSelectedadge.FirstRowElement__c = ShowSelectedadge.FirstRowElement__c.replace('[','');
    ShowSelectedadge.FirstRowElement__c = ShowSelectedadge.FirstRowElement__c.removeend(']');}
    if(ShowSelectedadge.SecondElement__c != null && ShowSelectedadge.SecondElement__c != ''){
    ShowSelectedadge.SecondElement__c = ShowSelectedadge.SecondElement__c.replace('[','');
    ShowSelectedadge.SecondElement__c = ShowSelectedadge.SecondElement__c.removeend(']');}
    if(ShowSelectedadge.ThirdElement__c!= null && ShowSelectedadge.ThirdElement__c!= ''){
    ShowSelectedadge.ThirdElement__c = ShowSelectedadge.ThirdElement__c.replace('[','');
    ShowSelectedadge.ThirdElement__c = ShowSelectedadge.ThirdElement__c.removeend(']');} 
     if(ShowSelectedadge.FourthElement__c!= null && ShowSelectedadge.FourthElement__c!= ''){    
    ShowSelectedadge.FourthElement__c = ShowSelectedadge.FourthElement__c.replace('[','');
    ShowSelectedadge.FourthElement__c = ShowSelectedadge.FourthElement__c.removeend(']'); }
    if(ShowSelectedadge.FifthElement__c != null && ShowSelectedadge.FifthElement__c != ''){   
    ShowSelectedadge.FifthElement__c  = ShowSelectedadge.FifthElement__c .replace('[','');
    ShowSelectedadge.FifthElement__c  = ShowSelectedadge.FifthElement__c .removeend(']}}'); 
    ShowSelectedadge.FifthElement__c  = ShowSelectedadge.FifthElement__c .removeend(']');}
    if(ShowSelectedadge.SixthElement__c != null){
    ShowSelectedadge.SixthElement__c = ShowSelectedadge.SixthElement__c.replace('[','');
    ShowSelectedadge.SixthElement__c = ShowSelectedadge.SixthElement__c.removeend(']'); 
    }else{
    ShowSelectedadge.SixthElement__c = '';
    }
    if(ShowSelectedadge.SeventhElement__c != null){ 
    ShowSelectedadge.SeventhElement__c = ShowSelectedadge.SeventhElement__c.replace('[','');
    ShowSelectedadge.SeventhElement__c = ShowSelectedadge.SeventhElement__c.removeend(']');  
    }else{   
    ShowSelectedadge.SeventhElement__c = '';
    }
    
    
    if(ShowSelectedadge.EightthElement__c!= null){ 
    ShowSelectedadge.EightthElement__c= ShowSelectedadge.EightthElement__c.replace('[','');
    ShowSelectedadge.EightthElement__c= ShowSelectedadge.EightthElement__c.removeend(']');  
    }else{   
    ShowSelectedadge.EightthElement__c= '';
    }
    
    
    if(ShowSelectedadge.ninthelement__c!= null){ 
    ShowSelectedadge.ninthelement__c= ShowSelectedadge.ninthelement__c.replace('[','');
    ShowSelectedadge.ninthelement__c= ShowSelectedadge.ninthelement__c.removeend(']');  
    }else{   
    ShowSelectedadge.ninthelement__c= '';
    }
    
    
     String badgename=ShowSelectedadge.BadgeName__c;
     badgename=badgename.substring(0,badgename.length()-1);
     String badgetype=ShowSelectedadge.Badge_Type__c;
     String module=ShowSelectedadge.Module__c;

    ShowBadge = module+'***'+badgetype+'***'+badgename+'***'+ShowSelectedadge.FirstRowElement__c +'***'+ ShowSelectedadge.SecondElement__c  +'***'+ ShowSelectedadge.ThirdElement__c  +'***'+ ShowSelectedadge.FourthElement__c  +'***'+ ShowSelectedadge.FifthElement__c +'***'+ ShowSelectedadge.SixthElement__c +'***'+ ShowSelectedadge.SeventhElement__c+'***'+ ShowSelectedadge.EightthElement__c+'***'+ ShowSelectedadge.ninthelement__c;
    
                      
    
    
    }
    
    public void deletename(){
    
    system.debug(';;;;;;;;;;;;;;;;;;;;;;;;;Del val ;;;;;;;;;;;;;;;;;;;;'+ApexPages.currentPage().getParameters().get('nameval'));
    
    string delvalue = ApexPages.currentPage().getParameters().get('nameval');
    BLN_BadgeTemplate_Styles__c bddel = [select id from BLN_BadgeTemplate_Styles__c where Event__c =: selectedevent AND Name LIKE : delvalue ];
    system.debug('------------------'+bddel.id );
    delete bddel;
    
    }
     
     public list<string> objects;
     public void updatetemplate(){
     delete ShowSelectedadge;
     ShowSelectedadge = new BLN_BadgeTemplate_Styles__c ();
     system.debug('   =============mythily ================   '+ApexPages.currentPage().getParameters().get('updtnameval'));
    
        string  ss = ApexPages.currentPage().getParameters().get('updtnameval');
        objects = new list<string>();
        objects = ss.split('"elementPropertiesArray":');
        system.debug('=========TTTTTTT============'+ objects);
        //system.debug('=========PPPPPPP============'+ objects[1]);
        list<string> listarray = new list<string> ();
        objects[1]=objects[1].removeEnd('}]}');
        listarray  = objects[1].split('},');
        objects[0]=objects[0].replace('{"badgeDetailsObject":','');
        
        ShowSelectedadge.BadgeName__c = objects[0];
        list<string> fornames = objects [0].split('savedImageDataUrl');
        list<string> actualval = fornames[0].split('width');
        string exactname = '';
        exactname = actualval[0].replace('{"name":"','');
        exactname = exactname.replace(',','');
        exactname = exactname.replace('"','');
        //system.debug('HHHHH  '+listarray[0]);
        ShowSelectedadge.Name = exactname;
        
         if(listarray.size() > 0){
         ShowSelectedadge.FirstRowElement__c = listarray[0]+'}]';}
         if(listarray.size() > 1){
          ShowSelectedadge.SecondElement__c    = '['+listarray[1]+'}]';}
          if(listarray.size() > 2){
           ShowSelectedadge.ThirdElement__c = '['+listarray[2]+'}]';}
           if(listarray.size() > 3){
            ShowSelectedadge.FourthElement__c = '['+listarray[3]+'}]';}
                if(listarray.size() > 4){
               
              ShowSelectedadge.fifthElement__c = '['+listarray[4]+'}]';}
            
            
              if(listarray.size() > 5){
              
             ShowSelectedadge.SixthElement__c = '['+listarray[5]+'}]';}
             if(listarray.size() > 6){
             system.debug('6666666666666666666666666'+listarray[6]);
             ShowSelectedadge.SeventhElement__c = '['+listarray[6]+'}]';}
             if(listarray.size() > 7){
             ShowSelectedadge.EightthElement__c = '['+listarray[7]+'}]';}
             if(listarray.size() > 8){
             ShowSelectedadge.ninthelement__c= '['+listarray[8]+'}]';}
             ShowSelectedadge.Event__c = selectedevent;
             ShowSelectedadge.Badge_Type__c=ApexPages.currentPage().getParameters().get('badgetypeup');
             ShowSelectedadge.Module__c=ApexPages.currentPage().getParameters().get('valsupdate');
             
            database.insert(ShowSelectedadge);
        
        system.debug('bbbbbbbbbbbbbbbbbbbbbbbbb'+ShowSelectedadge);
      
     
     
     
    }
    }
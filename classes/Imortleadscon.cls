public with sharing class Imortleadscon {
public string selectedeventid{get;set;}
public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}    
    public List<List<String>> allFields{get;set;}
    public List<header> gridrows{get;set;}
    public string badgeId{get;set;}
    public string scanTime{get;set;}
    public List<SelectOption> fieldsoptions{get;set;}
    public string compid{get;set;}
    public string loginusergnid{get;set;}
    public id LoginUserID{get;set;}
    public GN_User__c gn{get;set;}
    BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
    Public BLN_UtillDisplayLinks  myticket{get;set;}
    public  BLN_Event__c ev{get;set;}
    public Imortleadscon(){
    BLN_Gnuser_DAO gndao= new BLN_Gnuser_DAO();
    LoginUserID = UserInfo.getUserId();
        gn=gndao.gettinggnuser(LoginUserID);
        loginusergnid=gn.id;
        compid=gn.Default_Company_ID__c;
        selectedeventid = Apexpages.currentPage().getParameters().get('id');
         if(selectedeventid ==null){
               Cookie k = ApexPages.currentPage().getCookies().get('counter');
             if(k!=null){
             selectedeventid = k.getValue();
             }
             }
             BLN_Events_DAO evndao = new BLN_Events_DAO();
         ev = evndao.getEventtimezone(selectedeventid);
         myticket = new BLN_UtillDisplayLinks();
         myticket.isLeadRetrieval='active';
         myticket.isLeadExpand='expand';
         myticket.tablabel='Import Leads';
         myticket.eventName = ev.Name;
         myticket.EventId= selectedeventid;
         myticket.userPermissions(userInfo.getUserId(),selectedeventid); 
         gridrows=new List<header>();
        }
   
    public PageReference importCSVFile() 
    {
        if(csvFileBody==null)
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a File.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        String csvAsString = blobToString( csvFileBody,'ISO-8859-1');
        //String csvAsString = csvFileBody.toString();
        allFields=BLN_ImportAttendeesCon.parseCSV(csvAsString,false);
        List<String> headerrow=new List<String>();
        gridrows=new List<header>();
        fieldsoptions = new list<selectoption>();
        fieldsoptions.add(new selectoption('None','--None--'));
        fieldsoptions.add(new selectoption('Custom_Barcode__c','Custom Barcode'));
        fieldsoptions.add(new selectoption('Scan_Date__c','Scan Date'));
        fieldsoptions.add(new selectoption('Scan_Time__c','Scan Time'));
       // fieldsoptions.add(new selectoption('device__c','Device Name'));
        
        for(String s:allFields[0])
        {
        
            header gr=new header();
            gr.csvheader=s;
            
            For(SelectOption so : fieldsoptions)
            {
            
                if(gr.csvheader.contains(so.getlabel()))
                {
                    gr.field=so.getvalue();
                     break;
                }
            }
            
            gridrows.add(gr);
        }                
        return null;
    }  
    
    
    public class header
    {
        public String csvheader{get;set;}
        public String field{get;set;}     
    }
    
    public list<string> badgeIdList{set;get;}
    public list<datetime> scantimeList{set;get;}
    public map<string,string> ticketMap{set;get;}
     datetime sTimeled;
     String str;
    public PageReference Import()
    {
    badgeIdList= new list<string>();
    scantimeList=  new list<datetime>();
    boolean badgeIdExist=false,scanTimeExist=false,scandateExist=false,deviceExist=false;
   if(gridrows.size()==0)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a File and click next.');
    ApexPages.addMessage(myMsg);
   
    return null;
    }
    if(gridrows.size()!=0)
    {
        for(header e:gridrows)
        {
          if(e.field=='Custom_Barcode__c'){
          badgeIdExist=true;
          }
          if(e.field=='Scan_Date__c'){
          scandateExist=true;
          }     
        
        if(e.field=='Scan_Time__c'){
          scanTimeExist=true;     
        }
       /* if(e.field=='Device__c'){
          deviceExist=true;     
        } */
        }
    }
    if(csvFileBody==null)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a File.');
    ApexPages.addMessage(myMsg);
    return null;
    }
    if(allFields.size()==1)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter atleast one record in the file');
    ApexPages.addMessage(myMsg); 
    return null;
    }
    
    if(badgeIdExist==true&&scanTimeExist==true&&scandateExist==true)
    {
    allFields.remove(0);
    
    
         BLN_LeadScan_DAO led=new BLN_LeadScan_DAO();
        lisT<Lead_Scan__c> lscanlistall = new list<Lead_Scan__c>();
          lscanlistall=led.allleads(selectedeventid,loginusergnid); // fech all leadscan recodrs based on eventid and loginuserid
       
       
      Id batchInstanceId = Database.executeBatch(new BLN_BatchImportLeads(allFields, gridrows,ev,lscanlistall,loginusergnid,compid,csvAsString), 50);
        
        PageReference pg=new PageReference('/apex/BLN_LeadRetrieval');
        pg.getParameters().put('isImport','true');
        pg.setRedirect(true);
        return pg;        
        }
        else{
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Custom barcode ,ScanTime,Scan Date are mandatory to map for Import.');
        ApexPages.addMessage(myMsg); 
        return null;
        }
      
     }
     
     /*********wraper class*******************************/
  public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }    

/****************************************************/
public PageReference exportToCSV()
        {
                PageReference pageRef= new PageReference('/apex/BLN_LeadsImportTemplate');
                pageRef.setredirect(false);
                return pageRef;
        }


}
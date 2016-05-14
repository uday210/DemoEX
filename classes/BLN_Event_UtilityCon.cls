public class BLN_Event_UtilityCon{
/***********************************************************************************************
*   Controller Name : BLN_Event_Utility
*   Date            : 22/05/2014
*   Author          : Naga Mallikarjuna Rao B
*   Purpose         : This class is for show which Item Types to display in Events Pop-up
*   Change History  : 22/05/2014 
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   22/05/2014          Naga Mallikarjuna Rao B         To Create Page
*   23/05/2014          Naga Mallikarjuna Rao B         To get Package in packageItemType method.
*   05/06/2014          Naga Mallikarjuna Rao B         Added MOre ItemTypes...........
*   07/06/2014          Naga Mallikarjuna Rao B         Changed display ItemTypes Concepct based on selection of Event Options from Events page...........    
**************************************************************************************************/
   
   
   // This is For to know main ticket Type (Admission) from Item types.
   // Presently we are calling as "Attendee Admission".
   
    
    public static String mainItemType(){     
        LIST<Item_Type__c> itemTypes= new LIST<Item_Type__c>();         
        itemTypes= [SELECT ID, Item_Type_Number__c FROM Item_Type__c WHERE Name =: 'Admissions'];
        String itemType='';
        if(itemTypes.size() >0){
            itemType= itemTypes[0].Item_Type_Number__c;
        }   
            return itemType;     
            //return 'IT-000001';
    }
    
    
     public static String speakerItemType(){     
        LIST<Item_Type__c> itemTypes= new LIST<Item_Type__c>();         
        itemTypes= [SELECT ID, Item_Type_Number__c FROM Item_Type__c WHERE Name =: 'Speaker'];
        String itemType='';
        if(itemTypes.size() >0){
            itemType= itemTypes[0].Item_Type_Number__c;
        }   
            return itemType;     
            //return 'IT-000001';
    }
    
     
    
    //This is used in Events page for Display Item Types in Tickets detail popup, 
    //mainly to remove packages ticket, Matchleads, related Event Option Ticjets in ItemTypes
    
    
    
    public static LIST<String> ItemTypesToDisplayInEvents(){
       LIST<String> listOfItemTypes = new LIST<String>();
        
        listOfItemTypes.add('IT-000001');
        listOfItemTypes.add('IT-000002');
        
        listOfItemTypes.add('IT-000005');   
        //listOfItemTypes.add('IT-000007');  
        //listOfItemTypes.add('IT-000008'); 
        //listOfItemTypes.add('IT-000009'); 
        //listOfItemTypes.add('IT-000010'); 
        
    //Added On 07/06/2014       
        listOfItemTypes.add('IT-000011');
        listOfItemTypes.add('IT-000012');
        listOfItemTypes.add('IT-000013');
        listOfItemTypes.add('IT-000014');
        listOfItemTypes.add('IT-000015');
        listOfItemTypes.add('IT-000016');
        listOfItemTypes.add('IT-000017');
        listOfItemTypes.add('IT-000018');
        listOfItemTypes.add('IT-000019');
        listOfItemTypes.add('IT-000020');
        listOfItemTypes.add('IT-000021');
        listOfItemTypes.add('IT-000021');
     
        /*
        //If User Selects MatchLeads then we have display **MatchLeads Buyyer** and **Match Leads Seller** Item Types.
        if(matchLeadsBool){
           listOfItemTypes.add('IT-000003');
           listOfItemTypes.add('IT-000004'); 
        }
        
        */
        return listOfItemTypes;
    }

    
    public static LIST<String> displayEventOptions(){
         
         
         LIST<String> listOfItemTypes = new LIST<String>();
            /*
            listOfItemTypes.add('IT-000004'); 
            listOfItemTypes.add('IT-000007');  
            listOfItemTypes.add('IT-000008'); 
            listOfItemTypes.add('IT-000009'); 
            listOfItemTypes.add('IT-000010');  */
        return listOfItemTypes;
    } 

    public static String admissionItemType(){
    
        LIST<Item_Type__c> itemTypes= new LIST<Item_Type__c>();         
        itemTypes= [SELECT ID, Item_Type_Number__c FROM Item_Type__c WHERE Name =: 'Package'];
        String itemType='';
        if(itemTypes.size() >0){
            itemType= itemTypes[0].Item_Type_Number__c;
        }   
            return itemType;  
        //String packageItemType = 'IT-000005'; return 'IT-000005';           
        
    }
   




    //This is used in Events create/Edit page to get Package Item Types in packages creation area, 

    public static String packageItemType(){
    
        LIST<Item_Type__c> itemTypes= new LIST<Item_Type__c>();         
        itemTypes= [SELECT ID, Item_Type_Number__c FROM Item_Type__c WHERE Name =: 'Package'];
        String itemType='';
        if(itemTypes.size() >0){
            itemType= itemTypes[0].Item_Type_Number__c;
        }   
            return itemType;
        //String packageItemType = 'IT-000005';
            
        return 'IT-000005';
    }
    
    
    public static LIST<String> matchLeadsTickets(){
        LIST<String> matchLeadsLIST = new LIST<String>();
        
           matchLeadsLIST.add('IT-000003');
           matchLeadsLIST.add('IT-000004'); 
        return matchLeadsLIST;
    }
    
    public static LIST<String> leadRetrieval(){
        LIST<String> leadRetrievalLIST = new LIST<String>();
                leadRetrievalLIST.add('IT-000010');
        return leadRetrievalLIST;
    }
    
    public static LIST<String> scanAttendee(){
        LIST<String> scanAttendeeLIST = new LIST<String>();
        
        scanAttendeeLIST.add('IT-000007');
        return scanAttendeeLIST;
    }
    
    public static LIST<String> Kiosk(){
        LIST<String> KioskLIST = new LIST<String>();
        
            KioskLIST.add('IT-000008');
            return KioskLIST;
    }
    
    public static LIST<String> boothMaps(){
        LIST<String> boothMapsLIST = new LIST<String>();
        
                boothMapsLIST.add('IT-000009');
        return boothMapsLIST;
    }
    
                        
    public SET<String> itemTypeEventOptions(set<string> eventOptions){
        
        SET<String> itemTypesTodisplay = new SET<String>();
        
        if(eventOptions.contains('IT-000003') || eventOptions.contains('IT-000004') ){
            itemTypesTodisplay.add('IT-000003');
            itemTypesTodisplay.add('IT-000004');
        } 
        
        if(eventOptions.contains('IT-000010')){
            itemTypesTodisplay.add('IT-000010');
        }
        
        if(eventOptions.contains('IT-000007')){
            itemTypesTodisplay.add('IT-000007');
        }
        
        if(eventOptions.contains('IT-000008')){
            itemTypesTodisplay.add('IT-000008');
        }
        
        if(eventOptions.contains('IT-000009')){
            itemTypesTodisplay.add('IT-000009');
        }
        
        
        return itemTypesTodisplay;
    }
    
     
    public SET<String> allMainItemType(){
        SET<String> itemTypesTodisplay = new SET<String>();
        
         itemTypesTodisplay.add('IT-000001'); 
         itemTypesTodisplay.add('IT-000011');
         itemTypesTodisplay.add('IT-000018');
         itemTypesTodisplay.add('IT-000013');
         itemTypesTodisplay.add('IT-000014');
         itemTypesTodisplay.add('IT-004179');
         itemTypesTodisplay.add('IT-004180');
         itemTypesTodisplay.add('IT-004181');
         itemTypesTodisplay.add('IT-000031');
         itemTypesTodisplay.add('IT-000025');
    
        return itemTypesTodisplay;
    }
    
    public static LIST<Currency__c> defaultCurrency(){
        
        LIST<Currency__c> currencies = new LIST<Currency__c>();
        currencies = [SELECT id, Name, Currency_Name__c, Currency_Symbol__c FROM Currency__c WHERE Name ='USD'] ;      
        
        return currencies;
        
    }
    //After selecting Event options we will display created tickets in VF page based on following MAP.
    public static MAP<String, Boolean> itemTypesDisplayInEventsPage(){
        
        MAP<String, Boolean> displayMap = new MAP<String, Boolean>();
        
        displayMap.put('IT-000003', TRUE);  //MatchLeads Buyyer
        displayMap.put('IT-000004', TRUE);  //MatchLeads Seller
        displayMap.put('IT-000010', TRUE);  // Lead Scan
        displayMap.put('IT-000007', FALSE); // Scan Attendee
        displayMap.put('IT-000008', FALSE); // Kiosk
        displayMap.put('IT-000009', FALSE); // BoothMAP
        displayMap.put('IT-000001', TRUE); // Admission
        displayMap.put('IT-000005', TRUE); // BoothMAP
        
        
        
        return displayMap;
        
    }
    
    
    //After selecting Event options we will display created tickets in VF page based on following MAP.
    public static MAP<String, Boolean> paygatewaytypes(String module){
        
        MAP<String, Boolean> paygtype= new MAP<String, Boolean>();
        BLN_PGateway_Type_DAO pgdao=new BLN_PGateway_Type_DAO();
        
        for(PGateway_Type__c pt:pgdao.pGateWayTypes())
         {
               if(module=='Online')
               paygtype.put(pt.name+','+pt.Adaptive_Type__c,pt.Online_Flag__c);
               if(module=='Onsite')
               paygtype.put(pt.name+','+pt.Adaptive_Type__c,pt.Onsite_Flag__c);
               if(module=='ScanAttendee')
               paygtype.put(pt.name+','+pt.Adaptive_Type__c,pt.ScanAttendee_Flag__c);
         }
        
        
        
        return paygtype;
        
    }
    
    
    
}
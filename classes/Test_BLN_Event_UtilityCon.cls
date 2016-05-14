@istest
public class Test_BLN_Event_UtilityCon{
    static testmethod void Testmethod_BLN_Event_UtilityCon(){
    
    
    BLN_Event_UtilityCon bc = new BLN_Event_UtilityCon();
    
    LIST<Item_Type__c> it = new LIST<Item_Type__c>();         
        it= [SELECT ID, Item_Type_Number__c FROM Item_Type__c WHERE Name =: 'Admissions'];
         
    
    BLN_Event_UtilityCon.mainItemType();
    
    LIST<String> li = new LIST<String>();
        li.add('IT-000011');
        li.add('IT-000012');
        li.add('IT-000013');
        li.add('IT-000014');
        li.add('IT-000015');
        li.add('IT-000016');
        li.add('IT-000017');
        li.add('IT-000018');
        li.add('IT-000019');
        li.add('IT-000020');
        
        BLN_Event_UtilityCon.ItemTypesToDisplayInEvents();
        
         LIST<String> lo = new LIST<String>();
            lo.add('IT-000004'); 
            lo.add('IT-000007');  
            lo.add('IT-000008'); 
            lo.add('IT-000009');
            
            BLN_Event_UtilityCon.displayEventOptions();
            
             LIST<Item_Type__c> ip = new LIST<Item_Type__c>();    
             ip = [SELECT ID, Item_Type_Number__c FROM Item_Type__c WHERE Name =: 'Package'];
             
             BLN_Event_UtilityCon.admissionItemType();
             BLN_Event_UtilityCon.packageItemType();
             
             LIST<String> ml = new LIST<String>();
             ml.add('IT-000003');
             ml.add('IT-000004'); 
             BLN_Event_UtilityCon.matchLeadsTickets();
             
              LIST<String> ll = new LIST<String>();
              ll.add('IT-000010');
            BLN_Event_UtilityCon.leadRetrieval();
            
              LIST<String> sc = new LIST<String>();
               sc.add('IT-000007');
              BLN_Event_UtilityCon.scanAttendee(); 
              
              LIST<String> bm = new LIST<String>();
                bm.add('IT-000009');
                BLN_Event_UtilityCon.boothMaps(); 
                
              SET<String> iq = new SET<String>();
              iq.add('IT-000003');
              iq.add('IT-000010');
               iq.add('IT-000007');
               iq.add('IT-000008');
                iq.add('IT-000009');
                bc.itemTypeEventOptions(iq);
                
                bc.allMainItemType();
                
                
                LIST<Currency__c> cu = new LIST<Currency__c>();
               cu = [SELECT id, Name, Currency_Name__c, Currency_Symbol__c FROM Currency__c WHERE Name ='USD'] ;       
                BLN_Event_UtilityCon.defaultCurrency();
                
                
                MAP<String, Boolean> ds = new MAP<String, Boolean>();
                   ds.put('IT-000003', TRUE);  //MatchLeads Buyyer
                 ds.put('IT-000004', TRUE);  //MatchLeads Seller
                ds.put('IT-000010', TRUE);  // Lead Scan
                ds.put('IT-000007', FALSE); // Scan Attendee
                ds.put('IT-000008', FALSE); // Kiosk
                ds.put('IT-000009', FALSE); // BoothMAP
                ds.put('IT-000001', TRUE); // Admission
                ds.put('IT-000005', TRUE); // BoothMAP
                BLN_Event_UtilityCon.itemTypesDisplayInEventsPage();
                
                MAP<String, Boolean> pa = new MAP<String, Boolean>();
                BLN_PGateway_Type_DAO pdo =new BLN_PGateway_Type_DAO();
                string modul= 'Online';
                  BLN_Event_UtilityCon.paygatewaytypes(modul);
                  string mdlu = 'Onsite';
                  BLN_Event_UtilityCon.paygatewaytypes(mdlu);
                  string mdhjb = 'ScanAttendee';
                  BLN_Event_UtilityCon.paygatewaytypes(mdhjb);
                  
              }  
             }
public with sharing class Report_Registration_attendess_con {

    public Integer countontaketcategory{get;set;} 
    public string ticketcategoryName{get;set;}
    public String EventString{get;set;}
    public Integer Totaltablescount{get;set;}
    public Integer TotalExhibhitorstaffcount{get;set;}
    public Integer TotalSponsorstaffcount{get;set;}
    public Integer sponsorsTablecount{get;set;}
    public Integer Totalwificount{get;set;}
    Public Integer Totalelectriccount{get;set;}
    
    public Report_Registration_attendess_con(){
         
         EventString= Apexpages.currentpage().getparameters().get('id');
         countontaketcategory = 0;
         ticketcategoryName = '';
         Innerproductivity = new LIST<innerSalesProductivity>();  
           system.debug(' aaaaaaaaaa     ' + EventString );               
      
      Aggregateresult[] res = [SELECT count(Id),TicketTypes__r.Ticket_Category__c
                                    FROM Dummay__c
                                    WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString AND
                                    TicketTypes__r.TT_Name__c != 'Sponsor Staff' AND
                                    TicketTypes__r.TT_Name__c != 'Exhibitor Staff' AND
                                    TicketTypes__r.TT_Name__c != 'Electric' AND
                                    TicketTypes__r.TT_Name__c != 'WIFI'                                    
                                    GROUP BY TicketTypes__r.Ticket_Category__c];
         //                                    
                           
       system.debug(' Aggregate res !!!!!    ' + res );  
         for(AggregateResult r : res){
               integer countontaketcategory = Integer.valueOf(r.get('expr0'));
               string ticketcategoryName= (string)r.get('Ticket_Category__c');
              Innerproductivity.add(new innerSalesProductivity(ticketcategoryName,countontaketcategory)); 
       system.debug(' INNER CLASS res !!!!!    ' + Innerproductivity);  
         }
   
       Totaltablescount = TablesCount() ;
       TotalExhibhitorstaffcount= ExhibitorstaffCount();
       TotalSponsorstaffcount= SponsorstaffCount();
       sponsorsTablecount= sponsorTablesCount();
       Totalwificount= wificount();
       Totalelectriccount= electricCount();
              system.debug(' SPONSOR TABLE   ' + sponsorsTablecount);  

    }
    
     public Integer TablesCount() 
      {
             Aggregateresult[] TablesCountsze= [SELECT TicketTypes__r.Ticket_Category__c,Company__c
                                    FROM Dummay__c
                                    WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString And TicketTypes__r.Ticket_Category__c =: 'Exhibitor'
                                    GROUP BY TicketTypes__r.Ticket_Category__c,Company__c];
            integer tablesCount2 = TablesCountsze.size();
            return tablesCount2;
       }
       
        public Integer sponsorTablesCount() 
      {
             Aggregateresult[] sponsorTablesCountsze= [SELECT TicketTypes__r.Ticket_Category__c,Company__c
                                    FROM Dummay__c
                                    WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString And TicketTypes__r.Ticket_Category__c =: 'Sponsor'
                                    GROUP BY TicketTypes__r.Ticket_Category__c,Company__c];
            integer sponsortablesCount = sponsorTablesCountsze.size();
            return sponsortablesCount;
       }
        
      public Integer ExhibitorstaffCount() 
      
      {
              LIST<Dummay__c> Exhibitorstaffsze = [SELECT id,TicketTypes__r.TT_Name__c,Company__c
                                                   FROM Dummay__c
                                                   WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString And TicketTypes__r.TT_Name__c =: 'Exhibitor Staff'
                                                   ];
            integer staffCoun2= Exhibitorstaffsze.size();
            return staffCoun2;
      } 
      
       public Integer SponsorstaffCount() 
      
      {  system.debug(' EVENT ID '+EventString );
              LIST<Dummay__c> Sponsorstaffsize = [SELECT id,TicketTypes__r.TT_Name__c,Company__c
                                                   FROM Dummay__c
                                                   WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString And TicketTypes__r.TT_Name__c =: 'Sponsor Staff'
                                                   ];
            integer SponsorCount= Sponsorstaffsize.size();
            return SponsorCount;
      } 
      
       public Integer wificount() 
      
      {  system.debug(' EVENT ID '+EventString );
              LIST<Dummay__c> wifisize = [SELECT id,TicketTypes__r.TT_Name__c,Company__c
                                                   FROM Dummay__c
                                                   WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString And TicketTypes__r.TT_Name__c =: 'WIFI'
                                                   ];
            integer wifiCount= wifisize.size();
            return wifiCount;
           
      } 
         
         
        public Integer electricCount() 
      
      {  system.debug(' EVENT ID '+EventString );
              LIST<Dummay__c> electricsize = [SELECT id,TicketTypes__r.TT_Name__c,Company__c
                                                   FROM Dummay__c
                                                   WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString And TicketTypes__r.TT_Name__c =: 'Electric'
                                                   ];
            integer electricCount= electricsize.size();
            return electricCount;
             
      } 
    
      public LIST<innerSalesProductivity> Innerproductivity{get; set;} 
   
      public class innerSalesProductivity{
   
            public integer regatendeecount{get; set;}
            public string ticketcategory {get; set;}
             public innerSalesProductivity(string s1,integer i1){
                   regatendeecount= i1; 
                   ticketcategory = s1;
                 system.debug(' Aggregate sssssssssss     ' + regatendeecount + '111111 ' + ticketcategory );  
              } 
       }
    

}
public with sharing class ticrepcon
 {


 public List<Dummay__c> dummys{get;set;}
 public LIst<TicketTypes__c> ticTypes{get;set;}
 public string selectedEvent{get;set;}
 public MAP<id,TicketTypes__c> MapIdwithTic{get;set;}
 //public List<selectOption> options {get;set;}
 public string[] str{get;set;}
 public string eventName{get;set;}
 public Integer TotalAmount{get;set;}
  public Integer TotalCount{get;set;}
 public transient MAP<string,AttendeeSummary__c> MapIdwithatt{get;set;}
 public List<DisplayTickets> options{get;set;} 
 public MAP<id,Decimal> MapIdwithNumber{get;set;}
 public MAP<id,integer> MapIdwithcount{get;set;}
 
 public ticrepcon(){
 selectedEVent =Apexpages.CurrentPage().getParameters().get('id'); 

TotalAmount =0;
TotalCount = 0;
    ticTypes = new LIst<TicketTypes__c>();
    MapIdwithTic = new MAP<id,TicketTypes__c>();
    options = new List<DisplayTickets>();
    MapIdwithcount = new MAP<id,integer>();
    
    
        ticTypes = [select id,TT_Amount__c,Available__c,Avilable_for_Portal__c,Description__c,End_Time__c,EV_id__c,TT_Limit__c,Max_Tickets_per_Order__c,Min_Tickets_per_Order__c,
        TT_Name__c,Sales_End_Date__c,Sales_Start_Date__c,Service_Fee__c,Start_Time__c,TT_Sold__c,   Ticket_Category__c,Ticket_Description__c,   Ticket_Image_URL__c,TT_TicketType__c,TT_Available__c from TicketTypes__c where  EV_id__c=:selectedEVent and TT_NAme__c!=null order By Ticket_Category__c];
     
     MapIdwithNumber = new  MAP<id,Decimal>();
     
       for(AggregateResult ar : [SELECT SUM(TicketAmount__c) total, TicketTypes__r.id tids,SUM(Tickets_Quantty__c) ticsold  FROM Dummay__c 
                                         WHERE Event__r.id =: selectedEVent
                                         AND customer_key__c != Null
                                         AND TicketTypes__c!=null 
                                         //AND Primary_Attendee__c=TRUE
                                         AND customer_key__r.Isinserted__c = true  group By TicketTypes__r.id]){
              
                id tdid = (id)ar.get('tids'); 
                //id.valueOf(ar.get('tids'));
                decimal desi =(decimal)ar.get('total');
                  decimal desi1 =(decimal)ar.get('ticsold');
                  system.debug('HHHHHHHHHHHHHHHHHHH '+ desi1+tdid);  
                integer tcount =integer.valueOf(desi1);         
                MapIdwithNumber.put(tdid,desi); 
                MapIdwithcount.put(tdid,tcount);
            }
     
     
     
     
     
         for(TicketTypes__c tt : ticTypes ){
           MapIdwithTic.put(tt.id,tt); 
          // options.add(new SelectOption(tt.id,tt.TT_Name__c+'-'+tt.Ticket_Category__c));
          options.add(new DisplayTickets(tt,MapIdwithNumber.get(tt.id),MapIdwithcount.get(tt.id))); 
         }
    }
    
    
     public class DisplayTickets{
       public TicketTypes__c ttInn{get;set;}
       public Boolean myCheckbox { get; set; } 
       public decimal revenue{get;set;}
       public integer soldcount{get;set;}
       
       public DisplayTickets (TicketTypes__c tre,decimal rn,integer iso){
       ttInn = new TicketTypes__c();
         this.ttInn = tre;
         this.revenue =rn;
         this.soldcount = iso; 
       }
     }
    
    
    
    
    
 
 public void fortickets(){
  str = new string[]{};
   for(DisplayTickets dis:options){
     if(dis.myCheckbox){
       str.add(dis.ttInn.id);
     }
   }
  

 AggregateResult[] results = new AggregateResult[]{};
 results = [SELECT SUM(TicketAmount__c) total,SUM(Tickets_Quantty__c) abc FROM Dummay__c 
                                         WHERE Event__r.id =: selectedEVent
                                         AND customer_key__c != Null
                                         AND TicketTypes__c!=null 
                                         AND customer_key__r.Isinserted__c = true                     
                                         AND TicketTypes__r.ID IN :str ];
                                         
               system.debug('HHHHHHHHHHHHHHHHH '+results );                          
            Object sumAmount = results[0].get('total');
            decimal df = (decimal)results[0].get('abc');
            TotalCount = integer.valueOf(df);
          
            TotalAmount=Integer.ValueOf(sumAmount);
            if(TotalCount==null){
             TotalCount=0;
            }
            
            if(TotalAmount==null){
             TotalAmount =0;
            }
   }

 

 
 
 
 
 
    public LIst<List<inncls>> innList{get;set;}
    public transient  List<inncls> inn{get;set;}
   
 
    public PageReference  export(){
     str = new string[]{};
     
    dummys= new List<Dummay__c >();
    inn = new List<inncls>();
    innList = new  LIst<List<inncls>>();
     MapIdwithatt =new MAP<string,AttendeeSummary__c>();
 
    GlobalAttendee ga = new GlobalAttendee();
    system.debug('YYYYYYYYYYYYYYY '+MapIdwithatt);
    set<string> emails = new set<string>();
    
   for(Event_Attendee_Mapping__c eam:[select id,as_id__r.AS_email__C from Event_Attendee_Mapping__c where EV_ID__c=:selectedEvent]){
    emails.add(eam.AS_id__r.AS_email__c);
   }
    
    
    for( AttendeeSummary__c atta : [Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,Keywords__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, 
                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,Exhibitor_company_imageUrl__c From AttendeeSummary__c a where a.AS_Email__c =:emails ]){
                  
                  MapIdwithatt.put(atta.AS_Email__c,atta);
    
    }
     
     
     
     
     
     integer i=0;
       for(DisplayTickets dis:options){
             if(dis.myCheckbox){
               str.add(dis.ttInn.id);
             }
          }       
     
       for(Dummay__c d : [select Event__r.EV_Title__c,id,email__c,Tickets_Quantty__c,TicketTypes__c,First_Name__c,Last_Name__c,Payment_Type__c,customer_key__r.Name,TicketAmount__c,Promocode__c,Phone__c,DiscountValue__c,Check_number__c,Registered_Date__c from Dummay__c  where Event__c=:selectedEvent  and TicketTypes__c in :str and customer_key__r.isinserted__c=true and TicketTypes__c!=null]){
          if(i==0){
            eventName = d.Event__r.EV_Title__c;
           i++;
          }
          
           AttendeeSummary__c attsum = new AttendeeSummary__c();
           try{
           attsum = MapIdwithatt.get(d.email__c);
          }catch(exception ex){}
          
          
          if(attsum !=null){
           if(attsum.AS_Company__c!=null){
             attsum.AS_Company__c=escape(attsum.AS_Company__c);
           }   
          
          
           if(attsum.AS_BusinessDescription__c!=null){
             attsum.AS_BusinessDescription__c=escape(attsum.AS_BusinessDescription__c);
           }
       
       
           if(attsum.AS_WorkAddress1__c!=null){
             attsum.AS_WorkAddress1__c=escape(attsum.AS_WorkAddress1__c);
           } 
        
               
           if(attsum.AS_WorkAddress2__c!=null){
             attsum.AS_WorkAddress2__c=escape(attsum.AS_WorkAddress2__c);
           } 
         } 
           
           TicketTypes__c tp = new TicketTypes__c();
             try{    
                 tp =MapIdwithTic.get(d.TicketTypes__c);
             }catch(exception er){}
           
           if(inn.size()==900){
              inn.add(new inncls(d,tp ,attsum ));
              innList.add(inn);
              inn = new List<inncls>();
           }else{
              inn.add(new inncls(d,tp ,attsum ));
           }
       }
      
       innList.add(inn);
       
    PageReference pageRef= new PageReference('/apex/exportDummyToexcel');
    pageRef.setredirect(false);
    return pageRef;  
    }

   public class inncls{
     public Dummay__c dum{get;set;}
     public TicketTypes__c tic{get;set;}
     public AttendeeSummary__c att{get;set;}
      public inncls(Dummay__c d,TicketTypes__c t,AttendeeSummary__c a){
       this.tic =t;
       this.att =a;
       this.dum =d;
      }
   
   }



public String escape(String input){
    if(input!= null && input != '' && (input.contains('\\') )){
       input = input.replace('\\','');
       }
       if(input!= null && input != '' && (input.contains('"') )){
       input = input.replace('"','');
       }
       if(input!= null && input != '' && (input.contains('<') )){
       input = input.replace('<','');
       }
       
        if(input  != null && input .contains(',')){
         input =input .replaceAll('"','');
         input ='"'+input +'"';
       } 
      return input;
    }


}
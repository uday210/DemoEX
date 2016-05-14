public without sharing class Copy_EventCon {
  public String selectedToEvent { get; set; }
  public String selectedFromEvent { get; set; }
  public List<SelectOption> fromOptions{get;set;}
  public List<SelectOption> toOptions{get;set;}
  public List<User_Profile_Event__c> Upes{get;set;}
  
  
  
  public Copy_EventCon(){
    firstmethod();
}

 public void firstmethod(){
  Upes = new List<User_Profile_Event__c>();
    fromOptions = new List<SelectOption>();
    toOptions= new List<SelectOption>();
    for(User_Profile_Event__c UPE:[SELECT id,EV_id__r.EV_Title__c,EV_id__c from User_Profile_Event__c where User_id__c=:UserInfo.getUserId()and Profile_id__r.PR_Name__c='EventAdmin']){
    fromOptions.add(new SelectOption(UPE.EV_id__c,UPE.EV_id__r.EV_Title__c));
    toOptions.add(new SelectOption(UPE.EV_id__c,UPE.EV_id__r.EV_Title__c));
    }
 
 }






    public PageReference saveCopyAttendee() {
        List<Event_Attendee_Mapping__c> ForInserting = new List<Event_Attendee_Mapping__c>();
        
        Integer i=0;
        system.debug('1111111111111 '+selectedFromEvent+' @@@@@@@@@@@@@@@@@@@ '+selectedToEvent);
        for(Event_Attendee_Mapping__c  fromEvents :[SELECT id,AS_id__c,EV_id__c from Event_Attendee_Mapping__c where EV_id__c=:selectedFromEvent]){
             Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c();
             EAM.EV_id__c = selectedToEvent ;
             EAM.AS_id__c =fromEvents.AS_id__c;
             EAM.Boothleads_Profile__c ='Attendee';
             EAM.Attendee_Event_IDs__c = fromEvents.AS_id__c + selectedToEvent ;
             ForInserting.add(EAM);
              i++;
              If(i==990){
               Schema.SObjectField f = Event_Attendee_Mapping__c.Fields.Attendee_Event_IDs__c;
                  DataBase.upsert(ForInserting,f,false);
                   ForInserting = new List<Event_Attendee_Mapping__c>();
                   i=0;
              }
                 
            }
        DataBase.insert(ForInserting,false);
        
       Set<Id> insertedAttEmails = new Set<Id>();
       MAP<String,Id> mapEmailId= new MAP<String,Id>();
       
       For(Event_Attendee_Mapping__c  ToEvents :[SELECT id,AS_id__c,AS_id__r.AS_Email__C,EV_id__c from Event_Attendee_Mapping__c where EV_id__c=:selectedToEvent ]){
         mapEmailId.put(ToEvents.AS_id__r.AS_Email__C,ToEvents.AS_id__c);
          
       }
        system.debug('PPPPPPPPPPPPP DDDDDDDDD'+mapEmailId.KeySet());
       For(USER u:[SELECT id,userName from USER where userName IN :mapEmailId.KeySet()]){
         insertedAttEmails.add(u.id); 
          system.debug('PPPPPPPPPPPPP EEEEEEEEEEE '+insertedAttEmails);
       } 
       
              
        Set<Id> Existedupes = new Set<Id>();
          for(User_Profile_Event__c UPES1:[SELECT id,User_id__c from User_Profile_Event__c where User_id__r.userName IN :mapEmailId.keySet() and EV_id__c=:selectedToEvent ]){
             Existedupes.add(UPES1.User_id__c); 
          } 
       system.debug('PPPPPPPPPPPPP @@@@@@@@@@@@@ '+Existedupes);
         insertedAttEmails.RemoveAll(Existedupes);
      system.debug('PPPPPPPPPPPPP '+insertedAttEmails);
       
       Profile__c p = [Select id from Profile__c where PR_Name__c='Attendee'];
       integer j=0;
       
       for(Id userId:insertedAttEmails){
         User_Profile_Event__c up = new User_Profile_Event__c();
         up.EV_id__c = selectedToEvent ;
         up.EventAdmin_Id__c =UserInfo.GetUserId();
         up.UEP_isActive__c =true;
         up.Status__c ='Active';
         up.User_id__c =userId;
         up.Profile_id__c=p.id;
         Upes.add(up); 
         j++;
         if(j==990){
         DataBase.Insert(Upes,false);
          Upes = new List<User_Profile_Event__c>();
          j=0;
         }
         
         
       }
       
        DataBase.Insert(Upes,false);
         firstmethod();
     return null;
    }


  






}
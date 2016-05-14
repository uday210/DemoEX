public class eventChangeCon {

      @future
      public static void checkMail(){
              LIST<User> neetocreateUPE = new LIST<USER>();
            MAP<id,User> neetocreateUPEMAP = new MAP<ID, USER>();
            
            neetocreateUPE = [SELECT id, NAME, CompanyName, isSignup__c, Profile.Name FROM USER WHERE  createdById='005F0000002PNfc' AND  ProfileId='00eF0000000FYkG'  ];
            
             system.debug('        11111111111111111111111            '+neetocreateUPE.size());
            
            MAP<String, String> compName = new MAP<String, String>();
            
            for(User u: neetocreateUPE){
                
                compName.put(u.CompanyName, u.CompanyName);
                neetocreateUPEMAP.put(u.id, u);
            }
            
            LIST<Booth__c> boothName = new LIST<Booth__c>();
            
            
            boothName = [SELECT Id, Name, BT_Name__c FROM Booth__c WHERE EV_id__c='a00F0000008DyZ0'  AND BT_Name__c IN: compName.keySet() ];
            
             system.debug('        11111111111111111111111            '+boothName.size());
            
            MAP<String, id> BoothNameMap = new MAP<String,id>();
            
            for(Booth__c b: boothName){
                BoothNameMap.put(b.BT_Name__c, b.id);
            }
            
           
            
            LIST<User_Profile_Event__c> createdupe = new LIST<User_Profile_Event__c>();
            
            createdupe = [SELECT ID, Name, BT_id__c, BoothAdmin_id__c, EventAdmin_Id__c, EV_id__c, Profile_id__c FROM User_Profile_Event__c WHERE (EventAdmin_Id__c='005F0000002PNfc' AND  BoothAdmin_id__c =: neetocreateUPEMAP.keySet()  AND Profile_id__c ='a0EF000000GNoKn' AND EV_id__c ='a00F0000008DyZ0' ) ];
            
            MAP<id, User_Profile_Event__c> createdUPEMAP = new MAP<id, User_Profile_Event__c>();
            
            for(User_Profile_Event__c up: createdupe ){
                createdUPEMAP.put( up.BoothAdmin_id__c, up);
            }
            
             system.debug('        11111111111111111111111            '+createdupe.size());
             
            
            LIST<User_Profile_Event__c> newUPE = new LIST<User_Profile_Event__c>();
            
            for(user u: neetocreateUPE){
            
                if(createdUPEMAP.containsKey(u.id)){
                
                
                }else{
                    User_Profile_Event__c upe = new User_Profile_Event__c();
                        upe.BoothAdmin_id__c =u.id;
                        upe.EV_id__c='a00F0000008DyZ0';
                        upe.EventAdmin_Id__c='005F0000002PNfc';
                        upe.UEP_isActive__c=true;
                        upe.IsBoothPersonnel__c=true;
                        upe.Profile_id__c='a0EF000000GNoKn';
                        upe.Status__c='Active';
                        upe.User_id__c=u.id;
                        upe.ownerId = '005F0000002PNfc';
                        
                        if(BoothNameMap.containsKey(u.companyName))
                            upe.BT_id__c =  BoothNameMap.get(u.companyName);
                        else{
                            Booth__c booth = new Booth__c();
                            booth.BT_Name__c = u.companyName;
                            
                            insert booth;
                            
                            upe.BT_id__c = booth.id;
                            
                         }
                            
                        
                    newUPE.add(upe);
                
                }
            
            }
            
            system.debug('        11111111111111111111111            '+newUPE.size());
             system.debug('        ZZZZZZZZZZZZZZZZZZZZZZZZZZZ              '+newUPE.size());
    
            Database.insert(newUPE, false);

      }
      
      
        public void  cceventChangeCon(){
            
            checkMail();
            
        }
    
    
       
}
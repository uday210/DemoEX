public with sharing class CreateUPECon {


public CreateUPECon (){

EventId= ApexPages.Currentpage().getParameters().get('id');
EventName= new list<Event__c>();

if(EventId != null || EventId != ''){
EventName=[select id,EV_Title__c,owner.name,ownerid
           from Event__c 
           where id =: EventId
                            ];
                            
}
 
   
ProfileId= new list<Profile__c>();
ProfileId=[select id,PR_Name__c
           from Profile__c
           where PR_Name__c =: 'BoothAdmin'
          ];
                            
system.debug('PPPPPPPPPPPP  '+ProfileId);

DisplayBoothAdmins();         
}

public String EventId{get; set;}
public list<Event__c> EventName{get; set;}
public list<User> SelectedEventUsers{get; set;}
public list<String> UserEmails{get; set;}
public list<Event_Attendee_Mapping__c> SelectedEventBoothAdmins{get; set;}
public list<User_Profile_Event__c> BoothAdminUPEs{get; set;}
public list<String> UPEEmails{get; set;}

public list<Event_Attendee_Mapping__c> NoUPEExistEAMs{get; set;}
public list<User_Profile_Event__c> NoBoothExistEAMs{get; set;}
public list<User_Profile_Event__c> NoProfileExistEAMs{get; set;}
public list<User_Profile_Event__c> NoneExistUPEs{get; set;}

public String EAMId{get; set;}
public String UPEId{get; set;}
public String UPEBoothId{get; set;}
public String UPEProfileId{get; set;}

public list<Profile__c> ProfileId{get; set;}
public list<String> EAMS{get; set;}
public list<String> UPES{get; set;}
public list<String> UPESExist{get; set;}


public pagereference DisplayBoothAdmins(){

SelectedEventUsers= new list<User>();
UserEmails= new list<string>();
SelectedEventBoothAdmins= new list<Event_Attendee_Mapping__c>();   
BoothAdminUPEs= new list<User_Profile_Event__c>();
UPEEmails= new list<string>();
NoUPEExistEAMs= new list<Event_Attendee_Mapping__c>();
NoBoothExistEAMs= new list<User_Profile_Event__c>();   
NoProfileExistEAMs= new list<User_Profile_Event__c>();   
NoneExistUPEs= new list<User_Profile_Event__c>();  
EAMS=new list<String>();
UPES=new list<String>();
UPESExist=new list<String>();

if(Test.isRunningTest())
SelectedEventUsers = [select id,Username 
                      from User
                      where Profile.name =: 'Booth Admin' limit 10];
                      else
SelectedEventUsers = [select id,Username 
                      from User
                      where Profile.name =: 'Booth Admin'];
                      //AND isactive =: true];

system.debug('UUUUUUUUUUUUUUUUU  '+SelectedEventUsers.size());

if(SelectedEventUsers.size() >0){

for(User U:SelectedEventUsers){

UserEmails.add(U.Username);
system.debug('EEEEEEEEEEE  '+U.Username);
}               
system.debug('UUUUUUUUUSSSSSSSSSS   '+UserEmails.size());   

if(UserEmails.size() >0){

SelectedEventBoothAdmins=[select id,AS_id__r.AS_Email__c,EV_id__r.EV_Title__c 
                          from Event_Attendee_Mapping__c
                          where EV_id__c = : EventId
                          AND AS_id__r.AS_Email__c IN : UserEmails
                          AND Boothleads_Profile__c =: 'Booth Admin'];


system.debug('EEVVVVVBBBBBBBBB   '+SelectedEventBoothAdmins.size());                             

if(SelectedEventBoothAdmins.size() >0){
for(Event_Attendee_Mapping__c EAM:SelectedEventBoothAdmins){

EAMS.add(EAM.AS_id__r.AS_Email__c);
}
}
system.debug('EEEEEEEMMMMMMMM  '+EAMS.size());
BoothAdminUPEs=[select id,User_id__r.Username,Attendee_Summary__r.AS_Email__c,BT_id__c, Profile_id__c,
                Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c
                from User_Profile_Event__c
                where Attendee_Summary__r.AS_Email__c IN : EAMS
                AND EV_id__c =: EventId
                ];
                //AND BT_id__c != null
               // AND Profile_id__c =: ProfileId[0].id];   
                
system.debug('BBBBBBBBBBBBB  '+BoothAdminUPEs.size());                             

system.debug('UUUUUUU   '+UserEmails.size());                             

if(BoothAdminUPEs.size() >0){

if(SelectedEventBoothAdmins.size() >0){

for(User_Profile_Event__c UPE:BoothAdminUPEs){

system.debug('PPPPPPPRRRRRRRRRR  '+UPE.Profile_id__c );
if(UPE.BT_id__c == null && (UPE.Profile_id__c != ProfileId[0].id || UPE.Profile_id__c == null)){

NoneExistUPEs.add(UPE);
UPESExist.add(UPE.Attendee_Summary__r.AS_Email__c);
system.debug('PPPPPPPBBBBBBBBBBB   '+UPE.Profile_id__c );

}else if(UPE.BT_id__c == null){

NoBoothExistEAMs.add(UPE);
UPESExist.add(UPE.Attendee_Summary__r.AS_Email__c);

}else if(UPE.Profile_id__c != ProfileId[0].id || UPE.Profile_id__c == null){

NoProfileExistEAMs.add(UPE);
UPESExist.add(UPE.Attendee_Summary__r.AS_Email__c);

}else{

UPES.add(UPE.Attendee_Summary__r.AS_Email__c);
}
}
}

system.debug('UUUUUUPPPPPEEEEEE1111111111111  '+NoneExistUPEs.size());
system.debug('UUUUUUPPPPPEEEEEE22222222222  '+NoBoothExistEAMs.size());
system.debug('UUUUUUPPPPPEEEEEE333333333333  '+NoProfileExistEAMs.size());
system.debug('UUUUUUPPPPPEEEEEE44444444444  '+UPES.size());
system.debug('UUUUUUPPPPPEEEEEE44444444444  '+UPESExist.size());

system.debug('DDDDDDDDDDDDDDD    '+UPES.size()+'  EEEEEEEEEE  '+EAMS.size());
if(UPES.size() >0 && EAMS.size() >0){

NoUPEExistEAMs=[select id,AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c 
                from Event_Attendee_Mapping__c
                where EV_id__c = : EventId
                AND AS_id__r.AS_Email__c NOT IN : UPES
                AND AS_id__r.AS_Email__c NOT IN : UPESExist
                AND AS_id__r.AS_Email__c IN : EAMS];  
                
system.debug('NNNNNNNNNNNNNNNNNN   '+NoUPEExistEAMs.size());
  
  
  
    }   
    }
    
       }   
       }                                     
     return null;                     
}

public User_Profile_Event__c CreateUPE{get; set;}
public Booth__c CreateBooth{get; set;}




public void UPECreation(){

CreateUPE= new User_Profile_Event__c ();
CreateBooth= new Booth__c ();

system.debug('EEEEEAAAAAAMMMMM   '+EAMId);
if(EAMId != null){

list<Event_Attendee_Mapping__c> SelectedEAM=[select id,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,EV_id__c
                                             from Event_Attendee_Mapping__c 
                                             where id =: EAMId];

system.debug('SSSSSSSSSSSSSS  '+SelectedEAM);



if(SelectedEAM.size() >0){

list<Booth__c> BoothForUPE=[select id,BT_Name__c
                            from Booth__c 
                            where BT_Name__c =: SelectedEAM[0].AS_id__r.AS_Company__c];

                                                              
system.debug('BBBBBBOOOOOTTTTTTTTTHHHHHHHHh   '+BoothForUPE);
                                       
list<user> Username=[select id 
                     from User 
                     where Username =: SelectedEAM[0].AS_id__r.AS_Email__c]; 

system.debug('NNNNNNNNBBBBBBBUUUUUU   '+Username);




if(BoothForUPE.size() >0){

CreateUPE.BT_id__c=BoothForUPE[0].id;
CreateUPE.EV_id__c=SelectedEAM[0].EV_id__c;
CreateUPE.User_id__c=Username[0].id;
CreateUPE.BoothAdmin_id__c=Username[0].id;
CreateUPE.UEP_isActive__c=true;
CreateUPE.Status__c='Active';
CreateUPE.IsBoothPersonnel__c=true;
CreateUPE.Profile_id__c=ProfileId[0].id;
CreateUPE.Attendee_Summary__c=SelectedEAM[0].AS_id__c;
CreateUPE.EventAdmin_Id__c=EventName[0].ownerid ;
CreateUPE.OwnerId=EventName[0].ownerid;
Database.insert(CreateUPE);

system.debug('BBBBBBBBOOOOOOTTTTHH 111111111   '+CreateUPE);

}else {

CreateBooth.BT_Name__c=SelectedEAM[0].AS_id__r.AS_Company__c;
CreateBooth.EV_id__c=SelectedEAM[0].EV_id__c;
CreateBooth.BT_BoothUserCount__c=100;
CreateBooth.BT_isBoothActive__c=true;
CreateBooth.OwnerId=EventName[0].ownerid;
system.debug('BBBBBBBBOOOOOOTTTTHH 2222222222222   '+CreateBooth);

Database.insert(CreateBooth);

CreateUPE.BT_id__c=CreateBooth.id;
CreateUPE.EV_id__c=SelectedEAM[0].EV_id__c;
CreateUPE.User_id__c=Username[0].id;
CreateUPE.BoothAdmin_id__c=Username[0].id;
CreateUPE.UEP_isActive__c=true;
CreateUPE.Status__c='Active';
CreateUPE.IsBoothPersonnel__c=true;
CreateUPE.Profile_id__c=ProfileId[0].id;
CreateUPE.Attendee_Summary__c=SelectedEAM[0].AS_id__c;
CreateUPE.EventAdmin_Id__c=EventName[0].ownerid;
CreateUPE.OwnerId=EventName[0].ownerid;

Database.insert(CreateUPE);

system.debug('BBBBBBBBOOOOOOTTTTHH 33333333333   '+CreateUPE);

}

}
DisplayBoothAdmins();     
}     
                             
}




public void BoothProfileCreation(){

CreateBooth= new Booth__c ();

if(UPEId != null){
list<User_Profile_Event__c> NoBoothProfileForUPE=[select id, Attendee_Summary__r.AS_Company__c,EV_id__c
                                                  from User_Profile_Event__c
                                                  where id =: UPEId 
                                                  AND EV_id__c =: EventId
                                                  AND (Profile_id__c != :ProfileId[0].id OR Profile_id__c =: null)
                                                  AND BT_id__c =: null];
                                          
system.debug('NNNNNNNNBBBBBBBPPPPPPPPPPP   '+NoBoothProfileForUPE);

if(NoBoothProfileForUPE.size() >0){

list<Booth__c> BoothForUPE=[select id,BT_Name__c
                            from Booth__c 
                            where BT_Name__c =: NoBoothProfileForUPE[0].Attendee_Summary__r.AS_Company__c];
if(BoothForUPE.size() >0){  

NoBoothProfileForUPE[0].BT_id__c=BoothForUPE[0].id;
NoBoothProfileForUPE[0].Profile_id__c = ProfileId[0].id;
Database.update(NoBoothProfileForUPE[0]);
DisplayBoothAdmins();
}else{

CreateBooth.BT_Name__c=NoBoothProfileForUPE[0].Attendee_Summary__r.AS_Company__c;
CreateBooth.EV_id__c=NoBoothProfileForUPE[0].EV_id__c;
CreateBooth.BT_BoothUserCount__c=100;
CreateBooth.BT_isBoothActive__c=true;
CreateBooth.OwnerId=EventName[0].ownerid;

system.debug('BBBBBBBBOOOOOOTTTTHH 444444444444444  '+CreateBooth);

Database.insert(CreateBooth);

NoBoothProfileForUPE[0].BT_id__c=CreateBooth.id;
NoBoothProfileForUPE[0].Profile_id__c = ProfileId[0].id;

Database.update(NoBoothProfileForUPE[0]);
DisplayBoothAdmins();
}
}


}
}

public void BoothCreation(){

CreateBooth= new Booth__c ();

if(UPEBoothId != null){
list<User_Profile_Event__c> NoBoothForUPE=[select id, Attendee_Summary__r.AS_Company__c,EV_id__c
                                           from User_Profile_Event__c
                                           where id =: UPEBoothId 
                                           AND EV_id__c =: EventId
                                           AND BT_id__c =: null
                                           AND Profile_id__c =: ProfileId[0].id];
                                          
system.debug('NNNNNNNNBBBBBBBUUUUUU   '+NoBoothForUPE);

if(NoBoothForUPE.size() >0){

list<Booth__c> BoothForUPE=[select id,BT_Name__c
                            from Booth__c 
                            where BT_Name__c =: NoBoothForUPE[0].Attendee_Summary__r.AS_Company__c];
if(BoothForUPE.size() >0){  
                      
NoBoothForUPE[0].BT_id__c=BoothForUPE[0].id;

Database.update(NoBoothForUPE[0]);
system.debug('BBBBBBBBOOOOOOTTTTHH 555555555555555  '+NoBoothForUPE);
}else{

CreateBooth.BT_Name__c=NoBoothForUPE[0].Attendee_Summary__r.AS_Company__c;
CreateBooth.EV_id__c=NoBoothForUPE[0].EV_id__c;
CreateBooth.BT_BoothUserCount__c=100;
CreateBooth.BT_isBoothActive__c=true;

system.debug('BBBBBBBBOOOOOOTTTTHH 444444444444444  '+CreateBooth);

Database.insert(CreateBooth);

NoBoothForUPE[0].BT_id__c=CreateBooth.id;

Database.update(NoBoothForUPE[0]);
system.debug('BBBBBBBBOOOOOOTTTTHH 6666666666666  '+NoBoothForUPE);

}

}
DisplayBoothAdmins();

}
}

public void ProfileCreation(){

if(UPEProfileId != null){

list<User_Profile_Event__c> NoProfileForUPE=[select id, Attendee_Summary__r.AS_Company__c,EV_id__c
                                             from User_Profile_Event__c
                                             where id =: UPEProfileId 
                                             AND EV_id__c =: EventId
                                             AND BT_id__c != null
                                             AND (Profile_id__c != :ProfileId[0].id OR Profile_id__c =: null)
                                             ];
                                          
system.debug('PPPPPPPPPPPPPPPPPP   '+NoProfileForUPE);

if(NoProfileForUPE.size()>0){

NoProfileForUPE[0].Profile_id__c = ProfileId[0].id;
Database.update(NoProfileForUPE[0]);
system.debug('BBBBBBBBOOOOOOTTTTHH 777777777777777777  '+NoProfileForUPE[0]);

DisplayBoothAdmins();
}

}
}


}
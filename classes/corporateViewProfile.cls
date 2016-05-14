public with sharing class corporateViewProfile {

public string selectedEvent {get ; set ;}
//Constructor
public corporateViewProfile(){

    Cookie k = ApexPages.currentPage().getCookies().get('counter');
    selectedEvent= k.getValue();
    viewProfile();

}


public User_Profile_Event__c upeforTable {get;set;}
public List<Profile_Settings__c> Psettings {get ; set ;}
public AttendeeSummary__c vewProfileEAM {get ; set ;}
public list<Attachment> attchments  {get ; set ;}
public List<Widget__c> videos {get ; set ;}
    public PageReference viewProfile() {
    Psettings = new List<Profile_Settings__c> ();
    Psettings = [SELECT id,DBA__c,Website__c,exceptional_keywords__c,Salutation__c,Company_Logo__c,Contact_Image__c,BBB_Number__c,Additional_Company_videos__c,Additional_Company_Brouchers__c,Location__c,Country__c,Primary_Business_Category__c,Secondary_Business_Category__c,Distributors_Country__c,Manufatures_Country__c,Commodities__c,Geographical_Region__c,Certificate_Processed_by_RPO__c,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,Work_Address__c,Work_phone__c FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'Corporate' ];
    system.debug('pppppppppppppppppppppppppppppppppppppppppppppppppppppp'+Psettings[0]);
    upeforTable  =new User_Profile_Event__c();
    string viewEmail = userinfo.getUsername(); 
    vewProfileEAM = new AttendeeSummary__c ();
    GlobalAttendee Gatt = new GlobalAttendee ();
    vewProfileEAM=Gatt.ReturnAttendee(viewEmail);
    Commanforstates  gts = new Commanforstates ();     
    attchments = new list<Attachment>();
    videos = new List<Widget__c>();
    attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:vewProfileEAM.Id];
    videos = [Select id,YouTubeId_c__c From Widget__c Where AttendeeSummary__r.id =: vewProfileEAM.Id];
        system.debug('=========== ppppppppp ' + attchments );
        if(vewProfileEAM.AS_Work_States__c!=null){
            vewProfileEAM.AS_Work_States__c =gts.mapstate(vewProfileEAM.AS_Work_States__c);
         }
    return null;
    }



















}
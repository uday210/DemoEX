@istest(SeeAllData= true)
public class Test_BLN_RoomsCon{
    static testmethod void Testmethod_BLN_RoomsCon(){
    
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        system.runas(U){
        
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);    
            
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_RoomsCon roomData= new BLN_RoomsCon();
            roomData.addEditRoom.Name= 'Sample Room';
            roomData.addEditRoom.Room_Number__c= '1234';
            roomData.saveTrack();
            roomData.cancelTrack();
            ApexPages.CurrentPage().getParameters().put('editedRoomId',roomInfo.Id);
            roomData.editRoom();
            ApexPages.CurrentPage().getParameters().put('removedRoomId',roomInfo.Id);
            roomData.removeRoom();
            
            
            
        }
  
    }
}
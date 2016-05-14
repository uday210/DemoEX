public with sharing class Commanforstates {
public map<string,string> states{get;set;}


public Commanforstates (){
   try{
     mapstate('');
     }catch(Exception e){}
  }
    public string s{get;set;}
    public string mapstate(string sta){
        system.debug(' STATE SELECTED '+sta);
        //map<string,string> 
        states=new map<string,string>();
        states.put('None','None');
        states.put('Alabama','AL');
        states.put('Alaska', 'AK');
        states.put('Arizona','AZ');
        states.put('Arkansas','AR');
        states.put('California','CA');
        states.put('Colorado','CO');
        states.put('Connecticut','CT');
        states.put('Delaware','DE');
        states.put('District of Columbia','DC');
        states.put('Florida','FL');
        states.put('Georgia','GA');
        states.put('Hawaii','HI');
        states.put('Idaho','ID');
        states.put('Illinois','IL');
        states.put('Indiana','IN');
        states.put('Iowa','IA');
        states.put('Kansas','KS');
        states.put('Kentucky','KY');
        states.put('Louisiana','LA');
        states.put('Maine','ME');
        states.put('Maryland','MD');
        states.put('Massachusetts','MA');
        states.put('Michigan','MI');
        states.put('Minnesota','MN');
        states.put('Mississippi','MS');
        states.put('Missouri','MO');
        states.put('Montana','MT');
        states.put('Nebraska','NE');
        states.put('Nevada','NV');
        states.put('New Hampshire','NH');
        states.put('New Jersey','NJ');
        states.put('New Mexico','NM');
        states.put('New York','NY');
        states.put('North Carolina','NC');
        states.put('North Dakota','ND');
        states.put('Ohio','OH');
        states.put('Oklahoma','OK');
        states.put('Oregon','OR');
        states.put('Pennsylvania','PA');
        states.put('Rhode Island','RI');
        states.put('South Carolina','SC');
        states.put('South Dakota','SD');
        states.put('Tennessee','TN');
        states.put('Texas','TX');
        states.put('Utah','UT');
        states.put('Vermont','VT');
        states.put('Virginia','VA');
        states.put('Washington','WA');
        states.put('West Virginia','WV');
        states.put('Wisconsin','WI');
        states.put('Wyoming','WY');
        //states.put('Andhra Pradesh','AP');
        //states.put('Arunachal Pradesh','AR');
        //states.put('Assam','AS');
        //states.put('Bihar','BR');
        //states.put('Chhattisgarh','CG');
        //states.put('Goa','GA');
       // states.put('Gujarat','GJ');
        //states.put('Haryana','HR');
       // states.put('Himachal Pradesh','HP');
       // states.put('Jammu and Kashmir','JK');
        //states.put('Jharkhand','JH');
        //states.put('Karnataka','KA');
        //states.put('Kerala','KL');
        //states.put('Madhya Pradesh','MP');
        //states.put('Maharashtra','MH');
        //states.put('Manipur','MN');
        //states.put('Meghalaya','ML');
        //states.put('Mizoram','MZ');
        //states.put('Nagaland','NL');
       // states.put('Orissa','OR');
       /* states.put('Punjab','PB');
        states.put('Rajasthan','RJ');
        states.put('Sikkim','RJ');
        states.put('Tamil Nadu','TN');
        states.put('Telangana','TG');
        states.put('Tripura','TR');
        states.put('Uttarakhand','UA');
        states.put('Uttar Pradesh','UP');
        states.put('West Bengal','WB');
        states.put('Andaman and Nicobar Islands','AN');
        states.put('Daman and Diu','DD');
        states.put('Lakshadweep','LD');                                      
        states.put('National Capital Territory of Delhi','DL');    
        states.put('American Samoa','AS'); */   
       
        //states.put('India','IN');
        states.put('United States Of America','USA');
         
        system.debug('111111111111111111 '+states);
        s='';
        system.debug(' :::::::::STATE GET :::::::::::::: '+states.get(sta));
        s=states.get(sta);
        system.debug(' :::::::::::::::::::::::::::: '+s);
        return s;
  }
  
  
   public string longToShortConversion(string sta){
        system.debug(' STATE SELECTED '+sta);
        map<string,string> states=new map<string,string>();
        states.put('None','None');
        /*states.put('AP','Andhra Pradesh');
        states.put('AR','Arunachal Pradesh');
        states.put('AS','Assam');
        states.put('BR','Bihar');
        states.put('CG','Chhattisgarh');
        states.put('GA','Goa');
        states.put('GJ','Gujarat');
        states.put('HR','Haryana');
        states.put('HP','Himachal Pradesh');
        states.put('JK','Jammu and Kashmir');
        states.put('JH','Jharkhand');
        states.put('KA','Karnataka');
        states.put('KL','Kerala');
        states.put('MP','Madhya Pradesh');
        states.put('MH','Maharashtra');
        states.put('MN','Manipur');
        states.put('ML','Meghalaya');
        states.put('MZ','Mizoram');
        states.put('NL','Nagaland');
        states.put('OR','Orissa');
        states.put('PB','Punjab');
        states.put('RJ','Rajasthan');
        states.put('RJ','Sikkim');
        states.put('TN','Tamil Nadu');
        states.put('TG','Telangana');
        states.put('TR','Tripura');
        states.put('UA','Uttarakhand');
        states.put('UP','Uttar Pradesh');
        states.put('WB','West Bengal');
        states.put('AN','Andaman and Nicobar Islands');
        states.put('DD','Daman and Diu');
        states.put('LD','Lakshadweep');                                      
        states.put('DL','National Capital Territory of Delhi');  */  
       
        
        states.put('AL','Alabama');
        states.put('AK', 'Alaska');
        states.put('AZ','Arizona');
        states.put('AR','Arkansas');
        states.put('CA','California');
        states.put('CO','Colorado');
        states.put('CT','Connecticut');
        states.put('DE','Delaware');
        states.put('DC','District of Columbia');
        states.put('FL','Florida');
        states.put('GA','Georgia');
        states.put('HI','Hawaii');
        states.put('ID','Idaho');
        states.put('IL','Illinois');
        states.put('IN','Indiana');
        states.put('IA','Iowa');
        states.put('KS','Kansas');
        states.put('KY','Kentucky');
        states.put('LA','Louisiana');
        states.put('ME','Maine');
        states.put('MD','Maryland');
        states.put('MA','Massachusetts');
        states.put('MI','Michigan');
        states.put('MN','Minnesota');
        states.put('MS','Mississippi');
        states.put('MO','Missouri');
        states.put('MT','Montana');
        states.put('NE','Nebraska');
        states.put('NV','Nevada');
        states.put('NH','New Hampshire');
        states.put('NJ','New Jersey');
        states.put('NM','New Mexico');
        states.put('NY','New York');
        states.put('NC','North Carolina');
        states.put('ND','North Dakota');
        states.put('OH','Ohio');
        states.put('OK','Oklahoma');
        states.put('OR','Oregon');
        states.put('PA','Pennsylvania');
        states.put('RI','Rhode Island');
        states.put('SC','South Carolina');
        states.put('SD','South Dakota');
        states.put('TN','Tennessee');
        states.put('TX','Texas');
        states.put('UT','Utah');
        states.put('VT','Vermont');
        states.put('VA','Virginia');
        states.put('WA','Washington');
        states.put('WV','West Virginia');
        states.put('WI','Wisconsin');
        states.put('WY','Wyoming');
         states.put('AS','American Samoa');    
       
        //states.put('IN','India');
        states.put('USA','United States Of America');
         
        system.debug('111111111111111111 '+states);
        s='';
        system.debug(' :::::::::STATE GET :::::::::::::: '+states.get(sta));
        s=states.get(sta);
        system.debug(' :::::::::::::::::::::::::::: '+s);
        return s;
  }

}
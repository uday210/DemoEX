public without sharing class User_TimeZoneCon{
public string timezoneuser{ get; set; }

    public String getTimeZoneValue() {
       user u = new user();
       try{ 
        u = [select id,userName,TimeZoneSidKey from user Where id=:timezoneuser];
       }catch(exception er){} 
       system.debug('PPPPPPPPPPPPp '+u.TimeZoneSidKey);
        return u.TimeZoneSidKey ;
    }


}
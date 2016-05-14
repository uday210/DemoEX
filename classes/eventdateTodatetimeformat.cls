public class eventdateTodatetimeformat{
// This Class will make datetime from date and time
//By Phani

   public DAteTime getConvertDateTime(date d,string strT){
    
        String[] strDTDivided = strT.split(' '); 
        string hour = strDTDivided.get(0).split(':').get(0);
        string minute = strDTDivided.get(0).split(':').get(1);
        string second = '00';
        system.debug(strDTDivided.get(1));
        
        if (strDTDivided.get(1) == 'PM'){
           hour = String.ValueOf(Integer.ValueOf(hour) + 12);
        }
       
       string month = string.valueOf(d.month());
       string day =string.valueOf(d.day());
       string year = string.valueOf(d.year());

        string stringDate = year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
        return datetime.valueOf(stringDate);
  
   }
}
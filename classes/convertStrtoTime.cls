public class convertStrtoTime{
public convertStrtoTime(){

}

public Time getConvertTime(string strDT){
  string[] strDTDivided = new string[]{};
  strDTDivided = strDT.split(' ');
  string hour = strDTDivided.get(0).split(':').get(0);
  string minute = strDTDivided.get(0).split(':').get(1);
  string second = '00';
 
   if (strDTDivided.get(1) == 'PM'){
       hour = String.ValueOf(Integer.ValueOf(hour) + 12);
    }
 
 return null;
}


}
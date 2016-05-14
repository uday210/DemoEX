public without sharing class globalTimeConvertion{


public string timeTostring(Time t){
 string ss1='';
 string  ss=String.valueOf(t).substringBeforeLast(':');
 string[] arr = ss.split(':');

 if(integer.valueOf(arr[0])>=12){
integer middle;
 middle = integer.valueOf(arr[0])-12;
  system.debug('qqqqqqqqqqqqqqqq '+middle);
   if(middle<=9){
   if(middle==0){
    string s ='12';
    ss1=s+':'+arr[1]+' PM';
   }else{
   string s ='0'+string.valueOf(middle);
    ss1=s+':'+arr[1]+' PM';
    }
  }else{
   string s =string.valueOf(middle);
   ss1=s+':'+arr[1]+' PM';
  }
  
 }else{
  integer middle = integer.valueOf(arr[0]);
  if(middle<=9){
   string s ='0'+string.valueOf(middle);
   ss1=s+':'+arr[1]+' AM';
  } else{
      string s =string.valueOf(middle);
      ss1=s+':'+arr[1]+' AM';
      
   
     
  }
  
 
 }

return ss1;

}

public time stringTotime(string s){

     List<string> Endhour = s.split(':');
        integer Endhh=integer.valueOf(Endhour[0]);
         
        List<string> ENDmints = Endhour [1].split(' ');
       integer EndMM=integer.valueOf(ENDmints [0]);
        if(ENDmints [1] == 'PM'){
        if(Endhh!=12){
          Endhh= Endhh+12;
        }
        }
       Time mmEndTime = Time.newInstance(Endhh, EndMM, 00, 00);
     return mmEndTime ;
}




}
public class BLN_GoScheduleCon {

    public String apieventname { get; set; }

   
    public String opt { get; set; }

    public String no { get; set; }

    
    public PageReference UnSchedule() {
    String tempname=apieventname+'Job%';
        CronTrigger job = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType,State FROM CronTrigger where CronJobDetail.Name like:tempname ORDER BY CreatedDate DESC LIMIT 1];
    system.abortJob(job.id);
   return null;
    }


    public String lsttime { get; set; }

    public PageReference GoSchedule() {
    
    BLN_Item__c bi=[select id,name,Event__c,Event__r.name,item_name__c from BLN_Item__c where Event__r.name=:eventName and item_name__c=:itemName limit 1 ];
   List<Reg_Setting__c> regsettings=[select id,name,Setting_Type__c,Defaullt_Label__c,Event__c,Item__c,Included__c,Order__c,Group_Order__c from Reg_Setting__c where Event__c=:bi.event__c and Setting_Type__c='Regular' and Defaullt_Label__c='Work Address' and Item__c=:bi.id limit 1];
    if(regsettings.size()>0)
     {
        regsettings[0].Included__c=true;
        update regsettings;
     }
     else
     {
        Reg_Setting__c newreg=new Reg_Setting__c();
        newreg.Event__c=bi.event__c;
        newreg.Item__c=bi.id ;
        newreg.Setting_Type__c='Regular';
        newreg.Defaullt_Label__c='Work Address';
        newreg.Order__c=1;
        newreg.Group_Order__c=2;
        newreg.Table_Name__c='Company_Ext__c';
        newreg.Column_Name__c='Work Address';
        newreg.Label_Name__c='Work Address';
        newreg.Update_Access__c=true;
        newreg.Included__c=true;
        newreg.Group_Name__c='Address Information';
        insert newreg;
     } 
       
     scheduledEBMT m = new scheduledEBMT(apieventname,bi.id,bi.Event__c,no,opt);
     //schedule jon at start after 1min
     Integer intYear = system.now().year();
Integer intMon = system.now ().month ();
Integer intDate = system.now ().day ();
Integer intHr = system.now ().hour ();
Integer intMin = system.now ().minute ()+1;
Integer intSec = system.now ().second ();
if (intSec > 59){
intMin=intMin+1;
IntSec=intSec-60;
}
if (intMin > 59){
IntHr=intHr+1;
IntMin=intMin-60;
}
if (intHr > 23){
IntDate = intDate + 1;
intHr = intHr - 24;
}
if(intMon == 2 && intDate > 28){
intMon = intMon + 1;
intDate = intDate - 28;
}else if( (intMon == 4 || intMon == 6 || intMon == 9 || intMon == 11 ) && ( intDate > 30 ) ){
intMon = intMon + 1;
intDate = intDate - 30;
} else if (intDate > 31) {
intMon = intMon + 1;
intDate = intDate - 31;
}
if(intMon>12){
intYear=intYear+1;
intMon=intMon-12;
}
String Stryear = string.valueOf(intYear);
String Strmonth = string.valueOf(intMon);
String Strday = string.valueOf(intDate);
String Strhour = string.valueOf(intHr);
String Strminute = string.valueOf(intMin);
String Strsecond = string.valueOf(intSec);
String strJobName = apieventname+'Job-' + Strsecond + '_' + Strminute + '_' + Strhour + '_' + Strday + '_' + Strmonth + '_' + Stryear;
String strSchedule = '0 ' + Strminute + ' ' + Strhour + ' ' + Strday + ' ' + Strmonth + ' ?' + ' ' + Stryear;
     //
      

       bln_event__c bec=[select id,name,last_refreshed_time__c from bln_event__c where id=:bi.Event__c];
   bec.last_refreshed_time__c=lsttime;
   update bec; 

        system.schedule(strJobName , strSchedule, m);
     
     

   return null;
    }


    public String itemName { get; set; }

    public String eventName { get; set; }
    
    
    /*  stringToCodePoint
 *  converts all strings to code point values (UTF8)
 *  which could be converted back to string values later
 */ 
public static List<Integer> stringToCodePoint(String strInput) {
    System.debug('===> '+strInput);
              LIST<Integer> charLIST = new List<Integer>();
             
              if (strInput == null || strInput == '') return charLIST;
             
              string strHex = EncodingUtil.convertToHex(Blob.valueOf(strInput));
    System.debug('ddddd '+strHex);          
    if (strHex == null || strHex == '') return charLIST;
 
              // Build map to convert hex to decimal         
              Map<String,Integer> hexMAP = new Map<String,Integer>();
for (integer nLoop = 0; nLoop < 16; nLoop++)         
      hexMAP.put('0123456789abcdef'.subString(nLoop, nLoop+1), nLoop);
 
              Integer increment = 2;
              for(Integer i = 0; i < strHex.length(); i += increment) {
                     Integer out = 0;
                    
                     Integer c1 = (hexMAP.get(strHex.subString(i,i + 1)) * 16) + (hexMAP.get(strHex.subString(i + 1,i + 2)));
                     Integer c2 = 0;                  
                     Integer c3 = 0;
                     Integer c4 = 0;
                     if(c1 <128) {
                           out = c1;
                           increment = 2;
                     }
                     else
                     {
                           if(c1 > 193 && c1 < 224) {
                                  // first of 2
                                  increment = 4;                          
                           }
                           if(c1 > 223 && c1 < 240) {
                                  // first of 3
                                  increment = 6;
                           }
                           if(c1 > 239 && c1 < 245) {
                                  // first of 4
                                  increment = 8;
                           }
 
                           c2 = (hexMAP.get(strHex.subString(i + 2,i + 3)) * 16) + (hexMAP.get(strHex.subString(i + 3,i + 4)));                                     
                           if(increment == 4) {
                                  out = (c1 - 192) * 64 + c2 - 128;
                           }
                           else if(increment == 6) {
                                  c3 = (hexMAP.get(strHex.subString(i + 4,i + 5)) * 16) + (hexMAP.get(strHex.subString(i + 5,i + 6)));
                                  out = (c1-224)*4096 + (c2-128)*64 + c3 - 128;
                           }
                           else if(increment == 8) {
                                  c4 = (hexMAP.get(strHex.subString(i + 6,i + 7)) * 16) + (hexMAP.get(strHex.subString(i + 7,i + 8)));
                                  out = (c1 - 240) * 262144 + (c2 - 128) * 4096 + (c3 - 128) * 64 + c4 - 128;
                           }
                     }
                    
                     if ((out != 0) && IsLegalXmlChar(out) && IsLegalWindows1252(out))
                           charLIST.add(out);
              }            
              return charList;
}


@testvisible  private static boolean IsLegalXmlChar(integer character)
    {
        return
            (
                character == 9 /* == '\t' == 9   */        ||
                character == 10 /* == '\n' == 10  */        ||
                character == 13 /* == '\r' == 13  */        ||
                (character >= 32 && character <= 55295) ||
                (character >= 57344 && character <= 65533) ||
                (character >= 65536 && character <= 1114111)
            );
    }
       
 
    // from http://msdn.microsoft.com/en-us/goglobal/cc305145.aspx
@testvisible private static boolean IsLegalWindows1252(integer character)
    {
        return
            (
                character == 9 /* == '\t' == 9   */                       ||
                character == 10 /* == '\n' == 10  */                       ||
                character == 13 /* == '\r' == 13  */                       ||
                (character >= 32 && character <= 255) ||
                /* 0x01-- */
                character == 338 /* LATIN CAPITAL LIGATURE OE */         ||
                character == 339 /* LATIN SMALL LIGATURE OE */           ||
                character == 352 /* LATIN CAPITAL LETTER S WITH CARON */ ||
                character == 353 /* LATIN SMALL LETTER S WITH CARON */   ||
                character == 376 /* LATIN CAPITAL LETTER Y WITH DIAERESIS */ ||
                character == 381 /* LATIN CAPITAL LETTER Z WITH CARON */ ||
                character == 382 /* LATIN SMALL LETTER Z WITH CARON */   ||
                character == 402 /* LATIN SMALL LETTER F WITH HOOK */    ||
                /* 0x02-- */
                character == 710 /* MODIFIER LETTER CIRCUMFLEX ACCENT */ ||
                character == 732 /* SMALL TILDE */                       ||
                /* 0x2--- */
                character == 8211 /* EN DASH */                           ||
                character == 8212 /* EM DASH */                           ||
                character == 8216 /* LEFT SINGLE QUOTATION MARK */        ||
                character == 8217 /* RIGHT SINGLE QUOTATION MARK */       ||
                character == 8218 /* SINGLE LOW-9 QUOTATION MARK */       ||
                character == 8220 /* LEFT DOUBLE QUOTATION MARK */        ||
                character == 8221 /* RIGHT DOUBLE QUOTATION MARK */       ||
                character == 8222 /* DOUBLE LOW-9 QUOTATION MARK */       ||
                character == 8224 /* DAGGER */                            ||
                character == 8225 /* DOUBLE DAGGER */                     ||
                character == 8226 /* BULLET */                            ||
                character == 8230 /* HORIZONTAL ELLIPSIS */               ||
                character == 8240 /* PER MILLE SIGN */                    ||
                character == 8249 /* SINGLE LEFT-POINTING ANGLE QUOTATION MARK */     ||
                character == 8250 /* SINGLE RIGHT-POINTING ANGLE QUOTATION MARK */    ||
                character == 8364 /* EURO SIGN */                         ||
                character == 8482 /* TRADE MARK SIGN */
            );
    }
}
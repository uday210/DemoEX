public with sharing class BLN_TestServiceBCOMAPICon {

    public String Token { get; set; }
   public String s{get;set;}
    public PageReference callService() {
    Http CToken = new Http();
            //Encrypt password using XOR
string pwd1='jRhX:6x$Wz*V&X';

            Blob beforeblob = Blob.valueOf(pwd1);
    
    // base64 encode the blob that contains our url param value
    string paramvalue = EncodingUtil.base64Encode(beforeblob);
List<Integer> pwd= stringToCodePoint(paramvalue);
 String preSharedkey1='1a3FJpDlZt6R87Uj2q78';

 List<Integer> preSharedkey= stringToCodePoint(preSharedkey1);
 
 if(preSharedkey.size() < pwd.size())
 preSharedkey.addAll(preSharedkey);
 s=String.valueOf(preSharedkey.size());
for (integer i = 0; i < pwd.size(); i++)
{
pwd[i]=pwd[i]^preSharedkey[i];
}
 

 
 
 String p=String.fromCharArray(pwd);
 String encodedString = EncodingUtil.urlEncode(p,'UTF-8');
         HttpRequest reqCToken = new HttpRequest();
         
            reqCToken.setEndpoint('https://b-comapi1.mci-group.com/API/Authenticate?ApplicationId=BOOTHLEADS&UserName=boothleads-apiuser1&Password='+encodedString+'&EventCodeList=EBMT2016');
            //String TBodyParameters = 'card[number]='+vCls.CreditCardNumber+'&card[exp_month]='+vCls.SelectedMonth+'&card[exp_year]='+vCls.Selectedyear+'&card[cvc]='+vCls.CVVNumber;
            reqCToken.setHeader('Content-Type', 'text/json');
            //reqCToken.setBody(TBodyParameters);
           reqCToken.setMethod('GET');
            HttpResponse resCToken;
           resCToken = CToken.send(reqCToken);
           
            
       String tokinfo1=(String)JSON.deserialize(resCToken.getBody(), String.class);
            
     Token=tokinfo1;
     String t=System.now()+'';
     //get participants
     HttpRequest reqCToken1 = new HttpRequest();
            reqCToken1.setEndpoint('https://b-comapi1.mci-group.com/API/GetParticipantList?AuthenticationToken='+Token+'&EventCode=EBMT2016&LastModificationUTCDate=2016-03-24T17:20:00');
            //+t.replace(' ','T'));
            //String TBodyParameters = 'card[number]='+vCls.CreditCardNumber+'&card[exp_month]='+vCls.SelectedMonth+'&card[exp_year]='+vCls.Selectedyear+'&card[cvc]='+vCls.CVVNumber;
            reqCToken1.setHeader('Content-Type', 'text/json');
            //reqCToken.setBody(TBodyParameters);
            reqCToken1.setMethod('GET');
            
            HttpResponse resCToken1;
            try{
            resCToken1 = CToken.send(reqCToken1);
            }catch(Exception e){callService();}
            plist=new List<Participant>();
           //plist=(List<Participant>)JSON.deserialize(resCToken1.getBody(), Participant.class);
           JSONParser parser = JSON.createParser(resCToken1.getBody());
           
    while(parser.nextToken() != null){
        if(parser.getCurrentToken() == JSONToken.START_OBJECT){
            //read GoogleEventAttendee object
Participant p1 = (Participant) parser.readValueAs(Participant.class); 
plist.add(p1);
           
        }
        else if(parser.getCurrentToken() == JSONToken.END_ARRAY){
            break;  
        }
    }

           
        return null;
    }
   
  public transient List<Participant> plist{get;set;}
  class Participant
  {
   public String Identifier{get;set;}
   public String FirstName{get;set;}
   public String LastName{get;set;}
   public String Email{get;set;}
   public String StatusCode{get;set;}
   public String Title{get;set;}
   public String CompanyName{get;set;}
   public String Street{get;set;}
   public String ZipCode{get;set;}
   public String City{get;set;}
   public String State{get;set;}
   public String Country{get;set;}
   public String LastModificationDate{get;set;}
  }
/*  stringToCodePoint
 *  converts all strings to code point values (UTF8)
 *  which could be converted back to string values later
 */ 
public static List<Integer> stringToCodePoint(String strInput) {
    
              LIST<Integer> charLIST = new List<Integer>();
             
              if (strInput == null || strInput == '') return charLIST;
             
              string strHex = EncodingUtil.convertToHex(Blob.valueOf(strInput));
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


 private static boolean IsLegalXmlChar(integer character)
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
    private static boolean IsLegalWindows1252(integer character)
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
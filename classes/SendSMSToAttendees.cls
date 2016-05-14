global class SendSMSToAttendees {
	
	public Static Map<String,String> properties{get; set;}
	
	 public static String twiliotestcls(String toPhone, String messageTo){
	   	  String status ='';
		   try{    
		  properties = new Map<String,String>();
		  
          properties.put('To','+1'+toPhone);
          properties.put( 'From' ,'+17324106468');
          properties.put('Body', 'Tap here to download the boothleads apps - http://m.boothleads.com');
          
            
       String ACCOUNT_SID = 'ACf08e03bf42249cc8f172366d968ea9ec';
        String AUTH_TOKEN = '3db2b34c510ed8fdbb71b9ee75f14a9c';
        TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
        
 
      
        TwilioSMS message = client.getAccount().getSmsMessages().create(properties);
        status = 'SMS Sent succuessfully to ' + toPhone ;
       }catch(Exception e){

       status = 'SMS not sent';
       system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'+  e.getMessage());
        system.debug('111111111111111111111       '+  e.getTypeName());
       }
	   
	   return status;
	}
	 
}
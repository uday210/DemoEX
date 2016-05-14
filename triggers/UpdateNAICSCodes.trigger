trigger UpdateNAICSCodes on AttendeeSummary__c (before insert) {

	/*
	MAP<String, String> newNAICSCode = new MAP<String, String>();
	
	Schema.DescribeFieldResult F = AttendeeSummary__c.As_NAICSCode_1__c.getDescribe();
	List<Schema.PicklistEntry> P = F.getPicklistValues();

	for(Schema.PicklistEntry sc: p){
			String onlyNAICSNumber = sc.getValue().subString(sc.getValue().)
		newNAICSCode.put(sc.getValue() )
	}

*/
 	for(AttendeeSummary__c att : trigger.New){
 		try{
 			if(att.AS_NAICSCode1__c != null && att.As_NAICSCode_1__c == null){
 				att.As_NAICSCode_1__c = String.valueOf(att.AS_NAICSCode1__c);
 			}
 		}catch(Exception e){}
 		try{	
 			if(att.AS_NAICSCode2__c != null && att.As_NAICSCode_2__c == null){
 				att.As_NAICSCode_2__c = String.valueOf(att.AS_NAICSCode2__c);
 			}
 		}catch(Exception e){}
 		try{	
 			if(att.AS_NAICSCode3__c != null && att.As_NAICSCode_3__c == null){
 				att.As_NAICSCode_3__c = String.valueOf(att.AS_NAICSCode3__c);
 			}
 		}catch(Exception e){}
 		try{	
 			if(att.AS_NAICSCode4__c != null && att.As_NAICSCode_4__c == null){
 				att.As_NAICSCode_4__c = String.valueOf(att.AS_NAICSCode4__c);
 			}
 		}catch(Exception e){}
 		try{	
 			if(att.AS_NAICSCode5__c != null && att.As_NAICSCode_5__c == null){
 				att.As_NAICSCode_5__c = String.valueOf(att.AS_NAICSCode5__c);
 			}
 		}catch(Exception e){}
 		 	
 	}



}
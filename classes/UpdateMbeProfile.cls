@RestResource(urlMapping='/UpdateMbeProfile/*')
/* AUTHOR : Phani
 * Email :  phani@globalnest.com
 * AIM :    To update the User information from the mobile  clients
 */  
  global without Sharing class UpdateMbeProfile{
    @HttpPost
      global static SaveUserProfile3.UserInfo  doPost(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String userName= req.params.get('UserEmail');
        String eveid= req.params.get('Eveid');
        
                Blob reqbody =req.requestBody;
                String UserProfile= reqbody.toString();
                SaveUserProfile3.UserInfo UserInfoDetails = new SaveUserProfile3.UserInfo();
                   
                    JSONParser Parser = JSON.createParser(UserProfile);
                         While(parser.nextToken()!= null){
                           if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
                              while(parser.nextToken() != null){
                               if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
                                UserInfoDetails  = (SaveUserProfile3.UserInfo)parser.readValueAs(SaveUserProfile3.UserInfo.class);}     
                                system.debug('1111111111111 '+UserInfoDetails  );
                       }
                     }
                 }
               System.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFF '+UserInfoDetails.Title);
                 FetchEventdetails evedetails= new FetchEventdetails();
                 if(eveid!=null && eveid!=''){  
                     if(null !=evedetails.evedetails(eveid)){
                        if(evedetails.evedetails(eveid).Is_Webank_event__c ){
                           
                        
                        } else{
                            SaveUserProfile3.UserInfo  Uin = new SaveUserProfile3.UserInfo();
                            Uin.Message ='Updated Successfully';
                            return Uin ;
                        }                   
                     }
                 
                 }
              SaveUserProfile3.UserInfo  successMessage = new SaveUserProfile3.UserInfo();
                  for(Event_Attendee_Mapping__c eam : [select id,MBE_Profile__c from Event_Attendee_Mapping__c where  AS_Id__r.As_Email__c=:UserName and EV_id__c=:eveid]){
                    if(eam.MBE_Profile__c !=null ){
                        MBE_Profile__c mbeprofiles = new MBE_Profile__c();  
                        try{
                           mbeprofiles = [Select  AttendeeSummary__c,a.Ethnicity__c,a.AS_Secondary_Email__c,  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                                  a.AS_WorkZipCode__c,a.AS_WorkPhone__c, 
                                  a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Key_Words__c,
                                  a.AS_WebsiteUrl__c, a.AS_Title__c, 
                                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                                  a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                                  a.AS_HomePhone__c,a.AS_HomeCity__c,
                                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                                  a.References__c,a.Revenue_Range__c,a.distribution_Country__c,a.Manufactures_Country__c,a.DBA__c,a.BBB_Number__c,a.Commodity_1__c,a.Commodity_2__c,a.Commodity_3__c,a.Commodity_4__c,a.Commodity_5__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,
                                  a.AS_NAICSCode6__c,a.AS_NAICSCode7__c,a.AS_NAICSCode8__c,a.AS_NAICSCode9__c,
                                  AS_BusinessDunsNumber__c,AS_BusinessTaxId__c,Business_Structure__c,Company_Certifications__c,Year_in_business__c,FaxNumber__c,(SELECT Id, Name,Description,ContentType FROM Attachments) from MBE_Profile__c a Where id=:eam.MBE_Profile__c];
                        
                                 if(!(String.isEmpty(UserInfoDetails.firstName))){
                                     mbeprofiles.AS_FirstName__c =UserInfoDetails.firstName;
                                  }
                                 if(!(String.isEmpty(UserInfoDetails.LastName))){
                                     mbeprofiles.AS_LastName__c=UserInfoDetails.LastName;
                                  }
                                  
                                  if(!(String.isEmpty(UserInfoDetails.Company))){
                                     mbeprofiles.AS_Company__c=UserInfoDetails.Company;
                                  }
                                  if(!(String.isEmpty(UserInfoDetails.City))){
                                     mbeprofiles.AS_WorkCity__c=UserInfoDetails.City;
                                  }
                                  
                                  
                                    
                                     if(!(String.isEmpty(UserInfoDetails.Title))){
                                        mbeprofiles.AS_Title__c= UserInfoDetails.Title;                
                                     }
                                          
                                  
                                  if(!(String.isEmpty(UserInfoDetails.State))){
                                     mbeprofiles.AS_Work_States__c=UserInfoDetails.State;
                                  }
                                  if(!(String.isEmpty(UserInfoDetails.Phoneno))){
                                     mbeprofiles.AS_WorkPhone__c=UserInfoDetails.Phoneno;
                                  }
                                  
                                if(!(String.isEmpty(UserInfoDetails.Country))){
                                     mbeprofiles.AS_Work_Country__c=UserInfoDetails.Country;
                                  }
                        
                          
              if(!(String.isEmpty(UserInfoDetails.ImageUrl))){
                 Id filderId;
                  List<Folder> docs =[Select f.Type, f.SystemModstamp, f.NamespacePrefix, f.Name, f.LastModifiedDate, f.LastModifiedById, f.IsReadonly, f.Id, f.DeveloperName, f.CreatedDate, f.CreatedById, f.AccessType From Folder f where Name='shared documents'limit 1];
                     if(docs.size()>0){
                       filderId=docs[0].id;
                      }
                      
                       Document UserImageDoc = new Document();
                       UserImageDoc.Body = EncodingUtil.base64Decode(UserInfoDetails.ImageUrl);
                       UserImageDoc.FolderId =filderId;
                   
                       if(UserInfoDetails.ImageUrl!=null && UserInfoDetails.ImageUrl!=''){
                          List<document> docs12 =[select id from document where name =:userName+'.jpeg'];
                          delete docs12;
                          UserImageDoc.Name = userName+'.jpeg'; 
                      }
                  
                   UserImageDoc.IsPublic =true;
                   Database.SaveResult UseImageSaveresult =  Database.insert(UserImageDoc);
                  System.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFF 122222222222'+UseImageSaveresult.getId());
                 
                   
                   if (UseImageSaveresult.isSuccess()== True){                
                    mbeprofiles.AS_ImageUrl__c = UseImageSaveresult.getId();
                 }
                 
               }    
              DataBase.update(mbeprofiles,false);
              successMessage.Message= 'Updated Succesfully'; 
                
             }catch(exception er){} 
          }
         }   
        return successMessage;   
      }   
  }
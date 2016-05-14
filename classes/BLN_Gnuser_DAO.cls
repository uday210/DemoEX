public without sharing class BLN_Gnuser_DAO {
/***********************************************************************************************
*   Controller Name : BLN_Gnuser_DAO
*   Date            : 07/01/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class has all queries and Dml oprations of GNuser Object
*   Change History  : 07/01/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
* 07/01/2014          Phani Kumar ch                    To Create Page
**************************************************************************************************/
   public List<GN_User__c > getGnuserList(SET<id> setOfgnusers){
      return [select id,First_Name__c,Last_Name__c,User__c,Age__c,DOB__c,Eff_Date__c,Email__c,Gender__c,Is_Active__c,Mobile__c,User_Pic__c,Suffix__c,Prefix__c,Home_Phone__c,Biography__c,Blogger__c,FaceBookId__c,LinkedInId__c,TwitterId__c,Video__c from GN_User__c where Id IN :setOfgnusers];
   }
  public SET<String> getGnuserList(SET<String> setOfgnusers){
      MAP<String,GN_User__c> mapIdWithGnu = new MAP<String,GN_User__c>();
      for(GN_User__c gn :[select id,First_Name__c,Last_Name__c,User__c,Age__c,DOB__c,Eff_Date__c,Email__c,Gender__c,Is_Active__c,Mobile__c,User_Pic__c,Suffix__c,Prefix__c,Home_Phone__c,Biography__c,Blogger__c,FaceBookId__c,LinkedInId__c,TwitterId__c,Video__c from GN_User__c where Email__c IN :setOfgnusers]){
          mapIdWithGnu.put(gn.Email__c,gn);
      }
      return mapIdWithGnu.KeySet();
   }
   
   // This method is for updating gnuser
    public string updateGNUser(GN_User__c u,String Email,String ticketid,String sfuserid){
    
       //get gnuser of that ticket
       Ticket__c tc=[select id,name,tkt_profile__c from Ticket__c where id=:ticketid];
       system.debug('@@@tc'+tc);
        //Update user
        GN_User__c updateuser = [SELECT id,First_name__c,Last_name__c,Email__c,Home_phone__c,User__c FROM GN_User__c 
                            WHERE id =: tc.tkt_profile__r.bln_gn_user__c];
        system.debug('@@@updateuser'+updateuser);                    
        updateuser.First_Name__c=u.First_Name__c;
        updateuser.Last_Name__c=u.Last_Name__c ;
        //updateuser.title__c=u.title__c;
        updateuser.Home_phone__c=u.Home_phone__c;
        updateuser.Email__c =u.email__c;
        if(sfuserid!=null)
        updateuser.User__c=u.user__c;
        
        database.update(updateuser);    
        
        return updateuser.id;
    }
    
      public string InsertGNUser(GN_User__c u){
       DataBase.saveREsult saveRes =  DataBase.Insert(u,false);
       system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE '+saveRes );
        if(saveRes.isSuccess()){
            return saveRes.getId();
        }else{
           return '';
        }
      }
      
      
       public void InsertGNUser(List<GN_User__c> u){
          DataBase.saveREsult[] saveRes =  DataBase.Insert(u,false);
       }
      
      
      
      public GN_User__c gettinggnuser(string uid){
      
      return [SELECT id,name,First_Name__c,Last_Name__c,Prefix__c,Suffix__c,Email__c,(select id,Title__c,Company__c ,name from UC_Role__r ),
                        Default_Company_ID__c,Default_Company_ID__r.Name,Home_Phone__c,Home_Address__c,Home_Address__r.state__r.Long_Name__c,Home_Address__r.Country__r.Long_Name__c,User_Pic__c,Mobile__c
                        from GN_User__c where   User__c =: uid Limit 1];
      
      }
      
      //Methods to get com. extmsion work/business counntry and state info.....Start
      public UC_Role__c gettingUserRoleData(String gnUserId){
          return [Select Id,Name,Company__c,GN_User__c,Company__r.Id 
                  FROM
                  UC_Role__c
                  WHERE
                  GN_User__c = :gnUserId Limit 1];
      }
      
 //Methods to get com. extmsion work/business counntry and state info.....Start
      public UC_Role__c gettingUserRoleData(String gnUserId,String Cid){
          return [Select Id,Name,Company__c,GN_User__c,Company__r.Id 
                  FROM
                  UC_Role__c
                  WHERE
                  GN_User__c = :gnUserId and Company__c=:Cid Limit 1];
      }

      
       public Company_Ext__c gettingCmpnyExtData(String cmpnyId){
          return [Select Id,Name,Company__c,BLN_Business_Country__c,BLN_Business_State__c,BLN_Business_Country__r.Name,BLN_Business_Country__r.Long_Name__c,BLN_Business_State__r.Name,BLN_Business_State__r.Long_Name__c,Business_City__c
                  FROM
                  Company_Ext__c
                  WHERE
                  Company__c = :cmpnyId Limit 1];
      }
      //Methods to get com. extmsion work/business counntry and state info.....End
      
      public GN_User__c existingGnuser(string emailid){
      system.debug('ddddddddddddddddddddddddd'+emailid);
      return [SELECT Default_Company_ID__c,id,name,First_Name__c,Last_Name__c,Prefix__c,Email__c,Age__c,Biography__c,Blogger__c,DOB__c,FaceBookId__c,FourSquareId__c,Gender__c,LinkedInId__c,Suffix__c,TwitterId__c,Video__c,
                        Home_Phone__c,User_Pic__c,Mobile__c,Default_Company_ID__r.id,Default_Company_ID__r.Name,Home_Address__c,Home_Address__r.Address1__c,Home_Address__r.Address2__c,Home_Address__r.City__c,Home_Address__r.State__c ,Home_Address__r.Country__c ,Home_Address__r.Zipcode__c,Home_Address__r.Country__r.Long_Name__c FROM GN_User__c WHERE Email__c =: emailid limit 1];
      
      }
      
    
    public List<GN_User__c> existingGnusers(SEt<string> emailid){
      system.debug('dddddddddddddddddddddddddrajendrnrn'+emailid);
      return [SELECT Default_Company_ID__c,id,First_Name__c,Last_Name__c,Prefix__c,Suffix__c,Email__c,
                        Home_Phone__c,User_Pic__c,Mobile__c,Default_Company_ID__r.id FROM GN_User__c WHERE Email__c In : emailid ];
      
      }
      
    
    
    
    //return gnuserid
    public String insertGnUserprocess(String FirstName,String LastName,String email,String title,String phone,String address1,String address2,String city,String state,String country,String zipcode)
    {
        GN_User__c newu=new GN_User__c();
        newu.First_Name__c=FirstName;
        newu.Last_Name__c=LastName;
        newu.Email__c=email;
        //newu.Title__c=title;
        /*
        newu.Phone__c=phone;
        newu.Address1__c = address1;
        newu.Address2__c =  address2;
        newu.City__c = city;
        newu.State__c =state;
        newu.Country__c  = country;
        newu.Zip_Code__c = zipcode;
        */
        //insert GNuser process
    
        BLN_StatusMessage userMsg;
        String userid;
    
         BLN_Quick_Registration_BAL quickbal = new BLN_Quick_Registration_BAL ();
        if(quickbal.checkUserEmail(newu.Email__c)!=null){
            
            for(GN_User__c gnup : [select Default_Company_ID__c,id,First_Name__c,Last_Name__c,Email__c,user__c from GN_User__c where user__c =:quickbal.checkUserEmail(newu.Email__c) limit 1]){
                           userid= gnup.id;
                           
                            if(newu.Home_Phone__c!=null){
                             gnup.Home_Phone__c= newu.Home_Phone__c;
                            }
                            /*
                          if(newu.Address1__c!=null){
                             gnup.Address1__c = newu.Address1__c;
                            }
                            if(newu.Address2__c!=null){ 
                             gnup.Address2__c =  newu.Address2__c;
                            } 
                            if(newu.City__c!=null){
                             gnup.City__c = newu.City__c;
                            }
                            if(newu.State__c!=null){
                             gnup.State__c =newu.State__c;
                            }
                            if(newu.Country__c!=null){
                                gnup.Country__c  = newu.Country__c;
                            } 
                             if(newu.Zip_Code__c!=null){ 
                              gnup.Zip_Code__c = newu.Zip_Code__c;
                             }   
                             */ 
                       dataBase.update(gnup,false);
                      
            } 
            
            //if user exists but gnuser not exits
            if(userid==null)
            {
              BLN_User_DAO UserDAO = new BLN_User_DAO();
              newu.user__c=quickbal.checkUserEmail(newu.Email__c);
              userMsg=UserDAO.insertGNUser(newu);
            if(userMsg.successBool){
                userid=userMsg.successId;                  
            }
            }     
                 
        }else{
            userMsg=quickbal.insertGNUser(newu);
            if(userMsg.successBool){
                userid=userMsg.successId;                  
            }else{
                
               userid=null;  
            }
        }
        
        return userid;
    }
    
    
    
}
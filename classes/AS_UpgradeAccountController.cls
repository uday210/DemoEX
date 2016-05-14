public with sharing class AS_UpgradeAccountController{


public Pagereference CheckUserId(){
        if(userInfo.getUserType()=='guest'){
            Pagereference pg = new pagereference('/apex/AS_Login');
            pg.setredirect(true);
            return pg;
        }
        else{
            return null;
        }
    }

}
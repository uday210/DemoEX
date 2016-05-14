@RestResource(urlMapping='/AS_ItemInfo/*')
  
    global with sharing class AS_ItemInfo{
    
    @HttpPost
    global static Container doPost(){
        RestRequest req = RestContext.request;
        RestResponse response = RestContext.response;  
        system.debug('Body is '+req.requestBody);
        Blob jSONRequestBody=req.requestBody; 
        system.debug('$$$$$ '+jSONRequestBody);
        Container ct=new Container();
        try{
        
            String Item_Name=req.params.get('Item_Name');
            Decimal Item_Price;
            try{
                Item_Price=Decimal.valueOf(req.params.get('Item_Price'));
            }catch(exception ex){}
            String Item_Id=req.params.get('Item_Id');
            Decimal Item_Quantity;
            try{
                Item_Quantity=Decimal.valueOf(req.params.get('Item_Quantity'));
            }catch(exception ex){}
            boolean isTaxable=Boolean.valueOf(req.params.get('isTaxable'));
            Decimal SalesTax;
            try{
                SalesTax=Decimal.valueOf(req.params.get('SalesTax'));
            }catch(exception ex){}
            String EventID = req.params.get('Event_Id');
            String MobileItemID = req.params.get('MobileItem_Id');
            String Status=req.params.get('Status');  
            String OwnerEmailID = req.params.get('OwnerEmailID');
            List<User> LoginUser = [SELECT   Id,Username,FirstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City FROM User WHERE UserName=:OwnerEmailID limit 1 ];

            if(Status=='CREATE'){
                Item__c itm=new Item__c();
                itm.Event__c=EventID ;
                itm.Item_name__c=Item_Name;
                itm.Cost__c=Item_Price;
                itm.Item_Quantity__c=Item_Quantity;
                itm.isTaxable__c=isTaxable;
                itm.Sales_Tax__c=SalesTax;
                itm.ownerid=LoginUser[0].ID;
                
                Document document = new document();
                String imageurl ='';
                try{
                    document.Name=EventID+MobileItemID;
                    
                    document.isPublic=true;
                    document.ContentType='image/png';
                    document.type='png';
                    document.IsInternalUseOnly =false;
                    document.body=jSONRequestBody;
                    document.folderId=UserInfo.getUserId();
                    DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                    if(docSaveResult.isSuccess()){
                        system.debug('#### '+docSaveResult.getId());
                        itm.Item_Image__c = docSaveResult.getId();
                    }
                }
                catch(exception e){}

                insert itm;
                
                
                string urlbase =URL.getSalesforceBaseUrl().getHost();
                string orgId = UserInfo.getOrganizationId();
                String itemimageURL ='';
                system.debug('%%%%% '+itm.Item_Image__c+'&&&'+itm.id);
                itemimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+itm.Item_Image__c;
                ct.Success=new Success(MobileItemID,itm.Id,0,itemimageURL);
            }
            
            if(Status=='EDIT'){
                //Get Event Details FROM Ticket Object
                system.debug('  ITEM ID '+Item_Id);
                List<Item__c> itm=[SELECT Id,Event__c,Item_name__c,Cost__c,Item_Quantity__c,Item_Image__c,Sold_Quantity__c,isTaxable__c,Sales_Tax__c FROM Item__c WHERE id=:Item_Id LIMIT 1];
                system.debug('  ITEM IDSSSSSSSS '+itm);
                if(itm.size()==0)
                    ct.error='No Such Item Information Exists';
                else{
                    if(Item_Quantity<itm[0].Sold_Quantity__c){
                        ct.error='Item Quantity cannot be less that Sold Quantity';
                    }
                    else{
                        itm[0].Event__c=EventID ;
                        itm[0].Item_name__c=Item_Name;
                        itm[0].Cost__c=Item_Price;
                        itm[0].Item_Quantity__c=Item_Quantity;
                        itm[0].Mobile_ItemID__c =MobileItemID;
                        itm[0].isTaxable__c=isTaxable;
                        itm[0].Sales_Tax__c=SalesTax;
                        itm[0].ownerid=LoginUser[0].ID;
                        String imageURL='';
           
                            try{
                                Document d=[SELECT id,name FROM Document WHERE name=:itm[0].Event__c+itm[0].Mobile_ItemID__c];
                                    if(d!= NULL){
                                        database.delete(d,false);
                                    }
                            }
                            catch(exception e){}
                            try{
                                Document document = new document();
                                document.Name=itm[0].Event__c+itm[0].Mobile_ItemID__c;
                                
                                document.isPublic=true;
                                document.ContentType='image/png';
                                document.type='png';
                                document.IsInternalUseOnly =false;
                                document.body=jSONRequestBody;
                                
                                document.folderId=UserInfo.getUserId();

                                DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                                if(docSaveResult.isSuccess()){
                                    imageurl = docSaveResult.getId();
                                }
                                itm[0].Item_Image__c=imageurl; 
                            }
                            catch(Exception e){}

                        update itm[0];
                        system.debug('&&&&&& '+itm[0]);
                        string urlbase =URL.getSalesforceBaseUrl().getHost();
                        string orgId = UserInfo.getOrganizationId();
                        String itemimageURL ='';
                        itemimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+itm[0].Item_Image__c;
                        ct.Success=new Success(MobileItemID,itm[0].Id,itm[0].Sold_Quantity__c,itemimageURL);
                    }
                }
            }
            
            if(Status=='DELETE'){
                List<Item__c> itm=[SELECT   Id,Event__c,Item_name__c,Cost__c,Item_Quantity__c,Item_Image__c,Sold_Quantity__c,isTaxable__c,Sales_Tax__c FROM Item__c WHERE id=:Item_Id];
                if(itm.size()==0)
                    ct.error='No Such Item Exists';
                else{
                    ct.Success=new Success(MobileItemID,itm[0].Id,0,'');
                    delete itm;
                } 
            }
            
        }
        catch(Exception e){
            ct.error=e.getMessage();
        }
        
        
        return ct;
    
    }
    
    global class Container{
        public Success Success{get;set;}
        public String error{get;set;}
        
        public Container(){
        }
    }
    
    global class Success{    
        public String MobileItem_Id{get;set;}
        public Id Item_Id{get;set;}
        public Decimal Sold_Quantity{get;set;}
        public String ItemImage{get;set;}

        public Success(String mobileid,Id itemid,Decimal Sold_Quantity,String ItemImage){
            MobileItem_Id=mobileid;
            Item_Id=itemid;
            this.Sold_Quantity=Sold_Quantity;
            this.ItemImage=ItemImage;
        }
    }
       
}
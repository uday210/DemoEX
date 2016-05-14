global class BLN_ASC_Utillcls {
   
   public Static MAP<id,Tkt_profile__c> tktps=new MAP<id,Tkt_profile__c>();
	global OrderInfo parseInncls(BLN_Mytickets_BAL.inncls inc) {
		OrderInfo orderInfo = new orderInfo(inc.orderInn);
		OrderInfo.PaymentInfo = new PaymentInfo(inc.orderInn, inc.paymentInn);
		OrderInfo.ItemInfo = new List<ItemInfo>();
		OrderInfo.TicketInfo = new List<TicketInfo>();
		for (Order_Item__c oit : inc.orderItemInn) {
			OrderInfo.ItemInfo.add(new ItemInfo(oit));
		}
		for (Ticket__c tc : inc.ticketsInn ) {
			OrderInfo.TicketInfo.add(new TicketInfo(tc));
		}
		return OrderInfo;
	}


	global class OrderInfo {
		public String id {get; set;}
		public String name {get; set;}
		public String status {get; set;}
		public String eventId{get;set;}
		public DateTime OrderCreatedDate{get;set;}
		public TktProfileInfo buyerInfo {get; set;}
		public PaymentInfo PaymentInfo {get; set;}
		public List<ItemInfo> ItemInfo {get; set;}
		public List<TicketInfo> TicketInfo {get; set;}
		public OrderInfo(Order__c ord) {
			id = ord.id;
			name = ord.Name;
			eventId = ord.Events__c;
			status = ord.Order_Status__c;
			OrderCreatedDate = ord.CreatedDate;
			buyerInfo = new TktProfileInfo(ord);
		}
	}
	// Order Item information
	global class ItemInfo {
		public String Name{get;set;}
		public String Id{get;set;}
    	public Decimal price {get; set;}
    	public Decimal eachItemPrice{get;set;}
    	public String status {get; set;}
    	public Decimal quatity {get; set;}
    	public String itemType{get;set;}
		public Decimal fee {get; set;}
		public Decimal discount {get; set;}
		public Decimal tax {get; set;}
		public String promotionName {get; set;}
		public String promotionId{get;set;}
		public String promocode{get;set;}
		public String itemName{get;set;}
		public String currencyName {get; set;}
		public ItemInfo(Order_Item__c oi) {
			price = oi.Item_Total__c;
			status = oi.Status__c;
			itemName = oi.Item__r.item_name__c;
			eachItemPrice = oi.Each_Ticket_Price__c;
			fee = oi.Item_Fee__c;
			discount = oi.Item_Discount__c;
			itemType = oi.Item__r.Item_Type__r.Name;
			tax = oi.Tax__c;
			promotionName = oi.Promotion__r.Name;
			promocode= oi.Promotion__r.id;
			promocode = oi.Promotion__r.Promo_Code__c;
			quatity = oi.Item_Quantity__c;
			Name = oi.Name;
            Id = oi.Id;
		}
	}
	// Ticket information information
	global class TicketInfo {
		public String id {get; set;}
		public String seatNo {get; set;}
		public String scanId {get; set;}
		public String customBarcodeId {get; set;}
        public String badgeId{get;set;}
		public String typeOfTicket {get; set;}
		public String orderId {get; set;}
        public String name {get;set;}
        public String status{get;set;}
        public String badgelabel{get;set;}
        public String itemTypeName{get;set;}
        public DateTime lastModifieddate{get;set;}
        public String orderItemName{get;set;}
        public String orderItemId{get;set;}
        public String itemName{get;set;}
        public String itemid{get;set;}  
        public Decimal displayorder{get;set;}
        public String parentId{get;set;}
        public String itemPoolid{get;set;}
        public String itempoolName{get;set;}
        public String isItemBadgeble{get;set;}
        public TktProfileInfo TktProfileInfo {get; set;}
		public SponsorshipInfo SponsorshipInfo {get; set;}
		public boothInfo BoothInfo {get; set;}
		public TicketInfo(Ticket__c tc) {
			id = tc.id;
			name =tc.Name;
			status = tc.Ticket_Status__c;
			badgelabel = tc.Badge_Label__c;
            lastModifieddate = tc.lastModifieddate;
            orderItemName = tc.Order_Item__r.Name;
            orderItemId = tc.Order_Item__c;
            itemName = tc.Item__r.item_name__c;
            itemid = tc.Item__c;
            itemTypeName = tc.Item_Type__r.Name;
            parentId = tc.Parent_ID__c;
            isItemBadgeble = tc.Item_Pool__r.Badgable__c;
            itemPoolid = tc.Item_Pool__c;
            itempoolName = tc.Item_Pool__r.Item_Pool_Name__c;
            displayorder = tc.Ticket_Display_Order__c;
            typeOfTicket = tc.Item_Pool__r.Item_Type__r.Name;
			OrderId = tc.Order__c;
			seatNo = tc.Tag_No__c;
			scanId = tc.Scan_Id__c;
			customBarcodeId = tc.Custom_Barcode__c;
            badgeId =tc.Badge_ID__c;
			TktProfileInfo = new TktProfileInfo(tc);
			if (tc.BLN_Sponsorships__r.size() > 0) {
				this.SponsorshipInfo = new SponsorshipInfo(tc.BLN_Sponsorships__r[0]);
			}
			if (tc.booth_maps__r.size() > 0) {
				this.BoothInfo = new boothInfo(tc.booth_maps__r[0]);
			}
		}
	}

	global class SponsorshipInfo {
		public Decimal DisplayOrder {get; set;}
		public string LogoSize {get; set;}
		public string SponsorshipCategory {get; set;}
		public string TicketID {get; set;}
		public String Id {get; set;}
        public String Visibility{get;set;}

		public SponsorshipInfo(BLN_Sponsorships__c sp) {
			DisplayOrder = sp.Display_Order__c;
			LogoSize = sp.Logo_Size__c;
			SponsorshipCategory = sp.Sponsorship_Category__c;
			TicketID = sp.Ticket_ID__c;
			Id = sp.Id;
            Visibility = sp.Visibility__c;
		}
	}

	// Payment information
	global class PaymentInfo {
		public String currencyName {get; set;}
		public Decimal price {get; set;}
		public Decimal fee {get; set;}
		public Decimal discount {get; set;}
		public Decimal tax {get; set;}
		public Decimal paidAmount {get; set;}
		public Decimal actualPrice {get; set;} // with any discount
		public String gateWayName {get; set;}
		public String cardNo {get; set;}
		public String cardType {get; set;}
		public String mode {get; set;}
		public String refNo {get; set;}
		public PaymentInfo(Order__c ord, Payment__c pay) {
			if (ord != null) {
				price = ord.Order_Total__c;
				fee = ord.Order_Discount__c;
				discount = ord.Order_Discount__c;
				tax = ord.Order_Taxes__c;
				paidAmount = ord.Amount_Paid__c;
				actualPrice = ord.Order_Sub_Total__c;
				gateWayName = pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name;
				cardNo = pay.credit_card_last_4digits__c;
				cardType = pay.credit_card_type__c;
				mode =  pay.Payment_Mode__c;
				refNo = pay.Payment_Ref_Number__c;
			}
		}
		public PaymentInfo(Payment__c pay) {
			gateWayName = pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name;
			cardNo = pay.credit_card_last_4digits__c;
			cardType = pay.credit_card_type__c;
			mode =  pay.Payment_Mode__c;
			refNo = pay.Payment_Ref_Number__c;
		}
	}
	// User Information
	global class TktProfileInfo {
		public String id {get; set;}
		public String firstname {get; set;}
		public String lastname {get; set;}
		public String email {get; set;}
		public String mobile {get; set;}
		public String designation {get; set;}
		public String image {get; set;}
		public String twitter {get; set;}
		public String faceBook {get; set;}
		public String linkedInId {get; set;}
		public String biography {get; set;}
		public CompanyInfo companyInfo {get; set;}
		public List<eventDocuments> Documents{get;set;}
        public String blogger{get;set;}
        public String blog{get;set;}
        public string video{get;set;}

		public  TktProfileInfo(Ticket__c tc) {
			id = tc.Tkt_profile__c;
			firstname = tc.Tkt_profile__r.First_Name__c;
			lastname = tc.Tkt_profile__r.Last_Name__c;
			email = tc.Tkt_profile__r.Email__c;
			mobile = tc.Tkt_profile__r.Mobile__c;
			blogger = tc.Tkt_profile__r.Blogger__c;
			blog = tc.Tkt_profile__r.Blog_URL__c;
			if(null!=tc.Tkt_profile__r)
			companyInfo = new companyInfo(tc.Tkt_profile__r);
			designation = tc.Tkt_profile__r.TKT_Job_Title__c;
			image = tc.Tkt_profile__r.User_Pic__c;
			faceBook = tc.Tkt_profile__r.FaceBookId__c;
			linkedInId = tc.Tkt_profile__r.LinkedInId__c;
			twitter = tc.Tkt_profile__r.TwitterId__c;
			biography = tc.Tkt_profile__r.Biography__c;
            if(tc.TKT_profile__r.Video__c !=null && tc.TKT_profile__r.Video__c !=''){
            video=tc.TKT_profile__r.Video__c;
            }
			Documents= new List<eventDocuments>();
		try{	
			System.debug('Tkt profile values-------------- '+tktps);
            List<Attachment> attments = new List<Attachment>();
            if(null != tktps.get(tc.Tkt_profile__c)){
               attments	=tktps.get(tc.Tkt_profile__c).Attachments;
            }
			for(Attachment ar :attments){
              Documents.add(new eventDocuments(ar));
		    }
		  }catch(exception er){}  
		}
		public  TktProfileInfo(Order__c ord) {
			id = ord.BLN_Tkt_profile__c;
			firstname = ord.BLN_Tkt_profile__r.First_Name__c;
			lastname = ord.BLN_Tkt_profile__r.Last_Name__c;
			email = ord.BLN_Tkt_profile__r.Email__c;
			companyInfo = new companyInfo(ord.BLN_Tkt_profile__r);
			mobile = ord.BLN_Tkt_profile__r.Mobile__c;
			designation = ord.BLN_Tkt_profile__r.TKT_Job_Title__c;
			image = ord.BLN_Tkt_profile__r.User_Pic__c;
			faceBook = ord.BLN_Tkt_profile__r.FaceBookId__c;
			linkedInId = ord.BLN_Tkt_profile__r.LinkedInId__c;
			twitter = ord.BLN_Tkt_profile__r.TwitterId__c;
			biography = ord.BLN_Tkt_profile__r.Biography__c;
			blogger = ord.BLN_Tkt_profile__r.Blogger__c;
			blog = ord.BLN_Tkt_profile__r.Blog_URL__c;
			
			Documents = new List<eventDocuments>();
		}
		public TktProfileInfo(Tkt_profile__c tp) {
			id = tp.id;
			companyInfo = new companyInfo(tp);
			firstname = tp.First_Name__c;
			lastname = tp.Last_Name__c;
			email = tp.Email__c;
			mobile = tp.Mobile__c;
			designation = tp.TKT_Job_Title__c;
			image = tp.User_Pic__c;
			faceBook = tp.FaceBookId__c;
			linkedInId = tp.LinkedInId__c;
			twitter = tp.TwitterId__c;
			biography = tp.Biography__c;
			blogger = tp.Blogger__c;
			blog = tp.Blog_URL__c;
			
			Documents = new List<eventDocuments>();
		}

		public TktProfileInfo(Participant__c par) {
			id = par.BLN_TKT_profile__c;
			firstname = par.BLN_TKT_profile__r.First_Name__c;
			lastname = par.BLN_TKT_profile__r.Last_Name__c;
			email = par.BLN_TKT_profile__r.Email__c;
			companyInfo = new companyInfo(par.BLN_TKT_profile__r);
			mobile = par.BLN_TKT_profile__r.Mobile__c;
			designation = par.BLN_TKT_profile__r.TKT_Job_Title__c;
			image = par.BLN_TKT_profile__r.User_Pic__c;
			faceBook = par.BLN_TKT_profile__r.FaceBookId__c;
			linkedInId = par.BLN_TKT_profile__r.LinkedInId__c;
			twitter = par.BLN_TKT_profile__r.TwitterId__c;
			biography = par.BLN_TKT_profile__r.Biography__c;
			blogger = par.BLN_TKT_profile__r.Blogger__c;
			blog = par.BLN_TKT_profile__r.Blog_URL__c;
			
			Documents = new List<eventDocuments>();
		}
	}
	global class companyInfo {
		public String Name {get; set;}
		public String Logo {get; set;}
		public String Description {get; set;}
		public String Website {get; set;}
		public companyInfo(TKT_profile__c tkt) {
			Name = tkt.TKT_Company__c;
			Description = tkt.Company_Description__c;
			Logo = tkt.Company_Logo__c;
			Website = tkt.Company_Website_URL__c;
		}
	}

	global class boothInfo {
		public String boothName {get; set;}
		public String boothArea {get; set;}
		public String boothNumber {get; set;}
		public String room {get; set;}
		public String boothId {get; set;}
		public String boothTicketId {get; set;}
        public String visibility{get;set;}

		public boothInfo(booth_map__c bM) {
			boothName = bM.Ticket_id__r.tkt_profile__r.TKT_Company__c == null ? '' : bM.Ticket_id__r.tkt_profile__r.TKT_Company__c;
			boothArea = bM.Booth_Area__c == null ? '' : bM.Booth_Area__c;
			boothNumber = bM.Booth_Number__c == null ? '' : bM.Booth_Number__c;
			room = bM.BLN_Room__r.Name == null ? '' : bM.BLN_Room__r.Name;
			boothId = bM.id == null ? '' : bM.id;
			boothTicketId = bM.Ticket_id__r.Name == null ? '' : bM.Ticket_id__r.Name;
            Visibility = bM.Visibility__c;
		}
	}

	global Class appSttings {
		public string EventID{get; set;}
		public String ColumnName{get; set;}
		public String Columnlabel{get; set;}
		public Boolean Include{get; set;}
		public String Image{get;set;} 
		public string id{get; set;}
        public string displayorderId{get;set;}
		public  appSttings(Reg_Setting__c reg) {
			ColumnName = reg.Defaullt_Label__c;
			Columnlabel = reg.Label_Name__c;
			Include = reg.Included__c;
			id = reg.id;
			EventID = reg.Event__c;
            displayorderId= string.valueof(reg.Order__c);
			if(reg.Images__c!=null && reg.Images__c!='')
               Image =Label.ImageUrl+'?oid='+UserInfo.getOrganizationId()+'&id='+reg.Images__c;
		}
	}

	global Class eventDocuments {
        public string id{get;set;}
		public String Name{get; set;}
		public String Image{get; set;}
		public String Url{get; set;}
		public String Address{get; set;}
		public String Document{get; set;}
		public String Type{get;set;}
        public boolean isdelete{get;set;}
		public eventDocuments(BLN_Event_Document__c Ed) {
            id=Ed.id;
			Name = Ed.Name;
			Type =  Ed.Type__c;
            
			if (Ed.Image__c != null && Ed.Image__c != '')
				Image = Label.ImageUrl + '?oid=' + UserInfo.getOrganizationId() + '&id=' + Ed.Image__c;
			Url = Ed.Url__c;
			Address  = Ed.Address__c;
			for (Attachment att : Ed.Attachments) {
            
				Document = Label.Doc_Url + att.id;
                isdelete=att.isDeleted;
			}
		}

		public eventDocuments(Attachment att){
           id=att.id;
           Name = att.Name;
           Document = Label.Doc_Url + att.id;
           isdelete=att.isDeleted;
           system.debug('Name====='+Name);
		}
	}

    global class nonBadgeItempool{
    public string itemPoolId{get;set;}
    public string badgeStatus{get;set;}
    public nonBadgeItempool(Item_Pool__c itp){
    itemPoolId=itp.id;
    badgeStatus=itp.Badgable__c;
    
    }
    
    
    }

}
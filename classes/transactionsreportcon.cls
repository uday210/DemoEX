public class transactionsreportcon {

public LIST<Dummay__c> dum{get;set;}
public Dummay__c dm{get;set;}
public Dummay__c temp{get;set;}
 public string eventid{get;set;}
 public string email{get;set;}
 public string paykey{get;set;}
    public transactionsreportcon()
    {
   
      
      eventid= Apexpages.CurrentPage().getParameters().get('id');
      dum= [Select ID,First_Name__c,Last_Name__c,Email__c,Company__c,payKey__c,Payment_Type__c,Registered_Date__c,customer_key__r.IsInserted__c,IndividualAmount__c,Event__r.OrganizerId__c
            FROM Dummay__c 
            WHERE Event__c=: eventid 
          // Event__r.id='a00Z000000IKyiv'
            ORDER BY Registered_Date__c DESC ];
    }
    
public void sendemail()
{
    system.debug('EMAILID:' + email + 'eventid:' + eventid);
     temp= [Select ID,First_Name__c,Last_Name__c,Email__c,Company__c,payKey__c,Payment_Type__c,Registered_Date__c,Event__r.EV_Title__c,customer_key__r.IsInserted__c,IndividualAmount__c,Event__r.OrganizerId__c
            FROM Dummay__c where id=:email AND Event__c=: eventid
           ];

    system.debug('mmmmmmmmmmmmmc'+temp);
    //email = Apexpages.CurrentPage().getParameters().get('emailid');
   // system.debug('Email Id:'+email);
    LIST<String> ccAddresses = new LIST<String>();
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    EmailTemplate template = [select Id,Body,Subject,Markup from EmailTemplate Where Name = 'Failed Transaction'];
   // mail.setTemplateId(template.Id);
   mail.setSubject('Your Registration for '+temp.Event__r.EV_Title__c  + ' did not go through');
    mail.setReplyTo('unnikrishna.tula@globalnest.com');
    mail.setToAddresses(new String[]{temp.Email__c});
    mail.setccAddresses(new String[]{temp.Event__r.OrganizerId__c});
    system.debug('ccccccccccccc'+mail);
    //ccAddresses.add('durga@globalnest.com');
    mail.setSenderDisplayName('Unni');
    User us=[select id,name,Username from User where Username=:temp.email__c];
    //mail.setTargetObjectId(us.id);
   // mail.setWhatId(dum[0].id);
    //mail.setSaveAsActivity(false);
  
   



     // EmailTemplate E = new EmailTemplate();
      
      //= [select Id,Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Failed Transaction'];
      
       
      String ReplaceContactName = template.body; 
        system.debug('gggggggggggg'+ReplaceContactName);
      string replacedname;
      
            
              replacedname =ReplaceContactName.Replace('{!username}',temp.First_Name__c );
              system.debug('AAAAAAAAAAAAA'+replacedname);
             
                 // replacedname = ReplaceContactName.Replace('{!Dummay__c.First_Name__c}','');
              
              
             
              replacedname = replacedname.Replace('{!event}',temp.Event__r.EV_Title__c);
              system.debug('bbbbbbbbbbbbb'+replacedname);
               mail.setPlainTextBody(replacedname);   
               
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
               
}



  public pagereference chkpay()
  {
   paykey=ApexPages.CurrentPage().getParameters().get('paykey');
   Pagereference pg= page.PayDetailTest;
   //ControllerPayDetailApi.Paykey= dum.payKey__c;
  
   return pg;
  
  }
}
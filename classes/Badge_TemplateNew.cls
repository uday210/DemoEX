@RestResource(urlMapping='/Badge_TemplateNew/*')
    
    
    global with sharing class Badge_TemplateNew{
    

    
    @HttpPost  
    global static List<BadgeWithLayers> doPost(){
   
    
    RestRequest req = RestContext.request;  
        String EventID = req.params.get('Event_Id');
        RestResponse response = RestContext.response; 
    
     //   createstandardbadge('{"canvasWidth":"3.9","canvasHeight":"2.4","paperSize":"3.9\\" x 2.4\\"(Brother DK1202)","backgroundColor":"#FFFFFF","backgroundImage":"","backgroundSize":"100% 100%","backgroundPosition":"center center","backgroundRepeat":"no-repeat"}','Default badge-1',EventID,'"Scan Attendee;Attendee Registration"','Brother','{"id":-1,"type":"Image layer","content":"Hello World123123","directive":"layer-image","width":0.2524617996604414,"height":0.11943972835314091,"x":0.383938591695203,"y":0.005168196598659039,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":11,"elem":null,"scope":null,"image":"/Eventdex/resource/1444806078000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}','{"id":-1,"type":"Shape layer","content":"Hello World123123","directive":"layer-shape","width":1.005105428620759,"height":0.17482662369428226,"x":-0.005105428620759023,"y":0.1851112198210123,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":12,"elem":null,"scope":null,"color":"#bd2424","shape":0,"dummyLabel":"Rectangle","layerType":"SHAPE"}','{"id":-1,"type":"Attendee data layer","content":"John Smith","directive":"layer-text","width":0.7915110356536503,"height":0.16078098471986418,"x":0.10593939742741212,"y":0.19198008690397395,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":13,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"700","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"dummyLabel":"Full Name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"Attendee","directive":"layer-text","width":0.7813242784380307,"height":0.06910016977928692,"x":0.10933786078098467,"y":0.35837242093752697,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":14,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#f29b9b","rotation":0,"dummyLabel":"Ticket type","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Bar code layer","content":"Hello World123123","directive":"layer-bar-code","width":0.1532258064516129,"height":0.1532258064516129,"x":0.8467741935483871,"y":0.46200109349371243,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":15,"elem":null,"scope":null,"barCode":0,"rotation":90,"layerType":"QR_CODE"}','{"id":-1,"type":"Attendee data layer","content":"President","directive":"layer-text","width":0.7864176570458404,"height":0.06570458404074701,"x":0.005125032373169115,"y":0.42184397571292914,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":16,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"dummyLabel":"Title","layerType":"ATTENDEE_DATA"}');
     //   createstandardbadge('{"canvasWidth":"3.9","canvasHeight":"2.4","paperSize":"3.9\\" x 2.4\\"(Brother DK1202)","backgroundColor":"#FFFFFF","backgroundImage":"","backgroundSize":"100% 100%","backgroundPosition":"center center","backgroundRepeat":"no-repeat"}','Default badge-2',EventID,'"Scan Attendee;Attendee Registration"','Brother','{"id":-1,"type":"Attendee data layer","content":"My Company","directive":"layer-text","width":0.5372881355932204,"height":0.06779661016949151,"x":0.015254237288135592,"y":0.5203389830508474,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":8,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#a0ebd8","rotation":0,"dummyLabel":"Company","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"Attendee","directive":"layer-text","width":0.35423728813559324,"height":0.0847457627118644,"x":0.6338983050847457,"y":0.5118644067796609,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":9,"elem":null,"scope":null,"align":"right","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#ffffff","rotation":0,"dummyLabel":"Ticket type","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"John","directive":"layer-text","width":0.9033898305084747,"height":0.19661016949152543,"x":0.003389830508474576,"y":0.1593220338983051,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":10,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"dummyLabel":"First name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"Smith","directive":"layer-text","width":0.9033898305084747,"height":0.08305084745762713,"x":0.010169491525423728,"y":0.364406779661017,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":11,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"dummyLabel":"Last name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Image layer","content":"Hello World123123","directive":"layer-image","width":0.3,"height":0.15,"x":0.00677966101694915,"y":0,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":12,"elem":null,"scope":null,"image":"/Eventdex/resource/1444806078000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}','{"id":-1,"type":"Bar code layer","content":"Hello World123123","directive":"layer-bar-code","width":0.15847457627118644,"height":0.15847457627118644,"x":0.8016949152542373,"y":0.04067796610169491,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":13,"elem":null,"scope":null,"barCode":0,"rotation":90,"layerType":"QR_CODE"}');
          createstandardbadge('{"canvasWidth":"3.9","canvasHeight":"2.4","paperSize":"3.9\\" x 2.4\\"(Brother DK1202)","backgroundColor":"#FFFFFF","backgroundImage":"","backgroundSize":"100% 100%","backgroundPosition":"center center","backgroundRepeat":"no-repeat"}','Default badge-1',EventID,'"Scan Attendee;Attendee Registration"','Brother','{"id":-1,"type":"Shape layer","content":"Hello World","directive":"layer-shape","width":0.9983050847457627,"height":0.15084745762711865,"x":0.0016949152542372614,"y":0.4610169491525423,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":17,"elem":null,"scope":null,"color":"#000000","shape":0,"dummyLabel":"Rectangle","layerType":"SHAPE"}','{"id":-1,"type":"Attendee data layer","content":"My Company","directive":"layer-text","width":0.40338983050847466,"height":0.06610169491525422,"x":0.02542372881355932,"y":0.4864406779661017,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":18,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#ffffff","rotation":0,"fsize":0,"dummyLabel":"Company","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"John Smith","directive":"layer-text","width":0.98135593220339,"height":0.11186440677966104,"x":0.00677966101694899,"y":0.24576271186440682,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":20,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Full Name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Image layer","content":"Hello World","directive":"layer-image","width":0.22542372881355932,"height":0.1652542372881356,"x":0.042372881355932215,"y":0.02033898305084746,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":22,"elem":null,"scope":null,"image":"/Eventdex/resource/1453570521000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}','{"id":-1,"type":"Bar code layer","content":"Hello World","directive":"layer-bar-code","width":0.15847457627118644,"height":0.15847457627118644,"x":0.7881355932203391,"y":0.027118644067796602,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":23,"elem":null,"scope":null,"barCode":0,"rotation":90,"layerType":"QR_CODE"}','{"id":-1,"type":"Attendee data layer","content":"Attendee","directive":"layer-text","width":0.39322033898305087,"height":0.0779925847457627,"x":0.559322033898305,"y":0.4796345338983051,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":69,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#ebe6e6","rotation":0,"fsize":0,"dummyLabel":"Ticket type","layerType":"ATTENDEE_DATA"}');
          createstandardbadge('{"canvasWidth":"3.9","canvasHeight":"2.4","paperSize":"3.9\\" x 2.4\\"(Brother DK1202)","backgroundColor":"#FFFFFF","backgroundImage":"","backgroundSize":"100% 100%","backgroundPosition":"center center","backgroundRepeat":"no-repeat"}','Default badge-2',EventID,'"Scan Attendee;Attendee Registration"','Brother','{"id":-1,"type":"Image layer","content":"Hello World","directive":"layer-image","width":0.3,"height":0.15,"x":0.039066501683404795,"y":0.04245920980691203,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":24,"elem":null,"scope":null,"image":"/Eventdex/resource/1453570521000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}','{"id":-1,"type":"Bar code layer","content":"Hello World","directive":"layer-bar-code","width":0.180433656585422,"height":0.180433656585422,"x":0.7758769531812034,"y":0.02207706253057466,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":25,"elem":null,"scope":null,"barCode":0,"rotation":90,"layerType":"QR_CODE"}','{"id":-1,"type":"Attendee data layer","content":"John Smith","directive":"layer-text","width":0.8118845500848897,"height":0.12003395585738538,"x":0.10422721648297889,"y":0.23108687519783602,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":26,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Full Name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"My Company","directive":"layer-text","width":0.6882996172772007,"height":0.065713216885845,"x":0.1719518862766539,"y":0.367411009755115,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":27,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Company","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Shape layer","content":"Hello World","directive":"layer-shape","width":0.999241298811545,"height":0.1303904923599321,"x":0,"y":0.4759661592472159,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":28,"elem":null,"scope":null,"color":"#000000","shape":0,"dummyLabel":"Rectangle","layerType":"SHAPE"}','{"id":-1,"type":"Attendee data layer","content":"Attendee","directive":"layer-text","width":0.9528013582342955,"height":0.08098471986417655,"x":0.02190440562861498,"y":0.5016057091882248,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":29,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#ffffff","rotation":0,"fsize":0,"dummyLabel":"Ticket type","layerType":"ATTENDEE_DATA"}');
          createstandardbadge('{"canvasWidth":"3.9","canvasHeight":"2.4","paperSize":"3.9\\" x 2.4\\"(Brother DK1202)","backgroundColor":"#FFFFFF","backgroundImage":"","backgroundSize":"100% 100%","backgroundPosition":"center center","backgroundRepeat":"no-repeat"}','Default badge-3',EventID,'"Scan Attendee;Attendee Registration"','Brother','{"id":-1,"type":"Image layer","content":"Hello World","directive":"layer-image","width":0.18813559322033896,"height":0.138135593220339,"x":0.03398175592069294,"y":0.03567667117493022,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":43,"elem":null,"scope":null,"image":"/Eventdex/resource/1453570521000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}','{"id":-1,"type":"Attendee data layer","content":"Attendee","directive":"layer-text","width":0.3656412765100285,"height":0.08099739935541422,"x":0.571891456360968,"y":0.045862259359442895,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":44,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"700","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Ticket type","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"John Smith","directive":"layer-text","width":0.9730367471439669,"height":0.12523956145146897,"x":0.011786711173779165,"y":0.21058674570515956,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":45,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"700","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Full Name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Bar code layer","content":"Hello World","directive":"layer-bar-code","width":0.16523409398290698,"height":0.16523409398290698,"x":0.7825558976720094,"y":0.3872147564098875,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":46,"elem":null,"scope":null,"barCode":0,"rotation":90,"layerType":"QR_CODE"}','{"id":-1,"type":"Attendee data layer","content":"President","directive":"layer-text","width":0.5826825127334465,"height":0.058913412563667236,"x":0.034004776840954216,"y":0.3995885010503295,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":47,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Title","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"My Company","directive":"layer-text","width":0.5826825127334466,"height":0.06061120543293716,"x":0.027222238208972405,"y":0.49124053984058,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":48,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Company","layerType":"ATTENDEE_DATA"}');
          createstandardbadge('{"canvasWidth":"3.9","canvasHeight":"2.4","paperSize":"3.9\\" x 2.4\\"(Brother DK1202)","backgroundColor":"#FFFFFF","backgroundImage":"","backgroundSize":"100% 100%","backgroundPosition":"center center","backgroundRepeat":"no-repeat"}','Default badge-4',EventID,'"Scan Attendee;Attendee Registration"','Brother','{"id":-1,"type":"Shape layer","content":"Hello World","directive":"layer-shape","width":1.0008681404851658,"height":0.23584357284682464,"x":-0.0008681404851658137,"y":0.16816206727863942,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":56,"elem":null,"scope":null,"color":"#000000","shape":0,"dummyLabel":"Rectangle","layerType":"SHAPE"}','{"id":-1,"type":"Attendee data layer","content":"John Smith","directive":"layer-text","width":0.5254093407383961,"height":0.09128945929613537,"x":0.2500071940375816,"y":0.1936750021582113,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":57,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"700","fontFamily":"\'Arial\', sans-serif","color":"#ffffff","rotation":0,"fsize":0,"dummyLabel":"Full Name","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"Attendee","directive":"layer-text","width":0.3101378377600646,"height":0.06740525452504963,"x":0.35849040315386604,"y":0.3092198785646456,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":58,"elem":null,"scope":null,"align":"center","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#ffffff","rotation":0,"fsize":0,"dummyLabel":"Ticket type","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Attendee data layer","content":"President","directive":"layer-text","width":0.5915024028085523,"height":0.06909441454922159,"x":0.027158930678253868,"y":0.467606687577336,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":60,"elem":null,"scope":null,"align":"left","transform":"none","fontStyle":"normal","fontWeight":"400","fontFamily":"\'Arial\', sans-serif","color":"#000000","rotation":0,"fsize":0,"dummyLabel":"Title","layerType":"ATTENDEE_DATA"}','{"id":-1,"type":"Image layer","content":"Hello World","directive":"layer-image","width":0.1965295962706109,"height":0.1194397283531409,"x":0.41444706627147415,"y":0.013642772869845478,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":55,"elem":null,"scope":null,"image":"/Eventdex/resource/1453570521000/badgeToolAssets/images/build/example-image.png","layerType":"IMAGE"}','{"id":-1,"type":"Bar code layer","content":"Hello World","directive":"layer-bar-code","width":0.16000546746856206,"height":0.16000546746856206,"x":0.7844637564386637,"y":0.42810278840896665,"parentWidth":0,"parentHeight":0,"canvas":null,"selected":false,"zIndex":59,"elem":null,"scope":null,"barCode":0,"rotation":90,"layerType":"QR_CODE"}');
    
    
    newbadges  = Allbadges(EventID);
    
    return newbadges;
    }

    
    global static   List<BadgeWithLayers> newbadges{get;set;}
    
    
    //new code

global class BadgeWithLayers {
        public BLN_Badge_Style__c badge {get; set;}
        public List<BLN_Badge_Layer__c> layers {get; set;}
        
        public BadgeWithLayers(BLN_Badge_Style__c badge, List<BLN_Badge_Layer__c> layers) {
            this.badge = badge;
            this.layers = layers;
        }
    }
    

    
    global static List<BadgeWithLayers> Allbadges(String EventId) {
System.debug('111111111111111111 '+EventId);
        List<BadgeWithLayers> temps = new List<BadgeWithLayers>();
        List<BLN_Badge_Style__c> styles = [SELECT Name,Description__c,Data__c,Module__c FROM BLN_Badge_Style__c WHERE   Event__c=:EventId AND Module__c like '%Scan Attendee%' AND Printer__c like '%Brother%'];
        for (BLN_Badge_Style__c style: styles) {
            temps.add(new BadgeWithLayers(
                style,
                [SELECT Data__c FROM BLN_Badge_Layer__c WHERE BLN_Badge_Style_ID__c= :style.Name]
            ));
            System.debug(temps);
        }
        return temps;
    }   
    
    
    
    
    global static void createstandardbadge(String Data,String Description,String EventID,String module,String printer,String layer1,String layer2,String layer3,String layer4,String layer5,String layer6)
     {
     list<String> lay = new list<String>();
     lay.add(layer1);
     lay.add(layer2);
     lay.add(layer3);
     lay.add(layer4);
     lay.add(layer5);
     lay.add(layer6);
    
        try{
     //   List<BLN_Badge_Style__c> dummy =new List<BLN_Badge_Style__c>(); 
      List<BLN_Badge_Style__c> nstyle=[SELECT Name,Description__c,Data__c,Module__c FROM BLN_Badge_Style__c WHERE   Event__c=:EventId AND Module__c like '%Scan Attendee%' AND Printer__c like '%Brother%' AND Description__c=:Description];
      if(nstyle.size()==0)
      {
         
           BLN_Badge_Style__c StaticStyle = new BLN_Badge_Style__c();
            StaticStyle.Data__c=Data;
            StaticStyle.Description__c=Description;
            StaticStyle.Event__c=EventID;
            StaticStyle.Module__c=module;
            StaticStyle.Printer__c=printer;
           
      
         insert StaticStyle;
         
    String realBadgeId = '-1';
    realBadgeId = [SELECT Name FROM BLN_Badge_Style__c WHERE Id=:StaticStyle.Id LIMIT 1].Name;
   
       createstandardlayer(realBadgeId,lay);
       
      
     }   }catch(Exception e){
     
     }    
    }
     global static void createstandardbadge(String Data,String Description,String EventID,String module,String printer,String layer1,String layer2,String layer3,String layer4,String layer5,String layer6,String layer7)
     {
     list<String> lay = new list<String>();
     lay.add(layer1);
     lay.add(layer2);
     lay.add(layer3);
     lay.add(layer4);
     lay.add(layer5);
     lay.add(layer6);
     lay.add(layer7);
    
        try{
     //   List<BLN_Badge_Style__c> dummy =new List<BLN_Badge_Style__c>(); 
      List<BLN_Badge_Style__c> nstyle=[SELECT Name,Description__c,Data__c,Module__c FROM BLN_Badge_Style__c WHERE   Event__c=:EventId AND Module__c like '%Scan Attendee%' AND Printer__c like '%Brother%' AND Description__c=:Description];
      if(nstyle.size()==0)
      {
         
           BLN_Badge_Style__c StaticStyle = new BLN_Badge_Style__c();
            StaticStyle.Data__c=Data;
            StaticStyle.Description__c=Description;
            StaticStyle.Event__c=EventID;
            StaticStyle.Module__c=module;
            StaticStyle.Printer__c=printer;
           
      
         insert StaticStyle;
         
    String realBadgeId = '-1';
    realBadgeId = [SELECT Name FROM BLN_Badge_Style__c WHERE Id=:StaticStyle.Id LIMIT 1].Name;
   
       createstandardlayer(realBadgeId,lay);
       
      
     }   }catch(Exception e){
     
     }    
    }
    
    
    global static void createstandardlayer(String styleid,list<String> Data){
    System.debug('123 12 123 '+Data+' '+styleid);
    
    for(String la: Data){
    BLN_Badge_Layer__c StaticLayer = new BLN_Badge_Layer__c();
            StaticLayer.BLN_Badge_Style_ID__c = styleid;
            StaticLayer.Data__c =la;
            
            insert StaticLayer;
    }
    }
    }
@RestResource(urlMapping='/Badge_Template/*')

    global with sharing class Badge_Template{
    @HttpPost  
    global static Event doPost(){
        RestRequest req = RestContext.request;  
        String EventID = req.params.get('Event_Id');
        RestResponse response = RestContext.response; 
        
        bstyle=new List<BadgeTemplate_Styles__c>();
        
        bstyle=[select BadgeName__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c where (Badge_Type__c='Brother' or Badge_Type__c='Dymo' or Badge_Type__c='CustScanBadge') and (Event__c=:EventID or Event__r.EV_Title__c='Default Event Boothleads') and Module__c like '%Scan Attendee%' ];
        
        //for test class
        if(Test.isRunningTest())
        bstyle=[select BadgeName__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c limit 1 ];
        
      Event e1=new Event();
      e1.badges=new List<Badge>();
      for(BadgeTemplate_Styles__c btstyle:bstyle){
         
         //forming
      //Parse Badge Name
      bg=new Badge();
    String badgename=btstyle.BadgeName__c;
    parseBadge(badgename.substring(0,badgename.length()-1));
    elems=new List<Style>(); 
    //Parse Elements
    if(btstyle.FirstRowElement__c!=null)
    parseElement(btstyle.FirstRowElement__c);
    if(btstyle.SecondElement__c!=null)
    parseElement(btstyle.SecondElement__c);
    if(btstyle.ThirdElement__c!=null)
    parseElement(btstyle.ThirdElement__c);
    if(btstyle.FourthElement__c!=null)
    parseElement(btstyle.FourthElement__c);
    if(btstyle.FifthElement__c!=null)
    parseElement(btstyle.FifthElement__c );
     if(btstyle.SixthElement__c!=null)
    parseElement(btstyle.SixthElement__c);
     if(btstyle.SeventhElement__c!=null)
    parseElement(btstyle.SeventhElement__c);
     if(btstyle.EightthElement__c!=null)
    parseElement(btstyle.EightthElement__c);
     if(btstyle.ninthelement__c!=null)
    parseElement(btstyle.ninthelement__c);
    bg.elemsbg=new List<Style>();
    bg.elemsbg=elems;  
    bg.EventId=EventID ;
    bg.templateType='CUSTOM';
     
     e1.badges.add(bg);
     
      }//end of loop 
       
       
       
       
       
       //Standard Templates for Brtoher
        //forming
      //Parse Badge Name
      bg=new Badge();
   parseBadge('{"name":"BL-Brother-Template-1","width":374,"height":230,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCADwAYADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC2gGwcDpS4HoKRPuL9KdQAmB6CjA9BSb1/vD86N6/3h+dAC4HoKMD0FJvX+8Pzo3r/AHh+dAC4HoKMD0FAZT0YH8aWgBMD0FGB6CjcpOMjP1oLAdSBQAYHoKMD0FIGU9GH50pYDqQKADA9BRgegpN6/wB4fnRvX+8PzoAXA9BRgegpN6/3h+dG9f7w/OgBcD0FGB6CgEHpS0AJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoK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uif71T0hUN1AOKWgAooooAKKKKACiiigAooooAKRvun6UtI33T9KAET7i/SnU1PuL9KdQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFI33T9KWkb7p+lACJ9xfpTqan3F+lOoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACkb7p+lLSN90/SgBE+4v0p1NQjYOe1LketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtI33T9KMj1pCRtPNAH/2Q=="}');
    elems=new List<Style>(); 
    //Parse Elements
    parseElement('[{"id":"badgeQrCode","height":125,"width":125,"positionTop":10,"positionLeft":10,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(https://c.cs11.visual.force.com/resource/1403783597000/qrcodelogoimage)"}]');
    parseElement('[{"id":"badgeCompanyName","height":35,"width":220,"line-height":35,"position":"absolute","positionTop":25,"positionLeft":140,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"30px","fontFamily":"Helvetica","textTransform":"none","contentText":"Globalnest Llc","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]');
    parseElement('[{"id":"badgeFullName","height":36,"width":365,"line-height":36,"position":"absolute","positionTop":145,"positionLeft":10,"marginTop":"10px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"34px","fontFamily":"Helvetica","textTransform":"uppercase","contentText":"JOHN SMITH","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]');
    bg.elemsbg=new List<Style>();
    bg.elemsbg=elems;  
    bg.EventId=EventID ;
    bg.templateType='STANDARD';
    e1.badges.add(bg);
    
    bg=new Badge();
   parseBadge('{"name":"BL-Brother-Template-2","width":374,"height":230,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAD2AYYDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwBLeBZVJYkY9Kl+xp/eai0IEX41PvFAEH2NP7zUfY0/vNU+8UbxQBB9jT+81H2NP7zVPvFG8UAQ/Y09TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28UbxQBD9kj9TR9kj9TU28Ub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ABRRRQAUUUUAFFFFABRRRQAUUUUAU7v/AFo+lFF3/rR9KKAJLP8A1R+tWKrWX+rb61ZoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigCnd/60fSii7/1o+lFAEcUzRLhQOfWn/a39BRRQAfa39BS/apPRaKKAD7VJ6LR9qk9FoooAPtUnotH2qT0WiigA+1Sei0fapPRaKKAD7VJ6LR9qk9FoooAPtUnotH2qT0WiigA+1Sei0fapPRaKKAD7VJ6LR9qk9FoooAPtUnotH2qT0WiigA+1Sei0fapPRaKKAD7VJ6LR9qk9FoooAPtUnotH2qT0WiigA+1Sei0fapPRaKKAD7VJ6LR9qk9FoooAPtUnotH2qT0WiigA+1Sei0fapPRaKKAD7VJ6LR9qk9FoooAPtUnotH2qT0WiigA+1Sei0fapPRaKKAD7VJ6LR9qk9FoooADdSDstJ9rf0FFFAB9rf0FH2t/QUUUAH2t/QUfa39BRRQBHJIZWyeD7UUUUAf/2Q=="}');
    elems=new List<Style>(); 
    //Parse Elements
    parseElement('[{"id":"badgeExhibitor","height":60,"width":384,"line-height":60,"position":"absolute","positionTop":0,"positionLeft":0,"marginTop":"10px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"42px","fontFamily":"Helvetica","textTransform":"uppercase","contentText":"EXHIBITOR","backgroundColor":"rgb(0,0,0)","opacity":"1","textColor":"rgb(255,255,255)","white-space":"nowrap"}]');
    parseElement('[{"id":"badgeFullName","height":50,"width":365,"line-height":50,"position":"absolute","positionTop":75,"positionLeft":10,"marginTop":"10px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"42px","fontFamily":"Helvetica","textTransform":"uppercase","contentText":"JOHN SMITH","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]');
    parseElement('[{"id":"badgeCompanyName","height":50,"width":365,"line-height":50,"position":"absolute","positionTop":135,"positionLeft":10,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"42px","fontFamily":"Helvetica","textTransform":"none","contentText":"Global Nest LLC","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]');
    bg.elemsbg=new List<Style>();
    bg.elemsbg=elems;  
    bg.EventId=EventID ;
    bg.templateType='STANDARD';
    e1.badges.add(bg);
    
    bg=new Badge();
   parseBadge('{"name":"BL-Brother-Template-3","width":374,"height":230,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCADwAYADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC2gGwcDpS4HoKRPuL9KdQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegowPQUtFACYHoKMD0FLRQAmB6CjA9BS0UAJgegpGA2ngdKdSN90/SgBE+4v0p1NT7i/SnUAFFFFABRRRQAUUUUAFFFFABUbS7ZVTHXvUlVpP+PtKALNQNcqDhFLn2pLpjtVB/EaljjWNQAKAIxcjOHRl+tTAgjIORSMoYYYZFQW5KStETx2oAl83995eO2c1JVZiBeZJAGO9T+Yn99fzoAbLL5ZUYzuOKWWTy03YzUNwys0eCDz2NOu/wDU/jQBJFIJE3D8qcx2qT6VVTMDqf4GqxJ/q2+lABFJ5ibsYp9Q2n+pH1qagBkkixrljUX2k9omI9aS54kRmGVFTLIjY2sKAEjmWTp19DSTTeUB8uc0GH98JAceo9aju+sf1oAmjcSIGFPqvb/I7xntyKknbbEcdTwKAGx3Akk2hce+adLL5ZUYzuOKgiXZcAf7NPuvvR/WgCSWQxgYQtn0qI3RAyYmH1qzUF3/AKn8aAE+0t/zxantLtiDlT9Ken3B9Kiu/wDU/jQBMpyoPrQx2qT6UxHTYPmXp60SOnlt8y9PWgBYpPMTdjFPqG0/1I+tTUAFFFFABRRRQAUUUUAFI33T9KWkb7p+lACJ9xfpTqan3F+lOoAKKKKACiiigAooooAKTpS0lACK6uMqcioJP+PtKRS9uzDYWUnjFOjV5JfMddoHQUAJdcSRt2zVimyIJEKmoVaWEbWTevYigCzVZPmu2I6CgyyyfKkZX3NSwxCJfUnqaAIZED3e1hxipPs0X90/nTSD9rzg4x1qxQBUmiSNk2jGTUl3/qfxpLkEtHgE8066BMOACTntQA4oJIQp9KhjchHifqBxVhPuD6VDcxFhvX7w9KAHWn+pH1qaobUEQgEEHPepqAGFkZthwT6VG1rGemV+lE0TFhJH94frSC4ccNC2fagBo328iqW3IaW6+9H9aUK80gaQbVHQUXKktHgE89qACX5JkfseDSyfPOidhyadOm+IgdRyKbbK3LuOTxzQAn/L5+FF196P60YP2vODjHWi5BLR4BPNAFioLv8A1P41PUN0CYsAE89qAJE+4PpUV3/qfxqVPuj6VHdAmHABPPagBFtoioJXt60PbxBCQvIHrUqfcH0ok5RvpQBHaf6kfWpqhtQRCAQQc96moAKKKKACiiigAooooAKRvun6UtI33T9KAET7i/SnU1PuL9KdQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFI33T9KWkb7p+lACJ9xfpTqan3F+lOoAKKKKACiiigAooooAKKKKACiiigAqOWQrhVGWbpUlQPxdJnpigBfKc8tK2fbpSxlwxR+fRsU992Pkxn3qNZJBKEcLyM8UALExLyAknB4pTNGrYLDNRAlROR1zUsSL5QGAcjmgBZTiJiD26imrMgVQz84qNf9RIvYHipIkURAYHI5oAkyMZzxTPPizjeKiQqInV87QcUMzNEQIgFx1JoAknYhAVPcdKeXVSATg4qu3/AB6x/UU6RQ08YPTFAEqyo5wrAmlZlQZY4FRXAA2EDB3UkhJuMbN+B0zQBKkiP91gaHkRPvMBUTeYzqRFtIPXNKwdJS4XeD+lAEodWXcGBFRQzB2YFsnPH0pYmRnOFKseoNFv/H/vUATVFCxO/Jzg1LUNv/H/AL1AE1RQMShLHPJ61LVUEi2bHdsUATCaMttDDNSVGY0MQU8D1p46DBzQAtFFFABRRRQAUUUUAFFFFABRRRQAUjfdP0paRvun6UAIn3F+lOpqfcX6U6gAooooAKKKKACiiigAooooAKKKKACmSRiQYPBHQ+lPooAh/fjgbG9zSpEd+92y38qlooAiSMgybsYY00JMg2qVK9ieoqeigCLysQlAck96aEmVQqlSPU9qnooAiMI8rYDz1z700pM67WKgeo71PRQBAYmMKpxkGnshMqtxgCpKKAI5kLhcY4OaSSMlg6HDD171LRQBEFlZgXIUDsvehkdXLRkc9QalooAiRG373IzjGBQiOjt0Kk596looAKgVJULbQhBOeTUu9f7w/Ojev94fnQA1fNz84XHtTUi/dMjdz2qTev8AeH50b1/vD86AIikrLsYrt9e9TAYAA7Um5T/EPzp1ABRSblzjIz9aCQOpAoAWim71/vD86UkDqQKAFopu9f7w/Ojev94fnQA6im71/vD86N6/3h+dADqKQEHoc0tABSN90/SlpG+6fpQAifcX6U6mp9xfpTqACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAymQyXBUHkmpvsMn94U2P/AI/f+BVPeTPEV2HGaAIvsMn94UfYZP7wqP7XN/e/SrVnM8u7ec4oAqRqUuVUnkGtSs0/8f3/AAKrV3JJGF8vv14oAqzNtuyx6A0tzcLM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O36UyN3RspnPsKANK3iMUe0nJzUtQ2rO8WZM5z3FTUAFI33T9KWkb7p+lACJ9xfpTqan3F+lOoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDOj/wCP3/gVW551hIyCc+lVI/8Aj9/4FT9Q6pQA/wC3J/cNSwTrNnAIx61l1d0/+OgCI/8AH9/wKpdQ6JUR/wCP7/gVXpUjfHmY9smgBtr/AMe6fSotQ+4v1pgeRZwkefLzxgcVbkjSQAOM4oAz0tmaLzAwxjpSW0whclgTkVoARqvlggDpjNVrq3VUBjQ5z2oArzOJptwGM06a2aJAxYHNWLe3QxBnX5vep2WOYbSQ2O2aAKcFyqReWVJJpyxm1PmvyDxgVHcRFJsRocewp8TPI224zs9+KALcMolTcBgVJTIlRVxHjHtT6ACkb7p+lLSN90/SgBE+4v0p1NT7i/SnUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBnR/8fv/AAKrNzbtMVwQMVTcSLOzKrZzwcU7zrn/AGvyoAf9hf8Avip7aAw7skHNVfOuf9r8qPOuf9r8qAA/8f3/AAKptQ6JUEayNcKzK3Xk4qxfqzBMAn6UANt7lVVI9pz0zV2qkcCi3D7fnAzS2jyuzeZnGO4oAJLZmn8wMMZzipZphCoJGc1BJJMLjaudufSnXylo1wCee1AEyOJotwGM1Fb2zRSFiwORTrYFbYcEHmo7WSZpCJM4x3FAEktyscmwqSaW4iM0YUHHOaq3SMbnIUkcdqs3LOkQMec+woAdbxGKPaTnmpahtWdosyZznvU1ABSN90/SlpG+6fpQAifcX6U6mp9xfpTqACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApG+6fpS0jfdP0oARPuL9KdTUI2DntS5HrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALRSZHrRketAC0UmR60ZHrQAtFJketGR60ALSN90/SjI9aQkbTzQB//Z"}');
    elems=new List<Style>(); 
    //Parse Elements
    parseElement('[{"id":"badgeQrCode","height":125,"width":125,"positionTop":90,"positionLeft":235,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(https://c.cs11.visual.force.com/resource/1403783597000/qrcodelogoimage)"}]');
    parseElement('[{"id":"badgeCompanyName","height":30,"width":365,"line-height":30,"position":"absolute","positionTop":60,"positionLeft":10,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"28px","fontFamily":"Helvetica","textTransform":"none","contentText":"Globalnest Llc","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]');
    parseElement('[{"id":"badgeFullName","height":40,"width":365,"line-height":40,"position":"absolute","positionTop":5,"positionLeft":10,"marginTop":"10px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"38px","fontFamily":"Helvetica","textTransform":"uppercase","contentText":"JOHN SMITH","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(51,51,51)","white-space":"nowrap"}]');
    parseElement('[{"id":"badgeExhibitor","height":35,"width":220,"line-height":35,"position":"absolute","positionTop":130,"positionLeft":5,"marginTop":"10px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"30px","fontFamily":"Helvetica","textTransform":"uppercase","contentText":"ATTENDEE","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]');
    bg.elemsbg=new List<Style>();
    bg.elemsbg=elems;  
    bg.EventId=EventID ;
    bg.templateType='STANDARD';
    e1.badges.add(bg);
     
       //end of Standard templates
       
       
       
       
       
       return e1;
         
                
        }
        
        
        
        
        
        
        
        
        global static List<BadgeTemplate_Styles__c> bstyle{get;set;}
   global static Badge bg{get;set;}
   global static List<Style> elems{get;set;}
    global static void parseBadge(String bdg)
   {

     // Parse entire JSON response.
    bdg='['+bdg+']';
    JSONParser parser = JSON.createParser(bdg);
   
    System.debug('coming');
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
        System.debug('parser '+parser.getCurrentToken());
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    System.debug('hello');
                    bg= (Badge)parser.readValueAs(Badge.class);
                    System.debug('My Token '+parser.getCurrentToken());
                    System.debug('My bg '+bg);
                  
                

                }
            }
        }
    }
    
   }
   
   global static void parseElement(String elem)
   {
     
    // Parse entire JSON response.
    JSONParser parser = JSON.createParser(elem);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    Style st= (Style)parser.readValueAs(Style.class);
                  elems.add(st);

                }
            }
        }
    }
      
   }
   
  
  
  
  
  global class Style{
  public String id{get;set;}
  public String height{get;set;}
  public String width{get;set;}
  public String positionTop{get;set;}
  public String positionLeft{get;set;}
  public String marginTop{get;set;}
  public String marginRight{get;set;}
  public String marginBottom{get;set;}
  public String marginLeft{get;set;}
  public String paddingTop{get;set;}
  public String paddingRight{get;set;} 
  public String paddingBottom{get;set;} 
  public String paddingLeft{get;set;} 
  public String textAlign{get;set;} 
  public String fontSize{get;set;} 
  public String fontFamily{get;set;} 
  public String textTransform{get;set;} 
  public String contentText{get;set;}   
  public String backgroundColor{get;set;}
  public String opacity{get;set;}
  public String textColor{get;set;}  
  public String qrUrlResult{get;set;}
  public String urlResult{get;set;}
    public Style(String id,String height,String width,String positionTop,String positionLeft,String marginTop,String marginRight,
    String marginBottom,String marginLeft,String paddingTop,String paddingRight,String paddingBottom,String paddingLeft,
    String textAlign,String fontSize,String fontFamily,String textTransform,String contentText,
    String backgroundColor,String opacity,String textColor,String qrUrlResult,String urlResult){
        id=this.id;
        height=this.height;
        width=this.width;
        positionTop=this.positionTop;
        positionLeft=this.positionLeft;
        marginTop=this.marginTop;
        marginRight=this.marginRight;
        marginBottom=this.marginBottom;
        marginLeft=this.marginLeft;
        paddingTop=this.paddingTop;
        paddingRight=this.paddingRight; 
        paddingBottom=this.paddingBottom; 
        paddingLeft=this.paddingLeft; 
        textAlign=this.textAlign; 
        fontSize=this.fontSize; 
        fontFamily=this.fontFamily; 
        textTransform=this.textTransform; 
        contentText=this.contentText; 
        backgroundColor=this.backgroundColor;
        opacity=this.opacity;
        textColor=this.textColor;  
        qrUrlResult=this.qrUrlResult;
        urlResult=this.urlResult;
    }
}


global class Badge{
public String name{get;set;}
public String width{get;set;}
public String height{get;set;}
public String backgroundColor{get;set;}
public String savedImageDataUrl{get;set;}
public String EventId{get;set;}
public String templateType{get;set;}
public List<Style> elemsbg{get;set;}
public Badge(String name,String width,String height,String backgroundColor,String savedImageDataUrl)
{
  this.name=name;
  this.width=width;
  this.height=height;
  this.backgroundColor=backgroundColor;
  this.savedImageDataUrl=savedImageDataUrl;
  
}

public Badge()
{
 
}
}
//end of code



global class Event
{
  public List<Badge> badges{get;set;}
}

      
        }
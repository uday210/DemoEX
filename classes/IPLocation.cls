public class IPLocation {
 
    String IP_LOOKUP_URL = 'http://ipinfodb.com/ip_query.php?&timezone=true&ip=';
    public String latitude {get; set;}
    public String longitude {get; set;}
    public List<Account> dataList {get; set;}
    public String xmlResponse {get; set;}
 
    public IPLocation(){
        findLocation();
    }
 
    public void findLocation(){
        //Get the users IP address
        String ipAddress = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        Boolean lookupLocation = true;
 
        /*First check to see if user has existing cookie with current IP address. Rather than 
        create 3 seperate cookies for IP, lat, and long I put these all in one cookie comma
        seperated: "245.547.54.45,45.4575,-124.4575" There is probably no advantage, it may 
        even make this more complicated but it at least demos a different way to use cookies*/
 
        //First check to see if cookie exists
        Map<String,Cookie> cookies = ApexPages.currentPage().getCookies();
        if(cookies.size() > 0){
            if(cookies.get('ipLocation') != null){ 
                List<String> cookieValues = cookies.get('ipLocation').getValue().split(',');
                //List will contain [IP Address, Latitude, Longitude]
 
                /*Check to see if user has the same IP address as the cookie. If same there
                is no need to look up the location again*/
                if(ipAddress == cookieValues[0]){
                    latitude = cookieValues[1];
                    longitude = cookieValues[2];
                    lookupLocation = false;
                }
            }
        }
 
        /*If there were no cookies found or the current user's IP address did not match 
        that of the cookie we need to look up location of users IP address */
        if(lookupLocation == true){
            //Build HTTP request
            //Instantiate a new http object
            Http h = new Http();
 
            //Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
            HttpRequest req = new HttpRequest();
            req.setEndpoint(IP_LOOKUP_URL + ipAddress);
            req.setMethod('GET');
 
            /*We are also setting a timeout, if we are doing this callout on page load we don't want 
            this to prevent page from loading if IP server is down*/
            req.setTimeout(3000);
 
            //Send the request / call webservice
            HttpResponse res;
            Boolean calloutSuccess = true;
            try{
                res = h.send(req);
            }catch(Exception e){
                //Ghetto error handling but better than nothing
                calloutSuccess = false;
            }
 
            if(calloutSuccess == true){
                //Inspect the response, use the XmlStreamReader so we don't have to parse response
                xmlResponse = res.getBody();
                XmlStreamReader reader = res.getXmlStreamReader();
                Map<String,String> responseValues = new Map<String,String>();
 
                try{
                    while(reader.hasNext()) {
                        System.debug('Event Type:' + reader.getEventType());
                        if(reader.getEventType() == XmlTag.START_ELEMENT) {
                            String key = reader.getLocalName();
                            reader.next();
                            if(reader.getEventType() == XmlTag.CHARACTERS){
                                responseValues.put(key,reader.getText());
                            }
                        }
                        reader.next();
                    }
                }catch(exception e){
                    system.debug(e.getMessage());
                }
 
                //Set the latitude and longitude   
                latitude = responseValues.get('Latitude');// '47.482877';
                longitude = responseValues.get('Longitude');// '-122.217066';
 
                /*Next we want to create a cookies so we dont have to make unecessary callouts
                in the future*/
 
                List<Cookie> newCookies = new List<Cookie>();
                newCookies.add(new Cookie('ipLocation',ipAddress+','+latitude+','+longitude,null,15552000,false));
                ApexPages.currentPage().setCookies(newCookies);
 
                //Populate dataList, simply to output webservice values on the page
                dataList = new List<Account>();
                for(String s : responseValues.keySet()){
                    Account a = new Account();
                    a.Name = s;
                    a.Site = responseValues.get(s);
                    dataList.add(a);
                }
            }
        }
    }
}
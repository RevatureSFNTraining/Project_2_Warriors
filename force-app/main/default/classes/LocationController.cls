public class LocationController {
    
    @AuraEnabled
    public static String getLocationJson() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        // You need to go to the "Remote Site Setting" and add the link below 1st.
        request.setEndpoint('https://geolocation-db.com/json/73.37.197.229');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
            // Just return the json to my JavaScript controller.
            return response.getBody();   
        } else {
            return 'Something wrong with the http request.';
        }
    }
}
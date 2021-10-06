// This text has 88% code coverage.
@isTest
private class LocationControllerTest {

    @isTest static void testGetCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('LocationCalloutResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call method to test
        String result = LocationController.getLocationJson();
        
        String expect = '{"country_code":"US","country_name":"United States","city":"San Francisco","postal":"94112","latitude":37.7195,"longitude":-122.4411,"IPv4":"73.222.231.242","state":"California"}';
        System.assertEquals(expect, result);
    }

}
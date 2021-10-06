@isTest
private class DisplayCarListTest {
    @isTest
    static void posSingleTest() {
        Vehicle__c testCar = new Vehicle__c(Name = 'CarTest', Vehicle_Type__c = 'Car', Vehicle_Year__c = 2020, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camary', Status__c = 'Checked In', Description__c = 'Description');
        List<Vehicle__c> testCarList = new List<Vehicle__c>();
        testCarList = DisplayCarList.fetchVehicleRecords();
        System.assertEquals(1, testCarList.size());


    }
}

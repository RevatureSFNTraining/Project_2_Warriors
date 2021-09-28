/*
 * ContactTrigger
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Unit test class for the vehicle trigger.
 */

 @isTest
private class VehicleTriggerTest {
    
    @TestSetup
    static void makeData(){
        TestData.createTestData();
    }

    @isTest static void addVehicleTest() {
        Vehicle__c newVehicle = new Vehicle__c(Name = 'Toyota Camry 2020 Black', Vehicle_Identification_Number__c = 'FAKE1252211234211255', Base_Rental_Rate__c = 42.61, Vehicle_Year__c = 2020, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camry');
        insert newVehicle;
    }

    @isTest static void manualCheckInTest() {

        try {
            List<Vehicle__c> vehicles = [SELECT Status__c FROM Vehicle__c WHERE Status__c = 'Checked Out'];
            vehicles[0].Status__c = 'Checked In';
            update vehicles[0];

            System.assert(false, 'Was able to somehow change the vehicle status while it was checked out. Perhaps there was no active rental contract associated with it?');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot change status of vehicle while contract is still active: '));
        }
    }

    @isTest static void manualCheckOutTest() {
        try {
            List<Vehicle__c> vehicles = [SELECT Status__c FROM Vehicle__c WHERE Status__c != 'Checked Out'];
            vehicles[0].Status__c = 'Checked Out';
            update vehicles[0];

            System.assert(false, 'Was able to somehow manually check out a vehicle without forming a contract...');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot manually check out vehicles. Please form a rental contract.'));
        }
    }

    @isTest static void manualStationTest() {
        try {
            List<Vehicle__c> vehicles = [SELECT Status__c FROM Vehicle__c WHERE Status__c = 'Checked Out'];
            Depot__c depot = [SELECT Id FROM Depot__c LIMIT 1];
            vehicles[0].Stationed_Depot__c = depot.Id;
            update vehicles[0];

            System.assert(false, 'Was able to station a checked out vehicle to a depot.');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot station a checked out vehicle to a depot.'));
        }
    }
}
/*
 * ContactTrigger
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Contains initial test data shared by all test classes.
 */

 @isTest
public class TestData {
    
    //Made private and added @TestVisible annotation so only test methods can access it.
    @TestVisible
    private static void createTestData() {
        List<sObject> initialDB = new List<sObject>();
        List<sObject> depotDB = new List<sObject>();

        //Account
        initialDB.add(new Account(Name = 'Test Company'));

        //Contacts
        initialDB.add(new Contact(FirstName = 'Ben', LastName = 'Steward', Birthdate = Date.newInstance(1980, 2, 16), Email = 'some@email.com'));
        initialDB.add(new Contact(FirstName = 'John', LastName = 'Warner', Birthdate = Date.newInstance(1967, 6, 2), Email = 'the@email.com'));
        initialDB.add(new Contact(FirstName = 'Bob', LastName = 'Builder', Birthdate = Date.newInstance(1977, 10, 24), Email = 'bob@email.com'));
        initialDB.add(new Contact(FirstName = 'Billy', LastName = 'Bob', Birthdate = Date.newInstance(1998, 3, 14), Email = 'billy@email.com'));
        initialDB.add(new Contact(FirstName = 'Jane', LastName = 'Steward', Birthdate = Date.newInstance(1982, 4, 30), Email = 'some1@email.com'));

        //Vehicles
        initialDB.add(new Vehicle__c(Name = 'Toyota Camry 2019 Black', Vehicle_Identification_Number__c = 'FAKE1252211242211255', Base_Rental_Rate__c = 40.28, Vehicle_Year__c = 2019, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camry'));
        initialDB.add(new Vehicle__c(Name = 'Honda CRV 2019 Silver', Vehicle_Identification_Number__c = 'FAKE1252218653263121', Base_Rental_Rate__c = 43.28, Vehicle_Year__c = 2019, Vehicle_Make__c = 'Honda', Vehicle_Model__c = 'CRV'));
        initialDB.add(new Vehicle__c(Name = 'Lexus ES350 2022 Red', Vehicle_Identification_Number__c = 'FAKE1252283324562268', Base_Rental_Rate__c = 67.39, Vehicle_Year__c = 2022, Vehicle_Make__c = 'Lexus', Vehicle_Model__c = 'ES350'));
        initialDB.add(new Vehicle__c(Name = 'Toyota Camry 2019 Black', Vehicle_Identification_Number__c = 'FAKE1252285323767642', Base_Rental_Rate__c = 40.28, Vehicle_Year__c = 2019, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camry'));

        //Insert initalDB and grab account first since depots require Account id.
        //Will need lists of contacts and vehicles first for rental contracts later.
        insert initialDB;
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test Company'];
        List<Contact> customers = [SELECT Id FROM Contact];
        List<Vehicle__c> vehicles = [SELECT Id, Status__c FROM Vehicle__c];

        //Depots
        depotDB.add(new Depot__c(Name = 'Test Company Orlando', Owner__c = acc.Id, Address__c = '123 Sesame Street, Orlando FL 32715'));
        depotDB.add(new Depot__c(Name = 'Test Company Ontario', Owner__c = acc.Id, Address__c = '456 Fake Street, Ontario CA 94316'));

        //Insert data and grab depot data since it is required for rental contracts.
        insert depotDB;
        List<Depot__c> depots = [SELECT Id FROM Depot__c];

        //Rental Contract
        Rental_Contract__c testContract = new Rental_Contract__c(Company__c = acc.Id, Customer__c = customers[0].Id, Vehicle__c = vehicles[0].Id, Issuing_Depot__c = depots[0].Id, Expected_Return_Date__c = Date.today().addDays(7));

        insert testContract;
    }
}
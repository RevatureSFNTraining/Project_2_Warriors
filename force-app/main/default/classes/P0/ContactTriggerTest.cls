/*
 * ContactTriggerTest
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Unit test class for the Contact trigger.
 */

@isTest
private class ContactTriggerTest {

    @TestSetup
    static void makeData() {
        TestData.createTestData();
    }

    @isTest static void ageVerifyTest() {
        List<Contact> customers = [SELECT Birthdate FROM Contact];
        Map<Id, boolean> customerLegalAgeCheckMap = ContactTriggerHandler.verifyAges(customers);
        for (boolean isLegalAge : customerLegalAgeCheckMap.values()) {
            System.assert(isLegalAge);
        }
    }

    @isTest static void ageChangeTest() {
        try {
            Contact someCustomer = [SELECT BirthDate FROM Contact LIMIT 1];
            someCustomer.BirthDate = Date.today().addYears(-15); //Exactly 15 years old.
            update someCustomer;

            System.assert(false, 'Customer was somehow able to register at under the legal age of 21.');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Customer is not 21 years of age or above.'));
        }

    }

    @isTest static void insertTest() {
        List<Contact> customers = new List<Contact>();
        customers.add(new Contact(FirstName = 'Ronald', LastName = 'McDonald', Birthdate = Date.newInstance(1940, 5, 15), Email = 'ronald@mcdonalds.com'));
        customers.add(new Contact(FirstName = 'Burger', LastName = 'King', Birthdate = Date.newInstance(1954, 6, 2), Email = 'bk@burgerking.com'));
        customers.add(new Contact(FirstName = 'Wendy', LastName = 'Wendy', Birthdate = Date.newInstance(1969, 11, 15), Email = 'wendy@wendys.com'));
        insert customers;

        List<Contact> customerDB = [SELECT FirstName, LastName FROM Contact];
        for (Contact customer : customerDB) {
            switch on customer.FirstName {
                when 'Ronald' {
                    System.assertEquals('Ronald', customer.FirstName);
                    System.assertEquals('McDonald', customer.LastName);
                }
                when 'Burger' {
                    System.assertEquals('Burger', customer.FirstName);
                    System.assertEquals('King', customer.LastName);
                }
                when 'Wendy' {
                    System.assertEquals('Wendy', customer.FirstName);
                    System.assertEquals('Wendy', customer.LastName);
                }
            }
        }
    }

    @isTest static void underageCustomerTest() {
        try {
            Contact underagedCustomer = new Contact(FirstName = 'Fred', LastName = 'Parker', Birthdate = Date.newInstance(2000, 10, 2), Email = 'badstudent@someschool.edu'); //Just under 21 years old.
            insert underagedCustomer;

            System.assert(false, 'This customer is not underaged.');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Customer is not 21 years of age or above.'));
        }
    }

    @isTest static void duplicateEmailTest() {
        try {
            List<Contact> newCustomers = new List<Contact>();
            newCustomers.add(new Contact(FirstName = 'Caroline', LastName = 'Baker', Birthdate = Date.newInstance(1971, 11, 5), Email = 'caroline@bakersbakery.com'));
            newCustomers.add(new Contact(FirstName = 'Non-suspicious', LastName = 'Person', Birthdate = Date.newInstance(1975, 10, 9), Email = 'some@email.com'));
            newCustomers.add(new Contact(FirstName = 'Luigi', LastName = 'Bertoli', Birthdate = Date.newInstance(1957, 3, 14), Email = 'management@luigispizza.com'));
            insert newCustomers;

            System.assert(false, 'No duplicate emails somehow...');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('A contact with this e-mail already exists.'));
        }
    }
}
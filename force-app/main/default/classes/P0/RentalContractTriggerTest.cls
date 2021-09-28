/*
 * ContactTrigger
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Unit test class for the Rental Contract trigger.
 */

 @isTest
private class RentalContractTriggerTest {
    
    @TestSetup
    static void makeData(){
        TestData.createTestData();
    }

    @isTest static void overdueTest() {
        try {
            //Fetch current active contract and manually set it to 'Overdue'.
            Rental_Contract__c rentalContract = [SELECT Company__c, Customer__c, Status__c FROM Rental_Contract__c LIMIT 1];
            rentalContract.Status__c = 'Overdue';
            update rentalContract;

            //Attempt to create a new contract with an existing overdue contract. We will need to fetch a standby vehicle and depot first.
            Vehicle__c readyVehicle = [SELECT Id FROM Vehicle__c WHERE Status__c = 'Checked In' LIMIT 1];
            Depot__c someDepot = [SELECT Id FROM Depot__c LIMIT 1];
            Rental_Contract__c newContract = new Rental_Contract__c(Company__c = rentalContract.Company__c, Customer__c = rentalContract.Customer__c, Vehicle__c = readyVehicle.Id, Issuing_Depot__c = someDepot.Id, Expected_Return_Date__c = Date.today().addDays(1));
            insert newContract;

            System.assert(false, 'Was able to create a new contract for a customer with an overdue contract somehow');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Customer has an overdue contract. Please resolve this before creating a new contract.'));
        }
    }

    @isTest static void bulkContractTest() {
        //Fetch data first.
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Contact> customers = [SELECT Id FROM Contact];
        List<Depot__c> depots = [SELECT Id FROM Depot__c];
        List<Vehicle__c> availableVehicles = [SELECT Id, Name FROM Vehicle__c WHERE Status__c = 'Checked In'];

        List<Rental_Contract__c> newContracts = new List<Rental_Contract__c>();
        for (Vehicle__c vehicle : availableVehicles) {
            Contact randomCustomer = customers[(integer) (Math.random() * customers.size())];
            Depot__c randomDepot = depots[(integer) (Math.random() * depots.size())];

            newContracts.add(new Rental_Contract__c(Company__c = acc.Id, Customer__c = randomCustomer.Id, Vehicle__c = vehicle.Id, Issuing_Depot__c = randomDepot.Id, Expected_Return_Date__c = Date.today().addDays(3)));
        }
        insert newContracts;

        integer numInsertedContracts = [SELECT COUNT() FROM Rental_Contract__c WHERE Name LIKE 'New Contract %'];
        System.assertEquals(3, numInsertedContracts);
    }

    @isTest static void checkOutRentedVehicleTest() {
        try {
            Map<string, sObject> requiredFields = getRequiredInstances(true);

            Rental_Contract__c newContract = new Rental_Contract__c(Company__c = requiredFields.get('Account').Id, Customer__c = requiredFields.get('Customer').Id, Vehicle__c = requiredFields.get('Vehicle').Id, Issuing_Depot__c = requiredFields.get('Depot').Id, Expected_Return_Date__c = Date.today().addDays(3));
            insert newContract;

            System.assert(false, 'Was somehow able to form a contract for a vehicle that was already checked out...');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Vehicle is not available for checking out.'));
        }
    }

    @isTest static void beginLaterTest() {
        try {
            Map<string, sObject> requiredFields = getRequiredInstances(false);

            Rental_Contract__c newContract = new Rental_Contract__c(Company__c = requiredFields.get('Account').Id, Customer__c = requiredFields.get('Customer').Id, Vehicle__c = requiredFields.get('Vehicle').Id, Issuing_Depot__c = requiredFields.get('Depot').Id, Issue_Date__c = Date.today().addDays(1), Expected_Return_Date__c = Date.today().addDays(3));

            insert newContract;

            System.assert(false, 'Formed a contract that begins at a later date');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot issue a contract that starts at a later date than today.'));
        }
    }

    @isTest static void deadlineBeforeIssueDateTest() {
        try {
            Map<string, sObject> requiredFields = getRequiredInstances(false);

            Rental_Contract__c newContract = new Rental_Contract__c(Company__c = requiredFields.get('Account').Id, Customer__c = requiredFields.get('Customer').Id, Vehicle__c = requiredFields.get('Vehicle').Id, Issuing_Depot__c = requiredFields.get('Depot').Id, Expected_Return_Date__c = Date.today().addDays(-1));

            insert newContract;

            System.assert(false, 'This contract\'s due date takes place before the issue date. Get your time machines ready!');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot issue a contract with an expected return date earlier than or at the issue date.'));
        }
    }

    @isTest static void postponeTest() {
        Rental_Contract__c currentContract = [SELECT Expected_Return_Date__c FROM Rental_Contract__c WHERE Status__c = 'Active' LIMIT 1];
        Date currentDeadline = currentContract.Expected_Return_Date__c;
        currentContract.Expected_Return_Date__c = currentDeadline.addDays(3);
        update currentContract;

        try {
            currentContract.Expected_Return_Date__c = currentDeadline;
            update currentContract;

            System.assert(false, 'Was somehow able to set the deadline earlier than promised... The customer will not be happy.');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot set the expected return date earlier than the current deadline: '));
        }
    }

    @isTest static void returnVehicleTest() {
        Rental_Contract__c currentContract = [SELECT Issue_Date__c, Actual_Return_Date__c FROM Rental_Contract__c WHERE Status__c = 'Active' LIMIT 1];
        currentContract.Actual_Return_Date__c = Date.today();
        update currentContract;

        currentContract.Actual_Return_Date__c = currentContract.Issue_Date__c;
        update currentContract;

        try {
            currentContract.Actual_Return_Date__c = currentContract.Issue_Date__c.addDays(-1);
            update currentContract;

            System.assert(false, 'Vehicle was somehow returned before the issue date');
        }
        catch (DMLException e) {
            System.assert(e.getMessage().contains('Return date cannot occur before the issue date.'));
        }
    }

    @TestVisible
    private static Map<string, sObject> getRequiredInstances(boolean isCheckedOut) {
        Map<string, sObject> requiredFields = new Map<string, sObject>();
        requiredFields.put('Account', [SELECT Id FROM Account LIMIT 1]);
        requiredFields.put('Customer', [SELECT Id FROM Contact LIMIT 1]);
        requiredFields.put('Depot', [SELECT Id FROM Depot__c LIMIT 1]);
        if (isCheckedOut)
            requiredFields.put('Vehicle', [SELECT Id FROM Vehicle__c WHERE Status__c = 'Checked Out' LIMIT 1]);
        else
            requiredFields.put('Vehicle', [SELECT Id FROM Vehicle__c WHERE Status__c = 'Checked In' LIMIT 1]);
        return requiredFields;
    }
}
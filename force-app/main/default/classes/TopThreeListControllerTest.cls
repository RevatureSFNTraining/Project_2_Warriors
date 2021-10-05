// This this has 75% code coverage.
@isTest
private class TopThreeListControllerTest {
    
    @isTest static void Test1() {
        // ------------- Test Data Setup ------------- //
        //
        // Create 4 vehicles. ---------------- 
        vehicle__c v1 = new vehicle__c(Name= 'v1', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V001', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model 3', 
                                           Vehicle_Year__c = 2018);
        insert v1;
        vehicle__c v2 = new vehicle__c(Name= 'v2', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V002', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model S', 
                                           Vehicle_Year__c = 2018);
        insert v2;
        vehicle__c v3 = new vehicle__c(Name= 'v3', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V003', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model Y', 
                                           Vehicle_Year__c = 2018);
        insert v3;
        vehicle__c v4 = new vehicle__c(Name= 'v3', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V004', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model Y', 
                                           Vehicle_Year__c = 2018);
        insert v4;
        vehicle__c v5 = new vehicle__c(Name= 'v3', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V005', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model Y', 
                                           Vehicle_Year__c = 2018);
        insert v5;
        vehicle__c v6 = new vehicle__c(Name= 'v2', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V006', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model S', 
                                           Vehicle_Year__c = 2018);
        insert v6;
        vehicle__c v7 = new vehicle__c(Name= 'v2', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V007', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model S', 
                                           Vehicle_Year__c = 2018);
        insert v7;
        vehicle__c v8 = new vehicle__c(Name= 'v8', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V008', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model S', 
                                           Vehicle_Year__c = 2018);
        insert v8;
        vehicle__c v9 = new vehicle__c(Name= 'v9', 
                                           Base_Rental_Rate__c = 50, 
                                           Condition__c = 'Like New', 
                                           Vehicle_Identification_Number__c = 'V009', 
                                           Vehicle_Make__c = 'Tesla', 
                                           Vehicle_Model__c = 'Model S', 
                                           Vehicle_Year__c = 2018);
        insert v9;
        //  ---------------- Create 4 vehicles.
        // 
        // Create 4 rental contracts 1 contact and 1 account. ---------------- 
        Contact c1 = new Contact(LastName = 'C1');
        insert c1;
        Account a1 = new Account(Name = 'A1');
        insert a1;
        Rental_Contract__c rc1 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v1.Id);
        insert rc1;
        Rental_Contract__c rc2 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v2.Id);
        insert rc2;
        Rental_Contract__c rc3 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v3.Id);
        insert rc3;
        Rental_Contract__c rc4 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v4.Id);
        insert rc4;
        Rental_Contract__c rc5 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v5.Id);
        insert rc5;
        Rental_Contract__c rc6 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v6.Id);
        insert rc6;
        Rental_Contract__c rc7 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v7.Id);
        insert rc7;
        Rental_Contract__c rc8 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v8.Id);
        insert rc8;
        Rental_Contract__c rc9 = new Rental_Contract__c(Company__c = a1.Id, 
                                                        Customer__c = c1.Id, 
                                                        Expected_Return_Date__c = Date.parse('10/15/2021'), 
                                                        Issue_Date__c = Date.today(), 
                                                        Status__c = 'Active', 
                                                        Vehicle__c = v9.Id);
        insert rc9; 
        // ---------------- Create 4 rental contracts 1 contact and 1 account.
        

        // ------------- Perform Test ------------- //
        Test.startTest();
        List<vehicle__c> vList = TopThreeListController.getTopThree();
        Test.stopTest();
        
        
        // ------------- Verify ------------- //
        System.assertEquals(3, vList.size());
    }


}
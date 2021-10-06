@isTest
private class CarSalesControllerTest {
    @TestSetup
    static void makeData(){
        Vehicle__c vec = new Vehicle__c();
        vec.Name = 'testname';
        vec.Vehicle_Make__c = 'Acura';
        vec.Vehicle_Model__c = 'testmodel';
        vec.Vehicle_Identification_Number__c = '123456789';
        vec.Base_Rental_Rate__c = 100;
        vec.Vehicle_Year__c = 2020;
        
        Purchase_Transaction__c pur = new Purchase_Transaction__c();
        pur.Name = 'purtestname';
        
        Account acc = new Account();
        acc.Name = 'testacc';
        insert acc;
        Depot__c dep = new Depot__c();
        dep.Name = 'testdep';
        dep.Owner__c = acc.Id;
        insert vec;
        insert pur;
        insert dep;
        //CarSalesController testcont = new CarSalesController();
    }
    
    
    @isTest
    static void savecar() {
        Purchase_Transaction__c pur = [SELECT Id FROM Purchase_Transaction__c WHERE Name = 'purtestname'];
        Vehicle__c vehic = [SELECT Id, Purchase_Transaction__c FROM Vehicle__c WHERE Name = 'testname'];
        CarSalesController.saveCar(vehic, pur);
        System.assertEquals(pur.Id, vehic.Purchase_Transaction__c);
    }

    @isTest
    static void getCompanies() {
        List<Account> accList = [SELECT Id, Name FROM Account];
        CarSalesController.getCompanies();
        System.assertEquals(1, accList.size());
    }  
    
    @isTest
    static void getDepots() {
        List<Depot__c> depList = [SELECT Id, Name FROM Depot__c];
        CarSalesController.getDepots();
        System.assertEquals(1, depList.size());
    }
}
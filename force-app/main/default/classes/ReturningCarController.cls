public without sharing class ReturningCarController{
    
    @AuraEnabled //Needed when using c.saveAccount
    public static Account saveAccount (Account acc) {
        
        upsert acc; //You alredy know who it is
        return acc; //returns JSON for js
    }
        @AuraEnabled
    public static List <Account> getAccounts() {
        return [SELECT Id, name, Type, Phone FROM Account ORDER BY createdDate ASC];
    }    
    @AuraEnabled
    public static Vehicle__c findByName(String searchKey) {
       
        return [SELECT id, Vehicle_Year__c, Vehicle_Make__c, Vehicle_Model__c,  Status__c, Vehicle_Identification_Number__c 
				FROM Vehicle__c 
				WHERE Vehicle_Identification_Number__c = :searchKey limit 1];
       
    }
    @AuraEnabled
    public static Vehicle__c saveCar(Vehicle__c car) {
        system.debug('TEST' +car.Vehicle_Make__c);
        car.Status__c = 'Checked In';
system.debug('TEST' +car.id);
        Rental_Contract__c contract = [SELECT id,Vehicle__c,Status__c FROM Rental_Contract__c WHERE Vehicle__c = :car.Id AND status__c != 'Checked in' limit 1];
        system.debug('TEST' +contract.Status__c);
        contract.Status__c = 'Closed';
        update contract;
        update car;
        return car;
       
    }
}
public class CarRentalController {
	@AuraEnabled
    public static Rental_Contract__c saveRental(Rental_Contract__c rental, Contact contact){
        upsert contact;
        Account relatedAccount = [SELECT Id FROM Account where Name = 'Edge Communications'];
        Vehicle__c relatedCar = [SELECT Id FROM Vehicle__c where Name = 'Car 1'];
        rental.Customer__c = contact.Id;
        rental.Vehicle__c = relatedCar.Id;
        rental.Company__c = relatedAccount.Id;
        upsert rental;
        return rental;  
    }

    @AuraEnabled
    public static List<Account> getCompanies(){
        List<Account> companyList = [SELECT Id, Name FROM Account];
        return companyList;
    }

    @AuraEnabled
    public static List<Depot__c> getDepots(){
        List<Depot__c> depotList = [SELECT Id, Name FROM Depot__c];
        return depotList;
    }
}

public class CarRentalController {
	@AuraEnabled
    public static Rental_Contract__c saveRental(Rental_Contract__c rental, Contact contact){
        upsert contact;
        Account relatedAccount = [SELECT Id FROM Account where Name = 'Edge Communications'];
        rental.Customer__c = contact.Id;
        rental.Company__c = relatedAccount.Id;
        upsert rental;
        return rental;  
    }

    @AuraEnabled
    public static List<Vehicle__c> getCars(){
        List<Vehicle__c> carList = [SELECT Id, Name FROM Vehicle__c WHERE Vehicle__c.Status__c = 'Checked In'];
        return carList;
    }

    @AuraEnabled
    public static List<Depot__c> getDepots(){
        List<Depot__c> depotList = [SELECT Id, Name FROM Depot__c];
        return depotList;
    }
}

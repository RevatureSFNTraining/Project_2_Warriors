public class CarRentalController {
	@AuraEnabled
    public static Rental_Contract__c saveRental(Rental_Contract__c rental, Contact contact){
        List<Contact> existingContacts = [SELECT id, email FROM Contact WHERE Email = :contact.email];
        if(existingContacts.size() == 0) {
            insert contact;
            rental.Customer__c = contact.Id;
        } else {
            rental.Customer__c = existingContacts[0].id;
        }
        Account relatedAccount = [SELECT Id FROM Account where Name = 'United Oil & Gas, Singapore'];
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

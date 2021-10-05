public without sharing class NavListController {
	@AuraEnabled
   public static List<Account> getAccounts() {
       return [SELECT Id, Name, Industry, Phone
       FROM Account ORDER BY LastModifiedDate];
   }
    
    @AuraEnabled
    public static list<Depot__c> getRelatedList(Id recordId)
    {
        List<Depot__c> depList = [Select id, name, address__c from Depot__c where Owner__c=:recordId ];
        return depList;
    }
}
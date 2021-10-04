public without sharing class NavListController {
	@AuraEnabled
   public static List<Account> getAccounts() {
       return [SELECT Id, Name, Industry, Phone
       FROM Account ORDER BY LastModifiedDate];
   }
    
    @AuraEnabled
    public static list<Contact> getRelatedList(Id recordId)
    {
        List<Contact> Conlist = [Select id, name,firstname,lastname, email, phone from Contact where AccountId=:recordId ];
        return Conlist;
    }
}
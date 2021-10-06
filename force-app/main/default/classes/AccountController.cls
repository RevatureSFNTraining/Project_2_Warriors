public with sharing class AccountController{
    
    @AuraEnabled //Needed when using c.saveAccount
    public static Account saveAccount (Account acc) {
        
        upsert acc; //You alredy know who it is
        return acc; //returns JSON for js
    }
}
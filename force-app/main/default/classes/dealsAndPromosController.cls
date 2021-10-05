public class dealsAndPromosController {
    @AuraEnabled
    public static List<Discount__c> getPublicDiscounts(){
        List<Discount__c> publicDiscounts = [SELECT Id, Name, Discount_Percent__c, Discount_Code__c, Public__c 
                                             FROM Discount__c
                                             WHERE Public__c = true];
        return publicDiscounts;
    }
    
    @AuraEnabled
    public static List<Discount__c> getAllDiscounts() {
        List<Discount__c> allDiscounts = [SELECT Id, Name, Discount_Percent__c, Discount_Code__c, Public__c FROM Discount__c];
        return allDiscounts;
    }
}

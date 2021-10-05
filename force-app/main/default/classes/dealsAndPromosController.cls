public class dealsAndPromosController {
    @AuraEnabled
    public static List<Discount__c> getPublicDiscounts(){
        List<Discount__c> publicDiscounts = [SELECT Id, Name, Discount_Percent__c, Discount_Code__c, Public__c 
                                             FROM Discount__c
                                             WHERE Public__c = true];
        return publicDiscounts;
    }
    
    @AuraEnabled
    public static Discount__c findDiscount(String code) {
        List<Discount__c> allDiscounts = [SELECT Id, Name, Discount_Percent__c, Discount_Code__c, Public__c FROM Discount__c];
        Discount__c returnDiscount = new Discount__c();
        for(Discount__c disc : allDiscounts) {
            if(disc.Discount_Code__c == code) {
                returnDiscount = disc;
            }
        }
        return returnDiscount;
    }
}
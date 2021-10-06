@isTest
private class dealsAndPromosControllerTest {
    @TestSetup
    static void makeData(){
        Discount__c disc = new Discount__c();
        disc.Name = 'test';
        disc.Discount_Code__c = 'test';
        insert disc;
    }
    
    @isTest
    static void getPublicDiscounts() {
        List<Discount__c> discList = [SELECT Id, Name FROM Discount__c];
        dealsAndPromosController.getPublicDiscounts();
        System.assertEquals(1, discList.size());
    }

    @isTest
    static void findDiscount() {
        List<Discount__c> dList = [SELECT Id, Name FROM Discount__c];
        Discount__c testdisc = dealsAndPromosController.findDiscount('test');
        System.assertEquals(1, dList.size());
        System.assertEquals('test', testdisc.Discount_Code__c);
    }
}

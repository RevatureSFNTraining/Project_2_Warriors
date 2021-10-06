public with sharing class contactFormController {
    @AuraEnabled
    public static Case saveCase (Case c) {
        upsert c;
        return c;
    }
}

public class CarSalesController {
	@AuraEnabled
    public static Vehicle__c saveCar(Vehicle__c vehicle, Purchase_Transaction__c trans){
        upsert trans;
        vehicle.Purchase_Transaction__c = trans.Id;
        upsert vehicle;
        return vehicle;  
    }

    @AuraEnabled
    public static Vehicle__c saveAdditionalCar(Vehicle__c vehicle, Purchase_Transaction__c trans){
        upsert trans;
        upsert vehicle;  
        vehicle.Purchase_Transaction__c = trans.Id;
        upsert vehicle;
        return vehicle;       
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
    
    /*@AuraEnabled
    public static List<String> getPickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in Make are: '+pickListValuesList);
        }
        System.debug(pickListValuesList);     
        return pickListValuesList;
    }*/
}
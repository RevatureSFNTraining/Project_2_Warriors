public class DisplayCarList {
    @AuraEnabled
    public static List<Vehicle__c> fetchVehicleRecords(){
        List<Vehicle__c> vehicleList = [SELECT Id, Name, Vehicle_Type__c, Vehicle_Year__c, Vehicle_Make__c, Vehicle_Model__c, Status__c, Description__c FROM Vehicle__c WHERE Status__c != 'Lost/Stolen' OR Status__c != 'Decomissioned' ORDER BY Status__c];
        return vehicleList;  
    }
}

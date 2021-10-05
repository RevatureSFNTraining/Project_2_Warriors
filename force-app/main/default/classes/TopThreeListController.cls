public class TopThreeListController {
    
    // Assume the query return a list that has more than 3 elements.
    // This method return the a List<Vehicle__c> that contains the top 3 cars.
    @AuraEnabled
    public static List<Vehicle__c> getTopThree() {
        
        List<Vehicle__c> topThree = new List<Vehicle__c>();
        
        List<Rental_Contract__c> contractList = [SELECT Id, Vehicle__r.Name 
                                                 FROM Rental_Contract__c 
                                                 ORDER BY Vehicle__r.Name];
        // System.debug(contractList[3].Vehicle__r.Name);
        
        // Assume the map has more than 3 elements.
        Map<String, Integer> numOfContracts = new Map<String, Integer>();
        for (Rental_Contract__c contract : contractList) {
            if (!numOfContracts.containsKey(contract.Vehicle__r.Name)) {
                numOfContracts.put(contract.Vehicle__r.Name, 1);
            } else {
                numOfContracts.put(contract.Vehicle__r.Name, 
                                   numOfContracts.get(contract.Vehicle__r.Name) + 1);
            }
        }
        
        // List to hold the top 3 most popular vehicles. 
        List<String> vehicleName = new List<String>();
        vehicleName.add('');
        vehicleName.add('');
        vehicleName.add('');
        List<Integer> num = new List<Integer>();
        num.add(0);
        num.add(0);
        num.add(0);

        // Get the name of the top 3 cars.
        Integer counter = 0;
        for (String key : numOfContracts.keySet()) {
            if (counter < 3) { // Set the top 3 to the first 3.
                if (vehicleName[counter] == '') {
                    vehicleName[counter] = key;
                    num[counter] = numOfContracts.get(key);
                    counter++;
                }
            } else {
                if (numOfContracts.get(key) > num[0]) { // The current vehicle has more contract than #1.
                    // Set #2 become #3.
                    vehicleName[2] = vehicleName[1];
                    num[2] = num[1];
                    // Set #1 become #2.
                    vehicleName[1] = vehicleName[0];
                    num[1] = num[0];
                    // Set current vehicle to #1.
                    vehicleName[0] = key;
                    num[0] = numOfContracts.get(key);    
                } else if (numOfContracts.get(key) > num[1]) { // The current vehicle has more contract than #2.
                    // Set #2 become #3.
                    vehicleName[2] = vehicleName[1];
                    num[2] = num[1];
                    // Set current vehicle to #2.
                    vehicleName[1] = key;
                    num[1] = numOfContracts.get(key);  
                } else if (numOfContracts.get(key) > num[2]) { // The current vehicle has more contract than #3.
                    // Set current vehicle to #3.
                    vehicleName[2] = key;
                    num[2] = numOfContracts.get(key); 
                }
            }
        }
        // System.debug(vehicleName);
        // System.debug(num);
        
        // Query fot the top 3 cars and save them in a list.
        List<Vehicle__c> top1 = [SELECT Id, Name, Vehicle_Make__c 
                                 FROM Vehicle__C 
                                 WHERE Name = :vehicleName[0] 
                                 LIMIT 1];
        List<Vehicle__c> top2 = [SELECT Id, Name, Vehicle_Make__c 
                                 FROM Vehicle__C 
                                 WHERE Name = :vehicleName[1] 
                                 LIMIT 1];
        List<Vehicle__c> top3 = [SELECT Id, Name, Vehicle_Make__c 
                                 FROM Vehicle__C 
                                 WHERE Name = :vehicleName[2] 
                                 LIMIT 1];
        topThree.add(top1[0]);
        topThree.add(top2[0]);
        topThree.add(top3[0]);
        System.debug(topThree);

        return topThree;
        
    }
    
}
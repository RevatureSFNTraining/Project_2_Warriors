/*
 * ContactTrigger
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Helper class for handling vehicle triggers.
 */

public class VehicleTriggerHandler {

    /*
     * Checks if there are not active rental contracts on the vehicles which prevent them from being checked in.
     * In addition, check if there are any active rental contracts for vehicles being attempted to be manually checked out.
     * Throws an error in Salesforce if an attempt on changing a vehicle's status is being made while a rental contract is still active,
     * or if the vehicle is being manually checked out without an active rental contract.
     * @param vehicles - A list of Vehicles to be inserted/updated.
     */
    public static void checkContractStatus(List<Vehicle__c> vehicles) {
        //Check contracts that involve this vehicle, and check if the contract is closed.
        for (Vehicle__c vehicle : vehicles) {
            List<Rental_Contract__c> contracts = [SELECT Id, Name, Status__c FROM Rental_Contract__c WHERE Vehicle__c = :vehicle.Id];

            //Check if there is an active contract for vehicles that are checked out'.
            //Skip vehicle if there is one, otherwise throw an error.
            if (vehicle.Status__c.equals('Checked Out')) {
                boolean hasActiveContract = false;
                for (Rental_Contract__c rentalContract : contracts) {
                    if (!rentalContract.Status__c.equals('Closed')) {
                        hasActiveContract = true;
                        break;
                    }
                }

                if (hasActiveContract)
                    continue;
                
                vehicle.Status__c.addError('Cannot manually check out vehicles. Please form a rental contract.');
            }
            else {
                for (Rental_Contract__c rentalContract : contracts) {
                    if (!rentalContract.Status__c.equals('Closed'))
                        vehicle.Status__c.addError('Cannot change status of vehicle while contract is still active: ' + rentalContract.Name);
                }
            }
        }
    }
    
    /*
     * Checks if the vehicles are still being checked out, and prevent stationing them to depots if they still are.
     * @param vehicles - A list of Vehicles to be updated.
     */
    public static void checkVehicleStatus(List<Vehicle__c> vehicles) {
        //Checks if vehicles are already checked out.
        for (Vehicle__c vehicle: vehicles) {
            if (vehicle.Status__c.equals('Checked Out')) {
                //Prevent stationing a vehicle to a depot.
                if (vehicle.Stationed_Depot__c != null)
                    vehicle.Stationed_Depot__c.addError('Cannot station a checked out vehicle to a depot.');
            }
        }
    }
}
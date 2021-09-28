/*
 * RentalContactTrigger
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Triggers fired when a Rental Contract record is being modified.
 */

 trigger RentalContractTrigger on Rental_Contract__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            RentalContractTriggerHandler.checkCustomersForOverdueVehicles(Trigger.new);
            RentalContractTriggerHandler.checkOutVehicle(Trigger.new);
        }
        when BEFORE_UPDATE {
            RentalContractTriggerHandler.postponeCheck(Trigger.old, Trigger.new);
            RentalContractTriggerHandler.checkReturnDate(Trigger.new);
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            RentalContractTriggerHandler.changeVehicleStatus(Trigger.new, true);
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}
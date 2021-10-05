({
    /*doInit : function(component) {
        var action = component.get("c.getCompanies");
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistCompanies", list);
        })
        $A.enqueueAction(action);

        var depAction = component.get("c.getDepots");
        depAction.setCallback(this, function(response){
            var depList = response.getReturnValue();
            component.set("v.picklistDepots", depList);
        })
        $A.enqueueAction(depAction);
    },*/

    clickCreateRental : function(component, event, helper) {
        var newContact = component.get("v.newContact");
        var newRental = component.get("v.newRental");      
        var action = component.get("c.saveRental");
        action.setParams({rental : newRental, contact: newContact});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getRentalValue = component.get("v.newRental");
                alert("Thank you for renting a car with us!");
                console.log(getRentalValue);
            }
            else if (state === "INCOMPLETE") {
                console.error("INCOMPLETE");
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.error("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.error("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
        component.set("v.newRental",{'sObjectType': 'Rental_Contract__c', 'Name' : '', 'Issue_Date__c':'', 
                                    'Expected_Return_Date__c':'', 'Status__c':'Active'});
        component.set("v.newContact",{'sObjectType': 'Contact', 'FirstName': '', 'LastName': '','Birthdate': '',
                                        'Email': ''});
    }
})

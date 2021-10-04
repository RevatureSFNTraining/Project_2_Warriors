({
    getAccounts: function(component, event, helper) {
        var action = component.get("c.getAccounts");
        component.find("Id_spinner").set("v.class", 'slds-show');

        //Set up the callback
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.find("Id_spinner").set("v.class", 'slds-hide');
                component.set("v.accounts", actionResult.getReturnValue());

                //alert("Successful set: " + actionResult.getReturnValue()[0].Name);
            }
        });
        $A.enqueueAction(action);
    },
    updateCont: function(component, event, helper) {
        var value = event.getSource().get("v.value");
        var currentID = component.get("v.accounts[" + value + "].Id");
        var ConList = component.get("c.getRelatedList");
        component.find("Id_spinner").set("v.class", 'slds-show');

        ConList.setParams({
            recordId: currentID
        });
        //Set up the callback
        ConList.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.find("Id_spinner").set("v.class", 'slds-hide');
                var object1 = actionResult.getReturnValue();
                //alert("Successful set: " + object1[0].email);
                component.set("v.contacts", actionResult.getReturnValue());
                //component.set("v.conLocked", false);
                //component.set("v.accLocked", true);
                //alert("Successful set: " + actionResult.getReturnValue()[0].Email);
            } else {
                alert("Failed..")
            }
        });
        $A.enqueueAction(ConList);
    },

    fireNavInfoEvent: function(component, event, helper) {
        //do logic
        var cmpEvent = cmp.getEvent("navInfo");
        componentEvent.setParams({
            "account": component.find("selectAcc").get("v.value"),
            "contact": component.find("selectCon").get("v.value")
        });
        componentEvent.fire();
    },
})
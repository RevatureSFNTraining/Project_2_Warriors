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
        var DepList = component.get("c.getRelatedList");
        component.find("Id_spinner").set("v.class", 'slds-show');

        DepList.setParams({
            recordId: currentID
        });
        //Set up the callback
        DepList.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.find("Id_spinner").set("v.class", 'slds-hide');
                var object1 = actionResult.getReturnValue();
                //alert("Successful set: " + object1[0].email);
                component.set("v.depots", actionResult.getReturnValue());
                //component.set("v.conLocked", false);
                //component.set("v.accLocked", true);
                //alert("Successful set: " + actionResult.getReturnValue()[0].Email);
            } else {
                alert("No depots found.");
            }
        });
        $A.enqueueAction(DepList);
    },

    navInfoEvent: function(component, event) {
        //do logic

        //alert("arrived at event");
        var appEvent = $A.get("e.c:navInfo")
            // alert("event grabbed");
        var selectAcc = component.find("selectAcc").get("v.value");
        // alert("account value setup");
        var selectDepot = component.find("selectDepot").get("v.value");







        var testvar = component.get("v.depots");
        var testvar2 = testvar[0].Name;
        //alert("IS this EMPTY:  " + testvar2);
        var Depot = component.get("v.depots[" + selectDepot + "]");
        var Account = component.get("v.accounts[" + selectAcc + "]");

        //alert("Account: " + selectAcc + " || Depot: " + selectDepot);
        //alert("Account: " + Account.Name + " || Depot: " + Depot.Name);
        appEvent.setParams({
            "account": Account,
            "depot": Depot
        });
        //alert("values set");
        appEvent.fire();


    },
})
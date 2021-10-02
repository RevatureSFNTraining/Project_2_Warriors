({
    getAccounts: function(component) {
        var action = component.get("c.getAccounts");

        //Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.contacts", actionResult.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    updatePage: function(component, event, helper) {
        var value = event.getSource().get("v.value");
        var current = component.get("v.contacts[" + value + "].Name");
        var currentID = component.get("v.contacts[" + value + "].Id");

        //alert("Hey you pushed a button, maybe it will do something someday! : " + current + " and ID: " + currentID);

        event.getSource().set("v.disabled", true);

        var ConList = component.get("c.getRelatedList");
        //alert("Hey");
        ConList.setParams({
            recordId: currentID
        });

        ConList.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (component.isValid() && state === "SUCCESS") {
                var object1 = actionResult.getReturnValue();
                component.set("v.ContactList", actionResult.getReturnValue());
                //alert("Valid Company "+component.get("v.ContactList[0].Name"));
                //do logic
            } else {
                alert("Invalid Company");
            }

        });
        $A.enqueueAction(ConList);

    },
    unlockCompany: function(component, event, helper) {
        component.set("v.cdisabled", false);
    }
})
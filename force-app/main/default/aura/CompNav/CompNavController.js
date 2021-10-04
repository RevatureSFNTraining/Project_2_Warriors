({
    doInit: function(component, event, helper) {
        helper.getAccounts(component);
    },
    updateCont: function(component, event, helper) {
        helper.updateCont(component, event);
    },
    fireNavInfoEvent: function(component, event, helper) {
        helper.fireNavInfoEvent(component);
    }
})
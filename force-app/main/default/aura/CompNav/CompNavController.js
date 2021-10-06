({
    doInit: function(component, event, helper) {
        helper.getAccounts(component);
    },
    updateCont: function(component, event, helper) {
        helper.updateCont(component, event);
    },
    navInfoEvent: function(component, event, helper) {
        helper.navInfoEvent(component, event);
    }
})
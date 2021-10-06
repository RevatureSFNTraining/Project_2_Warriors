({
    doInit: function(component, event, helper) {
        helper.getAccounts(component);
    },
    updateThing: function(component, event, helper) {
        helper.updatePage(component, event, helper);
    },
    unlockCompany: function(component, event, helper) {
        helper.unlockCompany(component, event, helper);
    },

})
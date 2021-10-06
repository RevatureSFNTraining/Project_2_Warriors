({
    doInit : function(component, event, helper) {
        helper.doInit(component, event,helper);       
    },

    onRadio : function(component, event, helper) {
        var code = component.get("v.discountChosen.Discount_Code__c");
        console.log(code);
        component.find("textField").set("v.value", code);
    },

    addDiscount : function(component, event, helper) {
        helper.addDiscount(component, event, helper);
    }
})
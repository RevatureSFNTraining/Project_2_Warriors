({
    doInit : function(component) {
        var action = component.get("c.getPublicDiscounts");
        action.setCallback(this, function(response) {
            var state= response.getState()
            if (state === "SUCCESS") {
                var returnVal = response.getReturnValue();
                var finalList = [];
                for(var j=0; j<returnVal.length; j++) 
                {
                    returnVal[j].label = returnVal[j].Name;
                    returnVal[j].value = returnVal[j].Discount_Code__c;
                    finalList.push({'label': returnVal[j].label + ':   ' + returnVal[j].Discount_Percent__c + '%', 'value' : returnVal[j].value});
                }       
                console.log(returnVal);
                console.log(finalList);
                component.set("v.discountOptions", finalList);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

    addDiscount : function(component) {
        var disc = component.get("v.discountChosen");
        var action = component.get("c.findDiscount");
        action.setParams({code: disc.Discount_Code__c});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getDiscValue = response.getReturnValue();
                console.log(getDiscValue);
                var compEvent = component.getEvent("passDiscount");
                compEvent.setParams({
                    "discount" : getDiscValue.Discount_Percent__c
                });
                compEvent.fire();
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

        //var compEvent = component.getEvent("passDiscount");
        //compEvent.setParams({
        //    "discount" : getDiscValue.Discount_Percent__c
        //});
        //var discountChosen = component.get("{!v.discountChosen}");
        //console.log("compevent", compEvent);
        //console.log("discount", discountChosen);
        //compEvent.fire();
    }

})
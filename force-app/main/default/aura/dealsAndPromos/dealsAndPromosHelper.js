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
        
    }

})

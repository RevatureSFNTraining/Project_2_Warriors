({
    helperMethod: function(component, event) {

        var newAcc = component.get("v.newAccount"); //sets newAcc varible to attribute from form in view
        var action = component.get("c.saveAccount"); //sets action varible to method from apex controller

        action.setParams({
            "acc": newAcc //sets parameters to apex controller
        });

        action.setCallback(this, function(response) { //sets a callback to be sent 
            var state = response.getState(); //once the c.saveAccount is run
            if (state === "SUCCESS") { //if it goes well an alert will happen

                var name = response.getReturnValue().Name; //getReturnValue() gets JSON from response
                alert("hello " + name); //win free credit card popup
            }
        });


        $A.enqueueAction(action) //jquery fires settup function
    },

})
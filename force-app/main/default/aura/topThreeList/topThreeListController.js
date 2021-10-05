({
    
    doInit: function(component, event, helper) {
        // Create the action.
        let action = component.get("c.getTopThree");
        // Add callback behavior for when response is received.
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state == "SUCCESS") {
                component.set("v.cars", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed.
        $A.enqueueAction(action);
        
    },
    
})
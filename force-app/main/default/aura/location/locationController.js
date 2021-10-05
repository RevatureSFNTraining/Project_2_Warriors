({
    doInit : function(component, event, helper) {
       // Create the action.
       // Call getLocationJson() from Apex controller.
        let action = component.get("c.getLocationJson");
        
        // Add callback behavior for when response is received.
        action.setCallback(this, function(response) {
            // Check if the method from the Apex controller return successfully.
            let state = response.getState();
            if (state == "SUCCESS") { // The json is good to go.
                // Convert the Json to a JavaScript object.
                const obj = JSON.parse(response.getReturnValue());
                // Assign those object fields to the attributes of the component.
                component.set("v.city", obj.city);
                component.set("v.state", obj.state);
            } else {
                console.log("Failed with state: " + state);
            }
        });
        
        // Send action off to be executed.
        $A.enqueueAction(action);
    }
})
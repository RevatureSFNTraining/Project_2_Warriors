({
    createCase : function(component, event) {
        
        var newCase = component.get("v.newCase"); //sets newAcc varible to attribute from form in view
        var action = component.get("c.saveCase");//sets action varible to method from apex controller
        
        action.setParams({ 
            "c": newCase    //acc sets parameters to apex controller
        });                   
        
        action.setCallback(this, function(response) { //sets a callback to be sent 
            var state = response.getState();       //once the c.saveAccount is run
            if (state === "SUCCESS") {  	          //if it goes well an alert will happen
                
                var name = response.getReturnValue().SuppliedName; //getReturnValue() gets JSON from response
                alert("hello " + name);                     //win free credit card popup
            }
        });
        
        $A.enqueueAction(action) //jquery fires settup function
    },
    close : function(component, event) {
        alert("You can not destroy what you have alredy made...");
    }
})
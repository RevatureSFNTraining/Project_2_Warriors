({
    updateCar: function(component, event) {

        var newCar = component.get("v.Car"); //sets newAcc varible to attribute from form in view

        var action = component.get("c.saveCar"); //sets action varible to method from apex controller


        action.setParams({
            "car": newCar //sets parameters to apex controller
        });

        action.setCallback(this, function(response) { //sets a callback to be sent 
            var state = response.getState(); //once the c.saveAccount is run
            if (state === "SUCCESS") { //if it goes well an alert will happen

                // alert("SUCCESS"); //win free credit card popup
                component.set("v.Car", action.getReturnValue());
            } else {
                alert("Failure, unable to update car");
            }
        });


        $A.enqueueAction(action) //jquery fires settup function
    },

    Search: function(component, event) {

        var searchKey = component.get("v.searchKeyword");

        var action = component.get("c.findByName");
        action.setParams({
            "searchKey": searchKey
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); //once the c.saveAccount is run
            if (state === "SUCCESS") { //if it goes well an alert will happen

                //alert("SUCCESS"); //win free credit card popup
                component.set("v.Car", action.getReturnValue());
            } else {
                alert("VIN not found..");
            }



        });

        $A.enqueueAction(action);
    },

    handleApplicationEvent: function(cmp, event) {
        var Dep = event.getParam("depot");
        var Acc = event.getParam("account");
        cmp.set("v.account", Acc);
        cmp.set("v.depot", Dep);
    },



})
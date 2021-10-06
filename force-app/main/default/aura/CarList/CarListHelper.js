({        
    fetchCars : function(component) {
        var action = component.get('c.fetchVehicleRecords');
        action.setCallback(this, function(response){
            component.set('v.vehicleList', response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
})
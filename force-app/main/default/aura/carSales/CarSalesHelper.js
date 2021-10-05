({
    createCar : function (){
        var newCar = component.get("v.newCar");
        var action = component.get("c.saveCar");
        action.setParams({"vehicle": newCar});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getAllValue = component.get('v.newCar');
                alert(JSON.stringify(getAllValue)); //idk what i'm supposed to do here
            }
        });
        component.set("v.newCar",{'sObjectType':'Vehicle__c',
                                'Name':'',
                                'Vehicle_Identification_Number__c':0,
                                'Vehicle_Make__c':'',
                                'Vehicle_Model__c':'',
                                'Vehicle_Year__c' : 2021,
                                'Odometer_Mileage__c' : 0,
                                'Condition__c' : '',
                                'Base_Rental__Rate__c': 0});
    $A.enqueueAction(action);
    }
})
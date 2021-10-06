({
    doInit : function(component) {
        var action = component.get("c.getCompanies");
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistCompanies", list);
        })
        $A.enqueueAction(action);

        var depAction = component.get("c.getDepots");
        depAction.setCallback(this, function(response){
            var depList = response.getReturnValue();
            component.set("v.picklistDepots", depList);
        })
        $A.enqueueAction(depAction);
    },
        
    /*getPickListValues: function(component) {    
        var makeAction = component.get("c.getPickListValuesIntoList");
        makeAction.setParams({
            objectType: component.get("Vehicle__c"),
            selectedField: component.get("Vehicle_Make__c")
        });
        makeAction.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistValues", list);
            return list;
        })
        $A.enqueueAction(makeAction);
    },*/
    
    /*handleAddCar : function(component, event, helper) {
        var car = event.getParam("car");
        var action = component.get("c.saveCar");
        action.setParams({"car" : car})
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state==="SUCCESS"){
                var cars = component.get("v.cars");
                cars.push(car);
                component.set("v.cars", cars);
            }
        });
        $A.enqueueAction(action);
    },*/

    clickCreateCar : function(component, event, helper) {
        var newTran = component.get("v.newTran");
        var newCar = component.get("v.newCar");      
        var action = component.get("c.saveCar");
        action.setParams({vehicle : newCar, trans: newTran});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getCarValue = component.get("v.newCar");
                alert("Thank you for your sale!");
                console.log(getCarValue);
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
        component.set("v.newCar",{'sObjectType':'Vehicle__c',
                                'Name':'',
                                'Vehicle_Identification_Number__c':0,
                                'Vehicle_Make__c':'',
                                'Vehicle_Model__c':'',
                                'Vehicle_Year__c' : 2021,
                                'Odometer_Mileage__c' : 0,
                                'Condition__c' : '',
                                'Base_Rental__Rate__c': 0,
                                'Status_c' : 'Checked In'
                                //'Purchase_Transaction__r': '',
                                //'Stationed_Depot__r' : ''
                                });
        component.set("v.newTran",{'sObjectType':'Purchase_Transaction__c',
                                    'Name': '', 
                                    'Company__c': '',
                                    'Depot__r': '',
                                    'Price__c': 0, 
                                    'Notes__c': ''
                                    });
    },

    clickAdditionalCar : function(component, event, helper) {
        var newTran = component.get("v.newTran");
        var newCar = component.get("v.newCar");      
        var ack = component.get("c.saveCar");
        ack.setParams({vehicle : newCar, trans: newTran});
        ack.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getCarValue = component.get("v.newCar");
                alert("Thank you for your sale! Please add the details for your next vehicle.");
                console.log(getCarValue); //idk what i'm supposed to do here
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
        $A.enqueueAction(ack);
        component.set("v.newCar",{'sObjectType':'Vehicle__c',
                                'Name':'',
                                'Vehicle_Identification_Number__c':0,
                                'Vehicle_Make__c':'',
                                'Vehicle_Model__c':'',
                                'Vehicle_Year__c' : 2021,
                                'Odometer_Mileage__c' : 0,
                                'Condition__c' : '',
                                'Base_Rental__Rate__c': 0,
                                'Status_c' : 'Checked In'
                                //'Purchase_Transaction__r': '',
                                //'Stationed_Depot__r' : ''
                                });
    },

    toggleSection : function(component, event, helper) {
        // dynamically get aura:id name from 'data-auraId' attribute
        var sectionAuraId = event.target.getAttribute("data-auraId");
        // get section Div element using aura:id
        var sectionDiv = component.find(sectionAuraId).getElement();
        /* The search() method searches for 'slds-is-open' class, and returns the position of the match.
         * This method returns -1 if no match is found.
        */
        var sectionState = sectionDiv.getAttribute('class').search('slds-is-open'); 
        
        // -1 if 'slds-is-open' class is missing...then set 'slds-is-open' class else set slds-is-close class to element
        if(sectionState == -1){
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open cCarSales');

        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close cCarSales');
        }
    },
    
    handleApplicationEvent: function(cmp, event) {
        var Dep = event.getParam("depot");
        var Acc = event.getParam("account");
        cmp.set("v.account", Acc);
        cmp.set("v.depot", Dep);    
    }
})
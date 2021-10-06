({
    doInit : function(component) {
        var action = component.get("c.getCars");
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistCars", list);
        })
        $A.enqueueAction(action);
    },

    clickCreateRental : function(component, event, helper) {
        var newContact = component.get("v.newContact");
        var newRental = component.get("v.newRental");      
        var action = component.get("c.saveRental");
        action.setParams({rental : newRental, contact: newContact});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getRentalValue = component.get("v.newRental");
                alert("Thank you for renting a car with us!");
                console.log(getRentalValue);
            }
            else if (state === "INCOMPLETE") {
                alert("INCOMPLETE");
            }
            else if (state === "ERROR") {
                alert("Rental Contract was not created successfully.");

                }

        });
        $A.enqueueAction(action);
        component.set("v.newRental",{'sObjectType': 'Rental_Contract__c', 'Name' : '', 'Issue_Date__c':'', 
                                    'Expected_Return_Date__c':'', 'Status__c':'Active', 'Vehicle__c':''});
        component.set("v.newContact",{'sObjectType': 'Contact', 'FirstName': '', 'LastName': '','Birthdate': '',
                                        'Email': ''});
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
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open cRentCar');

        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close cRentCar');
        }
    },
    setPrice : function(component, event, helper) {
        var issueDate = new Date(component.get("v.newRental.Issue_Date__c"));
        var returnDate = new Date(component.get("v.newRental.Expected_Return_Date__c"));
        // To calculate the time difference of two dates
        var Difference_In_Time = returnDate.getTime() - issueDate.getTime();
        // To calculate the no. of days between two dates
        var Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);
        console.log(Difference_In_Days);
        var Price = Difference_In_Days * 25.77;
        component.find("priceField").set("v.value", '$' + Price);
    },

    handleComponentEvent : function(component, event, helper) {
        var issueDate = new Date(component.get("v.newRental.Issue_Date__c"));
        var returnDate = new Date(component.get("v.newRental.Expected_Return_Date__c"));
        // To calculate the time difference of two dates
        var Difference_In_Time = returnDate.getTime() - issueDate.getTime();
        // To calculate the no. of days between two dates
        var Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);
        console.log(Difference_In_Days);
        var Price = Difference_In_Days * 25.77;
        component.find("priceField").set("v.value", '$' + Price);
        var valueFromChild = event.getParam("discount");
        console.log("value from child:", valueFromChild);
        component.set("v.Discount.Discount_Percent__c", valueFromChild);
        var discountPercent = component.get("v.Discount.Discount_Percent__c");
        console.log("discountPercent", discountPercent);
        var finalPrice = (Price - (Price * discountPercent/100)).toFixed(2);
        component.find("priceField").set("v.value", '$' + finalPrice);
        alert("Discount Added! Savings of $" + (Price * discountPercent/100).toFixed(2));
    }
  
})

({
    createApplicant : function(component, event) {
        
        var newApplicant = component.get("v.newApplicant"); //sets newAcc varible to attribute from form in view
        var action = component.get("c.saveApplicant");//sets action varible to method from apex controller
        
        action.setParams({ 
            "applicant": newApplicant    //acc sets parameters to apex controller
        });                   
        
        action.setCallback(this, function(response) { //sets a callback to be sent 
            var state = response.getState();       //once the c.saveAccount is run
            if (state === "SUCCESS") {  	          //if it goes well an alert will happen
                var name = response.getReturnValue().Applicant_Name__c; //getReturnValue() gets JSON from response
                alert("Thank you for applying, " + name + ". We will get back to you shortly.");                     //win free credit card popup
            }
        });
        
        $A.enqueueAction(action) //jquery fires settup function
    },
    close : function(component, event) {
        alert("You can not destroy what you have alredy made...");
    },
    handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);

        // Get the file name
        uploadedFiles.forEach(file => console.log(file.name));
    }
})
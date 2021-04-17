({
	handleClick : function(component, event, helper) {
		console.log('***In helper');
      var a= component.get("v.recordId");
      console.log('***In helper'+a);
      //call apex class method
      var action = component.get('c.submitPayment');
        action.setParams({
            recordId : component.get("v.recordId"),
            secNumber : component.get("v.secNumber")
        });
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
            var dismissActionPanel = $A.get("e.force:closeQuickAction");
        	dismissActionPanel.fire();
          //set response value in wrapperList attribute on component.
          var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Success!",
                "message": "The Payment service has been called succesfully."
            });
            toastEvent.fire();
            window.setTimeout(
            $A.getCallback(function() {
                $A.get("e.force:refreshView").fire();
            }), 7000);
            
        } else {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Transaction Failed!",
                "message": "We were unable to call the service, please contact IT."
            });
            toastEvent.fire();    
        }
      });
      $A.enqueueAction(action);
    }
})
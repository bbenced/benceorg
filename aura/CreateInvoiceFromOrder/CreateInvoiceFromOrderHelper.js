({
    getStringAura : function(component) {
        var action = component.get('c.getOrderItems');
		var recordIdJS = component.get('v.recordId');
		console.log("Helper > getStringAura > v.recordId: " + component.get('v.recordId'));
		console.log("Helper > getStringAura > recordIdJS: " + recordIdJS);

		
        action.setParams( { orderId : recordIdJS });
        action.setCallback(this,function(response){
            var state = response.getState();

            if(state === "SUCCESS") {

                var returnFromApexJS = response.getReturnValue();
				console.log("Helper > getStringAura > returnFromApexJS: " + returnFromApexJS);
					
				component.set('v.stringToShow', returnFromApexJS);

            } else if (state === "INCOMPLETE") {
                console.log("Helper > getStringAura > INCOMPLETE");  
            } else if (state === "ERROR") {
                console.log("Helper > getStringAura > ERROR");  
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Helper > getStringAura > Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Helper > getStringAura > Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
})
({	 
    SaveEdition: function (cmp, draftValues){
        console.log(draftValues);
        var action = cmp.get("c.saveOpportunity");
		action.setParams( { opptyList : draftValues });
        action.setCallback(this,function(response){
            var state = response.getState();

            if(state === "SUCCESS") {

                var returnFromApexJS = response.getReturnValue();
				console.log("Helper > getStringAura > returnFromApexJS: " + returnFromApexJS);
                
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
    
    handleCellChange: function(cmp, event) {
        var values = event.getParam('draftValues');            
        var valuesJSON =  JSON.parse(JSON.stringify(values));              

		
		var draftValues = cmp.get('v.draftValues');        
        var draftValuesJSON =  JSON.parse(JSON.stringify(draftValues));       
		

        if(draftValuesJSON == null || draftValuesJSON == undefined){
            draftValuesJSON = valuesJSON;
            console.log(draftValuesJSON);
            cmp.set('v.draftValues',draftValuesJSON);
        }else{  
       	 	var found = false;
        	for(var i = 0;i<draftValuesJSON.length && !found;++i){
            	if(draftValuesJSON[i].Id == valuesJSON[0].Id){
					draftValuesJSON[i] = valuesJSON[0];       
                	found = true;
            	}            	
        	}  
            if(!found){
           		var mergedArrays = valuesJSON.concat(draftValuesJSON); 
    			console.log(mergedArrays);
            	cmp.set('v.draftValues',mergedArrays);
			}else{
 				console.log(draftValuesJSON);
                cmp.set('v.draftValues',draftValuesJSON);
 			}
        }
    },
    
    
    getStringAura : function(component) {
        var action = component.get('c.getOpportunityIdApex');
		var recordIdJS = component.get('v.recordId');
		console.log("Hepler > getStringAura > v.recordId: " + component.get('v.recordId'));
		console.log("Hepler > getStringAura > recordIdJS: " + recordIdJS);

		
        action.setParams( { recordIdApex : recordIdJS });
        action.setCallback(this,function(response){
            var state = response.getState();

            if(state === "SUCCESS") {

                //var returnFromApexJS = JSON.stringify(response.getReturnValue());
                var returnFromApexJS = response.getReturnValue();
				console.log("Helper > getStringAura > returnFromApexJS: " + returnFromApexJS);
                console.log("Helper > getStringAura > returnFromApexJS.length: "+ returnFromApexJS.length);
                
                var dataJS = new Array(returnFromApexJS.length);
             
                for(var i = 0;i<returnFromApexJS.length;++i){                    
                    var quotes = "";
                    
					for(var j = 0;j< returnFromApexJS[i].wrapQuoteList.length;++j){
                        if(j < returnFromApexJS[i].wrapQuoteList.length-1)
                        	quotes += returnFromApexJS[i].wrapQuoteList[j].Name + ", ";
                        else
                            quotes += returnFromApexJS[i].wrapQuoteList[j].Name;                        
                   	}
                    
                    var probabilityVar = returnFromApexJS[i].wrapOpportunity.Probability;
                    var CSSClassToApply = probabilityVar > 60 ? "HighProbability" : "NotLikely";
                    dataJS[i] = {
                        Id : returnFromApexJS[i].wrapOpportunity.Id,
                        opportunityName: returnFromApexJS[i].wrapOpportunity.Name, CSSClass : CSSClassToApply,                     
                        quoteName: quotes , CSSClass : CSSClassToApply,
                        probability: probabilityVar , CSSClass : CSSClassToApply,
                        NextStep:  returnFromApexJS[i].wrapOpportunity.NextStep, CSSClass : CSSClassToApply
                       
                    };
                    console.log(dataJS[i]);
                }
              	
				component.set('v.data', dataJS);

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
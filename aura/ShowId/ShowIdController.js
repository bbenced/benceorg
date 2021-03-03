({

	init : function (component, event, helper) {
		component.set('v.columns', [
            {label: 'Name', fieldName: 'opportunityName', type: 'text', cellAttributes: { class: { fieldName: 'CSSClass'}}},
            {label: 'Quotes', fieldName: 'quoteName', type: 'text', cellAttributes: { class: { fieldName: 'CSSClass'}}},
            {label: 'Probability', fieldName: 'probability', type: 'text', cellAttributes: { class: { fieldName: 'CSSClass'}}},
            {label: 'Next Step', fieldName: 'NextStep', type: 'text',editable: true, cellAttributes: { class: { fieldName: 'CSSClass'}}},
        ]);            
        helper.getStringAura(component);
        
	},	
            
            
            
	  
    handlecellchange: function(cmp, event, helper) {
		helper.handleCellChange(cmp,event);
    },

            
	handleSaveEdition: function (cmp, event, helper) {
        var draftValues = cmp.get('v.draftValues');
        console.log(draftValues);
		helper.SaveEdition(cmp,draftValues);
        $A.get('e.force:refreshView').fire();
    },

            
	handleClickButton : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
    },
})
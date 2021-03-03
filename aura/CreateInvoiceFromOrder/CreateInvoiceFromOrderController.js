({
	init : function (component, event, helper) {
		helper.getStringAura(component);
	},

	handleClickButton : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire(); 
        $A.get('e.force:refreshView').fire();
    },
})
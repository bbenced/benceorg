/**  
 * Trigger to update InvoiceItem fields dynamically
 * @author   Bence Baranyai	<bence.baranyai@evocrm.hu> 
 * @since    2020-10-21
*/

trigger InvoiceItem on Invoice_Item__c (before insert, before update, after insert, after update)  { 

	if (Trigger.isBefore && Trigger.isInsert) {
		UpdateInvoiceItemFields.updateItemTotalPriceFields(Trigger.new);
	}
	

	if (Trigger.isBefore && Trigger.isUpdate) {
		//variables
		List<Invoice_Item__c> itemTotalPriceList = new List<Invoice_Item__c> ();

		//loop
		for (Invoice_Item__c newItem : Trigger.new) {
			Invoice_Item__c oldItem = Trigger.oldMap.get(newItem.Id);

			//only Quantity and Net Unit Price is editable, rest is Read-only
			if (newItem.Quantity__c != oldItem.Quantity__c || newItem.Net_Unit_Price__c != oldItem.Net_Unit_Price__c) {
				itemTotalPriceList.add(newItem);
			}
		}

		//method calls
		UpdateInvoiceItemFields.updateItemTotalPriceFields(itemTotalPriceList);
	}

}
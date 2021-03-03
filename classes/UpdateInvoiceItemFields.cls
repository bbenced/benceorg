public class UpdateInvoiceItemFields  {

	 public static void updateItemTotalPriceFields(List<Invoice_Item__c> triggerList) {
		
		for(Invoice_Item__c thisItem : triggerList) {
			thisItem.Net_Item_Total_Price__c = thisItem.Quantity__c * thisItem.Net_Unit_Price__c;
			thisItem.Gross_Unit_Price__c = thisItem.Net_Unit_Price__c * (1 + thisItem.VAT_Rate__c);
			thisItem.Gross_Item_Total_Price__c = thisItem.Gross_Unit_Price__c * thisItem.Quantity__c;
			thisItem.Item_Total_VAT_Price__c = thisItem.Gross_Item_Total_Price__c - thisItem.Net_Item_Total_Price__c;
		}
	 }
}
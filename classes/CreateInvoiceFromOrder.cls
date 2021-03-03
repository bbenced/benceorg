/**  
 * Class to create Invoice from Order
 * @author   Bence Baranyai	<bence.baranyai@evocrm.hu> 
 * @since    2020-10-21
*/


public class CreateInvoiceFromOrder  {
	
	public static Boolean FailedToInsertException = false;

	@AuraEnabled
	public static  String getOrderItems(String orderId){

		Order order = [select OrderNumber, Id, VAT_Rate__c FROM Order Where Id = :orderId];

		List<OrderItem> orderItemList = new List<OrderItem>();
		orderItemList =  [Select Product2.Name, Id, Product2Id, Quantity, UnitPrice, TotalPrice FROM OrderItem where OrderId = :orderId];


		Double VAT = Double.valueOf(order.VAT_Rate__C );
		Invoice__c invoice = new Invoice__c(Name = order.OrderNumber, Order__c = orderId, VAT_Rate__c = VAT);
		insert invoice;

		List<Invoice_Item__c> invoiceItemList = new List<Invoice_Item__c>();


		for(Integer i = 0;i<orderItemList.size();++i){

			//adding values to the necessary fields that are not handled by the InvoiceItem.trigger
			invoiceItemList.add(new Invoice_Item__c(Name = orderItemList.get(i).Product2.Name + ' invoice',
													InvoiceId__c = invoice.Id,
													Net_Unit_Price__c = orderItemList.get(i).UnitPrice,
													Quantity__c = orderItemList.get(i).Quantity,
													Product__c = orderItemList.get(i).Product2Id,
													Order_Product__c = orderItemList.get(i).Id,
													Vat_Rate__c = invoice.VAT_Rate__c													
													));
		}

		//try catch for the front-end feedback
		try{	

			//for test
			if(FailedToInsertException == true){
				throw new CustomException('Failed to insert');
			}
				
			insert invoiceItemList;
			
		}catch(Exception e){
			return 'Something went wrong. The error message is: ' + e.getMessage();
			
		}
		return 'Successfully created invoices.';
		


	}


	

}
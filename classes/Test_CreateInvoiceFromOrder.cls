@isTest 
private class Test_CreateInvoiceFromOrder {

	@isTest
	private static void testGetOrderItems() {
		Account acc = new Account(Name = 'TestAcc');
        insert acc;   

		Id pricebookId = Test.getStandardPricebookId();

		Contract contract = new Contract(AccountId = acc.Id,
										 Status = 'Draft',
										 StartDate = System.today()-1,
										 ContractTerm = 3);
		insert contract;

		Product2 product1 = new Product2(Name = 'Test Product1');
		Product2 product = new Product2(Name = 'Test Product2');
		insert product;
		insert product1;

		PricebookEntry standardPrice1 = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = product1.Id,
														UnitPrice = 10000,
														IsActive = true);
        insert standardPrice1;

		PricebookEntry standardPrice2 = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = product.Id,
														UnitPrice = 10,
														IsActive = true);
        insert standardPrice2;

		Order order = new Order(AccountId = acc.Id,
								Status = 'Draft',
								EffectiveDate = System.today()-1,
								ContractId = contract.Id,
								VAT_Rate__c = '0.27',
								Pricebook2Id = pricebookId);
		insert order;



		

		OrderItem orderItem1 = new OrderItem(Product2Id = product1.Id,
											Quantity = 10,
											UnitPrice = 100,
											OrderId = order.Id,
											PricebookEntryId = standardPrice1.Id
											);
		insert orderItem1;

		OrderItem orderItem2 = new OrderItem(Product2Id = product.Id,
											Quantity = 10,
											UnitPrice = 100,
											OrderId = order.Id,
											PricebookEntryId = standardPrice2.Id
											);
		insert orderItem2;


		
		String msg = CreateInvoiceFromOrder.getOrderItems(order.Id);
		System.assertEquals('Successfully created invoices.',msg);	
		
		CreateInvoiceFromOrder.FailedToInsertException = true;
		System.assertEquals('Something went wrong. The error message is: Failed to insert',CreateInvoiceFromOrder.getOrderItems(order.Id));
											
	}
}
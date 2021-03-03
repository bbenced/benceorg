@isTest
public class testGetOpportunityId_Controller {
	

    @isTest static void testSaveOpportunity(){
		Account acc = new Account(Name = 'TestAcc');
        insert acc;        
        
        Opportunity oppty1 = new Opportunity(Name = 'TestOppty1',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                           	CloseDate = System.Today());
        insert oppty1;
        
        Opportunity oppty2 = new Opportunity(Name = 'TestOppty2',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                           	CloseDate = System.Today());
        insert oppty2;
        
        Opportunity oppty3 = new Opportunity(Name = 'TestOppty3',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                            CloseDate = System.Today());
        insert oppty3;
        
        Opportunity oppty4 = new Opportunity(Name = 'TestOppty4',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                            CloseDate = System.Today());
        Opportunity oppty5 = new Opportunity(Name = 'TestOppty4',                                          
                                            StageName = 'ClosedWon',
                                            CloseDate = System.Today());
        
        Quote quote11 = new Quote(Name= 'TestQuote11', OpportunityId = oppty1.Id);
        insert quote11;
        
        Quote quote12 = new Quote(Name= 'TestQuote12', OpportunityId = oppty1.Id);
        insert quote12;       
        
        Quote quote21 = new Quote(Name= 'TestQuote21', OpportunityId = oppty2.Id);
        insert quote21;
        
        List<Opportunity> testOpptyList = new List<Opportunity>();        
        oppty3.NextStep = 'Test';        
        testOpptyList.add(oppty3);
        String returnMsg = GetOpportunityId_Controller.saveOpportunity(testOpptyList);
        System.debug(returnMsg);
        System.assertEquals('Successful', returnMsg);
        
        testOpptyList.add(oppty5);
        returnMsg = GetOpportunityId_Controller.saveOpportunity(testOpptyList);
        System.assertEquals('Error', returnMsg);
        

                        
    }
    
    
    @isTest static void testGetOpportunityIdApex(){
        Account acc = new Account(Name = 'TestAcc');
        insert acc;        
        
        Opportunity oppty1 = new Opportunity(Name = 'TestOppty1',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                           	CloseDate = System.Today());
        insert oppty1;
        
        Opportunity oppty2 = new Opportunity(Name = 'TestOppty2',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                           	CloseDate = System.Today());
        insert oppty2;
        
        Opportunity oppty3 = new Opportunity(Name = 'TestOppty3',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                            CloseDate = System.Today());
        insert oppty3;
        
        Opportunity oppty4 = new Opportunity(Name = 'TestOppty4',
                                            AccountId = acc.Id,
                                            StageName = 'ClosedWon',
                                            CloseDate = System.Today());
        
        Quote quote11 = new Quote(Name= 'TestQuote11', OpportunityId = oppty1.Id);
        insert quote11;
        
        Quote quote12 = new Quote(Name= 'TestQuote12', OpportunityId = oppty1.Id);
        insert quote12;       
        
        Quote quote21 = new Quote(Name= 'TestQuote21', OpportunityId = oppty2.Id);
        insert quote21;

        List<GetOpportunityId_Controller.WrapperClass> testWrapperList = GetOpportunityId_Controller.getOpportunityIdApex(acc.Id);
        System.assertEquals(3, testWrapperList.size());       

    }

}
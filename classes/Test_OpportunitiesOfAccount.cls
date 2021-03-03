@isTest
private with sharing class Test_OpportunitiesOfAccount {
    @isTest static void testGetOpportunities(){
        
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
        
        Quote quote11 = new Quote(Name= 'TestQuote11', OpportunityId = oppty1.Id);
        insert quote11;
        
        Quote quote12 = new Quote(Name= 'TestQuote12', OpportunityId = oppty1.Id);
        insert quote12;
        
        Quote quote21 = new Quote(Name= 'TestQuote21', OpportunityId = oppty2.Id);
        insert quote21;
        
		List<Opportunity> testOpptyList = OpportunitiesOfAccount_Controller.getOpportunities(acc.Id);
        
        
        System.debug(acc.name + ' '+ acc.id);
        System.assertEquals(2,testOpptyList.size());
        
    }
}
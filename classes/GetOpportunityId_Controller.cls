public with sharing class GetOpportunityId_Controller {
    public class WrapperClass{
        @AuraEnabled
        public Opportunity wrapOpportunity {get; set;}
        @AuraEnabled
        public List<Quote> wrapQuoteList {get; set;}

        public WrapperClass(Opportunity wrapOpportunity, List<Quote> wrapQuoteList){
            this.wrapOpportunity = wrapOpportunity;
            this.wrapQuoteList = wrapQuoteList;
        }
        
    }
    @AuraEnabled
    public static String saveOpportunity(List<Opportunity> opptyList){
        try{
            update opptyList;
        }catch(exception e){
            System.debug('Error message: ' +e.getMessage());
            System.debug('Error type: ' +e.getTypeName());
			return 'Error';
		}        
		return 'Successful';     
    }
    
    @AuraEnabled
    public static List<WrapperClass> getOpportunityIdApex(Id recordIdApex){
        
        List<Opportunity> opptyList = [Select Name, Id, Probability, NextStep From Opportunity where AccountId = :recordIdApex];
        Set<Id> opptyIds = new Set<Id>();
    
        for(Integer i = 0;i< opptyList.size() ;++i){    
            opptyIds.add(opptyList.get(i).Id);
        }
        List<Quote> quotesList = [SELECT OpportunityId, Id, Name FROm Quote Where OpportunityId in :opptyIds];
		Map<Id, List<Quote>> quotesWithOpptyIds = new Map<Id, List<Quote>>();
        	for(Integer i = 0;i< quotesList.size();++i){
            	if(!quotesWithOpptyIds.containsKey(quotesList.get(i).OpportunityId)){
                	quotesWithOpptyIds.put(quotesList.get(i).OpportunityId,new List<Quote>{quotesList.get(i)});
            	} else{
                	quotesWithOpptyIds.get(quotesList.get(i).OpportunityId).add(quotesList.get(i));
            	}         
        	}    
        
        
        List<WrapperClass> wrapperList = new List<WrapperClass>();
        
        for(Integer i = 0;i<opptyList.size();++i){

            
            List<Quote> tmp =  quotesWithOpptyIds.get(opptyList.get(i).Id);
            if(tmp == null){
                tmp = new List<Quote>();
                tmp.add(new Quote(Name = '-'));
            }

            
            wrapperList.add(new WrapperClass(opptyList.get(i), tmp));
            
        }
        return wrapperList;
        
    }
}
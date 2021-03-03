/**
 * Controller class for OpportunitiesOfAccount Aura component
 * @author    evoCRM <balazs.horvath@evocrm.hu>
 * @since    2020-09-29 (bhorvath)
 * @info
 */

public with sharing class OpportunitiesOfAccount_Controller {

    public static List<Opportunity> getOpportunities(Id azon){
        List<Opportunity> opptyList = [SELECT Id, Name, Probability, NextStep FROM Opportunity WHERE AccountId = :azon];
        
        System.debug('OpportunitiesOfAccount_Controller > getOpportunities > opptyList.size()' + opptyList.size());
        System.debug('opttyList values: ');
        for(Integer i = 0;i<opptyList.size();++i){
            System.debug( opptyList.get(i).Id);
        }

        Set<Id> opptyIds = new Set<Id>();

    
        for(Integer i = 0;i< opptyList.size() ;++i){    
            opptyIds.add(opptyList.get(i).Id);
        }

        List<Quote> quotesList = [SELECT OpportunityId, Id, Name FROm Quote Where OpportunityId in :opptyIds];
        System.debug('OpportunitiesOfAccount_Controller > getOpportunities > guote.size()' + quotesList.size());
        
        Map<Id, List<Quote>> quotesWithOpptyIds = new Map<Id, List<Quote>>();
        for(Integer i = 0;i< quotesList.size();++i){
            if(!quotesWithOpptyIds.containsKey(quotesList.get(i).OpportunityId)){
                quotesWithOpptyIds.put(quotesList.get(i).OpportunityId,new List<Quote>{quotesList.get(i)});
            } else{
                quotesWithOpptyIds.get(quotesList.get(i).OpportunityId).add(quotesList.get(i));
            }
         
        }    
        System.debug('OpportunitiesOfAccount_Controller > getOpportunities > quotesWittOpptyIds.size()' + quotesWithOpptyIds.size());


        System.debug('FinalTest\nOpptys \n\tName\n\tQuotes\n\tProbability\n\tNextStep');
        for(Integer i = 0;i< opptyList.size();++i){
            System.debug(opptyList.get(i).Id + '\n\t' + opptyList.get(i).Name );
            if(quotesWithOpptyIds.containsKey(opptyList.get(i).id)){
                List<Quote> tmp = quotesWithOpptyIds.get(opptyList.get(i).id);
                for(Integer j = 0;j<tmp.size();++j){
                    System.debug(tmp.get(j).Name+',');
                }
            }
            System.debug('\t' +opptyList.get(i).Probability + '\n\t' + opptyList.get(i).NextStep);

        }


        return opptyList;
    }
}
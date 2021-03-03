public with sharing  class NextStep_Controller {

    @AuraEnabled
    public static void serverToGetNextStep(String nextStep, String Id1){
		Opportunity oppty = [select Id, NextStep from Opportunity where Id = :Id1];
        oppty.NextStep = nextStep;
        update oppty;        
    }
}
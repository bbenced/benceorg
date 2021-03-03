trigger AccountAddressTrigger on Account (before insert, before update) {

    for(Account acc : Trigger.new){
        If (acc.Match_Billing_Address__c == true && acc.BillingPostalCode!=Null) {
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }   
    } 
}
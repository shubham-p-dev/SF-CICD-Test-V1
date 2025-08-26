public with sharing class UpdateOpportunityAmountProfile {
    
    
    public static void updateOppAmtProfile() {
        
        List<Opportunity> opportunityList = new List<Opportunity>([ SELECT Id, Amount, Profile_Amount__c FROM Opportunity]);
        
        for (Opportunity eachOpp : opportunityList) {            
            if(eachOpp.Amount < 10000) {
                eachOpp.Profile_Amount__c = 'Low';
            } else if(eachOpp.Amount >= 10000 && eachOpp.Amount <= 50000) {
                eachOpp.Profile_Amount__c = 'Medium';
            } else if(eachOpp.Amount > 50000) {
                eachOpp.Profile_Amount__c = 'High';
            } else {
                eachOpp.Profile_Amount__c = 'NA';
            }
        }
        
        if(!opportunityList.isEmpty()) {
            UPDATE opportunityList;
        }
    }
}
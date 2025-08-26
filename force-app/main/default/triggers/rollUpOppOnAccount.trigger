trigger rollUpOppOnAccount on Opportunity (after insert) {
    
    if(trigger.isInsert && trigger.isAfter){
        
        Set<Id> setAccIds = new Set<Id>();
        Map<Id, Integer> mapAccIdCount = new Map<Id, Integer>();
        
        for(Opportunity opp : trigger.new) {
            setAccIds.add(opp.AccountId);
        }
        
        List<Opportunity> lstAccOpp = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN : setAccIds];
        
        for(Opportunity opp : lstAccOpp) {
            if(mapAccIdCount.ContainsKey(opp.AccountId)){
                mapAccIdCount.put(opp.AccountId, mapAccIdCount.get(opp.AccountId) + 1);
            } else {
                mapAccIdCount.put(opp.AccountId, 1);
            }
        }
        
        List<Account> lstParentAcc = [ SELECT Id, Opportunity_child_count__c FROM Account WHERE Id IN : setAccIds];
        
        for(Account eachAcc : lstParentAcc) {  
            eachAcc.Opportunity_child_count__c = mapAccIdCount.get(eachAcc.Id);
        }
        
        UPDATE lstParentAcc;
    }    
    
}
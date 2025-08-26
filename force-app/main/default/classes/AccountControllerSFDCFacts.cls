public with sharing class AccountControllerSFDCFacts {
    
    public static void updateAvgCaseResolutionDays(Set<Id> setAccountIds){
        
        List<Case> lstAccountCase = [ SELECT Id, CreatedDate, ClosedDate, AccountId FROM Case WHERE IsClosed = true AND AccountId IN : setAccountIds ];
        
        //Map<Id, Integer> mapAccountIdCaseCount = new Map<Id, Integer>();
        Map<Id, Integer> mapAccountIdDaysCount = new Map<Id, Integer>();
        
        for(Case caseObj : lstAccountCase) {
            
                        /*if(mapAccountIdCaseCount.containsKey(caseObj.AccountId)) {
            mapAccountIdCaseCount.put(caseObj.AccountId, mapAccountIdCaseCount.get(caseObj.AccountId) + 1);
            } else {
            mapAccountIdCaseCount.put(caseObj.AccountId, 1);
            }*/
            
            if(mapAccountIdDaysCount.containsKey(caseObj.AccountId)) {
                Integer daysCount = caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
                mapAccountIdDaysCount.put(caseObj.AccountId, mapAccountIdDaysCount.get(caseObj.AccountId) + daysCount);
            } else {
                mapAccountIdDaysCount.put(caseObj.AccountId, caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date()));
            }
        }
        
        List<Account> lstAccountToUp = [ SELECT Id, Avg_Case_Resoluton_Days__c, ( SELECT Id FROM Cases ) FROM Account WHERE Id IN : setAccountIds ];
        
        for(Account accountObj : lstAccountToUp) {
            
            if(accountObj.Cases.size() > 0 && mapAccountIdDaysCount.containsKey(accountObj.Id)) {
                
                Integer avgDays = mapAccountIdDaysCount.get(accountObj.Id)/accountObj.Cases.size();
                
                if(avgDays < 0) {
                    accountObj.Avg_Case_Resoluton_Days__c = 0;
                } else {
                    accountObj.Avg_Case_Resoluton_Days__c = avgDays;
                }
            }
        }
        
        
        if(!lstAccountToUp.isEmpty()) UPDATE lstAccountToUp;
        
                /*Integer totalDays = 0, totalCases = 0;
        // retrive all the cases for this account
        // get resolution days for each account (ClosedDate - CreatedDate)
        for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate
        FROM Case
        WHERE IsClosed=true
        AND AccountId =: accountId]){
        // increase number of cases
        totalCases++;
        // get duration in days and add it to totalDays
        totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
        }
        Decimal resolutionDays = totalDays/totalCases;
        // update account object
        Account acc = new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays);
        update acc;*/
    }
    
}
public with sharing class updateSalesRepHandler {


    public void handleInsertUpdateSalesRepUpdation(List<Account> newAccList, Map<Id, Account> mapOldIdAccount) {
	
        Set<Id> setUserIds = new Set<Id>();
        
        for(Account accObj : newAccList) {
            setUserIds.add(accObj.OwnerId);
        }
        
        
        Map<Id, User> mapOwnerIdName = new Map<Id, User>([SELECT Id, Name FROM User WHERE Id IN : setUserIds]);
        
        for(Account accObj : newAccList) {

            if((mapOldIdAccount != null && mapOldIdAccount.get(accObj.Id).OwnerId != accObj.OwnerId) || mapOldIdAccount == null) {
                accObj.Sales_Rep__c = mapOwnerIdName.get(accObj.OwnerId).Name;
            }
        }
    }
}
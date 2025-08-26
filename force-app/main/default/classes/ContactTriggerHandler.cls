public class ContactTriggerHandler {
    
    
    public void calculateActiveContacts(List<Contact> lstNewContacts, Map<Id, Contact> mapNewContacts) {
        
        Set<Id> setAccountIds = new Set<Id>();
        
        for(Contact contactRec : lstNewContacts) {
            if(contactRec.AccountId != null) setAccountIds.add(contactRec.AccountId); 
        }
        
        if(!setAccountIds.isEmpty()) {
        List<Account> lstContactRelatedAcc = [SELECT Id, Active_Contacts__c, (SELECT Id, Active__c FROM Contacts WHERE Active__c = true) FROM Account WHERE Id IN : setAccountIds];
        
            for(Account eachAccount : lstContactRelatedAcc) {
                eachAccount.Active_Contacts__c = eachAccount.Contacts.size();
            }
            if(!lstContactRelatedAcc.isEmpty()) UPDATE lstContactRelatedAcc;
        }
    }
    
    public void calculateActiveContactsUsingAggRes(List<Contact> lstNewContacts, Map<Id, Contact> mapOldContacts, Boolean isUpdate) {
        
        Set<Id> setAccountIds = new Set<Id>();
        
        for(Contact contactObj : lstNewContacts) {
            if(isUpdate) {
                Contact oldContactObj = mapOldContacts.get(contactObj.Id);                
                if(String.isNotBlank(contactObj.AccountId) &&
                   (contactObj.AccountId != oldContactObj.AccountId ||
                  	contactObj.Active__c != oldContactObj.Active__c)) {
                       setAccountIds.add(contactObj.AccountId);                   
                   }
            } else {
                if(String.isNotBlank(contactObj.AccountId)) setAccountIds.add(contactObj.AccountId);                
            }
        }
        
        if(!setAccountIds.isEmpty()) {
         	
            List<Account> listAccountToUp = new List<Account>();            
            List<AggregateResult> listAggResult = [SELECT AccountId, COUNT(Id)activeContacts FROM Contact WHERE Active__c = true AND AccountId IN : setAccountIds GROUP BY AccountId ];
            
            for(AggregateResult eachRes : listAggResult) {
                
                Id accId = (Id)eachRes.get('AccountId');
                Integer activeContacts = (Integer)eachRes.get('activeContacts');			
                
				Account relatedAccount = new Account(Id=accId, Active_Contacts__c=activeContacts);  
                listAccountToUp.add(relatedAccount);
            }
            if(!listAccountToUp.isEmpty()) UPDATE listAccountToUp;
        }
    }
    
    public void upMinAmountInsertUpDelUndel(List<Contact> lstNewContact, Map<Id, Contact> mapOldIdContact, Boolean isUpdate) {
        
        Set<Id> setAccIds = new Set<Id>();
        Map<Id, Decimal> mapAccIdMinAmount = new Map<Id, Decimal>();
        
        for(Contact eachCon : lstNewContact) {
            if(isUpdate) {
                if(eachCon.AccountId != mapOldIdContact.get(eachCon.Id).AccountId) {
                    setAccIds.addAll(new Set<Id>{eachCon.AccountId, mapOldIdContact.get(eachCon.Id).AccountId});
                } else if (eachCon.Amount__c != mapOldIdContact.get(eachCon.Id).Amount__c){
                    setAccIds.add(eachCon.AccountId);
                }     
            } else {
                if(eachCon.AccountId != null) setAccIds.add(eachCon.AccountId);                
            }
        }                
        
        List<Contact> allAccContactLst = [ SELECT Id, AccountId, Amount__c FROM Contact WHERE AccountId IN : setAccIds ];
        
        for(Contact eachCon : allAccContactLst) {
            if(mapAccIdMinAmount.containsKey(eachCon.AccountId)) {
                if(mapAccIdMinAmount.get(eachCon.AccountId) > eachCon.Amount__c) {
                    mapAccIdMinAmount.put(eachCon.AccountId, eachCon.Amount__c);
                }
            } else {
                mapAccIdMinAmount.put(eachCon.AccountId, eachCon.Amount__c);   
            }
        }
        
        List<Account> lstRelatedAccounts = [ SELECT Id, Lowest_Contact_Amount__c FROM Account WHERE Id IN : setAccIds ];
        
        for(Account eachAcc : lstRelatedAccounts) {
            eachAcc.Lowest_Contact_Amount__c = mapAccIdMinAmount.get(eachAcc.Id);
        }
        
        if(!lstRelatedAccounts.isEmpty()) UPDATE lstRelatedAccounts;
    }
    
}
public class sfExclusiveTriggerHandler {
	
    public void beforeInsertAcc(List<Account> lstNewAcc) {
    }
    
    public void afterInsertAccount(List<Account> lstNewAcc, Map<Id, Account> mapAccIdAcc) {
        system.debug('After insert account');
        
        String queueableJobId = System.enqueueJob(new QueueableInterfaceSFExclusive(lstNewAcc));
    }    
    
    public void beforeUpdateAccount(List<Account> lstOldAcc, Map<Id, Account> mapOldAccIdAcc,List<Account> lstNewAcc, Map<Id, Account> mapNewAccIdAcc) {
    }    
    
    public void afterUpdateAccount(List<Account> lstOldAcc, Map<Id, Account> mapOldAccIdAcc,List<Account> lstNewAcc, Map<Id, Account> mapNewAccIdAcc) {
    }  

    public void beforeDeleteAccount(List<Account> lstOldAcc, Map<Id, Account> mapOldAccIdAcc) {
    }
    
    public void afterDeleteAccount(List<Account> lstOldAcc, Map<Id, Account> mapOldAccIdAcc) {
    }    
    
    public void afterUndeleteAccount(List<Account> lstNewAcc, Map<Id, Account> mapNewAccIdAcc){
        
    }
    
    
    
}
public class QueueableInterfaceSFExclusive implements Queueable {

    List<Account> lstNewAccounts;
    
    public QueueableInterfaceSFExclusive(List<Account> lstNewAccountsFromTrigger) {
        this.lstNewAccounts = lstNewAccountsFromTrigger;
    }
    
    
    public void execute(QueueableContext qc) {
		
        
        for(Account eachAcc : lstNewAccounts) {
          //  eachAcc.Description = 'Updated by QueueableInterfaceSFExclusive';
        }        
		
       // if(!lstNewAccounts.isEmpty()) UPDATE lstNewAccounts;
        
        String enqueJobIdTwo = System.enqueueJob(new QueueableInterfaceSFExclusiveTwo(lstNewAccounts));
        System.debug('enqueJobIdTwo '+enqueJobIdTwo);
    }
}
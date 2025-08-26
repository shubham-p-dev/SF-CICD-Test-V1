public class QueueableInterfaceSFExclusiveTwo implements Queueable {

    List<Account> lstAccounts;
    
    public QueueableInterfaceSFExclusiveTwo(List<Account> lstAccountsFromQueueableOne) {
        this.lstAccounts = lstAccountsFromQueueableOne;
    }
    
    public void execute(QueueableContext qc) {
        
        List<Contact> lstContactToInsert = new List<Contact>();
        
        for(Account eachAcc : lstAccounts) {
            Contact newContact = new Contact();
            newContact.LastName = eachAcc.Name;
            newContact.AccountId = eachAcc.Id;
            newContact.Description = 'Added by QueueableInterfaceSFExclusiveTwo';
            lstContactToInsert.add(newContact);
        }
        
        if(!lstContactToInsert.isEmpty()) INSERT lstContactToInsert;
    }
}
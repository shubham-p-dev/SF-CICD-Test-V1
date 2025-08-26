// public with sharing class SD_AccountBatch {
//     public SD_AccountBatch() {

//     }
// }

public class SD_AccountBatch implements Database.Batchable<Account> {
    public Iterable<Account> start(Database.BatchableContext bc) {
        return [SELECT Id, Name FROM Account];
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Name += ' Updated';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {}
}

public class DatabaseMethodsDemo {
    
    public static void methodOne() {
        
        Account[] acctsList = [SELECT Id, Name, BillingCity
                               FROM Account WHERE BillingCity = 'Bombay'];
        
        for (Account a : acctsList) {
            a.BillingCity = 'Mumbai';
        }
        
        Account newAcct = new Account(Name = 'Acme two', BillingCity = 'San Francisco');
        acctsList.add(newAcct);
        
      List<Database.upsertResult> uResults = Database.upsert(acctsList,false);
        
        Set<Id> accIdsInserted = new Set<Id>();
        
        for(Database.upsertResult each : uResults) {
            system.debug('each '+each);
            
            if(each.isCreated() && each.isSuccess()) {
                accIdsInserted.add(each.getId());
            }
            
        }
        
        system.debug('accIdsInserted '+accIdsInserted);
    }
}
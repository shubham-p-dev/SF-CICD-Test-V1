public class BatchSFExclusive implements Database.Batchable<SObject> {
	
    public Database.querylocator start(Database.BatchableContext bc){
        
        //normally in synchronous transaction with governor limits we can query only 50K records in single transaction 
        //and we can upadate only 10K records in single transaction
        //but Database.getQueryLocator('') can query more than 50,000 records
        //single batch class can process 50 Millons records
        Database.queryLocator abc = Database.getQueryLocator('SELECT Id, Name FROM Account LIMIT 1');
        
        return abc;
    }
    
    public void execute(Database.BatchableContext bc, List<Sobject> recList){
        
        List<Account> accListToProcess = (List<Account>) recList;
                
        accListToProcess[0].Description = 'Updated in BatchSFExclusive batch';
        
        system.debug('Upadted acc record in batch '+accListToProcess[0]);
        
        UPDATE accListToProcess[0];
    }
    
    public void finish(Database.BatchableContext bc){
        // sending mail as batch processes successfully
        
        // chain another batch from here
        // batchDemo batch = new batchDemo();
        // Database.executeBatch(batch, 99);
        
    }
    
}
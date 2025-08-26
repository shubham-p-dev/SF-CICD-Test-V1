trigger LeadTrigger on Lead (before insert, after insert) {
    
    
    System.debug('OperationType   --> ' + System.Trigger.operationType);
    
    if (Trigger.isBefore && Trigger.isInsert) {
 		
        System.debug('Before Insert Trigger');
        System.debug('Size            --> ' + System.Trigger.size);
        System.debug('Executing       --> ' + System.Trigger.isExecuting);
        //System.debug('OperationType   --> ' + System.Trigger.operationType);
        
        //Trigger.new[0].addError('Not allowed');
        
        //LeadTriggerHandler.handleBeforeInsert();
        
        /*for (Lead leadObj : System.Trigger.new) {
            if (String.isBlank(leadObj.LeadSource)) {
                leadObj.LeadSource.addError('Please select Lead Source !');
                // leadObj.addError('Please select Lead Source !');
            }
        }*/
    }
    
    if (Trigger.isAfter && Trigger.isInsert) {
        
        System.debug('After Insert Trigger');
        System.debug('Size            --> ' + System.Trigger.size);
        System.debug('Executing       --> ' + System.Trigger.isExecuting);
        
        
        //System.debug('OperationType   --> ' + System.Trigger.operationType);
        
		//LeadTriggerHandler.handleAfterInsert();    
    }
}
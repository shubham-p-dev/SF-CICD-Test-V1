public class LeadTriggerHandler {

    public static void handleBeforeInsert() {
        System.debug('Before Insert Trigger');
        System.debug('Size            --> ' + System.Trigger.size);
        System.debug('Executing       --> ' + System.Trigger.isExecuting);
        System.debug('OperationType   --> ' + System.Trigger.operationType);
    }
    
    public static void handleAfterInsert() {
        System.debug('After Insert Trigger');
        System.debug('Size            --> ' + System.Trigger.size);
        System.debug('Executing       --> ' + System.Trigger.isExecuting);
        System.debug('OperationType   --> ' + System.Trigger.operationType);
    }
}
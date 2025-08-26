trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    
    if (Trigger.isBefore) {
        
        if (Trigger.isInsert) {
            AccountTriggerHandler.getShippingAddFromBillingAdd(Trigger.new);
        }
        if (Trigger.isUpdate) {
            AccountTriggerHandler.accountNameUpdateValidation(Trigger.oldMap, Trigger.newMap);
        }
        if (Trigger.isDelete) {
            AccountTriggerHandler.validateActiveAccountBeforeDelete(Trigger.oldMap);
        }
    }
    
    if (Trigger.isAfter) {
        
        if (Trigger.isInsert) {
            AccountTriggerHandler.createRelatedContact(Trigger.new, Trigger.newMap);
        }
        if (Trigger.isUpdate) {
            AccountTriggerHandler.updateMailingAddressOnContacts(Trigger.oldMap, Trigger.newMap);
        }
        if (Trigger.isDelete) {
            AccountTriggerHandler.accountDeletedEmailMessage(Trigger.oldMap);
        }
        if (Trigger.isUndelete) {
            AccountTriggerHandler.accountRestoredEmailMessage(Trigger.newMap);
        }
    }
    
}
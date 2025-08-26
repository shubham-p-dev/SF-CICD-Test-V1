trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {

    ContactTriggerHandler handler = new ContactTriggerHandler();
    
    
    if(Trigger.isBefore) {
        
    }
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            handler.upMinAmountInsertUpDelUndel(Trigger.new, null, false);
            //handler.calculateActiveContacts(Trigger.new, Trigger.newMap);
            handler.calculateActiveContactsUsingAggRes(Trigger.new, null, false);
        }
        if(Trigger.isUpdate) {
            handler.upMinAmountInsertUpDelUndel(Trigger.new, Trigger.oldMap, true);
            handler.calculateActiveContactsUsingAggRes(Trigger.new, Trigger.oldMap, true);
        }
        if(Trigger.isDelete) {
            handler.upMinAmountInsertUpDelUndel(Trigger.old, null, false);
        }
        if(Trigger.isUndelete) {
            handler.upMinAmountInsertUpDelUndel(Trigger.new, null, false);
        }
    }
    
    
}
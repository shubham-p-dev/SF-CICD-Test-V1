trigger CaseTrigger on Case (before insert, after insert) {


    if (Trigger.isAfter) {
        
        if (Trigger.isInsert) {
            CaseTriggerHandler.handleCreateZendeskTicket(Trigger.new);       
        }
    }

}
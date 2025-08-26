trigger sfExclusiveTrigger on Account (before insert, after insert, before update, after update,
                                       before delete, after delete, after undelete) {
	
    sfExclusiveTriggerHandler handler = new sfExclusiveTriggerHandler();
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            handler.beforeInsertAcc(Trigger.new);
        }
        if(Trigger.isUpdate){
            handler.beforeUpdateAccount(Trigger.old, Trigger.oldmap,Trigger.new, Trigger.newMap);
        }
        if(Trigger.isDelete){
            handler.beforeDeleteAccount(Trigger.old, Trigger.oldmap);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            handler.afterInsertAccount(Trigger.new, Trigger.newMap);
        }
        if(Trigger.isUpdate){
            handler.afterUpdateAccount(Trigger.old, Trigger.oldmap,Trigger.new, Trigger.newMap);
        }
        if(Trigger.isUpdate){
            handler.afterDeleteAccount(Trigger.old, Trigger.oldmap);
        }
        if(Trigger.isUndelete){
            handler.afterUndeleteAccount(Trigger.new, Trigger.newMap);
        }
    }
}
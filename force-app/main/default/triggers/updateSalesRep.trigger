trigger updateSalesRep on Account (before insert, before update) {

    updateSalesRepHandler handler = new updateSalesRepHandler();

    if(Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            handler.handleInsertUpdateSalesRepUpdation(Trigger.new, Trigger.oldMap);
        }
    }
}
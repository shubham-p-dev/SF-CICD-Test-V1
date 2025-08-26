/*You have to write Triger for  duplicate check on the Opportunity.
Criteria will be Phone Number And Email(It should be combination of both).
If you find any existing opportunity with same phone number and email in database then mark the incoming Opportunity as duplicate or you can add the error as well.
For now you can only concentrate on the insert scenarios as well no need to think on update scenario.
*/

trigger OpportunityTrigger on Opportunity (before insert, before update) {
        
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    
    if(Trigger.isBefore) {
        
        handler.beforeInsert(Trigger.new, Trigger.oldMap);
        
        if(Trigger.isInsert) {
            //handler.handleDupOppInsertUpdate(Trigger.new, null, false);
            //handler.beforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate) {
            //handler.handleDupOppInsertUpdate(Trigger.new, Trigger.oldMap, true);
        }
    }
    
    
    
    
	    
    
    
    
    
    
    
    
    
    /*if(Trigger.isBefore && Trigger.isInsert) {
        
        Set<String> setPhoneEmailString = new Set<String>();
        
        List<Opportunity> lstAllOpportunity = [ SELECT Id, Phone_Number__c, Email__c FROM Opportunity ];
        
        for(Opportunity eachOpp : lstAllOpportunity) {
            setPhoneEmailString.add(eachOpp.Phone_Number__c+eachOpp.Email__c);
        }
        
        for(Opportunity newOpp : Trigger.new) {
            if(setPhoneEmailString.contains(newOpp.Phone_Number__c+newOpp.Email__c)) {
                newOpp.addError('Opportunity exists with entered Phone Number and Email');
            }
        }
    }*/
}
public class OpportunityTriggerHandler {
    
    public void beforeInsert(List<Opportunity> listNewRecords, Map<Id, Opportunity> mapOldRecords) {
        
        Opportunity highestAmtOppo = [SELECT Id, Is_Highest_Amount__c, Amount FROM Opportunity WHERE Is_Highest_Amount__c = true ORDER BY Amount DESC NULLS LAST LIMIT 1];
        Boolean isOldOppUpdated = false;
        
        for(Opportunity oppInst : listNewRecords) {
            
            Opportunity oppOldInst = mapOldRecords != null ? mapOldRecords.get(oppInst.Id) : null;
            
            if(oppOldInst == null || oppInst.Amount != oppOldInst.Amount)
                if(oppInst.Amount > highestAmtOppo.Amount) {
                    oppInst.Is_Highest_Amount__c = true;
                    isOldOppUpdated = true;
                }
        }
        
        if(isOldOppUpdated) {
            highestAmtOppo.Is_Highest_Amount__c = false;
            UPDATE highestAmtOppo;
        }
    }
    
    
    public static void beforeUpdate(Map<Id, Opportunity> mapOldRecords, Map<Id, Opportunity> mapNewRecords) {
        
        Opportunity highestAmtOppo = [SELECT Id, Is_Highest_Amount__c, Amount FROM Opportunity WHERE Is_Highest_Amount__c = true ORDER BY Amount DESC NULLS LAST LIMIT 1];
        Boolean isOldOppUpdated = false;
        
        for(Opportunity oppNewInst : mapNewRecords.values()) {
            
            Opportunity oppOldInst = mapOldRecords.get(oppNewInst.Id);
            
            //if()
            
        }
        
        
    }
    
    
    
    public void handleDupOppInsertUpdate(List<Opportunity> lstNewOpportunity, Map<Id, Opportunity> mapOldOpportunity, Boolean isUpdate) {
        
        Set<String> setPhoneNumEmail = new Set<String>();
        
        List<Opportunity> lstAllOpportunities = [ SELECT Id, Phone_Number__c, Email__c FROM Opportunity WHERE Phone_Number__c != NULL AND Email__c != NULL ];
        
        for(Opportunity eachOpp : lstAllOpportunities) {
            setPhoneNumEmail.add(eachOpp.Phone_Number__c+eachOpp.Email__c);
        }
        
        for(Opportunity eachNewOpp : lstNewOpportunity) {
            if(isUpdate) {
                if((eachNewOpp.Phone_Number__c != mapOldOpportunity.get(eachNewOpp.Id).Phone_Number__c || eachNewOpp.Email__c != mapOldOpportunity.get(eachNewOpp.Id).Email__c) && setPhoneNumEmail.contains(eachNewOpp.Phone_Number__c+eachNewOpp.Email__c)){
                    eachNewOpp.addError('Opportunity exists with entered Phone Number and Email');
                }
            } else {
                if((eachNewOpp.Phone_Number__c != null && eachNewOpp.Email__c != null) && setPhoneNumEmail.contains(eachNewOpp.Phone_Number__c+eachNewOpp.Email__c)) {
                    eachNewOpp.addError('Opportunity exists with entered Phone Number and Email');
                }
            }
        }
    }
}
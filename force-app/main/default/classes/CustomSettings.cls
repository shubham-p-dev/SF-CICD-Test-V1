public class CustomSettings {
    
    public static void useCustomSettings() {
        
        Map<String,PhoneCodes__c> phoneCodesMap = PhoneCodes__c.getAll();
        
        system.debug('phoneCodesMap '+phoneCodesMap.keySet());
        system.debug('phoneCodesMap '+phoneCodesMap.values());
        
        for(PhoneCodes__c each : phoneCodesMap.values()) {
            system.debug('each '+each);
        }
        
        for(integer i=0;i<10;i++) {
            system.debug([SELECT Id, Name, API_Name__c FROM dynamicObjectsForSOQL__c]);
        }
        
    }

}
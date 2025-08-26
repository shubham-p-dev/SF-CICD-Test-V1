trigger CreateContactOnIndustry on Account(after insert, after update) {
    
    if(Trigger.isInsert || Trigger.isUpdate) {
        
        List<Contact> conListToInsert = new List<Contact>();
        Set<Id> setAccId = new Set<Id>();
        
        for(Account accObj : Trigger.new){
            setAccId.add(accObj.Id);
        }
        
        Map<Id, Set<String>> mapAccIdListConName = new Map<Id, Set<String>>();
        
        for(Contact conObj : [SELECT Id, Name, AccountId FROM Contact WHERE AccountId IN :setAccId]) {
            if(!mapAccIdListConName.containsKey(conObj.AccountId)){
                mapAccIdListConName.put(conObj.AccountId, new Set<String>());
            }
            mapAccIdListConName.get(conObj.AccountId).add(conObj.Name);
        }
        
        for(Account accObj : Trigger.new) {
            if(accObj.Industry == 'Clear' && 
               (Trigger.isInsert || 
               (Trigger.isUpdate && Trigger.oldMap.get(accObj.Id).Industry != 'Clear') &&
               !mapAccIdListConName.get(accObj.Id)?.contains(accObj.Name+'Industry'))) {
                
                Contact newCon = new Contact(LastName=accObj.Name+'Industry', 
                                             AccountId=accObj.Id);
                conListToInsert.add(newCon);
            }
        }	
        
        if(!conListToInsert.isEmpty()) {
            try {
                system.debug('create industry rec '+conListToInsert);
                INSERT conListToInsert;
            } catch(DmlException e) {
                System.debug('Error ' + e.getMessage());
            }
        }
    }
}





/*trigger CreateContactOnIndustry on Account(after insert, after update) {
    
    if(Trigger.isInsert || Trigger.isUpdate) {
        
        List<Contact> conListToInsert = new List<Contact>();
        Set<Id> setAccId = new Set<Id>();
        Map<Id, Set<String>> mapAccIdListConName = new Map<Id, Set<String>>();
        
        for(Account accObj : Trigger.new){
            setAccId.add(accObj.Id);
        }
        
        
        for(Contact conObj : [SELECT Id, Name FROM Contact WHERE AccountId IN : setAccId]) {
            if(mapAccIdListConName.ContainsKey(conObj.AccountId)){
                mapAccIdListConName.get(conObj.AccountId).add(conObj.Name+'Industry');
            } else {
                mapAccIdListConName.put(conObj.AccountId, new Set<String>{conObj.Name+'Industry'});	
            }
        }
        
        
        for(Account accObj : Trigger.new) {
            if((Trigger.isInsert && accObj.Industry == 'Clear') || (Trigger.isUpdate && Trigger.oldMap.get(accObj.Id).Industry != accObj.Industry && accObj.Industry == 'Clear' && !mapAccIdListConName.get(accObj.Id).contains(accObj.Name+'Industry'))) {
                Contact newCon = new Contact(LastName=accObj.Name+'Industry', 
                                             AccountId = accObj.Id);
                conListToInsert.add(newCon);
            }
        }	
        
        if(!conListToInsert.isEmpty()) INSERT conListToInsert;
    }
}*/
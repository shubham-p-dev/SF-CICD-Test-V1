public class AccountTriggerHandler {
    
    
    public static void getShippingAddFromBillingAdd(List<Account> listNewAccounts) {
        
        for (Account thisAccountInst : listNewAccounts) {
            
            if(String.isBlank(thisAccountInst.ShippingStreet)) { thisAccountInst.ShippingStreet = thisAccountInst.billingStreet; }
            if(String.isBlank(thisAccountInst.ShippingCity)) { thisAccountInst.ShippingCity = thisAccountInst.billingCity; }
            if(String.isBlank(thisAccountInst.ShippingState)) { thisAccountInst.ShippingState = thisAccountInst.billingState; }
            if(String.isBlank(thisAccountInst.ShippingCountry)) { thisAccountInst.ShippingCountry = thisAccountInst.billingCountry; }
            if(String.isBlank(thisAccountInst.ShippingPostalCode)) { thisAccountInst.ShippingPostalCode = thisAccountInst.billingPostalCode; }
        }
    }
    
    
    
    public static void createRelatedContact(List<Account> listNewAccounts, Map<Id, Account> mapNewAccounts) {
        
        List<Contact> newContactListToInsert = new List<Contact>();
        
        for(Account thisAccountInst : listNewAccounts) {
            newContactListToInsert.add(
                new Contact(LastName = thisAccountInst.Name, AccountId = thisAccountInst.Id)
                );
        }
        
        if(!newContactListToInsert.isEmpty()) {
            INSERT newContactListToInsert;
        }
    }
    
    
    
    public static void accountNameUpdateValidation(Map<Id, Account> mapOldAccounts, Map<Id, Account> mapNewAccounts) {
        
        for(Account newAccountInst : mapNewAccounts.values()) {
            
            Account oldAccountInst = mapOldAccounts.get(newAccountInst.Id);
            
            if (newAccountInst.Name != oldAccountInst.Name) {
                newAccountInst.Name.addError('Account name cannot be updated!');
            }
        }
        
    }
    
    
    
    public static void updateMailingAddressOnContacts(Map<Id, Account> mapOldAccounts, Map<Id, Account> mapNewAccounts) {
        
        Map<Id, Account> mapMailingAddUpdatedAccounts = new Map<Id, Account>();
        List<Contact> contactListToUpdate = new List<Contact>();
        
        for(Account newAccountInst : mapNewAccounts.values()) {
            
            Account oldAccountInst = mapOldAccounts.get(newAccountInst.Id);
            
            if(
                newAccountInst.ShippingStreet != oldAccountInst.ShippingStreet ||
                newAccountInst.ShippingCity != oldAccountInst.ShippingCity ||
                newAccountInst.ShippingState != oldAccountInst.ShippingState ||
                newAccountInst.ShippingCountry != oldAccountInst.ShippingCountry ||
                newAccountInst.ShippingPostalCode != oldAccountInst.ShippingPostalCode
            ) {
                mapMailingAddUpdatedAccounts.put(newAccountInst.Id, newAccountInst);
            }
        }
        
        
        for(Contact thisContactInst : [SELECT Id, AccountId FROM Contact WHERE AccountId IN : mapMailingAddUpdatedAccounts.keySet()]) {
            
            Account relatedAccount = mapMailingAddUpdatedAccounts.get(thisContactInst.AccountId);
            
            thisContactInst.MailingStreet = relatedAccount.ShippingStreet;
            thisContactInst.MailingCity = relatedAccount.ShippingCity;
            thisContactInst.MailingState = relatedAccount.ShippingState;
            thisContactInst.MailingCountry = relatedAccount.ShippingCountry;
            thisContactInst.MailingPostalCode = relatedAccount.ShippingPostalCode;
            
            contactListToUpdate.add(thisContactInst);
        }
        
        if (!contactListToUpdate.isEmpty()) {
            UPDATE contactListToUpdate;
        }
        
    }
    
    
    public static void validateActiveAccountBeforeDelete(Map<Id, Account> mapOldAccounts) {
        
        for(Account thisAccountInst : mapOldAccounts.values()) {
            
            if (thisAccountInst.Active__c == 'Yes') {
                thisAccountInst.Active__c.addError('Active account can not be deleted!');
            }
        }
    }
    
    
    
    public static void accountDeletedEmailMessage(Map<Id, Account> mapOldAccounts) {
        
        List<Messaging.SingleEmailMessage> listEmailMessages = new List<Messaging.SingleEmailMessage>();
        
        for(Account thisAccountInst : mapOldAccounts.values()) {
            
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            emailMsg.setSubject('Account Deleted : '+thisAccountInst.Name);
            emailMsg.setToAddresses(new List<String>{ UserInfo.getUserEmail() });
            emailMsg.setPlainTextBody('This is some body!');
            
            listEmailMessages.add(emailMsg);
        }
        
        if (!listEmailMessages.isEmpty()) {
            Messaging.sendEmail(listEmailMessages);
        }
    }
    
    
    
    public static void accountRestoredEmailMessage(Map<Id, Account> mapNewAccounts) {
        
        List<Messaging.SingleEmailMessage> listEmailMessages = new List<Messaging.SingleEmailMessage>();
        
        for(Account thisAccountInst : mapNewAccounts.values()) {
            
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            emailMsg.setSubject('Account Restored : '+thisAccountInst.Name);
            emailMsg.setToAddresses(new List<String>{ UserInfo.getUserEmail() });
            emailMsg.setPlainTextBody('This is some body!');
            
            listEmailMessages.add(emailMsg);
        }
        
        if (!listEmailMessages.isEmpty()) {
            Messaging.sendEmail(listEmailMessages);
        }
    }
    
    
}
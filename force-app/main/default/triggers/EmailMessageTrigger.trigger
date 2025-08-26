trigger EmailMessageTrigger on EmailMessage (before insert) {
	
    
    if(Trigger.isBefore && Trigger.isInsert) {
        
       // System.debug('New mails --> '+Trigger.new);
        
    }
    
    if(Trigger.isAfter && Trigger.isInsert) {
        
        System.debug('New mails --> '+Trigger.new);        
    }    
    
    
}
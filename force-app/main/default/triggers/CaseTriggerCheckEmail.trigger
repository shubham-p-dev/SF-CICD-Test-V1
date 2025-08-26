trigger CaseTriggerCheckEmail on Case (before insert, after insert) {

    if(Trigger.isBefore && Trigger.isInsert) {   
    }
    
    if(Trigger.isAfter && Trigger.isInsert) {
        
       /* System.debug('Time stamp --> '+System.now());
        System.debug('New Cases --> '+Trigger.new);
        
        DateTime fiveMinutesAgo = System.now().addMinutes(-5);
        
        List<Case> recentCases = [SELECT Id, CaseNumber, Subject, CreatedDate 
                                  FROM Case 
                                  WHERE CreatedDate >= :fiveMinutesAgo];
        System.debug('Recent Cases: ' + recentCases);        
        
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        email.setToAddresses(new String[] {'shubhamrpatil298@gmail.com'}); // replace with recipient's email address
        email.setSubject('Acknowledgement email');
        email.setPlainTextBody('Thanks for connecting with support');
        email.setHtmlBody('<h4>Thanks for connecting with support</h4>');
        
        emails.add(email);
        
        Messaging.sendEmail(emails);     */
    }    
    
}
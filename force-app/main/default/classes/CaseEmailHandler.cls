public class CaseEmailHandler {

    // Define the Invocable Method
    @InvocableMethod(label='Check Case and Send Email' description='Check for cases with same Subject, Description, ContactEmail, and SuppliedEmail in the last minute. Send email if none exists.')
    public static void checkCaseAndSendEmail(List<Id> caseIds) {
        
        System.debug('Called from flow -->'+caseIds);
        
        try{
        Map<String, List<Case>> mapCaseSubjectLstCases = new Map<String, List<Case>>();
        List<Case> lstUniquePriorityCases = new List<Case>();
        List<Case> lstDuplicateCases = new List<Case>();
        Set<Id> setUniquePriorityCaseIds = new Set<Id>();
        
        Map<String, Set<String>> mapSubSuppMailPrioMails = new Map<String, Set<String>>();
        Map<Id, String> mapCaseIdPriorityMail = new Map<Id, String>();
        
        List<EmailMessage> lstCaseRelatedEmailMsg = [SELECT Id, Subject, FromAddress, ToAddress, CcAddress, 
                                                     BccAddress FROM EmailMessage WHERE ParentId IN : caseIds];
        
        
        /*List<EmailToCasePriority__mdt> lstEmailToCasePriority = [SELECT DeveloperName, MasterLabel, 
                  Case_Priority_Number__c, Email__c FROM EmailToCasePriority__mdt];
        
       
        for(EmailMessage emailObj : lstCaseRelatedEmailMsg) {
            
            Set<String> allToCcBccEmailSet = new Set<String>();
            
            allToCcBccEmailSet.addAll(emailObj.ToAddress.split(';'));
            allToCcBccEmailSet.addAll(emailObj.CcAddress.split(';'));
            allToCcBccEmailSet.addAll(emailObj.BccAddress.split(';'));
            mapSubSuppMailPrioMails.put(emailObj.Subject+emailObj.FromAddress, allToCcBccEmailSet);
        }*/
        
        
        
        
        
        //cgpt
        //Map<String, Set<String>> mapSubSuppMailPrioMails2 = new Map<String, Set<String>>();
        
        //List<EmailMessage> lstCaseRelatedEmailMsg2 = [SELECT Id, Subject, FromAddress, ToAddress, CcAddress, BccAddress FROM EmailMessage WHERE ParentId IN :caseIds];
        
        List<EmailToCasePriority__mdt> lstEmailToCasePriorityMDT = [SELECT DeveloperName, MasterLabel, Case_Priority_Number__c, Email__c FROM EmailToCasePriority__mdt];
        
        // Create a Map to hold email priorities
        Map<String, Integer> emailPriorityMap = new Map<String, Integer>();
        
        // Populate the emailPriorityMap with emails and their priorities
        for (EmailToCasePriority__mdt metaRecord : lstEmailToCasePriorityMDT) {
            emailPriorityMap.put(metaRecord.Email__c, Integer.valueOf(metaRecord.Case_Priority_Number__c));
        }
        
        // Process each EmailMessage
        for (EmailMessage emailObj : lstCaseRelatedEmailMsg) {
            Set<String> allToCcBccEmailSet = new Set<String>();
            
            if(!String.isBlank(emailObj.ToAddress)) allToCcBccEmailSet.addAll(emailObj.ToAddress.split(';'));
            if(!String.isBlank(emailObj.CcAddress)) allToCcBccEmailSet.addAll(emailObj.CcAddress.split(';'));
            if(!String.isBlank(emailObj.BccAddress)) allToCcBccEmailSet.addAll(emailObj.BccAddress.split(';'));
            
            // Convert Set to List for sorting
            List<String> emailList = new List<String>(allToCcBccEmailSet);
            
            // Sort emails by priority using a bubble sort approach
            for (Integer i = 0; i < emailList.size(); i++) {
                for (Integer j = i + 1; j < emailList.size(); j++) {
                    Integer priorityI = emailPriorityMap.get(emailList[i]);
                    Integer priorityJ = emailPriorityMap.get(emailList[j]);
                    
                    // If priority is null, assign a default high value
                    if (priorityI == null) priorityI = 9999;
                    if (priorityJ == null) priorityJ = 9999;
                    
                    if (priorityI > priorityJ) {
                        // Swap if the current email has a higher priority number
                        String temp = emailList[i];
                        emailList[i] = emailList[j];
                        emailList[j] = temp;
                    }
                }
            }
            
            // Rebuild the set with sorted emails
            allToCcBccEmailSet.clear();
            allToCcBccEmailSet.addAll(emailList);
            
            mapSubSuppMailPrioMails.put(emailObj.Subject + emailObj.FromAddress, allToCcBccEmailSet);
        }

        
        
        
        
        
        
        
        
        List<Case> lstProcessingCases = [SELECT Id, CaseNumber, Subject, CreatedDate, ParentId, SuppliedEmail
                                         FROM Case WHERE Id IN : caseIds ];
        
        for(Case caseObj : lstProcessingCases) {
            if(!mapCaseSubjectLstCases.ContainsKey(caseObj.Subject+caseObj.SuppliedEmail)) {
                mapCaseSubjectLstCases.put(caseObj.Subject+caseObj.SuppliedEmail, new List<Case>());
            } 
            mapCaseSubjectLstCases.get(caseObj.Subject+caseObj.SuppliedEmail).add(caseObj);
        }
        
        
        for(String caseSubSuppEmail : mapCaseSubjectLstCases.KeySet()) {
            
            List<Case> lstSameCases = mapCaseSubjectLstCases.get(caseSubSuppEmail);
            //set to list convert
            List<String> lstPriorityEmails = new List<String>(mapSubSuppMailPrioMails.get(caseSubSuppEmail));
            
            if(!lstSameCases.isEmpty()) {
                
                Case priorityCase = lstSameCases[0];
                priorityCase.ContactId = '003J3000003sZRiIAM';
                if(!lstPriorityEmails.isEmpty()) {
                    priorityCase.Priority_Email__c = lstPriorityEmails[0];
                }
                lstUniquePriorityCases.add(priorityCase);
                
                for (Integer i = 1; i < lstSameCases.size(); i++) {
                    
                    Case eachDupCase = lstSameCases[i];
                    if(i < lstPriorityEmails.size() && lstPriorityEmails[i] != null) {
                        eachDupCase.ContactId = '003J3000003sZRiIAM';
                        eachDupCase.Priority_Email__c = lstPriorityEmails[i];   
                    }
                    lstDuplicateCases.add(eachDupCase);
                }
            }
        }
        
        for(Case caseObj : lstUniquePriorityCases) {
            setUniquePriorityCaseIds.add(caseObj.Id);
        }
        
        
        for(Case caseObj : lstDuplicateCases) {
            
            List<Case> relatedDupCases = mapCaseSubjectLstCases.get(caseObj.Subject+caseObj.SuppliedEmail);
            
            if(!relatedDupCases.isEmpty()) {
                caseObj.ParentId = relatedDupCases[0].Id;
            }
            caseObj.Description = 'Duplicate';
            //Assigning case Owner as Spam Queue
            //caseObj.OwnerId = '00G2x000000WvOQEA0';
            //This picklist value is inactive
            //caseObj.User_Role_Type__c = 'Spam Queue';
        }
        
        if(!lstDuplicateCases.isEmpty()) {
            UPDATE lstDuplicateCases;
        }
        
        System.debug('mapCaseSubjectLstCases --> '+mapCaseSubjectLstCases);
        System.debug('lstUniquePriorityCases --> '+lstUniquePriorityCases);
        System.debug('lstDuplicateCases --> '+lstDuplicateCases);
        System.debug('setUniquePriorityCaseIds --> '+setUniquePriorityCaseIds);
        
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        EmailTemplate emailTem = [SELECT Id, DeveloperName,  Subject, HtmlValue 
                    FROM EmailTemplate WHERE DeveloperName = 'Case_ACK'];
            
        for(Case caseObj : lstUniquePriorityCases) {
            
            /*Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            email.setToAddresses(new String[] {caseObj.SuppliedEmail});
            email.setSubject('Acknowledgement email case num --> '+caseObj.CaseNumber);
            email.setTargetObjectId(caseObj.ContactId);
            email.setTemplateId(emailTem.Id);
            email.setWhatId(caseObj.Id);*/
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { caseObj.SuppliedEmail });
            //email.setSubject('Acknowledgement email case num --> ' + caseObj.CaseNumber);
            email.setTargetObjectId(caseObj.ContactId);
            email.setTemplateId(emailTem.Id);
            email.setWhatId(caseObj.Id);
            email.setSaveAsActivity(true);
            
            // email.setPlainTextBody('Thanks for connecting with support');
            // email.setHtmlBody('<h4>Thanks for connecting with support</h4>');
            
            //email.setSaveAsActivity(true);
            
            
            emails.add(email);
        }
        
        system.debug('Emails --> '+emails);
		
            if (!lstUniquePriorityCases.isEmpty()) {
                UPDATE lstUniquePriorityCases;                      
            }
            
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);                      
        }
            
        } catch(Exception e){
            System.debug('***Exception');
            System.debug('Exception Type: ' + e.getTypeName());
            System.debug('Exception Message: ' + e.getMessage());
            System.debug('Exception Line Number: ' + e.getLineNumber());
        }
    }

    
            /*Map<String, Map<String, String>> mapToEmailDetails = new Map<String, Map<String, String>>();
        
        DateTime oneMinuteAgo = System.now().addMinutes(-1);
        List<String> listMailSubject = new List<String>();
        List<String> listMailDescription = new List<String>();
        List<String> listMailContactEmail = new List<String>();
        List<String> listMailSuppliedEmail = new List<String>();
        
        List<Case> lstProcessingCases = [SELECT Id, Subject, Description, ContactEmail, SuppliedEmail, CreatedDate,
                                         CaseNumber FROM Case WHERE Id IN : caseIds ];*/
        
       /* List<Case> matchingCases = [SELECT Id, Subject, Description, ContactEmail, SuppliedEmail, CreatedDate,
                                    CaseNumber FROM Case 
                                    WHERE CreatedDate >= :oneMinuteAgo];*/
        
        
        /*for(Case caseObj : lstProcessingCases) {
            if(mapToEmailDetails.ContainsKey(caseObj.SuppliedEmail)) {
                mapToEmailDetails.put(caseObj.SuppliedEmail, new Map<String, String>());
            }
            
            mapToEmailDetails.put(caseObj.SuppliedEmail,
                                  new Map<String, String> {
                                      	'SuppliedEmail' => caseObj.SuppliedEmail,
                                          'setSubject' => 'Acknowledgement email case num --> '+caseObj.CaseNumber,
                                          'setPlainTextBody' => 'Thanks for connecting with support',
                                          'setHtmlBody' => '<h4>Thanks for connecting with support</h4>'                                   
                                          });
                }
        

        for(String toMail : mapToEmailDetails.KeySet()) {

        	Map<String, String> emailDetails = mapToEmailDetails.get(toMail);
            
                   Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                   
                   email.setToAddresses(new String[] {emailDetails.get('SuppliedEmail')});
                   email.setSubject(emailDetails.get('setSubject'));
                   email.setPlainTextBody(emailDetails.get('setPlainTextBody'));
                   email.setHtmlBody(emailDetails.get('setHtmlBody'));
                   
                   emails.add(email);            
        }*/
        
        //for(Case caseObj : lstProcessingCases) {
}
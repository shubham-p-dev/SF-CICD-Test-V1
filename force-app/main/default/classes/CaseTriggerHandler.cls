public with sharing class CaseTriggerHandler {


    public static void handleCreateZendeskTicket(List<Case> listNewCaseRecords) {

        String jsonStringBody;

        if(!listNewCaseRecords.isEmpty()) {

            Case thisCaseInstRec = listNewCaseRecords[0];

            SD_ZendeskRequestBodyWrapper reqBodyWrap = new SD_ZendeskRequestBodyWrapper();

            reqBodyWrap.ticket.comment.body = thisCaseInstRec.Description;
            reqBodyWrap.ticket.priority = thisCaseInstRec.Priority;
            reqBodyWrap.ticket.subject = thisCaseInstRec.Subject;
            reqBodyWrap.ticket.requester.locale_id = 8;
            reqBodyWrap.ticket.requester.name = thisCaseInstRec.SuppliedName;
            reqBodyWrap.ticket.requester.email = thisCaseInstRec.ContactEmail;

            jsonStringBody = JSON.serialize(reqBodyWrap);
            System.debug('jsonStringBody in case --> '+jsonStringBody);
        }

        if (String.isNotBlank(jsonStringBody)) {
            makeCaseCreationCallout(jsonStringBody);
        }
    }


    @future(callout=true)
    public static void makeCaseCreationCallout(String jsonStringBody) {
        SD_ZendeskApiController.createNewTicket(jsonStringBody);
    }

}
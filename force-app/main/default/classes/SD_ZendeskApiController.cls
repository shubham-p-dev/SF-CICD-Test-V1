public with sharing class SD_ZendeskApiController {


    public static void createNewTicket(String jsonStringBody) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();

        String authKeyString = System.Label.Zendesk_Username + ':' + System.Label.Zendesk_Api_Token;
        Blob authKeyBlob = Blob.valueOf(authKeyString);
        String authKeyStringBase64 = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(authKeyString));

        request.setEndPoint('https://test-2072.zendesk.com/api/v2/tickets');
        request.setMethod('POST');
        request.setHeader('Authorization', authKeyStringBase64);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        //can be set JSON/XML

        System.debug('get body in api call --> '+jsonStringBody);

        request.setBody(jsonStringBody);

        try {
        
            response = http.send(request);
            
            System.debug('This status code -->'+response.getStatusCode());

            if (response.getStatusCode() == 201) {
                System.debug('Request Status --> '+response.getStatus());
                System.debug('Response Body --> '+response.getBody());
            }else {
                System.debug('Something went wrong --> '+response.getBody());
            }
            
        } catch (Exception ex) {
            System.debug('Exception message --> '+ex.getMessage());
        }

    }
 

    public static String getRequestBody() {

        String reqBody = '{'+ 
        '  "ticket": {'+
        '    "comment": {'+
        '      "body": "This is created from apex."'+
        '    },'+
        '    "priority": "urgent",'+
        '    "subject": "This ticked is created from apex!",'+
        '    "requester": {'+
        '        "locale_id": 8,'+
        '        "name": "Pablo",'+
        '        "email": "pablito@example.org"'+
        '    }'+
        '  }'+
        '}';

        return reqBody;
    } 


}
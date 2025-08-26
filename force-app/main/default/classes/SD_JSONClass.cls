public with sharing class SD_JSONClass {


    public static void jsonDeserializeExample() {

        //JSON.deserialize we use to map response coming from api with class(object) so its easy to work
        //for further logic

        String jsonString = getRequestBodyString();

        clientCredentialsResponseWrapper obj = (clientCredentialsResponseWrapper) JSON.deserialize(jsonString, clientCredentialsResponseWrapper.class);

        System.debug('Access Token: ' + obj.access_token.substring(15));
        System.debug('obj scope --> '+obj.scope);
    }


    public static void jsonDeserializeUntypedExample() {

        //JSON.deserializeUntyped we use when we know that the JSON string we are working with is simple and do not have nested object

        String jsonString = getRequestBodyString();

        Map<String, Object> obj = (Map<String, Object>) JSON.deserializeUntyped(jsonString);

        System.debug('Access Token: ' + obj?.get('access_token'));
        System.debug('obj scope --> '+obj?.get('scope'));
    }


    public static void jsonDeserializeStrictExample() {

        //JSON.deserializeStrict we use when we have to process the JSON with high precision
        //wrapper class must have all keys present in JSON string 
        //eg some name key is present in JSON string but not in class(wrapper) it will throw JSON Exception
        //comment any variable from clientCredentialsResponseWrapper and run method
        //19:39:19:056 FATAL_ERROR System.JSONException: Unknown field: SD_JSONClass.clientCredentialsResponseWrapper.id

        String jsonString = getRequestBodyString();

        clientCredentialsResponseWrapper obj = (clientCredentialsResponseWrapper) JSON.deserializeStrict(jsonString, clientCredentialsResponseWrapper.class);

        System.debug('Access Token: ' + obj.access_token.substring(15));
        System.debug('obj scope --> '+obj.scope);
    }


    public static void jsonSerializeExample() {

        //JSON.serialize we use to convert any class(eg. Account/List/Wrapper) in to JSON string
        //used while making callout to convert objects to string format to pass it in request body 

        String jsonStringOriginal = getRequestBodyString();

        //converted to class(object/wrapper)
        clientCredentialsResponseWrapper obj = (clientCredentialsResponseWrapper) JSON.deserialize(jsonStringOriginal, clientCredentialsResponseWrapper.class);

        System.debug('Access Token: ' + obj.access_token.substring(15));
        System.debug('obj scope --> '+obj.scope);
        
        //convert class to string 
        String jsonString = JSON.serialize(obj);
        System.debug('jsonString --> '+jsonString);
        
        //convert class to string pretty
        String jsonStringPretty = JSON.serializePretty(obj);
        System.debug('jsonStringPretty --> '+jsonStringPretty);

    }



    public static String getRequestBodyString() {

        String json =
        '{'+
        '    "access_token": "00D5i000008zU7Y!ARwAQGJK5cpkMcl_6b9pU.QHAmdjeFCQC_xrymgKrVmDX8Kc4ZkSs6rx7Eze0bDENOTtBU7OKQ3ekKJ3W1SklL3J5LKY9QcN",'+
        '    "signature": "vgUkSoqc6vOO8VSLDeDRrAEVF8J8mrqXptbeVMu4s3M=",'+
        '    "scope": "api id",'+
        '    "instance_url": "https://ibirdssoftservices-dev-ed.my.salesforce.com",'+
        '    "id": "https://login.salesforce.com/id/00D5i000008zU7YEAU/005J3000000rqbHIAQ",'+
        '    "token_type": "Bearer",'+
        '    "issued_at": "1754386368485"'+
        '}';

        return json;
    } 


    //This wrapper class maps with the Client Credentials integration flow response
    public class clientCredentialsResponseWrapper {
        public String access_token;
        public String signature;
        public String scope;
        public String instance_url;
      //  public String id;
        public String token_type;
        public String issued_at;
    }

}
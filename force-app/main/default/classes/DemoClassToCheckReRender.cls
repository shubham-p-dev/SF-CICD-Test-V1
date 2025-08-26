public with sharing class DemoClassToCheckReRender {


    @AuraEnabled
    public static string getSomeData(){

        Boolean firstCall = true;
        String message;

        if (firstCall) {
            message = 'Description field with old value';         
        } else {
            message = 'Description field has been updated';
        }

        return message;
    }



}
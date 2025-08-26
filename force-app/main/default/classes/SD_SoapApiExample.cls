global class SD_SoapApiExample {

    //webservice keyword is used to make an apex class as an apex SOAP
    //next step is to generate the WSDL and give it to source system
    webservice static Id createAccountContact(String accountContactName, Boolean isAccount) {

        Id idToReturn;

        if (isAccount) {
            
            Account accObj = new Account(Name = accountContactName);
            INSERT accObj;
            idToReturn = accObj.Id;

        } else {
            
            Contact conObj = new Contact(LastName = accountContactName);
            INSERT conObj;
            idToReturn = conObj.Id;

        }

        return idToReturn;
    }

}
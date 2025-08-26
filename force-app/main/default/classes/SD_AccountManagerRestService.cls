@RestResource(urlMapping = '/v1/AccountService/*')
global class SD_AccountManagerRestService {
    
    @HttpGet
    global static ResponseWrapperGetAccounts getListAccounts() {
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        List<Account> accounts = [SELECT Id, Name FROM Account];
        List<AccountDTO> simplified = new List<AccountDTO>();
        
        for (Account acc : accounts) {
            simplified.add(new AccountDTO(acc.Id, acc.Name));
        }
        
        ResponseWrapperGetAccounts response = new ResponseWrapperGetAccounts();
        response.total = simplified.size();
        response.accounts = simplified;
        
        
        // res.statusCode = 201;
        String narutoValue = req.headers.get('naruto');
        System.debug('narutoValue --> '+narutoValue);
        
        return response;
    }
    
    
    @HttpPost
    global static insertAccountResponseWrapper createAccountRecord() {
        
        RestRequest request = RestContext.request;
        System.debug('request --> '+System.JSON.serializePretty(request));
        
        RestResponse response = RestContext.response;
        System.debug('response --> '+System.JSON.serializePretty(response));
        
        String requestBodyString = request.requestBody.toString();
        
        AccountDataFromJsonBody obj = (AccountDataFromJsonBody) JSON.deserialize(requestBodyString, AccountDataFromJsonBody.class);
        
        System.debug('AccountDataFromJsonBody --> '+System.JSON.serializePretty(obj));
        
        Account newAccountInst = new Account(
            Name = obj?.accountName,
            Active__c = 'Yes',
            Phone = obj?.phone,
            RecordTypeId = '0125i000000MWuzAAG'
        );
        
        // INSERT newAccountInst;
        
        if (String.isNotBlank(newAccountInst.Id)) {
            response.statusCode = 201;
        } else {
            response.statusCode = 404;
        }
        
        return new insertAccountResponseWrapper(newAccountInst.Id, 'Account inserted success!');
        
        // return 'Account inserted success!';
    }
    
    
    
    /* Wrapper Classes */
    
    global class ResponseWrapperGetAccounts {
        public Integer total;
        public List<AccountDTO> accounts;
    }
    
    global class AccountDTO {
        public String Id;
        public String Name;
        
        public AccountDTO(String Id, String Name) {
            this.Id = Id;
            this.Name = Name;
        }
    }
    
    
    public class AccountDataFromJsonBody{
        public String accountName;
        public String phone;
    }
    
    
    global class insertAccountResponseWrapper{
        public String id;
        public String message;
        
        public insertAccountResponseWrapper(String id, String message) {
            this.id = id;
            this.message = message;
        }
    }
    
    
}
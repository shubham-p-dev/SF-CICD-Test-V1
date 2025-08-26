@RestResource(urlMapping='/servicerequestresttwo/*')
global class ServiceRequestRestAPIDemoTwo {
    
    @HttpPost
    global static void doPost(){
        
        string response;
        boolean status;
        
        list<contact> lstContactInsert = new list<contact>();
        list<case> lstservice = new list<case>();
        list<string> lstAadharNo = new list<string>();
        list<ResponseWrapper> responslist = new  list<ResponseWrapper>();
        ResponseWrapper resp = new ResponseWrapper();
        // map<string,contact> oldcontactmap = new map<string,contact>();
        //  map<string,contact> newcontactmap = new map<string,contact>();
        map<string,case> ServiceReqId = new map<string,case>();
        list<map<string,case>> responselist = new  list<map<string,case>>();
        
        //shubham
        Map<String, Contact> mapAadhaarContact = new Map<String, Contact>();
        
        try{            
            string jsonReq = RestContext.request.requestBody.toString();
            system.debug('jsonReq'+jsonReq);
            
            list<ServiceRequestWrapper> lstcustomer = (list<ServiceRequestWrapper>)JSON.deserialize(jsonReq,list<ServiceRequestWrapper>.class);
            
            for(ServiceRequestWrapper data: lstcustomer ){
                if(data.Adhaar != null && data.Adhaar != ''){ 
                    lstAadharNo.add(data.Adhaar);
                }
            }
            
            list<contact> Duplicate_Check = [select id,Aadhaar_Card_Number__c from contact where Aadhaar_Card_Number__c IN : lstAadharNo];
            
            for(contact co:Duplicate_Check){
                //oldcontactmap.put(co.Aadhaar_Card_Number__c,co);
                mapAadhaarContact.put(co.Aadhaar_Card_Number__c,co);
            }
            
            //shubham
            
            for(ServiceRequestWrapper each : lstcustomer) {
                
                if(mapAadhaarContact.get(each.Adhaar) == null) {
                    
                    contact con =new contact();
                    con.Salutation =each.Salutation;
                    con.FirstName = each.customerFirstName;
                    con.LastName =each.customerLastName;
                    con.Email = each.customerEmail;
                    con.Phone =each.mobileNo;
                    con.Aadhaar_Card_Number__c =each.Adhaar;
                    //a.Name=data.name;
                    lstContactInsert.add(con);
                }}
            
            if(!lstContactInsert.isEmpty()) {                	
                insert lstContactInsert;
                for(Contact eachCon : lstContactInsert) {
                    mapAadhaarContact.put(eachCon.Aadhaar_Card_Number__c,eachCon);
                }
            }
            
            
            if(!mapAadhaarContact.KeySet().isEmpty()) {
                
                for (ServiceRequestWrapper each : lstcustomer) {
                    
                    Contact customerContact = mapAadhaarContact.get(each.Adhaar);
                    
                    case c=new case();
                    c.ContactId = customerContact.Id;
                    //system.debug('contactid '+customerContact.id);
                    // c.Service_Request_Type__c = data.serviceRequestType;
                    c.Status = each.Status;
                    // c.Address_by_BP__c='a06C4000008q77FIAQ';
                    // c.Service_Required_For__c=data.serviceRequiredFor;
                    // c.Product_Category__c = data.productCategory;
                    c.Origin = each.serviceRequestChannel;
                    c.RecordTypeId = '0122x000000hZXYAA2';
                    lstservice.add(c);
                    ServiceReqId.put(each.Adhaar,c);
                    responselist.add(ServiceReqId);                                 
                }
            } 
            
            
            /*if(oldcontactmap.isEmpty()){

system.debug('oldcontactmap37'+oldcontactmap);

for(ServiceRequestWrapper data: lstcustomer ){                  
contact con =new contact();
con.Salutation =data.Salutation;
con.FirstName = data.customerFirstName;
con.LastName =data.customerLastName;
con.Email = data.customerEmail;
con.Phone =data.mobileNo;
con.Aadhaar_Card_Number__c =data.Adhaar;
//a.Name=data.name;
lstcon.add(con);
newcontactmap.put(data.Adhaar,con);

}
insert lstcon;

for(ServiceRequestWrapper data: lstcustomer ){
case c=new case();
c.ContactId =newcontactmap.get(data.Adhaar).id;
system.debug('contactid'+newcontactmap.get(data.Adhaar).id);
// c.Service_Request_Type__c=data.serviceRequestType;
c.Status =data.Status;
// c.Address_by_BP__c='a06C4000008q77FIAQ';
// c.Service_Required_For__c=data.serviceRequiredFor;
// c.Product_Category__c = data.productCategory;
c.Origin = data.serviceRequestChannel;
c.RecordTypeId='0122x000000hZXYAA2';
lstservice.add(c);
ServiceReqId.put(data.Adhaar,c);
responselist.add(ServiceReqId);

}



} else{
system.debug('oldcontactmap67'+oldcontactmap);
for(ServiceRequestWrapper data: lstcustomer ){

case c=new case();
c.ContactId =oldcontactmap.get(data.Adhaar).id;
//   c.Service_Request_Type__c=data.serviceRequestType;
c.Status =data.Status;
//    c.Address_by_BP__c='a06C4000008q77FIAQ';
//  c.Service_Required_For__c=data.serviceRequiredFor;
// c.Product_Category__c = data.productCategory;
c.Origin = data.serviceRequestChannel;
c.RecordTypeId='0122x000000hZXYAA2';
lstservice.add(c);
ServiceReqId.put(data.Adhaar,c);
responselist.add(ServiceReqId);
//  response = getResponse(true,'Success: Service Request Booked Successfully',ServiceReqId.get(data.customerEmail).id));

}
}*/
            
            //insert lstservice;
            Database.SaveResult[] srList = Database.insert(lstservice, false);
            
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    resp.status=true;
                    resp.message='Success: Service Request Booked Successfully';
                    resp.serviceRequestNo=sr.getId();
                    responslist.add(resp);
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                }
            }
            
            
            /*for(RequestJSONWrapper.ServiceRequestWrapper data: lstcustomer){
//response = getResponse(true,'Success: Service Request Booked Successfully',ServiceReqId.get(data.customerEmail).id);
resp.status=true;
resp.message='Success: Service Request Booked Successfully';
resp.serviceRequestNo=ServiceReqId.get(data.adhaar).id;
responslist.add(resp);
}*/
            
            
            string jsonresponse= JSON.serializePretty(responslist);
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = blob.valueOf(jsonresponse);
            
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            //ResponseWrapper resp=new ResponseWrapper();
            resp.status =false;
            resp.message=e.getMessage();
            resp.serviceRequestNo ='';
            String req = json.serialize(response);
            //response = getResponse(true,e.getMessage(),'');
            
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = blob.valueOf(req);
        }        
    }
    
    public class ServiceRequestWrapper{
        
        public string Salutation;
        public string customerFirstName;
        public string customerLastName;
        public string customerEmail;
        public string mobileNo;
        public string Adhaar;     
        public string serviceRequestType;
        public string Status;
        public string serviceRequiredFor;
        public string productCategory;
        public string serviceRequestChannel;
        
        public string LNTransferOrderCompany;
        public string LNTransferOrderNumber;
    }
    
    public class ResponseWrapper{
        public boolean status;
        public string message;
        public string serviceRequestNo;
        public list<case> lstcase;
    }
    
    public static string getResponse(boolean status, string message, string GUID){
        ResponseWrapper reswrapper =new ResponseWrapper();
        reswrapper.status = status;
        reswrapper.message =message;
        reswrapper.serviceRequestNo =GUID;
        return JSON.serialize(reswrapper);
    }      
}

/*

Customer Details
{

//account
Customer Type - B2B / B2C
IF B2B - BP Code
If B2C - Address Code

}

Service Request
{

//case
Record Type -= Interio Service Request 
Type = Installation/Break Fix/Dismantel


	//assets
	{
		Item Code = "dfadfa"
		Item Quantity 
	}
	{
		Item Code = "dfadfa"
		Item Quantity 
	}
	{
		Item Code = "dfadfa"
		Item Quantity 
	}
	{
		Item Code = "dfadfa"
		Item Quantity 
	}
}

*/
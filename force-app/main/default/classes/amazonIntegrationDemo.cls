@RestResource(urlMapping='/crmis-gamma-two.com/*')
global with sharing class amazonIntegrationDemo {
        
        @HttpGet
        global static ResponseData getData() {
            
            RestRequest req = RestContext.request;
            
            List<String> requestIds = new List<String>();
            
            if(req.params.get('request-ids-1') != null) requestIds.add(req.params.get('request-ids-1'));
            if(req.params.get('request-ids-2') != null) requestIds.add(req.params.get('request-ids-2'));
            if(req.params.get('request-ids-3') != null) requestIds.add(req.params.get('request-ids-3'));
            if(req.params.get('request-ids-4') != null) requestIds.add(req.params.get('request-ids-4'));
            if(req.params.get('request-ids-5') != null) requestIds.add(req.params.get('request-ids-5'));
            if(req.params.get('request-ids-6') != null) requestIds.add(req.params.get('request-ids-6'));
            if(req.params.get('request-ids-7') != null) requestIds.add(req.params.get('request-ids-7'));
            if(req.params.get('request-ids-8') != null) requestIds.add(req.params.get('request-ids-8'));
            if(req.params.get('request-ids-9') != null) requestIds.add(req.params.get('request-ids-9'));
            if(req.params.get('request-ids-10') != null) requestIds.add(req.params.get('request-ids-10'));
            
        	/*String requestId1 = req.params.get('request-ids-1');
        	String requestId2 = req.params.get('request-ids-2');
        	String requestId3 = req.params.get('request-ids-3');*/
            
            ResponseData responseData = new ResponseData();
            responseData.requests = new Map<String, Item>();
            responseData.lineItems = new Map<String, LineItem>();
            responseData.failedRequestIds = new List<FailedRequestId>();
            
            //Populating requests
            for (String requestId : requestIds) {
                Item request = new Item();
                request.id = requestId;
                request.lineItemId = requestId+'-ABCD';
                request.crmTicketId = 'srn'+requestId;
                request.status = 'Yet To Call';
                responseData.requests.put(requestId, request);
            }
            
            //Populating lineItems
            for (String requestId : requestIds) {
                
                LineItem lineItem = new LineItem();
                lineItem.orderId = requestId;
                lineItem.estimatedDeliveryDate = 1625267876;
                
                SingleItem singleItm = new SingleItem();
                singleItm.title = 'Philips Viva Collection HR1831/00 Juicer, 1.5-Litre, Ink Black';
                singleItm.modelNumber = 'Viva Collection HR1831/00';
                singleItm.brand = 'Philips';
                singleItm.category = 'Juicer';
                lineItem.item = singleItm;
                
                Customer customerData = new Customer();
                customerData.name = 'customer1';
                customerData.phoneNumber = '1234567890';
                customerData.email = 'abc@xyz.com';
                lineItem.customer = customerData;
                
                MailingAddress mailAddress = new MailingAddress();
                mailAddress.address = 'addresline1, addressline2, city - 114599, state, country';
                mailAddress.postalCode = '114599';
                mailAddress.city = 'Bengaluru';
                lineItem.mailingAddress = mailAddress;
                
                responseData.lineItems.put(requestId, lineItem);
            }
            
            // Populate failedRequestIds
            FailedRequestId failedRequestId = new FailedRequestId();
            failedRequestId.errorMsg = 'Requested InstallationRequestId 123-9998765-987654-9 doesn\'t exist in tracking table for vendor vikas.jain@lge.com';
            failedRequestId.failedId = '123-9998765-987654-9';
            failedRequestId.recoverable = false;
            responseData.failedRequestIds.add(failedRequestId);
            
            return responseData;
        }    
        
        global class Item {
            global String id;
            global String lineItemId;
            global String crmTicketId;
            global String status;
        }
        
        global class LineItem {
            global String orderId;
            global Long estimatedDeliveryDate;
            
            global SingleItem item;
            global Customer customer;
            global MailingAddress mailingAddress;
            
            /* global Item item;
            global String name;
            global String phoneNumber;
            global String email;
            global String address;
            global String postalCode;
            global String city;*/
        }
        
        global class FailedRequestId {
            global String errorMsg;
            global String failedId;
            global Boolean recoverable;
        }
        
        global class SingleItem {
            global String title;
            global String modelNumber;
            global String brand;
            global String Category;
        }
        
        global class Customer {
            global String name;
            global String phoneNumber;
            global String email;
        }
        
        global class MailingAddress {
            global String address;
            global String postalCode;
            global String city;    
        }
        
        global class ResponseData {
            global Map<String, Item> requests;
            global Map<String, LineItem> lineItems;
            global List<FailedRequestId> failedRequestIds;
        }
        
}
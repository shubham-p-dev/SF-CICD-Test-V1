@RestResource(urlMapping='/amazon-gen-order-demo/*')
global with sharing class AmazonGenericOrderDemo {
    
    @HttpPost
    global static void AmazonGenOrderDemo() {
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String jsonString = req.requestbody.toString();
        
        List<AccountObj> lstAccountsWrapper = (List<AccountObj>)JSON.deserialize(jsonString, List<AccountObj>.class);
        
        system.debug('lstAccounts size '+lstAccountsWrapper.size());
        
        Map<String, AccountObj> mapAccNameAccObj = new Map<String, AccountObj>();
        Map<Id, List<OrderItemObj>> mapAccIdOrderItems = new Map<Id, List<OrderItemObj>>();
        
        List<Account> lstAllAccounts = new List<Account>();
        List<Account> lstAccountsToInsert = new List<Account>();
        List<Order> ordersToInsert = new List<Order>();
        List<OrderItem> ordersItemsToInsert = new List<OrderItem>();
        
        
        for(AccountObj eachAcc : lstAccountsWrapper){
            
            Account acc = new Account();
            if(eachAcc.Id != null) acc.Id = eachAcc.Id;
            
            acc.Name = eachAcc.FirstName + eachAcc.LastName;
            
            //  acc.Salutation = eachAcc.Salutation;
            //  acc.FirstName = eachAcc.FirstName;
            //  acc.LastName = eachAcc.LastName;            
            //  acc.PersonMobilePhone = eachAcc.PersonMobilePhone;
            
			//personal org data
            acc.Active__c = eachAcc.Active;
          //  acc.SLA__c = eachAcc.SLA;
          //  acc.SLAExpirationDate__c = Date.valueOf(eachAcc.SLAExpirationDate);
          //  acc.SLASerialNumber__c = eachAcc.SLASerialNumber;
            
            if(eachAcc.Id == null || eachAcc.Id == ''){
                lstAccountsToInsert.add(acc);  
            } else {
                lstAllAccounts.add(acc);
            }
            
            mapAccNameAccObj.put(acc.Name+acc.Phone, eachAcc); 
        }        
        
        if(!lstAccountsToInsert.isEmpty()) {
            
            insert lstAccountsToInsert;
            
            for(Account eachAcc : lstAccountsToInsert) {
                system.debug('Each acc '+eachAcc);
                lstAllAccounts.add(eachAcc);
            }
        }
        
        
        for(Account eachAcc : lstAllAccounts) {
                        
            OrderObj orderWrapper = mapAccNameAccObj.get(eachAcc.Name+eachAcc.Phone).Order;
			List<OrderItemObj> OrderItemsList = mapAccNameAccObj.get(eachAcc.Name+eachAcc.Phone).OrderItems;   
            
            Order newOrder = new Order();        
            newOrder.AccountId = eachAcc.Id;
            newOrder.EffectiveDate = Date.valueof(orderWrapper.EffectiveDate);
            newOrder.Status = orderWrapper.status;
            newOrder.Pricebook2Id = orderWrapper.Pricebook2Id;
            //newOrder.Id = 'ID123';    
            
            system.debug('each newOrder '+newOrder);
            
            mapAccIdOrderItems.put(eachAcc.Id, OrderItemsList);
            ordersToInsert.add(newOrder);
        }
        
        
        if(!ordersToInsert.isEmpty()) {
           // insert ordersToInsert;
        }        
        
        
        for(Order eachOrder : ordersToInsert) {
            
            List<OrderItemObj> OrderItemsWrpper = mapAccIdOrderItems.get(eachOrder.AccountId);
            
            if(!OrderItemsWrpper.isEmpty()){
                ordersItemsToInsert.addAll(getOrderItems(eachOrder, OrderItemsWrpper));             
            }
        }
        
        if(!ordersItemsToInsert.isEmpty()) {
            
            for(OrderItem each : ordersItemsToInsert){
                system.debug('each OrderItem '+each);
            }
            
            //insert ordersItemsToInsert;
        }             
        
        res.statusCode = 200;
        res.responseBody = Blob.valueOf(JSON.Serialize(new Map<String, String>{'msg'=>'response from amazon-gen-order-demo'}));     
    }
    
    
    public static List<OrderItem> getOrderItems(Order order, List<OrderItemObj> wrapperOrderItems) {
        List<OrderItem> result = new List<OrderItem>();
        
        for(OrderItemObj eachOrderItem : wrapperOrderItems){
            OrderItem newOrderItem = new OrderItem();
            newOrderItem.Product2Id = eachOrderItem.Product2Id;   
            newOrderItem.OrderId = order.Id;   
            newOrderItem.Quantity = Decimal.valueOf(eachOrderItem.Quantity);  
            newOrderItem.ListPrice = Decimal.valueOf(eachOrderItem.ListPrice);   
            newOrderItem.UnitPrice = Decimal.valueOf(eachOrderItem.UnitPrice);   
            newOrderItem.PricebookEntryId = eachOrderItem.PricebookEntryId;   
            
            result.add(newOrderItem);
        }
                
        return result;
    }
    
    
    public class AccountObj{
        public String Id;
        public String Salutation;
        public String FirstName;
        public String LastName;
        public String PersonMobilePhone;
        public String BusinessUnitc;
        public String SubDivisionc;
        public String PersonEmail;
        public String RecordTypeId;
        public String AccountType;
        public String PaymentTerms;
        
        //personal org data
        public String Active;
        public String SLA;
        public String SLAExpirationDate;
        public String SLASerialNumber;

        public List<OrderItemObj> OrderItems;
        public OrderObj Order;
    }
    
    public class OrderObj{
        public String Id;
        public String AccountId;
        public String OrderType;
        public String PaymentTerms;
        public String EffectiveDate;
        public String status;
        public String ShipToAccount;
        public String ShiptoAreacode;
        public String SoldtoBusinessPartner;
        public String MHEDivision;
        public String LogisticsCompanyBranch;
        public String LineofBusiness;
        public String Area;
        public String SalesOrderSeries;
        public String BusinessUnit;
        public String SubDivision;
        public string OrderCurrency;
        public string RecordTypeId;
        
        public string Pricebook2Id;
    }
    
    public class OrderItemObj{
        public String Quantity;
        public String Product2Id;
        public String OrderId;
        public String ListPrice;
        public string PricebookEntryId;
        public string UnitPrice;        
    }    
}




/*




for(AccountObj eachAcc : lstAccounts){

Account updatedAcc = allAccDataMap.get(eachAcc.FirstName+eachAcc.PersonMobilePhone);

Order newOrder = new Order();        
if(updatedAcc != null) newOrder.AccountId = updatedAcc.Id;
newOrder.EffectiveDate = eachAcc.Order.EffectiveDate;
newOrder.Status = eachAcc.Order.status;  
newOrder.Id = 'ID123';  
ordersToInsert.add(newOrder);

}

system.debug('ordersToInsert line 68 '+ordersToInsert);

// insert ordersToInsert;


for(Integer i=0; i < lstAccounts.size(); i++) {

List<OrderItem> relatedListOrderItems = new List<OrderItem>();

system.debug('lstAccounts[i].OrderItems '+lstAccounts[i].OrderItems);

if(lstAccounts[i].OrderItems.size() > 0){
relatedListOrderItems = getOrderItems(ordersToInsert[i], lstAccounts[i].OrderItems);
}
ordersItemToInsert.addAll(relatedListOrderItems); 
}


*/
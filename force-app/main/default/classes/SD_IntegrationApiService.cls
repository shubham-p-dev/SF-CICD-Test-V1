public with sharing class SD_IntegrationApiService {


    public static void getMyIdAddress() {

        try {
            
        Http h = new Http();
        HttpRequest httpReq = new HttpRequest();
        HttpResponse response = new HttpResponse();

        httpReq.setEndPoint('https://api.ipify.org?format=json');
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json');
        httpReq.setMethod('GET');

        response = h.send(httpReq);

        System.debug('Satus Code --> '+response.getStatusCode());
        System.debug('Satus --> '+response.getStatus());

        IpifyResponseWrapper idAddressResponse = (IpifyResponseWrapper) JSON.deserialize(response.getBody(), IpifyResponseWrapper.class);
        String myIpAdd = idAddressResponse?.ip;

        System.debug('myIpAdd --> '+myIpAdd);

    } catch (Exception ex) {
            
    }

    }


    public static void getCurrencyExchangeRates() {

        try {
            
            Http h =  new Http();
            HttpRequest httpReq =  new HttpRequest();
            HttpResponse response =  new HttpResponse();

            httpReq.setEndPoint('https://open.er-api.com/v6/latest/usd');
            httpReq.setMethod('GET');
            httpReq.setHeader('Content-Type', 'application/json');
            httpReq.setHeader('Accept', 'application/json');

            response = h.send(httpReq);

            CurrencyExchangeRatesWrapper finalResponse = (CurrencyExchangeRatesWrapper) JSON.deserialize(response.getBody(), CurrencyExchangeRatesWrapper.class);

            System.debug('USD <> INR : '+finalResponse?.rates?.get('INR'));


        } catch (Exception ex) {
            
        }

    }


    public class IpifyResponseWrapper {
        private String ip;
    }


    public class CurrencyExchangeRatesWrapper {
        public String result;
        public String time_last_update_utc;
        public String time_next_update_utc;
        public String base_code;
        public Map<String, Decimal> rates;
    }


}
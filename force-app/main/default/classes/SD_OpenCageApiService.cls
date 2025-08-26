public with sharing class SD_OpenCageApiService {


    public static void getReverseGeocoding(Id accountId) {

        try {

        Account thisAccount = [SELECT Id, Location__Latitude__s, Location__Longitude__s FROM Account WHERE Id =: accountId LIMIT 1];
            
        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();

        String queryParams = thisAccount.Location__Latitude__s + ',' + thisAccount.Location__Longitude__s;

        httpReq.setEndPoint(System.Label.OpenCage_Base_URL+'/geocode/v1/json?key='+System.Label.OpenCage_Base_API_KEY+'&q='+queryParams+'&pretty=1');
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json');
        httpReq.setMethod('GET');

        httpRes = http.send(httpReq);

        if (httpRes.getStatusCode() == 200) {
            
            SD_OpenCageApiWrapper responseWrapper = (SD_OpenCageApiWrapper) System.JSON.deserialize(httpRes.getBody(), SD_OpenCageApiWrapper.class);

            if (!(responseWrapper?.results?.isEmpty())) {  

                SD_OpenCageApiWrapper.results thisResult = responseWrapper.results[0];
                SD_OpenCageApiWrapper.components thisComponenet = thisResult.components;

                thisAccount.BillingStreet = thisComponenet?.road;  
                thisAccount.BillingCity = thisComponenet?.city;  
                thisAccount.BillingState = thisComponenet?.state;  
                thisAccount.BillingPostalCode = thisComponenet?.postcode;  
                thisAccount.BillingCountry = thisComponenet?.country;  

                UPDATE thisAccount;
            }
        }

        } catch (Exception ex) {
                
        }

    }


    public static void getForwardGeocoding(Id accountId) {

        try {

        Account thisAccount = [SELECT Id, BillingStreet, BillingPostalCode, BillingCity, BillingCountry FROM Account WHERE Id =: accountId LIMIT 1];
            
        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();


        String fullAddress = thisAccount.BillingStreet + ', ' + thisAccount.BillingPostalCode + ', ' + thisAccount.BillingCity + ', ' + thisAccount.BillingCountry;
        String encodedAddress = EncodingUtil.urlEncode(fullAddress, 'UTF-8');

        //https://api.opencagedata.com/geocode/v1/json?key=0d7c69e3a559459da987f7ba712ac47f&q=Frauenplan+1%2C+99423+Weimar%2C+Germany&pretty=1
        
        httpReq.setEndPoint(System.Label.OpenCage_Base_URL+'/geocode/v1/json?key='+System.Label.OpenCage_Base_API_KEY+'&q='+encodedAddress+'&pretty=1');
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json');
        httpReq.setMethod('GET');

        httpRes = http.send(httpReq);

        if (httpRes.getStatusCode() == 200) {
            
            SD_OpenCageApiWrapper responseWrapper = (SD_OpenCageApiWrapper) System.JSON.deserialize(httpRes.getBody(), SD_OpenCageApiWrapper.class);

            if (!(responseWrapper?.results?.isEmpty())) {  

                SD_OpenCageApiWrapper.results thisResult = responseWrapper.results[0];
                SD_OpenCageApiWrapper.geometry thisGeometry = thisResult.geometry;

                thisAccount.Geolocation__Latitude__s = thisGeometry?.lat;  
                thisAccount.Geolocation__Longitude__s = thisGeometry?.lng;  
                
                UPDATE thisAccount;
            }
        }

        } catch (Exception ex) {
                
        }

    }


}
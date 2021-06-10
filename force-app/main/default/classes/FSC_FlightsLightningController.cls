/*********************************************************************************
Class Name      : FSC_FlightsLightningController
Description     : Controller to be used on the flights LWC, implements the HTTPCallout Framework to provide
				  Continuation support on HTTP requests
Created By      : Sebastian Torres
Created Date    : 2021-06-03
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-06-03              Initial version

*********************************************************************************/
public class FSC_FlightsLightningController {
    
    //Fetch data
    @AuraEnabled(cacheable=true continuation=true)
    public static Object fetchData() {
	    /*
		    You can also pass the list of requests in the constructor in case you don't want to use custom metadata
		*/
        /*
        HTTPRequest req = new HTTPRequest();
        req.setMethod('GET');
        req.setEndpoint('https://sfdcstop.herokuapp.com/blogs');
        HTTPRequest req1 = new HTTPRequest();
        req1.setMethod('GET');
        req1.setEndpoint('https://sfdcstop.herokuapp.com/apps');
        HTTPRequest req2 = new HTTPRequest();
        req2.setMethod('GET');
        req2.setEndpoint('https://sfdcstop.herokuapp.com/sessions');
        HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<HttpRequest> {req, req1, req2});        
		*/
        HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<String>{'MuleFlights'});
        return service.sendRequest('sendResponse');
    }
    
    //Send reponse method
    @AuraEnabled(cacheable=true)
    public static Object sendResponse(List<String> labels, Object state) {
        HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<String>{'MuleFlights'});
        List<HTTPResponse> responses = service.getResponse(labels);
        //RecordWrapper rWrapper = (RecordWrapper) JSON.deserialize(responses.get(0).getBody(), RecordWrapper.class);
        //ResponseWrapper wrapper = new ResponseWrapper();
        //wrapper.sessionData = sWrapper;
        //return JSON.serialize(rWrapper);
        
        List<FSC_FlightsRecordWrapper> lst = new List<FSC_FlightsRecordWrapper>();
        lst = (List<FSC_FlightsRecordWrapper>) JSON.deserialize(responses.get(0).getBody(),List<FSC_FlightsRecordWrapper>.class);
        system.debug('The list: ' + lst);
        return lst;
    }

}
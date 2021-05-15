/*********************************************************************************
Class Name      : Credomatic_ContinuationSupport
Description     : Main support class for async callouts using Continuation object. 
Created By      : Sebastian Torres
Created Date    : 2021-05-11
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-11              Initial version Work in progress

*********************************************************************************/
public with sharing class Credomatic_ContinuationSupport {
    
    // Test variable used holding the value of the Continuation.state.
    // Because the property is static, there can be only request in the method.
    @TestVisible
    private static String continuationState;
     
    // The function that fires the continuation
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startContinuation() {
        // Create the callout Request
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('<some URL or callout:NamedCredential here>');
 
        // Create the continuation with a 40s timeout
        Continuation con = new Continuation(40);
        con.ContinuationMethod = 'continuationCallback';
         
        // Store the HttRequest and make it accessible for a testing-context
        continuationState = con.addHttpRequest(req);
        con.state = continuationState;
 
        return con;
    }
 
    // The function that processes the continuation callback
    @AuraEnabled(cacheable=true)
    public static Object continuationCallback(Object state) {
        // Get the response
        HttpResponse response = Continuation.getResponse((String) state);
 
        Integer statusCode = response.getStatusCode();
        if (statusCode == 200) {
            return response.getBody();
        } else if(statusCode >= 2000) {
            // Handle continutation-specific error codes
            // See <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_System_Continuation.htm">https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_System_Continuation.htm</a>
            throw new AuraHandledException('Continuation Error: ' + statusCode + ' - ' + response.getBody());
        } else {
            // Handle standard HTTP request errors
            throw new AuraHandledException('HTTP Request Error: ' + statusCode + ' - ' + response.getBody());
        }
    }
}
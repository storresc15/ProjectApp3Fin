/*********************************************************************************
Class Name      : Credomatic_SEPOMEXService
Description     : Service Address Validation class for Mexico using Sepomex API
Created By      : Sebastian Torres
Created Date    : 2021-05-17
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-17              Initial version 

*********************************************************************************/
public class Credomatic_SEPOMEXService extends Credomatic_RestClient implements Credomatic_AddressValidationStrategy {
    
    private static final string DEFAULTNAMEDCREDENTIAL = 'sepomexmx';
    
    public Credomatic_SEPOMEXService() {
        namedCredentialName = DEFAULTNAMEDCREDENTIAL;
    }
    
    public String validateAddress(string state,string city, string street, string postalCode){
        
     //To implement in the future these two strings that contains the auth and token in order to make them configurable
     String authToken = '40f052e7-85ef-4279-ab9e-be61816e2497';   
        
     // Instantiate a new http object
    Http h = new Http();
	system.debug('The postal code: ' + postalCode);
    //String requestURL='callout:SmartyStreetsNC/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&street2=&city='+city+'&state='+state+'&zipcode='+postalCode;
    //String requestURL= 'https://us-street.api.smartystreets.com/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&street2=&city='+city+'&state='+state+'&zipcode='+postalCode;
    //String requestUrl = 'callout:SmartyStreetsNC/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&city='+validCity+'&state='+state+'&zipcode='+postalCode;
    String requestUrl = '/query/info_cp/' + postalCode + '?type=simplified&token=' + authToken;
    //String requestUrl2 = 'https://api.copomex.com/query/info_cp/76246?token=40f052e7-85ef-4279-ab9e-be61816e2497';    

   // Send the request, and return a response
    HttpResponse res = get(requestUrl);
    System.debug('The request URl SHOULD BE : https://api.copomex.com/query/info_cp/76246?token=40f052e7-85ef-4279-ab9e-be61816e2497');
	System.debug('This is what we are actually sending: ' + requestUrl);
        
    if(res.getStatusCode() == 200){

    string result=res.getBody();
    system.debug('^^^^^^'+result);

    List<Utility_SEPOMEXWrapper> wrapper =  (List<Utility_SEPOMEXWrapper>)JSON.deserialize(result,List<Utility_SEPOMEXWrapper>.class);
        if(wrapper[0].error == false) {
    system.debug('Success!!');
            return 'Success';
        } else {
           System.debug('Invalid Address');
            return 'Invalid Address';
        } 
        
    } else {
        System.debug('Error in Request: '+ res.getStatusCode());
        System.debug('These are the details: ' + res.getBody());
        return 'Error in Request '+ res.getStatusCode();
    }
        
    }
    
    

}
/*********************************************************************************
Class Name      : Credomatic_SmartyStreetsService
Description     : SMARTYStreet Address Validation class 
Created By      : Sebastian Torres
Created Date    : 2021-05-12
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-12              Initial version Work in progress

*********************************************************************************/
public class Credomatic_SmartyStreetsService extends Credomatic_RestClient implements Credomatic_AddressValidationStrategy {
    
    private static final string DEFAULTNAMEDCREDENTIAL = 'SmartyStreetsNC';
    
    public Credomatic_SmartyStreetsService() {
        namedCredentialName = DEFAULTNAMEDCREDENTIAL;
    }
    
    public String validateAddress(string state,string city, string street, string postalCode){
        
     //To implement in the future these two strings that contains the auth and token in order to make them configurable
     String authId = '8c976e28-18a3-00aa-e2a6-0d776c40ca6b';
     String authToken = 'G6TbbXnFnewSCnjDFQnY';   
        
     // Instantiate a new http object
    Http h = new Http();
    String validStreet = street.replace(' ', '%20');
    String validCity = city.replace(' ', '%20');

    //String requestURL='callout:SmartyStreetsNC/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&street2=&city='+city+'&state='+state+'&zipcode='+postalCode;
    //String requestURL= 'https://us-street.api.smartystreets.com/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&street2=&city='+city+'&state='+state+'&zipcode='+postalCode;
    //String requestUrl = 'callout:SmartyStreetsNC/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&city='+validCity+'&state='+state+'&zipcode='+postalCode;
    String requestUrl = '/street-address?auth-id='+ authId +'&auth-token='+ authToken +'&candidates=10&match=invalid&street='+validStreet+'&city='+validCity+'&state='+state+'&zipcode='+postalCode;

   // Send the request, and return a response
    HttpResponse res = get(requestUrl);

    if(res.getStatusCode() == 200){

    string result=res.getBody();
    system.debug('^^^^^^'+result);

    List<Utility_JSONStreetWrapper> wrapper =  (List<Utility_JSONStreetWrapper>)JSON.deserialize(result,List<Utility_JSONStreetWrapper>.class);
        if(wrapper[0].analysis.dpv_footnotes.contains('AA') || wrapper[0].analysis.dpv_footnotes.contains('BB')) {
    system.debug('Success!!');
            return 'Success';
        } else {
           System.debug('Invalid Address');
            return 'Invalid Address';
        } 
        
    } else {
        System.debug('Error in Request: '+ res.getStatusCode());
        return 'Error in Request '+ res.getStatusCode();
    }
        
    }

}
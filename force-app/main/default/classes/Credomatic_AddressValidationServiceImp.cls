/*********************************************************************************
Class Name      : Credomatic_AddressValidationServiceImp
Description     : Actual implementation of the address validation service
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-29              Initial version

*********************************************************************************/
public class Credomatic_AddressValidationServiceImp implements Credomatic_IAddressValidationService {
    
    public string validateAddressSingle(string country,string state,string city, string street, string postalCode) 
    {
        String response;
        
        Credomatic_AddressValidationStrategy validationService = getStrategy(country);
        response = validationService.validateAddress(state, city, street, postalCode);
        
        return response;
        
    }
    
    public void validateAccountAddress(Account a)
    {
        
    }
    public void validateAccountAddressBulk(List<Account> accs)
    {
        
    }
    
    private Credomatic_AddressValidationStrategy getStrategy(String countryCode)
    {
        Credomatic_AddressValidationStrategy countryStrategy;
        //Use custom metadata for reflection
        Type t = Type.forName(Credomatic_Application.AddressValidation_Service(countryCode));
        //Credomatic_Application.AddressValidation_Service(mdName)
        Credomatic_AddressValidationStrategy retVal = (Credomatic_AddressValidationStrategy)t.newInstance();
        return retVal;
        
    }

}
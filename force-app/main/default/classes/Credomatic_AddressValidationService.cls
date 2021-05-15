/*********************************************************************************
Class Name      : Credomatic_AddressValidationService
Description     : Actual implementation of the address validation service
Created By      : Sebastian Torres
Created Date    : 2021-05-13
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-13             Initial version

*********************************************************************************/
global class Credomatic_AddressValidationService {
    
    private static Credomatic_IAddressValidationService service()
	{
		return (Credomatic_IAddressValidationService) Credomatic_Application.Service.newInstance(Credomatic_IAddressValidationService.class);
	}

    global static string validateAddressSingle(string country,string state,string city, string street, string postalCode) 
    {
        return service().validateAddressSingle(country, state, city, street, postalCode);
    } 
}
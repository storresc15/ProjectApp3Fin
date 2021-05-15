/*********************************************************************************
Class Name      : Credomatic_AddressValidationStrategy
Description     : Interface for Address validation service and mocks 
Created By      : Sebastian Torres
Created Date    : 2021-05-13
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-13              Initial version 

*********************************************************************************/
public interface Credomatic_IAddressValidationService {
    
    String validateAddressSingle(string country,string state,string city, string street, string postalCode);
    void validateAccountAddress(Account a);
    void validateAccountAddressBulk(List<Account> accs);

}
/*********************************************************************************
Class Name      : Credomatic_AddressValidationStrategy
Description     : Strategy pattern class to be implemented by all the address validation support or utility classes. 
Created By      : Sebastian Torres
Created Date    : 2021-05-12
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-12              Initial version 

*********************************************************************************/
public interface Credomatic_AddressValidationStrategy {
    
    String validateAddress(string state,string city, string street, string postalCode);

}
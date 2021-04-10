/*********************************************************************************
Class Name      : Credomatic_PaymentRequest
Description     : This class works as a data carrier for the payment adapters
Created By      : Sebastian Torres
Created Date    : 2021-04-06
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-06              Initial version
*********************************************************************************/
public class Credomatic_PaymentRequest {
    
    public decimal Amount {get; set;}
    public String PaymentMethod {get; set;}
    public String AuthorizationCode {get; set;}

}
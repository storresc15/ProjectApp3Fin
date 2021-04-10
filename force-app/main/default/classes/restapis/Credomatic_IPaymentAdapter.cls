/*********************************************************************************
Class Name      : Credomatic_IPaymentAdapter
Description     : This contract needs to be implemented by payment adapters
Created By      : Sebastian Torres
Created Date    : 2021-04-06
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-06              Initial version
*********************************************************************************/
public interface Credomatic_IPaymentAdapter {
    
    void submitRequest(Credomatic_PaymentRequest request);

}
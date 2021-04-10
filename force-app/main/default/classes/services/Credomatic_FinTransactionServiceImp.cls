/*********************************************************************************
Class Name      : Credomatic_FinTransactionServiceImp
Description     : 
Created By      : Sebastian Torres
Created Date    : 2021-04-08
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-08              Initial version
*********************************************************************************/
public class Credomatic_FinTransactionServiceImp implements Credomatic_IFinTransactionService {
    
    //For this method consider later the strategy pattern in order to select at runtime the payment method
    //First Attempt was using a string with the method for the adapterFactory
    public void submitPaymentRequest(FinServ__FinancialAccountTransaction__c ft, String method)
    {
      //Declare and build the request for input to the adapter  
      Credomatic_PaymentRequest request = new Credomatic_PaymentRequest();
      request.Amount = ft.FinServ__Amount__c;  
      
      //Instantiate the adapter and submit request  
      Credomatic_IPaymentAdapter adapter = Credomatic_PaymentAdapterFactory.getAdapter(method);
      adapter.submitRequest(request);  
    }
    public void updateTransactionStatus(FinServ__FinancialAccountTransaction__c ft)
    {}
    public void updateRollupOnTransactions(Set<Id> ids)
    {}

}
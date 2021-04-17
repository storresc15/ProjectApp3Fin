/*********************************************************************************
Class Name      : Credomatic_IFinTransactionService
Description     : Interface for Financial Transactions service and mocks
Created By      : Sebastian Torres
Created Date    : 2021-04-08
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-08              Initial version

*********************************************************************************/
public interface Credomatic_IFinTransactionService {
    
    void submitPaymentRequest(FinServ__FinancialAccountTransaction__c ft, String method, String secNumber);
    void updateTransactionStatus(FinServ__FinancialAccountTransaction__c ft);
    void updateRollupOnTransactions(Set<Id> ids);

}
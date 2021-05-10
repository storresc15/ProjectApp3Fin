/*********************************************************************************
Class Name      : Credomatic_FinancialAccountState
Description     : This interface uses the state design pattern to help encapsulate the state's specific behavior
				  on the Financial Account object based on the status of the object
Created By      : Sebastian Torres
Created Date    : 2021-05-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-05              Initial version
*********************************************************************************/
public interface Credomatic_FinancialAccountState {
    
    void rollupBalance(FinServ__FinancialAccount__c financialAccount);
    void validateAccountNumber(FinServ__FinancialAccount__c financialAccount);
    void closeAccount(FinServ__FinancialAccount__c financialAccount);
    void validateShippingAddress(FinServ__FinancialAccount__c financialAccount);

}
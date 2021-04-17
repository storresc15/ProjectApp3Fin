/*********************************************************************************
Class Name      : Credomatic_IFinancialAccountSelector
Description     : Interface for Financial Accounts selector
Created By      : Sebastian Torres
Created Date    : 2021-04-16
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-16              Initial version
*********************************************************************************/
public interface Credomatic_IFinancialAccountSelector {
    
    List<FinServ__FinancialAccount__c> selectById(Set<ID> idSet);
    FinServ__FinancialAccount__c selectById(String accId);
    List<FinServ__FinancialAccount__c> selectByIdWithFATs(Set<ID> idSet);

}
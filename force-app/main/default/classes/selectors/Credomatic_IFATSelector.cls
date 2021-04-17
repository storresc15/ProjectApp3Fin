/*********************************************************************************
Class Name      : Credomatic_IFATSelector
Description     : Interface for Financial Account Transactions selector
Created By      : Sebastian Torres
Created Date    : 2021-04-16
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-16              Initial version
*********************************************************************************/
public interface Credomatic_IFATSelector {
    
    List<FinServ__FinancialAccountTransaction__c> selectById(Set<ID> idSet);
    FinServ__FinancialAccountTransaction__c selectById(String accId);

}
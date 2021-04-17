/*********************************************************************************
Class Name      : Credomatic_IAccountsSelector
Description     : Interface for Account selector
Created By      : Sebastian Torres
Created Date    : 2020-03-30
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2020-03-30              Initial version
*********************************************************************************/
public interface Credomatic_IAccountsSelector {
    
    List<Account> selectById(Set<ID> idSet);
    Account selectById(String accId);
    List<Account> selectByName(String name);
    List<Account> selectByIdWithConsAndOpps(Set<ID> idSet);
    List<Account> selectByOwner(Set<ID> idSet);
    List<Account> selectByOwnerandZipCode(Set<ID> idSet, Set<String> setZipCode);

}
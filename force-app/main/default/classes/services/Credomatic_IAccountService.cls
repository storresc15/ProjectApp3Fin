/*********************************************************************************
Class Name      : Credomatic_IAccountService
Description     : Interface for Account service and mocks
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-29              Initial version

*********************************************************************************/
public interface Credomatic_IAccountService {
    
    void createAccount(String name);
    void createAccount(fflib_ISObjectUnitOfWork uow, String name);
    // Method to update related records based on territory
    void updateOwnerFromAssignment(List<Account> records);
    void updateRelatedConsandOpps(Set<Id> idSet);

}
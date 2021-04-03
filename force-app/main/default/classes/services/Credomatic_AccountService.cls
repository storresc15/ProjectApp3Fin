/*********************************************************************************
Class Name      : Credomatic_AccountService
Description     : 
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version
Sebastian				  2021-03-29			  Added correct implementation for mocks
*********************************************************************************/
global with sharing class Credomatic_AccountService  {
    
    private static Credomatic_IAccountService service()
	{
		return (Credomatic_IAccountService) Credomatic_Application.Service.newInstance(Credomatic_IAccountService.class);
	}
    
    global static void createAccount(String name)
	{
		service().createAccount(name);
	}
    
    public static void createAccount(fflib_ISObjectUnitOfWork uow, String name)
    {
        service().createAccount(uow, name);
    }
    
    global static void updateOwnerFromAssignment(List<Account> records) 
    {
        service().updateOwnerFromAssignment(records);
    }
    
    global static void updateRelatedConsandOpps(Set<Id> idSet)
    {
        service().updateRelatedConsandOpps(idSet);
    }
}
/*********************************************************************************
Class Name      : Credomatic_TerritoryAssignmentService
Description     : 
Created By      : Sebastian Torres
Created Date    : 2021-04-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-05              Initial version
*********************************************************************************/
global with sharing class Credomatic_TerritoryAssignmentService {
    
    private static Credomatic_ITerritoryAssignmentService service()
	{
		return (Credomatic_ITerritoryAssignmentService) Credomatic_Application.Service.newInstance(Credomatic_ITerritoryAssignmentService.class);
	}
    
    global static void updateOwnerFromAssignment(List<Account> records) 
    {
        service().updateOwnerFromAssignment(records);
    }
    
    global static void updateRelatedConsandOpps(Set<Id> idSet)
    {
        service().updateRelatedConsandOpps(idSet);
    }
    
    global static void createAssignmentHistory(List<Account> accList, Map<Id, Account> previousRecords)
    {
        service().createAssignmentHistory(accList, previousRecords);
    }
    
    global static void updateOwnersFromAssignmentChange(List<Territory_Assignment__c> tAssignments, Map<Id, Territory_Assignment__c> previousRecords) 
    {
        service().updateOwnersFromAssignmentChange(tAssignments, previousRecords);
    }

}
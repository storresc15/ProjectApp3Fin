/*********************************************************************************
Class Name      : Credomatic_ITerritoryAssignmentService
Description     : Interface for Retail Territory Assignments service and mocks
Created By      : Sebastian Torres
Created Date    : 2021-04-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-05              Initial version

*********************************************************************************/
public interface Credomatic_ITerritoryAssignmentService {
    
    // Method to update related records based on territory
    void updateOwnerFromAssignment(List<Account> records);
    void updateRelatedConsandOpps(Set<Id> idSet);
	void createAssignmentHistory(List<Account> accList, Map<Id, Account> previousRecords);
    void updateOwnersFromAssignmentChange(List<Territory_Assignment__c> tAssignments, Map<Id, Territory_Assignment__c> previousRecords);
}
trigger Credomatic_TerritoryAssignmentsTrigger on Territory_Assignment__c (before insert, before update, before delete, after insert, after update, after delete) {
    
    //fflib_SObjectDomain.triggerHandler(Credomatic_TerritoryAssignments.class);
    Credomatic_Application.handleTrigger(Territory_Assignment__c.SObjectType);

}
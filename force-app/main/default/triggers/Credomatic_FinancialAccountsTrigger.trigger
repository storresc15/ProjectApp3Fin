trigger Credomatic_FinancialAccountsTrigger on FinServ__FinancialAccount__c (before insert, before update, before delete, after insert, after update, after delete) {
    
    Credomatic_Application.handleTrigger(FinServ__FinancialAccount__c.SObjectType);

}
trigger Credomatic_FATransactionsTrigger on FinServ__FinancialAccountTransaction__c (before insert, before update, before delete, after insert, after update, after delete) {
    
    Credomatic_Application.handleTrigger(FinServ__FinancialAccountTransaction__c.SObjectType);

}
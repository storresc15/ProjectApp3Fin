trigger Credomatic_InsurancePolicyTrigger on InsurancePolicy (before insert, before update, before delete, after insert, after update, after delete) {
	
    //fflib_SObjectDomain.triggerHandler(Credomatic_InsruancePolicy.class);
    Credomatic_Application.handleTrigger(InsurancePolicy.SObjectType);
}
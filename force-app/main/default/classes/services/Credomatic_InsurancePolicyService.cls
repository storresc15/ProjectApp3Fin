/*********************************************************************************
Class Name      : Credomatic_InsurancePolicyService
Description     : Service Layer implementation for Insurance Policies
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version
Sebastian                 2021-03-29              Updated the correct implementation for mocks
*********************************************************************************/
global with sharing class Credomatic_InsurancePolicyService {
    
    private static Credomatic_IInsurancePolicyService service()
	{
		return (Credomatic_IInsurancePolicyService) Credomatic_Application.Service.newInstance(Credomatic_IInsurancePolicyService.class);
	}
    
    global static void createInsurancePoliciesFromAccounts(List<Account> accs, String name, String policyName) {
        service().createInsurancePoliciesFromAccounts(accs, name, policyName);
    }
    
    
}
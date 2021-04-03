/*********************************************************************************
Class Name      : Credomatic_IInsurancePolicyService
Description     : Service Layer implementation for Insurance Policies
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-29              Initial version

*********************************************************************************/
public interface Credomatic_IInsurancePolicyService {
    
    void createInsurancePoliciesFromAccounts(List<Account> accs, String name, String policyName);

}
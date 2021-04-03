/*********************************************************************************
Class Name      : Credomatic_InsurancePolicyServiceImp
Description     : Service Layer implementation for Insurance Policies
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-29              Initial version

*********************************************************************************/
public class Credomatic_InsurancePolicyServiceImp 
	implements Credomatic_IInsurancePolicyService
{
	public void createInsurancePoliciesFromAccounts(List<Account> accs, String name, String policyName) {
        fflib_ISObjectUnitOfWork uow = Credomatic_Application.UnitOfWork.newInstance();
        List<InsurancePolicy> iPs = new List<InsurancePolicy>();
        //Instantiate the Domain class
        Credomatic_IInsruancePolicy iPolicies = (Credomatic_IInsruancePolicy)Credomatic_Application.Domain.newInstance(new List<InsurancePolicy>());
        //Iterate over Accounts
        for(Account a:accs) {
            iPolicies.createInsurancePolicies(uow, a, name, policyName);
        }
        uow.commitWork();
        }
}
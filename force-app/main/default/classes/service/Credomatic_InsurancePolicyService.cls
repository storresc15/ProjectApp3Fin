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

*********************************************************************************/
public class Credomatic_InsurancePolicyService implements IService {
    public static IService newInstance() {
        return (IService) Credomatic_Application.service.newInstance(IService.class);
    }
    
    public interface IService {
        void createInsurancePoliciesFromAccounts(List<Account> accs, String name, String policyName);
    }
    

    /*
     * createInsurancePoliciesFromAccounts
     */
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
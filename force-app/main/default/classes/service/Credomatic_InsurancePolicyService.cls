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
        Credomatic_IInsruancePolicy iPolicies = Credomatic_InsruancePolicy.newInstance(new List<InsurancePolicy>());
        //Iterate over Accounts
        for(Account a:accs) {
            iPolicies.createInsurancePolicies(uow, a, name, policyName);
        }
        uow.commitWork();
        }
    }
public with sharing class MVP0_Account_InsurancePolicy_Service {
    
    public static void createInsurancePolicies(List<Account> Accounts, Map<Id, Account> accountsOldMap) {
        
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<SObjectType> { InsurancePolicy.SObjectType}
        );
        
        for(Account account : Accounts) 
        {
			if(Account.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId()
              ||
              Account.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId())
            {
                //Checking if Client is platinum
               if(Account.FinServ__ClientCategory__c == 'Platinum' && accountsOldMap.get(account.id).FinServ__ClientCategory__c != 'Platinum') 
               {
                   system.debug('The client is platimun now');
                   InsurancePolicy Ip = new InsurancePolicy(Name = '001 Premium Policy',PolicyName = 'Premium Policy');
                   uow.registerNew(Ip, InsurancePolicy.NameInsuredId, account);
               }
            }
        
    }  
        uow.commitWork();
        }
        
    public static void testingDomainMethodPOC() {
        Account[] accsToIns = [SELECT ID, Name FROM Account LIMIT 10];
        Credomatic_Accounts accs = new Credomatic_Accounts(accsToIns);
        
    }

}
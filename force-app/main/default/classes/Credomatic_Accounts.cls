/*********************************************************************************
Class Name      : Credomatic_Accounts
Description     : Main Domain for Account object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version

*********************************************************************************/
public with sharing class Credomatic_Accounts extends fflib_SObjectDomain implements Credomatic_IAccounts {
    
    public static Credomatic_IAccounts newInstance(List<Account> recordList)
	{
		return (Credomatic_IAccounts) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IAccounts newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IAccounts) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_Accounts(sObjectList);
        }
    }
    

    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        
        Map<Id, Account> accountsOldMap = new Map<ID, Account>((List<Account>)existingRecords.values());
        
        createPremiumInsurancePolicies(accountsOldMap);

    }
    
    
    public override void onApplyDefaults() {
         for (Account account : (List<Account>) Records) {
            account.Description = 'New Created Account from UI';
        }
    }
    
    public void updateOpportunityActivity(fflib_ISObjectUnitOfWork uow)
	{
		for(Account account : (List<Account>) this.records)
		{
			account.Description = 'Last Opportunity Raised ' + System.today();
			uow.registerDirty(account);
		}
	}
    
    public void createPremiumInsurancePolicies(Map<Id, Account> accountsOldMap) {
  
        List<Account> accsForPolicies = new List<Account>();
        Credomatic_InsurancePolicyService service = (Credomatic_InsurancePolicyService) Credomatic_InsurancePolicyService.newInstance();
        
        for(Account account : (List<Account>) Records) 
        {
            if((Account.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId()
              ||
              Account.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId())
              && 
              Account.FinServ__ClientCategory__c == 'Platinum' && accountsOldMap.get(account.id).FinServ__ClientCategory__c != 'Platinum')
            {
                   system.debug('The client is platimun now');
                   accsForPolicies.add(account);
            }
        }
        System.debug('Creating Policies for the following accounts: ' + accsForPolicies);
        service.createInsurancePoliciesFromAccounts(accsForPolicies, '001 Premium Policy','Premium Policy');
    }

}
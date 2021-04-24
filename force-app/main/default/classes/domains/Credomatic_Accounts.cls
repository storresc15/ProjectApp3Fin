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
    
    public override void onBeforeInsert() 
    {
        Credomatic_TerritoryAssignmentService.updateOwnerFromAssignment(getQualifyingAccstoUpdateOwner());
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        
        Map<Id, Account> accountsOldMap = new Map<ID, Account>((List<Account>)existingRecords.values());
        
        Credomatic_InsurancePolicyService.createInsurancePoliciesFromAccounts(getQualifyingAccstoCreatePremiumInsurancePolicies(accountsOldMap), '001 Premium Policy','Premium Policy');
        Credomatic_TerritoryAssignmentService.updateOwnerFromAssignment(getQualifyingAccstoUpdateOwner(accountsOldMap));

    }
    
    public override void onAfterUpdate(Map<Id,sObject> existingRecords) {
        
        Map<Id, Account> accountsOldMap = new Map<ID, Account>((List<Account>)existingRecords.values());
        Credomatic_TerritoryAssignmentService.updateRelatedConsandOpps(getQualifyingRelatedConsandOpps(accountsOldMap));
        Credomatic_TerritoryAssignmentService.createAssignmentHistory(getQualifyingAccsforAssignmentHistory(accountsOldMap), accountsOldMap);

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
    
    public void updateAccOwner(fflib_ISObjectUnitOfWork uow, Map<String, Id> assignmentMap) 
    {
        for(Account account : (List<Account>) this.records)
		{
			account.OwnerId = assignmentMap.get(account.BillingPostalCode) != null? assignmentMap.get(account.BillingPostalCode) : account.OwnerId;
			uow.registerDirty(account);
		}
        
    }
    //This signature is used on the before trigger
    public void updateAccOwner(Map<String, Id> assignmentMap) 
    {
        for(Account account : (List<Account>) this.records)
		{
			account.OwnerId = assignmentMap.get(account.BillingPostalCode) != null? assignmentMap.get(account.BillingPostalCode) : account.OwnerId;
		}
        
    }
    
    public void updateAccsOwnerFromTerritory(fflib_ISObjectUnitOfWork uow, Map<Id, Id> assignmentMap) 
    {
        for(Account acc : (List<Account>) this.records) {
            acc.ownerId = assignmentMap.get(acc.ownerId);
            uow.registerDirty(acc);
        }
    }
    
    public List<Account> getQualifyingAccstoCreatePremiumInsurancePolicies(Map<Id, Account> accountsOldMap) 
    { 
        List<Account> accsForPolicies = new List<Account>();
        
        for(Account account : (List<Account>) Records) 
        {
            if((Account.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId()
              ||
              Account.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId())
              && 
              Account.FinServ__ClientCategory__c == 'Platinum' && accountsOldMap.get(account.id).FinServ__ClientCategory__c != 'Platinum')
            {
                   Credomatic_DiagnosticsInstrumentation.debug('The client is platimun now');
                   accsForPolicies.add(account);
            }
        }
        Credomatic_DiagnosticsInstrumentation.debug('Creating Policies for the following accounts: ' + accsForPolicies);
        return accsForPolicies;
}
    public List<Account> getQualifyingAccstoUpdateOwner(Map<Id, Account> accountsOldMap) 
    {
        List<Account> accsToUpdate = new List<Account>();
        
        for(Account acc : (List<Account>) Records) {
            if(acc.BillingPostalCode != null && acc.BillingPostalCode != accountsOldMap.get(acc.Id).BillingPostalCode) {
                    accsToUpdate.add(acc);
                } 
            }
       return accsToUpdate;
    }
    
    public List<Account> getQualifyingAccstoUpdateOwner() 
    {
        List<Account> accsToUpdate = new List<Account>();
        
        for(Account acc : (List<Account>) Records) {
            if(acc.BillingPostalCode != null) accsToUpdate.add(acc);
        }
        return accsToUpdate;     
    }
    
    public Set<Id> getQualifyingRelatedConsandOpps(Map<Id, Account> accountsOldMap) 
    {
        Set<Id> accsToUpdate = new Set<Id>();
        
        for(Account acc : (List<Account>) Records) {
            if(acc.OwnerId != accountsOldMap.get(acc.Id).OwnerId) {
                    accsToUpdate.add(acc.Id);
                } 
            }
        return accsToUpdate;       
    }
    
    public List<Account> getQualifyingAccsforAssignmentHistory(Map<Id, Account> accountsOldMap) {
        
        List<Account> accsToUpdate = new List<Account>();
        
        for(Account acc : (List<Account>) Records) {
            if(acc.OwnerId != accountsOldMap.get(acc.Id).ownerId) {
                	Credomatic_DiagnosticsInstrumentation.debug('This Account had a owner Change Assignment' + acc);
                    accsToUpdate.add(acc);
                } 
            }
        return accsToUpdate;
    }

}
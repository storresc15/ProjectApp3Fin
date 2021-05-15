/*********************************************************************************
Class Name      : Credomatic_FinancialAccounts
Description     : Main Domain for Financial Account Transaction object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2021-04-16
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-16              Initial version

*********************************************************************************/
public class Credomatic_FATransactions extends fflib_SObjectDomain implements Credomatic_IFATransactions {
    
    public static Credomatic_IFATransactions newInstance(List<FinServ__FinancialAccountTransaction__c> recordList)
	{
		return (Credomatic_IFATransactions) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IFATransactions newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IFATransactions) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_FATransactions(List<FinServ__FinancialAccountTransaction__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_FATransactions(sObjectList);
        }
    }
    
    public override void onBeforeInsert() 
    {
        
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) 
    {

    }
    
    public override void onAfterInsert() 
    {
       Credomatic_FinTransactionService.updateRollupOnTransactions(getQualifyingRelatedFinAccounts());
    }
    
    public override void onAfterUpdate(Map<Id,sObject> existingRecords) 
    {
       Credomatic_FinTransactionService.updateRollupOnTransactions(getQualifyingRelatedFinAccounts());
    }
       
    public override void onApplyDefaults() 
    {
     
    }

    public Set<Id> getQualifyingRelatedFinAccounts()
    {
        Set<Id> finAccsToUpdate = new Set<Id>();
        
        for(FinServ__FinancialAccountTransaction__c fat : (List<FinServ__FinancialAccountTransaction__c>) Records) {
            finAccsToUpdate.add(fat.FinServ__FinancialAccount__c);
             
            }
        
        
        return finAccsToUpdate;
    }

}
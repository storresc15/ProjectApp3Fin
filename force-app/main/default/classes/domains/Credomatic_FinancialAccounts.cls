/*********************************************************************************
Class Name      : Credomatic_FinancialAccounts
Description     : Main Domain for Financial Account object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2021-04-16
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-16              Initial version

*********************************************************************************/
public class Credomatic_FinancialAccounts extends fflib_SObjectDomain implements Credomatic_IFinancialAccounts {
    
    public static Credomatic_IFinancialAccounts newInstance(List<FinServ__FinancialAccount__c> recordList)
	{
		return (Credomatic_IFinancialAccounts) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IFinancialAccounts newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IFinancialAccounts) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_FinancialAccounts(List<FinServ__FinancialAccount__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_FinancialAccounts(sObjectList);
        }
    }
    
    public override void onBeforeInsert() 
    {
        
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) 
    {

    }
    
    public override void onAfterUpdate(Map<Id,sObject> existingRecords) 
    {
       
    }
       
    public override void onApplyDefaults() 
    {
     
    }
    
    public void updateRollupBalances(fflib_ISObjectUnitOfWork uow) 
    {
        
    }

}
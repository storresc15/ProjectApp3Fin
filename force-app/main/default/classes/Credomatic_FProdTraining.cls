/*********************************************************************************
Class Name      : Credomatic_FProdTraining
Description     : Main Domain for Financial Product Training object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2021-05-04
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-04              Initial version

*********************************************************************************/
public class Credomatic_FProdTraining extends fflib_SObjectDomain implements Credomatic_IFProdTraining {
    
     public static Credomatic_IFProdTraining newInstance(List<Financial_Product_Training__c> recordList)
	{
		return (Credomatic_IFProdTraining) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IFProdTraining newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IFProdTraining) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_FProdTraining(List<Financial_Product_Training__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_FProdTraining(sObjectList);
        }
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) 
    {
    }
    
    public override void onAfterUpdate(Map<Id,sObject> existingRecords)
    {
        //Implement the CAS functionality here
    }
       
    public override void onApplyDefaults() 
    {        
    }
    
    public void createFinProdTrainingFromEvent(fflib_ISObjectUnitOfWork uow, Event e) {
        Financial_Product_Training__c fpt = new Financial_Product_Training__c();
        fpt.Case__c = e.WhatId;
        fpt.Contact__c = e.WhoId;
        fpt.Name = 'Financial Product Training signoff';
        fpt.Description__c = 'This record was created automatically from the event ' + e.Subject + ' that was associated with this case: '+ e.WhatId;
        fpt.Financial_Account__c = e.Financial_Account__c;
        fpt.Product_Version__c = e.Product_Version__c;
        uow.registerNew(fpt); 
        }
}
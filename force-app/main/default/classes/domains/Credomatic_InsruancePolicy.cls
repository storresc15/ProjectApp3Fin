/*********************************************************************************
Class Name      : Credomatic_InsruancePolicy
Description     : Main Domain for Insurance Policy object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version

*********************************************************************************/
public with sharing class Credomatic_InsruancePolicy extends fflib_SObjectDomain implements Credomatic_IInsruancePolicy {
    
    public static Credomatic_IInsruancePolicy newInstance(List<InsurancePolicy> recordList)
	{
		return (Credomatic_IInsruancePolicy) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IInsruancePolicy newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IInsruancePolicy) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_InsruancePolicy(List<InsurancePolicy> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_InsruancePolicy(sObjectList);
        }
    }
    
    
    public override void onApplyDefaults() {
         for (InsurancePolicy Ip : (List<InsurancePolicy>) Records) {
            
        }
    }
    
    public void createInsurancePolicies(fflib_ISObjectUnitOfWork uow, Account acc, String name, String policyName) {
        
        InsurancePolicy Ip = new InsurancePolicy(Name = name,PolicyName = policyName);
        
            uow.registerNew(Ip,InsurancePolicy.NameInsuredId, acc); 
        }

}
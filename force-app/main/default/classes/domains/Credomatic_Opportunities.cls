/*********************************************************************************
Class Name      : Credomatic_Opportunities
Description     : Main Domain for Opportunity object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version

*********************************************************************************/
public class Credomatic_Opportunities extends fflib_SObjectDomain implements Credomatic_IOpportunities {
    
     public static Credomatic_IOpportunities newInstance(List<Opportunity> recordList)
	{
		return (Credomatic_IOpportunities) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IOpportunities newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IOpportunities) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_Opportunities(List<Opportunity> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_Opportunities(sObjectList);
        }
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        

    }
       
    public override void onApplyDefaults() {
         
    }
    
    
    public void updateOppOwner(fflib_ISObjectUnitOfWork uow, Id ownerId) 
    {
        for(Opportunity opp : (List<Opportunity>) this.records)
		{
			opp.OwnerId = OwnerId;
			uow.registerDirty(opp);
		}
        
    }

}
/*********************************************************************************
Class Name      : Credomatic_Contacts
Description     : Main Domain for Account object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version

*********************************************************************************/
public class Credomatic_Contacts extends fflib_SObjectDomain implements Credomatic_IContacts {
    
     public static Credomatic_IContacts newInstance(List<Contact> recordList)
	{
		return (Credomatic_IContacts) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IContacts newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IContacts) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_Contacts(List<Case> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_Contacts(sObjectList);
        }
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        

    }
       
    public override void onApplyDefaults() {
         
    }
    
    
    public void updateConOwner(fflib_ISObjectUnitOfWork uow, Id OwnerId) 
    {
        for(Contact c : (List<Contact>) this.records)
		{
			c.OwnerId = OwnerId;
			uow.registerDirty(c);
		}
        
    }

}
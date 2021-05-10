/*********************************************************************************
Class Name      : Credomatic_Events
Description     : Main Domain for Event object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2021-05-04
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-04              Initial version

*********************************************************************************/
public class Credomatic_Events extends fflib_SObjectDomain implements Credomatic_IEvents {
    
     public static Credomatic_IEvents newInstance(List<Event> recordList)
	{
		return (Credomatic_IEvents) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_IEvents newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_IEvents) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_Events(List<Event> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_Events(sObjectList);
        }
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) 
    {
    }
    
    public override void onAfterInsert()
    {
        Credomatic_FinancialTraining.productTrainingCreationfromEvent((List<Event>) Records);
    }
    
    public override void onAfterUpdate(Map<Id,sObject> existingRecords)
    {
        Map<Id, Event> eventsOldMap = new Map<ID, Event>((List<Event>)existingRecords.values());
        //Implement the CAS functionality here
        Credomatic_FinancialTraining.productTrainingCreationfromEvent(getQualifiedEventsForFPT(eventsOldMap));
    }
       
    public override void onApplyDefaults() 
    {        
    }
    
    public List<Event> getQualifiedEventsForFPT(Map<Id,Event> existingRecords) {
        List<Event> qualifiedEvents = new List<Event>();
        
        for(Event e : (List<Event>) Records) {
            if(e.Training_Sign_off__c == true && existingRecords.get(e.Id).Training_Sign_off__c != true){
                qualifiedEvents.add(e);
            }
        }
        Credomatic_DiagnosticsInstrumentation.debug('These events qualify as product training records: ' + qualifiedEvents);
        return qualifiedEvents;
    }
}
/*********************************************************************************
Class Name      : Credomatic_TerritoryAssignments
Description     : Main Domain for Territory Assignment object,Domain class is consumed by the Apex trigger handler and Apex service method
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version

*********************************************************************************/
public with sharing class Credomatic_TerritoryAssignments extends fflib_SObjectDomain implements Credomatic_ITerritoryAssignments {
    
    public static Credomatic_ITerritoryAssignments newInstance(List<Territory_Assignment__c> recordList)
	{
		return (Credomatic_ITerritoryAssignments) Credomatic_Application.Domain.newInstance(recordList);
	}
	
	public static Credomatic_ITerritoryAssignments newInstance(Set<Id> recordIdSet)
	{
		return (Credomatic_ITerritoryAssignments) Credomatic_Application.Domain.newInstance(recordIdSet);
	}
    
    public Credomatic_TerritoryAssignments(List<Territory_Assignment__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Credomatic_TerritoryAssignments(sObjectList);
        }
    }
    
    public override void onBeforeInsert() 
    {
        
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        

    }
    
    public override void onAfterUpdate(Map<Id,sObject> existingRecords) {
        
        Map<Id, Territory_Assignment__c> tAssignmentsOldMap = new Map<ID, Territory_Assignment__c>((List<Territory_Assignment__c>)existingRecords.values());
        Credomatic_TerritoryAssignmentService.updateOwnersFromAssignmentChange(getQualifiedAssignemntsFromUpdate(tAssignmentsOldMap), tAssignmentsOldMap);
    }
       
    public override void onApplyDefaults() {
    }

    public list<Territory_Assignment__c> getQualifiedAssignemntsFromUpdate(Map<ID, Territory_Assignment__c> oldMap) 
    {
         List<Territory_Assignment__c> tAssignmentsToUpdate = new List<Territory_Assignment__c>();
        
        for(Territory_Assignment__c ta : (List<Territory_Assignment__c>) Records) {
            if(ta.User_Assigned__c != oldMap.get(ta.Id).User_Assigned__c) {
                	system.debug('This Territory had a owner Change: '+ ta);
                    tAssignmentsToUpdate.add(ta);
                } 
            }
        return tAssignmentsToUpdate;
        
    }
}
/*********************************************************************************
Class Name      : Credomatic_OpportunitiesSelector
Description     : Main Selector for Opp object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2021-03-31 
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-31              Initial version
*********************************************************************************/
public class Credomatic_OpportunitiesSelector extends fflib_SObjectSelector
implements Credomatic_IOpportunitiesSelector
{
    public static Credomatic_IOpportunitiesSelector newInstance() {
        return (Credomatic_IOpportunitiesSelector) Credomatic_Application.selector.newInstance(Opportunity.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Opportunity.Id,
            Opportunity.Name,
            Opportunity.OwnerId    
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Opportunity.sObjectType;
    }
    
    public List<Opportunity> selectById(Set<ID> idSet) {
        return (List<Opportunity>) selectSObjectsById(idSet);
    }
    
}
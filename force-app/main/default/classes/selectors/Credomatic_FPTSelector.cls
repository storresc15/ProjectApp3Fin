/*********************************************************************************
Class Name      : Credomatic_FPTSelector
Description     : Main Selector for Financial_Product_Training__c object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2021-05-04
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-04              Initial version
*********************************************************************************/
public class Credomatic_FPTSelector extends fflib_SObjectSelector
implements Credomatic_IFPTSelector
{
    
    public static Credomatic_IFPTSelector newInstance() 
    {
        return (Credomatic_IFPTSelector) Credomatic_Application.selector.newInstance(Financial_Product_Training__c.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField> {
            Financial_Product_Training__c.Case__c,
            Financial_Product_Training__c.Id,
            Financial_Product_Training__c.Name,
            Financial_Product_Training__c.Contact__c,    
            Financial_Product_Training__c.Financial_Account__c,
            Financial_Product_Training__c.Product_Version__c    
                };
    }
    public Schema.SObjectType getSObjectType() 
    {
        return Financial_Product_Training__c.sObjectType;
    }
    
    public List<Financial_Product_Training__c> selectById(Set<ID> idSet) 
    {
        return (List<Financial_Product_Training__c>) selectSObjectsById(idSet);
    }
    
    public List<Financial_Product_Training__c> selectByContact(Set<ID> idSet)
    {
        fflib_QueryFactory query = newQueryFactory();
      	query.setCondition('Contact__c IN :idSet');
        return (List<Financial_Product_Training__c>) Database.query( query.toSOQL() );
    }

}
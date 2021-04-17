/*********************************************************************************
Class Name      : Credomatic_FinancialAccountSelector
Description     : Main Selector for Financial Account object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2021-04-16
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-16              Initial version
*********************************************************************************/
public class Credomatic_FinancialAccountSelector extends fflib_SObjectSelector
implements Credomatic_IFinancialAccountSelector {
    
    public static Credomatic_IFinancialAccountSelector newInstance() {
        return (Credomatic_IFinancialAccountSelector) Credomatic_Application.selector.newInstance(FinServ__FinancialAccount__c.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            FinServ__FinancialAccount__c.FinServ__Description__c,
            FinServ__FinancialAccount__c.Id,
            FinServ__FinancialAccount__c.Name,
            FinServ__FinancialAccount__c.OwnerId,    
            FinServ__FinancialAccount__c.FinServ__Balance__c,
            FinServ__FinancialAccount__c.FinServ__FinancialAccountNumber__c,
            FinServ__FinancialAccount__c.FinServ__PrimaryOwner__c,
            FinServ__FinancialAccount__c.RecordTypeId,
            FinServ__FinancialAccount__c.FinServ__RecordTypeName__c,
            FinServ__FinancialAccount__c.FinServ__Status__c
                };
    }
    public Schema.SObjectType getSObjectType() {
        return FinServ__FinancialAccount__c.sObjectType;
    }
    
    public List<FinServ__FinancialAccount__c> selectById(Set<ID> idSet) {
        return (List<FinServ__FinancialAccount__c>) selectSObjectsById(idSet);
    }
    
    public FinServ__FinancialAccount__c selectById(String fatId) {
        FinServ__FinancialAccount__c a = [SELECT Id, 
                                                 Name, 
                                                 FinServ__Balance__c, 
												 FinServ__PrimaryOwner__c, 
                                                     RecordTypeId, 
                                                     FinServ__FinancialAccountNumber__c 
                                          FROM FinServ__FinancialAccount__c WHERE Id = :fatId Limit 1];
        return a;
    }
    
    public List<FinServ__FinancialAccount__c> selectByIdWithFATs(Set<ID> idSet) {
        //Implementation of the select method for contacts and Opportunities
        fflib_QueryFactory query = newQueryFactory();
      query.setCondition('Id IN :idSet');
      //query.subselectQuery('Opportunities');
           
 
      new Credomatic_FATSelector().addQueryFactorySubselect(query,'FinServ__FinancialAccountTranslations__r');
 
      return (List<FinServ__FinancialAccount__c>) Database.query( query.toSOQL() );
    }

}
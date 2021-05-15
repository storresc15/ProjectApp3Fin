/*********************************************************************************
Class Name      : Credomatic_FATSelector
Description     : Main Selector for Financial Account Transaction object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2021-04-16
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-16              Initial version
*********************************************************************************/
public class Credomatic_FATSelector extends fflib_SObjectSelector
implements Credomatic_IFATSelector {
    
    public static Credomatic_IFATSelector newInstance() {
        return (Credomatic_IFATSelector) Credomatic_Application.selector.newInstance(FinServ__FinancialAccountTransaction__c.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            FinServ__FinancialAccountTransaction__c.FinServ__Description__c,
            FinServ__FinancialAccountTransaction__c.Id,
            FinServ__FinancialAccountTransaction__c.Name,
            FinServ__FinancialAccountTransaction__c.OwnerId,    
            FinServ__FinancialAccountTransaction__c.FinServ__Amount__c,
            FinServ__FinancialAccountTransaction__c.Primary_Owner__c,
            FinServ__FinancialAccountTransaction__c.FinServ__CardAccountID__c,
            FinServ__FinancialAccountTransaction__c.Card_Expiration_Date__c,
            FinServ__FinancialAccountTransaction__c.FinServ__TransactionId__c,
            FinServ__FinancialAccountTransaction__c.FinServ__TransactionStatus__c,
            FinServ__FinancialAccountTransaction__c.Payment_Applied__c,
            FinServ__FinancialAccountTransaction__c.FinServ__TransactionSubtype__c    
                };
    }
    public Schema.SObjectType getSObjectType() {
        return FinServ__FinancialAccountTransaction__c.sObjectType;
    }
    
    public List<FinServ__FinancialAccountTransaction__c> selectById(Set<ID> idSet) {
        return (List<FinServ__FinancialAccountTransaction__c>) selectSObjectsById(idSet);
    }
    
    public FinServ__FinancialAccountTransaction__c selectById(String fatId) {
        FinServ__FinancialAccountTransaction__c a = [SELECT Id, 
                                                     Name, 
                                                     FinServ__Amount__c, 
                                                     Primary_Owner__c, 
                                                     FinServ__CardAccountID__c, 
                                                     Card_Expiration_Date__c,
                                                     FinServ__TransactionId__c,
                                                     FinServ__TransactionStatus__c FROM FinServ__FinancialAccountTransaction__c WHERE Id = :fatId Limit 1];
        return a;
    }

}
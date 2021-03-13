/*********************************************************************************
Class Name      : MVP0_AccountsSelector
Description     : Main Selector for Account object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2020-12-05              Initial version

*********************************************************************************/
public class MVP0_AccountsSelector  extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.Description,
            Account.Id,
            Account.Name,
            Account.AnnualRevenue };
    }
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    public List<Account> selectById(Set<ID> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }

}
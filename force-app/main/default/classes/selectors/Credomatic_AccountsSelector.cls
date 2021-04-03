/*********************************************************************************
Class Name      : Credomatic_AccountsSelector
Description     : Main Selector for Account object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2020-12-05              Initial version
Sebastian				  2020-03-30			  Added the correct implementation with Credomatic_IAccountsSelector
*********************************************************************************/
public class Credomatic_AccountsSelector extends fflib_SObjectSelector
implements Credomatic_IAccountsSelector
{
    
    public static Credomatic_IAccountsSelector newInstance() {
        return (Credomatic_IAccountsSelector) Credomatic_Application.selector.newInstance(Account.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.Description,
            Account.Id,
            Account.Name,
            Account.OwnerId,    
            Account.AnnualRevenue,
            Account.isPersonAccount    };
    }
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    
    public List<Account> selectById(Set<ID> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }
    public List<Account> selectByName(String name) {
        return [SELECT Name FROM Account WHERE Name = :name];
    }
    //Method to be used on the territory solution
    public List<Account> selectByIdWithConsAndOpps(Set<ID> idSet) {
        //Implementation of the select method for contacts and Opportunities
        fflib_QueryFactory query = newQueryFactory();
      query.setCondition('Id IN :idSet');
      //query.subselectQuery('Opportunities');
           
 
      new Credomatic_ContactsSelector().addQueryFactorySubselect(query,'Contacts');
      new Credomatic_OpportunitiesSelector().addQueryFactorySubselect(query,'Opportunities');
 
      return (List<Account>) Database.query( query.toSOQL() );
    }

}
/*********************************************************************************
Class Name      : Credomatic_ContactsSelector
Description     : Main Selector for Contact object, handles all queries for the specific sObject - Use of fflib selector layer
Created By      : Sebastian Torres
Created Date    : 2021-03-31 
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-31              Initial version
*********************************************************************************/
public class Credomatic_ContactsSelector extends fflib_SObjectSelector
implements Credomatic_IContactsSelector
{
    public static Credomatic_IContactsSelector newInstance() {
        return (Credomatic_IContactsSelector) Credomatic_Application.selector.newInstance(Contact.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Contact.Id,
            Contact.FirstName,
            Contact.LastName,
            Contact.OwnerId    };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
    public List<Contact> selectById(Set<ID> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }
    
}
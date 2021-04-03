/*********************************************************************************
Class Name      : Credomatic_IContactsSelector
Description     : Interface for Contact selector
Created By      : Sebastian Torres
Created Date    : 2020-03-31
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2020-03-31              Initial version
*********************************************************************************/
public interface Credomatic_IContactsSelector {
	List<Contact> selectById(Set<ID> idSet);
}
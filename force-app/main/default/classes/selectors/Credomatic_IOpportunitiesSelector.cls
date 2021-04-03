/*********************************************************************************
Class Name      : Credomatic_IOpportunitiesSelector
Description     : Interface for Opps selector
Created By      : Sebastian Torres
Created Date    : 2021-03-31
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-31              Initial version
*********************************************************************************/
public interface Credomatic_IOpportunitiesSelector {
    
    List<Opportunity> selectById(Set<ID> idSet);

}
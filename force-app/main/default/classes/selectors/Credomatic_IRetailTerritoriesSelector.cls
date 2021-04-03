/*********************************************************************************
Class Name      : Credomatic_IRetailTerritoriesSelector
Description     : Interface for Opps selector
Created By      : Sebastian Torres
Created Date    : 2021-04-01
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-01              Initial version
*********************************************************************************/
public interface Credomatic_IRetailTerritoriesSelector {
    
    List<Retail_Territory__c> selectByZip(Set<String> zipCodes);
    List<Retail_Territory__c> selectById(Set<ID> idSet);

}
/*********************************************************************************
Class Name      : Credomatic_IFPTSelector
Description     : Interface for Financial Product Training selector
Created By      : Sebastian Torres
Created Date    : 2021-05-04
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-04              Initial version
*********************************************************************************/
public interface Credomatic_IFPTSelector {
    
    List<Financial_Product_Training__c> selectById(Set<ID> idSet);
    List<Financial_Product_Training__c> selectByContact(Set<ID> idSet);

}
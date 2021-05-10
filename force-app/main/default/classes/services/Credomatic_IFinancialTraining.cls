/*********************************************************************************
Class Name      : Credomatic_IFinancialTraining
Description     : Interface for Financial Training service and mocks
Created By      : Sebastian Torres
Created Date    : 2021-05-04
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-04              Initial version

*********************************************************************************/
public interface Credomatic_IFinancialTraining {
    
    void productTrainingCreationfromEvent(List<Event> events);

}
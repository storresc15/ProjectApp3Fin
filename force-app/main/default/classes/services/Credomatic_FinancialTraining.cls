/*********************************************************************************
Class Name      : Credomatic_FinancialTraining
Description     : 
Created By      : Sebastian Torres
Created Date    : 2021-05-04
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-04              Initial version
*********************************************************************************/
global class Credomatic_FinancialTraining {
    
    private static Credomatic_IFinancialTraining service()
	{
		return (Credomatic_IFinancialTraining) Credomatic_Application.Service.newInstance(Credomatic_IFinancialTraining.class);
	}

    global static void productTrainingCreationfromEvent(List<Event> events) 
    {
        service().productTrainingCreationfromEvent(events);
    }
}
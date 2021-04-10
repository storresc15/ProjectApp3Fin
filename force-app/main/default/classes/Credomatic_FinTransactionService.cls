/*********************************************************************************
Class Name      : Credomatic_FinTransactionService
Description     : 
Created By      : Sebastian Torres
Created Date    : 2021-04-08
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-08              Initial version
*********************************************************************************/
global class Credomatic_FinTransactionService {

    private static Credomatic_IFinTransactionService service()
	{
		return (Credomatic_IFinTransactionService) Credomatic_Application.Service.newInstance(Credomatic_IFinTransactionService.class);
	}
    
    global static void submitPaymentRequest(FinServ__FinancialAccountTransaction__c ft, String method)
    {
        service().submitPaymentRequest(ft, method);
    }
    global static void updateTransactionStatus(FinServ__FinancialAccountTransaction__c ft)
    {
        service().updateTransactionStatus(ft);
    }
    global static void updateRollupOnTransactions(Set<Id> ids)
    {
        service().updateRollupOnTransactions(ids);
    }

}
/*********************************************************************************
Class Name      : Credomatic_FinancialAccountContext
Description     : Interface for Financial Account state handlers
Created By      : Sebastian Torres
Created Date    : 2021-05-10
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-10              Initial version
*********************************************************************************/
public class Credomatic_FinancialAccountContext {
    
    public Credomatic_FinancialAccountState fAccState {get; set;}
    
    public Credomatic_FinancialAccountContext(String faState) 
    {
        if(faState == 'Open') {
            this.fAccState = new Credomatic_FAOpenState();
        } //else if()
        //Rest of the Handlers
    }
    
    public void rollupBalance(FinServ__FinancialAccount__c financialAccount, List<FinServ__FinancialAccountTransaction__c> fats)
    {
        fAccState.rollupBalance(financialAccount, fats);
    }
    
    public void validateAccountNumber(FinServ__FinancialAccount__c financialAccount)
    {
       fAccState.validateAccountNumber(financialAccount);
    }
    
    public void closeAccount(FinServ__FinancialAccount__c financialAccount)
    {
        fAccState.closeAccount(financialAccount);
    }
    
    public void validateShippingAddress(FinServ__FinancialAccount__c financialAccount)
    {
        fAccState.validateShippingAddress(financialAccount);
    }

}
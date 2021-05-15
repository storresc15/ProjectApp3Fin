/*********************************************************************************
Class Name      : Credomatic_FAOpenState
Description     : This class implements the Financial Account State pattern class and handles the functionality
				  related to the Open status on Financial Account record
Created By      : Sebastian Torres
Created Date    : 2021-05-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-05-05              Initial version
*********************************************************************************/
public class Credomatic_FAOpenState implements Credomatic_FinancialAccountState {
    
    public void rollupBalance(FinServ__FinancialAccount__c financialAccount, List<FinServ__FinancialAccountTransaction__c> fats)
    {
        double rolledUpAmount = 0;
        For(FinServ__FinancialAccountTransaction__c FAT : fats) {
        System.debug('The name: ' + FAT.name);
            if(FAT.FinServ__TransactionStatus__c == 'Posted' && FAT.Payment_Applied__c) {
                if(FAT.FinServ__TransactionSubtype__c == 'MIsc. Debit' || FAT.FinServ__TransactionSubtype__c == 'Cash Deposit'){
                    rolledUpAmount += FAT.FinServ__Amount__c;
                } else {
                    rolledUpAmount = rolledUpAmount - FAT.FinServ__Amount__c;
                }
            }
        
        }
        Credomatic_DiagnosticsInstrumentation.debug('This Financial Account will be updated with the balance: ' + financialAccount.Name);
        Credomatic_DiagnosticsInstrumentation.debug('The amount to be updated is: ' + financialAccount.FinServ__Balance__c + 'To this: ' +rolledUpAmount);
        financialAccount.FinServ__Balance__c = rolledUpAmount;
    }
    
    public void validateAccountNumber(FinServ__FinancialAccount__c financialAccount)
    {
        
    }
    public void closeAccount(FinServ__FinancialAccount__c financialAccount)
    {
        
    }
    public void validateShippingAddress(FinServ__FinancialAccount__c financialAccount)
    {
        
    }

}
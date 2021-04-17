/*********************************************************************************
Class Name      : Credomatic_FinTransactionServiceImp
Description     : 
Created By      : Sebastian Torres
Created Date    : 2021-04-08
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-08              Initial version
*********************************************************************************/
public class Credomatic_FinTransactionServiceImp implements Credomatic_IFinTransactionService {
    
    //For this method consider later the strategy pattern in order to select at runtime the payment method
    //First Attempt was using a string with the method for the adapterFactory - try then using custom metadata
    public void submitPaymentRequest(FinServ__FinancialAccountTransaction__c ft, String method, String secNumber)
    {
      //Declare and build the request for input to the adapter  
      Credomatic_PaymentRequest request = new Credomatic_PaymentRequest();
      Account acc = Credomatic_AccountsSelector.newInstance().selectById(ft.Primary_Owner__c);  
      request.Amount = ft.FinServ__Amount__c;
      request.bankaccountname = 'Testing';
      request.firstname = (acc.Name.contains(' '))?acc.Name.substringbefore(' '):acc.Name;
      request.lastname = (acc.Name.contains(' '))?acc.Name.substringafter(' '):acc.Name;
      request.BillingStreet = acc.BillingStreet;
      request.BillingCity = acc.BillingCity;
      request.BillingState = acc.BillingState;
      request.BillingPostalCode = acc.BillingPostalCode;
      //set wrapper credit card fields
      request.CreditCard_Number = ft.FinServ__CardAccountID__c;
      request.CreditCard_Expiration = ft.Card_Expiration_Date__c;
      request.CreditCard_SecurityNumber = secNumber;// ft.Card_Security_Nummber__c;

       //give this request a name
       request.ordername = ft.Name;  
      
      //Instantiate the adapter and submit request  
      Credomatic_IPaymentAdapter adapter = Credomatic_PaymentAdapterFactory.getAdapter(method);
      String response = adapter.submitRequest(request);
        //TO BE UPDATED WITH DOMAIN LAYER & UOW
        if(response == 'Success')
        {
            ft.FinServ__TransactionStatus__c = 'Posted';
            ft.Payment_Applied__c = true;
            
            update ft;
        } 
    }
    public void updateTransactionStatus(FinServ__FinancialAccountTransaction__c ft)
    {}
    public void updateRollupOnTransactions(Set<Id> ids)
    {
       List <FinServ__FinancialAccount__c> fAcs = Credomatic_FinancialAccountSelector.newInstance().selectByIdWithFATs(ids);

        system.debug('The list' + fAcs);
        
        For(FinServ__FinancialAccount__c fa : fAcs) {
            For(FinServ__FinancialAccountTransaction__c FAT : fa.FinServ__FinancialAccountTranslations__r) {
                System.debug('The name: ' + FAT.name);
            }
        } 
    }

}
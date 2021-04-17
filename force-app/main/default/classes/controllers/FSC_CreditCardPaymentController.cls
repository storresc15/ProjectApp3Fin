public with sharing class FSC_CreditCardPaymentController {
    
    @auraEnabled
    public static void submitPayment(String recordId, String secNumber) {
        
        //Remember to implement the selector     
        FinServ__FinancialAccountTransaction__c ft = Credomatic_FATSelector.newInstance().selectById(recordId);
      
        Credomatic_FinTransactionService.submitPaymentRequest(ft, 'PayByCard', secNumber);
    }

}
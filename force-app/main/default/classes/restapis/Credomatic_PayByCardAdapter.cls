/*********************************************************************************
Class Name      : Credomatic_PayByCardAdapter
Description     : This class contains logic to interact with processor class of a third party library to provide uniform access
Created By      : Sebastian Torres
Created Date    : 2021-04-06
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-06              Initial version
*********************************************************************************/
public class Credomatic_PayByCardAdapter implements Credomatic_IPaymentAdapter {
    
    public void submitRequest(Credomatic_PaymentRequest request) 
    {
        //Call the API service using the generate data method
        API_AuthorizeDotNet.authnetresp_wrapper responseFromProcessor = API_AuthorizeDotNet.authdotnetCharge(generateData(request));
        //System debug and also the diagnostics log
        system.debug('This is the log of what was returned: ' + responseFromProcessor);
        
        //Check the actual conditions for the operation to pass otherwise return an exception
        if(responseFromProcessor.responseCode == 'Error' /*  REST OF CONDITIONS   */){
            Throw new Credomatic_Application.ApplicationException ('There was an error on the payment request----- Response Code: ' + responseFromProcessor.responseCode);
        }
        
    }

    private API_AuthorizeDotNet.authnetReq_Wrapper generateData(Credomatic_PaymentRequest request) 
    {
        API_AuthorizeDotNet.authnetReq_Wrapper dataForPayment = new API_AuthorizeDotNet.authnetReq_Wrapper();
        dataForPayment.bankaccountname = 'Testing';
        dataForPayment.amt = String.valueOf(request.Amount);
        
        return dataForPayment;
    }
}
/*********************************************************************************
Class Name      : Credomatic_PaymentAdapterFactory
Description     : This class helps instantiate an adapter at runtime
Created By      : Sebastian Torres
Created Date    : 2021-04-06
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-06              Initial version
*********************************************************************************/
public class Credomatic_PaymentAdapterFactory {
    
    public static Credomatic_IPaymentAdapter getAdapter(String adapterName) 
    {
        Credomatic_IPaymentAdapter adapter;
        
        //Diferent conditions for adapters
        if(adapterName == 'PayByCard') adapter = new Credomatic_PayByCardAdapter();
        return adapter;
    }

}
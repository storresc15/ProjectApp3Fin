/*********************************************************************************
Class Name      : Credomatic_AsyncAddressValidation
Description     : Address Validation Async support class
Created By      : Sebastian Torres
Created Date    : 2021-04-14 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-14              Initial version
*********************************************************************************/
public class Credomatic_AsyncAddressValidation extends Credomatic_AsyncJob {
    
    public override void executeAsyncProcess(AsyncRequest__c request) 
    {
        //Checking limits
        if(!limitsAvailable()) return;
        
        List<ID> idsAfterSplit = request.Params__c.split(',');
    } 
    
    

}
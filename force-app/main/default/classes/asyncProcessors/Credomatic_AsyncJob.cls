/*********************************************************************************
Class Name      : Credomatic_AsyncJob
Description     : Interface to be implemented on all the Async job classes
Created By      : Sebastian Torres
Created Date    : 2021-04-14 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-14              Initial version
*********************************************************************************/
public abstract class Credomatic_AsyncJob {
    
    protected boolean limitsAvailable()
    {
        Integer allowedCallouts = Limits.getLimitCallouts() - Limits.getCallouts();
        if(allowedCallouts<=0) return false;
        return true;
    }
    public abstract void executeAsyncProcess(AsyncRequest__c request);

}
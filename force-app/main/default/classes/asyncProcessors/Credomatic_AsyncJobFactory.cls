/*********************************************************************************
Class Name      : Credomatic_AsyncJobFactory
Description     : Factory class for implementing the Async Jobs
Created By      : Sebastian Torres
Created Date    : 2021-04-14 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-14              Initial version
*********************************************************************************/
public class Credomatic_AsyncJobFactory {
    
    public static Credomatic_AsyncJob getInstance(String jobName) 
    {
        Credomatic_AsyncJob job = null;
        
        if(jobName == 'Address Validation') job = new Credomatic_AsyncAddressValidation();
        //implement rest of async processes
        
        return job;
    }

}
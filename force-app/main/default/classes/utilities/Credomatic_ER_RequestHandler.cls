/*********************************************************************************
Class Name      : Credomatic_ER_RequestHandler
Description     : Abstract Class for chain of responsibility implementation on External Referral platform event
Created By      : Sebastian Torres
Created Date    : 2021-04-21 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-21              Initial version
*********************************************************************************/
public abstract class Credomatic_ER_RequestHandler {
    
    public static final integer REQUEST_LEVEL_CONTACT = 0;
    public static final integer REQUEST_LEVEL_EXISTINGCHECK = 1;
    public static final integer REQUEST_LEVEL_GRATIFYAGENT = 2;
    public static final integer REQUEST_LEVEL_PRODUCTSPECIFIC = 3;
    
    protected integer handlerLevel;
    
    protected Credomatic_ER_RequestHandler nextHandler;
    
    public void setNextHandler(Credomatic_ER_RequestHandler handler) 
    {
        this.nextHandler = handler;
    }
    
    public void handleRequest(integer level, List<External_Referral__e> eReferrals) 
    {
        if(handlerLevel <= level) 
        {
            execute(eReferrals);
        }
        if(nextHandler != null)
        {
            nextHandler.handleRequest(level, eReferrals);
        }
    }
    
    abstract protected void execute(List<External_Referral__e> eReferrals);

}
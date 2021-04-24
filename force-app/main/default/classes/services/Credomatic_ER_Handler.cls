/*********************************************************************************
Class Name      : Credomatic_ER_Handler
Description     : Utility class that will create a chain of all the preceding request handlers
Created By      : Sebastian Torres
Created Date    : 2021-04-21 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-21              Initial version
*********************************************************************************/
public class Credomatic_ER_Handler {
    
    public static Credomatic_ER_RequestHandler getChainOfHandlers() 
    {
        Credomatic_ER_RequestHandler contactHandler = new Credomatic_ER_Contact(Credomatic_ER_RequestHandler.REQUEST_LEVEL_CONTACT);
        Credomatic_ER_RequestHandler existingCustomer = new Credomatic_ER_ExistingCustomer(Credomatic_ER_RequestHandler.REQUEST_LEVEL_EXISTINGCHECK);
        Credomatic_ER_RequestHandler gratifying = new Credomatic_ER_GratifyRef(Credomatic_ER_RequestHandler.REQUEST_LEVEL_GRATIFYAGENT);
        
        contactHandler.setNextHandler(existingCustomer);
        existingCustomer.setNextHandler(gratifying);
        //Condition for next handler
        return contactHandler;
    }

}
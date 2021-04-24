/*********************************************************************************
Class Name      : Credomatic_ER_ExistingCustomer
Description     : Class to handle the existing customer logic on external request
Created By      : Sebastian Torres
Created Date    : 2021-04-21 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-21              Initial version
*********************************************************************************/
public class Credomatic_ER_ExistingCustomer extends Credomatic_ER_RequestHandler {
    
    public Credomatic_ER_ExistingCustomer(integer handlerLevel) 
    {
        this.handlerLevel = handlerLevel;
    }
    
    public override void execute(List<External_Referral__e> eReferrals) 
    {
        system.debug('This is the system debug for existing customer: ' + eReferrals.size());
    }
}
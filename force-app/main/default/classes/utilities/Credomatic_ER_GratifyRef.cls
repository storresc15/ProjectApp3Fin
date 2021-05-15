/*********************************************************************************
Class Name      : Credomatic_ER_GratifyRef
Description     : Class to handle the gratification logic in external request
Created By      : Sebastian Torres
Created Date    : 2021-04-21 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-21              Initial version
*********************************************************************************/
public class Credomatic_ER_GratifyRef extends Credomatic_ER_RequestHandler {
    
    public Credomatic_ER_GratifyRef(integer handlerLevel) 
    {
        this.handlerLevel = handlerLevel;
    }
    
    public override void execute(List<External_Referral__e> eReferrals) 
    {
        system.debug('This is the system debug for gratifying: ' + eReferrals.size());
        //POC for the testing of this implementation of chain, use uow or service for this in future
        List<Task> tasks = new List<Task>();
        for(External_Referral__e er : eReferrals) {
            if(er.Contact_Customer__c == true){
              Task t = new Task();
              t.Description = 'Task created from ER Gratify handler from chain of platform events';
              t.Status = 'Not Started';
              t.Subject = 'Call';
              t.Priority = 'Normal';
              t.ActivityDate = System.today() + 5;  
              user u = [SELECT ID, Name, Username from User WHERE Username = 'sebastian.torres@devacc8.com' LIMIT 1];
              t.OwnerId = u.Id;
                tasks.add(t);
            } 
        }
        insert tasks;
    }
    
}
/*********************************************************************************
Class Name      : Credomatic_Batch_AccAssignment
Description     : Batch implementation to support the daily scheduled Account updates
Created By      : Sebastian Torres
Created Date    : 2021-04-13
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-13              Initial version
*********************************************************************************/
global class Credomatic_Batch_AccAssignment implements Database.Batchable<sObject>, System.Schedulable, Database.Stateful {
   
    // Simple job log for errors
	private List<JobError> jobErrors = new List<JobError>();
    
    global void execute(SchedulableContext sc)
	{
		// Start the job once the scheduled time has arrived
		Database.executeBatch(new Credomatic_Batch_AccAssignment());		
	}
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        return new Credomatic_AccountsSelector().queryLocatorForBatchAccAssignment();
    }
    
    global  void execute(Database.BatchableContext BC, List<sObject> scope) 
    {
        List<Account> accs = (List<Account>) scope;
        Map<Id, Account> newMap = new Map<Id,Account>(accs);// just in case it is required
        try
        {
            Credomatic_TerritoryAssignmentService.updateOwnerFromAssignment(accs);
        }
        catch (Exception e)
        {
            // Capture context and error for reporting once job complete
			JobError jobError = new JobError();
			jobError.records = accs;
			jobError.message = e.getMessage();
			jobErrors.add(jobError);
        }
        
        
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        if(jobErrors.size() > 0)
		{
			// Email address from user
			
			// Construct email body 
			String emailBody = '';
			for(JobError jobError : jobErrors)
			{
				List<String> failedOpps = new List<String>();
				for (Account acc : jobError.records)
				{
					failedOpps.add(acc.Name);
				}
				emailBody += String.format('<p>Error {0} occurred during the processing of Opportunities {1}</p>',
					new List<String> { jobError.message, String.join(failedOpps, ',') });					
			}			
			// Send email
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			mail.setToAddresses(new String[] { UserInfo.getUserId() });
			mail.setReplyTo(UserInfo.getUserEmail());
			mail.setSenderDisplayName(UserInfo.getUserName());
			mail.setSubject('Create Invoice Job Failures');
			mail.setHtmlBody(emailBody);
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        }
    }

    /**
	 * Simple wrapper class containing the error message and the records in scope at the time
	 **/
	public class JobError
	{
		public String message;		
		public List<Account> records;
	}
}
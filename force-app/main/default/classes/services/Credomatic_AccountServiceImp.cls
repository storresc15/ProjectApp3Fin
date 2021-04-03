/*********************************************************************************
Class Name      : Credomatic_AccountServiceImp
Description     : Implementation of Account service methods
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-29              Initial version

*********************************************************************************/
public class Credomatic_AccountServiceImp implements Credomatic_IAccountService {
    
    /*
     *  Create Account 
     */
    public void createAccount(String name) {
        fflib_ISObjectUnitOfWork uow = Credomatic_Application.unitOfWork.newInstance();

        createAccount(uow, name);

        uow.commitWork(); 
    }

    /*
     * createAccount 
     */
    public void createAccount(fflib_ISObjectUnitOfWork uow, String name) {
        Credomatic_AccountsSelector selector = (Credomatic_AccountsSelector) Credomatic_AccountsSelector.newInstance();
        List<Account> accList = selector.selectByName(name);
        
        
        if (accList.isEmpty()) {
            Account newAcc = new Account(Name = name);
            
            uow.registerNew(newAcc); 
        }
    }
    
    public void updateOwnerFromAssignment(List<Account> records) 
    {
        Set<Id> idToUpdateRelated = new Set<Id>();
        Set<String> zipCodes = new Set<String>();
        Map<String, Id> assignmentMap = new Map<String, Id>();
         //History Map
        Map<String, Id> historyAssignmentMap = new Map<String,Id>();
        
        //uow
        //fflib_ISObjectUnitOfWork uow = Credomatic_Application.unitOfWork.newInstance();
        
        //Implementation on how to get the correct Assignment based on Territory
        //First create the object, the fields, the selector, and think about the domain layer of that object
        for(Account acc : records) {
            zipCodes.add(acc.BillingPostalCode);
            idToUpdateRelated.add(acc.Id);
        }
        
        for(Retail_Territory__c t : Credomatic_RetailTerritoriesSelector.newInstance().selectByZip(zipCodes)) {
            territory_assignment__c assignment = Credomatic_TerritoriesUtilityClass.selectAssignedRep(t.territory_assignments__r);
            if(assignment != null) {
                assignmentMap.put(t.zip_code__c, assignment.User_Assigned__c);
                historyAssignmentMap.put(t.Zip_Code__c, t.Id);
            }
        }
        
          Credomatic_IAccounts accountDomain = (Credomatic_IAccounts)Credomatic_Application.Domain.newInstance(records);
		  accountDomain.updateAccOwner(assignmentMap);
        
        /*for(Account a : records) {
            a.OwnerId = assignmentMap.get(a.BillingPostalCode) != null? assignmentMap.get(a.BillingPostalCode) : a.OwnerId;
            idToUpdateRelated.add(a.Id);
        }*/
        //Missing the creation of the History object
        //CONSIDER Using the uow for creating the history object
        
        //Returning the Set to be passed to updateRelatedConsandOpps
    }
    
    public void updateRelatedConsandOpps(Set<Id> idSet) 
    {
        fflib_ISObjectUnitOfWork uow = Credomatic_Application.unitOfWork.newInstance();
        List<Account> accsWithRelated = Credomatic_AccountsSelector.newInstance().selectByIdWithConsAndOpps(idSet);
        
        //Credomatic_IOpportunities opportunities = (Credomatic_IOpportunities)Credomatic_Application.Domain.newInstance( recordList );
        //Credomatic_IContacts contacts = (Credomatic_IContacts)Credomatic_Application.Domain.newInstance( recordList );
                
        //Check on correct implementation or uow for the cons and opps updates
        for(Account acc : accsWithRelated) {
            
            if(acc.Opportunities.size() > 0) 
            {
                Credomatic_IOpportunities opportunities = (Credomatic_IOpportunities)Credomatic_Application.Domain.newInstance( acc.Opportunities );
				opportunities.updateOppOwner(uow, acc.OwnerId);                
            }
            
            if(!acc.IsPersonAccount && acc.Contacts.size() > 0) 
            {
                Credomatic_IContacts contacts = (Credomatic_IContacts)Credomatic_Application.Domain.newInstance( acc.Contacts );
				contacts.updateConOwner(uow, acc.OwnerId);  
            }
            
        }
        uow.commitWork();
    }

}
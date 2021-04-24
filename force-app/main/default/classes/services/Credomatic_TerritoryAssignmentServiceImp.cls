/*********************************************************************************
Class Name      : Credomatic_TerritoryAssignmentServiceImp
Description     : 
Created By      : Sebastian Torres
Created Date    : 2021-04-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-05              Initial version
*********************************************************************************/
public class Credomatic_TerritoryAssignmentServiceImp implements Credomatic_ITerritoryAssignmentService {
    
    public void updateOwnerFromAssignment(List<Account> records) 
    {
        Set<Id> idToUpdateRelated = new Set<Id>();
        Set<String> zipCodes = new Set<String>();
        Map<String, Id> assignmentMap = new Map<String, Id>();
         //History Map
        Map<String, Id> historyAssignmentMap = new Map<String,Id>();
        Credomatic_IAccounts accountDomain;
        
        
        
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
        
        if(System.isBatch()) {
            //Here consider updating with the even functionality a Map<String, List<Id>> to validate
            List<Account> accsValidated = New List<Account>();
            for(Account a : records) {
                if(a.ownerId != historyAssignmentMap.get(a.BillingPostalCode)) accsValidated.add(a);
            }
            accountDomain = (Credomatic_IAccounts)Credomatic_Application.Domain.newInstance(accsValidated);
        } else{
          accountDomain = (Credomatic_IAccounts)Credomatic_Application.Domain.newInstance(records);
        }
        
         accountDomain.updateAccOwner(assignmentMap);
        
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
                Credomatic_DiagnosticsInstrumentation.debug('Account ' + acc.name + 'Has ' + acc.Opportunities.size() + ' Opps to update');
                Credomatic_IOpportunities opportunities = (Credomatic_IOpportunities)Credomatic_Application.Domain.newInstance( acc.Opportunities );
				opportunities.updateOppOwner(uow, acc.OwnerId);                
            }
            
            if(!acc.IsPersonAccount && acc.Contacts.size() > 0) 
            {
                Credomatic_DiagnosticsInstrumentation.debug('Account ' + acc.name + 'Has ' + acc.Contacts.size() + ' Contacts to update');
                Credomatic_IContacts contacts = (Credomatic_IContacts)Credomatic_Application.Domain.newInstance( acc.Contacts );
				contacts.updateConOwner(uow, acc.OwnerId);  
            }
            
        }
        uow.commitWork();
    }

    public void createAssignmentHistory(List<Account> accList, Map<Id, Account> previousRecords) {
        fflib_ISObjectUnitOfWork uow = Credomatic_Application.unitOfWork.newInstance();
        
        Map<String, Id> assignmentMap = new Map<String, Id>();
        Set<String> zipCodes = new Set<String>();
         //History Map
        Map<String, Id> historyAssignmentMap = new Map<String,Id>();
        
        for(Account acc : accList) {
            zipCodes.add(acc.BillingPostalCode);
            zipCodes.add(previousRecords.get(acc.Id).BillingPostalCode);
        }
        
        for(Retail_Territory__c t : Credomatic_RetailTerritoriesSelector.newInstance().selectByZip(zipCodes)) {
            territory_assignment__c assignment = Credomatic_TerritoriesUtilityClass.selectAssignedRep(t.territory_assignments__r);
            if(assignment != null) {
                assignmentMap.put(t.zip_code__c, assignment.User_Assigned__c);
                historyAssignmentMap.put(t.Zip_Code__c, t.Id);
            }
        }
        
        for(Account a : accList) {
            Assignment_History__c aHistory = new Assignment_History__c();
            aHistory.Previous_Owner__c = previousRecords.get(a.id).ownerId;
            aHistory.New_Owner__c = a.ownerId;
            aHistory.Previous_Territory__c = historyAssignmentMap.get(previousRecords.get(a.id).BillingPostalCode);
            aHistory.New_Territory__c = historyAssignmentMap.get(a.BillingPostalCode);
            aHistory.Changed_By__c = a.LastModifiedById;
            uow.registerNew(aHistory, Assignment_History__c.account__c, a);
        }
        
        uow.commitWork();
        
    }
    
    public void updateOwnersFromAssignmentChange(List<Territory_Assignment__c> tAssignments, Map<Id, Territory_Assignment__c> previousRecords) 
    {
        Set<String> setZipCode = new Set<String>();
        Map<Id, Id> assignmentMap = new Map<Id, Id>();
        for(Territory_Assignment__c ta : tAssignments) {
            assignmentMap.put(previousRecords.get(ta.Id).User_Assigned__c, ta.User_Assigned__c);
            setZipCode.add(ta.Zip_Code__c);
        }
        
        List<Account> accs = Credomatic_AccountsSelector.newInstance().selectByOwnerandZipCode(assignmentMap.keySet(), setZipCode);
        fflib_ISObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        Credomatic_IAccounts accounts = (Credomatic_IAccounts)Credomatic_Application.Domain.newInstance(accs);
        accounts.updateAccsOwnerFromTerritory(uow, assignmentMap);
        
        uow.commitWork();
        
    }

}
/*********************************************************************************
Class Name      : MVP0_UnitOfWorkTest1
Description     : Unit Test for POC of Unit of work testing
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2020-12-05              Initial version

*********************************************************************************/
@isTest
public class MVP0_UnitOfWorkTest1 {
    
    @isTest
    static void challengeComplete() {
        
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                    Account.SObjectType,
                    Contact.SObjectType,
                    Note.SObjectType
                    });
        
         for (Integer i = 0; i < 100; i++) {
            Account acc = new Account(Name = 'TestAcc' + i, description = 'This is a new Account');
            acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId(); 
            uow.registerNew(acc);
            for (Integer j = 0; j < 5; j++) {
                Contact c = new Contact(LastName = 'TestContact' + i + '_' + j);
                uow.registerNew(c, Contact.AccountId, acc);
               Note n = new Note(Title = 'TestNote' + i + '_' + j, Body = 'Test note body.');
                //uow.registerRelationship(n, Note.ParentId, acc);
                uow.registerNew(n, Note.ParentId, acc);
            }
        }
        
        uow.commitWork();
        
        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
        
        Account accToTest = [SELECT ID , NAME, FinServ__ClientCategory__c FROM Account LIMIT 1];
		accToTest.FinServ__ClientCategory__c = 'Platinum';
        update accToTest;
        
    }

}
@isTest
public class MVP0_AccountsSelector_Test {
    
    @isTest
    public static void testingQuery() {
        Credomatic_AccountsSelector selector = (Credomatic_AccountsSelector) Credomatic_AccountsSelector.newInstance();
        Set<Id> setId = new Set<Id>{};
        
        List<Schema.SObjectField> fieldList = selector.getSObjectFieldList();
        
        String accType = 'This is the type' + selector.getSObjectType();
        
        List<Account> accList = selector.selectById(setId);
        
    }

}
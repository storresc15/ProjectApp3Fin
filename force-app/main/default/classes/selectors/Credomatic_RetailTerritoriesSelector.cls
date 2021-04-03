public class Credomatic_RetailTerritoriesSelector extends fflib_SObjectSelector
implements Credomatic_IRetailTerritoriesSelector
{
    public static Credomatic_IRetailTerritoriesSelector newInstance() {
        return (Credomatic_IRetailTerritoriesSelector) Credomatic_Application.selector.newInstance(Retail_Territory__c.SObjectType);
    }
    
    //To be reviewed the required fields on the queries
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Retail_Territory__c.Id,
            Retail_Territory__c.Name,
            Retail_Territory__c.OwnerId,
            Retail_Territory__c.Zip_Code__c,
            Retail_Territory__c.Assignments__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Retail_Territory__c.sObjectType;
    }
    
    public List<Retail_Territory__c> selectById(Set<ID> idSet) {
        return (List<Retail_Territory__c>) selectSObjectsById(idSet);
    }
    
    public List<Retail_Territory__c> selectByZip(Set<String> zipCodes) {
      	fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Zip_Code__c IN :zipCodes');
        query.subselectQuery('Territory_Assignments__r')
            .selectField('User_Assigned__c')
            .selectField('Zip_Code__c');
        
        return (List<Retail_Territory__c>) Database.query( query.toSOQL() );
    }
    
}
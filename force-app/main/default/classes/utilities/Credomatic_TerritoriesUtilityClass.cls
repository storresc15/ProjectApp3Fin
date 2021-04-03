public class Credomatic_TerritoriesUtilityClass {
    
    public static territory_assignment__c selectAssignedRep(List<territory_assignment__c> territoryAssignments) {
        /*if(territoryAssignments.size() == 1) return territoryAssignments[0];
        else if(territoryAssignments.size() == 2) return territoryAssignments[1];
        else if(territoryAssignments.size() == 3) return territoryAssignments[2];
        else return null; */
        
        //This returns the random selection of assigned resources
    Double rand = Math.floor(Math.random() * territoryAssignments.size());
        Integer idx = rand.intValue();
        return territoryAssignments[idx];
    }

}
trigger Credomatic_EventsTrigger on Event (before insert, before update, before delete, after insert, after update, after delete) {
    
    Credomatic_Application.handleTrigger(Event.SObjectType);

}
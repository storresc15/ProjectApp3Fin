trigger External_Referral_Trigger on External_Referral__e (after insert) {
    
   Credomatic_ER_RequestHandler handler = Credomatic_ER_Handler.getChainOfHandlers();
   handler.handleRequest(Credomatic_ER_RequestHandler.REQUEST_LEVEL_GRATIFYAGENT, trigger.new);   

    
    

}
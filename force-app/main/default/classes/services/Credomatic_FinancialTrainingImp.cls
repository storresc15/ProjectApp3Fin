/*********************************************************************************
Class Name      : Credomatic_FinTransactionServiceImp
Description     : Implementation of the Financial Transactions Service
Created By      : Sebastian Torres
Created Date    : 2021-04-08
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-08              Initial version
*********************************************************************************/
public without sharing class Credomatic_FinancialTrainingImp implements Credomatic_IFinancialTraining {

    public void productTrainingCreationfromEvent(List<Event> events)
    {
        Set<Id> setCon = new Set<Id>();
        
        For(Event e : events) {
            setCon.add(e.WhoId);
        }
        
        Map<Id, List<Financial_Product_Training__c>> finMap = new Map<Id, List<Financial_Product_Training__c>>();
        fflib_ISObjectUnitOfWork uow = Credomatic_Application.unitOfWork.newInstance();
        Credomatic_IFProdTraining iPTraining = (Credomatic_IFProdTraining)Credomatic_Application.Domain.newInstance(new List<Financial_Product_Training__c>());
        
        For(Financial_Product_Training__c fpt : Credomatic_FPTSelector.newInstance().selectByContact(setCon)) {
            if (!finMap.containsKey(fpt.Contact__c)) {
                finMap.put(fpt.Contact__c, new List<Financial_Product_Training__c>{fpt});
            } else{
                finMap.get(fpt.Contact__c).add(fpt);
            }
        }
        //Validation
        For(Event e : events) {
            Boolean fptMatched = false;
            if(finMap.containsKey(e.WhoId)) {
                for(Financial_Product_Training__c fpt : finMap.get(e.WhoId)) {
                if(e.Financial_Account__c == fpt.Financial_Account__c && e.Product_Version__c == fpt.Product_Version__c)
                {
                    Credomatic_DiagnosticsInstrumentation.debug('Found a match for this event and contact: ContactId:' + e.WhoId +' Id of event: '+ e.Id);
                    fptMatched = true;  
                }
                }
            }    
            if(!fptMatched)
            {
                //Creating the record
                Credomatic_DiagnosticsInstrumentation.debug('Creating a Product Training for this contact: ' + e.WhoId);
                iPTraining.createFinProdTrainingFromEvent(uow,e);
            } 
        }
        
        uow.commitWork();
    }
}
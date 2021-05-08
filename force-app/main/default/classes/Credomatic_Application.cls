/*********************************************************************************
Class Name      : Credomatic_Application
Description     : App_Application: application framework, using the factory method 
				  defined fflib_Application to initialize each portion of the design pattern Apex enterprise
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-09              Initial version
Sebastian				  2021-03-29			  Corrected the Service Factory implementation
Sebastian				  2021-04-20			  Added handleTrigger method for diagnostics
Sebastian				  2021-04-26			  Added External Request Custom Metadata info
*********************************************************************************/
public without sharing class Credomatic_Application {
    
     public static final fflib_Application.UnitOfWorkFactory unitOfWork = new fflib_Application.UnitOfWorkFactory(
        new List<SObjectType> {
            Account.SObjectType,
            Contact.SObjectType,
            Opportunity.SObjectType,    
            InsurancePolicy.SObjectType,
            Retail_Territory__c.SObjectType,
            Assignment_History__c.SObjectType,
            Territory_Assignment__c.SObjectType,
            FinServ__FinancialAccount__c.SObjectType,    
            FinServ__FinancialAccountTransaction__c.SObjectType,
            Financial_Product_Training__c.SObjectType,
            Event.SObjectType    
        }
    );

    public static final fflib_Application.ServiceFactory service = new fflib_Application.ServiceFactory(
        new Map<Type, Type> {
            Credomatic_IAccountService.class => Credomatic_AccountServiceImp.class,
            Credomatic_IInsurancePolicyService.class => Credomatic_InsurancePolicyServiceImp.class,
            Credomatic_ITerritoryAssignmentService.class => Credomatic_TerritoryAssignmentServiceImp.class,
            Credomatic_IFinTransactionService.class => Credomatic_FinTransactionServiceImp.class,
            Credomatic_IFinancialTraining.class => Credomatic_FinancialTrainingImp.class    
        }
    );

    public static final fflib_Application.SelectorFactory selector = new fflib_Application.SelectorFactory(
        new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_AccountsSelector.class,
            Contact.SObjectType => Credomatic_ContactsSelector.class,
            Opportunity.SObjectType => Credomatic_OpportunitiesSelector.class,
            Retail_Territory__c.SObjectType => Credomatic_RetailTerritoriesSelector.class,
            FinServ__FinancialAccountTransaction__c.SObjectType => Credomatic_FATSelector.class,
            FinServ__FinancialAccount__c.SObjectType => Credomatic_FinancialAccountSelector.class,
            Financial_Product_Training__c.SObjectType => Credomatic_FPTSelector.class    
        
        }
    );

    public static final fflib_Application.DomainFactory domain = new fflib_Application.DomainFactory(
        Credomatic_Application.selector,
        new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_Accounts.Constructor.class,
            InsurancePolicy.SObjectType => Credomatic_InsruancePolicy.Constructor.class,
            Contact.SObjectType => Credomatic_Contacts.Constructor.class,
            Opportunity.SObjectType => Credomatic_Opportunities.Constructor.class,
            Territory_Assignment__c.SObjectType => Credomatic_TerritoryAssignments.Constructor.class,
            FinServ__FinancialAccount__c.SObjectType => Credomatic_FinancialAccounts.Constructor.class,
            Financial_Product_Training__c.SObjectType => Credomatic_FProdTraining.Constructor.class,
            Event.SObjectType => Credomatic_Events.Contructor.class    
        }
    );
    //Implemented Diagnostic instrumentation by using this method on all the triggers as decorating the fflib handling mechanism
    public static void handleTrigger(SObjectType objectType)
    {
        if(!appEnabled) return; // On/off switch
        
        Map<SObjectType, Type> triggerMap = new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_Accounts.class,
            InsurancePolicy.SObjectType => Credomatic_InsruancePolicy.class,
            Territory_Assignment__c.SObjectType => Credomatic_TerritoryAssignments.class,
            Event.SObjectType => Credomatic_Events.class    
        };
        if(!triggerMap.containsKey(objectType)) return;
        
        try
        {
        Credomatic_DiagnosticsInstrumentation.push('handleTriggers TriggerObject: ' + objectType);    
        fflib_SObjectDomain.triggerHandler(triggerMap.get(objectType));
        } catch (Exception ex ) {
           Credomatic_DiagnosticsInstrumentation.debugException(ex);
           Credomatic_DiagnosticsInstrumentation.popAll();
        } finally
        {
            Credomatic_DiagnosticsInstrumentation.pop();
        }
    }
    
    public class GenericException extends Exception {}
    public class ApplicationException extends Exception {}
    public class AsyncUpdateException extends Exception{}
    
    public static void publishException(String exceptiondetails){
        Exception_Log__e pe = new Exception_Log__e();
        pe.debugData__c = exceptionDetails;
        eventBus.publish(pe);
    }
    
    @testvisible
    private static Credomatic_AppConfig__c testConfig = null;
    
    public static Credomatic_AppConfig__c getAppConfig()
    {
    if(Test.isRunningTest() && testConfig!=null) return testConfig;
    
    Credomatic_AppConfig__c theobject = Credomatic_AppConfig__c.getInstance('default');
    if(theObject==null || Test.isRunningTest()) 
    {
      theObject = new Credomatic_AppConfig__c();
      theObject.name = 'default';
      theObject.EnableDiagnostics__c = (Test.isRunningTest())? true: false;
      theObject.AppEnabled__c = true;
      if(!Test.isRunningTest()) Database.Insert(theobject);
      else testconfig = theObject;
    }
    return theObject;
  }

  public static Boolean diagnosticsEnabled
  { 
    get
    {
      return GetAppConfig().EnableDiagnostics__c;
    }
  }
  
  public static Boolean appEnabled
  { 
    get
    {
      return GetAppConfig().AppEnabled__c;
    }
  }
    
    public class MDExternalReferralClass
    {
        public String Name;
        public decimal Level;
		
        public MDExternalReferralClass(External_Referral_Request_Level__mdt source)
        {
            Name = source.DeveloperName;
            Level = source.level__c;
        }

        // Constructor that sets default values
        public MDExternalReferralClass(String MDName) {
            Name = MDName;
            Level = 3;
        }
        
        public MDExternalReferralClass() {}
    }
    
    @testvisible
    private static MDExternalReferralClass cachedConfig = null;
	
	public static MDExternalReferralClass getERConfig()
	{
		if(cachedConfig!=null) return cachedConfig;
		
        External_Referral_Request_Level__mdt setting = External_Referral_Request_Level__mdt.getInstance('Default');

		if(setting == null || Test.isRunningTest()) 
		{
            cachedConfig = new MDExternalReferralClass('Default');
            return cachedConfig;
		}
        cachedConfig = new MDExternalReferralClass(setting);
		return cachedConfig;    // If configuration data is large, don't cache it outside of test mode
	}
    public static Integer ER_LevelSetting
	{ 
		get
		{
			return Integer.valueOf(getERConfig().Level);
		}
	}

}
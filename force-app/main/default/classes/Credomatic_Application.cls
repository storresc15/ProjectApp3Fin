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
*********************************************************************************/
public without sharing class Credomatic_Application {
    
     public static final fflib_Application.UnitOfWorkFactory unitOfWork = new fflib_Application.UnitOfWorkFactory(
        new List<SObjectType> {
            Account.SObjectType,
            Contact.SObjectType,
            Opportunity.SObjectType,    
            InsurancePolicy.SObjectType    
        }
    );

    public static final fflib_Application.ServiceFactory service = new fflib_Application.ServiceFactory(
        new Map<Type, Type> {
            Credomatic_IAccountService.class => Credomatic_AccountServiceImp.class,
            Credomatic_IInsurancePolicyService.class => Credomatic_InsurancePolicyServiceImp.class
        }
    );

    public static final fflib_Application.SelectorFactory selector = new fflib_Application.SelectorFactory(
        new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_AccountsSelector.class,
            Contact.SObjectType => Credomatic_ContactsSelector.class,
            Opportunity.SObjectType => Credomatic_OpportunitiesSelector.class,
            Retail_Territory__c.SObjectType => Credomatic_RetailTerritoriesSelector.class    
        
        }
    );

    public static final fflib_Application.DomainFactory domain = new fflib_Application.DomainFactory(
        Credomatic_Application.selector,
        new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_Accounts.Constructor.class,
            InsurancePolicy.SObjectType => Credomatic_InsruancePolicy.Constructor.class,
            Contact.SObjectType => Credomatic_Contacts.Constructor.class,
            Opportunity.SObjectType => Credomatic_Opportunities.Constructor.class    
        }
    );

}
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

*********************************************************************************/
public without sharing class Credomatic_Application {
    
     public static final fflib_Application.UnitOfWorkFactory unitOfWork = new fflib_Application.UnitOfWorkFactory(
        new List<SObjectType> {
            Account.SObjectType,
            Contact.SObjectType,
            InsurancePolicy.SObjectType    
        }
    );

    public static final fflib_Application.ServiceFactory service = new fflib_Application.ServiceFactory(
        new Map<Type, Type> {
            Credomatic_AccountService.IService.class => Credomatic_AccountService.class,
            Credomatic_InsurancePolicyService.IService.class => Credomatic_InsurancePolicyService.class
        }
    );

    public static final fflib_Application.SelectorFactory selector = new fflib_Application.SelectorFactory(
        new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_AccountsSelector.class
        }
    );

    public static final fflib_Application.DomainFactory domain = new fflib_Application.DomainFactory(
        Credomatic_Application.selector,
        new Map<SObjectType, Type> {
            Account.SObjectType => Credomatic_Accounts.Constructor.class,
            InsurancePolicy.SObjectType => Credomatic_InsruancePolicy.Constructor.class    
        }
    );

}
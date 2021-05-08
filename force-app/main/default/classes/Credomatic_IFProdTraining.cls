/*********************************************************************************
Class Name      : Credomatic_IFProdTraining
Description     : As described in my Dreamforce 2014 presentation, Apex Interfaces are key to implementing mocking. 
				  You must define these in order to allow the mocking framework to substitute dynamically different implementations. 
				  The patterns library also provides base interfaces that reflect the base class methods for the Selector and Domain layers
Created By      : Sebastian Torres
Created Date    : 2021-04-05 
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-05               Initial version

*********************************************************************************/
public interface Credomatic_IFProdTraining {

    void createFinProdTrainingFromEvent(fflib_ISObjectUnitOfWork uow, Event e);
}
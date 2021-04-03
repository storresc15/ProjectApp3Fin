/*********************************************************************************
Class Name      : Credomatic_IContacts
Description     : As described in my Dreamforce 2014 presentation, Apex Interfaces are key to implementing mocking. 
				  You must define these in order to allow the mocking framework to substitute dynamically different implementations. 
				  The patterns library also provides base interfaces that reflect the base class methods for the Selector and Domain layers
Created By      : Sebastian Torres
Created Date    : 2021-03-12 
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-12              Initial version

*********************************************************************************/
public interface Credomatic_IContacts {
    
    void updateConOwner(fflib_ISObjectUnitOfWork uow, Id OwnerId);

}
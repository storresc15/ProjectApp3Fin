/*********************************************************************************
Class Name      : Credomatic_AccountServiceImp
Description     : Implementation of Account service methods
Created By      : Sebastian Torres
Created Date    : 2020-12-05
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-03-29              Initial version

*********************************************************************************/
public class Credomatic_AccountServiceImp implements Credomatic_IAccountService {
    
    /*
     *  Create Account 
     */
    public void createAccount(String name) {
        fflib_ISObjectUnitOfWork uow = Credomatic_Application.unitOfWork.newInstance();

        createAccount(uow, name);

        uow.commitWork(); 
    }

    /*
     * createAccount 
     */
    public void createAccount(fflib_ISObjectUnitOfWork uow, String name) {
        Credomatic_AccountsSelector selector = (Credomatic_AccountsSelector) Credomatic_AccountsSelector.newInstance();
        List<Account> accList = selector.selectByName(name);
        
        
        if (accList.isEmpty()) {
            Account newAcc = new Account(Name = name);
            
            uow.registerNew(newAcc); 
        }
    }
    
}
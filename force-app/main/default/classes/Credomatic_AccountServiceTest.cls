@isTest(isParallel=true)
public class Credomatic_AccountServiceTest {
    @IsTest
    private static void shouldCreateAccount()
    {
        // Create mocks
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks); // 建立工作单元的模拟
        Credomatic_AccountsSelector selectorMock = (Credomatic_AccountsSelector) mocks.Mock(Credomatic_AccountsSelector.class); // 建立选择逻辑层的模拟
     
        // Given
        String testAccountName = 'Test Existing Account';

        Credomatic_Application.unitOfWork.setMock(uowMock); // 使用 setMock 设置选择逻辑层的模拟
        Credomatic_Application.selector.setMock(selectorMock); // 使用 setMock 设置工作单元的模拟
     
        // When
        Credomatic_AccountService service = (Credomatic_AccountService) Credomatic_AccountService.newInstance();
        service.createAccount(testAccountName);
     
        // Then
        fflib_ArgumentCaptor argument = fflib_ArgumentCaptor.forClass(fflib_ISObjectUnitOfWork.class);
        ((fflib_ISObjectUnitOfWork) mocks.verify(uowMock, 1)).registerNew((Account) argument.capture()); // 验证 registerNew 函数被执行了一次，并且其中的参数是 Account 类型的

        ((fflib_ISObjectUnitOfWork) mocks.verify(uowMock, 1)).registerNew((Account) fflib_Match.anyObject()); // 另一种验证，registerNew 函数被执行了一次，并且其中的参数是任意 Account 类型的任何对象
    }

    @IsTest
    private static void shouldNotCreateAccount()
    {
        // Create mocks
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);
        Credomatic_AccountsSelector selectorMock = (Credomatic_AccountsSelector) mocks.Mock(Credomatic_AccountsSelector.class);
     
        // Given
        String testAccountName = 'Test Existing Account';

        /*
         * 下面这段代码使用 stub API 来模拟选择逻辑层的函数 selectByName 的执行结果：
         * 当其参数是变量 testAccountName 的值的时候，返回一个 Account 对象
         */
        mocks.startStubbing();
        List<Account> existingAccounts = new List<Account> { 
            new Account(
                Id = fflib_IDGenerator.generate(Account.SObjectType), // 建立随机的一个 ID 值
                Name = testAccountName) 
                };
        mocks.when(selectorMock.sObjectType()).thenReturn(Account.SObjectType);
        mocks.when(selectorMock.selectByName(testAccountName)).thenReturn(existingAccounts);
        mocks.stopStubbing();
        
        Credomatic_Application.unitOfWork.setMock(uowMock);
        Credomatic_Application.selector.setMock(selectorMock);
     
        // When
        Credomatic_AccountService service = (Credomatic_AccountService) Credomatic_AccountService.newInstance();
        service.createAccount(testAccountName);
     
        // Then
        fflib_ArgumentCaptor argument = fflib_ArgumentCaptor.forClass(fflib_ISObjectUnitOfWork.class);
        ((fflib_ISObjectUnitOfWork) mocks.verify(uowMock, 0)).registerNew((Account) argument.capture()); // 验证 registerNew 函数没有被执行
    }
}
/*********************************************************************************
Class Name      : Credomatic_PaymentRequest
Description     : This class works as a data carrier for the payment adapters
Created By      : Sebastian Torres
Created Date    : 2021-04-06
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-06              Initial version
*********************************************************************************/
public class Credomatic_PaymentRequest {
    
    public String orderName {get; set;}    
    public String BankAccountName {get; set;}
    public decimal Amount {get; set;}
    public String PaymentMethod {get; set;}
    public String AuthorizationCode {get; set;}
    
    public String FirstName {get; set;}
    public String LastName {get; set;}
    public String BillingState {get; set;}
    public String BillingCity {get; set;}
    public String BillingStreet {get; set;}
    public String BillingPostalCode {get; set;}
    
    //Credit Card Specific fields
    public String CreditCard_Number {get; set;}
    public String CreditCard_Expiration {get; set;}
    public String CreditCard_SecurityNumber {get; set;}

}
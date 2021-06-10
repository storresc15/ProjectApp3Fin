import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';


export default class CreateAccountLWC extends LightningElement {

    accountObject = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, DESCRIPTION_FIELD,PHONE_FIELD];

    handleAccountCreated(){
        // Run code when account is created.
    }
}
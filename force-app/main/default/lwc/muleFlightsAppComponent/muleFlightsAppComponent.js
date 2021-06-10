import { LightningElement, track, wire } from 'lwc';
import startRequestImperative from '@salesforce/apexContinuation/FSC_FlightsLightningController.fetchData';

export default class MuleFlightsAppComponent extends LightningElement {

    @track imperativeContinuation = {};

    callContinuation() {
        this.imperativeContinuation = '';
        startRequestImperative()
        .then(result => {
            this.imperativeContinuation = result;
        })
        .catch(error => {
            this.imperativeContinuation = error;
        }
        );
    }
    get formatedImperativeResult() {
        return JSON.stringify(this.imperativeContinuation);
    }
}
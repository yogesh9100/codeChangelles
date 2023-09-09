import { LightningElement, wire } from 'lwc';
//MessageChannel:Step 1: Import Messaging Channel 
import HOTEL_CHANNEL from "@salesforce/messageChannel/hotelData__c";
//MessageChannel:Step 2: Import references to indicate that this component is acting as a publisher
import {MessageContext, publish, subscribe} from 'lightning/messageService';
import WS_FIELD from '@salesforce/schema/Account.Website';
import BC_FIELD from '@salesforce/schema/Account.BillingCountry';
import NE_FIELD from '@salesforce/schema/Account.Name';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class HotelEditForm extends LightningElement {
    //Step 1: Instruct framework which object and which record to be show in edit mode
    recId; //= '0015i00000ok68gAAA';
    objectName = 'Account';
    //Step 2: Instruct framework fields to be made available for edit
    website = WS_FIELD;
    billingcountry = BC_FIELD ;
    hotelname = NE_FIELD;
    //MessageChannel:Step 3: Make a call to MessageContext method to indicate the framework that it is hotelEditForm component
    //acting as subscriber assign that to a variable or property
    @wire(MessageContext)
    messageContext;
    //MessageChannel:Step 4:Subscribe
    connectedCallback()
    {
        //Write your code here that you wish to run all the time when component is loaded
        subscribe(this.messageContext,HOTEL_CHANNEL,(message) => {this.processMessage(message)});
        console.log('I am inside connected call back');

    }
    //Use this method to unpack data being received from the publisher
    processMessage(message)
    {
        console.log('Message as received from publisher :: ' + message);
        console.log('Hotel Id from publisher :: ' + message.hotelId);
        console.log('Hotel Name from publisher :: ' + message.hotelName);
        //Assign recordId from the ID as received from publisher 
        this.recId = message.hotelId;
    }

    disconnectedCallback()
    {
        //Write your code here that you wish to run when you move away from the page that's using this component
        console.log('I am inside disconnected call back');

    }

    handleSuccess()
    {
        //Write success code after db save
        console.log('Data saved successfully');
        //Prep the data to show in success pop up
        const successMsg = {

            title:'Success',
            message:'Hotel Details have been successfully saved!!!!',
            variant:'Success',
            mode:'dismissible'
        };
        //Use show toast event to fire a success pop up message
        const eventToShowSuccessMsg = new ShowToastEvent(successMsg);
        this.dispatchEvent(eventToShowSuccessMsg);

    }

    handleError()
    {
        //Prep the data to show in success pop up
        const errorMsg = {

            title:'Error',
            message:'Something went wrong with data save !!!!',
            variant:'error',
            mode:'dismissible'
        };
        //Use show toast event to fire a success pop up message
        const eventToShowErrorMsg = new ShowToastEvent(errorMsg);
        this.dispatchEvent(eventToShowErrorMsg);
    }

    
}
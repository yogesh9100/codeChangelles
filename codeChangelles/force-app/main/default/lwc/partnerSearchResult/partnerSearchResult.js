import { LightningElement, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getPartners from '@salesforce/apex/AccountController.getPartners';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
//MessageChannel:Step 1: Import Messaging Channel 
import HOTEL_CHANNEL from "@salesforce/messageChannel/hotelData__c";
//MessageChannel:Step 2: Import references to indicate that this component is acting as a publisher
import { MessageContext, publish, subscribe } from 'lightning/messageService';
//uiRecordApi:Step 1: Import the relevant methods 
import { createRecord, updateRecord, deleteRecord } from 'lightning/uiRecordApi';
//uiRecordApi:Step 2: Import the object where we need to create or update or delete record
import CASE_OBJ from '@salesforce/schema/Case';
//uiRecordApi:Step 3: Import the object fields that should be used in create or update or delete record
import CASE_STATUS from '@salesforce/schema/Case.Status';
import CASE_ACCNAME from '@salesforce/schema/Case.AccountId';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';
import CASE_SUBJ from '@salesforce/schema/Case.Subject';
import CASE_DESC from '@salesforce/schema/Case.Description';

//Label is what user sees on the screen
//Name is a unique identifier of an action.Can be used or referred in code
const def_actions = [
    { label: 'Show Hotel Record', name: 'redirect_record_page' },
    { label: 'Show details', name: 'show_details' },
    { label: 'Edit', name: 'edit' },
    { label: 'Open Website', name: 'open_website' },
    { label: 'Setup Action Planning', name: 'action_planning' },
];


const def_columns = [

    { label: 'Name', fieldName: 'Name', type: 'text' },
    //{ label: 'Relationship Manager', fieldName: 'Hotel_Partner_Relationship_Manager__c', type: 'text' },
    //{ label: 'Site', fieldName: 'Website', type: 'text' },
    { label: 'Country', fieldName: 'BillingCountry', type: 'text' },
    { label: 'Category', fieldName: 'Partner_Hotel_Category__c', type: 'text' },
    { label: 'Rating', fieldName: 'Customer_Rating__c' },
    { label: 'Action', type: 'action', typeAttributes: { rowActions: def_actions, menuAlignment: 'auto' } }
];

export default class PartnerSearchResult extends NavigationMixin(LightningElement) {
    columns = def_columns; //Assign column variable to columns property
    dataToRefresh;
    //Property that holds location parameter value which comes from parent component left containner
    @api partnerLocation;
    @api parentComponentName;
    //Property to hold list of matching partner hotels or resorts returned from the DB
    partnerhotels;
    //MessageChannel:Step 3: Make a call to MessageContext method to indicate the framework that it is partnerSearchResult component
    //acting as publisher assign that to a variable or property
    @wire(MessageContext)
    messageContext;

    @wire(getPartners, { strlocation: '$partnerLocation' })
    readOutput(result) {
        if (result.data) {
            this.dataToRefresh = result;
            refreshApex(this.dataToRefresh);
            this.partnerhotels = result.data;
            console.log("this.partnerhotels :: " + this.partnerhotels);
        }
        else if (result.error) {
            console.log('Error fetching partner hotels / resorts data');
        }
    }

    getSelectedName() {

    }

    handleSelectedRowAction(event) {
        const actionName = event.detail.action;//Find the action from the row which was triggered by the user
        const rowSelected = event.detail.row;//Get details of entire row as received from DB
        switch (actionName.name) {
            case "show_details":
                //Write your code here

                break;
            case "edit":
                //Write your code here
                //MessageChannel:Step 4:Publish
                //Publish or Broadcast selected hotel Id and hotel Name to all the subscribers
                //Prepare the data in JS object format to be published
                const dataToPublish = {
                    hotelId: rowSelected.Id,
                    hotelName: rowSelected.Name
                };
                //Publish
                publish(this.messageContext, HOTEL_CHANNEL, dataToPublish);



                break;
            case "open_website":
                //Write your code here
                const websiteUrl = rowSelected.Website;
                //Prepare input for Navigation MixIn
                const inputToRedirect = {
                    type: 'standard__webPage',
                    attributes: {
                        url: websiteUrl
                    }
                };
                //Redirect the user to url
                this[NavigationMixin.Navigate](inputToRedirect);


                break;
            case "action_planning":
                //Write your code here
                //Create a new case record and associate with the hotel
                const szHotelId = rowSelected.Id;
                const szCaseSubject = 'Action Planning - Aug 2023';
                const szCaseDesc = 'New Case created to track the actions taken by the hotel to improve customer experience.Next review date is July 2023';
                const szCaseOrigin = 'Web';
                const szCaseStatus = 'New';

                //uiRecordApi:Step 4: Create fields list and assign values
                const fields = {};
                fields[CASE_STATUS.fieldApiName] = szCaseStatus;
                fields[CASE_ACCNAME.fieldApiName] = szHotelId;
                fields[CASE_ORIGIN.fieldApiName] = szCaseOrigin;
                fields[CASE_SUBJ.fieldApiName] = szCaseSubject;
                fields[CASE_DESC.fieldApiName] = szCaseDesc;

                //uiRecordApi:Step 5: Combine fields and object data together as record input and pass it to uiRecordAPI method
                const recordInput = {
                    apiName: CASE_OBJ.objectApiName,
                    fields
                };
                //uiRecordApi:Step 6:Call create method from uiRecordAPI
                createRecord(recordInput)
                    .then(() => {
                        //Show success message
                        //Prep the data to show in success pop up
                        const successMsg = {

                            title: 'Success',
                            message: 'A new case to track new hotel actions to increase customer satisfaction has been created !!!!..Click here to view the case !!!!',
                            variant: 'Success'

                        };
                        //Use show toast event to fire a success pop up message
                        const eventToShowSuccessMsg = new ShowToastEvent(successMsg);
                        this.dispatchEvent(eventToShowSuccessMsg);



                    })
                    .error(() => {
                        //Show error message

                        //Prep the data to show in success pop up
                        const errorMsg = {

                            title: 'Error',
                            message: 'Something went wrong.. System admins have been notified.. Please reach out to support team!!!!',
                            variant: 'error'

                        };
                        //Use show toast event to fire a success pop up message
                        const eventToShowErrorMsg = new ShowToastEvent(errorMsg);
                        this.dispatchEvent(eventToShowErrorMsg);
                    }

                    );
                break;
            case "redirect_record_page":
                //Write your code here
                const hotelrecId = rowSelected.Id;
                //Prepare input for Navigation MixIn
                const recordPageToRedirect = {
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: hotelrecId,
                        objectApiName: 'Account',
                        actionName: 'view'
                    }
                };
                //Redirect the user to url
                this[NavigationMixin.Navigate](recordPageToRedirect);


                break;

            default:
                break;
        }
    }

}
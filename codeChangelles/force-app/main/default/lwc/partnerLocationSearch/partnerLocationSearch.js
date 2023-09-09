import { LightningElement, wire } from 'lwc';
import getHotelLocation from '@salesforce/apex/AccountController.getHotelLocation';
import {refreshApex} from '@salesforce/apex';
export default class PartnerLocationSearch extends LightningElement {
    szdesc = 'Hotel Analysis App will assist partner operations team to review all hotels and customer reviews. Based on customer rating, it enables partner operations team to isolate non-performing hotels and plan to improve customer satisfaction';
    //Property to hold selected location
    selectedLocation;

    //Cache Burst
    dataReceivedFromDB;
    dataToRefresh;
    
    //Property to hold partner locations
    partnerlocations;
    //Call apex method using wire decorator
    @wire(getHotelLocation)
    //readLocationData({data, error}) or readLocationData({result.data, result.error})
    readLocationData(result)//Result is a system class which is having data & error properties
    {
        if(result.data)
        {
            this.dataReceivedFromDB = result.data;
            this.dataToRefresh = result;//Copy of entire object containing data and error
            refreshApex( this.dataToRefresh);//Keep checking or sends DB a signal to LWC framework if there is a change in the underlying data
            console.log('Partner Location Data :: ' + result.data);
            //have a object added to partner locations array
            this.partnerlocations = [ {label: '--Select Partner Location--', value: '' }];

            //Loop through the data and add locations into partner locations
            result.data.forEach(element => {
                const location = {};
                location.label = element;
                location.value = element;
                this.partnerlocations.push(location);
            });
            console.log('this.partnerlocations :: ' + this.partnerlocations);
        }
        else if(result.error)
        {
            console.log('Error Fetching Partner Location Data');
        }
    }
    
    
    value = 'inProgress';

    handleChange(event) {
        this.value = event.detail.value;
    }

    handleLocationChange(event)
   {
     this.selectedLocation = event.detail.value;
     //Create a custom event using system class CustomEvent
     //Add the selected location as an attribute
     //Fire the event so that parent component leftContainner can use the event and read the value(selected location)
     //Syntax: const evt = new CustomEvent('Name of the event', 'Values to be passed to the parent in JSON object format')
     const evt = new CustomEvent('userselectedlocation', {detail: this.selectedLocation});
     this.dispatchEvent(evt);
   }
}
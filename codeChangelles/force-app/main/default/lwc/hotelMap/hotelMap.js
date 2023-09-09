import { LightningElement, api, wire } from 'lwc';
//Refer Apex method in LWC using salesforce apex JS package
import getHotelInfo from '@salesforce/apex/AccountController.getHotelInfo';
//import getHotelPrimaryContact from '@salesforce/apex/AccountController.getHotelPrimaryContact';

export default class HotelMap extends LightningElement {
     //Private properties
     latValue; //= 13.0827;
     longValue; //= 80.2707;
     hotelName = 'Hotel Did Not Exist!!!!';
     mapMarkers;//Variable to hold map markers
     locationLatLong;



    //Step 1: Access current record's Salesforce Id
    //Step 2: Using the Id, query the DB and get lat and long values
    //Step 3: Replace hardcoded latValue and longValue variables
    
    //Step 1:
    //Public property i.e: It will get data from outside
    //In order to get current record Id being passed from page to the LWC, always use variable recordId
    @api recordId;

    //Step 2:
    //@wire('methodname','pass inputparameters if any in JS object format')
    //propertyorfunction to read data coming from DB

    //Create an Apex class and a method and make a call to the method to read lat and long values from DB
    @wire(getHotelInfo,{szHotelId:'$recordId'})
    readOutput({data, error})
    {
        //Data is a system property that holds data coming in from DB
        //Error is a system proprty that holds error if there are any

        //Check if there is data from DB
        if(data)
        {
            //Process the data
            console.log('Data from DB : ' +data);
            console.log('Data from DB in string format: ' + JSON.stringify(data));

            //Reading hotel lat & long coordinates and store them in variables that in turn in sends value to lightning map component
            this.latValue = data.Hotel_Latitude__c;
            this.longValue = data.Hotel_Longitude__c;
            this.hotelName = data.Name;
            
            //A property that holds location coordinates
            this.locationLatLong = [

                {
                    location: {
                        Latitude: this.latValue,
                        Longitude: this.longValue,
                    },
                    title: this.hotelName,
                    description: this.hotelName,
                },
            ];

            //Destructuring object
            this.mapMarkers = [...this.locationLatLong];

            

        }
        else if(error)
        {
            console.log('Something went wrong!!!!');        
        }
    }

   
}
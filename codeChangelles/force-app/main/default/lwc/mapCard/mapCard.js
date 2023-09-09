import { LightningElement } from 'lwc';

export default class MapCard extends LightningElement {

    //Define JS Array
    mapMarkers = [

        {
            location: {
                Street: '1 Market St',
                City: 'San Francisco',
                Country: 'USA',
            },
            title: 'The Landmark Building',
            description:
                'Historic <b>11-story</b> building completed in <i>1916</i>',
        },

        {
            location: {
                Street: '2 Market St',
                City: 'Troy',
                Country: 'USA',
            },
            title: 'Not sure if it exist',
            description:
                'Something we just cooked up !!!!</i>',
        },



    ];

    latValue = '13.0827';
    longValue = '80.2707';

    //A property that holds location coordinates
    locationLatLong = [

        {
            location: {
                Latitude: this.latValue,
                Longitude: this.longValue,
            },
            title: 'Hotel Bliss',
            description:
                'A new paradise on earth!!!!</i>',
        },
    ];
}
import { LightningElement } from 'lwc';

export default class LeftContainner extends LightningElement {

    //Create variables or properties to hold the values
    sztitle = 'Hotel Review & Action Planning';
    
   //Property to hold location data and shared with child component partnerSearchResult
   strPartnerLocation = ''; 
   strCompName = 'leftContainner';

   handleuserselectedlocation(event)
   {
     //Read the value sent by the child component(partnerLocationSearch)
     //and assign the value to strPartnerLocation
     this.strPartnerLocation = event.detail;

   }
   


}
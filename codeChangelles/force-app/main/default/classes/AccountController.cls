public with sharing class AccountController {
    //Add @AuraEnabled annotation so that this method can be used in LWC
    @AuraEnabled(cacheable=true)
    public static Account getHotelInfo(String szHotelId)
    {
        return [SELECT Id, Name, Hotel_Latitude__c, Hotel_Longitude__c FROM Account WHERE Id =: szHotelId];


    }
    @AuraEnabled
    public static Contact getHotelPrimaryContact(String szHotelId)
    {
        return [SELECT Id, Name FROM Contact WHERE AccountId =: szHotelId LIMIT 1];

    }
    @AuraEnabled(cacheable=true)
    public static List<String> getHotelLocation()
    {
        //Get the list of partner hotels and resorts
        List<Account> accsList = [SELECT Id, Name, BillingCountry FROM Account WHERE Is_Partner_Hotel__c = true and BillingCountry != ''];
        
        //Convert list of accounts to list of string
        //Loop the list and extract BillingCountry and add it to a string
        Set<String> locationlist = new Set<String>();
        for(Account accRecord : accsList)
        {
            locationlist.add(accRecord.BillingCountry);

        }
        
        System.debug('locationlist :: ' + locationlist);
        //As LWC cannot process set collection it needs to be converted into a list
        List<String> partnerLocations = new List<String>(locationlist);
        //Sort items inside the collection
        partnerLocations.sort();
        System.debug('partnerLocations :: ' + partnerLocations);
        return partnerLocations;


    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getPartners(String strlocation){
        if(String.isEmpty(strlocation)){
            return [SELECT Id, Name, Hotel_Partner_Relationship_Manager__c, website, BillingCountry, 
            Partner_Hotel_Category__c,Partner_Payment_Date__c, Customer_Rating__c
            FROM Account WHERE Is_Partner_Hotel__c = true];
        }else {
            return [SELECT Id, Name, Hotel_Partner_Relationship_Manager__c, website, BillingCountry, 
            Partner_Hotel_Category__c,Partner_Payment_Date__c, Customer_Rating__c
            FROM Account WHERE Is_Partner_Hotel__c = true and BillingCountry =: strlocation];
        }

    }
}
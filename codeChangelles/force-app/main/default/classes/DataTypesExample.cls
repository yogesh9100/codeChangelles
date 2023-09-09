public class DataTypesExample {
    
    
    public static void LearnVariables()
    {
    	// primitive data types
        Integer iValue = 10;
        Double dValue = 3.12;
        String strPlanent = 'Earth';
        Boolean isActive = true;
        
        System.debug('Value of iValue integer :: ' + iValue);
        System.debug('Value of dValue double :: ' + dValue);
        System.debug('Value of strPlanent string :: ' + strPlanent);
        System.debug('Value of isActive bool :: ' + isActive);
        
        
        // sObject data type
//        Hotel_Review__c hrRec = [SELECT Id, Customer_Review__c, Account__c , Account__r.Name, Account__r.BillingCountry FROM Hotel_Review__c LIMIT 1];
        //System.debug('Latest hotel Review :: ' + hrRec);
        
    }//
    
    public static void ifElseExample(Integer iNumber)
    {
        if(iNumber > 0)
        {
            System.debug('Number ' + iNumber + ' is positive!!');
        }
        else if(iNumber < 0)
        {
            System.debug('Number ' + iNumber + ' is negative!!');
        }
        else
        {
            System.debug('Number ' + iNumber + ' is zero!!');
        }
    }
    
    public static void loopExample()
    {
        // run a loop for 10 times and show the numbers on the log
        for(Integer i=1 ; i<10; i++)
        {
            System.debug('Value is '  + i);
        }
        
    }
    
    public static void getHotelPartners()
    {
        List<Account> acclist = [SELECT Id, Name, BillingCountry FROM Account WHERE Is_Partner_Hotel__c = true]; // returns more than 1 records
        System.debug('List of all partner hotels ' + acclist);
        
        Integer counter = 1;
        // Solve this using collections in Salesforce apex
        // 
        // Use for loop to access one account at a time from the collection
        for(Account accRecord : acclist)
        {
            
            //System.debug(' Hotel Partner #' + counter + ':: ' + accRecord); //sequential number
            System.debug(' Hotel Partner Id#' + accRecord.Id + ':: ' + accRecord); // use . notation to access field values 
            counter = counter + 1;

        }
    }
    
    public static void CollectionListExample()
    {
        // List, Map & Set
        
        List<String> lstfruit = new List<String>(); 
        lstfruit.add('Mango');
        lstfruit.add('Banana');
       	lstfruit.add('Jackfruit');
        	lstfruit.add('Jackfruit');
         
            
        System.debug('Fruits::' + lstfruit);
        
        // Use for loop to access one fruit at a time from the collection
        for(String objFruit : lstfruit)
        {
            System.debug('Fruit from the collection ::' + objFruit);

        }
        
    }
    
    public static void CollectionSetExample()
    {
        Set<String> CustomeremailAddress = new Set<String>();
        
        CustomeremailAddress.add('abc@gmail.com');
        CustomeremailAddress.add('123@gmail.com');
        CustomeremailAddress.add('alpha@gmail.com');
        CustomeremailAddress.add('beta@gmail.com');
        CustomeremailAddress.add('John@gmail.com');
                CustomeremailAddress.add('John@gmail.com');
                CustomeremailAddress.add('John@gmail.com');
        
        System.debug('Set Example output - Email address list::' +  CustomeremailAddress);
        
        
        
        
    }
    
    public static void CollectionMapExample()        
    {
        // To store name and age of users
        Map<String, Integer> ageData = new Map<String, Integer>();
        ageData.put('John', 25);
        ageData.put('Daniel', 30);
        ageData.put('Sharma', 35);
        ageData.put('Ariti', 25);
        ageData.put('Sai', 22);
        
        System.debug('Age of Sharma is ' + ageData.get('Sharma'));
        
    }
    
    public static void getHotelNameByLocation()
    {
        // To store name and age of users
        Map<String, String> hotelByLocation = new Map<String, String>();
        hotelByLocation.put('India', 'Hotel Royal Palace');
        hotelByLocation.put('USA', 'HomeStay Resorts');
        hotelByLocation.put('Australia', 'Hotel Grand Resorts');
        
               
        System.debug('Hotel located in India ' + hotelByLocation.get('India'));

        
        // To store more than one hotel in a particular location use Map and List together
        Map<String, List<String>> hotelsByLocation = new  Map<String, List<String>>();
        
        // Step 1: create a list of hotels 
        List<String> indiaBasedHotels = new List<String>();        
        indiaBasedHotels.add('Hotel Royal Palace');
        indiaBasedHotels.add('Radisson Blu');
        indiaBasedHotels.add('Marriot');
        
        List<String> usaBasedHotels = new List<String>();        
        usaBasedHotels.add('HomeStay Resorts');
        usaBasedHotels.add('Le Royal ');
     
        // Step 2: Add hotels and label it with the key (location)
        hotelsByLocation.put('India', indiaBasedHotels);
        hotelsByLocation.put('USA', usaBasedHotels);
        
        // access all hotels from the lcoation India
        System.debug('Htoels based out of India ::' + hotelsByLocation.get('India'));
           System.debug('Hoatels  based out of USA ::' + hotelsByLocation.get('USA'));
        
    }

}
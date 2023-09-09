@isTest
public class PriceCalculatorTest {
    @isTest
    static void testCalculateTotalPrice() {
        // Test case 1: Calculate total price for products with positive values
        List<Product2> products1 = new List<Product2>();
        products1.add(new Product2(Name = 'Product A', Price__c = 10, Quantity__c = 5));
        products1.add(new Product2(Name = 'Product B', Price__c = 15, Quantity__c = 2));
        Decimal expectedResult1 = 10 * 5 + 15 * 2;
        Decimal actualResult1 = PriceCalculator.calculateTotalPrice(products1);
        System.assertEquals(expectedResult1, actualResult1, 'Test case 1 failed');

        //Test case 2: Calculate total price for products with zero quantity
        List<Product2> products2 = new List<Product2>();
        products2.add(new Product2(Name = 'Product C', Price__c = 20, Quantity__c = 0));
        products2.add(new Product2(Name = 'Product D', Price__c = 25, Quantity__c = 0));
        Decimal expectedResult2 = 0;
        Decimal actualResult2 = PriceCalculator.calculateTotalPrice(products2);
        System.assertEquals(expectedResult2, actualResult2, 'Test case 2 failed');

        // Test case 3: Calculate total price for products with negative values
        List<Product2> products3 = new List<Product2>();
        products3.add(new Product2(Name = 'Product E', Price__c = -10, Quantity__c = 3));
        products3.add(new Product2(Name = 'Product F', Price__c = 5, Quantity__c = -2));
        Decimal expectedResult3 = -10 * 3 + 5 * -2;
        Decimal actualResult3 = PriceCalculator.calculateTotalPrice(products3);
        System.assertEquals(expectedResult3, actualResult3, 'Test case 3 failed');
    }
}
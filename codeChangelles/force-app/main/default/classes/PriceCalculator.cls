public class PriceCalculator {
   
    // Pre-setup: 
    // Create 2 custom fields on Product2 std. object
    // Price__c & Quantity__c

    // TODO: Write a test class to ensure calculateTotalPrice code is 100% covered

    // Method to calculate the total price of products
    public static Decimal calculateTotalPrice(List<Product2> products) {
        Decimal totalPrice = 0;
        for (Product2 product : products) {
            totalPrice += product.Price__c * product.Quantity__c;
        }
        return totalPrice;
    }
}
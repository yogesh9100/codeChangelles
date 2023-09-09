public class PaymentDueDateReminder implements Schedulable {
    public void execute(SchedulableContext sc) {
        // Call the batch process from PaymentDueDateUtil class
        PaymentDueDateUtil batchable = new PaymentDueDateUtil();
        Database.executeBatch(batchable, 5); // Adjust batch size as needed
    }
}

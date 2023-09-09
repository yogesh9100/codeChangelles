public class PaymentDueDateUtil  implements  Database.Batchable<SObject>{

    @future

    public static void sendEmailToPaymentCollectionTeam(Set<Id> accIds) {

        // Get the email recipients from a Custom Label instead of custom metadata type

        String emailRecipients = Label.India_Team_Email_Members;

        // Check if there are any valid email recipients

        if (String.isNotBlank(emailRecipients)) {

            // Create a map to store the accounts that have payment due today

            Map<Id, Account> accountsWithDueToday = new Map<Id, Account>();

            // Query for accounts with Payment Due Date equals to today

 

            List<Account> accountsDueToday = [

                SELECT Id, Name, AccountNumber, Payment_Due_Date__c

                FROM Account

               WHERE Id IN :accIds AND Payment_Due_Date__c = :Date.today()

            ];

            // Add accounts to the map

            for (Account acc : accountsDueToday) {

                accountsWithDueToday.put(acc.Id, acc);

            }

            // Check if there are any accounts with payment due today

            if (!accountsWithDueToday.isEmpty()) {

                // Send bulk email to the recipients

                sendBulkEmail(emailRecipients, accountsWithDueToday);

            }

        }

    }

    // Method to send bulk emails to the recipients

    private static void sendBulkEmail(String emailRecipients, Map<Id, Account> accounts) {

 

 

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

        List<String> recipientEmails = emailRecipients.split(';');

        message.setToAddresses(recipientEmails);

        message.setSubject('Payment Due Date Notification');

        // Prepare the email body with the account details

        String emailBody = 'The following accounts have their payment due today:\n';

        for (Account acc : accounts.values()) {

            emailBody += 'Account Name: ' + acc.Name + ', Account Number: ' + acc.AccountNumber + '\n';

        }

        message.setPlainTextBody(emailBody);

        // Send the email

        Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});

    }

 

    //Batch Class Starts

    public Database.QueryLocator start(Database.BatchableContext context) {

        // Query for Accounts where the Payment_Due_Date__c field is set to today's date

        return Database.getQueryLocator([

            SELECT Id, Name, AccountNumber, Payment_Due_Date__c

            FROM Account

            WHERE Payment_Due_Date__c = TODAY

        ]);

    }

 

    // The execute method is called for each batch of records returned from the start method.

    public void execute(Database.BatchableContext context, List<Account> scope) {

        // Process the batch of Accounts by sending email notifications to the India Team

        sendBulkEmail(Label.India_Team_Email_Members, scope);

    }

 

    // The finish method is called after all batches have been processed.

    public void finish(Database.BatchableContext context) {

        // Implement any post-processing logic if needed after all batches have been processed

        // For example, you could perform cleanup tasks or log the batch job's completion.

    }

 

    // Method to send bulk emails to the recipients

    private void sendBulkEmail(String emailRecipients, List<Account> accounts) {

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

        List<String> recipientEmails = emailRecipients.split(';');

        message.setToAddresses(recipientEmails);

        message.setSubject('Payment Due Date Notification');

 

        // Prepare the email body with the account details

        String emailBody = 'The following accounts have their payment due today:\n';

        for (Account acc : accounts) {

            emailBody += 'Account Name: ' + acc.Name + ', Account Number: ' + acc.AccountNumber + '\n';

        }

        message.setPlainTextBody(emailBody);

 

        // Send the email

        Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});

    }

 

}
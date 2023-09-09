trigger AccountTriggers on Account (before insert,before update,after insert, after update) {
    
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert))
    {
        // Find the list of accounts (Trigger.new) being updated or inserted and check if payment date is due for tomorrow
          
        System.debug('Inside After update condition');

        List<Account> accsToBeProcessed = new List<Account>();
        Set<Id> accIdsToBeProcessed = new Set<Id>();

        for(Account acc: Trigger.New)
        {
            System.debug('acc.Payment_Due_Date__c :: ' + acc.Payment_Due_Date__c);

            // check if payment date is due for tomorrow , if yes then isolate the account record and keep it in the list.
            // Else, do nothing
            if(acc.Payment_Due_Date__c !=  null && acc.Payment_Due_Date__c == System.today().addDays(1))
            {
                // add acc to the list of accounts to be processed >> Cant do this cos future method does nto accept List of sobject 
                //accsToBeProcessed.add(acc);


                accIdsToBeProcessed.add(acc.Id);
            } 

        }

        System.debug('accIdsToBeProcessed::' + accIdsToBeProcessed);
        // check if the list is not empty , if yes, call helper util class to send email . Else, do nothing
        if(accIdsToBeProcessed !=null && accIdsToBeProcessed.size() >0)
        {
            System.debug('Before future call');
            PaymentDueDateUtil.sendEmailToPaymentCollectionTeam(accIdsToBeProcessed);// call furture method and pass account ids
            System.debug('after future call');
        
        }
    }

    System.debug('End of trigger !!');



}